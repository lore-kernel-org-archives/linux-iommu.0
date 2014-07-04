From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/6] iommu/vt-d: move up no_iommu and dmar_disabled check
Date: Fri, 4 Jul 2014 17:28:47 +0800
Message-ID: <53B673CF.2040101@huawei.com>
References: <1400589472-8544-1-git-send-email-wangyijing@huawei.com>
	<1400589472-8544-3-git-send-email-wangyijing@huawei.com>
	<20140704090640.GS26537@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140704090640.GS26537-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index e020dcf..6b71608 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -3948,6 +3948,9 @@ int __init intel_iommu_init(void)
>>  	/* VT-d is required for a TXT/tboot launch, so enforce that */
>>  	force_on = tboot_force_iommu();
>>  
>> +	if (no_iommu || dmar_disabled)
>> +		return ret;
>> +
>>  	if (iommu_init_mempool()) {
>>  		if (force_on)
>>  			panic("tboot: Failed to initialize iommu memory\n");
>> @@ -3974,9 +3977,6 @@ int __init intel_iommu_init(void)
>>  		goto out_free_dmar;
>>  	}
>>  
>> -	if (no_iommu || dmar_disabled)
>> -		goto out_free_dmar;
>> -
>>  	if (list_empty(&dmar_rmrr_units))
>>  		printk(KERN_INFO "DMAR: No RMRR found\n");
> 
> This breaks the kexec case were the old kernel had VT-d enabled and the
> new one disabled. In this case the new kernel might need to disable the
> IOMMUs.

Hi Joerg,
   Thanks for your review and comments! You are right, I didn't consider the kexec case,
I will drop this patch.

Thanks!
Yijing.


> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Thanks!
Yijing
