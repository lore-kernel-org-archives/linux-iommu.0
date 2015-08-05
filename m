From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Wed, 5 Aug 2015 16:39:33 +0000
Message-ID: <BN1PR0301MB06277FDA6EB34E77B557CA75EA750@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-3-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437670365-20704-3-git-send-email-mark.rutland-5wv7dgnIgG8@public.gmane.org>
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
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mark
Thanks for the patch. Please find my comment inline.

Regards
Varun

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Mark Rutland
> Sent: Thursday, July 23, 2015 10:23 PM
> To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Mark Rutland; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
> marc.zyngier-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org;
> laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org;
> treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
> Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> 
> Currently msi-parent is used by a few bindings to describe the relationship
> between a PCI root complex and a single MSI controller, but this property
> does not have a generic binding document.
> 
> Additionally, msi-parent is insufficient to describe more complex
> relationships between MSI controllers and devices under a root complex,
> where devices may be able to target multiple MSI controllers, or where MSI
> controllers use (non-probeable) sideband information to distinguish devices.
> 
> This patch adds a generic binding for mapping PCI devices to MSI controllers.
> This document covers msi-parent, and a new msi-map property (specific to
> PCI*) which may be used to map devices (identified by their Requester ID) to
> sideband data for each MSI controller that they may target.
> 
> Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-msi.txt | 220
> ++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt
> b/Documentation/devicetree/bindings/pci/pci-msi.txt
> new file mode 100644
> index 0000000..9b3cc81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> @@ -0,0 +1,220 @@
> +This document describes the generic device tree binding for describing
> +the relationship between PCI devices and MSI controllers.
> +
> +Each PCI device under a root complex is uniquely identified by its
> +Requester ID (AKA RID). A Requester ID is a triplet of a Bus number,
> +Device number, and Function number.
> +
> +For the purpose of this document, when treated as a numeric value, a
> +RID is formatted such that:
> +
> +* Bits [15:8] are the Bus number.
> +* Bits [7:3] are the Device number.
> +* Bits [2:0] are the Function number.
> +* Any other bits required for padding must be zero.
> +
> +MSIs may be distinguished in part through the use of sideband data
> +accompanying writes. In the case of PCI devices, this sideband data may
> +be derived from the Requester ID. A mechanism is required to associate
> +a device with both the MSI controllers it can address, and the sideband
> +data that will be associated with its writes to those controllers.
> +
> +For generic MSI bindings, see
> +Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +
> +PCI root complex
> +================
> +
> +Optional properties
> +-------------------
> +
> +- msi-map: Maps a Requester ID to an MSI controller and associated
> +  msi-specifier data. The property is an arbitrary number of tuples of
> +  (rid-base,msi-controller,msi-base,length), where:
[varun] How would we account for hot plug PCI devices and SR-IOV use cases, with the rid base and length?  How do we take in to account for a PCIe bridge, while setting up the requestor ID base and length?

> +
> +  * rid-base is a single cell describing the first RID matched by the entry.
> +
> +  * msi-controller is a single phandle to an MSI controller
> +
> +  * msi-base is an msi-specifier describing the msi-specifier produced for the
> +    first RID matched by the entry.
> +
> +  * length is a single cell describing how many consecutive RIDs are matched
> +    following the rid-base.
> +
> +  Any RID r in the interval [rid-base, rid-base + length) is associated
> + with  the listed msi-controller, with the msi-specifier (r - rid-base + msi-
> base).
> +
> +- msi-map-mask: A mask to be applied to each Requester ID prior to
> +being mapped
> +  to an msi-specifier per the msi-map property.
> +
[varun] Can you please elaborate on a use case, where this would help. 



> +- msi-parent: Describes the MSI parent of the root complex itself.
> +Where
> +  the root complex and MSI controller do not pass sideband data with
> +MSI
> +  writes, this property may be used to describe the MSI controller(s)
> +  used by PCI devices under the root complex, if defined as such in the
> +  binding for the root complex.
> +
> +
> +Example (1)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the MSI controller is
> +		 * the RID, identity-mapped.
> +		 */
> +		msi-map = <0x0 &msi_a 0x0 0x10000>,
> +	};
> +};
> +
> +
> +Example (2)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the MSI controller is
> +		 * the RID, masked to only the device and function bits.
> +		 */
> +		msi-map = <0x0 &msi_a 0x0 0x100>,
> +		msi-map-mask = <0xff>
> +	};
> +};
> +
> +
> +Example (3)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the MSI controller is
> +		 * the RID, but the high bit of the bus number is
> +		 * ignored.
> +		 */
> +		msi-map = <0x0000 &msi 0x0000 0x8000>,
> +			  <0x8000 &msi 0x0000 0x8000>;
> +	};
> +};
> +
> +
> +Example (4)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the MSI controller is
> +		 * the RID, but the high bit of the bus number is
> +		 * negated.
> +		 */
> +		msi-map = <0x0000 &msi 0x8000 0x8000>,
> +			  <0x8000 &msi 0x0000 0x8000>;
> +	};
> +};
> +
> +
> +Example (5)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi_a: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	msi_b: msi-controller@b {
> +		reg = <0xb 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	msi_c: msi-controller@c {
> +		reg = <0xc 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@c {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to MSI controller a is the
> +		 * RID, but the high bit of the bus number is negated.
> +		 * The sideband data provided to MSI controller b is the
> +		 * RID, identity-mapped.
> +		 * MSI controller c is not addressable.
> +		 */
> +		msi-map = <0x0000 &msi_a 0x8000 0x08000>,
> +			  <0x8000 &msi_a 0x0000 0x08000>,
> +			  <0x0000 &msi_b 0x0000 0x10000>;
> +	};
> +};
> --
> 1.9.1
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
