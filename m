From: Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
Date: Mon, 10 Dec 2018 13:05:44 -0800
Message-ID: <34883ba5-b444-3d37-4d40-9b0a651dd2eb@oracle.com>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>, Dongli Zhang <dongli.zhang@oracle.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On 12/10/18 12:00 PM, Tim Chen wrote:
>> @@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>  	return SWIOTLB_MAP_ERROR;
>>  found:
>> +#ifdef CONFIG_DEBUG_FS
>> +	io_tlb_used += nslots;
>> +#endif
> One nit I have about this patch is there are too many CONFIG_DEBUG_FS.
> 
> For example here, instead of io_tlb_used, we can have a macro defined,
> perhaps something like inc_iotlb_used(nslots).  It can be placed in the
> same section that swiotlb_create_debugfs is defined so there's a single
> place where all the CONFIG_DEBUG_FS stuff is located.
> 
> Then define inc_iotlb_used to be null when we don't have
> CONFIG_DEBUG_FS.
> 

Dongli had removed above ifdef/endif on his next patch, "[PATCH v2 2/2]
swiotlb: checking whether swiotlb buffer is full with io_tlb_used"

Thanks,
Joe
