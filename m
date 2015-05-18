From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Mon, 18 May 2015 15:32:49 +0200
Message-ID: <CABxcv=mT8nVNfm_Ej2CJoRaXYAEGL2D9WmUC1sxCH=sN31sD2w@mail.gmail.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
	<CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
	<5559E88E.9050108@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5559E88E.9050108-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On Mon, May 18, 2015 at 3:26 PM, Marek Szyprowski
<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hello,
>
>
> On 2015-05-11 18:00, Javier Martinez Canillas wrote:
>>
>> Hello Marek,
>>
>> On Mon, May 4, 2015 at 10:15 AM, Marek Szyprowski
>> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>>
>>> Hello Everyone,
>>>
>>> This is yet another attempt to get Exynos SYSMMU driver with integrated
>>> with IOMMU & DMA-mapping subsystems. The main change from previous
>>> version is addition of the patches to define iommu-mapping, which need
>>> to be created during system boot to avoid IOMMU fault by devices, which
>>> has been left enabled by bootloader (i.e. framebuffer displaying slash
>>> screen).
>>>
>>> Patches has been also rebased onto v4.1-rc2 with 'arm: dma-mapping: fix
>>> off-by-one check in arm_setup_iommu_dma_ops' patch applied (see commit
>>> 1424532b2163bf1580f4b1091a5801e12310fac5 on fixes branch in
>>> git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git,
>>> more information:
>>> http://www.spinics.net/lists/arm-kernel/msg414722.html).
>>>
>>> All patches are also available in the following git repository:
>>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
>>> branch v4.1-exynos-iommu.
>>>
>> Thanks for the new series, this time I didn't get a system hang when I
>> enabled both CONFIG_DRM_EXYNOS_FIMD and CONFIG_DRM_EXYNOS_DP on my
>> Exynos5420 Peach Pit Chromebook.
>>
>> The system finished booting and I have both a console on the HDMI and
>> eDP/LVDS displays. But if I try to start X or weston, I again have a
>> completele system hang with no output on the serial console. This
>> works correctly without your IOMMU series.
>>
>> And again disabling CONFIG_DRM_EXYNOS_DP or CONFIG_DRM_EXYNOS_FIMD
>> avoids the system to hang. If I only have CONFIG_DRM_EXYNOS_HDMI
>> enabled, then I can start X with out issues and is displayed correctly
>> in the HDMI output.
>>
>> So it seems your workaround for the boot-loader leaving the FIMD dma
>> engine enabled is not enough? I'm not a graphics person so I can think
>> of the top of my head what could trigger the system hang when X or
>> weston are executed so I wondered if you have any ideas.
>
>
> This means that there are more bugs in Exynos DRM driver. Once Exynos DRM
> driver is probed, the initial iommu domain with identity mapping is
> destroyed
> and Exynos DRM manages it's own iommu domain, so it has nothing to my
> mentioned patch.
>

I see, thanks for the explanation.

> I will try to check this issue.
>

Great, thanks a lot for taking a look.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Best regards,
Javier
