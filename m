From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 11 Aug 2014 16:36:48 +0800
Message-ID: <53E880A0.3040702@huawei.com>
References: <1407725674-27271-1-git-send-email-wangyijing@huawei.com>
	<1407732187.9800.11.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407732187.9800.11.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>>  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
>>  
>> @@ -146,6 +148,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size, void *vaddr,
>>   */
>>  static __init int iommu_setup(char *p)
>>  {
>> +	char *end;
>>  	iommu_merge = 1;
>>  
>>  	if (!p)
>> @@ -192,6 +195,11 @@ static __init int iommu_setup(char *p)
>>  #endif
>>  		if (!strncmp(p, "pt", 2))
>>  			iommu_pass_through = 1;
>> +		if (!strncmp(p, "pt_force=", 9)) {
>> +			iommu_pass_through = 1;
>> +			iommu_pt_force_domain = simple_strtol(p+9, &end, 0);
>> +			iommu_pt_force_bus = simple_strtol(end+1, NULL, 0);
> 
> Documentation/kernel-parameters.txt?

Oh, I missed it, I will update it if other guys think the patch is the right fix to the issue later.

> 
>> +		}
>>  
>>  		gart_parse_options(p);
>>  
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index d1f5caa..49757f1 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2705,6 +2705,47 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
>>  				return ret;
>>  		}
>>  
>> +	/* We found some strange devices in HP c7000 and other platforms that
>> +	 * can not be enumerated by OS, but they did DMA read/write without
>> +	 * driver management, so we should create the pt mapping for these
>> +	 * devices to avoid DMA errors. Add iommu=pt_force=segment:busnum to
>> +	 * force to do pt context mapping in the bus number.
>> +	 */
> 
> So best case with this patch is that the user needs to discover that
> this option exists, figure out the undocumented parameters, be running
> on VT-d, permanently add a kernel commandline option, and never have any
> intention of assigning the device to userspace or a VM...

Hmmm, we can add some detection code in dmar fault process functions, and print
some useful messages.

> 
> Can't we handle this with the DMA alias quirks that are now in 3.17?  Or
> can the vendor fix this with a firmware update?  This device behavior is
> really quite broken for this kind of server class product.  Thanks,

Currently, I don't know how many devices have this issue. So I'm not sure
the vendor fix is a proper way to fix it. Alex, sorry, I don't understand
the firmware update to fix it? Do you mean updating the device EEPROM firmware ?

Thanks!
Yijing.


> 
> Alex
> 
>> +	if (iommu_pt_force_bus >= 0 && iommu_pt_force_bus >= 0) {
>> +		int found = 0;
>> +
>> +		iommu = NULL;
>> +		for_each_active_iommu(iommu, drhd) {
>> +			if (iommu_pt_force_domain != drhd->segment)
>> +				continue;
>> +
>> +			for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
>> +				if (!dev_is_pci(dev))
>> +					continue;
>> +
>> +				pdev = to_pci_dev(dev);
>> +				if (pdev->bus->number == iommu_pt_force_bus ||
>> +						(pdev->subordinate
>> +						 && pdev->subordinate->number <= iommu_pt_force_bus
>> +						 && pdev->subordinate->busn_res.end >= iommu_pt_force_bus)) {
>> +					found = 1;
>> +					break;
>> +				}
>> +			}
>> +
>> +			if (drhd->include_all) {
>> +				found = 1;
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (found && iommu)
>> +			for (i = 0; i < 256; i++)
>> +				domain_context_mapping_one(si_domain, iommu, iommu_pt_force_bus,
>> +						i,  hw ? CONTEXT_TT_PASS_THROUGH :
>> +						CONTEXT_TT_MULTI_LEVEL);
>> +	}
>> +
>>  	return 0;
>>  }
>>  
> 
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing
