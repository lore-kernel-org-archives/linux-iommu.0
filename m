Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9625525E
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749477; cv=none; b=uE09RPrYb6W5mgu8eJTVdMQvI3/BczMYg9vrWgpwetE1qqxO2NC5+4T68+UUXIwKhOLD2vigJo7giwaXRLdCWMS5UUKmWyU+iocxHeEn6ZTUl42kMBOOMZhEjjVA+4MR8gHc63DVLzPJv9zoS0iAwfYSoS72SQ95CRWz3sNnbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749477; c=relaxed/simple;
	bh=+gyPu3MGd0ybdcoSzKdW9PnsBPZkGaczcl6rAg91zYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ9p6BTOdNrvY6tpbyPH6iZyUtcSC1rc92HKecNIXmIsYCcI3pFxSoC9SA8Bt2z57lpfxkHQKIrI8zKsTn9WC0/T6xlNq3D0i7mXQcdl4SRa6Burq6djC/2OAHUnJRjw4VegPILEawv3lQWWnzDaPRPC1hEW5mFbBj4c7af3qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouGQ825Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouGQ825Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2263428c8baso16845ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744749474; x=1745354274; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoUaFHrTv8RTZNHDlFpZ560XHRPaosOSmDVF9mrwM5k=;
        b=ouGQ825QdkLc2y7RgcpHUA2Agbl4vXJrKvIOM+W65j2HPc0rWDEz80tJOYeQkdBj3X
         EgxZd0M1PlZjULQOaNAbv8cusWPfzFLePg55jDrQz6YhiK5sAp6HKFr2lkInqbbmBJ+T
         YQbYNJ9lxYNikrkX+n0FwNerd2tYGVS22hSNWcpM/N/7LEShEiE1sKUwTjZE1MIg1Urq
         y+Fh2UEwuWkHiMeiwaho2gTB7n1R33+f0yn+IsqHNs0xgtA6b3m0W7S7RcvrrQiGpo8b
         zsXPlaTsQbVZrrqkYbO12e6lFDjGHvWmIXW0M0gnyvsxVA+kBUpwOZUz736ulQXEszND
         x+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744749474; x=1745354274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoUaFHrTv8RTZNHDlFpZ560XHRPaosOSmDVF9mrwM5k=;
        b=JK1Ls4o4ArPn8LSQ/wlgAqqC1lMo3vg3bQdsO5ut1HX2XPrPFlszxtOJdvck4GK6O0
         FJb8YXUfaPWiGL9M0sywPYLp1tOK4NgsJBAsKZJxZeuFJWLIHL7Px7dbVfcAkGLtApAD
         CaOc8pJQLg3LXGrmn4bDGMIaHb7HiqXaOQlp9gipqa82Hv8hBFeifUQlacDPyAk6xtCr
         Ut2eQeTFXGBktyMtNouMgKrBRAsIt+fx7Zfx3DjAvorIwUnGme2x1ebiDUkjSMvWul+T
         tOvJ0x03PjyYq3D24SHiLfiTv8b+lEUJ/OfKE/7UW2xUriI1gzuhtg+SowIbUWC4cjL6
         7fpw==
X-Forwarded-Encrypted: i=1; AJvYcCWNLVj4wMQs/ecv3mbRx3yZ/fL5QBiamTP1tiLcsFOSrCzPzMhxP1m2Alee7mQFoN29dVxvJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPZiTrAtrakQySlg3usjPbRctqio7Cux38xqzXtpmmUW5b2XTQ
	9nT8N/SeUNEq4FvqeHAIaDrC/WYkwqiCWZrjv9QVqjT0lNAwlc40hWsxa5hytQ==
X-Gm-Gg: ASbGnctwbrMRwzuXdLTxZORUwv4aca/+97QbJEt0/CKf7VgARKyFStIWyqgJsoYpOyH
	M2yYfMAcWuySWACqBiPYiMIj7tCUzvW8hubukSirsCFWpe/5ucfofBXnEjwXzcPQDDh7j4qw8Vw
	Rh9WdwLfB54eON/ejtreJywPk6lfObEFZummZ4MV3MfpTm+fnH5tCwpBEL3ZIFf2lIoy8ysOuwO
	4oyyPcC+gKwHWLgrAxstgh71e1v/lByq1uco07nZcWst7jn1ds6rtzkI/SuaNLD4UqCG1DrBqLc
	ZaBzsNKyvKCT7imWF/Di67c/l0YtZjijuWQ0sdccW7kHRoKVtUg4f9vXBUthgvUFJr7/zQHh
X-Google-Smtp-Source: AGHT+IHudawRCQwe9w190Ozhu19z8kpu2BhxRiXkF5sxn4qiLxER0bWiZkQkw3lZSz+G5aSU5yPhhA==
X-Received: by 2002:a17:903:3bac:b0:21f:4986:c7d5 with SMTP id d9443c01a7336-22c3171e95bmr537405ad.8.1744749474215;
        Tue, 15 Apr 2025 13:37:54 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b65496sm122383065ad.42.2025.04.15.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:37:53 -0700 (PDT)
Date: Tue, 15 Apr 2025 20:37:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_7DmadjRe3GaaN7@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1MjDaAM4Em53gE@Asurada-Nvidia>

On Mon, Apr 14, 2025 at 10:57:32AM -0700, Nicolin Chen wrote:
> On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +	/* We might get the vcmdq */
> > +	struct arm_smmu_cmdq_ent cmd = {
> > +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> > +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > +	};
> > +
> > +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > +
> > +	/*
> > +	 * Since suspend is invoked when all clients have been
> > +	 * we don't expect more commands to be added to the cmdq.
> > +	 * Thus, wait for all existing commands to complete.
> > +	 */
> > +	arm_smmu_cmdq_shared_lock(cmdq);
> > +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > +	arm_smmu_cmdq_shared_unlock(cmdq);
> 
> Hmm, I just realized this: with an SMMU having multiple CMDQs
> (currently with vCMDQs and potentially with ECMDQs), should we
> make sure all cmdqs (not only the cmdq picked in this function
> by the arm_smmu_get_cmdq call above) to be empty?
> 
> On a system with vCMDQs, there are currently one standard SMMU
> CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> in this context. Perhaps SMMU might need a list of cmdqs that
> any new allocated cmdq must be added to, so we can iterate all
> the cmdqs in the list?
> 

Well.. I was thinking to only drain the cmdq if we have ats/pri enabled
because the only case where we'd wanna drain the cmdq is when:

1. There's a pending ATC invalidation
2. There's a pending CMD_RESUME / PRI_RESP

Since for any other invalidations, we'll clear the TLBs & config caches
on resume. Does the same hold true for the commands supported by
tegra-vcmdq?

Is there a spec I could read about tegra vCMDQ and the commands
supported by it?

> Thanks
> Nicolin

Thanks,
Praan
