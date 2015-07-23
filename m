From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] Generic PCI MSI + IOMMU topology bindings
Date: Thu, 23 Jul 2015 17:52:42 +0100
Message-ID: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

Currently we have no generic/standard mechanisms for describing the
relationship between PCI root complexes and other components which may be
required to make them usable, specifically IOMMUs and MSI controllers.

There is an existing binding for IOMMUs, and there is a de-facto standard for
referring to MSI controllers, but the generic portion of these can only
describe a relationship with a root complex as opposed to a device under a root
complex. This falls apart where IOMMUs and MSI controllers may distinguish
individual devices based on non-probeable information.

This series adds a generic "glue" bindings for describing the relationship
between root complexes, IOMMUs, and MSI controllers. The existing de-facto
binding for MSI controllers is formalised, along with a (backwards compatible)
extension necessary for describing contemporary MSI controllers which make use
of (non-probeable) sideband data.

Thanks,
Mark.

Mark Rutland (3):
  Docs: dt: add generic MSI bindings
  Docs: dt: Add PCI MSI map bindings
  Docs: dt: add PCI IOMMU map bindings

 .../bindings/interrupt-controller/msi.txt          | 135 +++++++++++++
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++++++++++++++
 Documentation/devicetree/bindings/pci/pci-msi.txt  | 220 +++++++++++++++++++++
 3 files changed, 526 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
