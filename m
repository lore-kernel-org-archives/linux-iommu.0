Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3C3B4EBC
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684050; cv=none; b=KKOwZ4XGszFKkgDa2/bKClEVsrswRb3VnM3TCFHlVOmvjZf2nFyzECR2bOkA5G5J/Hms5+fAOTTuhLo3zA8PmTcnIVHrE/DR9SusbDGKMfxKioLjZaTGXC17RXPiwHfZxGiZ1gOxIr368T5AcjBzqmaDAjY+7WUdYcAbmUXNcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684050; c=relaxed/simple;
	bh=kSeqEMv4c0TIXvJNC6U0eYQuiZfdEArf9fpPO5s7Iq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnFbVvp39I0G8ol5wlUDzIaIzM1rwnmLiTdIyVZxV7Owk/2phF4hxQ6ArAfUadk+V+gPP1Rux7nUjyy5hVmidDplqqPhci9HQxGws/vo4FUFKDoDHxSHSa3DXRv9MbXKUVskafl+Fy3KMSvJygDBUhXnlikFrAcbjBdS89zppt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEMz8c7J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEMz8c7J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b440b97aso21365ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684046; x=1788288846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avc+7hYLny1ws5AL8S1cDvx9iKCyG7U6wgDEUD+H2ug=;
        b=TEMz8c7JKkL5FmVVexKxfJ0/ZqxdcUhX3dc6V0G1MMk6n9plaWPHggeQoMyLqXPzMV
         +QBxZGkH7scODPccZ+cUCxcD/8fvXz4ljDVfLz/C/FyrCkhlYpGHvIgskiMxtJraWw6/
         SoiXTUoFYXFbziYsrzmosOG+6+0I8UGXDMcqsYIcyx/ETF93nJoTRT7ttQiLXfUj646n
         EPhD0Z8SiJ5ZUFw/jcoFqra34IBig2O1txJ92Qjya2M+XUkdvct29tMpndesd8GEA8F/
         u9N79W66HA74EvKMoAQ02MoYPLa7hBafF6eaV2osYQnm0vf58FxGWkSXD9y0ZPr6CzDq
         ViVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684046; x=1788288846;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avc+7hYLny1ws5AL8S1cDvx9iKCyG7U6wgDEUD+H2ug=;
        b=E5uwkL4dE5Y/4Z2rEs0bB/Cfe/n4bF6FNyZTP2crN6QevukTa6T00RTQB8XQedySIk
         jlfSIRSTASm6Vq9cmGxzo94dqHobz1ycepddhoaysGo9CAzdUNp7vDCrhEfMDTvcRwOi
         23/18SOOYZuU7MMlUdnhq485aBQL82MN5G09x2IrzPNoX0sR8m4V7ff/f6BRld9MF0fT
         OUx4FVNnhK87t5nGKdpjpYRoSoGSjmHwOKkSscLhPYHhKFu7+uNYzR0LK9woRanQCAOu
         kXvv6X0GMReO2h4wvqe/vN69gEHpPQvLU4JHi7DU3T+CekGkG56fND3y/qMC0XxblbBQ
         WoQg==
X-Gm-Message-State: AFuF++nT0bcAg+AgffndJGYss7VRh0G9SHZO74uBPBgIfTgKcNo1css0
	msP85ivRiyw0fpvvU+h1xl6GiacexP7ECjsQPlLfvRQvzacR5YkA5LYX1gIMEbAzj0mRyCDkoWL
	wtJt2kA==
X-Gm-Gg: AR+sD10+fvMyZIqw1iTybs5ZWtHeV97E3OzTp8vws5oPo8W0EawXBfOxp7fRmwv8Sod
	NLZQhwiBFyiKSPniPdbWgJwY7j8ApITsIBBsjjEEAYtJh6gdLi3QoeBHNYlbiiY0poZV2VSxDJf
	NPLPhzhfVopW4yFyNmbJ2+S2xCLbWG4dkGAmQtnciIJ62QKGc0iQYsZqYORjfnkPCK3pl/7it12
	kcJUPHoh+9UVyudEgX152GCEGG7EiewaQtl3AWAgfKzq2fru6gIH4VDPPPzm/RieR+Tplz/K4zn
	omHqcmBGxzyKkn1fFpw6gB9x6e3y0Um/sQgdHHzFiHSk6F0YIgMQzOYb/uNFK3mLXWkeMpTrtOh
	mRHtGNgV4WjNdS4+bMRNe1l+tihCwT1Ui26j3/IB4PvcmeE6CF24HB8Yk4NLu/6nyTJ/tZp80SP
	ztnaVaPya39GG7Fa2HVNRtig93NYok0lO6WtMlsWy/HhFt4hj9dkgF8O1RHOscINVXjsJi879jr
	rYa1gYO3zPiKwZGKxwQo/lBRw==
X-Received: by 2002:a17:902:fd85:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d707b557a0mr614755ad.3.1787684045715;
        Tue, 25 Aug 2026 11:54:05 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39667fe29absm794247a91.0.2026.08.25.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:54:05 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:53:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ao3kxwbwB9GC3EOM@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-10-praan@google.com>
 <178767577113.3356902.28128835506777632.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577113.3356902.28128835506777632.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 80 lines skipped ... ]
> > @@ -730,10 +770,58 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >  
> >  		/*
> >  		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> > -		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > -		 * our new indices yet, we can safely bail. Once the indices are
> > -		 * committed, we MUST write valid commands to those slots to
> > -		 * avoid indefinite polling in the drain function.
> > +		 *
> > +		 * This loop acts as the Point of Commitment.
> > +		 * The CMDQ_PROD_STOP_FLAG ensures that no new commands are
> > +		 * committed once the SMMU begins to suspend. The synchronization
> > +		 * relies on the following observability invariants:
> > +		 *
> > +		 * 1. Other CPUs observe the STOP_FLAG only *after* the SMMU is
> > +		 *    disabled. This is enforced in arm_smmu_runtime_suspend()
> 
>  [Severity: Critical]
>  If an ATC invalidation (CMDQ_OP_ATC_INV) is issued (e.g., during iommu_unmap
>  from a background thread) while the SMMU is suspended, the command appears
>  to be silently dropped here.
> 
>  Since ATC caches inside PCIe endpoints might not be globally invalidated
>  during resume, could the endpoint retain stale ATC entries upon wake-up?
>  Would this allow the endpoint to DMA into freed memory?
> 
> I agree.. I think there are only two options?
>  1) After GBPA=Abort ATS requests are blocked, so you could full
>     invalidate all the device ATC's and now it is safe to ignore
>     ATC_INV
>  2) Just don't perform suspend once ATS is activated

This is a little tricky, I'm leaning towards 1) since edge devices can
have ATS enabled

However, the EP might've entered it's low power state by the time we 
reach smmu's suspend. I'm not sure if we should be waking up the EP for
ATC INV All (or if it would even wake up in such a case?)

Praan
