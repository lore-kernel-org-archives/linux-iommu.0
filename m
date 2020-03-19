Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0580C4332D
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 18:44:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F6F20789
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNzAMLhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F6F20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5FEC287EEC;
	Thu, 19 Mar 2020 18:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIjDZavxjoX7; Thu, 19 Mar 2020 18:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7406487BF6;
	Thu, 19 Mar 2020 18:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 611F5C1830;
	Thu, 19 Mar 2020 18:44:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F068DC07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE9E085F8F
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nI4IRIQ0-BnD for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 18:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E924E85F11
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:43:58 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id c187so3782872wme.1
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f1kms1Cp/S2DCNW4uMZAVbQmKNgPwaRHV12JI4NkA+k=;
 b=dNzAMLhw75WU5RcG4cJ+2HatI0E22qaBvjlv3rCvndXOyGtc/64t5TMsMf4tV8IfAQ
 wYF5O9N+dgIwOi1qU5hWj5bX8pmQBWcFypnTUqAGPsaG3estI7OtLCx9x00gDI4K5wYu
 z2lGutpQhjrYpZ/WkQr75sJXd2j8zooRdLPBYqlO5ifndp+NiFwVFszcbgmdAVnMjoXm
 /85KdbaX+lP7G5fNJODNceuAbjLPBx5ce6wImXqV7mOah0l2KmXHN/p9oQSiM1o30KZx
 v3yV9wQlZePdo14/vvjTwKVQf1OvMCS6hfXUKar0V4QMjLAx39tayU/yt3EMtEi8LHQf
 kOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f1kms1Cp/S2DCNW4uMZAVbQmKNgPwaRHV12JI4NkA+k=;
 b=QJzRItRwOT2eTA7Dn9HwcFrnIrb3iZVm/y89+ApEdO3miYU3GPfIog+O8CVFGfPGHU
 fDRjchR+4XVwyoKfgST6mp7iO5DwMRT6Sco/hN4HaFxnyMntWGKy1CEjPl7F4bC6RD4u
 QFEl00QUjI84lHYoSiXR7/u/XuRkvPZoKkyr8qizagTyG/szP7rds3KCstrtHgHce/wy
 mtjWaVMBsaz3DanCTbmMIAd5BkuE9GyBYcitUNoGnhFKIF/8T5eBt2tKJDg8qNOJPaKP
 XPiyBoMQ+elFp1zv0CwsU5O4zQ6RDr7dObzokjr76jN1Rr8AiPVPdhBYtYss0cL2AWd6
 ZEfQ==
X-Gm-Message-State: ANhLgQ0nV5wMt41/L6Jw27OhhOHY0gxmgYGbv0EwmPN0xTQlwGen91Vj
 WirW0Pw+SqTI5EPXuQe5jAA1EA==
X-Google-Smtp-Source: ADFU+vtbENZvabZKtdw/DPbM6HU5AkeGexLxr2JVlNZfunhx7YefxB85Pmura26rapoHfeAtJTCh0A==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr5461989wmk.56.1584643437270; 
 Thu, 19 Mar 2020 11:43:57 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x3sm3241463wmx.44.2020.03.19.11.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 11:43:56 -0700 (PDT)
Date: Thu, 19 Mar 2020 19:43:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
Message-ID: <20200319184349.GA1697676@myrica>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
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

On Thu, Mar 19, 2020 at 12:54:59PM +0000, John Garry wrote:
> Hi Will,
> 
> > 
> > On Thu, Jan 02, 2020 at 05:44:39PM +0000, John Garry wrote:
> > > And for the overall system, we have:
> > > 
> > >    PerfTop:   85864 irqs/sec  kernel:89.6%  exact:  0.0% lost: 0/34434 drop:
> > > 0/40116 [4000Hz cycles],  (all, 96 CPUs)
> > > --------------------------------------------------------------------------------------------------------------------------
> > > 
> > >      27.43%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
> > >      11.71%  [kernel]          [k] _raw_spin_unlock_irqrestore
> > >       6.35%  [kernel]          [k] _raw_spin_unlock_irq
> > >       2.65%  [kernel]          [k] get_user_pages_fast
> > >       2.03%  [kernel]          [k] __slab_free
> > >       1.55%  [kernel]          [k] tick_nohz_idle_exit
> > >       1.47%  [kernel]          [k] arm_lpae_map
> > >       1.39%  [kernel]          [k] __fget
> > >       1.14%  [kernel]          [k] __lock_text_start
> > >       1.09%  [kernel]          [k] _raw_spin_lock
> > >       1.08%  [kernel]          [k] bio_release_pages.part.42
> > >       1.03%  [kernel]          [k] __sbitmap_get_word
> > >       0.97%  [kernel]          [k] arm_smmu_atc_inv_domain.constprop.42
> > >       0.91%  [kernel]          [k] fput_many
> > >       0.88%  [kernel]          [k] __arm_lpae_map
> > > 
> > > One thing to note is that we still spend an appreciable amount of time in
> > > arm_smmu_atc_inv_domain(), which is disappointing when considering it should
> > > effectively be a noop.
> > > 
> > > As for arm_smmu_cmdq_issue_cmdlist(), I do note that during the testing our
> > > batch size is 1, so we're not seeing the real benefit of the batching. I
> > > can't help but think that we could improve this code to try to combine CMD
> > > SYNCs for small batches.
> > > 
> > > Anyway, let me know your thoughts or any questions. I'll have a look if a
> > > get a chance for other possible bottlenecks.
> > 
> > Did you ever get any more information on this? I don't have any SMMUv3
> > hardware any more, so I can't really dig into this myself.
> 
> I'm only getting back to look at this now, as SMMU performance is a bit of a
> hot topic again for us.
> 
> So one thing we are doing which looks to help performance is this series
> from Marc:
> 
> https://lore.kernel.org/lkml/9171c554-50d2-142b-96ae-1357952fce52@huawei.com/T/#mee5562d1efd6aaeb8d2682bdb6807fe7b5d7f56d
> 
> So that is just spreading the per-CPU load for NVMe interrupt handling
> (where the DMA unmapping is happening), so I'd say just side-stepping any
> SMMU issue really.
> 
> Going back to the SMMU, I wanted to run epbf and perf annotate to help
> profile this, but was having no luck getting them to work properly. I'll
> look at this again now.

Could you also try with the upcoming ATS change currently in Will's tree?
They won't improve your numbers but it'd be good to check that they don't
make things worse.

I've run a bunch of netperf instances on multiple cores and collecting
SMMU usage (on TaiShan 2280). I'm getting the following ratio pretty
consistently.

- 6.07% arm_smmu_iotlb_sync
   - 5.74% arm_smmu_tlb_inv_range
        5.09% arm_smmu_cmdq_issue_cmdlist
        0.28% __pi_memset
        0.08% __pi_memcpy
        0.08% arm_smmu_atc_inv_domain.constprop.37
        0.07% arm_smmu_cmdq_build_cmd
        0.01% arm_smmu_cmdq_batch_add
     0.31% __pi_memset

So arm_smmu_atc_inv_domain() takes about 1.4% of arm_smmu_iotlb_sync(),
when ATS is not used. According to the annotations, the load from the
atomic_read(), that checks whether the domain uses ATS, is 77% of the
samples in arm_smmu_atc_inv_domain() (265 of 345 samples), so I'm not sure
there is much room for optimization there.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
