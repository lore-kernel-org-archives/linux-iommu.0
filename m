From: Shaik Ameer Basha <shaik.samsung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 12/27] ARM: dts: Add description of System MMU of
 Exynos SoCs
Date: Sun, 20 Apr 2014 15:25:59 +0530
Message-ID: <CAOD6ATr56P03Y3GChOTfTSHGrokU3do-YcRhk_voXSKcJVi8mA@mail.gmail.com>
References: <20140314140649.dc5958f420770af48e2376d9@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140314140649.dc5958f420770af48e2376d9-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi KyongHo Cho,

Please find the comments inline.

On Fri, Mar 14, 2014 at 10:36 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch adds dts entries for the System MMU devices found on
> Exynos4 and Exynos5 SoC series and the System MMU binding
> documentation.
>
> CC: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |   86 +++++++
>  arch/arm/boot/dts/exynos4.dtsi                     |  107 ++++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   23 +-
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   77 +++++-
>  arch/arm/boot/dts/exynos5250.dtsi                  |  266 +++++++++++++++++++-
>  arch/arm/boot/dts/exynos5420.dtsi                  |  205 ++++++++++++++-
>  6 files changed, 758 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
>
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> new file mode 100644
> index 0000000..e4417bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> @@ -0,0 +1,86 @@
> +Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
> +
> +Samsung's Exynos architecture contains System MMUs that enables scattered
> +physical memory chunks visible as a contiguous region to DMA-capable peripheral
> +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> +

[snip]


> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 8f6300f..df336ea 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -80,6 +80,16 @@
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
>         clock: clock-controller@10010000 {
>                 compatible = "samsung,exynos5250-clock";
>                 reg = <0x10010000 0x30000>;
> @@ -679,7 +689,7 @@
>                                 "sclk_hdmiphy", "mout_hdmi";
>         };
>
> -       mixer {
> +       mixer: mixer {
>                 compatible = "samsung,exynos5250-mixer";
>                 reg = <0x14450000 0x10000>;
>                 interrupts = <0 94 0>;
> @@ -700,7 +710,7 @@
>                 phy-names = "dp";
>         };
>
> -       fimd@14400000 {
> +       fimd: fimd@14400000 {
>                 clocks = <&clock 133>, <&clock 339>;
>                 clock-names = "sclk_fimd", "fimd";
>         };
> @@ -715,4 +725,256 @@
>                 io-channel-ranges;
>                 status = "disabled";
>         };
> +
> +       sysmmu_g2d: sysmmu@10A60000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x10A60000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <24 5>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock 361>;
> +       };
> +
> +       sysmmu_mfc_r: sysmmu@11200000 {
> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11200000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <6 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 268>, <&clock 266>;

Add mmu-masters...
                    mmu-masters = <&mfc>;

> +               samsung,power-domain = <&pd_mfc>;
> +       };
> +
> +       sysmmu_mfc_l: sysmmu@11210000 {
> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11210000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <8 5>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 267>, <&clock 266>;

Add mmu-masters...
                    mmu-masters = <&mfc>;


> +               samsung,power-domain = <&pd_mfc>;
> +       };
> +
> +       sysmmu_rotator: sysmmu@11D40000 {
> +               compatible = "samsung,sysmmu-v1";
> +               reg = <0x11D40000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <4 0>;
> +               clock-names = "sysmmu";
> +               clocks = <&clock 272>;
> +       };
> +

[snip]

>  };
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 45e2e65..a736f09 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -470,7 +470,7 @@
>                 phy-names = "dp";
>         };
>
> -       fimd@14400000 {
> +       fimd: fimd@14400000 {
>                 samsung,power-domain = <&disp_pd>;
>                 clocks = <&clock 147>, <&clock 421>;
>                 clock-names = "sclk_fimd", "fimd";
> @@ -641,7 +641,7 @@
>                 status = "disabled";
>         };
>
> -       mixer@14450000 {
> +       mixer: mixer@14450000 {
>                 compatible = "samsung,exynos5420-mixer";
>                 reg = <0x14450000 0x10000>;
>                 interrupts = <0 94 0>;
> @@ -720,4 +720,205 @@
>                 clock-names = "watchdog";
>                 samsung,syscon-phandle = <&pmu_system_controller>;
>          };
> +
> +       sysmmu_g2dr: sysmmu@10A60000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x10A60000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <24 5>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 482>, <&clock 481>;
> +       };
> +
> +       sysmmu_g2dw: sysmmu@10A70000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x10A60000 0x1000>;

Duplicate sysmmu reg base address.
                    reg = <0x10A70000 0x1000>;

> +               interrupt-parent = <&combiner>;
> +               interrupts = <22 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 482>, <&clock 481>;
> +       };
> +
> +       sysmmu_scaler0r: sysmmu@12880000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x12880000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <22 4>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 384>, <&clock 381>;
> +       };
> +
> +       sysmmu_scaler1r: sysmmu@12890000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x12890000 0x1000>;
> +               interrupts = <0 186 0>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 385>, <&clock 382>;
> +       };
> +
> +       sysmmu_scaler2r: sysmmu@128A0000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x128A0000 0x1000>;
> +               interrupts = <0 188 0>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 386>, <&clock 383>;
> +       };
> +
> +       sysmmu_scaler0w: sysmmu@128C0000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x128C0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <27 2>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 384>, <&clock 381>;
> +       };
> +
> +       sysmmu_scaler1w: sysmmu@128D0000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x128D0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <22 6>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 385>, <&clock 382>;
> +       };
> +
> +       sysmmu_scaler2w: sysmmu@128E0000 {
> +               compatible = "samsung,sysmmu-v3.2";
> +               reg = <0x128E0000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <19 6>;
> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 386>, <&clock 383>;
> +       };
> +
> +       sysmmu_mfc_r: sysmmu@11200000 {

0x11200000 belongs to mfc_l
             sysmmu_mfc_l: sysmmu@11200000

> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11200000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <6 2>;

                    interrupts = <8 5>;
Add mmu-masters field,
                    mmu-masters = <&mfc>;

> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 402>, <&clock 401>;

clocks = <&clock 403>, <&clock 401>;

> +               samsung,power-domain = <&mfc_pd>;
> +       };
> +
> +       sysmmu_mfc_l: sysmmu@11210000 {

0x11210000 belongs to mfc_r
                    sysmmu_mfc_r: sysmmu@11210000

> +               compatible = "samsung,sysmmu-v2";
> +               reg = <0x11210000 0x1000>;
> +               interrupt-parent = <&combiner>;
> +               interrupts = <8 5>;

interrupts = <6 2>;
Add mmu-masters field,
                    mmu-masters = <&mfc>;

> +               clock-names = "sysmmu", "master";
> +               clocks = <&clock 403>, <&clock 401>;

clocks = <&clock 402>, <&clock 401>;

Regards,
Shaik Ameer Basha
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
