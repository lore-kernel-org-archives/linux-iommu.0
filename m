Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AA426D2E
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825102; cv=none; b=WkvT4V6eM1nkFqSPPBvX0h7WsVS0l3dMf3mA65MuIpOPZAXqYa+5dB39LLUk2gsH3zq0WqWDyBxKwFQ4G5hARqhqYMa+tkcnJVE0sEmc5gKBKkl8VFyuuGXMXvfYCmaR1UcB/lNo9yhmYmCVnVPI74/H5/cjQYArUgCNoWqlOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825102; c=relaxed/simple;
	bh=w2JktL+v61DL4h6yBVGKzzOAstSuMDYAe6/bKIYCI7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adVuRC7nImxogtHJdL5w/rBO23n3kV0819vMpEzzQZ3Fg0edioO0WFG7s3TjyuvfmaqECUsYeitzUazD/vkO20TrJX0qmrCi3T7r8Sh0gp12MkC9CCoyiZs56wII+icAHqnp5chgGQt3WrdAIYikDLQtwPQzdGusztbcaBaMUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQAXTCky; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQAXTCky"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso42745e9.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787825095; x=1788429895; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cyXgf/imt42EyjU9r/iWXqABk8Dr5fOp0hkHgXnc/1I=;
        b=WQAXTCkyL6rBCcec+c5sq7DiZ6Wk9zMQfL9lAK9OZSSV9qQ3fqS3XlmVjEnSXPF5aR
         x/O7NaZqubiGk61bRDxHLi7BdbUdD/aXQXSN1VMZs93KgXLbBajM/9U1ur8OGKyIQlo0
         6BAZGQyQ9o7Cn+uJHLvtsr4DDVxBfbYP5fUKPEnzvN63XkSuUJvPrRnVhzxNJfGs7Gp2
         xoLN0x6awCUBEI3i0TggbxQDnCJe3fvp2qgickXonsFvwDUPUTCfsHum/kgxLTzmiN+S
         0phrjrcjmkeP/CluEkIQRYoPM8zIGpKx1/CSKqqQBtomM0lyAs8AcvJnZujAIQsnpS3K
         Tf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825095; x=1788429895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cyXgf/imt42EyjU9r/iWXqABk8Dr5fOp0hkHgXnc/1I=;
        b=CQTBUaOOt3a6sO2oy6CouMQ2NPh+8+FpY/u3GGcBCVTJ4LcjA6ViFhaJfyTMi3b8hi
         7bI7dXDeFYoSiKkHWMwVlN3h1AWwl4W+itv3YmJeigCbvTYjg4rsKuopwj2DQZFq/A3t
         Yefo1pz6gtrYVFHlNlFva5MHFTTWtuQb/Tk2rSUsg/8CoUs+EEXutduMTBTpXHegSvud
         P/Ofw6EiWcT7iCW7eZGoiRjPxjCWbrNZ/fOBcxfGJMiEo2IkUSCTkDnwEII9Uiebp3uo
         LrXcCIg58B9l5Dco9noZF/Xp3Iy1R/12yV4r3UdCipG3E8YJ3UtLufKQkUdxgIZ00iSz
         5qIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6OdhPNBAkIvR3Z7Kpj00dFtiAFmFD4Eddu6Gh7ojPwlTYmO0fqPfMGSjuIY2LtF/acHQANA==@lists.linux.dev
X-Gm-Message-State: AFuF++kD+jl4+Lrb9v5Qhl6cD2/gRxR4ucckwpWx8oODAkjVIjuogjUz
	vN2P6DgJB3dVc/LFW3JgHgEOZRvC5TbDLcTUfvjOqVvH/kZooPPhAgK8zupQyoOuEg==
X-Gm-Gg: AR+sD12AGZAmlwZpmRK/7LQFdNxH/3wg1C5UNZcFVwHCBvJdOOtHXgUSjWWvrcy1GON
	J6ZCx/ACHOaRATinlNARepG17bAVr5zJrWzjGalMaa3wTlac8HXcAyrUwKmNwFVmOoe6S/pa4fT
	LxlUfC74M/HxpZYwkC2/08HBNIfprUlbgu1kP+eMdcZhGjICK63y6KO4Xkg1yG/y66dqM1FVwEg
	fvN1dhQ1hsEerhFd4aCvVn1qSYv7HotbJpGOABOiNN1S5GDtyVs8Qm2/iPoYdZ3/CAqa+7n2t+u
	5jh3lT9MzTzZ14AaT1T1uW9vHaxuNdRBf4bxo78P9n4VErW+hMXmkalf28CUSKcEq48XpOyu7tZ
	A8A12tpMNaBWAP6P91f+3Uj8OaoC5uwEPXNIR0C7gLLponlvlJ/TVgEV0IOmwkaQoWHtuARzOCc
	VvqNokz2di5KcjuLqLitDy+MXGhNYK/HNrMW+r4/F+8ZL8SwR0UF9pz8gohd4lwgBz9LdL6E3qN
	W1sHmOumjEfdU8zCQbaXL56s6K++A==
X-Received: by 2002:a05:600c:68d2:b0:499:cb15:4511 with SMTP id 5b1f17b1804b1-49b0e6483acmr671155e9.8.1787825094654;
        Thu, 27 Aug 2026 03:04:54 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4af00fd2sm36028375e9.12.2026.08.27.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:04:53 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:04:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com, vdonnefort@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 23/24] iommu/arm-smmu-v3-kvm: Enable nesting
Message-ID: <apALwh7sRMsn7WS-@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-24-smostafa@google.com>
 <178769159057.3356902.13161185498161727294.b4-review@b4>
 <ao6puxVSNsLC8aql@google.com>
 <20260826123831.GA3667628@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826123831.GA3667628@nvidia.com>

On Wed, Aug 26, 2026 at 09:38:31AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2026 at 08:54:19AM +0000, Mostafa Saleh wrote:
> > On Tue, Aug 25, 2026 at 05:59:50PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 129 lines skipped ... ]
> > > > +	ret = smmu_attach_stage_2(&target);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	hyp_spin_lock(&smmu->hw_lock);
> > > > +	cur_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(hyp_ste_ptr->data[0]));
> > > > +	target_cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target.data[0]));
> > > > +	target_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(target.data[0]));
> > > > +	if ((cur_valid && !target_valid) ||
> > > > +	    (target_cfg == STRTAB_STE_0_CFG_ABORT)) {
> > > > +		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
> > > > +		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
> > > > +		for (i = 1; i < STRTAB_STE_DWORDS; i++)
> > > > +			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
> > > > +	} else {
> > > > +		for (i = 1; i < STRTAB_STE_DWORDS; i++)
> > > > +			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
> > > > +		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
> > > > +		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
> > > > +	}
> > > 
> > > This doesn't look good enough, a driver can't safe writely to a valid
> > > STE in any order like this, and it can't make it non-valid or risk
> > > breaking guests. We had this bug in linux already, the hitless STE
> > > update in the hypervisor is mandatory for linux guests using PASID.
> > 
> > This piggy-backs on the kernel algorithm, as described in the comment
> > in this patch:
> > +       /*
> > +        * Summary of each host emulated state vs real HW.
> > +        * |    Host    |       HW      |
> > +        * ==============================
> > +        * |    V=0     |       V=0     |
> > +        * |    Abort   |       Abort   |
> > +        * |    Bypass  |       S2      |
> > +        * |    S1      |       S1+S2   |
> > +        *
> > +        * For the host, any V=0 transition is not hitless, all other permutations of
> > +        * (abort, bypass, S1) transitions are hitless.
> > +        * For the HW state, any V=0 transition is not hitless, as all the S2 config is
> > +        * always the same (ttbr, vtcr...), all other transitions should be hitless too.
> > +        * However, the host is not trusted, which means that any V=0 <=> V=1 transitions
> > +        * or any transition to an abort STE we need to enforce writing order of the STE
> > +        * dword 0 and add CFGI.
> > +        * Otherwise, we write the STE in the opposite order to cover cases from abort
> > +        * to S2 or nested.
> > +        */
> > 
> > So this way, the hypervisor doesn't break the STE and keeps the host
> > STE transitions hitless.
> > 
> > Or there is an example that I missed and is broken by this?
> 
> If we are exiting S1DSS mode it looks like this clears S1DSS before
> changing to S2 only mode? That would be a bug.
> 

From S1DSS (nested in HW) to bypass (S2 in HW), the kernel STE writer
will do a hitless update by writing DWORD 0 => CFGI => DOWRD1-3 => CFGI
The hypervisor will transition Nested to S2 only on the first CFGI which
is safe.

However, it would be harder to reason about a buggy or a malicious kernel,
my impression was it can only shoot it's own foot with bad STEs.

I will give this more thought.

> There are also gotchas where writing things out of order can make the
> STE UNPREDICTABLE that must be avoided too.
> 
> We really don't need two versions of this stuf, just use the
> programmer we know it is right at this point.

The problem with that it needs to pull a lot of code out of the
SMMUv3 driver which has things as struct arm_smmu_master.
I will need to check how that can work, but I will try to avoid
that, specially this is not a generic STE writer it has quite
small transitions which shouldn't change in the future.

Thanks,
Mostafa

> 
> Jason
