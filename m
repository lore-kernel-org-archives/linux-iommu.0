Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22141C47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:16:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F352613D3
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F352613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45E4F40623;
	Thu, 27 May 2021 11:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jU4QTdE8v_vY; Thu, 27 May 2021 11:16:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66B3E404F3;
	Thu, 27 May 2021 11:16:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F50C000D;
	Thu, 27 May 2021 11:16:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D773C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82EFA400F6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4sROowf1R24i for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 11:16:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7A5D400E0
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:16:13 +0000 (UTC)
Received: from dggeml754-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrQD95x95zYnV4;
 Thu, 27 May 2021 19:13:29 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggeml754-chm.china.huawei.com (10.1.199.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 19:16:07 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 19:16:06 +0800
Subject: Re: [RFC PATCH v3 5/8] vfio/type1: VFIO_IOMMU_ENABLE_IOPF
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-6-lushenming@huawei.com>
 <20210518125821.590a23aa.alex.williamson@redhat.com>
 <c74251ec-9536-7e9f-cc38-db730aeaed92@huawei.com>
 <20210524161130.5417c867@x1.home.shazbot.org>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <b2ec33f3-b433-05f9-6c64-db17d8fbdc58@huawei.com>
Date: Thu, 27 May 2021 19:15:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210524161130.5417c867@x1.home.shazbot.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
> On Fri, 21 May 2021 14:38:25 +0800
> Shenming Lu <lushenming@huawei.com> wrote:
> 
>> On 2021/5/19 2:58, Alex Williamson wrote:
>>> On Fri, 9 Apr 2021 11:44:17 +0800
>>> Shenming Lu <lushenming@huawei.com> wrote:
>>>   
>>>> Since enabling IOPF for devices may lead to a slow ramp up of performance,
>>>> we add an ioctl VFIO_IOMMU_ENABLE_IOPF to make it configurable. And the
>>>> IOPF enabling of a VFIO device includes setting IOMMU_DEV_FEAT_IOPF and
>>>> registering the VFIO IOPF handler.
>>>>
>>>> Note that VFIO_IOMMU_DISABLE_IOPF is not supported since there may be
>>>> inflight page faults when disabling.
>>>>
>>>> Signed-off-by: Shenming Lu <lushenming@huawei.com>
>>>> ---
>>>>  drivers/vfio/vfio_iommu_type1.c | 223 +++++++++++++++++++++++++++++++-
>>>>  include/uapi/linux/vfio.h       |   6 +
>>>>  2 files changed, 226 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 01e296c6dc9e..7df5711e743a 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -71,6 +71,7 @@ struct vfio_iommu {
>>>>  	struct rb_root		dma_list;
>>>>  	struct blocking_notifier_head notifier;
>>>>  	struct mmu_notifier	mn;
>>>> +	struct mm_struct	*mm;  
>>>
>>> We currently have no requirement that a single mm is used for all
>>> container mappings.  Does enabling IOPF impose such a requirement?
>>> Shouldn't MAP/UNMAP enforce that?  
>>
>> Did you mean that there is a possibility that each vfio_dma in a
>> container has a different mm? If so, could we register one MMU
>> notifier for each vfio_dma in the MAP ioctl?
> 
> We don't prevent it currently.  There needs to be some balance,
> typically we'll have one mm, so would it make sense to have potentially
> thousands of mmu notifiers registered against the same mm?

If we have one MMU notifier per vfio_dma, there is no need to search the
iommu->dma_list when receiving an address invalidation event in
mn_invalidate_range().
Or could we divide the vfio_dma ranges into parts with different mm, and
each part would have one MMU notifier?

>  
>>>>  	unsigned int		dma_avail;
>>>>  	unsigned int		vaddr_invalid_count;
>>>>  	uint64_t		pgsize_bitmap;
>>>> @@ -81,6 +82,7 @@ struct vfio_iommu {
>>>>  	bool			dirty_page_tracking;
>>>>  	bool			pinned_page_dirty_scope;
>>>>  	bool			container_open;
>>>> +	bool			iopf_enabled;
>>>>  };
>>>>  
>>>>  struct vfio_domain {
>>>> @@ -461,6 +463,38 @@ vfio_find_iopf_group(struct iommu_group *iommu_group)
>>>>  	return node ? iopf_group : NULL;
>>>>  }
>>>>  
>>>> +static void vfio_link_iopf_group(struct vfio_iopf_group *new)
>>>> +{
>>>> +	struct rb_node **link, *parent = NULL;
>>>> +	struct vfio_iopf_group *iopf_group;
>>>> +
>>>> +	mutex_lock(&iopf_group_list_lock);
>>>> +
>>>> +	link = &iopf_group_list.rb_node;
>>>> +
>>>> +	while (*link) {
>>>> +		parent = *link;
>>>> +		iopf_group = rb_entry(parent, struct vfio_iopf_group, node);
>>>> +
>>>> +		if (new->iommu_group < iopf_group->iommu_group)
>>>> +			link = &(*link)->rb_left;
>>>> +		else
>>>> +			link = &(*link)->rb_right;
>>>> +	}
>>>> +
>>>> +	rb_link_node(&new->node, parent, link);
>>>> +	rb_insert_color(&new->node, &iopf_group_list);
>>>> +
>>>> +	mutex_unlock(&iopf_group_list_lock);
>>>> +}
>>>> +
>>>> +static void vfio_unlink_iopf_group(struct vfio_iopf_group *old)
>>>> +{
>>>> +	mutex_lock(&iopf_group_list_lock);
>>>> +	rb_erase(&old->node, &iopf_group_list);
>>>> +	mutex_unlock(&iopf_group_list_lock);
>>>> +}
>>>> +
>>>>  static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>>>>  {
>>>>  	struct mm_struct *mm;
>>>> @@ -2363,6 +2397,68 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>>>>  	list_splice_tail(iova_copy, iova);
>>>>  }
>>>>  
>>>> +static int vfio_dev_domian_nested(struct device *dev, int *nested)  
>>>
>>>
>>> s/domian/domain/
>>>
>>>   
>>>> +{
>>>> +	struct iommu_domain *domain;
>>>> +
>>>> +	domain = iommu_get_domain_for_dev(dev);
>>>> +	if (!domain)
>>>> +		return -ENODEV;
>>>> +
>>>> +	return iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, nested);  
>>>
>>>
>>> Wouldn't this be easier to use if it returned bool, false on -errno?  
>>
>> Make sense.
>>
>>>
>>>   
>>>> +}
>>>> +
>>>> +static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data);
>>>> +
>>>> +static int dev_enable_iopf(struct device *dev, void *data)
>>>> +{
>>>> +	int *enabled_dev_cnt = data;
>>>> +	int nested;
>>>> +	u32 flags;
>>>> +	int ret;
>>>> +
>>>> +	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = vfio_dev_domian_nested(dev, &nested);
>>>> +	if (ret)
>>>> +		goto out_disable;
>>>> +
>>>> +	if (nested)
>>>> +		flags = FAULT_REPORT_NESTED_L2;
>>>> +	else
>>>> +		flags = FAULT_REPORT_FLAT;
>>>> +
>>>> +	ret = iommu_register_device_fault_handler(dev,
>>>> +				vfio_iommu_type1_dma_map_iopf, flags, dev);
>>>> +	if (ret)
>>>> +		goto out_disable;
>>>> +
>>>> +	(*enabled_dev_cnt)++;
>>>> +	return 0;
>>>> +
>>>> +out_disable:
>>>> +	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_IOPF);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int dev_disable_iopf(struct device *dev, void *data)
>>>> +{
>>>> +	int *enabled_dev_cnt = data;
>>>> +
>>>> +	if (enabled_dev_cnt && *enabled_dev_cnt <= 0)
>>>> +		return -1;  
>>>
>>>
>>> Use an errno.>
>>>   
>>>> +
>>>> +	WARN_ON(iommu_unregister_device_fault_handler(dev));
>>>> +	WARN_ON(iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_IOPF));
>>>> +
>>>> +	if (enabled_dev_cnt)
>>>> +		(*enabled_dev_cnt)--;  
>>>
>>>
>>> Why do we need these counters?  
>>
>> We use this counter to record the number of IOPF enabled devices, and if
>> any device fails to be enabled, we will exit the loop (three nested loop)
>> and go to the unwind process, which will disable the first @enabled_dev_cnt
>> devices.
>>
>>>   
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>>  					 struct iommu_group *iommu_group)
>>>>  {
>>>> @@ -2376,6 +2472,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>>  	struct iommu_domain_geometry geo;
>>>>  	LIST_HEAD(iova_copy);
>>>>  	LIST_HEAD(group_resv_regions);
>>>> +	int iopf_enabled_dev_cnt = 0;
>>>> +	struct vfio_iopf_group *iopf_group = NULL;
>>>>  
>>>>  	mutex_lock(&iommu->lock);
>>>>  
>>>> @@ -2453,6 +2551,24 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>>  	if (ret)
>>>>  		goto out_domain;
>>>>  
>>>> +	if (iommu->iopf_enabled) {
>>>> +		ret = iommu_group_for_each_dev(iommu_group, &iopf_enabled_dev_cnt,
>>>> +					       dev_enable_iopf);
>>>> +		if (ret)
>>>> +			goto out_detach;
>>>> +
>>>> +		iopf_group = kzalloc(sizeof(*iopf_group), GFP_KERNEL);
>>>> +		if (!iopf_group) {
>>>> +			ret = -ENOMEM;
>>>> +			goto out_detach;
>>>> +		}
>>>> +
>>>> +		iopf_group->iommu_group = iommu_group;
>>>> +		iopf_group->iommu = iommu;
>>>> +
>>>> +		vfio_link_iopf_group(iopf_group);  
>>>
>>> This seems backwards, once we enable iopf we can take a fault, so the
>>> structure to lookup the data for the device should be setup first.  I'm
>>> still not convinced this iopf_group rb tree is a good solution to get
>>> from the device to the iommu either.  vfio-core could traverse dev ->
>>> iommu_group -> vfio_group -> container -> iommu_data.  
>>
>> Make sense.
>>
>>>
>>>   
>>>> +	}
>>>> +
>>>>  	/* Get aperture info */
>>>>  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
>>>>  
>>>> @@ -2534,9 +2650,11 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>>  	vfio_test_domain_fgsp(domain);
>>>>  
>>>>  	/* replay mappings on new domains */
>>>> -	ret = vfio_iommu_replay(iommu, domain);
>>>> -	if (ret)
>>>> -		goto out_detach;
>>>> +	if (!iommu->iopf_enabled) {
>>>> +		ret = vfio_iommu_replay(iommu, domain);
>>>> +		if (ret)
>>>> +			goto out_detach;
>>>> +	}  
>>>
>>> Test in vfio_iommu_replay()?  
>>
>> Not yet, I will do more tests later.
>>
>>>   
>>>>  
>>>>  	if (resv_msi) {
>>>>  		ret = iommu_get_msi_cookie(domain->domain, resv_msi_base);
>>>> @@ -2567,6 +2685,15 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>>  	iommu_domain_free(domain->domain);
>>>>  	vfio_iommu_iova_free(&iova_copy);
>>>>  	vfio_iommu_resv_free(&group_resv_regions);
>>>> +	if (iommu->iopf_enabled) {
>>>> +		if (iopf_group) {
>>>> +			vfio_unlink_iopf_group(iopf_group);
>>>> +			kfree(iopf_group);
>>>> +		}
>>>> +
>>>> +		iommu_group_for_each_dev(iommu_group, &iopf_enabled_dev_cnt,
>>>> +					 dev_disable_iopf);  
>>>
>>> Backwards, disable fault reporting before unlinking lookup.  
>>
>> Make sense.
>>
>>>   
>>>> +	}
>>>>  out_free:
>>>>  	kfree(domain);
>>>>  	kfree(group);
>>>> @@ -2728,6 +2855,19 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>>>  		if (!group)
>>>>  			continue;
>>>>  
>>>> +		if (iommu->iopf_enabled) {
>>>> +			struct vfio_iopf_group *iopf_group;
>>>> +
>>>> +			iopf_group = vfio_find_iopf_group(iommu_group);
>>>> +			if (!WARN_ON(!iopf_group)) {
>>>> +				vfio_unlink_iopf_group(iopf_group);
>>>> +				kfree(iopf_group);
>>>> +			}
>>>> +
>>>> +			iommu_group_for_each_dev(iommu_group, NULL,
>>>> +						 dev_disable_iopf);  
>>>
>>>
>>> Backwards.  Also unregistering the fault handler can fail if there are
>>> pending faults.  It appears the fault handler and iopf lookup could also
>>> race with this function, ex. fault handler gets an iopf object before
>>> it's removed from the rb-tree, blocks trying to acquire iommu->lock,
>>> disable_iopf fails, detach proceeds, fault handler has use after free
>>> error.  
>>
>> We have WARN_ON for the failure of the unregistering.
>>
>> Yeah, it seems that using vfio_iopf_group is not a good choice...
>>
>>>
>>>   
>>>> +		}
>>>> +
>>>>  		vfio_iommu_detach_group(domain, group);
>>>>  		update_dirty_scope = !group->pinned_page_dirty_scope;
>>>>  		list_del(&group->next);
>>>> @@ -2846,6 +2986,11 @@ static void vfio_iommu_type1_release(void *iommu_data)
>>>>  
>>>>  	vfio_iommu_iova_free(&iommu->iova_list);
>>>>  
>>>> +	if (iommu->iopf_enabled) {
>>>> +		mmu_notifier_unregister(&iommu->mn, iommu->mm);
>>>> +		mmdrop(iommu->mm);
>>>> +	}
>>>> +
>>>>  	kfree(iommu);
>>>>  }
>>>>  
>>>> @@ -3441,6 +3586,76 @@ static const struct mmu_notifier_ops vfio_iommu_type1_mn_ops = {
>>>>  	.invalidate_range	= mn_invalidate_range,
>>>>  };
>>>>  
>>>> +static int vfio_iommu_type1_enable_iopf(struct vfio_iommu *iommu)
>>>> +{
>>>> +	struct vfio_domain *d;
>>>> +	struct vfio_group *g;
>>>> +	struct vfio_iopf_group *iopf_group;
>>>> +	int enabled_dev_cnt = 0;
>>>> +	int ret;
>>>> +
>>>> +	if (!current->mm)
>>>> +		return -ENODEV;
>>>> +
>>>> +	mutex_lock(&iommu->lock);
>>>> +
>>>> +	mmgrab(current->mm);  
>>>
>>>
>>> As above, this is a new and undocumented requirement.
>>>
>>>   
>>>> +	iommu->mm = current->mm;
>>>> +	iommu->mn.ops = &vfio_iommu_type1_mn_ops;
>>>> +	ret = mmu_notifier_register(&iommu->mn, current->mm);
>>>> +	if (ret)
>>>> +		goto out_drop;
>>>> +
>>>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>>>> +		list_for_each_entry(g, &d->group_list, next) {
>>>> +			ret = iommu_group_for_each_dev(g->iommu_group,
>>>> +					&enabled_dev_cnt, dev_enable_iopf);
>>>> +			if (ret)
>>>> +				goto out_unwind;
>>>> +
>>>> +			iopf_group = kzalloc(sizeof(*iopf_group), GFP_KERNEL);
>>>> +			if (!iopf_group) {
>>>> +				ret = -ENOMEM;
>>>> +				goto out_unwind;
>>>> +			}
>>>> +
>>>> +			iopf_group->iommu_group = g->iommu_group;
>>>> +			iopf_group->iommu = iommu;
>>>> +
>>>> +			vfio_link_iopf_group(iopf_group);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	iommu->iopf_enabled = true;
>>>> +	goto out_unlock;
>>>> +
>>>> +out_unwind:
>>>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>>>> +		list_for_each_entry(g, &d->group_list, next) {
>>>> +			iopf_group = vfio_find_iopf_group(g->iommu_group);
>>>> +			if (iopf_group) {
>>>> +				vfio_unlink_iopf_group(iopf_group);
>>>> +				kfree(iopf_group);
>>>> +			}
>>>> +
>>>> +			if (iommu_group_for_each_dev(g->iommu_group,
>>>> +					&enabled_dev_cnt, dev_disable_iopf))
>>>> +				goto out_unregister;  
>>>
>>>
>>> This seems broken, we break out of the unwind if any group_for_each
>>> fails??  
>>
>> The iommu_group_for_each_dev function will return a negative value if
>> we have disabled all previously enabled devices (@enabled_dev_cnt).
> 
> What's the harm in calling disable IOPF on a device where it's already
> disabled?  This is why I'm not sure the value of keeping a counter.  It
> also presumes that for_each_dev iterates in the same order every time.

In the current implementation (can only have one iommu dev fault handler),
there is no harm in calling disable IOPF on a device where it's already
disabled, but if someone else has already enabled IOPF on the device,
the IOPF enabling here would fail, and goto the unwind process, then
if we disable all the devices regardless of enabled or disabled, we
may disable the devices which were enabled by others.

And if we could have more than one handler per dev in the future, the
iommu interfaces could be re-designed to be harmless for this...

Besides, if we can't assume that for_each_dev iterates in the same order
every time, we may need to keep more than a counter...

>  
>>>> +		}
>>>> +	}
>>>> +
>>>> +out_unregister:
>>>> +	mmu_notifier_unregister(&iommu->mn, current->mm);
>>>> +
>>>> +out_drop:
>>>> +	iommu->mm = NULL;
>>>> +	mmdrop(current->mm);
>>>> +
>>>> +out_unlock:
>>>> +	mutex_unlock(&iommu->lock);
>>>> +	return ret;
>>>> +}  
>>>
>>>
>>> Is there an assumption that the user does this before performing any
>>> mapping?  I don't see where current mappings would be converted which
>>> means we'll have pinned pages leaked and vfio_dma objects without a
>>> pinned page bitmap.  
>>
>> Yeah, we have an assumption that this ioctl (ENABLE_IOPF) must be called
>> before any MAP/UNMAP ioctl...
>>
>> I will document these later. :-)
> 
> 
> That can't be fixed with documentation, if it's a requirement, the code
> needs to enforce it.  But also why is it a requirement?  Theoretically
> we could unpin and de-account existing mappings and allow the mmu
> notifier to handle these as well, right?  Thanks,

Make sense. It is not a necessary requirement.

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
