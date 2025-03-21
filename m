Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C613AD38
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566748; cv=none; b=CXJSgK6ixDwGQ/F1y/8xt8MRXmYvMuC8sGd6SegsRTDcUJLVZ7Jssdhui90ksiAuU93X441994Rdr97gGwUviEQ99FS80QIuxys9f8NTj2+wINTVB7PehfwwFz6/irGG5EC7srWoeDd5O3Nxu8BOAduRaRfO5Xkze5H52SWINHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566748; c=relaxed/simple;
	bh=osw4F8zu7JSuC9698OLrxDbgrb9j5dhcg2G7NA+VtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDAlFmY0FSAFnWmtC/nHHl0/F+Wsu9Q+ElOLzAZQ8LsoANKD4CDsOyog2fLX+FQs61/hYha7NukltR7KaKZkGktDTVvrIt80qWPSO/ux4iXiO1VjYjXrDqm22KIodf2Fhiim4PXoOWTxLSE02bwjElvTP44j662gw8OYVlara1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJ+uU9fa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJ+uU9fa"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so232365ad.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742566746; x=1743171546; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIEZ4kpTUBu+id+Vmhu0rbHLleCDWNMmuP45Ao49wIE=;
        b=aJ+uU9famyyp9IaZUI3BcuNh0dQrzbrJEiwOfX2JUTMV0Y/Pw1uUUs0ahUJU6AQmgA
         MUilyZ0MI9x8PDdOQqmclK+0Y8yHw1btxXzcW/sVA5QwLxNaZF4ILL78qBaHBicZH649
         z4pYnCobeXSebvo/FlcmtWSBz0795MAZiRgZm2uZS3lUdWWlhL/8oDwdcakDc2CKlhJd
         jqHxRhEg8ap0uz0yxMOZ3C7wC7s0PUA3K8l3UB7sHD404w+TPVT7Jfm38fwNW6boppn7
         5M4fewjgbpEmnEST0Lh5b0bEpumfePMHL3m1WT9DAwn8NS/DnuYx1MXFEONdDp0QuCp0
         PfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566746; x=1743171546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIEZ4kpTUBu+id+Vmhu0rbHLleCDWNMmuP45Ao49wIE=;
        b=H8pEtCsc1ubqUw0nFdo4yOLb3/DPzd3BCXmP4OljburKi0rdZiojrs6MQmaMDS99oK
         oewIcORqDeCNVqjVadJje85nQ9bjEgmG5lNkQUnz7WT/3xltja8UXNleUoeCQiUEliC6
         uU3U3EikuZ05fL2amQQ5kgG4DVihg/ZbS7xlQqh5u4Ab5tJ+nwnS9290lUbj1z4/4Idl
         SsbnPhY5ytnADPrlDAVjmydKWmQ5dcMeMX0MB0zPInuldI985Jr79Gd4PeY0/kU4Niak
         N3DBb43hxnf8Nyh2byJesmKyUk3StjSZ8hYPYhXQ3n12bb+nTx0pctc7rZxJlkWCDarp
         HtZg==
X-Forwarded-Encrypted: i=1; AJvYcCX0xmelyk+DN98xGVxnHFBNYSdp1mimGknI7fZ0MW+oELjocgwTfqyRZjT+cVaJX36lENQaPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJCvSHFOLS5R503ep/NaUgOTs4qqgeueaERKUCE2+PD9Dl6z8J
	b9b6yNUmZLPqwjeunwzT/Lrclt8p62xLi43tTT/xPSataERMMc+NogTiHtz0xg==
X-Gm-Gg: ASbGncsTkfyKvQ9BI3W2L/yjTaxjzxNDObXNagwGXcF+80QbtKJf1brw8dZQUeL6DvQ
	/fELpEHlwuoklo/iSsP4la/pfgJNBZr8SnPirsJCKxM0S4R9J3AbxEApi0M8B76tnYQaNFGfNCu
	4bqOn8Rdq3uyO/AtQETrLy84NMjGbYPOetMjD/DS276RcLfK2RQPeSzcW0oaNjsdfqK990UUh6T
	LMhaVJldOG0Eqxt3oRXKgFS7khpi1oSQhNrNYqgm2CK/ggPQkb+p9jyUIgmeo6P8kTlRsV6dR81
	Oqfa3IrcWrjoSmI36DPjjVP+dLzLCnQeuYrOmcdMbcH+msCvV+CVWWmbswxoDvaRoQ/neNBi/oL
	JwnM=
X-Google-Smtp-Source: AGHT+IGMZ+AANRQdGIzGRm+CH38EBDOj1n04nrBta03wr9l4Zq2utuMXEC1KPkMApM6RqskV+6zDyw==
X-Received: by 2002:a17:903:98d:b0:220:ce33:6385 with SMTP id d9443c01a7336-227844c198fmr2194215ad.9.1742566746121;
        Fri, 21 Mar 2025 07:19:06 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030fe83d50sm1919704a91.24.2025.03.21.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:19:05 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:18:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z911UT59UnDzRymF@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yV8KsdXnZg1Ppo@google.com>

On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
> On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> > On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > 3. Invoking runtime_pm_get/put
> > > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > > memory, the initial idea is to focus on areas where the driver accesses
> > > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > > 
> > > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > > transactions? Why would ops like flush even be called if the HW is
> > > disabled?
> > 
> > Because once the device has finished its operation, its driver is free to
> > call rpm_put() before calling dma_unmap(), so by the time that gets as far
> > as TLB maintenance, the SMMU may already be asleep as well if that device
> > was the only thing keeping it awake.
> > 
> > For direct IOMMU API users, pagetable update may be even more asynchronous
> > from device activity, e.g. a GPU buffer might only be unmapped once
> > userspace closes the last file handle referencing it, long after the GPU
> > itself has moved on to other things.
> > 
> > > flush is performance path stuff, so it doesn't seem great to be adding
> > > extra calls there.
> > 
> > That much is true - this really wants to be using pm_runtime_get_if_in_use()
> > nearly everywhere such that at most it's just juggling refcounts. There's no
> > point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> > so is inherently going to do a full arm_smmu_reset() and thus invalidate
> > everything anyway.
> 
> AFAICT, there is no guarantees that caches are clean on system resume,
> but as we do invalidate everything that should be fine, but I am not sure

I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
assume that doing so would ensure that TLB hits don't occur anymore. Let
me dig into the spec to see if I can find something regarding TLB
behavior when GBPA.Abort = 1

> how that works with distributed SMMUs where the TBU can still be powered
> with some TLBs that can be invalid?
> 

Hmm.. do you mean some situation like:

 |-----------------------|    |-------------------|
 | |-------|   |-------| |    |-------------------|
 | | Dev X |   | Dev Y | |    |                   |
 | | (TBU) |   |_______| |    |       SMMUv3      |
 | |-------|             |    |  (TCU -> TBU_X)   |
 |     Power_Domain A    |    |  Power_Domain B   |
 |-----------------------|    |-------------------|

Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
Power_Domain A would still remain ON whereas SMMUv3 might assume all
it's clients are down and try to suspend (power off Power_Domain B)
while the TLBs withing TBU_X are still powered up?

To avoid such a case maybe we should invalidate everything during
suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
something to all it's TBUs asking them to invalidate all TLBs otherwise
this is a miss in the arch (unlikely for Arm) as TLB hits should never
occur if the SMMU is disabled. I guess I need to go through the SMMUv3
spec (or maybe the MMU-700 TRM) for confirming this..

> Thanks,
> Mostafa
> > 

Thanks,
Praan

> > > > Instead of wrapping every exposed op with an rpm_get/put, the idea is to
> > > > follow through till a logical common point (lowest common ancestor in
> > > > the call hierarchies) and wrap those with the rpm_get/put calls.
> > > 
> > > Should the iommu core be doing this instead of hidden in drivers? It
> > > seems like there might be better information there about when we
> > > expect the IOMMU to be powered up and working and when it is OK to
> > > have it shutdown?
> > 
> > On the contrary, I would say it's very much driver-level knowledge as to
> > which operations need the hardware accessible or not, and trying to do it at
> > the core level would inevitably end up very pessimistic and inefficient, or
> > at best just horribly complex.
> > 
> > > And maybe in this direction we can do things like remove the
> > > translation before doing a suspend so that flush ops are not a
> > > problem.
> > 
> > Case in point: that would be a load of extra work to do, make suspend/resume
> > even slower, and even then for no benefit, since map_pages/umnmap_pages can
> > still be called on the unattached domain (especially a default DMA domain),
> > wherein drivers may still end up trying to touch their hardware for various
> > reasons in ways invisible to the core API. Easy example: consider a driver
> > calling dma_alloc_coherent() to prepare a buffer *before* it wakes up its
> > client device (which would then also wake up the SMMU via the device link),
> > and deep within that call, arm_lpae_init_pte() ends up calling back into
> > arm_smmu_tlb_inv_walk() because it's laying down a block mapping where an
> > old empty table PTE happens to be...
> > 
> > Thanks,
> > Robin.
