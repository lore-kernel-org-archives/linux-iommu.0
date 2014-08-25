From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 25 Aug 2014 15:13:32 +0800
Message-ID: <53FAE21C.3000603@huawei.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
	<8121916dfcae4c4a9d71377081c082fc@BLUPR03MB566.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8121916dfcae4c4a9d71377081c082fc-GeMU99Gfrru4FpqPz9FowuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joerg
	Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>> +	/* We found some strange devices in HP c7000 and other platforms, they
>> +	 * can not be enumerated by OS, and they did DMA read/write without
>> +	 * driver management. if we open iommu in these platforms, the DMA
>> read/write
>> +	 * will be blocked by IOMMU hardware. Currently, we only create identity
>> mapping
>> +	 * for the devices in OS. To fix this, add iommu=pt_force=segment:busnum
>> to
>> +	 * force to do identity mapping for the specific bus.
>> +	 */
>> +	if (iommu_pt_force_bus >= 0 && iommu_pt_force_bus >= 0) {
> 
> iommu_pt_force_bus twice?

Sharp eyes! Sorry, it should be if (iommu_pt_force_domain >= 0 && iommu_pt_force_bus >= 0).

Thanks for your good catch!

Thanks!
Yijing.

> 
> Thanks
> -Bharat
> 
>> +		int found = 0;
>> +
>> +		iommu = NULL;
>> +		for_each_active_iommu(iommu, drhd) {
>> +			if (iommu_pt_force_domain != drhd->segment)
>> +				continue;
>> +
>> +			for_each_active_dev_scope(drhd->devices, drhd->devices_cnt,
>> i, dev) {
>> +				if (!dev_is_pci(dev))
>> +					continue;
>> +
>> +				pdev = to_pci_dev(dev);
>> +				if (pdev->bus->number == iommu_pt_force_bus ||
>> +						(pdev->subordinate
>> +						 && pdev->subordinate->number <=
>> iommu_pt_force_bus
>> +						 && pdev->subordinate->busn_res.end >=
>> iommu_pt_force_bus)) {
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
>> +				domain_context_mapping_one(si_domain, iommu,
>> iommu_pt_force_bus,
>> +						i,  hw ? CONTEXT_TT_PASS_THROUGH :
>> +						CONTEXT_TT_MULTI_LEVEL);
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> --
>> 1.7.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> .
> 


-- 
Thanks!
Yijing
