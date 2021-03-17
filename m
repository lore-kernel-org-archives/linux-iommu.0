Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0104C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 12:59:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5500964F6C
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 12:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5500964F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13BF83027;
	Wed, 17 Mar 2021 12:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hy9PRFr91sxu; Wed, 17 Mar 2021 12:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 034E782FB1;
	Wed, 17 Mar 2021 12:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF1CBC000B;
	Wed, 17 Mar 2021 12:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA09C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 12:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE16C42FFE
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 12:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4Sl79PWxa-m for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 12:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2FC7414D5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 12:59:50 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0qvN2WStz90W0;
 Wed, 17 Mar 2021 20:57:52 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 20:59:38 +0800
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Scan leaf TTD to sync
 hardware dirty log
To: Yi Sun <yi.y.sun@linux.intel.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-7-zhukeqian1@huawei.com>
 <20210317104429.GT28580@yi.y.sun>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <82fd0514-dc2e-c908-56d1-73143762540b@huawei.com>
Date: Wed, 17 Mar 2021 20:59:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210317104429.GT28580@yi.y.sun>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Cornelia
 Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org,
 James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>,
 wanghaibin.wang@huawei.com, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 2021/3/17 18:44, Yi Sun wrote:
> On 21-03-10 17:06:09, Keqian Zhu wrote:
>> From: jiangkunkun <jiangkunkun@huawei.com>
>>
>> During dirty log tracking, user will try to retrieve dirty log from
>> iommu if it supports hardware dirty log.
>>
>> This adds a new interface named sync_dirty_log in iommu layer and
>> arm smmuv3 implements it, which scans leaf TTD and treats it's dirty
>> if it's writable (As we just enable HTTU for stage1, so check whether
>> AP[2] is not set).
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>
>> changelog:
>>
>> v2:
>>  - Add new sanity check in arm_smmu_sync_dirty_log(). (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
>>  - Document the purpose of flush_iotlb in arm_smmu_sync_dirty_log(). (Robin)
>>  
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 30 +++++++
>>  drivers/iommu/io-pgtable-arm.c              | 90 +++++++++++++++++++++
>>  drivers/iommu/iommu.c                       | 38 +++++++++
>>  include/linux/io-pgtable.h                  |  4 +
>>  include/linux/iommu.h                       | 18 +++++
>>  5 files changed, 180 insertions(+)
>>
> Please split iommu common interface out. Thanks!
Yes, I will do it in v3.

> 
> [...]
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 2a10294b62a3..44dfb78f9050 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2850,6 +2850,44 @@ int iommu_stop_dirty_log(struct iommu_domain *domain, unsigned long iova,
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_stop_dirty_log);
>>  
>> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
>> +			 size_t size, unsigned long *bitmap,
>> +			 unsigned long base_iova, unsigned long bitmap_pgshift)
> 
> One open question: shall we add PASID as one parameter to make iommu
> know which address space to visit?
> 
> For live migration, the pasid should not be necessary. But considering
Sure, for live migration we just need to care about level/stage 2 mapping under nested mode.

> future extension, it may be required.
It sounds a good idea. I will consider this, thanks!

> 
> BRs,
> Yi Sun
> .
> 
Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
