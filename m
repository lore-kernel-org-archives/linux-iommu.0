From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 7/7] arm64: dts: Add mtcmos and pmic node for hi6220 HiKey
	board
Date: Thu, 5 Nov 2015 21:34:48 +0800
Message-ID: <1446730488-31930-8-git-send-email-puck.chen@hisilicon.com>
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

Add dts node for hi665x pmic and hi6220 mtcmos driver

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Fei Wang <w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 210 ++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..5e0b8260 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,5 +167,215 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		mtcmos {
+			compatible = "hisilicon,hi6220-mtcmos-driver";
+			hisilicon,mtcmos-steady-us = <10>;
+			hisilicon,mtcmos-sc-on-base  = <0xf7800000>;
+			hisilicon,mtcmos-acpu-on-base = <0xf65a0000>;
+
+			g3d_vdd: regulator@a1{
+				regulator-name = "G3D_PD_VDD";
+				regulator-compatible = "mtcmos1";
+				hisilicon,ctrl-regs = <0x830 0x834 0x83c>;
+				hisilicon,ctrl-data = <1 0x1>;
+			};
+
+			soc_med: regulator@a2{
+				regulator-name = "SOC_MED";
+				regulator-compatible = "mtcmos2";
+				hisilicon,ctrl-regs = <0x830 0x834 0x83c>;
+				hisilicon,ctrl-data = <2 0x1>;
+			};
+		};
+	};
+
+	pmic: pmic@f8000000 {
+		compatible = "hisilicon,hi655x-pmic-driver";
+		reg = <0x0 0xf8000000 0x0 0x1000>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		pmic-gpios = <&gpio_pmu_irq_n>;
+		status = "okay";
+		ldo2: regulator@a21 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo2";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-valid-modes-mask = <0x02>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x029 0x02a 0x02b>;
+			regulator-ctrl-mask = <0x1>;
+			regulator-vset-regs = <0x072>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+		};
+		ldo7: regulator@a26 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo7";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-valid-modes-mask = <0x0a>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x029 0x02a 0x02b>;
+			regulator-ctrl-mask = <0x6>;
+			regulator-vset-regs = <0x078>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1800000>,<1850000>,
+						<2850000>,<2900000>,
+						<3000000>,<3100000>,
+						<3200000>,<3300000>;
+		};
+		ldo10: regulator@a29 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo10";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-valid-modes-mask = <0x0a>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <360>;
+			regulator-ctrl-regs = <0x02c 0x02d 0x02e>;
+			regulator-ctrl-mask = <0x1>;
+			regulator-vset-regs = <0x07b>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1800000>,<1850000>,
+						<1900000>,<2750000>,
+						<2800000>,<2850000>,
+						<2900000>,<3000000>;
+		};
+		ldo13: regulator@a32 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo13";
+			regulator-min-microvolt = <1600000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02c 0x02d 0x02e>;
+			regulator-ctrl-mask = <0x4>;
+			regulator-vset-regs = <0x07e>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1600000>,<1650000>,
+						<1700000>,<1750000>,
+						<1800000>,<1850000>,
+						<1900000>,<1950000>;
+		};
+		ldo14: regulator@a33 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo14";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02c 0x02d 0x02e>;
+			regulator-ctrl-mask = <0x5>;
+			regulator-vset-regs = <0x07f>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+		};
+		ldo15: regulator@a34 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo15";
+			regulator-min-microvolt = <1600000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02c 0x02d 0x02e>;
+			regulator-ctrl-mask = <0x6>;
+			regulator-vset-regs = <0x080>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1600000>,<1650000>,
+						<1700000>,<1750000>,
+						<1800000>,<1850000>,
+						<1900000>,<1950000>;
+		};
+		ldo17: regulator@a36 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo17";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02f 0x030 0x031>;
+			regulator-ctrl-mask = <0x0>;
+			regulator-vset-regs = <0x082>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <2500000>,<2600000>,
+						<2700000>,<2800000>,
+						<2900000>,<3000000>,
+						<3100000>,<3200000>;
+		};
+		ldo19: regulator@a38 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo19";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <360>;
+			regulator-ctrl-regs = <0x02f 0x030 0x031>;
+			regulator-ctrl-mask = <0x2>;
+			regulator-vset-regs = <0x084>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1800000>,<1850000>,
+						<1900000>,<2750000>,
+						<2800000>,<2850000>,
+						<2900000>,<3000000>;
+		};
+		ldo21: regulator@a40 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo21";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-always-on;
+			regulator-valid-modes-mask = <0x02>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02f 0x030 0x031>;
+			regulator-ctrl-mask = <0x4>;
+			regulator-vset-regs = <0x086>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <1650000>,<1700000>,
+						<1750000>,<1800000>,
+						<1850000>,<1900000>,
+						<1950000>,<2000000>;
+		};
+		ldo22: regulator@a41 {
+			compatible = "hisilicon,hi655x-regulator-pmic";
+			regulator-name = "ldo22";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-valid-modes-mask = <0x02>;
+			regulator-initial-mode = <0x02>;
+			regulator-off-on-delay = <120>;
+			regulator-ctrl-regs = <0x02f 0x030 0x031>;
+			regulator-ctrl-mask = <0x5>;
+			regulator-vset-regs = <0x087>;
+			regulator-vset-mask = <0x3>;
+			regulator-n-vol = <8>;
+			regulator-vset-table  = <900000>,<1000000>,
+						<1050000>,<1100000>,
+						<1150000>,<1175000>,
+						<1185000>,<1200000>;
+		};
 	};
 };
-- 
1.9.1
