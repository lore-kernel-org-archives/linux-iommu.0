From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 06/22] ARM: dt: tegra114: iommu: Fix IOMMU register
	address
Date: Tue, 16 Jul 2013 16:27:09 -0700
Message-ID: <20130716232708.GB12189@dhcp-172-17-186-34.nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-7-git-send-email-hdoyu@nvidia.com>
	<51E5D4C5.4090109@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4987079784944669115=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51E5D4C5.4090109-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4987079784944669115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 05:18:29PM -0600, Stephen Warren wrote:
> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Fix IOMMU register address.
>=20
> Oh dear, how serious is this?
>=20
> That incorrect node got added in v3.9 - a long time ago. Does the SMMU
> driver touch registers during probe() or under any other condition right
> now? If so, can that hang the CPU or end up trashing some other HW
> module's registers?
>=20
> I'm trying to determine whether we need to urgently send this patch as a
> fix Cc: stable.

Judging by the TRM there's nothing in the range from 0x7000ec00 to
0x7000f7ff, so hopefully we got lucky.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR5dbMAAoJEN0jrNd/PrOh4MoP/2dJfn5/TPp6bMk0DzPxc+1G
k1IS0ryTrrQxe0x186MN2JEDJP5t8tQkR82eAE+f/lemw6kkx1LCIDZLH2hZqbGo
tHvZfeN9FC/3Wu23/5Krc4gDzZlMGQTEwCYD7o8UsAth5YebFz61YYf2wotoEdyv
1qxiFVDwP0Xy8DZRRlV7jU8W8GGxmYl/snMJ+C5EWnaJj9W6gZiW17zhd2ybDpxR
Wjl9OwvVMifRlIuqYiq4YWvIAKl9M8urQbN8z2Ghuq+sg2Qt0PV/z/gdbUHVxXq2
kOyWIOZWK6SRWI6fnm8kZO3o3fNxELUpODFkPlYezIBepKBXgfVmtemm7wZiDEF5
LRGpf5FtU7r56ebSeV3P7im7CVsBqDaaoWuUbSRwNZHsaT3dkR1g99zCLgLBKIAF
KP4BQ1F9k4sRxzmh//3F8ym3PgjNUAAgkHTPQ/2z3ZJrhwZTEhet9IRzmsjvKvqr
kzMfWEbesSFJ8oE+vgNZGXlwsiIndz8zcKsYTQkeitsTv4LJW/YMTGpCbAFVTwiH
y9DQFF5ZQLnu+Hr9Lli2UMbk4JJIhHGmSgUx7eqZ74dIyUdWSEBtxYTdMqVo5JKn
n1llMiYtJs7LGW9hhlIv9hV580BaaHkkibPlDH2o2VrqwdAUuXCROI/fXGPwAhz1
pKrgaBboVy9oePsyDza8
=Bi1o
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

--===============4987079784944669115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4987079784944669115==--
