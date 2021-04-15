Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21163C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:18:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9781061624
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 06:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9781061624
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5874D60D6A;
	Thu, 15 Apr 2021 06:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhxGA2D0veGC; Thu, 15 Apr 2021 06:18:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20B2360BA9;
	Thu, 15 Apr 2021 06:18:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CD64C000C;
	Thu, 15 Apr 2021 06:18:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEBF4C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D014A40204
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DG94O0QH74wz for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFE76401E4
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:18:21 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FLTbb1hRCzPp4H;
 Thu, 15 Apr 2021 14:15:23 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 14:18:10 +0800
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
To: Lu Baolu <baolu.lu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Joerg
 Roedel" <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
Date: Thu, 15 Apr 2021 14:18:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

Hi Baolu,

Thanks for the review!

On 2021/4/14 15:00, Lu Baolu wrote:
> Hi Keqian,
> 
> On 4/13/21 4:54 PM, Keqian Zhu wrote:
>> Some types of IOMMU are capable of tracking DMA dirty log, such as
>> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
>> dirty log tracking framework in the IOMMU base layer.
>>
>> Three new essential interfaces are added, and we maintaince the status
>> of dirty log tracking in iommu_domain.
>> 1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
>> 2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
>> 3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>>
>> A new dev feature are added to indicate whether a specific type of
>> iommu hardware supports and its driver realizes them.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>   drivers/iommu/iommu.c | 150 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h |  53 +++++++++++++++
>>   2 files changed, 203 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d0b0a15dba84..667b2d6d2fc0 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1922,6 +1922,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>       domain->type = type;
>>       /* Assume all sizes by default; the driver may override this later */
>>       domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>> +    mutex_init(&domain->switch_log_lock);
>>         return domain;
>>   }
>> @@ -2720,6 +2721,155 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>>   +int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
>> +               unsigned long iova, size_t size, int prot)
>> +{
>> +    const struct iommu_ops *ops = domain->ops;
>> +    int ret;
>> +
>> +    if (unlikely(!ops || !ops->switch_dirty_log))
>> +        return -ENODEV;
>> +
>> +    mutex_lock(&domain->switch_log_lock);
>> +    if (enable && domain->dirty_log_tracking) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    } else if (!enable && !domain->dirty_log_tracking) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    ret = ops->switch_dirty_log(domain, enable, iova, size, prot);
>> +    if (ret)
>> +        goto out;
>> +
>> +    domain->dirty_log_tracking = enable;
>> +out:
>> +    mutex_unlock(&domain->switch_log_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_switch_dirty_log);
> 
> Since you also added IOMMU_DEV_FEAT_HWDBM, I am wondering what's the
> difference between
> 
> iommu_switch_dirty_log(on) vs. iommu_dev_enable_feature(IOMMU_DEV_FEAT_HWDBM)
> 
> iommu_switch_dirty_log(off) vs. iommu_dev_disable_feature(IOMMU_DEV_FEAT_HWDBM)
Indeed. As I can see, IOMMU_DEV_FEAT_AUX is not switchable, so enable/disable
are not applicable for it. IOMMU_DEV_FEAT_SVA is switchable, so we can use these
interfaces for it.

IOMMU_DEV_FEAT_HWDBM is used to indicate whether hardware supports HWDBM, so we should
design it as not switchable. I will modify the commit message of patch#12, thanks!

> 
>> +
>> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
>> +             size_t size, unsigned long *bitmap,
>> +             unsigned long base_iova, unsigned long bitmap_pgshift)
>> +{
>> +    const struct iommu_ops *ops = domain->ops;
>> +    unsigned int min_pagesz;
>> +    size_t pgsize;
>> +    int ret = 0;
>> +
>> +    if (unlikely(!ops || !ops->sync_dirty_log))
>> +        return -ENODEV;
>> +
>> +    min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>> +    if (!IS_ALIGNED(iova | size, min_pagesz)) {
>> +        pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
>> +               iova, size, min_pagesz);
>> +        return -EINVAL;
>> +    }
>> +
>> +    mutex_lock(&domain->switch_log_lock);
>> +    if (!domain->dirty_log_tracking) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    while (size) {
>> +        pgsize = iommu_pgsize(domain, iova, size);
>> +
>> +        ret = ops->sync_dirty_log(domain, iova, pgsize,
>> +                      bitmap, base_iova, bitmap_pgshift);
> 
> Any reason why do you want to do this in a per-4K page manner? This can
> lead to a lot of indirect calls and bad performance.
> 
> How about a sync_dirty_pages()?
The function name of iommu_pgsize() is a bit puzzling. Actually it will try to
compute the max size that fit into size, so the pgsize can be a large page size
even if the underlying mapping is 4K. The __iommu_unmap() also has a similar logic.

BRs,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
