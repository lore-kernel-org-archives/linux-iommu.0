From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 2/2] drivers: dma-mapping: parse per device reserved mem
 at probe time
Date: Mon, 27 Nov 2017 09:44:20 +0100
Message-ID: <e44416ee-0f33-e310-d881-aaa3edfdf69e@samsung.com>
References: <20171126131346.12532-1-peng.fan@nxp.com>
        <CGME20171126131432epcas4p23145c6f438f7f186545456960f284b91@epcas4p2.samsung.com>
        <20171126131346.12532-2-peng.fan@nxp.com>
        <875c3a8c-a857-823e-0243-487d1dd9bee7@samsung.com>
        <20171127083713.clh6oz5sgere4usq@linux-u7w5.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20171127083713.clh6oz5sgere4usq-MVApIMqXe9XjwJyOrGAgIJjmvxFtTJ+o0e7PPNI6Mm0@public.gmane.org>
Content-language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peng,

On 2017-11-27 09:37, Peng Fan wrote:
> Hi Marek,
>
> On Mon, Nov 27, 2017 at 09:31:00AM +0100, Marek Szyprowski wrote:
>> Hi
>>
>> On 2017-11-26 14:13, Peng Fan wrote:
>>> Invoke of_reserved_mem_device_init at dma_configure, then
>>> there is no need to call of_reserved_mem_device_init in device
>>> specific probe function.
>>>
>>> Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
>> This has been already tried long time ago, without success:
>> http://patches.linaro.org/patch/33558/
> Thanks for the info. I should first search mail list before
> sending out patches.

It doesn't mean that I'm against such idea. I just pointed that I've
already tried. That time, however there was no dma_configure() function
yet, which seems to be better place for of_rmem_device_init().

I would however always call of_dma_configure(), even when reserved mem
node is there. IIRC on ARM64 that function configures dma_ops, without
which no dma is possible at all.

>
> Thanks,
> Peng.
>
>>> ---
>>>    drivers/base/dma-mapping.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>>> index e584eddef0a7..55dca06a7b55 100644
>>> --- a/drivers/base/dma-mapping.c
>>> +++ b/drivers/base/dma-mapping.c
>>> @@ -12,6 +12,7 @@
>>>    #include <linux/export.h>
>>>    #include <linux/gfp.h>
>>>    #include <linux/of_device.h>
>>> +#include <linux/of_reserved_mem.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/vmalloc.h>
>>> @@ -351,7 +352,9 @@ int dma_configure(struct device *dev)
>>>    	}
>>>    	if (dma_dev->of_node) {
>>> -		ret = of_dma_configure(dev, dma_dev->of_node);
>>> +		ret = of_reserved_mem_device_init(dev);
>>> +		if (ret)
>>> +			ret = of_dma_configure(dev, dma_dev->of_node);
>>>    	} else if (has_acpi_companion(dma_dev)) {
>>>    		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
>>>    		if (attr != DEV_DMA_NOT_SUPPORTED)
>>> @@ -367,5 +370,6 @@ int dma_configure(struct device *dev)
>>>    void dma_deconfigure(struct device *dev)
>>>    {
>>>    	of_dma_deconfigure(dev);
>>> +	of_reserved_mem_device_release(dev);
>>>    	acpi_dma_deconfigure(dev);
>>>    }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
