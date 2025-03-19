Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F620897A
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370194; cv=none; b=ev3uMeS8bkOCgVrVrfP/Icl4VDc6+mQDq9voeE/UHXWH1C7SDWiK0PfoDjhBg1E2ryEwewl3x94eMlK7/qSdsF7lf9jfIYn12xY8ibdhDFyr861xGetSCYWVoc6yJJXErdgbc8hVncNpQpIUpNaDnRfgXW3RRXRWEf/Cfo+C6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370194; c=relaxed/simple;
	bh=BOWdO+o51kA7CISrP/hNDHWqzUQTPja6p7cnuotjM+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNZWkoRbWYLARers52yjiGd7dDuhLWCoa+eTY50Hhdr89m6KiS6mZuidkrNQww8qj1bcnD9uyDcGy0Xndw8bXR8pkFavJnwFY9OJILRHIOTurNL4/xga+zwffV5ryVUi8r/HxymtEmdGowBWxvsDFWpaiiQhlkFjsClOvzN7SaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9teWkri; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9teWkri"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so62445ad.0
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742370192; x=1742974992; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKBKMVRcBkeiSseD0PhvfqZxmXzf39iy04AC17lZUM0=;
        b=P9teWkriU3UCc5BW+JYFlFuG15SCo6febLnqMUwht0CJlYl2uAu+J+r2YFg44OwWE3
         AouT4Mu84EzTm7nbDu8PpySHvQGuLDMrbcL8csl++0/32WzV6IJt8k2F4EcnR33fGlsp
         2LoB8GrWLvIYTUajMxoDQR0v4NxnJ9rHeLt1YHleMnIlW68rFrC5G/buc9XgUY3ZE0ZH
         Yb5wdPLHBqR7emoDa5qidyFgVulLJqofa2+kA6hwZ6DYxhngojy5OsSoIEragZsvlgno
         Q9TwAqkz4Ug5RYGRG3NouenVg8goDTtYE9jEQVNtL5rJ4Tsx3k0RWG9romOvUQTy9uT7
         xq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742370192; x=1742974992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKBKMVRcBkeiSseD0PhvfqZxmXzf39iy04AC17lZUM0=;
        b=pVCrVAwHTV0NSzwSWeOof6wk9N41hQh6dMieCCLV79KDSwKBdkXR0gPC9ablYJAL0N
         R07/ac49McrE637NzY4+1R/pW5qnHjDv8pjUvWcBApwicoTEWmBuyYpvDL0zQ9U61/0Q
         mEze0HEf0R2ZtPRHWdBo3JVF8F5wPGbvoumOcq3baBYFvX+VJ8IjIXaKvhie/eZkWDlw
         B61F0v1KUSY3PO13Ge0/zOkT8urPqRYauwalOgwA5dlEKox6oSKQen/rWcD3Sam6AZj2
         OSLr7sXYNiZ7UT0/QRJH33HobjQ4L0GyQ1Q+LALOndZHlfKJ22U1KEB6yXSrEmh2WIgB
         GVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPB7SAeKmT5Dt8b9HHyFDLUTh5+F7AzPiHqG6hoaTfGhZ8d5XmOhPSOpjh4k6gr1rU44kcyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKcZBW089R4j3s+OfqA3bkn0/C54e9Rk26ycCEyfjxROfc/JPA
	sEwd2oXsDsBvLvS1nb36ZUEeZsZsv0W3ORpshRrs6fUHlgSPEr8MTYqwrdz1sA==
X-Gm-Gg: ASbGncuHwUxT9Jw0wR8wV5uMr3HVu5lob39rOMitxrSSTSFdyR4XS6og3Vy2xOomVSV
	SLBtSDDsyq6ppQ3tRMUX3NlvoxURRZInwuXSyg61/Sfzk4ZUXVXEBwbQhaVpguhRA+TOI5Gn4u6
	VZJZ/clUg+nHg1DiixSqocbja5EgUrOSA7DAvps0DVpKxS+wI1Sk4KG9e/zqmjSR1+CwkEx2e84
	3eduJWhc+JOSi8pcdDJDdyqGXSbUUeqDWppWIivwl2gRbghvN8nJMrSz0ynFP61Ota/Li8408PA
	L33KuJLJG82kj9SRiCG6NYGK6tCzMT5cVpxgYRgwxJ9bezDIXxoECGPVZ5ZPHFJC3Hjed7tjnEg
	nEEmsMMFu0F6+HQ==
X-Google-Smtp-Source: AGHT+IGktfZrgnJSjnprGI7k9i5cldvACdqQluIQ61zI7nq6UZikNgheNG+4tDnDNQBMyGeTMCIJRg==
X-Received: by 2002:a17:902:ccc7:b0:21d:dd8f:6e01 with SMTP id d9443c01a7336-2264c5d1c9emr1101985ad.5.1742370191437;
        Wed, 19 Mar 2025 00:43:11 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a8775sm107397615ad.95.2025.03.19.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:43:10 -0700 (PDT)
Date: Wed, 19 Mar 2025 07:43:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <Z9p1h_PRefpHANJZ@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-2-praan@google.com>
 <Z9pNCKjUMbg09Wrn@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9pNCKjUMbg09Wrn@Asurada-Nvidia>

On Tue, Mar 18, 2025 at 09:50:16PM -0700, Nicolin Chen wrote:
> On Wed, Mar 19, 2025 at 12:42:50AM +0000, Pranjal Shrivastava wrote:
> > Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> > registering interrupt handlers and the other one for enabling interrupt
> > generation in the hardware. This refactor helps in re-initialization of
> > hardware interrupts as part of a subsequent patch that enables runtime
> > power management for the arm-smmu-v3 driver.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > +{
> > +	int ret, irq;
> > +
> > +	/* Disable IRQs first */
> > +	ret = arm_smmu_disable_irqs(smmu);
> 
> Why do we need to touch HW in this SW handler setting-up function?
> 

This is just to maintain status quo, if you look at the current
`arm_smmu_setup_irqs` we still:

	/* Disable IRQs first */
	ret = arm_smmu_write_reg_sync(smmu, 0,ARM_SMMU_IRQ_CTRL,
				      ARM_SMMU_IRQ_CTRLACK);


> > @@ -4171,6 +4187,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  		return ret;
> >  	}
> >  
> > +	/* Enable interrupt generation on the SMMU */
> > +	arm_smmu_enable_irqs(smmu);
> > +
> 
> Should this replace arm_smmu_setup_irqs() in this function? I see
> arm_smmu_setup_irqs() still remain in arm_smmu_device_reset(), so
> a normal probe routine would call it twice?
> 
> In my view, arm_smmu_setup_irqs() can be done just once, moving
> out of arm_smmu_device_reset() and up to arm_smmu_device_probe()?
> 

That makes sense, I kept the `arm_smmu_setup_irqs()` here to re-init the
MSIs during resume but I guess it's better to call `arm_smmu_setup_irqs`
once during probe and maybe re-work to call `arm_smmu_setup_msis` during
resume to re-alloc the MSIs. I'll add this in the next version.

Thanks,
Praan
