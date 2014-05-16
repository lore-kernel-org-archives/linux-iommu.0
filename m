From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 16 May 2014 14:23:18 +0200
Message-ID: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This commit introduces a generic device tree binding for IOMMU devices.
Only a very minimal subset is described here, but it is enough to cover
the requirements of both the Exynos System MMU and Tegra SMMU as
discussed here:

    https://lkml.org/lkml/2014/4/27/346

More advanced functionality such as the dma-ranges property can easily
be added in a backwards-compatible way. In the absence of a dma-ranges
property it should be safe to default to the whole address space.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 109 ++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
new file mode 100644
index 000000000000..2d67b52b656e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -0,0 +1,109 @@
+This document describes the generic device tree binding for IOMMUs and their
+master(s).
+
+
+IOMMU device node:
+==================
+
+An IOMMU can provide the following services:
+
+* Remap address space to allow devices to access physical memory ranges that
+  they otherwise wouldn't be capable of accessing.
+
+  Example: 32-bit DMA to 64-bit physical addresses
+
+* Implement scatter-gather at page level granularity so that the device does
+  not have to.
+
+* Provide system protection against "rogue" DMA by forcing all accesses to go
+  through the IOMMU and faulting when encountering accesses to unmapped
+  address regions.
+
+* Provide address space isolation between multiple contexts.
+
+  Example: Virtualization
+
+Device nodes compatible with this binding represent hardware with some of the
+above capabilities.
+
+IOMMUs can be single-master or multiple-master. Single-master IOMMU devices
+typically have a fixed association to the master device, whereas multiple-
+master IOMMU devices can translate accesses from more than one master.
+
+Required properties:
+--------------------
+- #iommu-cells: The number of cells in an IOMMU specifier. The meaning of the
+  cells is defined by the binding for the IOMMU device.
+
+  Typical values include:
+  * 0: Single-master IOMMU devices are often not configurable, therefore the
+    specifying doesn't need to encode any information and can be empty.
+
+  * 1: Multiple-master IOMMU devices need to know for which master they should
+    enable translation. Typically the single cell in the specifier corresponds
+    to the master device's ID.
+
+
+IOMMU master node:
+==================
+
+Devices that access memory through an IOMMU are called masters. A device can
+have multiple master interfaces (to one or more IOMMU devices).
+
+Required properties:
+--------------------
+- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
+  master interfaces of the device. One entry in the list describes one master
+  interface of the device.
+
+Optional properties:
+--------------------
+- iommu-names: A list of names identifying each entry in the iommus property.
+
+
+Examples:
+=========
+
+Single-master IOMMU:
+--------------------
+
+	iommu {
+		#iommu-cells = <0>;
+	};
+
+	master {
+		iommu = <&/iommu>;
+	};
+
+Multi-master IOMMU:
+-------------------
+
+	iommu {
+		/* the specifier represents the ID of the master */
+		#iommu-cells = <1>;
+	};
+
+	master {
+		/* device has master ID 42 in the IOMMU */
+		iommu = <&/iommu 42>;
+	};
+
+Multi-master device:
+--------------------
+
+	/* single-master IOMMU */
+	iommu@1 {
+		#iommu-cells = <0>;
+	};
+
+	/* multi-master IOMMU */
+	iommu@2 {
+		/* the specifier represents the ID of the master */
+		#iommu-cells = <1>;
+	};
+
+	/* device with two master interfaces */
+	master {
+		iommus = <&/iommu@1>,    /* master of the single-master IOMMU */
+			 <&/iommu@2 42>; /* ID 42 in multi-master IOMMU */
+	};
-- 
1.9.2
