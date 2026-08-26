Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5D3EDAC9
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745349; cv=none; b=TFPrsocc3FCpjf7EsYlF2bYqhg6jIl7wBjwsWs1BM78YcMV50F240bZ+TYhKltOhR7LkDraCioQ2dyjBr71P3p26Wadg8HOgIEM2XfQR6hHLdG6bJr0F63l2MWs45N8o1ZuEBXdl5bCsegceD1vp6/Hp2hLpQ6K1krKV6Hid1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745349; c=relaxed/simple;
	bh=7NwsRyoXIKTYSAfcUIWFfmUfu6PIlF2wQatwMK6Ws8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j713K+V/M5MDj2WwK8JqcWbyMbxzKJUz+Al/C3vgMOt+3JK77lVKIJM60F9kdbCpHRKB/+9wu0I2ZzSHPhRzl43aSi/Ypk/M8hqk7cfxwQrC4EhYila8KIIjr2DWxopXUVCv9pwm/thy08C7WTT4sjS/ykTxzBzh0J4FR26eqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yha8gKdZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yha8gKdZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso106075ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787745347; x=1788350147; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRzukAECeVcAvfomTikVToUAi6wUjRV3nv1Wl0VWz9U=;
        b=Yha8gKdZ8YoIf6MXTmpN+5H782XWfSDihXDqO/wFGlhyCgHB8sSR5f71VrbYwZjx2V
         w6S0cwEkdJAEEH/knvekPGybZIKCAa4LoNfq+U/S6Tsu8ffo746Ln0j06JifHybJw5D/
         fmKyHODd7XN5oO30tXwmOsfRiQVaHITHvvag97dexEe6yVE6Cb0U+1XiFOrRYj3Yi1pJ
         bOW1hjWiqgFStSF2Oyxlk4+yEquPbPjBpRWSu6Ex+IAivXfpcrY1KabcBvmEBrT5W/9a
         JyOQIFnV+tGSltXfvEXEjFq8FxPinEiNSHHPkVkIVCEb3yvd+AFbSTMFBojf7qADqiXj
         25LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745347; x=1788350147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRzukAECeVcAvfomTikVToUAi6wUjRV3nv1Wl0VWz9U=;
        b=k8Hcq7rjZkdjHltH/rd+bpyUahIsZAF+7jGGL1+/ABzXgG6jdV2A5LxOP/ukaV7mSe
         d+GSt/VAcN33qxVNNus26sVyJSzhRbZM//6AVDujiNJSCiR80Keekx1LGujNE0JhSeTH
         V11Tr+crUvA2YubW3VMlQAXJc/RGiD2uB6k0Dlc2S8re0KapPtmR6XfnYV+rxebbWtNB
         hWVPdViWGqML4ZJnee/rbrlbPN0QTSw7Nrm9Q4DerMp46nqB5fTFgJ/gaE/bM4SbQYZP
         EIoAqYuaSBIwvkEmF3hF+uVOtaGTKI2gRRpeoWxr0cFQiZnuLH/PoPjHeaqmLmXEegVn
         BVuQ==
X-Gm-Message-State: AFuF++nyhIVYs/7yKvgTnOp+tu9QzJaC7V1PXhnGhUWajRJwkSd0S1i+
	cljyh1bqah6SdDUM9YkDZlvOkz5p8QszCd6Q4vK4Ogk1GvF0sDRopZ3g0uqXmsDRYw==
X-Gm-Gg: AR+sD12HqqPMINNGPZLZDWFul9aUgNiJUZHmQf17KjEmOElmcIsNU610EfprupVElZA
	qQmoBvvfu9YPxpBXBYATbcxy6yLBBFJ+f4CduTzYzlRwMEu+RJZnG04llvZjLNi2lYl55JCqEeg
	FZPufIB2r5snZBOnyXu9FljTq33//ZiAfgIDI6KvXbJtBLLq3rGGnaG7tITtfFubu/Ph3Qo5L9E
	GzeQM7tWQyRNBa1XgiZXftMBnUdanYlcNcDl0G0ltdNcp1RTPrxKBxsYvE7/lSrlwX3ihSDnpBD
	PAuWugIMhVPGs4/CYCqcD+rxCrbnccosVfJzWDceEJgRy+pHb51nFHRM50r8fa1bc//IOqNdLDG
	8rbasnji4trOXFODW4ldhqV9h7X1DBJDN75E91for6JotdVV5aMbVunlXsEVC+pUCLAiq/aLpTS
	qBtGpVkxGSBQA53t6GFW12t+ty2csMC/FZxEegWASTnUaqWZvXMt+PqqdX/o1ziIaJafjD7s+Gl
	tTPXHWTanoET0hbjtH8O7pZqg==
X-Received: by 2002:a17:902:ec83:b0:2d5:db38:8011 with SMTP id d9443c01a7336-2d70bcdef94mr4704305ad.16.1787745346622;
        Wed, 26 Aug 2026 04:55:46 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beae5b51sm828751a12.3.2026.08.26.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:55:46 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:55:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/12] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <ao7UPKsHiwAFk5BF@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260825133342.GA3332773@nvidia.com>
 <ao3j5FFfKQsctV4r@google.com>
 <20260825201454.GF3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825201454.GF3325090@nvidia.com>

On Tue, Aug 25, 2026 at 05:14:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 06:50:12PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Aug 25, 2026 at 10:33:42AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 28, 2026 at 09:09:16PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > [v9]
> > > >  - Replaced atomic_fetch_or_relaxed() with atomic_fetch_or() for
> > > >    correct ordering while asserting the STOP_FLAG
> > > >  - Moved arm_smmu_drain_queues() after the cmdq->lock wait loop in
> > > >    runtime_suspend() as per feedback in v8.
> > > >  - Refactored suspend sequence to use arm_smmu_disable_irqs() and
> > > >    synchronize_irq() for safe GERROR handling.
> > > >  - Fixed an off-by-one error in suspend polling timeouts.
> > > >  - Dropped arm_smmu_cmdq_can_elide() check from inv_range
> > > >  - Renamed arm_smmu_cmdq_can_elide() to arm_smmu_is_active().
> > > >  - Removed redundant bitwise masking from owner_prod reads.
> > > >  - Added comments to explain locking, gating and elision better.
> > > >  - Added comments to explain secondary cmdq draining and gating.
> > > >  - Rebased on arm/smmu/updates
> > > 
> > > There are alot of scary looking sashiko remarks, are you planning to
> > > resend this with some of them addressed?
> > > 
> > 
> > Yes, I was first hoping to discuss them on the list! Thanks a lot for
> > initiating that discussion :) 
> > 
> > [BTW, I'm interested to know if you used some tool to pull in sashiko
> > feedback in your replies, such a tool seems helpful!]
> 
> I have been testing 'b4 review tui' to help my workflow. I have too
> many patches to review and I'm trying to move them all into b4 and out
> of my scattered mail boxes.
> 
> If you setup sashiko.dev integration:
> 
> [b4]
>         sashiko-url = https://sashiko.dev
> 
> Then when you load a series it just automagically shows the sashiko
> stuff (press f to expand them) and you can easially quote them when
> replying.
> 
> It can be a bit rough to ge there though, you have to get a series
> applied to make it to that screen, so eg, the whitespace damage here
> made that a pain.
> 
> However.. I had AI make an AI instruction for another AI to use AI to
> to automagically fix git am conflicts to get *something* so I can use
> the tool..
> 
> But I like that the patches end up applied on a check out branch and I
> can poke around with my editor too..
> 

Ack. That sounds interesting, I'll try it out! And sorry for the
whitespace issue, the --fix-inplace is notorious,

Thanks for sharing this!
- Praan
