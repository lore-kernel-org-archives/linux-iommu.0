From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
Date: Thu, 30 Oct 2014 15:56:56 +0100
Message-ID: <20141030145654.GD20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com>
 <5452107D.8080207@nvidia.com>
 <54521181.8080005@nvidia.com>
 <54521B22.6070708@nvidia.com>
 <54523E8B.7000900@nvidia.com>
 <5452418F.8080005@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5452418F.8080005-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 03:47:59PM +0200, Terje Bergstr=C3=B6m wrote:
> On 30.10.2014 15:35, Alexandre Courbot wrote:
> > Great, thanks for confirming!
> >=20
> > Thierry, how do you want to address this? We could change the register
> > for the GPU group, or (maybe preferable if we want to reflect the actual
> > hardware state) add the GPUB group. I don't know if that would be easy
> > though since we would have the problem of the gpusrd and gpuswr clients
> > ownership (seems like they would belong to both groups?)
>=20
> gpusrd and gpuswr are client IDs for GPU reads and writes on MC. GPU and
> GPUB are SW group IDs for SMMU. There's no 1:1 or hierarchical mapping.

Since the GPU client ID is effectively useless for purposes of IOMMU
translation I'd lean towards just keeping the existing TEGRA_SWGROUP_GPU
and update the register to point to MC_SMMU_GPUB_ASID_0.

Thierry

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUlG2AAoJEN0jrNd/PrOhHzIQAK3CtE57qL3bg8RSuVMwPBOr
6CVUw8S8uN2pYfg2jqV23BBvgD4Pk1i07yj5CD/QuLuB+g1OMDMghNYO2G3IM1R+
Rn1aR3Kw8BI22HLI7p+EF7k+D4TvcTu01fCz3J9LcjiREL0jf7vFPAdhlIPQGgFW
4qNMCSerdEAacl8T1OavgB9HI1rnSIAkqJ5C18cZdt3B6o18bbDIwmmVDofTR77o
qKqKrhk5OmDXpIq9Bkbgj4CippedJJtTGcuOPyHlzhg4T3y4Sal6vhegy34JsSNJ
l+PFVg9bbWZQPk1uNwPq3me73zt033z4/5g1LSJbdV+7yjAT/X8fRAjrNQ2RIR/k
gGkaK/h0vfD85eJLQG+Jui1xFmb7bbRe0Fh+KpWF4UMyB8dLb4i/ZnoskrTW2y59
MwCUxwZEGHK7WTsWWdzbJbYPMb1VOoZvNkSjG4eTTQyhM3MQCqQUPSbuvdfQ31qZ
p4aMhCjdtUBOoKww3506T9Q75Se+DPqUANb7zGfJKnxpohM4QQYDuGjZPivl0Nq9
b4NrVNUYcTrjjxkxBYRtK4L6XJNTSHok5s7CWEuiiDXJsSmognel1MrLDKRPkini
hZEVSou6f4UZ9+mFXt1JXkTEPMilGOkdU5xbln47UEYsOVCzmhgz0k8dePm1ILew
i02fQuhGSYCXD8nuzVXv
=KrkV
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
