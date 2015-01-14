From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Wed, 14 Jan 2015 01:24:01 +0100
Message-ID: <54B5B721.4070309@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1417514366.21830.22.camel@collabora.co.uk>
	<54818768.3080303@samsung.com>
	<CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
	<54AC93E0.8010705@samsung.com>
	<54ACFD69.1020500@collabora.co.uk> <54AD0293.70909@samsung.com>
	<54AEB384.2040005@collabora.co.uk> <54B36C5A.6050109@samsung.com>
	<54B3F1B7.7090307@collabora.co.uk> <54B4ABFB.5000501@samsung.com>
	<54B5B5F6.3030607@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54B5B5F6.3030607-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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

On 01/14/2015 01:19 AM, Javier Martinez Canillas wrote:
> 
> I dug further on this issue and found that the cause is that the exynos_mixer
> driver needs some clocks (CLK_HDMI and CLK_SCLK_HDMI) grabbed by exynos_hdmi
> to be kept enabled after hdmi_poweroff (drivers/gpu/drm/exynos/exynos_hdmi.c).
> 
> Otherwise, any access to mixer device registers leads to an imprecise external
> abort error. The following change [0] to the Exynos DRM HDMI driver makes the
> issue to not happen and I can successfully execute:
> 
> # echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> 
> Only not disabling the hdmi clock [1]: is enough but doing so makes sometimes the
> DISP1 power domain disabling fails. It doesn't seem to have side effect though
> since I also see the signal in the HDMI display to go standby and then on again.
> 
> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> # echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> [   63.089080] Power domain disp1-power-domain disable failed
> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> #
> 
> That error message when both clocks are not disabled on hdmi_poweroff() though.
> 

This should be: "That error message is not shown when both clocks are disabled".

Best regards,
Javier
