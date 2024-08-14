Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B41A00D6
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629490; cv=none; b=cLgJQwVYA+5QJx01H2xKCTaYb1ugN1xHlz5rpnWdqEtrxzyJ2GUeI5SqUSI3g0xfQtECTlu8nTdbns3gVK9zJBdJTNjIi+m/gysAWjrjrBAC8nVCRQ6axEKnG6tG27fs57M9B81CLQT8UOpXroAIszsFqdhMyYGpoqM1kM6mNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629490; c=relaxed/simple;
	bh=ywl8XmyS9mHm+0bQOP27BgcWEnPO1Bj2PrL8OOlKNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtjSm+RXbFlF3CVdURTaxBvu4xsCQB19cRf+ylkCCYOj77xzqknp51UTZ1Txg6xUm19+hzhwwP4VzHa4GC0HCXA/W9/FPNSavAs4k1WxXNUo5X10UIGs+/MRqs2vAISEEqg/OCORPxbwxNgxw5v7gqil1fy3CCUjnB3xRXK/CXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jH4sYqno; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jH4sYqno"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so4648a12.1
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723629485; x=1724234285; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XNPiYAxD0nXeda3XoGkXcfBa5gPOVQX7S7Zbc6+r9Yg=;
        b=jH4sYqnoO0+uQop+93z8MKR5Przj99zrD53lO3fgP1iQlznN3yTPSHQkcPUZ7RD1YX
         SiNEM2wxvZfXXfKSDx6VKJ5bcBIbNaEdBxHQM2hWQMAlrpyzHrWxB8Wg92U5BY7w59+D
         R4c+xsrvtCalF4bhoCu3EHVcc3F1K1bCXe58USGCWZQ/FQfakPHvMTW2SSbEWZaFk5Hk
         WHYpBjNMzSh70VWSP8/dxVb61B5RWKV63itSqUlZMUZCPydIxVPMmYD3x8DsOy3FP+GC
         HFugTKxC3LvR/5XUSobaLDDn5eoPp3SaiOiuv7EhQbaAbXtWwuO333ks4cKarhZQN1wK
         uB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629485; x=1724234285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNPiYAxD0nXeda3XoGkXcfBa5gPOVQX7S7Zbc6+r9Yg=;
        b=Rb7QjsMyeCXHQU/piwGYfU81HCSK6Jg1HBW8NRdyYD2VFES2SsPE0jBvQ2/YLx4uGE
         eWzfLnPAhOx41S/dcSNwnQn0heA1OC1T7Ee/0qzYhHYwRVCLdSx+++5/AuSFqBQQ6Dbz
         j5q20Z2ymwZgQ8pm1c+C3rudHPw3Nst72RNdwNF40pvrbgG9NAoiP9xxLF9s0DO2drXl
         Cut+50FuWJCJtXrCIPBLqPuhVhW4QNXwuCLwQwQKD7CI6B57Ha3HlELmyHbin8VJLucV
         jMf5h8BewZiQWxJMYg2g69HoS+Gr1uNWln/Ya2zPiHfIVstsDXTI2BDruq2hBrOBmXqA
         2m9w==
X-Forwarded-Encrypted: i=1; AJvYcCUSMYz/vi4N26yMvpyLiwMy/AiXQ4ErFo8Ac42EqyrbPApfnZrvNE2ZHvlmPU31k44/FKBQDM7pfSCF1I0fPgo70INorWY=
X-Gm-Message-State: AOJu0YziyZwosbRFOTIDMPyBQjkzeQlQo58PItVOVsCBDKXVsKZ6QDAx
	ReL+aSFYE0ij2SSOqtNNpSSem860h3LgPbXzDn08uz+uwiE3hoVfrLyy38FGaQ==
X-Google-Smtp-Source: AGHT+IGOoeQSGPXnP0Clm+mJgyY7hA8NUckb53WhjJatTU+/3rVRLEqRqMqPYgosUnSxt0miWa/RPg==
X-Received: by 2002:a05:6402:3481:b0:5aa:19b1:ffc7 with SMTP id 4fb4d7f45d1cf-5bea28067bdmr77383a12.2.1723629485134;
        Wed, 14 Aug 2024 02:58:05 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded31c5esm14718735e9.13.2024.08.14.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:58:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:58:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
Message-ID: <Zrx_qO1iHwbr4ctO@google.com>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
 <20240813175155.GN1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813175155.GN1985367@ziepe.ca>

On Tue, Aug 13, 2024 at 02:51:55PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 08:52:55PM +0000, Mostafa Saleh wrote:
> > Previously, S2 stall was disabled and in case there was an event it
> > wouldn't be reported on the assumption that it's always pinned  by VFIO.
> > 
> > However, now since we can enable stall, devices that use S2 outside
> > VFIO should be able to report the stalls similar to S1.
> > 
> > Also, to keep the old behaviour were S2 events from nested domains were
> > not reported as they are pinned (from VFIO) add a new flag to track this.
> 
> I'm not entirely clear on every detail of this stall feature...
> 
> But from a core perspective device fault reporting should only ever be
> turned on in the STE/CD if the attached domain->iopf_handler is not NULL.
> 
> If it is NULL then any access to a non-present address should trigger
> some kind of device error failure automatically.
> 
> This is new core functionality since this code would have been
> originally written. Now it is all handled transparently by the core
> code. The driver should just deliver all fault events to
> iommu_report_device_fault() and it will sort it out.
> 

I agree, as there is no iopf handler in this case, we should just
report it to the iommu code and it will reject it instead of tracking this
in the driver. And as all the “enable_nesting” stuff is going away soon
anyway it’s not worth adding extra code for it. (plus we shouldn’t
really assume the intention of caller)

> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 8d573d9ca93c..ffa865529d73 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> >  	struct iopf_fault fault_evt = { };
> >  	struct iommu_fault *flt = &fault_evt.fault;
> > +	struct arm_smmu_domain *smmu_domain;
> >  
> >  	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> >  	case EVT_ID_TRANSLATION_FAULT:
> > @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > -	/* Stage-2 is always pinned at the moment */
> > -	if (evt[1] & EVTQ_1_S2)
> > -		return -EFAULT;
> > -
> 
> This makes sense at first blush since the domain mode shouldn't define
> if events should be processed or not, and the events should be failed
> anyhow right? If someone did turn on fault reporting in the STE then
> it should always be processed to conclusion.
> 
> >  	if (!(evt[1] & EVTQ_1_STALL))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  		goto out_unlock;
> >  	}
> >  
> > +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> > +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
> 
> Strongly discouraging drivers from calling iommu_get_domain_for_dev()
> in async paths like this. The locking is tricky and the core code does...
> 
> > +	/* nesting domain is always pinned at the moment */
> > +	if (smmu_domain->enable_nesting) {
> 
> This is not necessary - a nesting domain will never have an
> iopf_handler set.
> 
> It immediately calls iommu_report_device_fault() which will reject it
> because of:
> 
> 	if (!group->attach_handle->domain->iopf_handler)
> 		goto err_abort;
> 
> Which after the rework will end up in find_fault_handler() at the top
> of the function:
> 
>  https://lore.kernel.org/r/ZrTNGepJXbmfuKBK@google.com
> 
> So I think these parts are not necessary.

Yes, I will remove this patch and squash the removal of ignoring S2
events.

Thanks,
Mostafa

> 
> Though arguably we should be rejecting domains with iopf_handler set
> in some of the attach calls..
> 
> Jason
