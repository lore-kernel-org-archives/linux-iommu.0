From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Wed, 07 Jan 2015 18:55:31 +0900
Message-ID: <54AD0293.70909@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <54ACFD69.1020500@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linaro-mm-sig@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Javier,

On 01/07/2015 06:33 PM, Javier Martinez Canillas wrote:
> Hello Joonyoung,
> 
> On 01/07/2015 03:03 AM, Joonyoung Shim wrote:
>> On 01/06/2015 06:49 PM, Javier Martinez Canillas wrote:
>>>
>>> Also I tried forcing the kernel to not disable unused power domains by
>>> passing the pd_ignore_unused parameter to the kernel command line. I
>>> see on the kernel log a "genpd: Not disabling unused power domains"
>>> message but HDMI output still has the stripes that Sjoerd mentioned.
>>> Do you know if Exynos DRM HDMI in mainline is supposed to work without
>>> SysMMU / IOMMU support?
>>>
>>
>> I don't think iommu support and power domain issue are related. I also
>> get displaying stripes via hdmi but it is just power domain issue
>> regardless iommu support.
>>
>> I observed 8th bit from 0x1445000C register of mixer is set to 1 with
>> displaying stripes. It means "The graphic layer0 line buffer underflow".
>> There was same underflow issue on Exynos4 based boards. As Marek said,
>> because LCD0 power domain was turned off.
>>
> 
> Interesting, thanks a lot for sharing this information.
>  
>> I just tried to turn off DISP1 power domain at u-boot and DISP1 power
>> domain is turned on from kernel hdmi and mixer driver on odroid xu3 
>> board. As the result, i can see displaying penguin logo from hdmi.
>>
> 
> Can you share the patches you are using to turn on the DISP1 power domain
> since AFAIU the kernel does not know about the DISP1 power domain after
> commit d51cad7df871 ("ARM: dts: remove display power domain for exynos5420").
> 
> I tried reverting that commit before so the kernel knows about the DISP1
> power domain and booting with pd_ignore_unused but still had the stripes.
>  

I add DISP1 power domain on dts and please refer below patch[0] with
some modification on hdmi phy(Actually, i think this is not related).
You also should disable DISP1 power domain from bootloader.

>> But the problem exists still because it is failed to control on/off of
>> DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]
>>
> 
> Something that is not clear to me is how display panel is working on the
> Peach boards if this is a power domain issue since according to the manual
> both the modules used for display (LCD controller and DP) and the modules
> used for HDMI (MIXER and HDMI) belong to the same power domain (DISP1).
> 

I don't know about that because i just tested on odroid xu3 board
without display panel. Hmm, It can be any conditions to success on/off
power domain e.g. power state of clocks and of on/off order display
devices.

Is DISP1 power domain disabled on Peach boards to save power, not always
on?

> Or am I misunderstanding something? 
> 
> Thanks a lot for your help and best regards,
> Javier
> 

Thanks.

[0]:
---
 arch/arm/boot/dts/exynos5420.dtsi      | 10 ++++++++++
 drivers/clk/samsung/clk-exynos5420.c   |  4 ++--
 drivers/gpu/drm/exynos/exynos_hdmi.c   |  8 ++------
 include/dt-bindings/clock/exynos5420.h |  2 ++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8617a03..ff9ad4a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -270,6 +270,14 @@
 		reg = <0x10044120 0x20>;
 	};
 
+	disp1_pd: power-domain@100440C0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440C0 0x20>;
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK200>,
+			<&clock CLK_MOUT_USER_ACLK200_DISP1>;
+		clock-names = "oscclk", "pclk0", "clk0";
+	};
+
 	pinctrl_0: pinctrl@13400000 {
 		compatible = "samsung,exynos5420-pinctrl";
 		reg = <0x13400000 0x1000>;
@@ -704,6 +712,7 @@
 			"sclk_hdmiphy", "mout_hdmi";
 		phy = <&hdmiphy>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
+		samsung,power-domain = <&disp1_pd>;
 		status = "disabled";
 	};
 
@@ -717,6 +726,7 @@
 		interrupts = <0 94 0>;
 		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
+		samsung,power-domain = <&disp1_pd>;
 	};
 
 	gsc_0: video-scaler@13e00000 {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 848d602..52ba0e6 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -635,7 +635,7 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 			SRC_TOP3, 0, 1),
 	MUX(0, "mout_user_aclk400_mscl", mout_user_aclk400_mscl_p,
 			SRC_TOP3, 4, 1),
-	MUX(0, "mout_user_aclk200_disp1", mout_user_aclk200_disp1_p,
+	MUX(CLK_MOUT_USER_ACLK200_DISP1, "mout_user_aclk200_disp1", mout_user_aclk200_disp1_p,
 			SRC_TOP3, 8, 1),
 	MUX(0, "mout_user_aclk200_fsys2", mout_user_aclk200_fsys2_p,
 			SRC_TOP3, 12, 1),
@@ -693,7 +693,7 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 			SRC_TOP10, 0, 1),
 	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
 			SRC_TOP10, 4, 1),
-	MUX(0, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
+	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p, SRC_TOP10, 8, 1),
 	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
 			SRC_TOP10, 12, 1),
 	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 563a19e..f3cdf80 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1664,7 +1664,6 @@ static void hdmi_mode_apply(struct hdmi_context *hdata)
 
 static void hdmiphy_conf_reset(struct hdmi_context *hdata)
 {
-	u8 buffer[2];
 	u32 reg;
 
 	clk_disable_unprepare(hdata->res.sclk_hdmi);
@@ -1672,11 +1671,8 @@ static void hdmiphy_conf_reset(struct hdmi_context *hdata)
 	clk_prepare_enable(hdata->res.sclk_hdmi);
 
 	/* operation mode */
-	buffer[0] = 0x1f;
-	buffer[1] = 0x00;
-
-	if (hdata->hdmiphy_port)
-		i2c_master_send(hdata->hdmiphy_port, buffer, 2);
+	hdmiphy_reg_writeb(hdata, HDMIPHY_MODE_SET_DONE,
+				HDMI_PHY_ENABLE_MODE_SET);
 
 	if (hdata->type == HDMI_TYPE13)
 		reg = HDMI_V13_PHY_RSTOUT;
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 8dc0913..15b9bb2 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -204,6 +204,8 @@
 #define CLK_MOUT_MAUDIO0	643
 #define CLK_MOUT_USER_ACLK333	644
 #define CLK_MOUT_SW_ACLK333	645
+#define CLK_MOUT_USER_ACLK200_DISP1	646
+#define CLK_MOUT_SW_ACLK200	647
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
1.9.1
