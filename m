From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 1 Nov 2013 10:52:24 +0100
Message-ID: <20131101095223.GH27864@ulmo.nvidia.com>
References: <52718122.9000206@wwwdotorg.org>
	<20131031.101232.80781047726461143.hdoyu@nvidia.com>
	<527286CC.9080404@wwwdotorg.org>
	<20131031.184603.979300613649357798.hdoyu@nvidia.com>
	<52729912.9050800@wwwdotorg.org>
	<20131101084909.5ed79987aa3aeb13b14e3f08@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1850514120842827206=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131101084909.5ed79987aa3aeb13b14e3f08-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1850514120842827206==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 08:49:09AM +0200, Hiroshi Doyu wrote:
> On Thu, 31 Oct 2013 18:53:22 +0100
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> ...
> > We're talking about memory-mapped on-SoC devices here, that generally
> > only exist inside Tegra SoCs.
> >=20
> > Even ignoring that (i.e. expanding the argument to arbitrary modules),
> > having drivers that perform bus-master transactions call a function
> > of_iommu_attach() or similar, which does nothing if the device isn't
> > behind an IOMMU but otherwise does whatever is required, seems like it
> > isn't much of an imposition.
>=20
> Where do you expect of_iommu_attach() to be called?
> I thought something below:
>=20
> 	Modified drivers/base/dd.c
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 35fa368..92ec2e9 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -278,6 +278,10 @@ static int really_probe(struct device *dev, struct d=
evice_driver *drv)
>  	if (ret)
>  		goto probe_failed;
> =20
> +	ret =3D of_iommu_attach(dev);
> +	if (ret)
> +		goto probe_failed;
> +
>  	if (driver_sysfs_add(dev)) {
>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>  			__func__, dev_name(dev));
>=20

The patches for late interrupt reference resolution introduced a
separate function, of_platform_probe(), with the intent of having it
call potentially many resource allocation hooks. The function needs to
be platform_device specific, and therefore is called from within the
platform_drv_probe() function. The reason is that interrupts are stored
as resources within struct platform_device, so you need to have access
to a platform device.

I think that devices that require attachment to an IOMMU will always end
up being platform devices too, so even if it isn't a strict requirement
here it would still make sense to use a similar infrastructure to avoid
cluttering the core code with too many loose function calls.

Thierry

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc3nXAAoJEN0jrNd/PrOhs2wQALvKXOIALAkIlmgDpt/UwLZ3
deGnliphUmS8HMxrFCU1pMU7JfVZlJUkBcewtIxIc6vND5gmyzkvoiAlUYbtGs2U
v9AVmF8ZBf2YZMUKV2GwaUQgivBHQGR7lsjubpW22WA+wGk7UieXc4yo1VeY2Mum
EUwbnX7X+jPV6QCoAJ4nabknLg4U2aPUlgxgjxt1uM7N9D514oxX2xT/RBhjChWp
ftvkLnoCra99sbE7gpYzxWop9ArKOERoVZYzTIX0XwC4rNvAc6p5bRBxTtaLLnpc
YdlVZU/x06qMbDjPJwIsYLyQEoppffwQVfnpWUcONCFXSdRm8dqH+0ywCaP58Ltp
PYCMZFHyr11wt4YNUnqj1MJhAYMiP0zsWIvUUNFvF/XJ1y+cvTyyJ3pDxkbpf5wp
EP81ErIhKG/XHAi1qnqm7EYdBq6oi2WCmFAE8zES9ov/06t3SUfqfvGKcQkZAIDK
AcWcrWEcE8txOa5tEYOdoSNEk9SVlRU99N2SaaE9pZzSZT/uvKujwUfS1oCAkyRx
n3SFf11gLxHDo2u6tkw0BfADvkRoDIJluNg3B337mj1/xbbb/J/1735qSRhg7QXr
1XzODR2FlJUcsWSH+wV++71vi0U0GXYMZpKhsITUOutbCTTpRUiACCO7j+JH38EB
Uir2Bafy/KMCaI27+SmN
=hnrj
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============1850514120842827206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1850514120842827206==--
