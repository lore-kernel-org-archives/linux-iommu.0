Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88779C4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 11:18:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6752072D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 11:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWY/+nXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6752072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12967863D5;
	Fri, 20 Mar 2020 11:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w0Omz2H3taCO; Fri, 20 Mar 2020 11:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0611286138;
	Fri, 20 Mar 2020 11:18:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E057EC089E;
	Fri, 20 Mar 2020 11:18:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66F1CC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 11:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55E0120336
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 11:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pORD+1MvTb98 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 11:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 7918E2014B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 11:18:52 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a25so6976547wrd.0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R2GbNEVqYqJyY/7DJozmJIGSvrZLlNutR9Aa7/O6Smw=;
 b=mWY/+nXFQ/TRgPldtI8g3TX8aZk+rqrFLAL/irchXuG48lg9Q53pXhDseQa3HmyxSl
 vAL9bgJdL8hT8pyJ9kJFG8QX8NIuHm9oG/0Dj3Oqho52+A7WFeG5EfhjvHxmKR0gt695
 5/QZro7zHgK8i43/b/lsAoaDt4+0PXcsBKbTqSpoShlt/k/pIk0G3Ndie6IEHLtIatfi
 dxznOOhMteU5lh0gxBK57jXZQHpx9Y+SeJdv01PcV4OgnWjN6v7L/XZ83M+0VrE7fice
 sq560FeejFiK8/aMmnRStDO1j6lhdZUnvh9NsyrqLOepwjRBx0tFb9qjTCHd/TX9kCXK
 uIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R2GbNEVqYqJyY/7DJozmJIGSvrZLlNutR9Aa7/O6Smw=;
 b=B+3ip+jAX7Xa0wsa+7t8bRqyhJAF1ryGfePN0asyWD5GnERftRwXwK7akHxgz2e1SB
 IBlGSjEUXDGh6HwgAUjFVShZMvelVAyvJTzuHFWsrAHaJuI8oUVB7menpiNmdRpEVE/v
 hnG+k6JbJgWqcAURvQMIgXBuveh/5GTdwOVhERuw8fyEvwiq2YDiGR3tAW4SE0JnxN6g
 hbnpe/5QZjmWlxP+n3n2wwntFbib9DSTBbei9B+LoMwwB9R6KzSPfAQnv9oUl+ss1YwT
 gAUz8nbN0Qzes+IIg4s2pnAQOMzhdVWf0P0uo3ByT1BZnuFWA8Ybc4M0bfob6Re4pM8k
 O/rA==
X-Gm-Message-State: ANhLgQ3FFe23smq4MYKjpV5LzSb4lC3AtjD/kln8aoCuotBnbY+H5v6i
 tmFkztkK4ZvYnxGHi9kIkqkb6Q==
X-Google-Smtp-Source: ADFU+vs8bTEWi7h/gO6kGrjdklq1O6E2M0naM+StjyBSFi4vYDydx7EVCmMaoMseDMDALcmHBsRZew==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr10926536wrs.179.1584703130599; 
 Fri, 20 Mar 2020 04:18:50 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id l17sm1160991wrm.57.2020.03.20.04.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 04:18:50 -0700 (PDT)
Date: Fri, 20 Mar 2020 12:18:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
Message-ID: <20200320111842.GD1702630@myrica>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
Cc: Will Deacon <will@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Mar 20, 2020 at 10:41:44AM +0000, John Garry wrote:
> On 19/03/2020 18:43, Jean-Philippe Brucker wrote:
> > On Thu, Mar 19, 2020 at 12:54:59PM +0000, John Garry wrote:
> > > Hi Will,
> > > 
> > > > 
> > > > On Thu, Jan 02, 2020 at 05:44:39PM +0000, John Garry wrote:
> > > > > And for the overall system, we have:
> > > > > 
> > > > >     PerfTop:   85864 irqs/sec  kernel:89.6%  exact:  0.0% lost: 0/34434 drop:
> > > > > 0/40116 [4000Hz cycles],  (all, 96 CPUs)
> > > > > --------------------------------------------------------------------------------------------------------------------------
> > > > > 
> > > > >       27.43%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
> > > > >       11.71%  [kernel]          [k] _raw_spin_unlock_irqrestore
> > > > >        6.35%  [kernel]          [k] _raw_spin_unlock_irq
> > > > >        2.65%  [kernel]          [k] get_user_pages_fast
> > > > >        2.03%  [kernel]          [k] __slab_free
> > > > >        1.55%  [kernel]          [k] tick_nohz_idle_exit
> > > > >        1.47%  [kernel]          [k] arm_lpae_map
> > > > >        1.39%  [kernel]          [k] __fget
> > > > >        1.14%  [kernel]          [k] __lock_text_start
> > > > >        1.09%  [kernel]          [k] _raw_spin_lock
> > > > >        1.08%  [kernel]          [k] bio_release_pages.part.42
> > > > >        1.03%  [kernel]          [k] __sbitmap_get_word
> > > > >        0.97%  [kernel]          [k] arm_smmu_atc_inv_domain.constprop.42
> > > > >        0.91%  [kernel]          [k] fput_many
> > > > >        0.88%  [kernel]          [k] __arm_lpae_map
> > > > > 
> > > > > One thing to note is that we still spend an appreciable amount of time in
> > > > > arm_smmu_atc_inv_domain(), which is disappointing when considering it should
> > > > > effectively be a noop.
> > > > > 
> > > > > As for arm_smmu_cmdq_issue_cmdlist(), I do note that during the testing our
> > > > > batch size is 1, so we're not seeing the real benefit of the batching. I
> > > > > can't help but think that we could improve this code to try to combine CMD
> > > > > SYNCs for small batches.
> > > > > 
> > > > > Anyway, let me know your thoughts or any questions. I'll have a look if a
> > > > > get a chance for other possible bottlenecks.
> > > > 
> > > > Did you ever get any more information on this? I don't have any SMMUv3
> > > > hardware any more, so I can't really dig into this myself.
> > > 
> > > I'm only getting back to look at this now, as SMMU performance is a bit of a
> > > hot topic again for us.
> > > 
> > > So one thing we are doing which looks to help performance is this series
> > > from Marc:
> > > 
> > > https://lore.kernel.org/lkml/9171c554-50d2-142b-96ae-1357952fce52@huawei.com/T/#mee5562d1efd6aaeb8d2682bdb6807fe7b5d7f56d
> > > 
> > > So that is just spreading the per-CPU load for NVMe interrupt handling
> > > (where the DMA unmapping is happening), so I'd say just side-stepping any
> > > SMMU issue really.
> > > 
> > > Going back to the SMMU, I wanted to run epbf and perf annotate to help
> > > profile this, but was having no luck getting them to work properly. I'll
> > > look at this again now.
> > 
> > Could you also try with the upcoming ATS change currently in Will's tree?
> > They won't improve your numbers but it'd be good to check that they don't
> > make things worse.
> 
> I can do when I get a chance.
> 
> > 
> > I've run a bunch of netperf instances on multiple cores and collecting
> > SMMU usage (on TaiShan 2280). I'm getting the following ratio pretty
> > consistently.
> > 
> > - 6.07% arm_smmu_iotlb_sync
> >     - 5.74% arm_smmu_tlb_inv_range
> >          5.09% arm_smmu_cmdq_issue_cmdlist
> >          0.28% __pi_memset
> >          0.08% __pi_memcpy
> >          0.08% arm_smmu_atc_inv_domain.constprop.37
> >          0.07% arm_smmu_cmdq_build_cmd
> >          0.01% arm_smmu_cmdq_batch_add
> >       0.31% __pi_memset
> > 
> > So arm_smmu_atc_inv_domain() takes about 1.4% of arm_smmu_iotlb_sync(),
> > when ATS is not used. According to the annotations, the load from the
> > atomic_read(), that checks whether the domain uses ATS, is 77% of the
> > samples in arm_smmu_atc_inv_domain() (265 of 345 samples), so I'm not sure
> > there is much room for optimization there.
> 
> Well I did originally suggest using RCU protection to scan the list of
> devices, instead of reading an atomic and checking for non-zero value. But
> that would be an optimsation for ATS also, and there was no ATS devices at
> the time (to verify performance).

Heh, I have yet to get my hands on one. Currently I can't evaluate ATS
performance, but I agree that using RCU to scan the list should get better
results when using ATS.

When ATS isn't in use however, I suspect reading nr_ats_masters should be
more efficient than taking the RCU lock + reading an "ats_devices" list
(since the smmu_domain->devices list also serves context descriptor
invalidation, even when ATS isn't in use). I'll run some tests however, to
see if I can micro-optimize this case, but I don't expect noticeable
improvements.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
