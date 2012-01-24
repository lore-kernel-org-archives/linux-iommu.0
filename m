From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 15:46:01 +0200
Message-ID: <20120124134601.GT27414@legolas.emea.dhcp.ti.com>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com>
 <1325747509-29665-3-git-send-email-hdoyu@nvidia.com>
 <20120123154310.GC6269@8bytes.org>
 <20120124.154121.1062920821192552748.hdoyu@nvidia.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lKkRBIzN5W0l28vM"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120124.154121.1062920821192552748.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--lKkRBIzN5W0l28vM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 24, 2012 at 02:41:21PM +0100, Hiroshi Doyu wrote:
> From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driv=
er
> Date: Mon, 23 Jan 2012 16:43:10 +0100
> Message-ID: <20120123154310.GC6269-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>=20
> > > +	}
> > > +
> > > +	spin_unlock_irqrestore(&as->lock, flags);
> > > +
> > > +	domain->priv =3D NULL;
> > > +	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
> > > +}
> > > +
> > > +static int smmu_iommu_attach_dev(struct iommu_domain *domain,
> > > +				 struct device *dev)
> > > +{
> > > +	struct smmu_as *as =3D domain->priv;
> > > +	struct smmu_device *smmu =3D as->smmu;
> >=20
> > Hmm, this looks like there is a 1-1 mapping between hardware SMMU
> > devices and domains. This is not consistent with IOMMU-API semantics
> > where a domain can contain devices behind different SMMUs. Please fix
> > that.
>=20
> Actually I really like the concept of this "domain" now, which hides
> the H/W hierarchy from users.
>=20
> But in Tegra SMMU/GART case, there's a single one IOMMU device in the
> system. Keeping a iommu device list in a domain and iterating iommu
> device list in each iommu_ops seem to be so nice, but I'm afraid that
> this may be a bit too much when one already knows that there's only
> one IOMMU device in the system.
>
> If there's no actual problem for 1-1 mapping between IOMMU H/Ws and
> domains, I think that it may not so bad to keep the original code(1-1)
> for GART and SMMU. What do you think?

I think it boils down to "extensability". If you can truly/fully
guarantee that there will *always* be a single IOMMU on all upcoming
Tegras, then it's really overkill.

But if there's even a remote possibility of the HW being changed and you
end up with more IOMMUs, things start to feel necessary for the sake of
making it easy to extend.

my 2 cents, feel free to ignore ;-)

--=20
balbi

--lKkRBIzN5W0l28vM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHrYZAAoJEIaOsuA1yqREhSUP/RTAexluxgG9Fmnr1KTXfg/T
DGISQ2GUz5MEzYahC51382CGIDq3DtDs2U6Zfps9BhO7hiCi46UVgObjwOeprxgp
qKp3+FDlxhmiZLB63FEHSHLq8FbV2FwQoeOPiLtw8EFycqhGk6sdRigxCVfBb9yP
U5yCuxWgF6B0iDn3czWJrDQWYilySaxEb4ruYd6IeK4tSs6pF5jWaX2Ew46y6uTU
U1FWlsRQ847fEZPoMEBE4xp1SED0UQRItcWOLMj6UmIo/f3NYwt4DEoOCEFzn4m/
2nfi9q1QhzodOU0xnEcJDUJ5cEzKrNLTq9ueoQGfzsySr/h/wig/R3H/FRkTne/E
OlZp7o4Y7z+lQosTCcIYrSYrPNqlJdTz61r7HtKZqmbVOO+BvAwKA1jA3pkzekJe
GXnqmCmUxTJJlx3/+VQLlEEeFv5EpPyVPhUHcaxfqVSzKZnjGBMbGKZoV8cqfLr6
UsNZyA63nPMu2SVPT+xNqkskrHfmCJDo9uNByMK60k91h/9Ccf8NYNNlzOjsDWkX
DjhqU0bfYvXJFTb3SN65eLfUR1k+Aj9bERsxU9Q2SdfJpRtgf7lD6cpXBQiElBQl
grsDD5In9yMdRYSBVln2CoWpnrMfKPcqq1BOFOEcdxVXeUPJbzi5JGlLTlsJzXQd
VABFBYynG45Jmwqglu+v
=WHg1
-----END PGP SIGNATURE-----

--lKkRBIzN5W0l28vM--
