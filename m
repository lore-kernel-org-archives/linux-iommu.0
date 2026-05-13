Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E921349CE6
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682479; cv=none; b=hAcYEYTxBzxdaWBC3VVkWcLNLvN7H4okppZen+KsO3pyQO0EoU7Og/Hd1DrdCDU67xyFtpo9yVEteU9Q8v/GFLZfSMVwdiWk/fICdCaJC+wuXp12vprayh4pFdpvpa2jvMpgTJfNd+A5MjG1mZrjV+HkptZktBQYrFmWs6lixkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682479; c=relaxed/simple;
	bh=XJ3mfSG5bhBulx6TUSY6t5fiBkHC3+OsF05wOi9w0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9Y/I9eH/JaKrv79Q+fof/p8b2zbNp2g/ZuNQAxc9N6h3zer1lGbC3VLMScijxRHomNliGrF+4LJNfxCoo6+Yoe9Q9K1aiQ5lD4zrqSJFhf+y5TkGXJw2ajFbg0OIJAqkX+NVqE8kW1l/UFefDiFVHYgPGJ0Tu5efwfmJCwEQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb6tMWjK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb6tMWjK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so135ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778682476; x=1779287276; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3TnKwYV0Kzd1zXkaaqOGDYWO3WX2nNMrzmPg/2ozAlk=;
        b=Bb6tMWjKYAkHbnc+HhbMdmJXAdiTF05C3ptwMBDL6Y6YWYHTByc2qOGg917EDqOurP
         yqa5fEaMHoUcgjCi7Bc62qsNWEtIrQw5bH5n3+RpC70ThYglu57swE8Xv28zCZ/HPAYh
         WGNpmNO9vQjvevf9GKFzNKWOeFWuUFgBdK5Lnhoc+16bX8CgjCiRv3upzsr+LFVVZcBH
         yPtucq/TnAUwA79jCREj+LZuFN9IPN2co/v4W10UPTmuNaaBl6oqCEpZP22Q7GGTH7/U
         gzCx/FqvJ8/MIFtPU95JG+/yJIEHZ9+O4OGgFHA8+ykH8FH0SfIZpfM0SK//ynyORqnO
         3e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682476; x=1779287276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TnKwYV0Kzd1zXkaaqOGDYWO3WX2nNMrzmPg/2ozAlk=;
        b=a50tlusRizvXybfGVhvBKoBescRj3H8CrcSo59n5UsRDgjGDFMWDNijsljGbkR4SgS
         6kLqqDImPODh5U8cejyx5Ueyb/Ao1EdXj30dhOsS/S7YREMLboyZAxGrYy7WpEe1kKmN
         7UrUzlC1IuCOVvxqseuC3O/7grF5WwxGwMl3zsWyv9O+bY/s0X5UtZ1y8i6yTDvtacID
         D/RE55lHUIt8eHp4zlMszQdYDnXnQravWYY+aT8KbKkuQpjFuj/byotwNlNmPyb9qBlB
         86VuYs1apI3AUb7H/BvAZ8k4gZXSSkAyYyiMkTvmVAte+WTQVl9YEb3vfgV+Um9qBGZr
         Q5Og==
X-Forwarded-Encrypted: i=1; AFNElJ8ZeMy9s7t4KxDEd/pAQgf5I5CiqkBrTSf0K1/93heUMKYkExrcseCNFGepdcZpuwM8ddtJLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxstkLJ3qiuSOMRQZ6aSkTuB6QEiWG3qZ9zp1yz8KxX3Vbz0U/U
	MJYTGg0lTYma2CpT1sSKnZFxZdlWqSLkn4aYWJtAMRxkvzQax7r+CN88fdQJotppaQ==
X-Gm-Gg: Acq92OHWitljv8chVYz6HyqUZ68kY2+hRTqUYcTXyfpi4gY3tRUzM7+s+kyNCQzVoTY
	FShUh3Ta0r1PFVOQzybgzOIx2Usn6P1f/wyIgV+nd3RcRtPxy3IUf5TkovNoqY1j4oSkw3gIxGd
	w/Ahjx8nPvblzygB/kTyNXNc6n3aE5JpdWU98/mKkvyI94rmGRIUQfBeQ4lLXbDLongCl53R9ny
	uz6TWKgrkTLeHRRJXV64uVlzu901tydBRqhnb3prasN+qMljt0btlnhXQeQUjjevJR2sFI/63Oy
	2qq/oTyOpywHfILRHbsH3KI/22Ltw3ZrlEG9uc1xO7cC7WAMU7F3x5wgYoa4HBKxW1fYRxHUCRB
	IM5akv9TPOwH8Mk0ihpavv4a97kiQX5U2C6AIZUk0EJ0BnigmYDNvDZ1hekXSTPBxCCGldWeN6+
	ABgeU0ltf5jEy+tGPXoe3yl6hcQ2tVkDnnTCgzUkesKC8EFxQh8CtIa5uUbwXgeKW+d/5g
X-Received: by 2002:a17:903:2154:b0:2b8:e82d:ff7c with SMTP id d9443c01a7336-2bd2c0f12bemr1729045ad.9.1778682475851;
        Wed, 13 May 2026 07:27:55 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edfa2fb1sm3416572a91.17.2026.05.13.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:27:55 -0700 (PDT)
Date: Wed, 13 May 2026 14:27:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <agSKZPJmFMLc0gno@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
 <af7oyeleKFXpcIKu@nvidia.com>
 <agHYDxuYyqzmAfy5@google.com>
 <agRjt9XpN66ktdk9@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agRjt9XpN66ktdk9@willie-the-truck>

On Wed, May 13, 2026 at 12:42:47PM +0100, Will Deacon wrote:
> On Mon, May 11, 2026 at 01:22:23PM +0000, Pranjal Shrivastava wrote:
> > On Sat, May 09, 2026 at 12:56:57AM -0700, Nicolin Chen wrote:
> > > On Fri, May 08, 2026 at 03:24:32PM +0100, Robin Murphy wrote:
> > > > On 2026-05-08 2:57 pm, Pranjal Shrivastava wrote:
> > > > > I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
> > > > > doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
> > > > > Since the fault handlers are already expecting HW-triggered updates?
> > > > > 
> > > > > Which means our check would be something like:
> > > > > 
> > > > >     if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
> > > > >     	if (smmu->features & FEAT_HA)
> > > > > 	 ...
> > > > >     }
> > > > > 
> > > > > instead of cpu_has_hw_af()?
> > > > 
> > > > Hmm, looking closer, cpu_has_hw_af() is the thing which actually influences
> > > > mm behaviour (via arch_has_hw_pte_young and arch_wants_old_prefaulted_pte),
> > > > and that can still be false at runtime if ARM64_HW_AFDBM is enabled but any
> > > > CPU doesn't support HAFDBS, so perhaps you were right the first time :)
> > > 
> > > IIUIC, v2 should be:
> > > 
> > > +		/*
> > > +		 * Enable Hardware Access and Dirty updates (DBM) if supported by
> > > +		 * both the SMMU and the CPU. It is unsafe to enable SMMU's HTTU,
> > > +		 * if the CPU does not support it as it bypasses mm page aging.
> > > +		 */
> > > +		if (cpu_has_hw_af()) {
> > 
> > Ack, yes. IMO, this is the correct system-wide gate.
> 
> Hmm, I'm not so sure :/
> 
> cpu_has_hw_af() doesn't take into account CPUs with broken DBM and, in
> fact, ID_AA64MMFR1_EL1.HAFDBS allows support for AF to be advertised
> without support for DBM.
> 
> Having said that, I don't understand why we need to care about the CPU
> support. The comment above states:
> 
>   "It is unsafe to enable SMMU's HTTU, if the CPU does not support it as
>    it bypasses mm page aging."
> 
> but I don't understand what that "bypassing" means. vmscan should still
> pick up the correct state from the page-table, so what's the problem?

I agree that for the Access Flag (AF), vmscan would eventually see the 
bit in the table. However, I’m concerned about Hardware Dirty (HD/DBM).
I know the vmscan might eventually get to it.. but here's my worry:

IIUC, in arm64 the dirty state of a page is tracked through a specific 
protocol using the PTE_RDONLY and PTE_WRITE (DBM) bits. A shared writable
page is initially mapped with both bits set (_PAGE_SHARED [1])

It also seems to be documented in arch/arm64/include/asm/pgtable.h [2]:

/*
 * PTE bits configuration in the presence of hardware Dirty Bit Management
 * (PTE_WRITE == PTE_DBM):
 *
 * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
 *   0      0      |   1           0          0
 *   0      1      |   1           1          0
 *   1      0      |   1           0          1
 *   1      1      |   0           1          x
 *
 * When hardware DBM is not present, the software PTE_DIRTY bit is updated via
 * the page fault mechanism. Checking the dirty status of a pte becomes:
 *
 *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
 */

Thus, if the CPU does not support/enable Hardware Dirty management
(TCR_EL1.HD == 0), it is forced to trigger a Permission Fault on the 1st
write because PTE_RDONLY is 1. The fault allows the kernel to call 
folio_mark_dirty() [3]

If we enable SMMU HD independently in the Context Descriptor, the SMMU
will see a write and silently clear PTE_RDONLY in the hardware table.
When the CPU later accesses the page, it sees PTE_RDONLY == 0 and 
proceeds without ever faulting.

Now, if we're work on an SVA page, with only SMMU supporting HTTU. A DMA
writes to the page and the process (CPU) calls fsync(). IIUC, it performs
a lookup in the Page Cache specifically for folios tagged as DIRTY.
Since, vmscan didn't run yet, this could potentally drop the writes..

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/arch/arm64/include/asm/pgtable-prot.h#L61
[2] https://elixir.bootlin.com/linux/v7.1-rc3/source/arch/arm64/include/asm/pgtable.h#L390
[3] https://elixir.bootlin.com/linux/v7.1-rc3/source/mm/memory.c#L3698
