From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 18/18] iommu: exynos: add callback for initializing
	devices from device tree
Date: Fri, 23 Jan 2015 17:15:43 +0100
Message-ID: <54C273AF.1010404@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
	<1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
	<CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
	<54C2415A.3020508@samsung.com>
	<CABxcv=nX22+1VcA038yyLJz7dUN-tk9-kWTpSB-FeyLxVeRmZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CABxcv=nX22+1VcA038yyLJz7dUN-tk9-kWTpSB-FeyLxVeRmZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Javier,

On 2015-01-23 14:48, Javier Martinez Canillas wrote:
> On Fri, Jan 23, 2015 at 1:40 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> +
>>>> +       list_add_tail(&data->owner_node, &owner->clients);
>>> This is the line that causes the kernel to hang, if I comment the
>>> list_add_tail() call then the kernel boots.
>>>
>>> I checked that neither data nor owner are NULL and that the
>>> owner->clients list_head is initialized. Do you have any ideas what
>>> could be happening?
>>
>> This is really strange. However the hang is definitely not caused by
>> adding the controller to the list, but rather the fact that it is later
>> being initialized, probably in exynos_iommu_attach_device().
>>
> Yes, I knew adding to the list was not the issue but a side effect of
> being in the list. I'm not familiar with Exynos sysmmu/iommu to figure
> out though.
>
>> Just a quick question - does bootloader on Exynos5420 Peach Pit sets
>> any image on the display?
>>
> Yes u-boot does initialize the display, I see the boot messages and
> have an u-boot prompt.
>
>> If so then we will get IOMMU page fault on init (DMA engine of FIMD is
>> left enabled from bootloader) and such case is not yet handled.
>> Besides that I have no idea for any other reason for such failure.
>>
> I see, that's a reasonable explanation and in fact your patch makes at
> least the kernel to start booting.
>
>> To check if this is caused by io page fault, please temporarily add the
>> following hack:
>> --->8---
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 7864797609b3..5e70cf7eb31b 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -2011,6 +2011,9 @@ static bool arm_setup_iommu_dma_ops(struct device
>> *dev, u64 dma_base, u64 size,
>>           return false;
>>       }
>>
>> +    iommu_map(mapping->domain, 0x40000000, 0x40000000, 0x80000000,
>> +          IOMMU_READ | IOMMU_WRITE);
>> +
>>       if (arm_iommu_attach_device(dev, mapping)) {
> The kernel still hangs but the boot does indeed go further. Here is my
> boot log [0] although I couldn't find an evident cause.

Frankly, this freeze looks really strange, because there is no error message
or any other failure indicator.

Thanks for testing the above hack. It confirmed that the previous boot 
failure
was caused by display left enabled in bootloader. Such configuration is 
not yet
supported, although I will do my best so find how to add support for it. 
For the
time being - please don't enable IOMMU support on Exynos5420 Peach Pit. It
shouldn't be a big issue, because IOMMU support was already non-functional
all the time on Exynos platform.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
