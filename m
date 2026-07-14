Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8849439000
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018853; cv=none; b=cuv3xGh/c/1CFHr4dmj3kLKydy7P4FI8FPiIrFRUlkEaWT4df0CcRTHs4hu5BgzPul86O3w2Bi4W1ZOWSmCd5bF1ufv9y4/Cp0775LEYm1qaP9+SGGDqHniz2eVdkMRfdwiy5Cff8qzsPBFDvWRhJTCf0f2+2Iucy381vT5AigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018853; c=relaxed/simple;
	bh=BQvQA28/hQsJiQl1Rts5gtoQqHvUkzf0m5MoHJQ0PZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4O0VBbWVuZ8JECK2Z3+7UX0ga++gbC+f/PfHNy1MYaUVcvsyZrnSdO7TcP8FRRYrPy1EMU515/XvSG3mrxkOMZH4+Rv01ZxG2ki+Z7XYBxgLf0Glf+pr5M4guOh07+mhjunKunnD+n6Y8go+lQfvBgE7CY+3QafXCFZ+ZMAaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hd5Rm33Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hd5Rm33Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ba701891so5274065e9.3
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784018850; x=1784623650; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m879ws2jFhHLOh/9WRuezyCL3r8TAQ3JpjmFZyFa7tw=;
        b=hd5Rm33Yv/OoXMIz/o08qShV9xqmP/1f3NkCVkzCMJsCJULVzcUyHzmzrw3o7MJyGA
         YDGoBfe874ClXjYIfTX1zOEaj60LBJsPNYOvk77b3VXideJoXA6DVTMcMJXsN6gjCxiJ
         Eim6i16IInrGwywEBmF7OLpVUgesryCYRB9EkecHK6JQHhsUAPSmO4sRBjmnB1zRVH/q
         dY46erIV3jufKnyiVFUDpVQPMoueIu1RCw1t91RPeXZXFhRnKDCPQgunSGGelCCupOAh
         YWD3bkp9s+F3U7PGxT5m8uQTkQuLRkIoOe5PjSveqZaEfQKR0tlEIfHcAMuIqJGrERiY
         L6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018850; x=1784623650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m879ws2jFhHLOh/9WRuezyCL3r8TAQ3JpjmFZyFa7tw=;
        b=sXVTv3/wG4BfE+3UEVkf8VQcZ3TOgIbtKwV11RMmeGW7Q5i6yaftoJ7BSsgXzHRxeZ
         A39UN1csEmUEgERd/0pr9RvNJrotIK4YXV7FtGmHe7yW03wmZgPFE22Tk5jmcfselWzB
         LeKACWg6Omq8i6rLLKScmAiS2TZX0GKmzvC8MS8Z6sE0lRosqRu2RfVdyPD85vppNp7+
         sb6bSS7MFCCzKb9QqB8qHThGTQjZPB/EeV4z8y9ZNdUgLy02Ui1iLnPD3MlC9TsaHGDi
         GCNbMc4LUzhJSWuIyTXV8mtXsEmIn3zkatLEOQwR7S4uuWR1v7yLx0MpW4E+AGi+GbOE
         n0Gg==
X-Forwarded-Encrypted: i=1; AHgh+RrAY5RS8GgAz2kJjUUlQuM2Wln8X6RV7oYlBA/mzRjWC+DQjKb4lvRQMb3ommK4wsvmMkzMYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXK34WgO+HMMTM2x5IVMop/Yxh1m5gFhpHKIH1fsO1PwaO+gJa
	JNFwF/oDaEkKGvaW2N6ZfFLwgfT/OOogOy0LiOCYfHhbdoZhCLmURHat9x0yNnciSg==
X-Gm-Gg: AfdE7cli9+CLXtjeCzChiPJjY40Uaore7QPDfjrtaYhhQqcMa59n2xA3MdqX3V2Lgql
	9dJzCEKy2g5pjAVPmsUbW8QjCT2NbGB2LTpjZCgOL967cSmz5R/0lCGeffiEGVp1gzanBq/FBUL
	qFhPMkB5hPB0h4gr1KpMmFAnZ1r5bJ6GsHdk04xqtN5BK2jTWPM2UXnGiPw3EWjEEBOhh2jXooO
	tf6/ejnrmXBy3x0RbFx0HiADe5NDUvggXJ8UyAzi8vikaINyOiXKiL476xxf0ryR25PtPbbynq3
	CE0gxTs4s/5sg9rQtev+sZzlqwLAX8FjILmIAmi35U7qaYBYO+i59IXvzxkwSjtkRyc54dsMLu5
	1nQmHey9iCjjQN6xCssFunrPWpWpFn6xNKwfbOUoeVwQjGmiXMxXI9sq0rvuhbqg0EvN686Y2sS
	7qaXcq6g2iiym4sQzEx2LGSggcOafsS+dU/58tDRGAKKTZfinFlhY=
X-Received: by 2002:a05:600c:4f8a:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-493f87e6e9cmr127818785e9.15.1784018849325;
        Tue, 14 Jul 2026 01:47:29 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495086ca93esm59158715e9.0.2026.07.14.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:47:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:47:24 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alX3nHLykNc_nng5@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
 <alUJa5cbjjqZ8n72@google.com>
 <alUMVU7DYcrvgAYi@google.com>
 <alUsLFBQ5qKFOgwQ@google.com>
 <alXwXRGqECTUZ3ou@google.com>
 <alXzcrnxWADIEL2H@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alXzcrnxWADIEL2H@google.com>

On Tue, Jul 14, 2026 at 08:29:38AM +0000, Mostafa Saleh wrote:
> On Tue, Jul 14, 2026 at 09:16:29AM +0100, Vincent Donnefort wrote:
> > On Mon, Jul 13, 2026 at 06:19:24PM +0000, Mostafa Saleh wrote:
> > > 
> > > That would walk the table twice, first time with a massive map, then
> > > to unmap the pages that was just mapped, issuing TLB invalidations
> > > for all of those, also as the IOMMU page table code never frees tables
> > > that means we would immediately exahust the IOMMU pool.
> > 
> > Well the massive map is pretty quick we would mostly just allocate the PGD? And
> > then it would be just for the subsequent unmaps to split the blocks. So nothing
> > to be freed really and no risk to exhaust the pool. But if you put the calls to
> > the host_stage2_* functions that's pretty transparent.
> 
> Not for the IOMMU, everything is mapped with a leaf mapping, because

Ha Ok my bad, I didn't get that!

> the pgtable code does not support splitting blocks, this is something
> I plan to add support for in a follow up series after this one is
> merged along side other optimizations.
> 
> > 
> > Just to make sure I am clear. Here's what it could look like:
> > 
> > in iommu.c:
> > 
> > int kvm_iommu_stage2_idmap_init(struct kvm_s2_mmu *host_mmu)
> > {
> > 	u64 addr = 0;
> > 
> > 	for (i = 0; i < hyp_memblock_nr; i++) { 
> > 		kvm_iommu_stage2_idmap(addr, reg->start, IOMMU_MMIO);
> > 
> > 		addr = reg->start + reg->size;
> > 		kvm_iommu_stage2_idmap(reg->start, addr, IOMMU_READ | IOMMU_WRITE);
> > 	}
> > 
> > 	kvm_iommu_stage2_idmap(addr, kvm_phys_size(host_mmu), IOMMU_MMIO);
> > }
> > 
> > in mem_protect.c:
> > 
> > int kvm_host_prepare_stage2(void *pgt_pool_base)
> > {
> > 	...
> > 
> > 	return kvm_iommu_stage2_idmap_init(mmu);
> > 
> > 	/* 
> > 	 * From here, all the changes to the host stage-2 will be reported to
> > 	 * the iommu driver
> > 	 */
> > }
> > 
> > On the pro side: no custom walker and we really couple the iommu idmap to the
> > host stage-2 map.
> > 
> > On the con side: As you've pointed out, we'd need indeed the iommu to be ready
> > early enough.
> > 
> > If you want to stick to the snapshot function, could we have the walker to
> > first walk the hyp_memblock? the .arg could just pass if we are walking a MMIO
> > region? That would avoid that find_mem_range_from() and I believe would
> > massively simplify the snapshot walker.
> > 
> 
> I see, let me try that.
> 
> 
> Unrelated to this, but while looking into option#2 I see that
> __pkvm_guest_share_host() does not call either of the
> host_stage2_set_owner* so that requires another explicit
> pkvm_iommu_host_stage2_idmap() call.

It does! it calls __host_set_page_state_range() which calls
host_stage2_idmap_locked().

FTR, I don't really like __host_set_page_state_range(). And we removed it
recently from our Android tree. Because there's just a special case in
__host_set_page_state_range() to cover guest_share_host. So we can easily
replace all the callers with __host_update_page_state() and and call the
idmap explicitely in __pkvm_guest_share_host().

> 
> I still plan to use option#2 in v7.
> 
> Thanks,
> Mostafa
> 
