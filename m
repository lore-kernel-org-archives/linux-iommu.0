Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D3C4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 10:42:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8762072D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 10:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8762072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB0252051E;
	Fri, 20 Mar 2020 10:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z+1WNasxBKeM; Fri, 20 Mar 2020 10:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2EBE52044C;
	Fri, 20 Mar 2020 10:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22333C1830;
	Fri, 20 Mar 2020 10:42:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A20FFC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 10:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E213889CC
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 10:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSWN2703nfWA for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 10:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 482CC8892E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 10:42:08 +0000 (UTC)
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 68F81D201EA9FC6A56DB;
 Fri, 20 Mar 2020 10:42:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Mar 2020 10:42:05 +0000
Received: from [127.0.0.1] (10.210.167.248) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 20 Mar
 2020 10:42:02 +0000
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
From: John Garry <john.garry@huawei.com>
Message-ID: <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
Date: Fri, 20 Mar 2020 10:41:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200319184349.GA1697676@myrica>
Content-Language: en-US
X-Originating-IP: [10.210.167.248]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Will Deacon <will@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
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

On 19/03/2020 18:43, Jean-Philippe Brucker wrote:
> On Thu, Mar 19, 2020 at 12:54:59PM +0000, John Garry wrote:
>> Hi Will,
>>
>>>
>>> On Thu, Jan 02, 2020 at 05:44:39PM +0000, John Garry wrote:
>>>> And for the overall system, we have:
>>>>
>>>>     PerfTop:   85864 irqs/sec  kernel:89.6%  exact:  0.0% lost: 0/34434 drop:
>>>> 0/40116 [4000Hz cycles],  (all, 96 CPUs)
>>>> --------------------------------------------------------------------------------------------------------------------------
>>>>
>>>>       27.43%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
>>>>       11.71%  [kernel]          [k] _raw_spin_unlock_irqrestore
>>>>        6.35%  [kernel]          [k] _raw_spin_unlock_irq
>>>>        2.65%  [kernel]          [k] get_user_pages_fast
>>>>        2.03%  [kernel]          [k] __slab_free
>>>>        1.55%  [kernel]          [k] tick_nohz_idle_exit
>>>>        1.47%  [kernel]          [k] arm_lpae_map
>>>>        1.39%  [kernel]          [k] __fget
>>>>        1.14%  [kernel]          [k] __lock_text_start
>>>>        1.09%  [kernel]          [k] _raw_spin_lock
>>>>        1.08%  [kernel]          [k] bio_release_pages.part.42
>>>>        1.03%  [kernel]          [k] __sbitmap_get_word
>>>>        0.97%  [kernel]          [k] arm_smmu_atc_inv_domain.constprop.42
>>>>        0.91%  [kernel]          [k] fput_many
>>>>        0.88%  [kernel]          [k] __arm_lpae_map
>>>>
>>>> One thing to note is that we still spend an appreciable amount of time in
>>>> arm_smmu_atc_inv_domain(), which is disappointing when considering it should
>>>> effectively be a noop.
>>>>
>>>> As for arm_smmu_cmdq_issue_cmdlist(), I do note that during the testing our
>>>> batch size is 1, so we're not seeing the real benefit of the batching. I
>>>> can't help but think that we could improve this code to try to combine CMD
>>>> SYNCs for small batches.
>>>>
>>>> Anyway, let me know your thoughts or any questions. I'll have a look if a
>>>> get a chance for other possible bottlenecks.
>>>
>>> Did you ever get any more information on this? I don't have any SMMUv3
>>> hardware any more, so I can't really dig into this myself.
>>
>> I'm only getting back to look at this now, as SMMU performance is a bit of a
>> hot topic again for us.
>>
>> So one thing we are doing which looks to help performance is this series
>> from Marc:
>>
>> https://lore.kernel.org/lkml/9171c554-50d2-142b-96ae-1357952fce52@huawei.com/T/#mee5562d1efd6aaeb8d2682bdb6807fe7b5d7f56d
>>
>> So that is just spreading the per-CPU load for NVMe interrupt handling
>> (where the DMA unmapping is happening), so I'd say just side-stepping any
>> SMMU issue really.
>>
>> Going back to the SMMU, I wanted to run epbf and perf annotate to help
>> profile this, but was having no luck getting them to work properly. I'll
>> look at this again now.
> 
> Could you also try with the upcoming ATS change currently in Will's tree?
> They won't improve your numbers but it'd be good to check that they don't
> make things worse.

I can do when I get a chance.

> 
> I've run a bunch of netperf instances on multiple cores and collecting
> SMMU usage (on TaiShan 2280). I'm getting the following ratio pretty
> consistently.
> 
> - 6.07% arm_smmu_iotlb_sync
>     - 5.74% arm_smmu_tlb_inv_range
>          5.09% arm_smmu_cmdq_issue_cmdlist
>          0.28% __pi_memset
>          0.08% __pi_memcpy
>          0.08% arm_smmu_atc_inv_domain.constprop.37
>          0.07% arm_smmu_cmdq_build_cmd
>          0.01% arm_smmu_cmdq_batch_add
>       0.31% __pi_memset
> 
> So arm_smmu_atc_inv_domain() takes about 1.4% of arm_smmu_iotlb_sync(),
> when ATS is not used. According to the annotations, the load from the
> atomic_read(), that checks whether the domain uses ATS, is 77% of the
> samples in arm_smmu_atc_inv_domain() (265 of 345 samples), so I'm not sure
> there is much room for optimization there.

Well I did originally suggest using RCU protection to scan the list of 
devices, instead of reading an atomic and checking for non-zero value. 
But that would be an optimsation for ATS also, and there was no ATS 
devices at the time (to verify performance).

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
