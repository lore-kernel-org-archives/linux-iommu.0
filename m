From: Vikas Sajjan <sajjan.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 30/31] ARM: dts: add System MMU nodes of exynos5250
Date: Sun, 27 Apr 2014 23:09:26 +0530
Message-ID: <CAGm_ybhTEN9QxFBd1Su8NGP32KeYTF8d_Z8gXKo7cYpapZrA9w@mail.gmail.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<1398584283-22846-31-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398584283-22846-31-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sunil joshi <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi shaik,

+Doug, Abhilash,

On Sun, Apr 27, 2014 at 1:08 PM, Shaik Ameer Basha
<shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |  270 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 3742331..eebd397 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -82,6 +82,16 @@
>                 reg = <0x10044040 0x20>;
>         };
>
> +       pd_isp: isp-power-domain@0x10044020 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x10044020 0x20>;
> +       };
> +
> +       pd_disp1: disp1-power-domain@0x100440A0 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x100440A0 0x20>;
> +       };
> +

As per subject "add System MMU nodes of exynos5250", it should only
add SysMMU node.
So, I think adding power domain nodes should go in a separate patch.

Adding power domain nodes can break the system, if powering ON/OFF of
the given power domain is NOT taken care well.
I can see ISP is one such case. With this series I can see S2R breaks
[1] on 5250 chromebook with current mainline kernel (same applies for
arndale and smdk5250, but I have tested on these boards yet)

 Doug , Abhilash, Tomasz any thoughts on this.

[1]: https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/2c3f79b4ed68a54da9065a7d1a6f46d33e1df204


>         clock: clock-controller@10010000 {
>                 compatible = "samsung,exynos5250-clock";
>                 reg = <0x10010000 0x30000>;
> @@ -192,7 +202,7 @@
>                 clock-names = "fimg2d";
>         };
>
> -       codec@11000000 {
> +       mfc: codec@11000000 {
>                 compatible = "samsung,mfc-v6";
>                 reg = <0x11000000 0x10000>;
>                 interrupts = <0 96 0>;
> @@ -692,7 +702,7 @@
>                                 "sclk_hdmiphy", "mout_hdmi";
>         };
>
> -       mixer {
> +       mixer: mixer {
>                 compatible = "samsung,exynos5250-mixer";
>                 reg = <0x14450000 0x10000>;
>                 interrupts = <0 94 0>;
> @@ -713,7 +723,7 @@
>                 phy-names = "dp";
>         };
>
> -       fimd@14400000 {
> +       fimd: fimd@14400000 {
>                 clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
>                 clock-names = "sclk_fimd", "fimd";
>         };
> @@ -736,4 +746,258 @@
>                 clocks = <&clock 348>;
>                 clock-names = "secss";
>         };
> +
> +       sysmmu_g2d: sysmmu@10A60000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x10A60000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <24 5>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_2D>;
> +       };
> +
> +       sysmmu_mfc_r: sysmmu@11200000 {
> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11200000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <6 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
> +               mmu-masters = <&mfc>;
> +               samsung,power-domain = <&pd_mfc>;
> +       };
> +
> +       sysmmu_mfc_l: sysmmu@11210000 {
> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11210000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <8 5>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
> +               mmu-masters = <&mfc>;
> +               samsung,power-domain = <&pd_mfc>;
> +       };
> +
> +       sysmmu_rotator: sysmmu@11D40000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x11D40000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <4 0>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_ROTATOR>;
> +       };
> +
> +       sysmmu_fimc_isp: sysmmu@13260000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13260000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <10 6>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_ISP>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_drc: sysmmu@13270000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13270000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <11 6>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_DRC>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_scc: sysmmu@13280000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13280000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <5 2>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_SCC>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_scp: sysmmu@13290000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13290000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <3 6>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_SCP>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_fd: sysmmu@132A0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132A0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <5 0>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_FD>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_mcuctl: sysmmu@132B0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132B0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <5 4>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_MCU>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_odc: sysmmu@132C0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132C0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <11 0>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_ODC>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_dis0: sysmmu@132D0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132D0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <10 4>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_DIS0>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_dis1: sysmmu@132E0000{
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132E0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <9 4>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_DIS1>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_3dnr: sysmmu@132F0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x132F0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <5 6>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMC_3DNR>;
> +               samsung,power-domain = <&pd_isp>;
> +       };
> +
> +       sysmmu_fimc_lite0: sysmmu@13C40000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13C40000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <3 4>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_FIMC_LITE0>, <&clock CLK_CAMIF_TOP>;
> +               samsung,power-domain = <&pd_gsc>;
> +       };
> +
> +       sysmmu_fimc_lite1: sysmmu@13C50000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13C50000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <24 1>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_FIMC_LITE1>, <&clock CLK_CAMIF_TOP>;
> +               samsung,power-domain = <&pd_gsc>;
> +       };
> +
> +       sysmmu_gsc0: sysmmu@13E80000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13E80000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <2 0>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
> +               samsung,power-domain = <&pd_gsc>;
> +               mmu-masters = <&gsc_0>;
> +       };
> +
> +       sysmmu_gsc1: sysmmu@13E90000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13E90000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <2 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
> +               samsung,power-domain = <&pd_gsc>;
> +               mmu-masters = <&gsc_1>;
> +       };
> +
> +       sysmmu_gsc2: sysmmu@13EA0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13EA0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <2 4>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_GSCL2>, <&clock CLK_GSCL2>;
> +               samsung,power-domain = <&pd_gsc>;
> +               mmu-masters = <&gsc_2>;
> +       };
> +
> +       sysmmu_gsc3: sysmmu@13EB0000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x13EB0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <2 6>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_GSCL3>, <&clock CLK_GSCL3>;
> +               samsung,power-domain = <&pd_gsc>;
> +               mmu-masters = <&gsc_3>;
> +       };
> +
> +       sysmmu_fimd1: sysmmu@14640000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x14640000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <3 2>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_FIMD1>;
> +               samsung,power-domain = <&pd_disp1>;
> +               mmu-masters = <&fimd>;
> +       };
> +
> +       sysmmu_tv: sysmmu@14650000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x14650000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <7 4>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock CLK_SMMU_TV>;
> +               samsung,power-domain = <&pd_disp1>;
> +               mmu-masters = <&mixer>;
> +       };
> +
> +       sysmmu_jpeg: sysmmu@11F20000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x11F20000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <4 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
> +               samsung,power-domain = <&pd_gsc>;
> +       };
> +
> +       sysmmu_mdma0: sysmmu@10A40000{
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x10A40000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <7 0>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_MDMA0>, <&clock CLK_MDMA0>;
> +       };
> +
> +       sysmmu_mdma1: sysmmu@11D50000{
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x11D50000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <7 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock CLK_SMMU_MDMA1>, <&clock CLK_MDMA1>;
> +       };
>  };
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
