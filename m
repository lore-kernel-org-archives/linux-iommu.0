From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/4] of: move of_dma_configure() to device,c to help re-use
Date: Fri, 9 Jan 2015 09:34:50 -0600
Message-ID: <CAL_JsqLG2OQL2TMMrXi4U0PU1vNzgodUehoZwpds5z8JKsB1jQ@mail.gmail.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com>
 <3861625.CJ6m15sZMh@wuerfel> <54AED9EC.1020703@ti.com> <2083932.v1GzgAfexK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2083932.v1GzgAfexK@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 8, 2015 at 4:24 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Thursday 08 January 2015 14:26:36 Murali Karicheri wrote:
>> On 01/08/2015 03:40 AM, Arnd Bergmann wrote:
>> > On Wednesday 07 January 2015 17:37:56 Rob Herring wrote:
>> >> On Wed, Jan 7, 2015 at 12:49 PM, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>  wrote:
>> >>
>> >>> +       ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
>> >>> +       if (ret<  0) {
>> >>> +               dma_addr = offset = 0;
>> >>> +               size = dev->coherent_dma_mask + 1;
>> >>
>> >> If coherent_dma_mask is DMA_BIT_MASK(64), then you will overflow and
>> >> have a size of 0. There may also be a problem when the mask is only
>> >> 32-bit type.
>> >
>> > The mask is always a 64-bit type, it's not optional. But you are right,
>> > the 64-bit mask case is broken, so I guess we have to fix it differently
>> > by always passing the smaller value into arch_setup_dma_ops and
>> > adapting that function instead.
>> Arnd,
>>
>> What is the smaller value you are referring to in the below code?
>> between *dev->dma_mask and size from DT? But overflow can still happen
>> when size is to be calculated in arch_setup_dma_ops() for Non DT case or
>> when DT size is configured to be equivalent of DMA_BIT_MASK(64) + 1. Can
>> we discuss the code change you have in mind when you get a chance?
>
> I meant changing every function that the size values gets passed into
> to take a mask like 0xffffffff instead of a size like 0x100000000, so
> we can represent a 64-bit capable bus correctly.

Or you could special case a size of 0 to mean all/max? I'm not sure if
we need to handle size=0 for other reasons beyond just wrong DT data.

> This means we also need to adapt the value returned from of_dma_get_range.
> A minor complication here is that the DT properties sometimes already
> contain the mask value, in particular when we want to represent a
> full mapping like
>
>         bus {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 dma-ranges = <0 0 0xffffffff>; /* all 4 GB, DMA_BIT_MASK(32) */

This is wrong though, right? The DT should be size. Certainly, this
could be a valid size, but that would not make the mask 0xfffffffe. We
would still want it to be 0xffffffff.

We could do a fixup for these cases adding 1 if bit 0 is set (or not
subtracting 1 if we want the mask).

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
