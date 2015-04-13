From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: rockchip: fix build without CONFIG_OF
Date: Mon, 13 Apr 2015 12:10:53 +0200
Message-ID: <20150413101050.GA3654@ulmo.nvidia.com>
References: <3138014.xYAj3FssJ8@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3115469805948313993=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <3138014.xYAj3FssJ8@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============3115469805948313993==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 11:58:24PM +0200, Arnd Bergmann wrote:
> The rockchip iommu driver references its of_device_id table
> from the init function, which fails to build when the table
> is undefined:
>=20
> iommu/rockchip-iommu.c: In function 'rk_iommu_init':
> iommu/rockchip-iommu.c:1029:35: error: 'rk_iommu_dt_ids' undeclared (firs=
t use in this function)
>   np =3D of_find_matching_node(NULL, rk_iommu_dt_ids);
>=20
> This removes the #ifdef and the corresponding of_match_ptr wrapper
> to make it build both with CONFIG_OF enabled or disabled.
>=20
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: 425061b0f5074 ("iommu/rockchip: Play nice in multi-platform builds=
")

How can this even happen? Rockchip depends on multiplatform, and
multiplatform pulls in OF. Ah... COMPILE_TEST... oh well.

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVK5YnAAoJEN0jrNd/PrOhCs8P/iOYuBjtq1BFP0M2CHp11WYq
PlrgGWiz70jRvCq49UOuNVqpGFnYhK7wQub5U7z+M582ZfRYEnSl2laYaxmTGoVk
iteLLQ3b+1WhUWXyVS80kWGVxHeyP8TBqg9vHMwHXgd9aC3vQ+bl5xTFRw4TmI+E
itzAID+QqmH03srCVXWjeuJ+9g6iuyVwrZupvlneax8XYd0sqdpjh5DiIz1CLqei
8y4V6Tk0EB7YeKllB3FW0qCf4HDZ86Pu5Ms6N8fYXVL2UuYFO3nLTjQWW4rzkoA9
hYRkfH/WgktpWvEbmvPmfcD/CWE2ptsPBQaeX6qgJwOmmIomKBAZxrTo6litwxfv
30QkU/E0wyFDXsXvenX89++wU5gc3VkaJv15cMY1B0zCfmCSlcLfshQxREI4KPhq
oe2ZBi/O/fOPUvRWtTMOaci7/4/yzQ9XfbYFPKBYsWc0q/OOgQkxKHyXg6UmpEp7
g+BBfje495BDQXENI1v+mmESLu7wLsrTavDa2OMDLOKGKo0ukmDfNyC77tGQ+U7j
PhzFk4WvWslwdk6cM/c5Db+LFlxBSSbRJed3tF1FaTV7b3nWDKL8W9zdZ8cWVolj
3dq+7JPVz3Cp8DPEjnoeHSdFBqtUg3TgJ/BdjCORsPIiuogcktOQD74bfqHynL4P
RcyCjFsNXe71jK1AMB0b
=yNPE
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


--===============3115469805948313993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============3115469805948313993==--
