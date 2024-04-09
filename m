Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DBE12D75B
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662324; cv=none; b=dVFYFt2MrMeCiiCBShyyYAYrI3zbO5bxEwoRbOpnBL4atLRF9vKM6NEB0sZtbbH+unU6i9JwXpTYIvkGQn6NObmGdgyfnxOLW55qK/3Rqtc+2m3k2ro1EF+w9AerRumnH7x8+m9Tqj2IeEulk5wSkwTlha1va8eVVXxV1wQH++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662324; c=relaxed/simple;
	bh=e7xh7zUpQO/f7HZi7UU4sg3MF2Z15fxZPQmiWM4x8uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quTFOMCHLdJRazajqirv1cdcGpTtT063u7mPSzzgyxiyclyeQ5DtS3stUPPLgXHtSQZe4tARqIBqvU4iZl19IeY7FvmdiEYLfKirFbRl4p7zQVPyolIWJ4JwkJ/hvW4NDF6wCEOHCHiJ2wLah5EU6Pilv8ECdGamGj5G21e3yOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZjk1iEn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZjk1iEn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso72345e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Apr 2024 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712662320; x=1713267120; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4DFnz/WvqbVMqJ3REDURlQMNEnJzpbcoDSyqNDWBm4=;
        b=iZjk1iEnMA2KZNGqDd+B5k/AzV4cJptsb3RsqsSiqrVonPriFkaakTHYkguTX7IeAY
         Kwe9zfL/HCJyucLdMNwBKeXMv1qtQFtykK3qsKBOjKO7tIfZ/dJ+aQnOx2gIV1dQr3P+
         h+co+/iqe2HsCZnYEOw5ZZCkwP8aqlO8xNtCZmYic38lpfOKIBNwX5MEpcpwKc8qGPz5
         g/Mywhvu28LVJ2fyDciZnjWLgYez1cAv6rlNt4vRIZRGjMt+LIFN1Bx29ZI+6njFS+iy
         QYd1gvGlKXVk0SVWvQT5w5+W3mYtGKePXfKUm0tM5L92/vF/BTWa1XSvb7t3LHOTswhX
         aE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712662320; x=1713267120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4DFnz/WvqbVMqJ3REDURlQMNEnJzpbcoDSyqNDWBm4=;
        b=lzYYdU4bCVjjCgMVh0Ckw9FR1PBp9Atuo120XWmp5/fhDb9xX0ZXedCf3vlTkuGv+U
         bwO/wqbIr21knCCz3jgGppWxR3MHAt/9/j8/0fyew6nYBSyT3r6ajaIsDZ8JNxzorpci
         Q677+i4DX1vCBlIrET/eNUHvcZQx563TAEGdok2RRb86QLIwmvU2aPMKJhCKNgGb8BsG
         6wd46LjByb9WH6B2S0Vx6tpf5uWmA3TzuqEyHBQAiEGlNJFhoyz8iwKZyzoYCPXJ4e7k
         7pS6vWxt1wARPGCEJCBDMwpoUPL3q/7GX6S6O309rYlp4KPFVST965bID51CpYcptk2n
         HirA==
X-Forwarded-Encrypted: i=1; AJvYcCU7f5NKwYth+o9I9FCZVSHL2FybMvmGp+Ro+V21jQFhc4lQ5wkr/oRigp6FAvCB95dTUTGoN7irxzIeriXYao4LJEuJ/vc=
X-Gm-Message-State: AOJu0YyonrVB3RhAlhXZWDJLSI6sIHp0wqb4czGbOiHYMjIybGSbKbdH
	tZD/0Gdhx0T+hx/rdUxIutITWfspJJUa5T8Afxel00Q9pjlRg29EYahdXFegWA==
X-Google-Smtp-Source: AGHT+IEKhWdjBCLhSgPhpTkaQshxax9sUIa24Y/ydpxEHLgbRl9WWQbrCX4RqHImsXU0Q6eJ0iLhyA==
X-Received: by 2002:a05:600c:1e0a:b0:414:1400:a776 with SMTP id ay10-20020a05600c1e0a00b004141400a776mr121340wmb.5.1712662319674;
        Tue, 09 Apr 2024 04:31:59 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b00416b8da335esm400432wmo.48.2024.04.09.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:31:59 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:31:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Message-ID: <ZhUnK1-Pvcix5dyI@google.com>
References: <20240403053759.643164-1-aaprelkov@usergate.com>
 <ZhUbw6gAeBjpFz5C@google.com>
 <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>

Hi Robin,

On Tue, Apr 09, 2024 at 12:17:54PM +0100, Robin Murphy wrote:
> On 09/04/2024 11:43 am, Mostafa Saleh wrote:
> > Hi Aleksandr,
> > 
> > On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
> > > If devm_add_action() returns ENOMEM, then MSIs allocated but
> > > not freed on teardown.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
> > > Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> > > ---
> > > v2: Use appropriate function for registration failure as
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
> > > 
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 41f93c3ab160..8800af041e5f 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
> > >   	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> > >   	/* Add callback to free MSIs on teardown */
> > > -	devm_add_action(dev, arm_smmu_free_msis, dev);
> > > +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
> > > +	if (ret)
> > > +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
> > 
> > I am not sure that is the right fix, as allowing the driver to probe
> > without MSIs, seems worse than leaking MSI memory.
> > 
> > IMHO, we can just add something like:
> >      dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;
> 
> Honestly I don't think this matters. If we ever really did fail to allocate
> 16 bytes, SLUB would already be screaming and spewing stacktraces, and the
> system is dead already.
> 
> > Also, we can’t unconditionally fallback to wired irqs if MSI exists,
> > according to the user manual:
> >      An implementation must support one of, or optionally both of,
> >      wired interrupts and MSIs
> >      ...
> >      The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.
> > 
> > We can add some logic, to check dt/acpi irqs and to choose to fallback
> > or not based on that, but, if we get -ENOMEM, (especially early at
> > probe) something really went wrong, so I am not sure it’s worth
> > the complexity.
> 
> That logic already exists in arm_smmu_setup_unique_irqs() - the messages
> here are in the sense of "we're giving up on MSIs and falling back to trying
> whatever wired IRQs we may or may not have." The critical point is that
> we're not using MSIs for some potentially actionable reason, i.e. if the
> user does expect the system to be MSI-capable, then it could be an
> indication of perhaps a wrong or missing msi-parent, for which they may
> pursue a firmware fix. In other cases it's normal and expected not to use
> MSIs though (e.g. the system just doesn't have an ITS), so we don't want to
> be *too* noisy about it.

The case I am worried about in this patch, is for systems with
MSIs only.
With this patch, that means, we fallback to wired irqs which don't
exist, so the driver will probe with no interrupts at all, which in my
opinion worse than leaking the memory.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > 
> > >   }
> > >   static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
> > > -- 
> > > 2.34.1
> > > 
> > Thanks,
> > Mostafa
