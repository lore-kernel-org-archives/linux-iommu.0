From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 3/8] of: fix size when dma-range is not used
Date: Wed, 28 Jan 2015 10:28:12 -0500
Message-ID: <54C9000C.3040907@ti.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
	<1422392405-32196-4-git-send-email-m-karicheri2@ti.com>
	<54C8C652.8050507@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54C8C652.8050507-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/28/2015 06:21 AM, Robin Murphy wrote:
> Hi Murali,
>
> [sorry, missed replying to yesterday's version]
>
> On 27/01/15 21:00, Murali Karicheri wrote:
>> Fix the dma-range size when the DT attribute is missing. i.e set size to
>> dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask. Also add
>> code to check invalid values of size configured in DT and log error.
>>
>> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> ---
>> drivers/of/device.c | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 2de320d..17504f4 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -105,12 +105,19 @@ void of_dma_configure(struct device *dev, struct
>> device_node *np)
>> ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>> if (ret < 0) {
>> dma_addr = offset = 0;
>> - size = dev->coherent_dma_mask;
>> + size = dev->coherent_dma_mask + 1;
>> } else {
>> offset = PFN_DOWN(paddr - dma_addr);
>> dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>> }
>>
>> + if (is_power_of_2(size + 1))
>> + size = size + 1;
>> + else if (!is_power_of_2(size)) {
>> + dev_err(dev, "invalid size\n");
>> + return;
>> + }
>> +
>
> Couldn't these checks go into the "else" path above? We don't need to
> check the non-DT case, because we know we've just set it to something
> sensible.
Robin,

Sure it can. I was doing flip/flop on the choice and thought it doesn' 
matter either way. Please also repond to Catalin's comment if you have 
any issues so that I can avoid additional spin on this patch.

Thanks

Murali
>
> Robin.
>
>> dev->dma_pfn_offset = offset;
>>
>> coherent = of_dma_is_coherent(np);
>>
>
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
