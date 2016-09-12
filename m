From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 01/22] Docs: dt: add PCI IOMMU map bindings
Date: Mon, 12 Sep 2016 17:13:39 +0100
Message-ID: <78de747525b995011b7af6e23c484041f08e303d.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

The existing IOMMU bindings are able to specify the relationship between
masters and IOMMUs, but they are insufficient for describing the general
case of hotpluggable busses such as PCI where the set of masters is not
known until runtime, and the relationship between masters and IOMMUs is
a property of the integration of the system.

This patch adds a generic binding for mapping PCI devices to IOMMUs,
using a new iommu-map property (specific to PCI*) which may be used to
map devices (identified by their Requester ID) to sideband data for the
IOMMU which they master through.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
new file mode 100644
index 000000000000..56c829621b9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
@@ -0,0 +1,171 @@
+This document describes the generic device tree binding for describing the
+relationship between PCI(e) devices and IOMMU(s).
+
+Each PCI(e) device under a root complex is uniquely identified by its Requester
+ID (AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
+Function number.
+
+For the purpose of this document, when treated as a numeric value, a RID is
+formatted such that:
+
+* Bits [15:8] are the Bus number.
+* Bits [7:3] are the Device number.
+* Bits [2:0] are the Function number.
+* Any other bits required for padding must be zero.
+
+IOMMUs may distinguish PCI devices through sideband data derived from the
+Requester ID. While a given PCI device can only master through one IOMMU, a
+root complex may split masters across a set of IOMMUs (e.g. with one IOMMU per
+bus).
+
+The generic 'iommus' property is insufficient to describe this relationship,
+and a mechanism is required to map from a PCI device to its IOMMU and sideband
+data.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+
+PCI root complex
+================
+
+Optional properties
+-------------------
+
+- iommu-map: Maps a Requester ID to an IOMMU and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (rid-base,iommu,iommu-base,length).
+
+  Any RID r in the interval [rid-base, rid-base + length) is associated with
+  the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
+
+- iommu-map-mask: A mask to be applied to each Requester ID prior to being
+  mapped to an iommu-specifier per the iommu-map property.
+
+
+Example (1)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	iommu: iommu@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * The sideband data provided to the IOMMU is the RID,
+		 * identity-mapped.
+		 */
+		iommu-map = <0x0 &iommu 0x0 0x10000>;
+	};
+};
+
+
+Example (2)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	iommu: iommu@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * The sideband data provided to the IOMMU is the RID with the
+		 * function bits masked out.
+		 */
+		iommu-map = <0x0 &iommu 0x0 0x10000>;
+		iommu-map-mask = <0xfff8>;
+	};
+};
+
+
+Example (3)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	iommu: iommu@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * The sideband data provided to the IOMMU is the RID,
+		 * but the high bits of the bus number are flipped.
+		 */
+		iommu-map = <0x0000 &iommu 0x8000 0x8000>,
+			    <0x8000 &iommu 0x0000 0x8000>;
+	};
+};
+
+
+Example (4)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	iommu_a: iommu@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	iommu_b: iommu@b {
+		reg = <0xb 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	iommu_c: iommu@c {
+		reg = <0xc 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * Devices with bus number 0-127 are mastered via IOMMU
+		 * a, with sideband data being RID[14:0].
+		 * Devices with bus number 128-255 are mastered via
+		 * IOMMU b, with sideband data being RID[14:0].
+		 * No devices master via IOMMU c.
+		 */
+		iommu-map = <0x0000 &iommu_a 0x0000 0x8000>,
+			    <0x8000 &iommu_b 0x0000 0x8000>;
+	};
+};
-- 
2.8.1.dirty
