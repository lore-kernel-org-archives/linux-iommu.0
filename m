Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3E0C2D0C2
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 17:44:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3752072C
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 17:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3752072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3E7085BC2;
	Thu,  2 Jan 2020 17:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXoHCf4Md_96; Thu,  2 Jan 2020 17:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B7C9845A0;
	Thu,  2 Jan 2020 17:44:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B235C1D7D;
	Thu,  2 Jan 2020 17:44:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1213C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 17:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 796092052B
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 17:44:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ah7qh3jLiRPr for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 17:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id C71C92050F
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 17:44:43 +0000 (UTC)
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id D9739A5E9B5C61B8224E;
 Thu,  2 Jan 2020 17:44:40 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 Jan 2020 17:44:40 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Jan 2020
 17:44:39 +0000
Subject: arm-smmu-v3 high cpu usage for NVMe
To: Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>, "Robin
 Murphy" <robin.murphy@arm.com>
References: <20190821151749.23743-1-will@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
Date: Thu, 2 Jan 2020 17:44:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20190821151749.23743-1-will@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ming Lei <ming.lei@redhat.com>, Marc Zyngier <maz@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


Hi Will, Robin,

While analyzing an arm64 issue in interrupt handling for NVMe [0], we 
have noticed a worryingly high CPU utilization in the SMMU driver.

The background is that we may get CPU lockup for high-throughput NVMe 
testing, and we noticed that disabling the SMMU during testing avoids 
the issue. However this lockup is a cross-architecture issue and there 
are attempts to address it, like [1]. To me, disabling the SMMU is just 
avoiding that specific issue.

Anyway, we should still consider this high CPU loading:

    PerfTop:    1694 irqs/sec  kernel:97.3%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cycles],  (all, CPU: 0)
--------------------------------------------------------------------------------------------------------------------------

     50.84%  [kernel]       [k] arm_smmu_cmdq_issue_cmdlist
     19.51%  [kernel]       [k] _raw_spin_unlock_irqrestore
      5.14%  [kernel]       [k] __slab_free
      2.37%  [kernel]       [k] bio_release_pages.part.42
      2.20%  [kernel]       [k] fput_many
      1.92%  [kernel]       [k] aio_complete_rw
      1.85%  [kernel]       [k] __arm_lpae_unmap
      1.71%  [kernel]       [k] arm_smmu_atc_inv_domain.constprop.42
      1.11%  [kernel]       [k] sbitmap_queue_clear
      1.05%  [kernel]       [k] blk_mq_free_request
      0.97%  [kernel]       [k] nvme_irq
      0.71%  [kernel]       [k] blk_account_io_done
      0.66%  [kernel]       [k] kmem_cache_free
      0.66%  [kernel]       [k] blk_mq_complete_request

This is for a CPU servicing the NVMe interrupt and doing the DMA unmap. 
The DMA unmap is done in threaded interrupt context.

And for the overall system, we have:

   PerfTop:   85864 irqs/sec  kernel:89.6%  exact:  0.0% lost: 0/34434 
drop: 0/40116 [4000Hz cycles],  (all, 96 CPUs)
--------------------------------------------------------------------------------------------------------------------------

     27.43%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
     11.71%  [kernel]          [k] _raw_spin_unlock_irqrestore
      6.35%  [kernel]          [k] _raw_spin_unlock_irq
      2.65%  [kernel]          [k] get_user_pages_fast
      2.03%  [kernel]          [k] __slab_free
      1.55%  [kernel]          [k] tick_nohz_idle_exit
      1.47%  [kernel]          [k] arm_lpae_map
      1.39%  [kernel]          [k] __fget
      1.14%  [kernel]          [k] __lock_text_start
      1.09%  [kernel]          [k] _raw_spin_lock
      1.08%  [kernel]          [k] bio_release_pages.part.42
      1.03%  [kernel]          [k] __sbitmap_get_word
      0.97%  [kernel]          [k] arm_smmu_atc_inv_domain.constprop.42
      0.91%  [kernel]          [k] fput_many
      0.88%  [kernel]          [k] __arm_lpae_map

One thing to note is that we still spend an appreciable amount of time 
in arm_smmu_atc_inv_domain(), which is disappointing when considering it 
should effectively be a noop.

As for arm_smmu_cmdq_issue_cmdlist(), I do note that during the testing 
our batch size is 1, so we're not seeing the real benefit of the 
batching. I can't help but think that we could improve this code to try 
to combine CMD SYNCs for small batches.

Anyway, let me know your thoughts or any questions. I'll have a look if 
a get a chance for other possible bottlenecks.

[0] 
https://lore.kernel.org/lkml/e815b5451ea86e99d42045f7067f455a@www.loen.fr/

[1] 
https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/

Cheers,
John

On 21/08/2019 16:17, Will Deacon wrote:
> Hi again,
> 
> This is version two of the patches I posted yesterday:
> 
>    v1: https://lkml.kernel.org/r/20190820154549.17018-1-will@kernel.org
> 
> Changes since then include:
> 
>    * Fix 'ats_enabled' checking when enabling ATS
>    * Remove redundant 'dev_is_pci()' calls
>    * Remove bool bitfield
>    * Add patch temporarily disabling ATS detection for -stable
>    * Issue ATC invalidation even when non-leaf
>    * Elide invalidation/SYNC for zero-sized address ranges
>    * Shuffle the patches round a bit
> 
> Thanks,
> 
> Will
> 
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> 
> --->8
> 
> Will Deacon (8):
>    iommu/arm-smmu-v3: Document ordering guarantees of command insertion
>    iommu/arm-smmu-v3: Disable detection of ATS and PRI
>    iommu/arm-smmu-v3: Remove boolean bitfield for 'ats_enabled' flag
>    iommu/arm-smmu-v3: Don't issue CMD_SYNC for zero-length invalidations
>    iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters
>    iommu/arm-smmu-v3: Fix ATC invalidation ordering wrt main TLBs
>    iommu/arm-smmu-v3: Avoid locking on invalidation path when not using
>      ATS
>    Revert "iommu/arm-smmu-v3: Disable detection of ATS and PRI"
> 
>   drivers/iommu/arm-smmu-v3.c | 117 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 87 insertions(+), 30 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
