From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 3/7] of: fix size when dma-range is not used
Date: Fri, 6 Feb 2015 09:54:23 -0500
Message-ID: <54D4D59F.6050408@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
	<1423173179-10227-4-git-send-email-m-karicheri2@ti.com>
	<20150206143812.GB20549@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150206143812.GB20549@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/06/2015 09:38 AM, Catalin Marinas wrote:
> On Thu, Feb 05, 2015 at 09:52:55PM +0000, Murali Karicheri wrote:
>> Fix the dma-range size when the DT attribute is missing. i.e  set size to
>> dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask. Also add
>> code to check invalid values of size configured in DT and log error.
>>
>> Cc: Joerg Roedel<joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Cc: Grant Likely<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Rob Herring<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Cc: Will Deacon<will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Russell King<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> Cc: Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>
>> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/of/device.c |   17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 2de320d..314c8a9 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -105,9 +105,24 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>   	ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
>>   	if (ret<  0) {
>>   		dma_addr = offset = 0;
>> -		size = dev->coherent_dma_mask;
>> +		size = dev->coherent_dma_mask + 1;
>>   	} else {
>>   		offset = PFN_DOWN(paddr - dma_addr);
>> +
>> +		/*
>> +		 * Add a work around to treat the size as mask + 1 in case
>> +		 * it is defined in DT as a mask.
>> +		 */
>> +		if (size&  1) {
>> +			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
>> +				 size);
>> +			size = size + 1;
>> +		}
>> +
>> +		if (!size) {
>> +			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
>> +			return;
>> +		}
>
> Would it make sense to set coherent_dma_mask to 0 here to make this more
> noticeable? It can be done together with the mask calculation from size.
>
I guess you are the following in the code.

if (!size) {
		dev->coherent_dma_mask = 0;
		dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
		return;
}

Not sure how this is going to help and how this get handled by the 
caller and subsequent logic. Probably it will cause probe to fail, with 
some helpful error code. Need to try this out. Will do before sending my 
size based dma mask patch later today.

Murali

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
