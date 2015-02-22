From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v5 04/18] ARM: dts: exynos5250: add sysmmu nodes
Date: Sun, 22 Feb 2015 18:58:03 +0100
Message-ID: <54EA18AB.10507@suse.de>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com> <1422028288-891-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422028288-891-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Am 23.01.2015 um 16:51 schrieb Marek Szyprowski:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 250 ++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 250 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/ex=
ynos5250.dtsi
> index ae22bd9..8583b9e 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -224,6 +224,7 @@
>  		interrupts =3D <0 91 0>;
>  		clocks =3D <&clock CLK_G2D>;
>  		clock-names =3D "fimg2d";
> +		iommus =3D <&sysmmu_g2d>;
>  	};
> =20
>  	mfc: codec@11000000 {
> @@ -233,6 +234,8 @@
>  		power-domains =3D <&pd_mfc>;
>  		clocks =3D <&clock CLK_MFC>;
>  		clock-names =3D "mfc";
> +		iommus =3D <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> +		iommu-names =3D "left", "right";
>  	};
> =20
>  	rtc: rtc@101E0000 {
> @@ -693,6 +696,7 @@
>  		power-domains =3D <&pd_gsc>;
>  		clocks =3D <&clock CLK_GSCL0>;
>  		clock-names =3D "gscl";
> +		iommu =3D <&sysmmu_gsc1>;
>  	};
> =20
>  	gsc_1:  gsc@13e10000 {
> @@ -702,6 +706,7 @@
>  		power-domains =3D <&pd_gsc>;
>  		clocks =3D <&clock CLK_GSCL1>;
>  		clock-names =3D "gscl";
> +		iommu =3D <&sysmmu_gsc1>;
>  	};
> =20
>  	gsc_2:  gsc@13e20000 {
> @@ -711,6 +716,7 @@
>  		power-domains =3D <&pd_gsc>;
>  		clocks =3D <&clock CLK_GSCL2>;
>  		clock-names =3D "gscl";
> +		iommu =3D <&sysmmu_gsc2>;
>  	};
> =20
>  	gsc_3:  gsc@13e30000 {
> @@ -720,6 +726,7 @@
>  		power-domains =3D <&pd_gsc>;
>  		clocks =3D <&clock CLK_GSCL3>;
>  		clock-names =3D "gscl";
> +		iommu =3D <&sysmmu_gsc3>;
>  	};
> =20
>  	hdmi: hdmi {
> @@ -743,6 +750,7 @@
>  		clocks =3D <&clock CLK_MIXER>, <&clock CLK_HDMI>,
>  			 <&clock CLK_SCLK_HDMI>;
>  		clock-names =3D "mixer", "hdmi", "sclk_hdmi";
> +		iommus =3D <&sysmmu_tv>;
>  	};
> =20
>  	dp_phy: video-phy@10040720 {
> @@ -763,6 +771,7 @@
>  		power-domains =3D <&pd_disp1>;
>  		clocks =3D <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
>  		clock-names =3D "sclk_fimd", "fimd";
> +		iommus =3D <&sysmmu_fimd1>;
>  	};
> =20
>  	adc: adc@12D10000 {
> @@ -784,4 +793,245 @@
>  		clocks =3D <&clock CLK_SSS>;
>  		clock-names =3D "secss";
>  	};
> +
> +	sysmmu_gsc0: sysmmu@13E80000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13E80000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <2 0>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_gsc1: sysmmu@13E90000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13E90000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <2 2>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_gsc2: sysmmu@13EA0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13EA0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <2 4>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_GSCL2>, <&clock CLK_GSCL2>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_gsc3: sysmmu@13EB0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13EB0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <2 6>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_GSCL3>, <&clock CLK_GSCL3>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_mfc_r: sysmmu@11200000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x11200000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <6 2>;
> +		power-domains =3D <&pd_mfc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_mfc_l: sysmmu@11210000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x11210000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <8 5>;
> +		power-domains =3D <&pd_mfc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
> +		#iommu-cells =3D <0>;
> +	};

These two nodes (and further ones below) seem sorted wrongly. Please
order by unit address.

Regards,
Andreas

> +
> +	sysmmu_tv: sysmmu@14650000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x14650000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <7 4>;
> +		power-domains =3D <&pd_disp1>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_TV>, <&clock CLK_MIXER>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimd1: sysmmu@14640000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x14640000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <3 2>;
> +		power-domains =3D <&pd_disp1>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_FIMD1>, <&clock CLK_FIMD1>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_g2d: sysmmu@10A60000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x10A60000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <24 5>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_2D>, <&clock CLK_G2D>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_rotator: sysmmu@11D40000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x11D40000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <4 0>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_ROTATOR>, <&clock CLK_ROTATOR>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_jpeg: sysmmu@11F20000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x11F20000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <4 2>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_isp: sysmmu@13260000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13260000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <10 6>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_ISP>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_drc: sysmmu@13270000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13270000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <11 6>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_DRC>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_fd: sysmmu@132A0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132A0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <5 0>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_FD>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_scc: sysmmu@13280000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13280000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <5 2>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_SCC>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_scp: sysmmu@13290000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13290000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <3 6>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_SCP>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_mcuctl: sysmmu@132B0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132B0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <5 4>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_MCU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_odc: sysmmu@132C0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132C0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <11 0>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_ODC>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_dis0: sysmmu@132D0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132D0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <10 4>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_DIS0>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_dis1: sysmmu@132E0000{
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132E0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <9 4>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_DIS1>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_3dnr: sysmmu@132F0000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x132F0000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <5 6>;
> +		clock-names =3D "sysmmu";
> +		clocks =3D <&clock CLK_SMMU_FIMC_3DNR>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_lite0: sysmmu@13C40000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13C40000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <3 4>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_FIMC_LITE0>, <&clock CLK_CAMIF_TOP>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	sysmmu_fimc_lite1: sysmmu@13C50000 {
> +		compatible =3D "samsung,exynos-sysmmu";
> +		reg =3D <0x13C50000 0x1000>;
> +		interrupt-parent =3D <&combiner>;
> +		interrupts =3D <24 1>;
> +		power-domains =3D <&pd_gsc>;
> +		clock-names =3D "sysmmu", "master";
> +		clocks =3D <&clock CLK_SMMU_FIMC_LITE1>, <&clock CLK_CAMIF_TOP>;
> +		#iommu-cells =3D <0>;
> +	};
>  };

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
