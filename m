Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA21C47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:17:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8862613D3
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8862613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8493040160;
	Thu, 27 May 2021 11:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RXFrKzUQuuBt; Thu, 27 May 2021 11:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68646400E0;
	Thu, 27 May 2021 11:17:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F166C000D;
	Thu, 27 May 2021 11:17:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97D37C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85D7F60817
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xf8Fri8xoWLQ for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 11:16:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 399BD607E5
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:16:59 +0000 (UTC)
Received: from dggeml755-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrQBt0d7xz1BFQ6;
 Thu, 27 May 2021 19:12:22 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggeml755-chm.china.huawei.com (10.1.199.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 19:16:57 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 19:16:56 +0800
Subject: Re: [RFC PATCH v3 2/8] vfio/type1: Add a page fault handler
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-3-lushenming@huawei.com>
 <20210518125837.6de73631.alex.williamson@redhat.com>
 <e7e8562f-44a7-92e5-2c4c-974fa7c6cb84@huawei.com>
 <20210524161135.61deaa7a@x1.home.shazbot.org>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <fb2384a1-2036-0d67-9955-ed56b4bc4d13@huawei.com>
Date: Thu, 27 May 2021 19:16:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210524161135.61deaa7a@x1.home.shazbot.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Robin
 Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021/5/25 6:11, Alex Williamson wrote:
> On Fri, 21 May 2021 14:38:52 +0800
> Shenming Lu <lushenming@huawei.com> wrote:
> 
>> On 2021/5/19 2:58, Alex Williamson wrote:
>>> On Fri, 9 Apr 2021 11:44:14 +0800
>>> Shenming Lu <lushenming@huawei.com> wrote:
>>>   
>>>> VFIO manages the DMA mapping itself. To support IOPF (on-demand paging)
>>>> for VFIO (IOMMU capable) devices, we add a VFIO page fault handler to
>>>> serve the reported page faults from the IOMMU driver.
>>>>
>>>> Signed-off-by: Shenming Lu <lushenming@huawei.com>
>>>> ---
>>>>  drivers/vfio/vfio_iommu_type1.c | 114 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 114 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 45cbfd4879a5..ab0ff60ee207 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -101,6 +101,7 @@ struct vfio_dma {
>>>>  	struct task_struct	*task;
>>>>  	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>>>>  	unsigned long		*bitmap;
>>>> +	unsigned long		*iopf_mapped_bitmap;
>>>>  };
>>>>  
>>>>  struct vfio_batch {
>>>> @@ -141,6 +142,16 @@ struct vfio_regions {
>>>>  	size_t len;
>>>>  };
>>>>  
>>>> +/* A global IOPF enabled group list */
>>>> +static struct rb_root iopf_group_list = RB_ROOT;
>>>> +static DEFINE_MUTEX(iopf_group_list_lock);
>>>> +
>>>> +struct vfio_iopf_group {
>>>> +	struct rb_node		node;
>>>> +	struct iommu_group	*iommu_group;
>>>> +	struct vfio_iommu	*iommu;
>>>> +};
>>>> +
>>>>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>>>  					(!list_empty(&iommu->domain_list))
>>>>  
>>>> @@ -157,6 +168,10 @@ struct vfio_regions {
>>>>  #define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
>>>>  #define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
>>>>  
>>>> +#define IOPF_MAPPED_BITMAP_GET(dma, i)	\
>>>> +			      ((dma->iopf_mapped_bitmap[(i) / BITS_PER_LONG]	\
>>>> +			       >> ((i) % BITS_PER_LONG)) & 0x1)  
>>>
>>>
>>> Can't we just use test_bit()?  
>>
>> Yeah, we can use it.
>>
>>>
>>>   
>>>> +
>>>>  #define WAITED 1
>>>>  
>>>>  static int put_pfn(unsigned long pfn, int prot);
>>>> @@ -416,6 +431,34 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Helper functions for iopf_group_list
>>>> + */
>>>> +static struct vfio_iopf_group *
>>>> +vfio_find_iopf_group(struct iommu_group *iommu_group)
>>>> +{
>>>> +	struct vfio_iopf_group *iopf_group;
>>>> +	struct rb_node *node;
>>>> +
>>>> +	mutex_lock(&iopf_group_list_lock);
>>>> +
>>>> +	node = iopf_group_list.rb_node;
>>>> +
>>>> +	while (node) {
>>>> +		iopf_group = rb_entry(node, struct vfio_iopf_group, node);
>>>> +
>>>> +		if (iommu_group < iopf_group->iommu_group)
>>>> +			node = node->rb_left;
>>>> +		else if (iommu_group > iopf_group->iommu_group)
>>>> +			node = node->rb_right;
>>>> +		else
>>>> +			break;
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&iopf_group_list_lock);
>>>> +	return node ? iopf_group : NULL;
>>>> +}  
>>>
>>> This looks like a pretty heavy weight operation per DMA fault.
>>>
>>> I'm also suspicious of this validity of this iopf_group after we've
>>> dropped the locking, the ordering of patches makes this very confusing.  
>>
>> My thought was to include the handling of DMA faults completely in the type1
>> backend by introducing the vfio_iopf_group struct. But it seems that introducing
>> a struct with an unknown lifecycle causes more problems...
>> I will use the path from vfio-core as in the v2 for simplicity and validity.
>>
>> Sorry for the confusing, I will reconstruct the series later. :-)
>>
>>>   
>>>> +
>>>>  static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>>>>  {
>>>>  	struct mm_struct *mm;
>>>> @@ -3106,6 +3149,77 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>>>>  	return -EINVAL;
>>>>  }
>>>>  
>>>> +/* VFIO I/O Page Fault handler */
>>>> +static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)  
>>>   
>>> >From the comment, this seems like the IOMMU fault handler (the  
>>> construction of this series makes this difficult to follow) and
>>> eventually it handles more than DMA mapping, for example transferring
>>> faults to the device driver.  "dma_map_iopf" seems like a poorly scoped
>>> name.  
>>
>> Maybe just call it dev_fault_handler?
> 
> Better.
> 
>>>> +{
>>>> +	struct device *dev = (struct device *)data;
>>>> +	struct iommu_group *iommu_group;
>>>> +	struct vfio_iopf_group *iopf_group;
>>>> +	struct vfio_iommu *iommu;
>>>> +	struct vfio_dma *dma;
>>>> +	dma_addr_t iova = ALIGN_DOWN(fault->prm.addr, PAGE_SIZE);
>>>> +	int access_flags = 0;
>>>> +	unsigned long bit_offset, vaddr, pfn;
>>>> +	int ret;
>>>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>>> +	struct iommu_page_response resp = {0};
>>>> +
>>>> +	if (fault->type != IOMMU_FAULT_PAGE_REQ)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	iommu_group = iommu_group_get(dev);
>>>> +	if (!iommu_group)
>>>> +		return -ENODEV;
>>>> +
>>>> +	iopf_group = vfio_find_iopf_group(iommu_group);
>>>> +	iommu_group_put(iommu_group);
>>>> +	if (!iopf_group)
>>>> +		return -ENODEV;
>>>> +
>>>> +	iommu = iopf_group->iommu;
>>>> +
>>>> +	mutex_lock(&iommu->lock);  
>>>
>>> Again, I'm dubious of our ability to grab this lock from an object with
>>> an unknown lifecycle and races we might have with that group being
>>> detached or DMA unmapped.  Also, how effective is enabling IOMMU page
>>> faulting if we're serializing all faults within a container context?  
>>
>> Did you mean "efficient"?
> 
> Yes, that's more appropriate.
> 
>> I also worry about this as the mapping and unmapping of the faulting pages
>> are all with the same lock...
>> Is there a way to parallel them? Or could we have more fine grained lock
>> control?
> 
> It seems we need it; the current locking is designed for static
> mappings by the user, therefore concurrency hasn't been a priority.

I will try to implement it. :-)

> This again touches how far we want to extend type1 in the direction
> we intend to go with SVA/PASID support in IOASID.  Thanks,

Reply in the cover.

Thanks,
Shenming

> 
> Alex
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
