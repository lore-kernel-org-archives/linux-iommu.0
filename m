Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A91A680E
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734468; cv=none; b=JP/4h+cZIoYwrOrNnR3fXClP+xG1hJsBm5mFlq1EUI1dJ0M8w7jb3j9ApfVCFNY5OonxTey53N9UpV+XJWnAECYs9+vEekNH9yM4QUlO2rccE7UWt6yXa+wPeOozoXOWsmKBWjaf761FIPu9NJNyVAr0p5Hb5XV5xrJ/zmuC4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734468; c=relaxed/simple;
	bh=bl/YMALd3mQ/g2M3kVKZpJBRcUl71G7E1PaFpoMCpTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0OHXXHJfR1LHEBzuaPG5hOIy81J4SpmHOLwjvqK11JnUjjQTm4nYsn+ebXjkCMwVtLWBuDQLqxTzO7SiNWohpQTDqbxvo6q1jawmqB1Vpmicld//KpdTwjZbkG5JLXh8b4FLunPHV/DlPlkO1D3PoMGO6eayCSvIMwVoFEqCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjrrCq/1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjrrCq/1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499b1409a75so31835e9.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787734465; x=1788339265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GC7HaV6ubG2A4QN/tpZz7iru0oh8bNIqfpSQwQL8lBA=;
        b=cjrrCq/1gv5qb12Q1ZbNheE6ZXpqGoeLEQ9yM/KkbLGadNg+v9fUb1o0m5cLz3is0p
         L64ALlb3YPWdlGM7hjBWOO0KLuKWnBD0motqHy6TnE3XQKUvM6Q1Hs5GioMrwLpIHV5m
         q3Q+5q6bzkSlwi7QiqckViIiTv3PvS5tZ3cOm5WQIVW8vewGJitm76sxTGB0XR7jEh58
         KFLwx34AQLlYrCHisM3nwaIt46JQIndx+gc6j8//NZTq8uuqnjBzzB09m2owgtn9w6Ak
         v38lMqEiD/u3j096FUTAqWS+hFlKDDCCvzbuwTC3hi9sJ+02jN8FbAvyGC5BVv68x9FN
         N5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734465; x=1788339265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC7HaV6ubG2A4QN/tpZz7iru0oh8bNIqfpSQwQL8lBA=;
        b=GiYtj+InEvjrRXozULRvFXwt7WCNgwMknfOjACFcSMh1kuH9Tw2x/fQ2R4suJAU63X
         lQwEPgdcPOj9B7TOtjriRnaPf3/WihIifNIfyw3vMKRjHYdbVwX8puN0TV6zCH02n8jG
         urCoxzZU1tGZ07p63+yHW828ncWxjLrmBczfK1WqSVpxlL+oZ9fEazojGKvGZus70rST
         90VJiSsNxbzL2LHhdgNgDl2CCmSDI0HXJm42dvtpQKFvhTTsOot450kCgTop3n5YPduK
         xVDDANQN0XfINOC6j+KtEVln40t7I4MGRwEBKQ2lP3pseCFNda402I21Jq6Cl7mzeQ1w
         Nf1g==
X-Forwarded-Encrypted: i=1; AHgh+RoHNC8f8Vl8iVZPMKBj0CZ2Bf2Ju9rC9+ntX8A8gPvoo52YEKygMBvHBhiOqT/b2jTJ2tjkhQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kgsMbmpJhDTUH+gFMVuWYs24QKjVBH1MMCQwjUiLaPJYy3qbcN
	4CDj3gYY+Ny0JNeDJ6jeBpBoPMl21nBO6B3I8MnaqoU9ut7DjkMsPWSr6w1rvMWx76NgK3BitAV
	TDk3vVg==
X-Gm-Gg: AR+sD13xe5SlMsQ8MVFkCCYRQpzLq5zwUh0as9R8BsxgR5yo2Zk2sBUfSZXbghiCwNL
	SNXD3yG0cfbcEcb+xRBFIiaffsN3INaDqHxZvapp2Y15S1mPzwEDsFbdiYOjn+J1NgAjcZ5BYlm
	PF6YgVTejAxsyq4LMGLaypKCwbDDGPQ5k0mIxPtlU4Oruz5EFioluiDtoO3+dqdPVi8J6guab5p
	UPFrY4GeIHVlGL5B7sxYVMn3hAur/aoP+iTeFflr5yhEeXK4BNqwq5HBiXvF6u4nUEkZIK8RRjp
	cURa+uXbKBqeXiF+AKiEX+kaXksy2PVQTEWyALl0oAHwkOZab4uMCk5InCOPhUFslEHyUy09qTB
	4peKApoC/0Gz5AFO9+yMzDULgkiQrXPS9x0v7VJotYRFTuuUUhM9/cz5ZgH1PxX8sjU8Ez/W5bA
	7FXjcMSm2BODWfKJ1R9pxI5XFsUbhjuQFmtLb1UG73SX2ws4xLGCTqBU9D+xT0RBXmHu+lSHgTp
	Ct9lH6CdRIdItVltn4rO02ly+pLUIUlpiSoKduu
X-Received: by 2002:a05:600c:c0d3:b0:499:cfeb:4f17 with SMTP id 5b1f17b1804b1-499dda22aedmr502865e9.5.1787734464271;
        Wed, 26 Aug 2026 01:54:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dcad2532sm19052725e9.11.2026.08.26.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:54:23 -0700 (PDT)
Date: Wed, 26 Aug 2026 08:54:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 23/24] iommu/arm-smmu-v3-kvm: Enable nesting
Message-ID: <ao6puxVSNsLC8aql@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-24-smostafa@google.com>
 <178769159057.3356902.13161185498161727294.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178769159057.3356902.13161185498161727294.b4-review@b4>

On Tue, Aug 25, 2026 at 05:59:50PM -0300, Jason Gunthorpe wrote:
> > [ ... 129 lines skipped ... ]
> > +	ret = smmu_attach_stage_2(&target);
> > +	if (ret)
> > +		return ret;
> > +	hyp_spin_lock(&smmu->hw_lock);
> > +	cur_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(hyp_ste_ptr->data[0]));
> > +	target_cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target.data[0]));
> > +	target_valid = FIELD_GET(STRTAB_STE_0_V, le64_to_cpu(target.data[0]));
> > +	if ((cur_valid && !target_valid) ||
> > +	    (target_cfg == STRTAB_STE_0_CFG_ABORT)) {
> > +		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
> > +		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
> > +		for (i = 1; i < STRTAB_STE_DWORDS; i++)
> > +			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
> > +	} else {
> > +		for (i = 1; i < STRTAB_STE_DWORDS; i++)
> > +			WRITE_ONCE(hyp_ste_ptr->data[i], target.data[i]);
> > +		WARN_ON(smmu_send_cmd(smmu, &cfgi_cmd));
> > +		WRITE_ONCE(hyp_ste_ptr->data[0], target.data[0]);
> > +	}
> 
> This doesn't look good enough, a driver can't safe writely to a valid
> STE in any order like this, and it can't make it non-valid or risk
> breaking guests. We had this bug in linux already, the hitless STE
> update in the hypervisor is mandatory for linux guests using PASID.

This piggy-backs on the kernel algorithm, as described in the comment
in this patch:
+       /*
+        * Summary of each host emulated state vs real HW.
+        * |    Host    |       HW      |
+        * ==============================
+        * |    V=0     |       V=0     |
+        * |    Abort   |       Abort   |
+        * |    Bypass  |       S2      |
+        * |    S1      |       S1+S2   |
+        *
+        * For the host, any V=0 transition is not hitless, all other permutations of
+        * (abort, bypass, S1) transitions are hitless.
+        * For the HW state, any V=0 transition is not hitless, as all the S2 config is
+        * always the same (ttbr, vtcr...), all other transitions should be hitless too.
+        * However, the host is not trusted, which means that any V=0 <=> V=1 transitions
+        * or any transition to an abort STE we need to enforce writing order of the STE
+        * dword 0 and add CFGI.
+        * Otherwise, we write the STE in the opposite order to cover cases from abort
+        * to S2 or nested.
+        */

So this way, the hypervisor doesn't break the STE and keeps the host
STE transitions hitless.

Or there is an example that I missed and is broken by this?

Thanks,
Mostafa

> 
> You should use the STE programmer logic from the main driver which
> gets this right for every scenario a linux guest can trigger. I don't
> think there is anything about it that would be difficult for pkvm.
> 
> -- 
> Jason
