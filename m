From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Thu, 24 Jul 2014 12:07:10 +0200
Message-ID: <20140724100709.GD3811@ulmo.nvidia.com>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
	<1405558917-7597-2-git-send-email-ohaugan@codeaurora.org>
	<20140717082138.GC18640@ulmo> <53CDB76A.5090602@codeaurora.org>
	<20140722074507.GB18258@ulmo> <53CFF5C3.5060600@codeaurora.org>
	<20140724093427.GH14017@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7471659404473371703=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140724093427.GH14017-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7471659404473371703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2014 at 11:34:27AM +0200, Joerg Roedel wrote:
> On Wed, Jul 23, 2014 at 10:49:55AM -0700, Olav Haugan wrote:
> > Joerg, can you comment on what you envisioned when you suggested that we
> > add the fallback?
> >=20
>=20
> The problem is that we already have tons of IOMMU drivers in the tree
> which don't provide these call-backs. So adding this API extension
> without a fall-back that works for these drivers too would fragment the
> functionality between different IOMMU drivers in an inacceptable way and
> undermine the purpose of a generic API.

But we only care about in-tree drivers anyway, so we can equally well
just point all drivers to the generic implementation in the same patch
that adds this new function. The end result will be the same, but it
will keep the core function simpler (and more consistent with the other
core functions).

Thierry

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0NrNAAoJEN0jrNd/PrOhI70QAK3b/E77cWS7Qy4M6fvxK1fz
TezcugwdveOlVRaRkTNIWKlqJCCIMWRcNbG04wrskYwiQqe8YnGVcx2ll0YxDvTE
VHCU6csUeOTzXazyKHDM3PZNq1qb+uFOjvEsiGn0UPQkaPXYtfziEip7UJfTpPW4
IxqtjIYZ4nOjdvZZ8DTIWUzRBQaKDGLfFuTU6zeKX/83iJqn3MpnW+mMtZEQ91Mz
sqYRYA56f/F2WdQSi93IUz1ZZBuOgRZVnyLfgScWXe/eJwu6BNximTSJO7n8fz/p
aMKNFX8uYWr1Yrm0X1gO+F5lixP4hklYvZ1lGEhvm5LHC3ZL61XYUUwWKPwPQGsh
QsoYOZdNo2c5mAOtsBfOfHrkPBS8cFT/qQnYaHYwPoXsb9/2qNmGRi4R92KTboUI
I5j8lnzLlFigKKKqyWjHl0/AZ+HQPo6AVyglYGM6xh5zD4xsr1GwtfA2K4gbR6d/
5kgPdLMZkzeDGR1DKhRzClfHrhUamaWP7AeV4CggAm2UxKXlxFz4va83UXDmfr0+
nvegBU9vHaBk+KmpyIQAS8DP6Ic9VjqNBYr4o3Jw2c+3yvEa1a2ZpXelGF8+uH1x
IzvW46OPlIq/2iNYNLGYYQo9eP04qsuWOChzNZQNYFK6dlw++DJWi7cMfB6uCc5P
zRIXEGWUMmFaZtpC2Lud
=NlvO
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

--===============7471659404473371703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7471659404473371703==--
