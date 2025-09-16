Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08330748D
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023827; cv=none; b=EAbpLWo8UBTIfDpqF5KwB3tawLLS54seU+7Sc09CIzCX6Nkp93XVOQS9XJ0u4d6WTBW2+cFlnwd1bbI8bnB6tD8nJS8xx/Tdp25vY6ScSdtHCeHGxDw2wTyenPvk3b+kmyNDSppeZZxVed34f4HDT2fUfyKmImxWcJa4sMRyaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023827; c=relaxed/simple;
	bh=DhwkCUF4dudkXP7+wY51z+786KhHrdUbmAB0Gd0fdow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1zZtKmRNnzooCk9bNV4kTCI/9xnesXLX/y0DRWMYM7yflelCOSprRX8l6iRwoUQXiseJAddLv1orfuR0v1cCxXhXgOSMzW277ijai7m780Pv6Uezn0p9QGrK+BaUZuBkt8mT2oc/zp+0hC0Eg0rJFsWJCc2w5Ox+rTjua2DRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPiZdEaE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPiZdEaE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2f894632so46025e9.0
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758023822; x=1758628622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySSczih2oIxRE/mCuJE87rsnZpN4MGD71PRCDCNKi2s=;
        b=KPiZdEaEeJdPYZa22vWeG+EE6ZaBx1YSo1SWuc3NacYwuaXznV/VnzOucCyqQAaNAU
         yb3SBfqzBGP2kP8lGCwKras/YBgPucSr11frXakLdDzJMWASebQf0oX44goG5n76h4Xv
         bnEdp18Rjloupl+4NjQ11IOqF4SGXiSZew3Cu2Ixab409Bk5lDX3n21CWTX5Q6QFLmWG
         7Yg91UhwnskfQfYNEaf9Erh3EMC6qrgTPpn+H16srsqoDLsPcsI/+HUIE+De6Xre5oaf
         jWSbScNvmOmUf3/vuAJnny1L9jewUY/8N1lz47dzP6+pl4ZuKA5+LPwsj5fUWO6y13Sn
         nr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023822; x=1758628622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySSczih2oIxRE/mCuJE87rsnZpN4MGD71PRCDCNKi2s=;
        b=xDOzBMmWOMHTdutRAieA6fIzU1sJ26pApbr+rWhu0KVf4TQE/CK52HZceUC1iiw/2W
         Ptp5Z5UpO5NPxayjo7eCs8do63gPWJlODXfJwG1Xd6QlCV41ONyOP9/k7YYH5dE7dBwS
         HrLBhvQ+DCycNInojFLuz3/X8rxPJd6gqOf0lyOvNVzwIyazz2U91m2i26o2ceUJp2V2
         xAyvGMBdn/B/0NEFdgAgwUaaTeJNm00SX/J1FSidb14xEtLVR5nJU8u41fgeTmowpfIv
         tFgufHdtc4XYuib8ioDAbACiFSt1bOjzQclPd0Er3NpUDZ6VBgiI9TwrV7g9P9HT4tx1
         VePA==
X-Forwarded-Encrypted: i=1; AJvYcCUke0QWZPAu8KDd7kLFDYxF0uGzTRFx75XyN5azMaIWIoxdF2JtGaymABPXCxQITY6MAFLpkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKgwAlCNpmEASDVSSdHY0z/fq81EE47TwIoZZ0WPlQ2lC9dE5+
	u2DNewCCjxYEyucaNUFD2E7HX+MNdn2LpJ5jlAP4ASdCV4a/RAZfXmxBohRY9ZsM9g==
X-Gm-Gg: ASbGncvNACFs+TWVk/zU+1v8tDtRjOfKms8Y3SdCimLIpC7pSiFuUuH/E8Y/vR4ZYOm
	o5LlFirPjQLVyvvZx1VtKv2Nm0SaVyoanXP4GuKMsWnpxfT8ZKAH41Da3mY2UR5O3a8J22navpY
	gIgYKQZQZ0oYr2ocWSXDeNmK6aKD4g4AKcRdNR9huQpl9C5VqqjFCch/u38XcGi1MjdAePj7e0X
	i1u0elTrCMTmARMyEFEVmSX86JoP6i2stcdV0nPQy+NAMh88izEy1NzlFkTO3aATI3Ml4driH25
	lotTkDDNrRP+lxGvwnCq+foBqMPVXWBAR+3LBMl7KrtAHqo+Y24wAOQ7KTj2nykIYWvweD9YrmP
	keaA8h6q2Z03HWqeHUzwOHYiIof/o0sMCRCN8cDLW6aalzHac0HTHqfr+o22Rj1CeONIdSQ==
X-Google-Smtp-Source: AGHT+IHVAA1mnayi87cRkdBzWdXwnComM1Vq5NxdtVwd631wdxx6byWBLXjdkxRQfsfT6Te7gJR0sQ==
X-Received: by 2002:a05:600c:4689:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45f320079e2mr1709505e9.0.1758023822383;
        Tue, 16 Sep 2025 04:57:02 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3260a1ddsm15806845e9.5.2025.09.16.04.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:57:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:56:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMlQivFvqf1FGK_T@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-2-smostafa@google.com>
 <aMAvwlMQ-Jf2MWzd@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAvwlMQ-Jf2MWzd@willie-the-truck>

On Tue, Sep 09, 2025 at 02:46:42PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:29PM +0000, Mostafa Saleh wrote:
> > Soon, IOMMU drivers running in the hypervisor might interact with
> > non-coherent devices, so it needs a mechanism to map memory as
> > non cacheable.
> > Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
> > so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 5f9d56754e39..52d7ee91e18c 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
> >  int __pkvm_host_share_hyp(u64 pfn);
> >  int __pkvm_host_unshare_hyp(u64 pfn);
> >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
> >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 8957734d6183..861e448183fd 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
> >  	return ret;
> >  }
> >  
> > -int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> >  {
> >  	u64 phys = hyp_pfn_to_phys(pfn);
> >  	u64 size = PAGE_SIZE * nr_pages;
> >  	void *virt = __hyp_va(phys);
> >  	int ret;
> >  
> > +	WARN_ON(prot & KVM_PGTABLE_PROT_X);
> 
> Should this actually just enforce that the permissions are
> KVM_PGTABLE_PROT_RW:
> 
> 	WARN_ON((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RW);
> 
> ?
> 
> Since the motivation is about the memory type rather than the
> permissions, it would be best to preserve the current behaviour.

Yes, this series doesn't do any permisson changes, I was not sure if
that would be needed in the future or not (some RO mappings), but I will
update the check as suggested to be more strict.

Thanks,
Mostafa

> 
> Will
