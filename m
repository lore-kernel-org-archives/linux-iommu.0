From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v5 05/18] ARM: dts: exynos5420: add sysmmu nodes
Date: Sun, 22 Feb 2015 19:00:02 +0100
Message-ID: <54EA1922.2030000@suse.de>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com> <1422028288-891-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422028288-891-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Am 23.01.2015 um 16:51 schrieb Marek Szyprowski:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 181 ++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 181 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/ex=
ynos5420.dtsi
> index 1b62410..b8f1c9f 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
[...]
> @@ -925,4 +932,178 @@
>  		samsung,sysreg-phandle =3D <&sysreg_system_controller>;
>  		samsung,pmureg-phandle =3D <&pmu_system_controller>;
>  	};
> +
> +	sysmmu_g2dr: sysmmu@0x10A60000 {
[snip]

Unit addresses are without 0x. Please also check the sort order.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
