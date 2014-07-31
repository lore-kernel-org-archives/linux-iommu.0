From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 11:54:19 +0100
Message-ID: <20140731105419.GC22994@leverpostej>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406803383-11601-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 31, 2014 at 11:43:03AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Reviewed-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This looks good to me, and you've adressed the only comments I had, so:

Reviewed-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks for putting this together!

Mark.

> ---
> Changes in v5:
> - clarify comment about dma-ranges vs. IOMMU regarding a device's
>   disabled state
> - use proper DTS syntax reference absolute nodes for phandles
> - clarify the meaning of the #iommu-cells = <0> example
> - remove confusing (and unnecessary) #address-cells and #size-cells from
>   multi-master windowed IOMMU example and clarify the meaning of DMA
>   window
> 
> Changes in v4:
> - clarify that disabling an IOMMU DT node may not disable translation
> - be more explicit that examples are only examples
> - add multi-ID master example
> 
> Changes in v3:
> - use #iommu-cells instead of #address-cells/#size-cells
> - drop optional iommu-names property
> 
> Changes in v2:
> - add notes about "dma-ranges" property (drop note from commit message)
> - document priorities of "iommus" property vs. "dma-ranges" property
> - drop #iommu-cells in favour of #address-cells and #size-cells
> - remove multiple-master device example
> 
>  Documentation/devicetree/bindings/iommu/iommu.txt | 182 ++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> new file mode 100644
> index 000000000000..5a8b4624defc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -0,0 +1,182 @@
> +This document describes the generic device tree binding for IOMMUs and their
> +master(s).
> +
> +
> +IOMMU device node:
> +==================
> +
> +An IOMMU can provide the following services:
> +
> +* Remap address space to allow devices to access physical memory ranges that
> +  they otherwise wouldn't be capable of accessing.
> +
> +  Example: 32-bit DMA to 64-bit physical addresses
> +
> +* Implement scatter-gather at page level granularity so that the device does
> +  not have to.
> +
> +* Provide system protection against "rogue" DMA by forcing all accesses to go
> +  through the IOMMU and faulting when encountering accesses to unmapped
> +  address regions.
> +
> +* Provide address space isolation between multiple contexts.
> +
> +  Example: Virtualization
> +
> +Device nodes compatible with this binding represent hardware with some of the
> +above capabilities.
> +
> +IOMMUs can be single-master or multiple-master. Single-master IOMMU devices
> +typically have a fixed association to the master device, whereas multiple-
> +master IOMMU devices can translate accesses from more than one master.
> +
> +The device tree node of the IOMMU device's parent bus must contain a valid
> +"dma-ranges" property that describes how the physical address space of the
> +IOMMU maps to memory. An empty "dma-ranges" property means that there is a
> +1:1 mapping from IOMMU to memory.
> +
> +Required properties:
> +--------------------
> +- #iommu-cells: The number of cells in an IOMMU specifier needed to encode an
> +  address.
> +
> +The meaning of the IOMMU specifier is defined by the device tree binding of
> +the specific IOMMU. Below are a few examples of typical use-cases:
> +
> +- #iommu-cells = <0>: Single master IOMMU devices are not configurable and
> +  therefore no additional information needs to be encoded in the specifier.
> +  This may also apply to multiple master IOMMU devices that do not allow the
> +  association of masters to be configured. Note that an IOMMU can by design
> +  be multi-master yet only expose a single master in a given configuration.
> +  In such cases the number of cells will usually be 1 as in the next case.
> +- #iommu-cells = <1>: Multiple master IOMMU devices may need to be configured
> +  in order to enable translation for a given master. In such cases the single
> +  address cell corresponds to the master device's ID. In some cases more than
> +  one cell can be required to represent a single master ID.
> +- #iommu-cells = <4>: Some IOMMU devices allow the DMA window for masters to
> +  be configured. The first cell of the address in this may contain the master
> +  device's ID for example, while the second cell could contain the start of
> +  the DMA window for the given device. The length of the DMA window is given
> +  by the third and fourth cells.
> +
> +Note that these are merely examples and real-world use-cases may use different
> +definitions to represent their individual needs. Always refer to the specific
> +IOMMU binding for the exact meaning of the cells that make up the specifier.
> +
> +
> +IOMMU master node:
> +==================
> +
> +Devices that access memory through an IOMMU are called masters. A device can
> +have multiple master interfaces (to one or more IOMMU devices).
> +
> +Required properties:
> +--------------------
> +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> +  master interfaces of the device. One entry in the list describes one master
> +  interface of the device.
> +
> +When an "iommus" property is specified in a device tree node, the IOMMU will
> +be used for address translation. If a "dma-ranges" property exists in the
> +device's parent node it will be ignored. An exception to this rule is if the
> +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> +parent shall take effect. Note that merely disabling a device tree node does
> +not guarantee that the IOMMU is really disabled since the hardware may not
> +have a means to turn off translation. But it is invalid in such cases to
> +disable the IOMMU's device tree node in the first place because it would
> +prevent any driver from properly setting up the translations.
> +
> +
> +Notes:
> +======
> +
> +One possible extension to the above is to use an "iommus" property along with
> +a "dma-ranges" property in a bus device node (such as PCI host bridges). This
> +can be useful to describe how children on the bus relate to the IOMMU if they
> +are not explicitly listed in the device tree (e.g. PCI devices). However, the
> +requirements of that use-case haven't been fully determined yet. Implementing
> +this is therefore not recommended without further discussion and extension of
> +this binding.
> +
> +
> +Examples:
> +=========
> +
> +Single-master IOMMU:
> +--------------------
> +
> +	iommu {
> +		#iommu-cells = <0>;
> +	};
> +
> +	master {
> +		iommus = <&{/iommu}>;
> +	};
> +
> +Multiple-master IOMMU with fixed associations:
> +----------------------------------------------
> +
> +	/* multiple-master IOMMU */
> +	iommu {
> +		/*
> +		 * Masters are statically associated with this IOMMU and share
> +		 * the same address translations because the IOMMU does not
> +		 * have sufficient information to distinguish between masters.
> +		 *
> +		 * Consequently address translation is always on or off for
> +		 * all masters at any given point in time.
> +		 */
> +		#iommu-cells = <0>;
> +	};
> +
> +	/* static association with IOMMU */
> +	master@1 {
> +		reg = <1>;
> +		iommus = <&{/iommu}>;
> +	};
> +
> +	/* static association with IOMMU */
> +	master@2 {
> +		reg = <2>;
> +		iommus = <&{/iommu}>;
> +	};
> +
> +Multiple-master IOMMU:
> +----------------------
> +
> +	iommu {
> +		/* the specifier represents the ID of the master */
> +		#iommu-cells = <1>;
> +	};
> +
> +	master@1 {
> +		/* device has master ID 42 in the IOMMU */
> +		iommus = <&{/iommu} 42>;
> +	};
> +
> +	master@2 {
> +		/* device has master IDs 23 and 24 in the IOMMU */
> +		iommus = <&{/iommu} 23>, <&{/iommu} 24>;
> +	};
> +
> +Multiple-master IOMMU with configurable DMA window:
> +---------------------------------------------------
> +
> +	/ {
> +		iommu {
> +			/*
> +			 * One cell for the master ID and one cell for the
> +			 * address of the DMA window. The length of the DMA
> +			 * window is encoded in two cells.
> +			 *
> +			 * The DMA window is the range addressable by the
> +			 * master (i.e. the I/O virtual address space).
> +			 */
> +			#iommu-cells = <4>;
> +		};
> +
> +		master {
> +			/* master ID 42, 4 GiB DMA window starting at 0 */
> +			iommus = <&{/iommu}  42  0  0x1 0x0>;
> +		};
> +	};
> -- 
> 2.0.3
> 
> 
