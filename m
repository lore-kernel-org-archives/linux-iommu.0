Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16E324B06
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319527; cv=none; b=a35Qemec8clT2mCQvU3oOc7oEWOc5CuzaYX2pJGfxWFc97d0jpOTM7qT+f1VPpnckZadjjXnl1iKWDI2Vdr3IDZhPrbTItLgnxOQxdn4sMLbbXiwXF/YwTqbn287FN26lXuBP2VVyzkUWvgmKyXMmm14Dyvds6ILthwgIoDZ1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319527; c=relaxed/simple;
	bh=1KkC74yltJoF9gY0gEzVV2Thr+ROcbYh/YgRoBkt59w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3QOr8o0YwZw3H6jXF1TbJuaPjt1VLYYczmrj+8E49vrLM6doF0EUaJGbOJAK3vUJhlDZ16oDDm8tuCMCEkDk/lSJ1+iCsE62T0uXteCcC9ErTTh1wjwIEWLvvHUlpeJFpQ2vDnHJOBE5qn4DxcpBlgIwBiSW8fgVpHf5ui/HAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KHBXqoRq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KHBXqoRq"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0c68aa31so49984871cf.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784319523; x=1784924323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OyZcoDYsLDOa3jljtF+USnQN0n2vX9UR7xfVNnqT1/U=;
        b=KHBXqoRqv5/+vGYlbb9pK8jc4i2jpGNWa33vGp6Bj4NXiCv/+boKrYDbU2U191hUyQ
         ugA9/beUH1hG9aStowcAJDaUXBXBNAvnAn3to6pvQJYEWAUJtnZkgumtUnv4bzcZpVJU
         HBI6WWwUTqxQF6LUug6WdMpklQoGKKOuLWn6MGzgEvECUM6m7IgiXoqZKOUaDmryu0mO
         oDEYO/O7DBTG4RjDzvcqXAbQSvN80mU7rytBd4YKy/QH9af3v9VSOHtf8SABnmYD4pJA
         pwUhs4g0w3dJ7FMC78aXQEOXavLgvraBXMAnK2MlffbynGr8iVZJBUY3w2eVOCj2wf3a
         IYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784319523; x=1784924323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OyZcoDYsLDOa3jljtF+USnQN0n2vX9UR7xfVNnqT1/U=;
        b=AUwCSaCzCTnkfrCp/Je2hN7HIEakmRSzs3nCTjnXaxOEz7pSNkVkRIGbdF6C9xK1+p
         gqrOyW93ExDQyH+H+ctLrJNTcTLVTR+6DwqxwQ9jZOG4wZsVlWHV8Fz9twhsi1HEBZTJ
         DOF2ytH/39WWLrMmpt2E6eU3e+CK/HouoyITG+2czksi0ohXwiffdWf9aG86Qlo0t6KA
         vHKAViSr66tvD3DU+Ip0jBQZo5m4aXj4qiGCDTmyX7k4CBB4AgeiXzZ1HCpS8mMGzuJv
         m3AySPGtXZZQcebP4Zz5GP4a19uKT63KEnlp00UaijGjL7Vl3xL07ArTpLJLAkInfAgW
         hGZw==
X-Forwarded-Encrypted: i=1; AHgh+RqlXnQceWdIz1FqfCkRjIeHF2L7WTUTeccLYxTsmuBtAjZ4JR8vErH+A7lg7FLw/JEB6nrKDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbMah4ZzVmTA3jS8PG5L+bAVIbDlsNz3a0xOFB8EVc6/R6W6gN
	IT03BMIpCpGqgb9cK5e/j+BAG9G05fGe8Fo+1h56MIzKg+Kjgtdj0/JDOtFCyhCuJ+4=
X-Gm-Gg: AfdE7cnFtI2ezEr+TbzPMQIL2xLujaZHvOpyPd9j5ZuM/tIgdFBVVuOOT2R4Ajy+4ER
	I1zt+AVL8vorxkgqp5Iciw2V7asfFFPyBvIiRHBeqz66Ztdtow2+Y+Zr1g3w5pTi+3dM/gKp6p/
	BXkVIiAPWQNe8xt/GzEsDj2DY6XJEleDSiDqIpaligrPESdJvyXakUVt83VEVQP98sGLIKa/ero
	WJOu70h6fk7KVj+Bm/g1uWThUxs6QTnPzLV0ZSKs3IVtljq1DHOdJQoJSCK6YTLGRya+EcWBQG1
	J3IyL2WFgIZFNsyZepo0l2GS5qOXAJ8Ho8RFTH+dABy4tLAKXcuZJMwnBIiZGZlNM1M6QY8Iupm
	DlaOLII/M8VsBmnHOy97+kBlYWJegcDlZwVK5DPOr1dH7vc7LKQ==
X-Received: by 2002:a05:622a:249:b0:51a:8a47:b578 with SMTP id d75a77b69052e-5213b72b769mr40771701cf.38.1784319523028;
        Fri, 17 Jul 2026 13:18:43 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b9d5bsm19993871cf.31.2026.07.17.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:18:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkp17-000000052o2-3RvD;
	Fri, 17 Jul 2026 17:18:41 -0300
Date: Fri, 17 Jul 2026 17:18:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <20260717201841.GC701389@ziepe.ca>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714104202.1664187-3-amhetre@nvidia.com>

On Tue, Jul 14, 2026 at 10:42:01AM +0000, Ashish Mhetre wrote:
> Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
> twice, with the second issue executing only after the first issue's
> CMD_SYNC has completed:
> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> ATC_INV is not affected and must never be doubled.
> 
> Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
> arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
> key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
> subsequent changes wiring the workaround into the CMDQ submission and
> iommufd batching paths can share a single predicate.
> 
> Rename the existing arm_smmu_cmdq_issue_cmdlist() to
> __arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
> the same cmdlist a second time when the predicate fires. Register the
> new condition with arm_smmu_cmdq_batch_force_sync() and add
> arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
> repeating" transition.
> 
> No callers enable the static key yet, so there is no functional change.
> A subsequent change will enable the key on affected instances.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 14 ++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 57 +++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
>  3 files changed, 67 insertions(+), 5 deletions(-)

Because the VM has access to VCMDQ/etc it can issue commands directly
(maybe not on this chip, but as a general comment), thus invalidation
errata need to be made visible to the VM and we need to expect the VM
will generate invalidations to properly deal with any errata.

Ie I'd expect the VM to see a "nvidia,tegra264-smmu" compatible string
to activate the errata fix.

If so then we will already get duplicated invalidations here and then
we will duplicate them again. That's not great.

On the other hand if you want to emulate a generic and actually
functional SMMU device that has nothing like VCMDQ/etc then you must
do something like this in this patch.

I was imagining a general direction that we would expose the errata
information to the guest and the guest would have to deal with it.

Given this is the opposite I wonder if we want to do it. It does make
sense for a chip that probably doesn't have vCMDQ and I don't think
qemu can even create a DT description to trigger the errata anyhow.

But it starts to become confusing down the road if we decide other
invalidation errata (like the CONT must be RIL thing) must be delt
with by the guest.

So.. Maybe add a comment why this one is different, or maybe just
disable FEAT_NESTING if there isn't a use case?

Otherwise the rest is fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
