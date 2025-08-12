Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7062EA168
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994587; cv=none; b=ovQeK9qEwT6NZc1QrRJEWppBg4FXwhaIU7imVPG9iRVV3QQJ1EePAjVupCeFt1lkjjRunD7hgu1EXLVXxJ0sZ7xw5LEa5j3kS6uWPGbg3fXoMtbVzm3yuk6j+JbX28OTDslUfCog0Pp0JgGGVbWukrifEaDo4HFhQdkn5Iz89Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994587; c=relaxed/simple;
	bh=tTdx1UQ4bPBlbnqXoSHE5xrjt1WlM8z3PbQt6giizt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUJ0dzfY2Bcpfp/sONG98miyu2oRImXke88EjntgNVBU9uRJe6SRck8+c8HAWm0cjABXTOmGQaqH7UQaFpkJt343WZTdtUm8LwTKMVFbi2RlgTTh8tKlcEacapJO+01SAD+rsAwkx7mNonbuqeIk8/eya2q/PNHz5kk7k1qJRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpYUr8rC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpYUr8rC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so46295e9.1
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754994583; x=1755599383; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1/anwh1bqqHUf4EN9XkEDdbFNVMa1nyZcPFf3i2Ukg=;
        b=xpYUr8rCQVBOH5O6xsbLu/pumUafk7xAgAd9RMyyddcSJVRTR0hatTxhfCLfur8fDH
         TxnywDB0eABGNFqlBwSv0pVX0TUMCleAZKJEMFl5A0mn32wmiElsDKIKlFJWr3tXbrvn
         cpwWYS+6Nmmf45pM1LjO+2XjwL8yULzDhhIEZOCDykMHayEt+4ROe9BgqmOHVc5/gvtI
         5KGQ5T9xtIF8tBO/dsCIww/Z3i0lCY8zIV27CtsRLBBnKl2PGwPdKq1b6ImOlcM4QgZj
         2Lod4fHmUAIlu4ZcOmf6czBHwduABN6FmIsHNSEeApH/iRNaW796ByPqT0L0XpEYK65k
         Kv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994583; x=1755599383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/anwh1bqqHUf4EN9XkEDdbFNVMa1nyZcPFf3i2Ukg=;
        b=WQkIidshKN7nf9mXRwrwuCp2ZbA7zLhFyBoeRy+aQRhP74IYPCVM5Dd28anN579Zgp
         VP4PWvTGv2qlvolabV45iMPhMc2dEO4sbKvblt+AFofmUbv2Nue9eX1/qH8+LjGGOi1S
         UiBjL4jVCl+Z3MvpCNblEchYf40IrUA1x2cjOxOvYU4EjHyTbRZYnZGUKPOFf67pvuf/
         tv1evdXBylXZ1K+inO93Iyov1UQNlGUH7P5baWLtBXw1r745yhROPNhO5QXz97Bzt3g2
         2ZDn4scmPPdEBR+PSRdsa3XwkjwmX/zInwkM7wU253vhP84hLq7zgoPvRgCZjm3pYI4y
         m0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSjgF3zcm2ssTmyMisiSLreQ4WcCUxecfFX+gWUVaGraCy3qXRctNhaIEZou2d0CnKn6GJvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWpH/GO8ba/Xgj9Ef02OwMos//9QS2hVNszhtEGGJutZRA72hm
	clQtj+5+BxHC+prD4fPo7OHEPRaZCQg1ANZhFcceYHeZLCvJp9dv18fKLdiPKRmJhw==
X-Gm-Gg: ASbGncuDj9u7jkw+RO83W44PR2JIoGZXQuU5vfG+4qxGSa3E8tjRGOzNyIixFhrlAOg
	fhRNATCzYzOttVEMBsetu7Ax29NefaHPQjGxdQEAfnuFN99MiHt/jUDmcAECqcEQwI9z6WfpMEB
	+wZZMLRkMHRx9au9/RQJF/cbEX6mRP1Hj0ma/LX9WxGwG3I/MmhmKDwQ5SwIJVLX35UIL/FOLyW
	HsjFupPdI+33ydaRrN/DP+a2SxYvocjOLyeLc+SCnVFvLYDvBcS/Eszlq7jzY8PZ7NG9AgS0Q5M
	YF5+j3Y3bMPCMkJss8dgrNCwVTxk+VG1igoZzO2NNT5XQu1yeG3zXqhZYemXqgtmbepuyY54ho0
	xd0CzuZXyUrvLtRrbftWUjryoTKbQKWN6N/+4AIp3Lz6Oe9HtundrED1U+k6+vphWMJ9Lvlf4HD
	Vk
X-Google-Smtp-Source: AGHT+IHaYmnizcPqrn3Lb/9/nhKegnTEZ2frct1vzrtYBKDcVLr6eexdb/QiWRjNckapmQO/Wt9MMQ==
X-Received: by 2002:a05:600c:899:b0:458:b4ae:41a0 with SMTP id 5b1f17b1804b1-45a118d4771mr710605e9.5.1754994583250;
        Tue, 12 Aug 2025 03:29:43 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm43741716f8f.39.2025.08.12.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:29:42 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:29:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aJsXkidmcSl3jUJP@google.com>
References: <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811185523.GG377696@ziepe.ca>

On Mon, Aug 11, 2025 at 03:55:23PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> > I am not sure I understand, the SMMU driver will register its IOMMU
> > ops to probe the devices
> 
> You couldn't do this. But why do you need the iommu subsystem to help
> you do probing for the pKVM driver? Today SMMU starts all devices in
> ABORT mode except for some it scans manually from the fw tables.
> 
> They switch to identity when the iommu subsystem attaches devices, you
> can continue to do that by having the paravirt driver tell pkvm when
> it attaches.
> 
> What is wrong with this approach?
> 

My confusion is that in this proposal we have 2 drivers:
- arm-smmu-v3-kvm: Register arm_smmu_ops? binds to the SMMUs
- pkvm-iommu: Register pkvm_iommu_ops, binds to faux devices.
So how does attach/detach... (rest of iommu_ops) work? In that case we need
the pkvm driver to handle those. So, why do we need to have iommu_ops for the
kvm one?

> > > > Also I am not sure how that
> > > > looks from the kernel perspective (do we have 2 struct devices per SMMU?)
> > > 
> > > I think you'd want to have pkvm bound to the physical struct device
> > > and then spawn new faux, aux or something devices for the virtualized
> > > IOMMUs that probes the new paravirt driver. This driver would be fully
> > > self contained.
> > 
> > I think it’s hard to reason about this as 2 devices, from my pov it seems
> > that the pKVM HVCs are a library that can be part of separate common file,
> > then called from drivers. (with common ops)
> > Instead of having extra complexity of 2 drivers (KVM and IOMMU PV).
> > However, I can see the value of that as it totally abstracts the iommu ops
> > outside the device specific code, I will give it more thought.
> > But it feels that might be more suitable for a full fledged PV
> > implementation (as in RFC v1 and v2).
> 
> Maybe, but I'm feeling sensitive here to not mess up the ARM SMMU
> driver with this stuff that is honestly looking harder and harder to
> understand what it is trying to do...
> 
> If you can keep the pkvm enablement to three drivers:
>  - A pKVM SMMU driver sharing some header files
>  - A the untrusted half of the above driver
>  - A para virt IOMMU driver
> 
> And not further change the smmu driver beyond making some code
> sharable it sure would be nice from a maintenance perspective.

I am almost done with v4, which relies on a single driver, I don’t think
it’s that complicated, it adds a few impl_ops + some few re-works.

I think that is much simpler than having 3 drivers.
Also better for the current SMMUv3 driver maintainability to have the KVM driver
as mode, where all the KVM logic is implemented in a new file which relies on few
ops, similar to “tegra241-cmdqv.c”

I will post this version, and then it would be easier to compare both approaches.

> 
> > I had an offline discussion with Will and Robin and they believe it might
> > be better if we get rid of the kernel KVM SMMUv3 driver at all, and just
> > rely on ARM_SMMU_V3 + extra hooks, so there is a single driver managing
> > the SMMUs in the system.
> 
> > This way we don’t need to split current SMMUv3 or have different IOMMU ops,
> > and reduces some of the duplication, also that avoids the need for a fake device.
> > 
> > Then we have an extra file for KVM with some of the hooks (similar to the
> > hooks in arm_smmu_impl_ops we have for tegra)
> > 
> > And that might be more suitable for nesting also, to avoid the bind/unbind flow.
> > 
> > I will investigate that and if feasible I will send v4 (hopefully
> > shortly) based on this idea, otherwise I will see if we can separate
> > KVM code and SMMU bootstrap code.
> 
> Maybe, not sure what exactly you imagine here.. You still have your
> para virt driver, yes?
> 
> This especially is what bothers me, I don't think you should have a
> para virt driver for pkvm hidden inside the smmu driver at all.
> 
> And if we have a smmu driver that optionally doesn't register with the
> iommu subsystem at all - that seems unwise..

I was imagining just splitting all the KVM specific code outside of the
SMMU code, but not as a driver, it would be a library which “arm-smmu-v3-kvm”
calls into.

Thanks,
Mostafa

> 
> Jason
