From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Wed, 14 Jan 2015 01:19:02 +0100
Message-ID: <54B5B5F6.3030607@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com> <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com> <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk> <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk> <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk> <54B4ABFB.5000501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54B4ABFB.5000501@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linaro-mm-sig@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hello Joonyoung,

On 01/13/2015 06:24 AM, Joonyoung Shim wrote:
>> 
>> Yes, I was not able to trigger that by running modetest but by turning off
>> my HDMI monitor and then turning it on again. When the monitor is turned
>> on then I see a "Power domain power-domain disable failed" and the imprecise
>> external abort error.
>> 
>> I had to disable CONFIG_DRM_EXYNOS_DP in order to trigger though and that
>> is why I was not able to reproduce it before.
>> 
>> I think though that this is a separate issue of the HDMI not working since
>> power domains should be able to have many consumers devices and I see that
>> other power domains are used that way.
>> 
> 
> OK, we need more investigation.
>

I dug further on this issue and found that the cause is that the exynos_mixer
driver needs some clocks (CLK_HDMI and CLK_SCLK_HDMI) grabbed by exynos_hdmi
to be kept enabled after hdmi_poweroff (drivers/gpu/drm/exynos/exynos_hdmi.c).

Otherwise, any access to mixer device registers leads to an imprecise external
abort error. The following change [0] to the Exynos DRM HDMI driver makes the
issue to not happen and I can successfully execute:

# echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
# echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank

Only not disabling the hdmi clock [1]: is enough but doing so makes sometimes the
DISP1 power domain disabling fails. It doesn't seem to have side effect though
since I also see the signal in the HDMI display to go standby and then on again.

# echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
# echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
[   63.089080] Power domain disp1-power-domain disable failed
# echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
#

That error message when both clocks are not disabled on hdmi_poweroff() though.

I tried different things like set parent of mixer clock to hdmi clock instead
of aclk200_disp1 or make the Exynos DRM mixer driver to grab the hdmi clock
from  DT and prepare_enable from mixer_poweron() but in all cases the same
imprecise external abort error was triggered by mixer_poweron() trying to access
the mixer registers.

Any ideas?

Thanks a lot and best regards,
Javier

[0]:
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 5765a161abdd..0887911cfdd5 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2084,8 +2084,8 @@ static void hdmi_poweroff(struct exynos_drm_display *display)
 
        cancel_delayed_work(&hdata->hotplug_work);
 
-       clk_disable_unprepare(res->sclk_hdmi);
-       clk_disable_unprepare(res->hdmi);
 
        /* reset pmu hdmiphy control bit to disable hdmiphy */
        regmap_update_bits(hdata->pmureg, PMU_HDMI_PHY_CONTROL,


[1]:
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 5765a161abdd..628bff96d543 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -2085,7 +2085,7 @@ static void hdmi_poweroff(struct exynos_drm_display *display)
        cancel_delayed_work(&hdata->hotplug_work);
 
        clk_disable_unprepare(res->sclk_hdmi);
-       clk_disable_unprepare(res->hdmi);
 
        /* reset pmu hdmiphy control bit to disable hdmiphy */
        regmap_update_bits(hdata->pmureg, PMU_HDMI_PHY_CONTROL,
