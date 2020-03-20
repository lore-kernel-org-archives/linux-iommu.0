Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122BC4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFB52076F
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz048aZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFB52076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8BDF225C36;
	Fri, 20 Mar 2020 16:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rxen69H3ZJZX; Fri, 20 Mar 2020 16:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 33301252A8;
	Fri, 20 Mar 2020 16:33:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFBCC1830;
	Fri, 20 Mar 2020 16:33:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E64C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 09D2387A4D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w1A3YQPGB9H4 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6AEDB879F0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:33:29 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 175A320753;
 Fri, 20 Mar 2020 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584722009;
 bh=Z1c07qKggjOfg7ZL5A2fnOtQ5WNQUxuM9CzVN2sZnoA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rz048aZnAx+F9myQY2MF+g80onihpc1n63zkOZi8vatwE4rR06zUFWAp98KBhnqE/
 9N0OU3f18NRdkJ5UIFaC1+uNl5ycwqXqphD9Zw/lMSqEc1xtY5BGrgDG/VTv1+hA3q
 lYu9EkoMZQutBGzkMRq08TRPPTBUGiCroQAy7n6M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jFKaN-00EIWo-Bd; Fri, 20 Mar 2020 16:33:27 +0000
MIME-Version: 1.0
Date: Fri, 20 Mar 2020 16:33:27 +0000
From: Marc Zyngier <maz@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
In-Reply-To: <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
 <20200320111842.GD1702630@myrica>
 <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
Message-ID: <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, jean-philippe@linaro.org,
 will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 thunder.leizhen@huawei.com, ming.lei@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

Hi John,

On 2020-03-20 16:20, John Garry wrote:
>>> 
>>>> 
>>>> I've run a bunch of netperf instances on multiple cores and 
>>>> collecting
>>>> SMMU usage (on TaiShan 2280). I'm getting the following ratio pretty
>>>> consistently.
>>>> 
>>>> - 6.07% arm_smmu_iotlb_sync
>>>>      - 5.74% arm_smmu_tlb_inv_range
>>>>           5.09% arm_smmu_cmdq_issue_cmdlist
>>>>           0.28% __pi_memset
>>>>           0.08% __pi_memcpy
>>>>           0.08% arm_smmu_atc_inv_domain.constprop.37
>>>>           0.07% arm_smmu_cmdq_build_cmd
>>>>           0.01% arm_smmu_cmdq_batch_add
>>>>        0.31% __pi_memset
>>>> 
>>>> So arm_smmu_atc_inv_domain() takes about 1.4% of 
>>>> arm_smmu_iotlb_sync(),
>>>> when ATS is not used. According to the annotations, the load from 
>>>> the
>>>> atomic_read(), that checks whether the domain uses ATS, is 77% of 
>>>> the
>>>> samples in arm_smmu_atc_inv_domain() (265 of 345 samples), so I'm 
>>>> not sure
>>>> there is much room for optimization there.
>>> 
>>> Well I did originally suggest using RCU protection to scan the list 
>>> of
>>> devices, instead of reading an atomic and checking for non-zero 
>>> value. But
>>> that would be an optimsation for ATS also, and there was no ATS 
>>> devices at
>>> the time (to verify performance).
>> 
>> Heh, I have yet to get my hands on one. Currently I can't evaluate ATS
>> performance, but I agree that using RCU to scan the list should get 
>> better
>> results when using ATS.
>> 
>> When ATS isn't in use however, I suspect reading nr_ats_masters should 
>> be
>> more efficient than taking the RCU lock + reading an "ats_devices" 
>> list
>> (since the smmu_domain->devices list also serves context descriptor
>> invalidation, even when ATS isn't in use). I'll run some tests 
>> however, to
>> see if I can micro-optimize this case, but I don't expect noticeable
>> improvements.
> 
> ok, cheers. I, too, would not expect a significant improvement there.
> 
> JFYI, I've been playing for "perf annotate" today and it's giving
> strange results for my NVMe testing. So "report" looks somewhat sane,
> if not a worryingly high % for arm_smmu_cmdq_issue_cmdlist():
> 
> 
>     55.39%  irq/342-nvme0q1  [kernel.kallsyms]  [k] 
> arm_smmu_cmdq_issue_cmdlist
>      9.74%  irq/342-nvme0q1  [kernel.kallsyms]  [k] 
> _raw_spin_unlock_irqrestore
>      2.02%  irq/342-nvme0q1  [kernel.kallsyms]  [k] nvme_irq
>      1.86%  irq/342-nvme0q1  [kernel.kallsyms]  [k] fput_many
>      1.73%  irq/342-nvme0q1  [kernel.kallsyms]  [k]
> arm_smmu_atc_inv_domain.constprop.42
>      1.67%  irq/342-nvme0q1  [kernel.kallsyms]  [k] __arm_lpae_unmap
>      1.49%  irq/342-nvme0q1  [kernel.kallsyms]  [k] aio_complete_rw
> 
> But "annotate" consistently tells me that a specific instruction
> consumes ~99% of the load for the enqueue function:
> 
>          :                      /* 5. If we are inserting a CMD_SYNC,
> we must wait for it to complete */
>          :                      if (sync) {
>     0.00 :   ffff80001071c948:       ldr     w0, [x29, #108]
>          :                      int ret = 0;
>     0.00 :   ffff80001071c94c:       mov     w24, #0x0      // #0
>          :                      if (sync) {
>     0.00 :   ffff80001071c950:       cbnz    w0, ffff80001071c990
> <arm_smmu_cmdq_issue_cmdlist+0x420>
>          :                      arch_local_irq_restore():
>     0.00 :   ffff80001071c954:       msr     daif, x21
>          :                      arm_smmu_cmdq_issue_cmdlist():
>          :                      }
>          :                      }
>          :
>          :                      local_irq_restore(flags);
>          :                      return ret;
>          :                      }
>    99.51 :   ffff80001071c958:       adrp    x0, ffff800011909000
> <page_wait_table+0x14c0>

This is likely the side effect of the re-enabling of interrupts (msr 
daif, x21)
on the previous instruction which causes the perf interrupt to fire 
right after.

Time to enable pseudo-NMIs in the PMUv3 driver...

          M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
