From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Thu, 08 Jan 2015 17:42:44 +0100
Message-ID: <54AEB384.2040005@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1417514366.21830.22.camel@collabora.co.uk>
	<54818768.3080303@samsung.com>
	<CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
	<54AC93E0.8010705@samsung.com>
	<54ACFD69.1020500@collabora.co.uk> <54AD0293.70909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54AD0293.70909-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gustavo Padovan <gustavo.padovan-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Joonyoung,

On 01/07/2015 10:55 AM, Joonyoung Shim wrote:
>>>
>>> I don't think iommu support and power domain issue are related. I also
>>> get displaying stripes via hdmi but it is just power domain issue
>>> regardless iommu support.
>>>
>>> I observed 8th bit from 0x1445000C register of mixer is set to 1 with
>>> displaying stripes. It means "The graphic layer0 line buffer underflow".
>>> There was same underflow issue on Exynos4 based boards. As Marek said,
>>> because LCD0 power domain was turned off.
>>>
>> 
>> Interesting, thanks a lot for sharing this information.
>>  
>>> I just tried to turn off DISP1 power domain at u-boot and DISP1 power
>>> domain is turned on from kernel hdmi and mixer driver on odroid xu3 
>>> board. As the result, i can see displaying penguin logo from hdmi.
>>>
>> 
>> Can you share the patches you are using to turn on the DISP1 power domain
>> since AFAIU the kernel does not know about the DISP1 power domain after
>> commit d51cad7df871 ("ARM: dts: remove display power domain for exynos5420").
>> 
>> I tried reverting that commit before so the kernel knows about the DISP1
>> power domain and booting with pd_ignore_unused but still had the stripes.
>>  
> 
> I add DISP1 power domain on dts and please refer below patch[0] with
> some modification on hdmi phy(Actually, i think this is not related).
> You also should disable DISP1 power domain from bootloader.
>

Thanks a lot for the patch. With your changes I have some HDMI output on
my Peach Pi. But the HDMI output is broken since the resolution is very
low and the video as a lot of visual artifacts.

In your change you are also adding clock phandles for the pd oscillator
clock and the CLK_MOUT_SW_ACLK200, CLK_MOUT_USER_ACLK200_DISP1 pairs for
the parent input and input clocks of the devices attached to the pd.

And also making changes to the clocks in the clk-exynos5420 driver. Can
you please explain the rationale for those changes? I'm asking because
without your clock changes (only adding the DISP1 pd and making the
devices as consumers), I've HDMI output too but video is even worse. This
[0] is the minimal change I have on top of 3.19-rc3 to have some output.

The docs I've access to, don't have information about the clock hierarchy.
So each time there is a clock issue, I've a hard time to figure out what's
happening.

So there seems to be two issues here, one is the mixer and hdmi modules not
being attached to the DISP1 power domain and another one is the clocks setup
not being correct to have proper HDMI video output.
 
>>> But the problem exists still because it is failed to control on/off of
>>> DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]
>>>

I didn't have this issue when testing your patch against 3.19-rc2. From your
log I see that you are testing on a 3.18.1. So maybe makes sense to test with
the latest kernel version since this HDMI issue qualifies as an 3.19-rc fix?

Since commit 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach completes")
that landed in 3.19-rc1, I see that the power domain is powered on when a
device is attached. So maybe that is what makes a difference here?

>> 
>> Something that is not clear to me is how display panel is working on the
>> Peach boards if this is a power domain issue since according to the manual
>> both the modules used for display (LCD controller and DP) and the modules
>> used for HDMI (MIXER and HDMI) belong to the same power domain (DISP1).
>> 
>
> I don't know about that because i just tested on odroid xu3 board
> without display panel. Hmm, It can be any conditions to success on/off
> power domain e.g. power state of clocks and of on/off order display
> devices.
>

My guess is that this is again clock related. Since if I add the DISP1 pd to
the DTS and make the fimd node as a consumer of the pd, the display panel
works correctly (same than current mainline that doesn't have the node).

But, if I also make the mixer and hdmi nodes as consumer of the DISP1, then
the exynos dp driver's probe function fails as shown in [1]. In this case,
the HDMI output works and I see that the DISP1 power domain is not powered
off so the only thing I can think is that is a clocks issue.

> Is DISP1 power domain disabled on Peach boards to save power, not always
> on?
>

No AFAICT, currently as I mentioned before the DISP1 power domain was removed
from the exynos5420.dtsi. So since the kernel does not know about it, should
be always on. With your patch, it should not be disabled either since it has
devices attached to and I confirmed that is not powered off anymore once all
the attached devices' probe functions have been deferred and retried again.

Thanks a lot for your help and best regards,
Javier

[0]:
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 517e50f6760b..9966fe7bb0ec 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -265,6 +265,11 @@
 		clock-names = "oscclk", "pclk0", "clk0";
 	};
 
+	disp_pd: power-domain@100440C0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440C0 0x20>;
+	};
+
 	msc_pd: power-domain@10044120 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044120 0x20>;
@@ -535,6 +540,7 @@
 	};
 
 	fimd: fimd@14400000 {
+		samsung,power-domain = <&disp_pd>;
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
@@ -710,6 +716,7 @@
 		phy = <&hdmiphy>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
+		samsung,power-domain = <&disp_pd>;
 	};
 
 	hdmiphy: hdmiphy@145D0000 {
@@ -722,6 +729,7 @@
 		interrupts = <0 94 0>;
 		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
+		samsung,power-domain = <&disp_pd>;
 	};
 
 	gsc_0: video-scaler@13e00000 {


[1]:
exynos-dp 145b0000.dp-controller: EDID data does not include any extensions.
exynos-dp 145b0000.dp-controller: EDID Read success!
exynos-dp 145b0000.dp-controller: Link Training Clock Recovery success
exynos-dp 145b0000.dp-controller: Link Training success!
exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
exynos-dp 145b0000.dp-controller: unable to config video
