Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833644C77
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461463; cv=none; b=YZZVLW4bj+QtolekznLZIYpvWrY/vpKroq2gphZlgfYxhsyqBJKFoRQKu1tWb+FwbLRv/iyKGW1jxk5X/Di95aMsOz36MYOQyhocJHReuBzrVyM14+8SkX2BPLM7m9ravNKCqUKx0lE8R26/w9ONC48XM7w0UIOMAAzJCMnY4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461463; c=relaxed/simple;
	bh=QTHzxUgyF78kXRnS4zGNCRInegv9/H2UGpyHjnwV1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9mkN22C0eJ+K0K1SW7Kj2wb4zISSRK6CNX3sF4+LpGjnPE8KJz206g/OMJikqY6Un/HX+BCMn5oqjYDUpitGpTuUtmWS1HBRXilclyeemvnQcGbtTgiFP1jXBrd0/jAgohYbzRTQ0igl5XSwJUFNulEdjvSgW1Z9TYK+pvPXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8i2fECd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8i2fECd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so323455ad.0
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746461461; x=1747066261; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ku5fEvPNhrXtzhpjr1oPMCrs3RK4KvKnBUV3HGNFDhI=;
        b=y8i2fECdyd2vJIWRRAHgklyqxumPrA72huDTHhCfRnM1Gp/Oz4Impye9Q6yuGoFnv4
         yFfmvIhjT8SrF/0DVVpccmZ8mJB7dh2Og6k9Qv2Qq6jGnbqJIapbnLS2ZzLPtaveyLrC
         lQfew9q69ed8A//KP+1zEMZQ1SYE+5X4qL19przw1Lcpz9i5WcIXkUQEJvH5Bh1NJCW9
         zSzJWv4FeXCYJ99O11sEeqaKBM4OhJ0HJB2XSOtiBZUqSJved/LfmoLi8xQ6SuxICvzr
         zyKImQhqbUksGbfx6ueAu6GbJmOHvkj0pAfqXthuBDDPU+MiuwBNau2+gVWx5c0XdOU+
         V1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461461; x=1747066261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku5fEvPNhrXtzhpjr1oPMCrs3RK4KvKnBUV3HGNFDhI=;
        b=wlXqGqz8qEb9p5qUoQ0YzPDOHOlkh/6ydU5Tv3ssjhk09wDmR/jVDPkOZyZQlZV8nf
         JqRdu3qni8ysjPUWyNuYoGNroFHna+EAyPUkW8qpbYInJPWKObaWLXYUg0F+cI32GN5G
         nhoAS4+2dpolinDaT4hXRJfiqvKH4PEH7wXqCbZ5WhctoQuw6t9f/rs30oO/epndvQju
         yyYUEc0KbbLHDRUw3eyiXQL00Vs006phQth/JdpUGLkJ5vy6Qxyoo9nss75aZjbn/3Ze
         brfTl4Uf9PKbkolu9uRYKGJRmOqKSmZk718P9xdYAQb7vrt7Hg/0qVIHRQEiffVOLyhG
         AF9w==
X-Forwarded-Encrypted: i=1; AJvYcCVYJfkc0QIWWDD8n0uuJ9dy34tgDfEWh5UtG28zXKA3vpDR0CGFyOrgqR3jg7hZSwpVKMic2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4XsrwBZ/0Q1CGdQOK766f7NXaDILaPMx5YgH5krPs0aC5/WXK
	J8BW31OsF6SgZBi//qTygTXNQybv6eKl22hJCULuENIiZWvNk203CrmyJdBnLQ==
X-Gm-Gg: ASbGncvfFtzd9pCYvZnjMsTM26cvblzk4i8qomF+EpcbtknR0ksFVXV1okTHxkdyu7l
	LUl3Nz/vDdYl5suUt+ApEJlqbJr8q7HFkyVvXhIHdqD83Ax2Gw17I4K6mlagNdESmYWnT87lHLS
	6eqgt3joM3+WN819NwacAdJXsGN2odAnZ5W8F432rijn/x53BkKSNQdOUA7L9U7OTezIBr9A/Wf
	MFJYep096mTxKvO7zZT6rzMyqRcZG2cL3Z4+sywGR6CVePFK4ZPOwfgrJ7vczQ9EGfg0phpGb/Q
	EaLl0TLfz6Hp+GpLiqda9+IpOFN0h8nVK8kZnH3iIw6aWOVzcq4e375bBPBdsruM9FDZSLKl
X-Google-Smtp-Source: AGHT+IEazlu7DmZ3UhCm/qhjwSs6G1K8QYI4nX4f2r40sqoGPUXeVSc9nPCaf4Hx50vlh92PyyfH1A==
X-Received: by 2002:a17:903:fab:b0:216:27f5:9dd7 with SMTP id d9443c01a7336-22e316fd714mr315445ad.11.1746461461011;
        Mon, 05 May 2025 09:11:01 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e174db5c6sm50979215ad.0.2025.05.05.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:11:00 -0700 (PDT)
Date: Mon, 5 May 2025 16:10:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before
 hw access
Message-ID: <aBjjDUhpffTEgPQi@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-11-praan@google.com>
 <CAE2F3rDKZpUGHc1oUm6zAJfb=XW7HOjs7vodgt_CDgWsDWUS2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDKZpUGHc1oUm6zAJfb=XW7HOjs7vodgt_CDgWsDWUS2g@mail.gmail.com>

On Sun, May 04, 2025 at 01:29:04PM -0700, Daniel Mentz wrote:
> On Fri, Apr 18, 2025 at 4:35 PM Pranjal Shrivastava <praan@google.com> wrote:
> > @@ -139,6 +147,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
> >                 .old_domain = iommu_get_domain_for_dev(dev),
> >                 .ssid = IOMMU_NO_PASID,
> >         };
> > +       struct arm_smmu_device *smmu = master->smmu;
> 
> Appears unused.
> 

Yes, left it by mistake, the kernel test robot complains about it too,
will remove this.

> > @@ -130,10 +130,10 @@ static int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> >         if (pm_runtime_enabled(smmu->dev))
> >                 return pm_runtime_get_if_in_use(smmu->dev);
> >
> > -       return 0;
> > +       return 1;
> 
> Can we fix this in the commit that added this function?
> 

Ugh, yes, my bad. Will move it to the appropriate commit.

> > @@ -2365,6 +2437,10 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> >         if (!size)
> >                 return;
> >
> > +       /* No need to invalidate TLBs if smmu is suspended */
> 
> The code doesn't check if the SMMU is suspended but rather whether the
> usage count is zero which is different. I'm concerned about the
> following sequence of events:
> 
>  * usage count drops to 0
>  * TLB invalidations are elided, stale TLB entries remain
>  * usage count becomes non-zero
> 
> This would result in stale TLB entries staying permanently. I propose
> adding a new member like "is_suspended" to struct arm_smmu_device that
> stores whether the SMMU device is suspended. If this value reads true
> (i.e. SMMU is suspended) then you can rely on the driver issuing
> TLBI_NSNH_ALL before re-enabling SMMU. Use proper acquire and release
> semantics when accessing this variable.

Hmm.. we aren't relying on the refcount alone but the rpm state as well.
Pasting the following lines from pm_runtime_get_if_in_use's doc strings:

 * Increment the runtime PM usage counter of @dev if its runtime PM
 * status is  %RPM_ACTIVE and its runtime PM usage counter is greater
 * than 0, in which case it returns 1.

Thus, we aren't only eliding the invalidations when the refcount == 0
but also when rpm state != RPM_ACTIVE which is checked first[1].

I believe you're suggesting a case where the rpm_state == RPM_ACTIVE
but the refcount bounces between 0 & 1 without changing the rpm state?

Skimming through the core runtime pm code[2], it seems it does nothing
to resume if current_state and/or last_state were RPM_ACTIVE. 

Let me dig deeper into the core runtime code to see if we're missing
something here.. otherwise, I agree with your suggestion to have a bool
to check if the smmu is really suspended.


Thanks,
Praan

[1]
https://elixir.bootlin.com/linux/v6.15-rc4/source/drivers/base/power/runtime.c#L1217

[2]
https://elixir.bootlin.com/linux/v6.15-rc4/source/drivers/base/power/runtime.c#L784


