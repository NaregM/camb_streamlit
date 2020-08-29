import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

import camb
from camb import model, initialpower

import seaborn as sns

import streamlit as st

sns.set_style('darkgrid')


from PIL import Image
import requests
from io import BytesIO

response = requests.get("https://streamlit-data.s3-us-west-1.amazonaws.com/cmb-1.jpg")
img = Image.open(BytesIO(response.content))


#image = Image.open('/home/nareg/Downloads/cmb-1.jpg')
st.image(img, use_column_width = True)


# ====================================================================================================================

def C_ell(h = 0.73, ombh2 = 0.022, omch2 = 0.143, ns = 0.96, As = 2.19e-9, tau = 0.066, lmax = 3000):

    """
    CMB power spectra

    """

    pars = camb.CAMBparams()
    pars.set_cosmology(H0 = 100 * h, ombh2 = ombh2, omch2 = omch2, TCMB = 2.7255, tau = tau)

    #As = np.exp(ln10A)*1e-10

    pars.InitPower.set_params(ns = ns, r = 0, As = As)

    pars.set_dark_energy()
    pars.set_for_lmax(lmax = lmax)
    results = camb.get_results(pars)
    powers = results.get_cmb_power_spectra(pars, raw_cl = False, CMB_unit = 'muK')
    Cl = powers['total']
    cl_TT = Cl[:, 0]

    return cl_TT[30:,]  # leave out first 30 values

def power(h = 0.73, ombh2 = 0.022, omch2 = 0.143, ns = 0.96, As = 2.19e-9, tau = 0.066, nonLin = False, kmin = 5e-5, kmax = 5, z = 0.0):

    """
    """
    pars = camb.CAMBparams()
    pars.set_cosmology(H0=100*h, ombh2=ombh2, omch2=omch2, tau = tau)
    pars.set_dark_energy(w = -1)
    pars.InitPower.set_params(ns=ns, As = As)
    PK = camb.get_matter_power_interpolator(pars, nonlinear=nonLin, hubble_units=False, k_hunit=False, kmax=10)

    K = np.linspace(kmin, kmax, 2500)
    PS = PK.P(z, K)
    return K, PS


df2 = pd.DataFrame({
                   'CMB power spectrum': [True, False],
                   'Matter power spectrum': [True, False]
                   })

cmb_ps = st.sidebar.selectbox(
    'CMB power spectrum: ',
    df2['CMB power spectrum'])

matter_ps = st.sidebar.selectbox(
    'Matter power spectrum: ',
    df2['Matter power spectrum'])


h = st.sidebar.slider('h', 0.5, 0.9, step = 0.1)
ombh2 = st.sidebar.slider(u'\u2126 b h^2', 0.01, 0.1, step = 0.001)
ns = st.sidebar.slider(u'ns', 0.9, 1.5, step = 0.01)
omch2 = st.sidebar.slider(u'\u2126 c h^2', 0.05, 0.6, step = 0.001)
tau = st.sidebar.slider('\u03C4', 0.02, 0.2, step = 0.01)
As = st.sidebar.slider(u'As', 1.0e-9, 5.5e-9, step = 0.01 * 1e-9)

p_fid = dict(h = h, ns = ns, ombh2 = ombh2, omch2 = omch2, As = As, tau = tau)

st.markdown("## Tune cosmological parameters from left sidebar or select Planck best values from behiend:")

if st.checkbox('Use Planck 2015'):

    p_fid = dict(ns = 0.96, ombh2 = 0.022, omch2 = 0.143, As = 2.19e-9, tau = tau)


color = st.beta_color_picker('Color Selection', "#116377")

if cmb_ps:

    st.markdown("## CMB Spectrum")
    st.markdown("Choose maximum $\ell$: ")

    ell = st.slider(u'', 1000, 4999, step = 200)

    r"$\ell$ = ", ell

    Cl_TT = C_ell(**p_fid, lmax = ell)
    ls = np.arange(Cl_TT.size)

    plt.plot(ls, Cl_TT, color = color, lw = 1.75, label = "TT")
    plt.xlabel(r"$\ell$", size = 17)
    plt.legend()
    st.pyplot()

st.markdown("-------------------------------------------------------------------------------")

if matter_ps:

    st.markdown("## Matter Power Spectrum")
    st.markdown("Adjust minimum and maximum $k$ and redshift: ")

    kmin = st.slider(u'', 1e-5, 1e-3, step = 1e-6)
    "$k_{min}$ = ", kmin

    kmax = st.slider(u'', 1e-2, 5.5, step = 0.5)
    "$k_{max}$ = ", kmax

    z_ = st.slider(u'', 0.0, 3.0, step = 0.1)
    "Redshift:  = ", z_

    ks, ps = power(**p_fid, kmin = kmin, kmax = kmax, z = z_)

    plt.loglog(ks, ps, color = color, lw = 1.75, label = "Matter Power Spectrum")
    plt.xlabel(r"$\mathrm{k} \ [Mpc]$", size = 14)
    plt.ylabel(r"$\mathrm{Power Spectrum} \ [add unit]$", size = 14)
    plt.legend()
    st.pyplot()
