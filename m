From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 3/7] doc:bindings:Document for hi655x pmic driver
Date: Thu, 5 Nov 2015 21:34:44 +0800
Message-ID: <1446730488-31930-4-git-send-email-puck.chen@hisilicon.com>
References: <1446730488-31930-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446730488-31930-1-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, haojian.zhuang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add Document for hi655x pmic driver

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 .../regulator/hisilicon,hi655x-regulator.txt       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/hisilicon,hi655x-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/hisilicon,hi655x-regulator.txt b/Documentation/devicetree/bindings/regulator/hisilicon,hi655x-regulator.txt
new file mode 100644
index 0000000..66c6a73
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/hisilicon,hi655x-regulator.txt
@@ -0,0 +1,50 @@
+Hisilicon Hi655x Voltage regulators
+
+Note:
+The hi655x regulator control is managed by hi655x Power IC.
+So the node of this regulator must be child node of hi655x
+pmic node.
+
+The driver uses the regulator core framework, so please also
+take the bindings of regulator.txt for reference.
+
+Required properties:
+- compatible: Must be "hisilicon,hi655x-regulator-pmic";
+- regulator-name: Regulator name in SoC.
+- regulator-min-microvolt: Smallest voltage support.
+- regulator-max-microvolt: Largest voltages support.
+- regulator-initial-mode: Init mode of this regulator.
+- regulator-valid-modes-mask: Valid support mode mask.
+- regulator-off-on-delay: The time wait for power steady
+- regulator-ctrl-regs: Registers offset of control register.
+  In turn with enable disable and status register offset.
+- regulator-ctrl-mask: The control mask of the register.
+- regulator-vset-regs: Voltage set register offset.
+- regulator-vset-mask: voltage set control mask.
+- regulator-n-vol: The num of support voltages.
+- regulator-vset-table: The table of support voltages.
+
+Example:
+        pmic: pmic@f8000000 {
+                compatible = "hisilicon,hi655x-pmic-driver";
+		...
+                ldo2: regulator@a21 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo2";
+                        regulator-min-microvolt = <2500000>;
+                        regulator-max-microvolt = <3200000>;
+                        regulator-valid-modes-mask = <0x02>;
+                        regulator-initial-mode = <0x02>;
+                        regulator-off-on-delay = <120>;
+                        regulator-ctrl-regs = <0x029 0x02a 0x02b>;
+                        regulator-ctrl-mask = <0x1>;
+                        regulator-vset-regs = <0x072>;
+                        regulator-vset-mask = <0x3>;
+                        regulator-n-vol = <8>;
+                        regulator-vset-table  = <2500000>,<2600000>,
+                                                <2700000>,<2800000>,
+                                                <2900000>,<3000000>,
+                                                <3100000>,<3200000>;
+                };
+		...
+	}
-- 
1.9.1
