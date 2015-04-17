From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 00/18] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Fri, 17 Apr 2015 16:48:28 +0200
Message-ID: <55311D3C.5050300@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
	<20150204142149.GM3702@8bytes.org>
	<CABxcv=mXENvPHvvN5iOaUBZKORF49RhDs-tL_PBT4Urh54pd0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CABxcv=mXENvPHvvN5iOaUBZKORF49RhDs-tL_PBT4Urh54pd0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-04-17 16:33, Javier Martinez Canillas wrote:
> Hello Marek,
>
> On Wed, Feb 4, 2015 at 3:21 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> Hi Marek,
>>
>> On Fri, Jan 23, 2015 at 04:51:10PM +0100, Marek Szyprowski wrote:
>>> 1. All iommu related patches (with 'iommu: exynos') can be merged to
>>> iommu tree. They don't have any direct dependencies on the DTS, DRM and
>>> power domain initialization change - without them the driver will simply
>>> not initialize, when no exynos,sysmmu nodes are provided in device tree.
>>>
>>> Joerg, could you merge those patches?
>> Given the previous comments and tests on this patch set I am still
>> waiting for some Acked-bys and/or Tested-bys on this. Can you collect
>> these and resend then (probably after the v3.20 merge window)?
>>
> I rebased your patches on top of latest linux-next (next-20150415) and
> tested it on my Exynos5420 Peach Pit. HDMI display is working
> correctly (both console and X) when CONFIG_DRM_EXYNOS_IOMMU is
> enabled. I also see that the mixer is attached to the IOMMU domain:
>
> exynos-mixer 14450000.mixer: exynos_iommu_attach_device: Attached
> IOMMU with pgtable 0x6e5e0000
> ...
> exynos-sysmmu 14650000.sysmmu: Enabled
>
> As I mentioned before [0] on your v4 series, I still have the boot
> hang when CONFIG_DRM_EXYNOS_FIMD is enabled. You said that the cause
> is u-boot leaving the FIMD DMA engine enabled and so causing IOMMU
> page faults on init [1].
>
> I tried disabling the display on u-boot but the system hangs remains.
> But since I do a chain loading using the verified u-boot that comes
> with the Chromebooks, I don't know if the RO boot-loader is leaving
> something enabled.
>
> In any case since HDMI with sysmmu is working correctly, that issue is
> orthogonal to your series and can be fixed as a followup so:
>
> Tested-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

In meantime I've managed to add UART adapter to our Chromebook Snow and
finally found the issue with FIMD. It was really nasty to debug, because
it causes a crash with console lock taken in register_framebuffer(), so
there was no debug/crash message - only complete system freeze. All this
was caused by fimd left enabled by bootloader, but with gate clock
disabled, so any access to its register caused freeze.

I need to cleanup the patches. I will rebase them and send once 4.1rc1 is
out. I'm sorry that I didn't let you know earlier, but I'm terribly busy
with other (internal) stuff right now.

> NOTE: Most of the patches don't apply cleanly so I pushed a branch [2]
> with my conflict resolution so you don't have to do the same. I also
> did some small changes like using bool instead of int when were
> assigning it to true and renaming some of the subject lines to match
> the format used by the subsystem.
>
> What I didn't change is to re-order the sysmmu device nodes according
> to the unit address that was asked by Andreas since the DTS patches
> are likely to conflict with the work Krzysztof is doing to use labels
> instead of overriding nodes in Exynos 4 and 5 DTS[i]. So you may need
> to change those anyways once Krzysztof patches land.

Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
