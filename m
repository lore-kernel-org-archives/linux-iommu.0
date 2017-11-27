From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/2] drivers: dma-mapping: parse per device reserved mem at
	probe time
Date: Mon, 27 Nov 2017 16:37:15 +0800
Message-ID: <20171127083713.clh6oz5sgere4usq@linux-u7w5.ap.freescale.net>
References: <20171126131346.12532-1-peng.fan@nxp.com>
	<CGME20171126131432epcas4p23145c6f438f7f186545456960f284b91@epcas4p2.samsung.com>
	<20171126131346.12532-2-peng.fan@nxp.com>
	<875c3a8c-a857-823e-0243-487d1dd9bee7@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <875c3a8c-a857-823e-0243-487d1dd9bee7-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek, 

On Mon, Nov 27, 2017 at 09:31:00AM +0100, Marek Szyprowski wrote:
>Hi
>
>On 2017-11-26 14:13, Peng Fan wrote:
>> Invoke of_reserved_mem_device_init at dma_configure, then
>> there is no need to call of_reserved_mem_device_init in device
>> specific probe function.
>> 
>> Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
>
>This has been already tried long time ago, without success:
>http://patches.linaro.org/patch/33558/

Thanks for the info. I should first search mail list before
sending out patches.

Thanks,
Peng.

>
>> ---
>>   drivers/base/dma-mapping.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>> index e584eddef0a7..55dca06a7b55 100644
>> --- a/drivers/base/dma-mapping.c
>> +++ b/drivers/base/dma-mapping.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/export.h>
>>   #include <linux/gfp.h>
>>   #include <linux/of_device.h>
>> +#include <linux/of_reserved_mem.h>
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>> @@ -351,7 +352,9 @@ int dma_configure(struct device *dev)
>>   	}
>>   	if (dma_dev->of_node) {
>> -		ret = of_dma_configure(dev, dma_dev->of_node);
>> +		ret = of_reserved_mem_device_init(dev);
>> +		if (ret)
>> +			ret = of_dma_configure(dev, dma_dev->of_node);
>>   	} else if (has_acpi_companion(dma_dev)) {
>>   		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
>>   		if (attr != DEV_DMA_NOT_SUPPORTED)
>> @@ -367,5 +370,6 @@ int dma_configure(struct device *dev)
>>   void dma_deconfigure(struct device *dev)
>>   {
>>   	of_dma_deconfigure(dev);
>> +	of_reserved_mem_device_release(dev);
>>   	acpi_dma_deconfigure(dev);
>>   }
>
>Best regards
>-- 
>Marek Szyprowski, PhD
>Samsung R&D Institute Poland
>

-- 
