From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 04/12] of: Add NVIDIA Tegra memory controller binding
Date: Fri,  7 Nov 2014 17:00:55 +0100
Message-ID: <1415376063-17205-5-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The memory controller on NVIDIA Tegra exposes various knobs that can be
used to tune the behaviour of the clients attached to it.

In addition, the memory controller implements an SMMU (IOMMU) which can
translate I/O virtual addresses to physical addresses for clients. This
is useful for scatter-gather operation on devices that don't support it
natively and for virtualization or process separation.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v3:
- add missing clocks and clock-names properties
- add example

 .../memory-controllers/nvidia,tegra-mc.txt         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
new file mode 100644
index 000000000000..f3db93c85eea
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra Memory Controller device tree bindings
+===================================================
+
+Required properties:
+- compatible: Should be "nvidia,tegra<chip>-mc"
+- reg: Physical base address and length of the controller's registers.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - mc: the module's clock input
+- interrupts: The interrupt outputs from the controller.
+- #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
+  the SWGROUP of the master.
+
+This device implements an IOMMU that complies with the generic IOMMU binding.
+See ../iommu/iommu.txt for details.
+
+Example:
+--------
+
+	mc: memory-controller@0,70019000 {
+		compatible = "nvidia,tegra124-mc";
+		reg = <0x0 0x70019000 0x0 0x1000>;
+		clocks = <&tegra_car TEGRA124_CLK_MC>;
+		clock-names = "mc";
+
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+		#iommu-cells = <1>;
+	};
+
+	sdhci@0,700b0000 {
+		compatible = "nvidia,tegra124-sdhci";
+		...
+		iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
+	};
-- 
2.1.3
