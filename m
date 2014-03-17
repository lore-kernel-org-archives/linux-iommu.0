From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH v11 12/27] ARM: dts: Add description of System MMU of
 Exynos SoCs
Date: Mon, 17 Mar 2014 09:32:22 +0900
Message-ID: <20140317093222.1e56049853b06bd183c24241@samsung.com>
References: <20140314140649.dc5958f420770af48e2376d9@samsung.com>
 <5322F407.208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5322F407.208@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, 14 Mar 2014 13:20:23 +0100, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On 14.03.2014 06:06, Cho KyongHo wrote:
> > This patch adds dts entries for the System MMU devices found on
> > Exynos4 and Exynos5 SoC series and the System MMU binding
> > documentation.
> >
> > CC: Rob Herring <robherring2@gmail.com>
> > CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >   .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |   86 +++++++
> >   arch/arm/boot/dts/exynos4.dtsi                     |  107 ++++++++
> >   arch/arm/boot/dts/exynos4210.dtsi                  |   23 +-
> >   arch/arm/boot/dts/exynos4x12.dtsi                  |   77 +++++-
> >   arch/arm/boot/dts/exynos5250.dtsi                  |  266 +++++++++++++++++++-
> >   arch/arm/boot/dts/exynos5420.dtsi                  |  205 ++++++++++++++-
> >   6 files changed, 758 insertions(+), 6 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > new file mode 100644
> > index 0000000..e4417bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> > @@ -0,0 +1,86 @@
> > +Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
> > +
> > +Samsung's Exynos architecture contains System MMUs that enables scattered
> > +physical memory chunks visible as a contiguous region to DMA-capable peripheral
> > +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> > +
> > +System MMU is an IOMMU and supports identical translation table format to
> > +ARMv7 translation tables with minimum set of page properties including access
> > +permissions, shareability and security protection. In addition, System MMU has
> > +another capabilities like L2 TLB or block-fetch buffers to minimize translation
> > +latency.
> > +
> > +System MMUs are in many to one relation with peripheral devices, i.e. single
> > +peripheral device might have multiple System MMUs (usually one for each bus
> > +master), but one System MMU can handle transactions from only one peripheral
> > +device. The relation between a System MMU and the peripheral device needs to be
> > +defined in device node of the peripheral device.
> > +
> > +MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
> > +MMUs.
> > +* MFC has one System MMU on its left and right bus.
> > +* FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
> > +  for window 1, 2 and 3.
> > +* M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
> > +  the other System MMU on the write channel.
> > +The drivers must consider how to handle those System MMUs. One of the idea is
> > +to implement child devices or sub-devices which are the client devices of the
> > +System MMU.
> > +
> > +Required properties:
> > +- compatible: Should be one of:
> > +		"samsung,sysmmu-v1"
> > +		"samsung,sysmmu-v2"
> > +		"samsung,sysmmu-v3.1"
> > +		"samsung,sysmmu-v3.2"
> > +		"samsung,sysmmu-v3.3"
> > +
> > +- reg: A tuple of base address and size of System MMU registers.
> > +- interrupt-parent: The phandle of the interrupt controller of System MMU
> > +- interrupts: An interrupt specifier for interrupt signal of System MMU,
> > +	      according to the format defined by a particular interrupt
> > +	      controller.
> > +- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
> > +               Please refer to the following documents:
> > +	       Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +	       Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > +	       Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> > +	       Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> > +	       Optional "master" if the clock to the System MMU is gated by
> > +	       another gate clock other than "sysmmu". The System MMU driver
> > +	       sets "master" the parent of "sysmmu".
> > +	       Exynos4 SoCs, there needs no "master" clockj.
> > +	       Exynos5 SoCs, some System MMUs must have "master" clocks.
> > +- clocks: Required if the System MMU is needed to gate its clock.
> > +	  Please refer to the documents listed above.
> > +- samsung,power-domain: Required if the System MMU is needed to gate its power.
> > +	  Please refer to the following document:
> > +	  Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> > +- mmu-masters: A phandle to device nodes representing the master for which
> > +               the System MMU can provide a translation. Any additional values
> > +	       after the phandle will be ignored because a System MMU never
> > +	       have two or more masters. "#stream-id-cells" specified in the
> > +	       master's node will be also ignored.
> > +	       If more than one phandle is specified, only the first phandle
> > +	       will be treated.
> > +
> > +Examples:
> > +	gsc_0: gsc@13e00000 {
> > +		compatible = "samsung,exynos5-gsc";
> > +		reg = <0x13e00000 0x1000>;
> > +		interrupts = <0 85 0>;
> > +		samsung,power-domain = <&pd_gsc>;
> > +		clocks = <&clock 256>;
> > +		clock-names = "gscl";
> > +	};
> > +
> > +	sysmmu_gsc0: sysmmu@13E80000 {
> > +		compatible = "samsung,exynos4210-sysmmu";
> > +		reg = <0x13E80000 0x1000>;
> > +		interrupt-parent = <&combiner>;
> > +		interrupts = <2 0>;
> > +		clock-names = "sysmmu", "master";
> > +		clocks = <&clock 262>, <&clock 256>;
> > +		samsung,power-domain = <&pd_gsc>;
> > +		mmu-masters = <&gsc_0>;
> > +	};
> 
> Binding documentation should be added in separate patch in front of the 
> series relying on such binding or with the patch adding binding 
> implementation to the driver, so DT maintainers can review the binding 
> and related code easily.
> 
> Changes to dts(i) files should be posted in a separate patch, preferably 
> at the end of the series, when any prerequisites are already available.
> 

Thank you for the advice.

Should the patches related to the change in DT be shown in the following order?
"documentation -> source code change -> DT description"

KyongHo
