From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v9 06/16] ARM: dts: Add description of System MMU of Exynos
 SoCs
Date: Thu, 08 Aug 2013 12:45:34 +0200
Message-ID: <520376CE.3000109@samsung.com>
References: <002a01ce941b$0d9a31c0$28ce9540$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <002a01ce941b$0d9a31c0$28ce9540$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 08/08/2013 11:38 AM, Cho KyongHo wrote:

How about something along the lines of:

"This patch adds dts entries for the SYSMMU devices found on Exynos4
and Exynos5 SoC series and the SYSMMU binding documentation."

instead of this empty changelog ?

> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
>  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   82 ++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  290 ++++++++++++++++++++
>  5 files changed, 622 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> new file mode 100644
> index 0000000..92f0a33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> @@ -0,0 +1,103 @@
> +Samsung Exynos4210 IOMMU H/W, System MMU (System Memory Management Unit)
> +
> +Samsung's Exynos architecture contains System MMU that enables scattered
> +physical memory chunks visible as a contiguous region to DMA-capable peripheral
> +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.

s/so forth/and more ?

> +
> +System MMU is a sort of IOMMU and support identical translation table format to

s/support/supports ?

> +ARMv7 translation tables with minimum set of page properties including access
> +permissions, shareability and security protection. In addition, System MMU has
> +another capabilities like L2 TLB or block-fetch buffers to minimize translation
> +latency.
> +
> +A System MMU is dedicated to a single master peripheral device.  Thus, it is
> +important to specify the correct System MMU in the device node of its master
> +device. Whereas a System MMU is dedicated to a master device, the master device
> +may have more than one System MMU.
> +
> +Required properties:
> +- compatible: Should be "samsung,exynos4210-sysmmu"
> +- reg: A tuple of base address and size of System MMU registers.
> +- interrupt-parent: The phandle of the interrupt controller of System MMU
> +- interrupts: A tuple of numbers that indicates the interrupt source.

The interrupt specifier depends on the interrupt controller (interrupt-parent). 
So it might not always be a "tuple of numbers". It's probably better to say,
e.g.:

- interrupts: Should contain the SYSMMU controller interrupt.

> +- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
> +               Please refer to the following documents:
> +	       Documentation/devicetree/bindings/clock/clock-bindings.txt
> +	       Documentation/devicetree/bindings/clock/exynos4-clock.txt
> +	       Documentation/devicetree/bindings/clock/exynos5250-clock.txt

You could replace "Documentation/devicetree/bindings/clock" with "../clock"

> +	       Optional "master" if the clock to the System MMU is gated by
> +	       another gate clock other than "sysmmu". The System MMU driver
> +	       sets "master" the parent of "sysmmu".
> +	       Exynos4 SoCs, there needs no "master" clocks.
> +	       Exynos5 SoCs, some System MMUs must have "master" clocks.
> +- clocks: Required if the System MMU is needed to gate its clock.
> +	  Please refer to the documents listed above.
> +- samsung,power-domain: Required if the System MMU is needed to gate its power.

Isn't it required always when an SoC support Power Domains and the SYSMMU
belongs to a power domain ? Perhaps something like:

- samsung,power-domain: Required if the System MMU belongs to a Power Domain.

would be more appropriate ?

> +	  Please refer to the following document:
> +	  Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> +
> +Required properties for the master peripheral devices:
> +- iommu: phandles to the System MMUs of the device
> +
> +Examples:
> +A System MMU is dedicated to a single master device.
> +	gsc_0:  gsc@0x13e00000 {
> +		compatible = "samsung,exynos5-gsc";
> +		reg = <0x13e00000 0x1000>;
> +		interrupts = <0 85 0>;
> +		samsung,power-domain = <&pd_gsc>;
> +		clocks = <&clock 256>;
> +		clock-names = "gscl";

You could omit all the above properties, perhaps just leaving
'compatible' property, simply replacing them with:
		...

since the only relevant property hers is 'iommu' ? Just a suggestion
though.

> +		iommu = <&sysmmu_gsc1>;

Shouldn't this be:

		iommu = <&sysmmu_gsc0>;
? 
It also probably makes sense to put the SYMMU device node above 
the master device node.

> +	};
> +
> +	sysmmu_gsc0: sysmmu@13E80000 {
> +		compatible = "samsung,exynos4210-sysmmu";
> +		reg = <0x13E80000 0x1000>;
> +		interrupt-parent = <&combiner>;
> +		interrupt-names = "sysmmu-gsc0";
> +		interrupts = <2 0>;
> +		clock-names = "sysmmu", "master";
> +		clocks = <&clock 262>, <&clock 256>;
> +		samsung,power-domain = <&pd_gsc>;
> +		status = "ok";
> +	};
> +
> +MFC has 2 System MMUs for each port that MFC is attached. Thus it seems natural
> +to define 2 System MMUs for each port of the MFC:
> +
> +	mfc: codec@13400000 {
> +		compatible = "samsung,mfc-v5";
> +		reg = <0x13400000 0x10000>;
> +		interrupts = <0 94 0>;
> +		samsung,power-domain = <&pd_mfc>;
> +		clocks = <&clock 170>, <&clock 273>;
> +		clock-names = "sclk_mfc", "mfc";
> +		status = "ok";
> +		iommu = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> +	};

How about putting this node as last one in this example ?

> +	sysmmu_mfc_l: sysmmu@13620000 {
> +		compatible = "samsung,exynos4210-sysmmu";
> +		reg = <0x13620000 0x1000>;
> +		interrupt-parent = <&combiner>;
> +		interrupt-names = "sysmmu-mfc-l";
> +		interrupts = <5 5>;
> +		clock-names = "sysmmu";
> +		clocks = <&clock 274>;
> +		samsung,power-domain = <&pd_mfc>;
> +		status = "ok";
> +	};
> +
> +	sysmmu_mfc_r: sysmmu@13630000 {
> +		compatible = "samsung,exynos4210-sysmmu";
> +		reg = <0x13630000 0x1000>;
> +		interrupt-parent = <&combiner>;
> +		interrupt-names = "sysmmu-mfc-r";
> +		interrupts = <5 6>;
> +		clock-names = "sysmmu";
> +		clocks = <&clock 275>;
> +		samsung,power-domain = <&pd_mfc>;
> +		status = "ok";
> +	};
> +
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 597cfcf..6265984 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -251,6 +251,7 @@
>  		clocks = <&clock 170>, <&clock 273>;
>  		clock-names = "sclk_mfc", "mfc";
>  		status = "disabled";
> +		iommu = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
>  	};
>  
>  	serial@13800000 {
> @@ -485,5 +486,126 @@
>  		clock-names = "sclk_fimd", "fimd";
>  		samsung,power-domain = <&pd_lcd0>;
>  		status = "disabled";
> +		iommu = <&sysmmu_fimd0>;
> +	};
> +
> +	sysmmu_mfc_l: sysmmu@13620000 {
> +		compatible = "samsung,exynos4210-sysmmu";
> +		reg = <0x13620000 0x1000>;
> +		interrupt-parent = <&combiner>;
> +		interrupt-names = "sysmmu-mfc-l";

Do you really need 'interrupt-names' property, when there is only
one interrupt in each node. Isn't it just a leftover from previous
iterations ? I can't see it mentioned in the binding documentation.

> +		interrupts = <5 5>;
> +		clock-names = "sysmmu";
> +		clocks = <&clock 274>;
> +		samsung,power-domain = <&pd_mfc>;
> +		status = "ok";
> +	};


Thanks,
Sylwester
