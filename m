Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B47C47259
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 09:15:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F042206B8
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 09:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXWA/MYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F042206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36AA186670;
	Tue,  5 May 2020 09:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KIJelu4JpiCF; Tue,  5 May 2020 09:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5ED08638F;
	Tue,  5 May 2020 09:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75865C088B;
	Tue,  5 May 2020 09:15:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8FDC0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 08D2A864F2
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68RqHHUPRuQ4 for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 09:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EE3848638F
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:15:42 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e16so1808850wra.7
 for <iommu@lists.linux-foundation.org>; Tue, 05 May 2020 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sU7U3FhjLtetQ4yGftkHmkBqFM+M9ZWPk430QlcmjSw=;
 b=QXWA/MYxeBeYOjAoqaNN2WaAGPU0Tv3zhPwTqxa96+5wzt9CdxYYAAOCUz6pWhuzUl
 933MuJKNFPVD3w9C/QvD/C0e6iA+FZPTltexAp+raUdXk9hamFndUJbWV2K4iPOJiiz7
 mqMyTD/SmVD6T8yeuC7kKEIaQK7SAcsO3TOplzzSgBS/tPHNt0Is/ZMyXCEdT7r2D46z
 FIOLqY+T6XzzhHEgdFXwAFjHT0v74ZucOnNkxFTOaVA8+6OV7MLwC5bHsfh2sv+sT888
 szyzUg2wNsB84mYvmwLGhiEl0EZfJEPVQVC4y7fppcLdtB5gerYO6mRdLiS7XmYwmwZ0
 XEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sU7U3FhjLtetQ4yGftkHmkBqFM+M9ZWPk430QlcmjSw=;
 b=ZEasjr+/GbO+iMSUKDADX2wQWM7kvdWoFH6SiqFbw0a5gPg6CpZNJzKFGU9bLT9doc
 9ORxblQbOlEhYro5oXL4FsZ3frMu4iqv64q3w9pnu56YYVL1pyibniwAXdcE2wVPY2YL
 YKAMQUCI5iK1XO0Z35SiuDVd33atX2F/eNdat7JZlHiqY5bSemjpDtTRSs2XGcg5dWeF
 J87NVuAs1z3ezkxe0s/EDejaFQ5qf73YDW4tURBwJmiXEmq0og2Dl4FtMrYNoFMf2hxM
 nI+SSGE3FH1Tjlreb9zgI/OJM7bQRaRMZ0hFKvz+M2c43/8L4flHf83T14CP4/M3Q9Ln
 T40g==
X-Gm-Message-State: AGi0PuY0L++4JnAYdM2zEC6VeXcrcx4rJzN7cgM0hx/i6XtydDXrPwyj
 4fAKysEGmHycDAiCmoHfzR0Axw==
X-Google-Smtp-Source: APiQypLUdwS9EMNq1wqY/xPjJM+u52dIVylq937W1BwIZPG2UftDefGXQhpqhk5pltip4j2URFGphQ==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr2063792wrs.19.1588670141301; 
 Tue, 05 May 2020 02:15:41 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id c190sm2856893wme.4.2020.05.05.02.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 02:15:40 -0700 (PDT)
Date: Tue, 5 May 2020 11:15:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200505091531.GA203922@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200430141617.6ad4be4c@jacob-builder>
 <20200504164351.GJ170104@myrica>
 <20200504134723.54e2ebcd@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200504134723.54e2ebcd@jacob-builder>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, May 04, 2020 at 01:47:23PM -0700, Jacob Pan wrote:
> > > > +	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid,
> > > > &invalid_cd); +
> > > > +	arm_smmu_tlb_inv_asid(smmu_domain->smmu,
> > > > smmu_mn->cd->asid);
> > > > +	/* TODO: invalidate ATS */
> > > > +  
> > > If mm release is called after tlb invalidate range, is it still
> > > necessary to invalidate again?  
> > 
> > No, provided all mappings from the address space are unmapped and
> > invalidated. I'll double check, but in my tests invalidate range
> > didn't seem to be called for all mappings on mm exit, so I believe we
> > do need this.
> > 
> I think it is safe to invalidate again. There was a concern that mm
> release may delete IOMMU driver from the notification list and miss tlb
> invalidate range. I had a hard time to confirm that with ftrace while
> killing a process, many lost events.
> 

If it helps, I have a test that generates small DMA transactions on a SMMU
model. This is the trace for a job on a 8kB mmap'd buffer:

  smmu_bind_alloc: dev=0000:00:03.0 pasid=1
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e6000 pasid=1 group=74 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=74
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffff860e7000 pasid=1 group=143 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=143
  smmu_mm_invalidate: pasid=1 start=0xffff860e6000 end=0xffff860e8000
  smmu_mm_invalidate: pasid=1 start=0xffff860e6000 end=0xffff860e8000
  smmu_mm_invalidate: pasid=1 start=0xffff860e8000 end=0xffff860ea000
  smmu_mm_invalidate: pasid=1 start=0xffff860e8000 end=0xffff860ea000
  smmu_unbind_free: dev=0000:00:03.0 pasid=1

And this is the same job, but the process immediately kills itself after
launching it.

  smmu_bind_alloc: dev=0000:00:03.0 pasid=1
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffffb9d15000 pasid=1 group=259 flags=3 prot=2
  smmu_mm_release: pasid=1
  dev_page_response: IOMMU:0000:00:03.0 code=0 pasid=1 group=259
  dev_fault: IOMMU:0000:00:03.0 type=2 reason=0 addr=0x0000ffffb9d15000 pasid=1 group=383 flags=3 prot=2
  dev_page_response: IOMMU:0000:00:03.0 code=1 pasid=1 group=383
  smmu_unbind_free: dev=0000:00:03.0 pasid=1

We don't get any invalidate_range notification in this case.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
