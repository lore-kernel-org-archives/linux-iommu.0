Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19727C433ED
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 09:32:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BED6101D
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 09:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BED6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D93C4038C;
	Mon, 19 Apr 2021 09:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zRxAX9CA0gWv; Mon, 19 Apr 2021 09:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA41940393;
	Mon, 19 Apr 2021 09:32:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F6AAC000F;
	Mon, 19 Apr 2021 09:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C754C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 09:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C061607CD
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 09:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aPff8V-pyHGm for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 09:32:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0492607BF
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 09:32:22 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FP1kD4zpFzqTsr;
 Mon, 19 Apr 2021 17:29:56 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 19 Apr 2021 17:32:09 +0800
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
To: Lu Baolu <baolu.lu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Joerg
 Roedel" <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-3-zhukeqian1@huawei.com>
 <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
Date: Mon, 19 Apr 2021 17:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
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

On 2021/4/14 15:14, Lu Baolu wrote:
> On 4/13/21 4:54 PM, Keqian Zhu wrote:
>> Block(largepage) mapping is not a proper granule for dirty log tracking.
>> Take an extreme example, if DMA writes one byte, under 1G mapping, the
>> dirty amount reported is 1G, but under 4K mapping, the dirty amount is
>> just 4K.
>>
>> This adds a new interface named iommu_split_block in IOMMU base layer.
>> A specific IOMMU driver can invoke it during start dirty log. If so, the
>> driver also need to realize the split_block iommu ops.
>>
>> We flush all iotlbs after the whole procedure is completed to ease the
>> pressure of IOMMU, as we will hanle a huge range of mapping in general.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>   drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h | 11 +++++++++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 667b2d6d2fc0..bb413a927870 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2721,6 +2721,47 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
>>   +int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
>> +              size_t size)
>> +{
>> +    const struct iommu_ops *ops = domain->ops;
>> +    unsigned int min_pagesz;
>> +    size_t pgsize;
>> +    bool flush = false;
>> +    int ret = 0;
>> +
>> +    if (unlikely(!ops || !ops->split_block))
>> +        return -ENODEV;
>> +
>> +    min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>> +    if (!IS_ALIGNED(iova | size, min_pagesz)) {
>> +        pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
>> +               iova, size, min_pagesz);
>> +        return -EINVAL;
>> +    }
>> +
>> +    while (size) {
>> +        flush = true;
>> +
>> +        pgsize = iommu_pgsize(domain, iova, size);
>> +
>> +        ret = ops->split_block(domain, iova, pgsize);
>> +        if (ret)
>> +            break;
>> +
>> +        pr_debug("split handled: iova 0x%lx size 0x%zx\n", iova, pgsize);
>> +
>> +        iova += pgsize;
>> +        size -= pgsize;
>> +    }
>> +
>> +    if (flush)
>> +        iommu_flush_iotlb_all(domain);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_split_block);
> 
> Do you really have any consumers of this interface other than the dirty
> bit tracking? If not, I don't suggest to make this as a generic IOMMU
> interface.
> 
> There is an implicit requirement for such interfaces. The
> iommu_map/unmap(iova, size) shouldn't be called at the same time.
> Currently there's no such sanity check in the iommu core. A poorly
> written driver could mess up the kernel by misusing this interface.

Yes, I don't think up a scenario except dirty tracking.

Indeed, we'd better not make them as a generic interface.

Do you have any suggestion that underlying iommu drivers can share these code but
not make it as a generic iommu interface?

I have a not so good idea. Make the "split" interfaces as a static function, and
transfer the function pointer to start_dirty_log. But it looks weird and inflexible.

On the other hand, if a driver calls map/unmap with split/merge at the same time,
it's a bug of driver, it should follow the rule.

> 
> This also applies to iommu_merge_page().
>

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
