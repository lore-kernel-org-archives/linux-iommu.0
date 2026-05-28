Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AE367B7D
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005557; cv=none; b=i2amjafCN/DA39pU6BEpEUpDMQFQ14n3KlBBlyWFf3pKmrEOLgue7HEpMpg78LQQ8yH145L+F6/RlNVc0+NSwrvDUXhB5TWElj7mqPxIVI4C55AO6X6/BT6lIIH/XzI3L/mN+K86IEHa+80tDsVvu07GpuqOLtna5toBrgNyklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005557; c=relaxed/simple;
	bh=epQc3YpEnZykw7sGorLMn1h9MASCAUgxV8l1m9C2j1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg2k1GMUaefOPh+M8MdBOXoCn/ewGlYwzRPjeX/QRSIB7WM3PZZVNqkgnAu4e61Wj0TwTz5E1KOTMdMZ0ICHGZDLmvyTAvkMz/wa8n6zbsyW2lXNzPB0XNeC6jAnHQ/6etDrBTpeTH0zOFQ2P5bpw+L76rc+M+Lj61qMZRnMCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsFrbo8V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsFrbo8V"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso215ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005555; x=1780610355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s45jeyZUnHcuxamvKyKSnvNc3yOM6rgGg+lJBsLH2Ic=;
        b=WsFrbo8V9ExojWrd1FwRRLxLqowttp8cucJd6jklR1IvY9NGzfkiQs/4WQBTJdTqHF
         fzWxg5pI2nywToa3GFhUcudDoN6aigqPm8SvGZzVUgyX9Itv9SKS7dufIG5nAVhCGKNB
         S2pjWg7POQ6NVqT8Jtsx4D4pcIuqnQ/p9dLFyGdCbvqb6sFZkZzIN/5yTjZSoSAeGRM0
         h29sAxof2NC0PV2yWVgbO+j0IQRFNUyQLBDgshRngvk4l4zT0oiAOnTCZPwnCssDSmRN
         RVELWFXEL3hdMQJv/B2hKqyvfyAyr/dQX0gMd9JQELKPhAVQEbKGpIbQnuo0duMKwRN/
         92sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005555; x=1780610355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s45jeyZUnHcuxamvKyKSnvNc3yOM6rgGg+lJBsLH2Ic=;
        b=bE2LSKGW1rQO67n9rIOPchx+eolPUTKNu9N0qh4xJ9TQ/8KZYqRZ7SCycVJTMsMZ7j
         RGeQPj9eKsv14h3MUNpCTGfUnOo90nHAezBVALdcFwA7GQ385LnQGLELW5ZOFqUDnSnF
         wopL2rKl8v2N7Xh44i6m9bNLgV+AVJJ/rCeAtHvmF9NdBNBKVWxDoboXGS/pKxjnOX03
         VXJKScNY1CwjGJf7mxd1N+3m0oZdK6fyoXooT4exx+4zks84+speh36rriokXVslhLtg
         c1t1VkSA/9RRHAmbEYXpFh2eVN99d7JLV01Ryw/iNTaGLaH/vMSrt/9hQwYSkY99Dz/+
         dTfA==
X-Gm-Message-State: AOJu0Yz/zI4BpBRZvegc3DBQoEa7FNgENV1BcaEyrh2WEh4HCNbZCyYd
	wwGECYkbNoTnxcF9+zjiiYc3nYaGhN6FFTEvDpU2ID+fQTVTI67ztcoa8p/B7TkvUA==
X-Gm-Gg: Acq92OHj/bDaOt5LlZpTk55nO3knUqYzkxPyrGn8aw7sjkePChMYCe0h4YnWiEcMpnp
	2WeLVh6XbDsYHgpZC2gYvFHYlQ3GRNByEG5AS3SR9kQDNKnM4kf9/JDOG/GWeyV8jl1SNuFrm3m
	p94IqT+TepKBKWP7wdAV87FczW2ComGbiRTMlnJYItMhh74fceO87nqzWFrtsHfZfCJojuLB0RC
	OR38cuNXbSxN9x4uQZ7BzbCwxwZ3KiNatdTcSTFMB8LNAJFCoYj8SilEDM3A89Hmq22CLWh7WEc
	TWNHuCWYzzrfFw2JKFY6HcoKO2QHtd0gfSmy2CfRKrfxRwgbre0SnV2cq+XXqXSRATkklKApLd1
	NYg5aLOKsT2Yt9E10YqU2KLDIuN7Sb++sueY9iJCJD2nA7Y+nNr76jDJYtlQz02qSl2wEGCLfSg
	J8AD4eqnsp54fmEwIBwiVnaX0F0N4dhhzGPGItSjKFzi31x4mv+9COJBkc7U52F2pRa98s
X-Received: by 2002:a17:902:db02:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2bf20d31c2emr350305ad.13.1780005554757;
        Thu, 28 May 2026 14:59:14 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe10d592sm55406a91.3.2026.05.28.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:59:14 -0700 (PDT)
Date: Thu, 28 May 2026 21:59:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 06/11] iommu/arm-smmu-v3: Handle gerror during suspend
Message-ID: <ahi6q_BgoKaJG27I@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-7-praan@google.com>
 <ahiPNqKhC186BHPl@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiPNqKhC186BHPl@Asurada-Nvidia>

On Thu, May 28, 2026 at 11:53:42AM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:02PM +0000, Pranjal Shrivastava wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 93cee32f6c99..191b5b5b805c 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2257,10 +2257,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
> >  
> >  static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
> >  
> > -static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> > +static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
> 
> We don't need a lock because the new caller would disable the IRQ.
> 
> Yet, maybe add a line of comments:
> /* Lockless; must ensure that there are no concurrent callers */

Ack, I'll add the comment.

> 
> Otherwise,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Praan
