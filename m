From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/mediatek: select ARM_DMA_USE_IOMMU
Date: Mon, 29 Feb 2016 11:22:24 +0000
Message-ID: <56D429F0.7010409@arm.com>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
	<56D41F74.8010408@arm.com> <2734684.OJWJHS6snX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2734684.OJWJHS6snX@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/02/16 10:53, Arnd Bergmann wrote:
> On Monday 29 February 2016 10:37:40 Robin Murphy wrote:
>> Hi Arnd,
>>
>> On 29/02/16 09:19, Arnd Bergmann wrote:
>>> The newly added Mediatek IOMMU driver uses the IOMMU_DMA infrastructure,
>>> but unlike other such drivers, it does not select 'ARM_DMA_USE_IOMMU',
>>> which is a prerequisite, leading to a link error:
>>>
>>> warning: (MTK_IOMMU) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT && NEED_SG_DMA_LENGTH)
>>
>> Going off on a tangent, is it actually right for that to depend on a
>> NEED_* symbol, or should that really be a select instead?
>
> ARM_DMA_USE_IOMMU gets this right, it selects NEED_SG_DMA_LENGTH as it
> actually needs it.
>
> The IOMMU_DMA symbol is a bit strange, and the dependency can probably
> get dropped altogether, but at least here it told us what went wrong.

IOMMU_DMA uses sg_dma_len() unconditionally all over the place, hence 
the "dependency". Thanks for the clarification; fix sent.

>>> drivers/iommu/built-in.o: In function `iommu_put_dma_cookie':
>>> mtk_iommu.c:(.text+0x11fe): undefined reference to `put_iova_domain'
>>> drivers/iommu/built-in.o: In function `iommu_dma_init_domain':
>>> mtk_iommu.c:(.text+0x1316): undefined reference to `init_iova_domain'
>>> drivers/iommu/built-in.o: In function `__iommu_dma_unmap':
>>> mtk_iommu.c:(.text+0x1380): undefined reference to `find_iova'
>>>
>>> This adds the same select that the other drivers have. On a related
>>> note, I wonder if we should just always select ARM_DMA_USE_IOMMU
>>> whenever any IOMMU driver is enabled. Are there any cases where
>>> we would enable an IOMMU but not use it?
>>
>> You could use one solely for VFIO without caring about DMA ops - I think
>> that's mostly how ARM SMMUs are being used in practice at the moment -
>> but DMA-focused 'media' IOMMUs vastly outnumber 'virtualisation' IOMMUs
>> on ARM, so it would probably make sense. We already have the equivalent
>> "select IOMMU_DMA if IOMMU_SUPPORT" on arm64.
>
> Ok.
>
>>> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
>>> ---
>>>    drivers/iommu/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index b325954cf8f8..ea0998921702 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -341,6 +341,7 @@ config MTK_IOMMU
>>>    	bool "MTK IOMMU Support"
>>>    	depends on ARM || ARM64
>>>    	depends on ARCH_MEDIATEK || COMPILE_TEST
>>> +	select ARM_DMA_USE_IOMMU
>>
>> If going down this route, I'd be inclined to add an "if ARM" there, just
>> for clarity.
>
> That would run into the NEED_SG_DMA_LENGTH problem on other architectures
> that don't already set it, right?

Sorry, I'm lost - wouldn't "depends on ARM || ARM64" make other 
architectures moot? arm64 already has NEED_SG_DMA_LENGTH=y by default.

Robin.
