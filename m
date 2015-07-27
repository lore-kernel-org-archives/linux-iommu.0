From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Mon, 27 Jul 2015 09:16:01 +0100
Message-ID: <55B5E8C1.4030707@arm.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com> <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437670365-20704-3-git-send-email-mark.rutland-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/07/15 17:52, Mark Rutland wrote:
> Currently msi-parent is used by a few bindings to describe the
> relationship between a PCI root complex and a single MSI controller, but
> this property does not have a generic binding document.
> 
> Additionally, msi-parent is insufficient to describe more complex
> relationships between MSI controllers and devices under a root complex,
> where devices may be able to target multiple MSI controllers, or where
> MSI controllers use (non-probeable) sideband information to distinguish
> devices.
> 
> This patch adds a generic binding for mapping PCI devices to MSI
> controllers. This document covers msi-parent, and a new msi-map property
> (specific to PCI*) which may be used to map devices (identified by their
> Requester ID) to sideband data for each MSI controller that they may
> target.
> 
> Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> new file mode 100644
> index 0000000..9b3cc81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> @@ -0,0 +1,220 @@
> +This document describes the generic device tree binding for describing the
> +relationship between PCI devices and MSI controllers.
> +
> +Each PCI device under a root complex is uniquely identified by its Requester ID
> +(AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> +Function number.
> +
> +For the purpose of this document, when treated as a numeric value, a RID is
> +formatted such that:
> +
> +* Bits [15:8] are the Bus number.
> +* Bits [7:3] are the Device number.
> +* Bits [2:0] are the Function number.
> +* Any other bits required for padding must be zero.
> +
> +MSIs may be distinguished in part through the use of sideband data accompanying
> +writes. In the case of PCI devices, this sideband data may be derived from the
> +Requester ID. A mechanism is required to associate a device with both the MSI
> +controllers it can address, and the sideband data that will be associated with
> +its writes to those controllers.
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
> +  Any RID r in the interval [rid-base, rid-base + length) is associated with
> +  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> +
> +- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> +  to an msi-specifier per the msi-map property.
> +
> +- msi-parent: Describes the MSI parent of the root complex itself. Where
> +  the root complex and MSI controller do not pass sideband data with MSI
> +  writes, this property may be used to describe the MSI controller(s)
> +  used by PCI devices under the root complex, if defined as such in the
> +  binding for the root complex.

Right, this is where I'd expect some details about #msi-cells. Is it
meant to be ignored? The lack of symmetry between the PCI and non-PCI
use cases feels a bit inelegant (not to mention that it precludes having
an unified parser for both cases).

This otherwise looks good to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
