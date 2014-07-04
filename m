From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 02/10] devicetree: Add generic IOMMU device tree
	bindings
Date: Fri, 4 Jul 2014 06:42:48 +0000
Message-ID: <9ffe3c3871ef4b60a955259bfa0bed6c@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-3-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403815790-8548-3-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
	Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd
	Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Thierry Reding
> Sent: Friday, June 27, 2014 2:20 AM
> To: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
> Stephen Warren; Arnd Bergmann; Will Deacon; Joerg Roedel
> Cc: Olav Haugan; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Grant Grundler; Rhyland
> Klein; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Marc Zyngier; Allen Martin; Paul Walmsley; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Cho KyongHo; Dave Martin; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: [PATCH v3 02/10] devicetree: Add generic IOMMU device tree
> bindings
> 
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
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
>  Documentation/devicetree/bindings/iommu/iommu.txt | 156
> ++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt
> b/Documentation/devicetree/bindings/iommu/iommu.txt
> new file mode 100644
> index 000000000000..f8f03f057156
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -0,0 +1,156 @@
> +This document describes the generic device tree binding for IOMMUs and
> +their master(s).
> +
> +
> +IOMMU device node:
> +==================
> +
> +An IOMMU can provide the following services:
> +
> +* Remap address space to allow devices to access physical memory ranges
> +that
> +  they otherwise wouldn't be capable of accessing.
> +
> +  Example: 32-bit DMA to 64-bit physical addresses
> +
> +* Implement scatter-gather at page level granularity so that the device
> +does
> +  not have to.
> +
> +* Provide system protection against "rogue" DMA by forcing all accesses
> +to go
> +  through the IOMMU and faulting when encountering accesses to unmapped
> +  address regions.
> +
> +* Provide address space isolation between multiple contexts.
> +
> +  Example: Virtualization
> +
> +Device nodes compatible with this binding represent hardware with some
> +of the above capabilities.
> +
> +IOMMUs can be single-master or multiple-master. Single-master IOMMU
> +devices typically have a fixed association to the master device,
> +whereas multiple- master IOMMU devices can translate accesses from more
> than one master.
> +
> +The device tree node of the IOMMU device's parent bus must contain a
> +valid "dma-ranges" property that describes how the physical address
> +space of the IOMMU maps to memory. An empty "dma-ranges" property means
> +that there is a
> +1:1 mapping from IOMMU to memory.
> +
> +Required properties:
> +--------------------
> +- #iommu-cells: The number of cells in an IOMMU specifier needed to
> +encode an
> +  address.
> +
> +Typical values for the above include:
> +- #iommu-cells = <0>: Single master IOMMU devices are not configurable
> +and
> +  therefore no additional information needs to be encoded in the
> specifier.
> +  This may also apply to multiple master IOMMU devices that do not
> +allow the
> +  association of masters to be configured.
> +- #iommu-cells = <1>: Multiple master IOMMU devices may need to be
> +configured
> +  in order to enable translation for a given master. In such cases the
> +single
> +  address cell corresponds to the master device's ID.
> +- #iommu-cells = <4>: Some IOMMU devices allow the DMA window for
> +masters to
> +  be configured. The first cell of the address in this may contain the
> +master
> +  device's ID for example, while the second cell could contain the
> +start of
> +  the DMA window for the given device. The length of the DMA window is
> +given
> +  by the third and fourth cells.
> +
> +
> +IOMMU master node:
> +==================
> +
> +Devices that access memory through an IOMMU are called masters. A
> +device can have multiple master interfaces (to one or more IOMMU
> devices).
> +
> +Required properties:
> +--------------------
> +- iommus: A list of phandle and IOMMU specifier pairs that describe the
> +IOMMU
> +  master interfaces of the device. One entry in the list describes one
> +master
> +  interface of the device.
> +
> +When an "iommus" property is specified in a device tree node, the IOMMU
> +will be used for address translation. If a "dma-ranges" property exists
> +in the device's parent node it will be ignored. An exception to this
> +rule is if the referenced IOMMU is disabled, in which case the
> +"dma-ranges" property of the parent shall take effect.
> +
> +
> +Notes:
> +======
> +
> +One possible extension to the above is to use an "iommus" property
> +along with a "dma-ranges" property in a bus device node (such as PCI
> +host bridges). This can be useful to describe how children on the bus
> +relate to the IOMMU if they are not explicitly listed in the device
> +tree (e.g. PCI devices). However, the requirements of that use-case
> +haven't been fully determined yet. Implementing this is therefore not
> +recommended without further discussion and extension of this binding.
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
> +		iommus = <&/iommu>;
> +	};
> +
> +Multiple-master IOMMU with fixed associations:
> +----------------------------------------------
> +
> +	/* multiple-master IOMMU */
> +	iommu {
> +		/*
> +		 * Masters are statically associated with this IOMMU and
> +		 * address translation is always enabled.
> +		 */
> +		#iommu-cells = <0>;
> +	};
> +
> +	/* static association with IOMMU */
> +	master@1 {
> +		reg = <1>;
> +		iommus = <&/iommu>;
> +	};
> +
> +	/* static association with IOMMU */
> +	master@2 {
> +		reg = <2>;
> +		iommus = <&/iommu>;
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
> +	master {
> +		/* device has master ID 42 in the IOMMU */
> +		iommus = <&/iommu 42>;
> +	};
> +
Master node corresponds to the device node, right? Master ID would correspond to Stream ID? We are already using "iommu-parent" property to link a device to its corresponding IOMMU. We can use the same property instead of using "iommus".

-Varun
