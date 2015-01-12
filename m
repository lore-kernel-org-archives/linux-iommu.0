From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Mon, 12 Jan 2015 17:09:27 +0100
Message-ID: <54B3F1B7.7090307@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1417514366.21830.22.camel@collabora.co.uk>
	<54818768.3080303@samsung.com>
	<CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
	<54AC93E0.8010705@samsung.com>
	<54ACFD69.1020500@collabora.co.uk> <54AD0293.70909@samsung.com>
	<54AEB384.2040005@collabora.co.uk> <54B36C5A.6050109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54B36C5A.6050109-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Gustavo Padovan <gustavo.padovan-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Joonyoung,

On 01/12/2015 07:40 AM, Joonyoung Shim wrote:
>> And also making changes to the clocks in the clk-exynos5420 driver. Can
>> you please explain the rationale for those changes? I'm asking because
>> without your clock changes (only adding the DISP1 pd and making the
>> devices as consumers), I've HDMI output too but video is even worse. This
>> [0] is the minimal change I have on top of 3.19-rc3 to have some output.
>> 
> 
> I just refer below patches,
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/34576
> 
> But i'm not sure whether DISP1 power domain is same case with MFC power domain.
>

Thanks a lot for sharing those patches, now your changes are much more
clear to me.

>> 
>> So there seems to be two issues here, one is the mixer and hdmi modules not
>> being attached to the DISP1 power domain and another one is the clocks setup
>> not being correct to have proper HDMI video output.
>>  
> 
> Hmm, i can see normal hdmi output still from latest upstream
> kernel(3.19-rc4) with my kernel changes and u-boot changes(DISP1 power
> domain disable) of prior mail on odroid xu3 board.
>

I thought you said on another email that after commit 2ed127697eb1 which
landed on 3.19-rc1 you had bad HDMI output?

In your changes, it was missing the SW_ACLK_400_DISP1 and USER_ACLK_400_DISP1
clock mux outputs that goes to internal buses in the DISP1. Adding IDs for
these in the exynos5420 clock driver and to the parent and input clock paris
list in the DISP1 power domain gives me a good HDMI output on 3.19-rc2.

Also, the SW_ACLK_300_DISP1 and USER_ACLK_300_DISP1 are needed for the FIMD
parent and input clock respectively. Adding those to the clocks list of the
DISP1 power domain gives me working display + HDMI on my Exynos5800 Peach Pi.

These are the changes I have now [0]. Please let me know what you think.

>> 
>> I didn't have this issue when testing your patch against 3.19-rc2. From your
>> log I see that you are testing on a 3.18.1. So maybe makes sense to test with
>> the latest kernel version since this HDMI issue qualifies as an 3.19-rc fix?
>> 
>> Since commit 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach completes")
>> that landed in 3.19-rc1, I see that the power domain is powered on when a
>> device is attached. So maybe that is what makes a difference here?
>> 
>
> I'm not sure, but i get same error results from 3.19-rc4. Did you test
> using exynos drm driver? I used modetest of libdrm
>

Yes, I was not able to trigger that by running modetest but by turning off
my HDMI monitor and then turning it on again. When the monitor is turned
on then I see a "Power domain power-domain disable failed" and the imprecise
external abort error.

I had to disable CONFIG_DRM_EXYNOS_DP in order to trigger though and that
is why I was not able to reproduce it before.

I think though that this is a separate issue of the HDMI not working since
power domains should be able to have many consumers devices and I see that
other power domains are used that way.

Best regards,
Javier

[0]:
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0ac5e0810e97..53b0a03843f2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -270,6 +270,19 @@
 		reg = <0x10044120 0x20>;
 	};
 
+	disp1_pd: power-domain@100440C0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440C0 0x20>;
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK200>,
+			<&clock CLK_MOUT_USER_ACLK200_DISP1>,
+			<&clock CLK_MOUT_SW_ACLK300>,
+			<&clock CLK_MOUT_USER_ACLK300_DISP1>,
+			<&clock CLK_MOUT_SW_ACLK400>,
+			<&clock CLK_MOUT_USER_ACLK400_DISP1>;
+		clock-names = "oscclk", "pclk0", "clk0",
+			      "pclk1", "clk1", "pclk2", "clk2";
+	};
+
 	pinctrl_0: pinctrl@13400000 {
 		compatible = "samsung,exynos5420-pinctrl";
 		reg = <0x13400000 0x1000>;
@@ -537,6 +550,7 @@
 	fimd: fimd@14400000 {
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
+		samsung,power-domain = <&disp1_pd>;
 	};
 
 	adc: adc@12D10000 {
@@ -710,6 +724,7 @@
 		phy = <&hdmiphy>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
+		samsung,power-domain = <&disp1_pd>;
 	};
 
 	hdmiphy: hdmiphy@145D0000 {
@@ -722,6 +737,7 @@
 		interrupts = <0 94 0>;
 		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
+		samsung,power-domain = <&disp1_pd>;
 	};
 
 	gsc_0: video-scaler@13e00000 {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 848d602efc06..07d666cc6a29 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -635,8 +635,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 			SRC_TOP3, 0, 1),
 	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX(0, "mout_user_aclk200_disp1", mout_user_aclk200_disp1_p,
-			SRC_TOP3, 8, 1),
+	MUX(CLK_MOUT_USER_ACLK200_DISP1, "mout_user_aclk200_disp1",
+			mout_user_aclk200_disp1_p, SRC_TOP3, 8, 1),
 	MUX(0, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
 	MUX(0, "mout_user_aclk400_wcore", mout_user_aclk400_wcore_p,
@@ -663,8 +663,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(CLK_MOUT_USER_ACLK333, "mout_user_aclk333", mout_user_aclk333_p,
 			SRC_TOP4, 28, 1),
 
-	MUX(0, "mout_user_aclk400_disp1", mout_user_aclk400_disp1_p,
-			SRC_TOP5, 0, 1),
+	MUX(CLK_MOUT_USER_ACLK400_DISP1, "mout_user_aclk400_disp1",
+			mout_user_aclk400_disp1_p, SRC_TOP5, 0, 1),
 	MUX(0, "mout_user_aclk66_psgen", mout_user_aclk66_peric_p,
 			SRC_TOP5, 4, 1),
 	MUX(0, "mout_user_aclk333_g2d", mout_user_aclk333_g2d_p,
@@ -675,8 +675,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 			SRC_TOP5, 16, 1),
 	MUX(0, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
-	MUX(0, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
-			SRC_TOP5, 24, 1),
+	MUX(CLK_MOUT_USER_ACLK300_DISP1, "mout_user_aclk300_disp1",
+			mout_user_aclk300_disp1_p, SRC_TOP5, 24, 1),
 	MUX(0, "mout_user_aclk300_gscl", mout_user_aclk300_gscl_p,
 			SRC_TOP5, 28, 1),
 
@@ -693,7 +693,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 			SRC_TOP10, 0, 1),
 	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
 			SRC_TOP10, 4, 1),
-	MUX(0, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p,
+			SRC_TOP10, 8, 1),
 	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
 	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
@@ -717,8 +718,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(CLK_MOUT_SW_ACLK333, "mout_sw_aclk333", mout_sw_aclk333_p,
 			SRC_TOP11, 28, 1),
 
-	MUX(0, "mout_sw_aclk400_disp1", mout_sw_aclk400_disp1_p,
-			SRC_TOP12, 4, 1),
+	MUX(CLK_MOUT_SW_ACLK400, "mout_sw_aclk400_disp1",
+			mout_sw_aclk400_disp1_p, SRC_TOP12, 4, 1),
 	MUX(0, "mout_sw_aclk333_g2d", mout_sw_aclk333_g2d_p,
 			SRC_TOP12, 8, 1),
 	MUX(0, "mout_sw_aclk266_g2d", mout_sw_aclk266_g2d_p,
@@ -726,8 +727,8 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_sw_aclk_g3d", mout_sw_aclk_g3d_p, SRC_TOP12, 16, 1),
 	MUX(0, "mout_sw_aclk300_jpeg", mout_sw_aclk300_jpeg_p,
 			SRC_TOP12, 20, 1),
-	MUX(0, "mout_sw_aclk300_disp1", mout_sw_aclk300_disp1_p,
-			SRC_TOP12, 24, 1),
+	MUX(CLK_MOUT_SW_ACLK300, "mout_sw_aclk300_disp1",
+			mout_sw_aclk300_disp1_p, SRC_TOP12, 24, 1),
 	MUX(0, "mout_sw_aclk300_gscl", mout_sw_aclk300_gscl_p,
 			SRC_TOP12, 28, 1),
 
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 8dc0913f1775..99da0d117a7d 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -204,6 +204,12 @@
 #define CLK_MOUT_MAUDIO0	643
 #define CLK_MOUT_USER_ACLK333	644
 #define CLK_MOUT_SW_ACLK333	645
+#define CLK_MOUT_USER_ACLK200_DISP1	646
+#define CLK_MOUT_SW_ACLK200	647
+#define CLK_MOUT_USER_ACLK300_DISP1     648
+#define CLK_MOUT_SW_ACLK300     649
+#define CLK_MOUT_USER_ACLK400_DISP1     650
+#define CLK_MOUT_SW_ACLK400     651
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
