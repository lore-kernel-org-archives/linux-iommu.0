Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14602C3255
	for <iommu@lists.linux.dev>; Sun, 14 Sep 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877803; cv=none; b=fL+F9kyTR90eo61jrHCJduzmeCTKk6S16ctiivRasWjWQ98B+lLK64r6xalIWsjOlUm58GAdUdRFPgwYKQ4KSwN/0j0EjPE5AHi3KEZK3ikzjjmJ2KgD3/HnlLjpP34eu4asJjZJ9AYJ93RK5nljVYqNjHODRqrPzr+BNAZNKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877803; c=relaxed/simple;
	bh=uX0wZKJmEpYuqOqFw3mmAD3zJbyD9U44trnTAWBGHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP5izCxOTUdn1KlAgNnELLlsEHT9iZph3T7b3mCUhVCjNtt4tvQ0RFS+WubhtRCTzaEvkJtj7HHmbznfgy4JpaQknyHvvJo00+v9AFujB6SCMWiBSPckDi7D17KXsWvxKfHuxf2z/0u7OpTcooZQUAqr5mASa+CdTizCtbIA7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3UZ+LuU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3UZ+LuU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cca557085so213465ad.1
        for <iommu@lists.linux.dev>; Sun, 14 Sep 2025 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757877801; x=1758482601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG+gYRralj304lv9jlQQvH2rsqe/nskBvKJU5W4aZb0=;
        b=r3UZ+LuUgQsbyrdM63D6leg0ZuNINznx1HGMgzUigDvAlFMCKcUP9SQwAqdsf8d+ys
         KPNp8is/U4hx1J2dbljWgvuRZ8eAjLB0LptE/ptrBwhZn36DPURTne/TDZ/mHv7C2OJv
         K8VGwgJIs+Okt+G+O8JKK08z1OGrELoaBQ+AgyqduVcENahcJDybN3fpQCPogzalmk91
         Ww1f7fYBPf35njMa9/8blsKid/uQ0vQl9xFOIs01BZy7PzHT+Nm3QcWFUkAzyDdkxQEQ
         xAazdtByxUVqxgsTDYWODizANcwCgxs8titpIAhMqdAqSq217UIChTrZaJX/nPCmrtyL
         +rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877801; x=1758482601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG+gYRralj304lv9jlQQvH2rsqe/nskBvKJU5W4aZb0=;
        b=Adv5Vy7j0Y2LP1Q81UgVYUVLJ1Ys9ryyeUusSdjjtPhqcAIQ/5qMLRRVuy4yQxEA0R
         fC1s2E+VpipzXREeapIyzSUtWC1/NDeWnVIbrUr7NnfZ6aAkWiCZ32Bqmy/smqfXZWuk
         hgEFqwPDsPRwJQKXiGiwxw5f4oMnjYYlxObTbneHp4qxe7TJ8rIInwFSoi4KzdIM1Db2
         BMxqJ+mYxcwwSiZLgoYJCQBacETvoJKIav5mOwEMve0/bmsqGPvfzHfuX+qOmWqXssNE
         Ty3gfpDUPJtNINfdVPfHQBSBLIQbDtH6NfhFKQvzoma9AllkNe1f7+FfWPK7bTVVHRh3
         R/kg==
X-Forwarded-Encrypted: i=1; AJvYcCWaTZc3rHh4EdIhVryY+d6jT0yjcNDbCuEkW/wR8tY9cD+JjN2TwRKtgCrZF4U+bQLRPvHkxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSYLpRIX1UCfsGP2ehgmvgVqqTBoYdxqmgN5KgibusLygdGDEE
	hfESBEcEJzNDfro2fzjdqOiK3TbcsLDsgvJBI/C1yrLiY23o/ypgvME6zy3wwWQg8A==
X-Gm-Gg: ASbGncv4w+EtrI2/0HNv6Nn26PjNzd1h87WqtFMyTQ2f+lwDOzSnGhG1T4Dy4I4rSlS
	sy2mSkOagALAEzeUzJAjzRnODpVI38Gzpkq3DDAkQZcksp6DCdp12P1d4/aP9/fiXp4ozBCH9OR
	94+Sll1sCTmSskBmIVsZ8a9kJzpwnhX5387up5hwdlkQgHuizEJWaf2LNe9yy72R6g6ID5pjXwE
	katVkr46yQNa1AxKiUSDCpR0RHmuE9RBZqJe99AiEk7fW1kMqiE6DEKwBq2FqkPDccksp1mtDzx
	bUyzX6ZuaLVH6Ov6eQ/Tbpb4IQjBFh2OoeNyDCsdpDkwBxJLjwhik6fRY5rNm9D9RS5hpn+aul3
	7eJj5GzutPG6jQooRTRGRQ1bGRCSc3Fc/rN/5P+PPvQzFjTPMqsnpQVzaWQE1E8unUGYLO2pVHQ
	==
X-Google-Smtp-Source: AGHT+IHeCAQpludM0vTJDLMiqTdpngcD9vok0tgM2qTCvopIbkrrbFlepcXGw62j8sLSWvlQCNe2WQ==
X-Received: by 2002:a17:903:183:b0:246:a8ac:1a36 with SMTP id d9443c01a7336-260e7c51cb0mr3888035ad.2.1757877800544;
        Sun, 14 Sep 2025 12:23:20 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e2b9125a8sm1504984a91.1.2025.09.14.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:23:19 -0700 (PDT)
Date: Sun, 14 Sep 2025 19:23:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMcWIDQzi5CDNC4C@google.com>
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

+1. I believe the current `WARN_ON(prot & KVM_PGTABLE_PROT_X);` check
would potentially allow "Read-only" or "Write-only" donations to slide
through silently.

> 
> Will

Thanks,
Praan
