Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3E2D321A
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023888; cv=none; b=YZzAAvVpSJQGePVis3hwkoiADuyXBf6qCkBwqQfZr/PhdNoeEtmcFAjvtHA8LBwa/7b5kqP7De/2WPVL+6gg9g9TSujyDHAQqhQU/NibjQpftOGFekV1BDddoxGc7U14aNDGD0YbHeixkxeXhlojTZK5ELE6az3P82lMDnj1nMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023888; c=relaxed/simple;
	bh=uO0NCh73QWjdt5Uyj9kU6fcAnxi3vw1tE7kTtVZcrLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK/XSNNAzDLoZUNajR3vgPvY/R9GiJxgKhEwaP8AxngyG4err9g7msex4msGFQehC3K1JO8UxWratDK7BfhvuADrBewcGD1yx5qKhIRRqfm+Ql633cGTKM++T6jYIFY67emwcIQL9nrbHinR4K/2EcFrKNtvcrwHPX1Ac2I+7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRMaoVVB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRMaoVVB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso44205e9.1
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758023885; x=1758628685; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3psH5CD7tcrvwMqVdIhmXfChnHfszSZCh0gJTDmLAQs=;
        b=IRMaoVVBjdeuH8ugFznBCW1iCt3/TlqYGM/S05KBIm/tJNKwVSdr8ZcNl3gcHwvyMv
         IIDemWvYmGJdALGnhjUmirLCGd8QD+jgGQD8DRgpkTouCxqZ8+hsXX5KF0dE8pwPs8Hy
         jJZq02spHF2xitLfI6/JGTX94utND2fIn5gl/RrSWa6lXBu9kYqaYgdCBlcVBLDUFl1H
         v509dSAyPvcrXaicajMjBxIjHxal0WPsJRYtyhmyF7+9k308we5+WQGs3a6uJAL4nLWK
         ItIjulJj8DZ8vAYSLa6kk1IYlnWJcoNjgf1B27WkzoHIBNQtcJqgrpor/t5F4Fq1ILrm
         qq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023885; x=1758628685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3psH5CD7tcrvwMqVdIhmXfChnHfszSZCh0gJTDmLAQs=;
        b=o/j9B1tyPaddRo6CSLgCBt7MazAry70EW/Luzr+sV2MlnVhXsh7a6IH2+QF8UK4W6N
         qufHrKJ08ttR8XP969j30RqMVzEhbDX6kmcbJh7PUk6M5kKohQqXWuD2c4nNraw+iOWL
         5S6zvZ+OlkVC1//jrvkPM3B9j12OTAJ4R536oG2NGwUDeESrCUolocRsGr/h24NDYnNa
         w+FUzRRCH4wys7pRnaBKg08FjLzqQ35jCXAJLhoQShVnXjP14DMGhc76RYRMfTDseArB
         Lnzv/ywa9jmsZP8Xte2L5DTErTSb5TLGOgVobz+WJqMBzJLDaqYUhAcxBo8ivetrLawP
         zQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWozAiIGF/2E4/efuyuuzfJIz/I+OJLWOigALVjy7bgXmce44EcQem0R0iP958lrOf5KVpa6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDo7XH+TQGkChmgj84D/Sz6Ukhk3bFdhyMPSWN/wryyqTkS3hc
	reU2ms8gK2q6M7//4mGiyuD1fa3VcqfBDk0PXeIy9vFCTm7mziYBCpxLInNcCFJx3Q==
X-Gm-Gg: ASbGnctnaRA7caA+WJQg+aFgNJVpEqPgyGlzsBkVSYpy4QLZl7HWFER321Y6qUnmbBY
	SwzIS0BUw7Y0nT4VUBN2fSZRcAaAIcEfEZR4PveAjhw0T1A3VegHGzUDY1lnrUp2k/4GNhl0DoV
	jy1WFAf8lutfQc3ZLC1gMCaVdrngPTySyGy9UNg0zgmhW6rZl7WgCNE/UC7ZgwZgVIGV9qfEVRn
	sDy1pIGiPUsFTwgvdvj5dfMs2HrFZrZauUSwpJXcfi3ZYzwMXx+8NSi1+1dmhSpmA+iZB4DQArs
	PkQu+bUYFw++9rkL9UOCogtKa2+5VlQxaZheuo81NzAaF8YXVbLX2HSqKDKH7JB2oouWFXZLHpl
	d7VIuPOVGS1WO93knDjYHRWdwUxmXrLOgqeR99BSNrXoRnyk+VwsycWAk3tRYiz9Vct2Chw==
X-Google-Smtp-Source: AGHT+IG7Q075/69lFtwq0hoEJKVoCNlBE4hU6CDHrnoiEI5/aWCVfJbO7FkOPky6dULeT2aGJwID/Q==
X-Received: by 2002:a05:600c:8b6a:b0:45f:5b02:b0cb with SMTP id 5b1f17b1804b1-45f5b02b390mr996015e9.0.1758023884645;
        Tue, 16 Sep 2025 04:58:04 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm15966584f8f.48.2025.09.16.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:58:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:58:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory
 with prot
Message-ID: <aMlQyEdJdJ4Q9iS5@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-2-smostafa@google.com>
 <aMAvwlMQ-Jf2MWzd@willie-the-truck>
 <aMcWIDQzi5CDNC4C@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMcWIDQzi5CDNC4C@google.com>

On Sun, Sep 14, 2025 at 07:23:12PM +0000, Pranjal Shrivastava wrote:
> On Tue, Sep 09, 2025 at 02:46:42PM +0100, Will Deacon wrote:
> > On Tue, Aug 19, 2025 at 09:51:29PM +0000, Mostafa Saleh wrote:
> > > Soon, IOMMU drivers running in the hypervisor might interact with
> > > non-coherent devices, so it needs a mechanism to map memory as
> > > non cacheable.
> > > Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
> > > so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> > >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > index 5f9d56754e39..52d7ee91e18c 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > @@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
> > >  int __pkvm_host_share_hyp(u64 pfn);
> > >  int __pkvm_host_unshare_hyp(u64 pfn);
> > >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> > > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
> > >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> > >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> > >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index 8957734d6183..861e448183fd 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
> > >  	return ret;
> > >  }
> > >  
> > > -int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> > > +int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> > >  {
> > >  	u64 phys = hyp_pfn_to_phys(pfn);
> > >  	u64 size = PAGE_SIZE * nr_pages;
> > >  	void *virt = __hyp_va(phys);
> > >  	int ret;
> > >  
> > > +	WARN_ON(prot & KVM_PGTABLE_PROT_X);
> > 
> > Should this actually just enforce that the permissions are
> > KVM_PGTABLE_PROT_RW:
> > 
> > 	WARN_ON((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RW);
> > 
> > ?
> > 
> > Since the motivation is about the memory type rather than the
> > permissions, it would be best to preserve the current behaviour.
> 
> +1. I believe the current `WARN_ON(prot & KVM_PGTABLE_PROT_X);` check
> would potentially allow "Read-only" or "Write-only" donations to slide
> through silently.

True, this can only be done from the hypervisor code though, I will
make the check stricter as Will suggested, and if needed we can relax
that later.

Thanks,
Mostafa

> 
> > 
> > Will
> 
> Thanks,
> Praan
