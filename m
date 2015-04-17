From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v5 00/18] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Fri, 17 Apr 2015 18:15:09 +0200
Message-ID: <CABxcv=nNgrtC_reDL3PWOTeUSopataPSHnjhf2Lfu2WwT8m+0g@mail.gmail.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
	<20150204142149.GM3702@8bytes.org>
	<CABxcv=mXENvPHvvN5iOaUBZKORF49RhDs-tL_PBT4Urh54pd0Q@mail.gmail.com>
	<55311D3C.5050300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <55311D3C.5050300@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On Fri, Apr 17, 2015 at 4:48 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
>
> On 2015-04-17 16:33, Javier Martinez Canillas wrote:
>>
>> Hello Marek,
>>
>> On Wed, Feb 4, 2015 at 3:21 PM, Joerg Roedel <joro@8bytes.org> wrote:
>>>
>>> Hi Marek,
>>>
>>> On Fri, Jan 23, 2015 at 04:51:10PM +0100, Marek Szyprowski wrote:
>>>>
>>>> 1. All iommu related patches (with 'iommu: exynos') can be merged to
>>>> iommu tree. They don't have any direct dependencies on the DTS, DRM and
>>>> power domain initialization change - without them the driver will simply
>>>> not initialize, when no exynos,sysmmu nodes are provided in device tree.
>>>>
>>>> Joerg, could you merge those patches?
>>>
>>> Given the previous comments and tests on this patch set I am still
>>> waiting for some Acked-bys and/or Tested-bys on this. Can you collect
>>> these and resend then (probably after the v3.20 merge window)?
>>>
>> I rebased your patches on top of latest linux-next (next-20150415) and
>> tested it on my Exynos5420 Peach Pit. HDMI display is working
>> correctly (both console and X) when CONFIG_DRM_EXYNOS_IOMMU is
>> enabled. I also see that the mixer is attached to the IOMMU domain:
>>
>> exynos-mixer 14450000.mixer: exynos_iommu_attach_device: Attached
>> IOMMU with pgtable 0x6e5e0000
>> ...
>> exynos-sysmmu 14650000.sysmmu: Enabled
>>
>> As I mentioned before [0] on your v4 series, I still have the boot
>> hang when CONFIG_DRM_EXYNOS_FIMD is enabled. You said that the cause
>> is u-boot leaving the FIMD DMA engine enabled and so causing IOMMU
>> page faults on init [1].
>>
>> I tried disabling the display on u-boot but the system hangs remains.
>> But since I do a chain loading using the verified u-boot that comes
>> with the Chromebooks, I don't know if the RO boot-loader is leaving
>> something enabled.
>>
>> In any case since HDMI with sysmmu is working correctly, that issue is
>> orthogonal to your series and can be fixed as a followup so:
>>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
>
> In meantime I've managed to add UART adapter to our Chromebook Snow and
> finally found the issue with FIMD. It was really nasty to debug, because
> it causes a crash with console lock taken in register_framebuffer(), so
> there was no debug/crash message - only complete system freeze. All this

Yeah, that's why I was not able to find the cause yet. No output
message and just a complete system hang.

> was caused by fimd left enabled by bootloader, but with gate clock
> disabled, so any access to its register caused freeze.
>

Awesome, I'm glad that you figured it out.

Interface clocks being gated that are needed to access registers has
bitten us too many times, didn't it? :-)

> I need to cleanup the patches. I will rebase them and send once 4.1rc1 is
> out. I'm sorry that I didn't let you know earlier, but I'm terribly busy
> with other (internal) stuff right now.
>

No worries, I was also busy with other stuff and just took a look at
this issue again today. I hope my branch could save you some effort
for the rebase then.

>> NOTE: Most of the patches don't apply cleanly so I pushed a branch [2]
>> with my conflict resolution so you don't have to do the same. I also
>> did some small changes like using bool instead of int when were
>> assigning it to true and renaming some of the subject lines to match
>> the format used by the subsystem.
>>
>> What I didn't change is to re-order the sysmmu device nodes according
>> to the unit address that was asked by Andreas since the DTS patches
>> are likely to conflict with the work Krzysztof is doing to use labels
>> instead of overriding nodes in Exynos 4 and 5 DTS[i]. So you may need
>> to change those anyways once Krzysztof patches land.
>
>
> Thanks!
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Best regards,
Javier
