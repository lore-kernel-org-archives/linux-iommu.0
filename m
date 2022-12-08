Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BA2F3D
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 13:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E460C433C1;
	Thu,  8 Dec 2022 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670507305;
	bh=6JvO2gQh0uvOKOJpp/CABLwVY2G2zg6zxv9G9PUEYho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIVtCOXRqv0dRKfJ2g541ZBmsq4uf0PdYLUYbyqEA4rRvVUS1dM6TNrOvM/fOnwdk
	 b2B+GztlLtM3niOa4YIC5RHrRl9bP75tpm+1xmMxQvJtmtzZYhuF2wKqT/tL/ohybg
	 GDEdjGdvsif5Ij3NEIGeGIt7DH/+MJ3ikCFBXQcrM98WYo4ixCNGtJ8MH9hpJ03tKZ
	 Un0HzNYUOOE6pnSMZVE7yh2v6DCX6L20oF6HDFPmklRA2asF6G/uo4uBsaHazXDHQt
	 eZShRqeqmtKjn4pirdrGmIgGtwmifFotviqvTnQEeUy9m8KCEfCHFLqPno7EjpzSsT
	 RrF+o75MvfeOQ==
Date: Thu, 8 Dec 2022 13:48:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	kernelci-results@groups.io, bot@kernelci.org
Cc: gtucker@collabora.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com, mingyuan.ma@mediatek.com,
	libo.kang@mediatek.com, chengci.xu@mediatek.com,
	yf.wang@mediatek.com, youlin.pei@mediatek.com,
	anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: next/master bisection: baseline.login on mt8173-elm-hana
Message-ID: <Y5HrIhEfuEgGKuMB@sirena.org.uk>
References: <6391e1c4.170a0220.b562d.3c9c@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpEsPdHeW7COrmvg"
Content-Disposition: inline
In-Reply-To: <6391e1c4.170a0220.b562d.3c9c@mx.google.com>
X-Cookie: They just buzzed and buzzed...buzzed.


--tpEsPdHeW7COrmvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2022 at 05:08:20AM -0800, KernelCI bot wrote:

The KernelCI bisection bot found a boot failure in today's -next on
mt8173-elm-hana was triggered by 26593928564cf ("iommu/mediatek: Add
error path for loop of mm_dts_parse").  We get an oops towards the end
of boot:

<6>[    0.840037] printk: bootconsole [mtk8250] disabled
<6>[    0.840037] printk: bootconsole [mtk8250] disabled
<1>[    0.854924] Unable to handle kernel read from unreadable memory at vi=
rtual address 000000000000003b

<1>[    0.864288] Mem abort info:
<1>[    0.867374]   ESR =3D 0x0000000096000005
<1>[    0.871408]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>[    0.877005]   SET =3D 0, FnV =3D 0
<1>[    0.880350]   EA =3D 0, S1PTW =3D 0
<1>[    0.883776]   FSC =3D 0x05: level 1 translation fault
<1>[    0.888938] Data abort info:

=2E..

<4>[    1.027320]  kobject_put+0x18/0xf0
<4>[    1.030996]  put_device+0x1c/0x28

<4>[    1.034586]  mtk_iommu_mm_dts_parse+0x2d0/0x31c
<4>[    1.039394]  mtk_iommu_probe+0x2dc/0x4c0
<4>[    1.043592]  platform_probe+0xb0/0xd0
<4>[    1.047530]  really_probe+0xf8/0x280
<4>[    1.051377]  __driver_probe_device+0xbc/0xe8

<4>[    1.055923]  driver_probe_device+0x44/0x104
<4>[    1.060380]  __driver_attach+0xb4/0x108
<4>[    1.064487]  bus_for_each_dev+0x88/0xd4
<4>[    1.068598]  driver_attach+0x2c/0x38
<4>[    1.072445]  bus_add_driver+0x114/0x1f4
<4>[    1.076554]  driver_register+0x6c/0x108
<4>[    1.080663]  __platform_driver_register+0x2c/0x38
<4>[    1.085640]  mtk_iommu_driver_init+0x24/0x30

I've left the full report from the bot below, including links to more
detailed information and a Reported-by tag for the bot below, the log
links got mangled and should be:

   https://storage.kernelci.org/next/master/next-20221208/arm64/cros---chro=
meos-5.10-arm64-chromiumos-mediatek.flavour.config%2Barm64-chromebook/clang=
-13/lab-collabora/baseline-mt8173-elm-hana.html
   https://storage.kernelci.org/next/master/next-20221208/arm64/cros---chro=
meos-5.10-arm64-chromiumos-mediatek.flavour.config%2Barm64-chromebook/clang=
-13/lab-collabora/baseline-mt8173-elm-hana.txt

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> next/master bisection: baseline.login on mt8173-elm-hana
>=20
> Summary:
>   Start:      f925116b24c0c Add linux-next specific files for 20221208
>   Plain log:  https://storage.kernelci.org/next/master/next-20221208/arm6=
4/cros://chromeos-5.10/arm64/chromiumos-arm64.flavour.config+arm64-chromebo=
ok/clang-13/lab-collabora/baseline-mt8173-elm-hana.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20221208/arm6=
4/cros://chromeos-5.10/arm64/chromiumos-arm64.flavour.config+arm64-chromebo=
ok/clang-13/lab-collabora/baseline-mt8173-elm-hana.html
>   Result:     26593928564cf iommu/mediatek: Add error path for loop of mm=
_dts_parse
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
>   Branch:     master
>   Target:     mt8173-elm-hana
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   clang-13
>   Config:     cros://chromeos-5.10/arm64/chromiumos-arm64.flavour.config+=
arm64-chromebook
>   Test case:  baseline.login
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 26593928564cf5b576ff05d3cbd958f57c9534bb
> Author: Yong Wu <yong.wu@mediatek.com>
> Date:   Tue Oct 18 10:42:55 2022 +0800
>=20
>     iommu/mediatek: Add error path for loop of mm_dts_parse
>    =20
>     The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
>     larb is parsed fail, we should put_device for the i..0 larbs.
>    =20
>     There are two places need to comment:
>     1) The larbid may be not linear mapping, we should loop whole
>        the array in the error path.
>     2) I move this line position: "data->larb_imu[id].dev =3D &plarbdev->=
dev;"
>        before "if (!plarbdev->dev.driver)", That means set
>        data->larb_imu[id].dev before the error path. then we don't need
>        "platform_device_put(plarbdev)" again in probe_defer case. All dep=
end
>        on "put_device" of the error path in error cases.
>    =20
>     Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the =
MM TYPE")
>     Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>     Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
>     Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>     Link: https://lore.kernel.org/r/20221018024258.19073-4-yong.wu@mediat=
ek.com
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>=20
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index df490236e1fb5..e0c669b75271d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1067,8 +1067,10 @@ static int mtk_iommu_mm_dts_parse(struct device *d=
ev, struct component_match **m
>  		u32 id;
> =20
>  		larbnode =3D of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> -		if (!larbnode)
> -			return -EINVAL;
> +		if (!larbnode) {
> +			ret =3D -EINVAL;
> +			goto err_larbdev_put;
> +		}
> =20
>  		if (!of_device_is_available(larbnode)) {
>  			of_node_put(larbnode);
> @@ -1081,14 +1083,16 @@ static int mtk_iommu_mm_dts_parse(struct device *=
dev, struct component_match **m
> =20
>  		plarbdev =3D of_find_device_by_node(larbnode);
>  		of_node_put(larbnode);
> -		if (!plarbdev)
> -			return -ENODEV;
> +		if (!plarbdev) {
> +			ret =3D -ENODEV;
> +			goto err_larbdev_put;
> +		}
> +		data->larb_imu[id].dev =3D &plarbdev->dev;
> =20
>  		if (!plarbdev->dev.driver) {
> -			platform_device_put(plarbdev);
> -			return -EPROBE_DEFER;
> +			ret =3D -EPROBE_DEFER;
> +			goto err_larbdev_put;
>  		}
> -		data->larb_imu[id].dev =3D &plarbdev->dev;
> =20
>  		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>  		platform_device_put(plarbdev);
> @@ -1123,6 +1127,15 @@ static int mtk_iommu_mm_dts_parse(struct device *d=
ev, struct component_match **m
>  		return -EINVAL;
>  	}
>  	return 0;
> +
> +err_larbdev_put:
> +	/* id may be not linear mapping, loop whole the array */
> +	for (i =3D MTK_LARB_NR_MAX - 1; i >=3D 0; i++) {
> +		if (!data->larb_imu[i].dev)
> +			continue;
> +		put_device(data->larb_imu[i].dev);
> +	}
> +	return ret;
>  }
> =20
>  static int mtk_iommu_probe(struct platform_device *pdev)
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [479174d402bcf60789106eedc4def3957c060bad] Merge tag 'platform-dr=
ivers-x86-v6.1-5' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pl=
atform-drivers-x86
> git bisect good 479174d402bcf60789106eedc4def3957c060bad
> # bad: [f925116b24c0c42dc6d5ab5111c55fd7f74e8dc7] Add linux-next specific=
 files for 20221208
> git bisect bad f925116b24c0c42dc6d5ab5111c55fd7f74e8dc7
> # good: [a1c975859da787104f6f2610f0f5507ef794dea4] Merge branch 'master' =
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good a1c975859da787104f6f2610f0f5507ef794dea4
> # bad: [df52ed561d70653b4d82a468026450374161693b] Merge branch 'master' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect bad df52ed561d70653b4d82a468026450374161693b
> # good: [ddf1b69a1f2e0704bc0d5f7f71e4f8c4891a3bbb] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> git bisect good ddf1b69a1f2e0704bc0d5f7f71e4f8c4891a3bbb
> # good: [b5cb3c9818c0085928c1d795e1e2a78add3dbca5] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
> git bisect good b5cb3c9818c0085928c1d795e1e2a78add3dbca5
> # bad: [b07fcd1e4269638ae72abc499543eb72605bd34b] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> git bisect bad b07fcd1e4269638ae72abc499543eb72605bd34b
> # bad: [147cf2079e0afce372e3d14089396736a025ecda] Merge branch 'next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> git bisect bad 147cf2079e0afce372e3d14089396736a025ecda
> # good: [14d40e4c74b85c390e076712a6d2831e9464b786] Merge branch 'next' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> git bisect good 14d40e4c74b85c390e076712a6d2831e9464b786
> # good: [b169a180bef26679b44484ad24b7d8ae32623a10] iommu/io-pgtable: Remo=
ve map/unmap
> git bisect good b169a180bef26679b44484ad24b7d8ae32623a10
> # good: [f04ae51dd965bc0b7f2e01c5d85fc214877b4061] Merge tag 'arm-smmu-up=
dates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm=
/smmu
> git bisect good f04ae51dd965bc0b7f2e01c5d85fc214877b4061
> # bad: [4dd549a66a969ccd3ed344f37fb9b9e9516fc1e6] Merge branches 'iommu/f=
ixes', 'arm/allwinner', 'arm/exynos', 'arm/mediatek', 'arm/rockchip', 'arm/=
smmu', 'ppc/pamu', 's390', 'x86/vt-d', 'x86/amd' and 'core' into next
> git bisect bad 4dd549a66a969ccd3ed344f37fb9b9e9516fc1e6
> # good: [21c1f9021f0e7d28c3edfcc70e1ca1926ea3774e] s390/pci: use lock-fre=
e I/O translation updates
> git bisect good 21c1f9021f0e7d28c3edfcc70e1ca1926ea3774e
> # bad: [00ef8885a945c37551547d8ac8361cacd20c4e42] iommu/mediatek: Fix cra=
sh on isr after kexec()
> git bisect bad 00ef8885a945c37551547d8ac8361cacd20c4e42
> # good: [dcb40e9fcce9bd251eaff19f3724131db522846c] iommu/mediatek: Add pl=
atform_device_put for recovering the device refcnt
> git bisect good dcb40e9fcce9bd251eaff19f3724131db522846c
> # bad: [ef693a8440926884bfd9cc3d6d36f65719513350] iommu/mediatek: Validat=
e number of phandles associated with "mediatek,larbs"
> git bisect bad ef693a8440926884bfd9cc3d6d36f65719513350
> # bad: [26593928564cf5b576ff05d3cbd958f57c9534bb] iommu/mediatek: Add err=
or path for loop of mm_dts_parse
> git bisect bad 26593928564cf5b576ff05d3cbd958f57c9534bb
> # good: [b5765a1b44bea9dfcae69c53ffeb4c689d0922a7] iommu/mediatek: Use co=
mponent_match_add
> git bisect good b5765a1b44bea9dfcae69c53ffeb4c689d0922a7
> # first bad commit: [26593928564cf5b576ff05d3cbd958f57c9534bb] iommu/medi=
atek: Add error path for loop of mm_dts_parse
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#35262): https://groups.io/g/kernelci-results/message/=
35262
> Mute This Topic: https://groups.io/mt/95537191/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--tpEsPdHeW7COrmvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOR6yEACgkQJNaLcl1U
h9A8WQf+PxBKqPFQIXXOf5aScugL/vg/DfSKvb8W03a+gHlFhiaxbo82QTSF/fwX
OAnYyHUyitl7N3ReHqycf38yEIdRmgxZ/QS0R2WBLUIqeDcwlAS9QBIbcA/aaUtU
yAHQucruv/pHSiVyce9YySjEYrZx1utUJ07/QrEkHftvFkltLL6ACeQdeCMVlxH2
2fp5ODyaG/c0Yd7KZO23CgQPKWds3unHpTTL/NGEcY01c0kVRIRt0qGXyrvHJYQw
QWqJ4tXJGLmYkXncR58kWvQ8YGpT85tcaStYDmnHD6pkjqO09i8998icqgsuqNyG
JSAjg47HT9kEuYN4pSUK5Q98ERccVg==
=yvxS
-----END PGP SIGNATURE-----

--tpEsPdHeW7COrmvg--
