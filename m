From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 11/23] iommu/tegra: smmu: Add of_mach_id for T114
Date: Wed, 26 Jun 2013 12:56:42 +0200
Message-ID: <20130626105641.GM27083@manwe>
References: <1372238906-9346-12-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-12-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 12:28:14PM +0300, Hiroshi Doyu wrote:
> Add of_mach_id for T114

I don't think of_mach_id is the right word. Why not use a subject such
as "iommu/tegra: smmu: Add Tegra114 support". And instead of duplicating
the subject in the commit message, perhaps you can say instead that for
Tegra114 the SMMU is the same as for Tegra30 (which I assume here given
that no code changes are required).

And we really need the nvidia,tegra114-smmu.txt binding documentation.
Either that or update the nvidia,tegra30-smmu.txt with Tegra114 specific
information.

Thierry

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysjpAAoJEN0jrNd/PrOhAPsP/05YlESph+AHCwXzJ2LRocPr
Q0IJHqlyyo3SyJv4qoEZbYUqPDHdUNN7VtfI8xdJVp7ORbsLbMAU5a5uDTzsg84X
jlYNNYHcHmI8nlwpvMRrKnDU7kTq2jjkc6PaQkzyDWo26kgoQE0A916LFF13L4k9
Cz1CGMLiB0ZZhm1VuI1HZCP2YMZukTS9oFsS61TvDWxTM0dhiCfiQa96H/ATd1FV
UXm5vT+XtoLQ6PqRiBpTY1Ns++C/xat1hvYC+Ecs4Mbon/ZrLc7P4bhFAeYBKh+O
kFefvzs5YBZhgomP2/8B8o1AHT21SaWyG8W8WnOjNp1IEPHR1XWUnTx4qRkIl54H
bT1letR+KU7qVxlmJOCF56Ktvs5jh7tt3UMwdVBpUgYqBBM9lOb3b7tVq9RsQe9K
Eovv+B2+UWmQPxU72cGISjM8Wt6BA10NpvOGJmhsKy+iCcoLW+huVne4QOMYvWwg
uof2myJNnxcKi2N3r3XG7/rbXfHDbyHm6vi/NridRu0Zi1qKDDy0JeH7nvX2roNQ
UqzI5CPZZmV4tvnXp2nmiWJxHWPzRboBlQ7lx78zKI3pO0y+IM6SaS4VxVB08hcn
dp88Tn4diB+75RNCg9egz+kfuyHjMEp8G74NGwZKeXVE560Iqm2Nad2ocEJsmPBI
hNzxebNtYXfv/Bs0wz/8
=uJ+m
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
