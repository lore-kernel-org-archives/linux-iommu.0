From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
 Exynos SoCs
Date: Mon, 7 Oct 2013 08:44:54 -0500
Message-ID: <CAL_JsqLny8sOgn9y0Tm9-Vq_3YPdtqkr5nTJ67Y0Zx1hDmduNQ@mail.gmail.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Hyunwoong Kim <khw0178.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Keyyoung Park <keyyoung.park@samsung.com>, Subash Patel <supash.ramaswamy@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, Rahul Sharma <rahul.sharma@samsung.com>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 26, 2013 at 6:28 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
>  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
>  5 files changed, 617 insertions(+), 0 deletions(-)
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
> +
> +System MMU is a sort of IOMMU and support identical translation table format to
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
> +- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
> +               Please refer to the following documents:
> +              Documentation/devicetree/bindings/clock/clock-bindings.txt
> +              Documentation/devicetree/bindings/clock/exynos4-clock.txt
> +              Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> +              Optional "master" if the clock to the System MMU is gated by
> +              another gate clock other than "sysmmu". The System MMU driver
> +              sets "master" the parent of "sysmmu".
> +              Exynos4 SoCs, there needs no "master" clocks.
> +              Exynos5 SoCs, some System MMUs must have "master" clocks.
> +- clocks: Required if the System MMU is needed to gate its clock.
> +         Please refer to the documents listed above.
> +- samsung,power-domain: Required if the System MMU is needed to gate its power.
> +         Please refer to the following document:
> +         Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> +
> +Required properties for the master peripheral devices:
> +- iommu: phandles to the System MMUs of the device

You have not addressed my comments from the last version. We do not
need 2 (or more) different ways to describe the connection between
masters and iommu's. Use mmu-masters property here to describe the
connection.

Rob
