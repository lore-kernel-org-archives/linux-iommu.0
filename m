Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1427C7618B
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 10:12:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5C72081B
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5C72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 586C4E2E;
	Thu, 25 Jul 2019 10:12:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9F45DC1
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 10:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AC46D709
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 10:12:04 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 62B4DCEA9F31A61DA0CD;
	Thu, 25 Jul 2019 18:12:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
	(10.3.19.211) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 25 Jul 2019 18:11:53 +0800
Subject: Re: [RFC PATCH v2 00/19] Try to reduce lock contention on the SMMUv3
	command queue
To: Will Deacon <will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
	<c8dcc53f-8afa-0966-dcfd-ca79b099893f@huawei.com>
	<20190724122019.tzllwvqzy5ptfz6c@willie-the-truck>
	<085c4eb1-e385-04b7-e3ce-f290a80c1779@huawei.com>
	<20190724144817.kecc6kx7lhitaaac@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <7cf4d92f-fcaf-dacc-5e34-ed315ef52abe@huawei.com>
Date: Thu, 25 Jul 2019 11:11:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190724144817.kecc6kx7lhitaaac@willie-the-truck>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 24/07/2019 15:48, Will Deacon wrote:
> On Wed, Jul 24, 2019 at 03:25:07PM +0100, John Garry wrote:
>> On 24/07/2019 13:20, Will Deacon wrote:
>>> On Wed, Jul 24, 2019 at 10:58:26AM +0100, John Garry wrote:
>>>> On 11/07/2019 18:19, Will Deacon wrote:
>>>>> This is a significant rework of the RFC I previously posted here:
>>>>>
>>>>>   https://lkml.kernel.org/r/20190611134603.4253-1-will.deacon@arm.com
>>>>>
>>>>> But this time, it looks like it might actually be worthwhile according
>>>>> to my perf profiles, where __iommu_unmap() falls a long way down the
>>>>> profile for a multi-threaded netperf run. I'm still relying on others to
>>>>> confirm this is useful, however.
>>>>>
>>>>> Some of the changes since last time are:
>>>>>
>>>>>   * Support for constructing and submitting a list of commands in the
>>>>>     driver
>>>>>
>>>>>   * Numerous changes to the IOMMU and io-pgtable APIs so that we can
>>>>>     submit commands in batches
>>>>>
>>>>>   * Removal of cmpxchg() from cmdq_shared_lock() fast-path
>>>>>
>>>>>   * Code restructuring and cleanups
>>>>>
>>>>> This current applies against my iommu/devel branch that Joerg has pulled
>>>>> for 5.3. If you want to test it out, I've put everything here:
>>>>>
>>>>>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
>>>>>
>>>>> Feedback welcome. I appreciate that we're in the merge window, but I
>>>>> wanted to get this on the list for people to look at as an RFC.
>>>>>
>>>>
>>>> I tested storage performance on this series, which I think is a better
>>>> scenario to test than network performance, that being generally limited by
>>>> the network link speed.
>>>
>>> Interesting, thanks for sharing. Do you also see a similar drop in CPU time
>>> to the one reported by Ganapat?
>>
>> Not really, CPU load reported by fio is mostly the same.
>
> That's a pity. Maybe the cmdq isn't actually getting hit very heavily by
> fio.
>
>>>> Baseline performance (will/iommu/devel, commit 9e6ea59f3)
>>>> 8x SAS disks D05	839K IOPS
>>>> 1x NVMe D05		454K IOPS
>>>> 1x NVMe D06		442k IOPS
>>>>
>>>> Patchset performance (will/iommu/cmdq)
>>>> 8x SAS disk D05		835K IOPS
>>>> 1x NVMe D05		472K IOPS
>>>> 1x NVMe D06		459k IOPS
>>>>
>>>> So we see a bit of an NVMe boost, but about the same for 8x disks. No iommu
>>>> performance is about 918K IOPs for 8x disks, so it is not limited by the
>>>> medium.
>>>
>>> It would be nice to know if this performance gap is because of Linux, or
>>> simply because of the translation overhead in the SMMU hardware. Are you
>>> able to get a perf profile to see where we're spending time?
>>
>> I'll look to do that, but I'd really expect it to be down to the time linux
>> spends on the DMA map and unmaps.
>
> Right, and it would be good to see how much of that is in SMMUv3-specific
> code. Another interesting thing to try would be reducing the depth of the
> io-pgtable. We currently key that off VA_BITS which may be much larger
> than you need (by virtue of being a compile-time value).
>

The perf call-graph before and after is below. Interesting to see how 
long the mapping takes. So changing the io-pgtable depth may help here.

The unmapping speed improves - I don't know why it doesn't help the 8x 
disk scenario throughput, which these profiles are based on.

JFYI, our HW guys are quite concerned with the SMMU programming 
interface, specifically having a single submission queue which requires 
locking or some sort of synchronization. Obviously it's not a single 
culprit for consuming time.

before map
  |--3.02%--__iommu_map_sg_attrs
      |
      --2.99%--iommu_dma_map_sg
             |
             --2.71%--iommu_map_sg
                |
                --2.58%--iommu_map
                    |
                   --2.50%--arm_smmu_map
                          |
                          --2.48%--arm_lpae_map
                               |
                               --0.66%--__arm_lpae_map
                                     |
                                     --0.50%--__arm_lpae_map


after map
--3.25%--__iommu_map_sg_attrs
     |
     --3.20%--iommu_dma_map_sg
          |
          --2.77%--iommu_map_sg
               |
               --2.62%--iommu_map
                    |
                     --2.53%--arm_smmu_map
                            |
                            --2.49%--arm_lpae_map
                                   |
                                   --0.72%--__arm_lpae_map
                                         |
                                         --0.56%--__arm_lpae_map

before unmap
--5.64%--__iommu_unmap_sg_attrs
   |
   --5.63%--iommu_dma_unmap_sg
     |
      --5.53%--__iommu_dma_unmap
        |
        --4.97%--iommu_unmap_fast
          |
          --4.94%--__iommu_unmap
            |
            --4.91%--arm_smmu_unmap
               |
                --4.83%--arm_lpae_unmap
                   |
                   --4.80%--__arm_lpae_unmap
                     |
                     --4.62%--__arm_lpae_unmap
                        |
                        --4.50%--__arm_lpae_unmap
                           |
                           --4.33%--__arm_lpae_unmap
                             |
                              --4.13%--arm_smmu_tlb_inv_range_nosync
                                |
                                 --3.97%--arm_smmu_cmdq_issue_cmd
                                   |
                                    --3.74%--_raw_spin_unlock_irqrestore

after unmap
--2.75%--__iommu_unmap_sg_attrs
     |
     --2.74%--iommu_dma_unmap_sg
        |
        --2.59%--__iommu_dma_unmap
              |
              |--1.82%--arm_smmu_iotlb_sync
              |       |
              |        --1.78%--arm_smmu_tlb_inv_range
              |              |
              |              --1.75%--arm_smmu_cmdq_issue_cmdlist
              |
              --0.65%--iommu_unmap_fast
                  |
                   --0.64%--__iommu_unmap
                        |
                        --0.62%--arm_smmu_unmap
                            |
                            --0.55%--arm_lpae_unmap
                                  |
                                  --0.54%--__arm_lpae_unmap


I tried to capture a record for direct DMA, but dma_direct_map_sg et al 
wasn't even showing in graph. That's the target...

John

> Will
>
> .
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
