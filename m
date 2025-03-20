Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522C21CC40
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480486; cv=none; b=SYytlnDHf+phrNNEQOSJduBbx97rMYqCKevoq4yrVoALf+OXz9Opga2rjsU0MMrFCekzATKwTua3u4VF1S28xaytK5EXsWMI+OhCn1Kc0GVT5w1pCcAnb4GdU3iRRpmmamrX05N76c3gl7rkh0WctB/IcH0tBgGMSFcDD9TL74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480486; c=relaxed/simple;
	bh=EpS9FmHVtzChZTxUzmrDbCoRFdcb8Qo9gWW2v2MyKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAPt1GwHo8o/UggOKT9oC3fkzRkqCp/ThnugnB/U9pAyzjdl4J6NUaG7De3b1h+bBYJ3/IxQsf7WvHMLsirU7NBDL5VfNRp9sjLOwLVc8PWdZr4n27QdNmiYNRZJQPIlUAsTo8z+PpV/TfWz87B5fuYJmclvoDGec/QaC+iQuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrXhXoTJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrXhXoTJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso152745ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742480484; x=1743085284; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0e+3b57TnpWHbWhrdPwGKeQWZnpg48F8Kx6mQBBFG18=;
        b=RrXhXoTJ/7RF8h/QvtIvTl1F52SbXxD2rSG9U/Xs9rotUcSam/1QFWL+KiLKA/4PQT
         ir3VJTgNd2tZpmhZp6XSxLRaoQNmHeanSRN7wllxbv9DYDYLEqb3ePOsRPhPRTA8Zl6+
         laN3T6dapeI6oCQRLB19H9EPRrXOeoC19FXTiWjkyrwELr/ji6/oEUJUB96xeO2PMrvh
         BHXXMz994a1rx8EQFz6AH4AFSKOrpzRAmKIBsyeqoBswmSBE9UWCVGO4onxCITegq8gr
         NOyYaJMmnm8bLhVU89hyDbVAaKk3laUVw0aBnvn3NJCyXxR8vpltWKfrTEoYTXGiN0R7
         FLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480484; x=1743085284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e+3b57TnpWHbWhrdPwGKeQWZnpg48F8Kx6mQBBFG18=;
        b=C9cE4MQBEmT8owY6K+50bcuFuMOGRO27Eq579QoI8dyiro0S4MlAZALVTfCQyDbl1C
         h5zWZFdqPpdTalgiUmmdsm5g982QFFuDdz/nJqU1nsZU1LU4KAA0T4Uuzvfp7LDwuExu
         Hc5ZHfwQPlM9UZj1WzuB7KSHx36N+aUmdzA5Uw9mGVHgaLJq4pvn8Qk2gQ0YAzxqXfrn
         jIfFCe1g8L56/5FAtKJ7cLqrX/mgL/2GirgFPEmGCEF5s5Q6d4GrpNj/BbiQ7liiMJIE
         AcalH58io5ZXPhXtvO1XLWqyUucXQ2sWN0x3kPJXnX4TwAal4yqbXhvJ+pDk+I8qGcOu
         B+cA==
X-Forwarded-Encrypted: i=1; AJvYcCVLDHCn6C6WYog4m/jwJIgYQk1d7Ym0Dt6Rd7bycAif+z6l9d/zHU/+T/zqvKYH/rNovw/SEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh+MIFmLenbWt+m1nbTSKlqqovj9fMDl+vTkpygav+z8U8LZ1c
	EPejAo8FMi+sdJgbmzReRgToXKZFTET93PI1wWPGTxheL2tppLsVz+zjD36WIQ==
X-Gm-Gg: ASbGnctgE2Ltd9TBfvnntfrAAki5fWPQxc3N5Fc97w1kHFlGovZQrM6jHpmsXh9qMJA
	IpYd1wTkPxWEqia4WAEQDSJiam4uSP7kbPn6j6f76w1DZFOp+mWEFhRRxTx/WvrQdHaUnoDpOb0
	psfLwJOsK7+b/5E9P+fAgOB6TFeuM4XswetkGsJAHjbNHmug1qVABsy33ZIWbF7/vyJhklI1PY8
	jd+R+Lhn3TUksFK8a/C0YVf9juYIeIjz3+Udsp4THaNxsf9Ie1MFdVh2NtcFP4+jYPR0b+jlsgy
	CwydxNCu8FKor05QdRkSivXO+aBbJLx2ybgMN8GjIWrT/sjZHJEFfapgVuUdCSKprAQitHRJkAJ
	JXEs=
X-Google-Smtp-Source: AGHT+IH4AVHYLU/XtOOAb0l5nLLNVwMoBrgkTIA+LU03h6EKy8AeAW7Z+E3yJaHqSJYTphgv/gWwfg==
X-Received: by 2002:a17:903:2448:b0:223:5182:6246 with SMTP id d9443c01a7336-22661fec2e1mr2243605ad.23.1742480483398;
        Thu, 20 Mar 2025 07:21:23 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155aa8bsm13754579b3a.70.2025.03.20.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:21:22 -0700 (PDT)
Date: Thu, 20 Mar 2025 14:21:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <Z9wkW8KVEZFUKQIs@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com>
 <20250319120404.GD10600@ziepe.ca>
 <Z9vCwLbwwjn-gVJ9@google.com>
 <20250320125421.GJ126678@ziepe.ca>
 <121319f7-2af4-4a3a-955b-9bbae09aa92c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121319f7-2af4-4a3a-955b-9bbae09aa92c@arm.com>

On Thu, Mar 20, 2025 at 01:22:07PM +0000, Robin Murphy wrote:
> On 20/03/2025 12:54 pm, Jason Gunthorpe wrote:
> > On Thu, Mar 20, 2025 at 07:25:20AM +0000, Pranjal Shrivastava wrote:
> > 
> > > I agree, that we can elide TLBIs if the smmu is asleep (powered-off),
> > > the main reason to wake up the hw is because `arm_smmu_write_ste` issues
> > > a prefetch CMD. Again, it is possible that the smmu sleeps after this op
> > > and the prefetch has no real benefit.
> > 
> > Does any HW caching survive the power off? I was assuming no.
> > 
> > So it is pointless to issue a prefetch and then immediately power off
> > the SMMU and throw away the STE cache.
> > 
> > IOW if you don't know that the SMMU will stay powered up after the
> > attach there is no reason to do a prefetch.
> 
> And even if the caches don't lose state in hardware, we'll explicitly clear
> them on resume anyway. Furthermore I'm not aware of any current SMMU
> implementations where the prefetch command does anything meaningful anyway,
> so right now this is absolutely a non-issue.
> 

Ack. I agree, for the next version, I'll use rpm_get_if_active for
any TLBIs / CFGIs and Prefetches and otherwise elide it.

> > > Anyway, having *any* rpm implementation that causes us to lose TLB
> > > content, will cause a hit on the performance, so maybe this
> > > micro-optimization isn't worth at all?
> > 
> > Right, it was my assumption that you loose the caches. I would guess
> > keeping all the cache SRAM powered is a big part of the power budget...
> > 

Right. I think it's fair to assume that SRAMs aren't retained, even if
they are, we anyway clean everything on resume.

> > > Also, while we're at it, should we have a feature switch for users who'd
> > > like to disable runtime PM for performance reasons? I don't think that
> > > relying on the `power-domain` being present alone is sufficient.
> > 
> > I'm worried about how much this will hurt server workloads. Optimizing
> > invalidation is a worry and you've gone and put in some more atomic
> > write traffic on shared cache lines. Not great :\
> 
> Indeed, that was the reason for wrapping the RPM calls in explicit
> pm_runtime_enabled() checks in SMMUv2 - see the comment in
> arm_smmu_device_probe() - on the assumption that servers wouldn't advertise
> a power domain for the SMMU (not least because we've no support for such a
> thing under ACPI anyway).
> 

Yes, SMMUv2 is what I referred to for this. So..just checking for
pm_runtime_enabled based on dev->power-domain should suffice then?

> Thanks,
> Robin.
