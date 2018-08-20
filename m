From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Date: Mon, 20 Aug 2018 14:12:09 -0500
Message-ID: <20180820191209.GA28618@bogus>
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180818155430.5586-7-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver hasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. In a result

As a result...

> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT by introducing a new required property,
> the memory clock. Adding the new clock property also puts the tegra20-mc
> binding in line with the bindings of the later Tegra generations.

I don't understand this part. It looks to me like you are breaking 
compatibility. The driver failing to probe with an old DT is okay?

OS's like OpenSUSE use new DTs with older kernel versions, so you should 
consider how to not break them as well. I guess if all this is optional 
or has been unused, then there shouldn't be a problem.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 -----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 23 ++++++++++++++-----
>  2 files changed, 17 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> deleted file mode 100644
> index 099d9362ebc1..000000000000
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -NVIDIA Tegra 20 GART
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-gart"
> -- reg: Two pairs of cells specifying the physical address and size of
> -  the memory controller registers and the GART aperture respectively.
> -
> -Example:
> -
> -	gart {
> -		compatible = "nvidia,tegra20-gart";
> -		reg = <0x7000f024 0x00000018	/* controller registers */
> -		       0x58000000 0x02000000>;	/* GART aperture */
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> index 7d60a50a4fa1..1564df89392a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> @@ -2,25 +2,36 @@ NVIDIA Tegra20 MC(Memory Controller)
>  
>  Required properties:
>  - compatible : "nvidia,tegra20-mc"
> -- reg : Should contain 2 register ranges(address and length); see the
> -  example below. Note that the MC registers are interleaved with the
> -  GART registers, and hence must be represented as multiple ranges.
> +- reg : Should contain 2 register ranges: physical base address and length of
> +  the controller's registers and the GART aperture respectively.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - mc: the module's clock input
>  - interrupts : Should contain MC General interrupt.
>  - #reset-cells : Should be 1. This cell represents memory client module ID.
>    The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>
>    or in the TRM documentation.
> +- #iommu-cells: Should be 0. This cell represents the number of cells in an
> +  IOMMU specifier needed to encode an address. GART supports only a single
> +  address space that is shared by all devices, therefore no additional
> +  information needed for the address encoding.
>  
>  Example:
>  	mc: memory-controller@7000f000 {
>  		compatible = "nvidia,tegra20-mc";
> -		reg = <0x7000f000 0x024
> -		       0x7000f03c 0x3c4>;
> -		interrupts = <0 77 0x04>;
> +		reg = <0x7000f000 0x400		/* controller registers */
> +		       0x58000000 0x02000000>;	/* GART aperture */
> +		clocks = <&tegra_car TEGRA20_CLK_MC>;
> +		clock-names = "mc";
> +		interrupts = <GIC_SPI 77 0x04>;
>  		#reset-cells = <1>;
> +		#iommu-cells = <0>;
>  	};
>  
>  	video-codec@6001a000 {
>  		compatible = "nvidia,tegra20-vde";
>  		...
>  		resets = <&mc TEGRA20_MC_RESET_VDE>;
> +		iommus = <&mc>;
>  	};
> -- 
> 2.18.0
> 
