Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775601B87C0
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505702; cv=none; b=XnQHV5JEvw5GiTKCduYQDYg9fjGRFB0r2scrHvvZ8nOyBw2tB6yaP774ONTZkpHRwbgCy8oamb3Ad1quOB/AIK5IQV5bF1nXrusZlmo3D65xMFfTUEwNAwZqaCDSEzX/PRiuMvf6ani4nj4BfHbTA7uKZFEmqR0SZK0zCsNUoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505702; c=relaxed/simple;
	bh=TVx456v4bPVt5hN7INd320N3ng06cE3ZqomA3NeIx0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWjSFbIMXcveqaGF1/PxSTZJ/MFVUVPrVEQ2gfTWu2ZoKyzg43z1oDiImpbRw/frdFIbI92AgFS3hdkd1c7FjRgQPI2hUDFqK4SgdRQKaPH5mMe4dmWnMaqykI+bAYWMcdhuOFfHOaExYi+PP/FGOW1sxLKenRa6g/CWsgy4VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UeOmdIne; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UeOmdIne"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso735ad.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778505699; x=1779110499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odoNhC1jkxHEmpElHSk6/Y6iPKFT+XGqoxzHTbmY1lw=;
        b=UeOmdIneDKKaX3RSWx018UT3yR01BRj1o43NMdY/5mS7Q+pZ+yYrZ6wAGyddHFsiLt
         pLlCsCSqlkzwJHYwudLqeeNBL8VM6w2+TL557/Zitv1XXrLLytu7IE8/oyhpU7+vPrbQ
         h/N1rrn60UGKFvOCsLU/06quzGIdmABNNVzFy4OZmymKATP7aLKe1yLDlrAjZ8+0dpUi
         KbaZex+bR88ezvLdH2HRpbGOOvQVv7VyEC5ba1QdLU6e+6gTokLnRCIcH/qeUn3ASRFU
         /+SFIp4XY3EYZDnPKYzRsi7WsWaub8/fUjctGGlJURyKl0TObZA6jFGfbzEsnYGC+u6t
         Ep+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505699; x=1779110499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odoNhC1jkxHEmpElHSk6/Y6iPKFT+XGqoxzHTbmY1lw=;
        b=r/OmIprJscylR3vAW6jpYS0+CFAVqTomGxV/p8+GV99IyMuRxzYvyIcGp6wF5mcu9n
         OGpYuViHRtyEIwC96oAt2OQ17uJLpu7LrO8DWV6mldPBHFq/4R3g1QyUwFxv1qaQSPtG
         duyr0k7KyOszFQN34G0EvmURIegB1iL+ybqS05kvYKCcXVbBbTCTdPAuDbe6wGVRyJIo
         thLbgbEmq997yu2i8Tb68fog2uY6oc4IANGOmeb1ImhnNEtgjxaMtDYY32aeDy0zL7oI
         R0tdZo78hXoWQpnuxrfZi/tXqn4JnkYDdEsaNEI/1cimmZAPo6wYHlilNjZV7yJY8flI
         eQLw==
X-Forwarded-Encrypted: i=1; AFNElJ8X1Fo9b4C1eKs59Jslh4fhZ5S5kcTKHlTQiX22NOQO73/Hox7t2zxTpfFQtMgLoUH5ROcVdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpzgW8N8QDYf64Avtcb6hQF6LShnOA7EpcGkdDfua27WCm6yZC
	wpB4pC76300xI7L4oUWDC8B6PBmbCzaKNpx6i53nJyqhWeH9zE5bhDnVR4HTbqVEyA==
X-Gm-Gg: Acq92OEWipNhGeVlPVKZoMw6OysTaJTfvfU64l8FsCjRh/9UllWYBz4BmWGJEyYnsyx
	STWuwELpD3uDTNHAclkCThBeLelYP074FEvX79WcPowCvwhB22sTQSDT2pZu5d6EnQ4Rn1ccGWA
	oqHr6gAgtcVy1Qx5CzQqyM7O+A/O6jpJHZsw6wPXIUZ3Jf1qp60e0Yi3OUZSxX39DJLWcpOg1N7
	+L3KZMlgYAkqXeIOJFLvztD9n2l3MEJv8dPzF2sTwfl6OGHBj2NqVIy/nVFD667fDOq09snyPfV
	KK6FkHvGK7AmUnpUUGAzm4Mf1fpxSCj0jofhtcdlXd3lwrpTFyhrBY58i1QdM0LV9xMqIVLjMM2
	HFsOa76OtKDdHegHS/HXWJpW2I0p6XxvqJnOq/iJyL9E2/2JWLLykQp4shqITWe62b3TOKh1Zx8
	KuVQ5sYxVhuRXCQAMEH8GJXP/SMkHaJb1LILPIFZXkPhK5KjNdLOGEzsHq92c8nQwPKn5k
X-Received: by 2002:a17:903:1666:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2bc747c1c17mr5151525ad.14.1778505698122;
        Mon, 11 May 2026 06:21:38 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm20960916b3a.19.2026.05.11.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:21:37 -0700 (PDT)
Date: Mon, 11 May 2026 13:21:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <agHX241sD1AjG8KB@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>

On Fri, May 08, 2026 at 03:24:32PM +0100, Robin Murphy wrote:
> On 2026-05-08 2:57 pm, Pranjal Shrivastava wrote:
> > On Fri, May 08, 2026 at 02:31:11PM +0100, Robin Murphy wrote:
> > > On 2026-05-08 2:12 pm, Pranjal Shrivastava wrote:
> > > > On Fri, May 08, 2026 at 09:35:50AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 07, 2026 at 10:30:14PM +0000, Pranjal Shrivastava wrote:
> > > > > > > @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> > > > > > >    		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
> > > > > > >    					      CTXDESC_CD_1_TTB0_MASK);
> > > > > > > +
> > > > > > > +		/*
> > > > > > > +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
> > > > > > > +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
> > > > > > > +		 * share the same bit.
> > > > > > > +		 */
> > > > > > > +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
> > > > > > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > > > > > > +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > > > > > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > > > > > 
> > > > > > IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?
> > > > > 
> > > > > SVA does not use IO_PGTABLE at all, and it directly constructs its own
> > > > > CD.
> > > > > 
> > > > > No relation between those two flows.
> > > > 
> > > > I understand that but I mean we need to know if the system supports
> > > > HTTU ? Like for SMMU we use the IO_PGTABLE_QUIRK, shouldn't we be
> > > > checking if the CPU's tables support HTTU?
> > > > 
> > > > Are we assuming that if the SMMU IDR presents HTTU capability the MMU
> > > > would also have it? I think an unconditional enablement is risky as we
> > > > may not have system-wide HTTU support.
> > > > 
> > > > If we look at arm_smmu_master_sva_supported, the driver already
> > > > maintains a strict agreement between the CPU and SMMU for SVA.
> > > > It checks sanitized CPU ID registers for things like PARANGE & ASIDBITS,
> > > > and it uses system_supports_bbml2_noabort() to decide whether to enable
> > > > FEAT_BBML2.
> > > > 
> > > > Shouldn't we follow this exact same pattern for HTTU ?
> > > > We should probably be checking cpu_has_hw_af() (from asm/cpufeature.h)
> > > > in the SVA support check or here if we wanna enable HTTU.
> > > 
> > > It might make sense to depend on CONFIG_ARM64_HW_AFDBM - when that is
> > > enabled, then IIRC we already expect to cope with some CPUs not supporting
> > > hardware updates, so it should still be fine for an SMMU to make them even
> > > if no CPU does. However, if it's disabled then I'm not sure if missing
> > > access flag faults (if SMMU HA silently sets them) might be an issue - for
> > > dirty, we'd just never put down the Writeable-Clean permission so enabling
> > > SMMU HD wouldn't do anything anyway.
> > 
> > I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
> > doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
> > Since the fault handlers are already expecting HW-triggered updates?
> > 
> > Which means our check would be something like:
> > 
> >     if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
> >     	if (smmu->features & FEAT_HA)
> > 	 ...
> >     }
> > 
> > instead of cpu_has_hw_af()?
> 
> Hmm, looking closer, cpu_has_hw_af() is the thing which actually influences
> mm behaviour (via arch_has_hw_pte_young and arch_wants_old_prefaulted_pte),
> and that can still be false at runtime if ARM64_HW_AFDBM is enabled but any
> CPU doesn't support HAFDBS, so perhaps you were right the first time :)
> 

Yea, I believe the cpu_has_hw_af() is the right gate.

> Although AFAICS from __cpu_setup(), ARM64_HW_AFDBM will still
> unconditionally enable TCR_EL1.HA on CPUs which do support it, so maybe it
> is OK anyway?
> 

I believe cpu_has_hw_af() is still the safer gate for SVA. While 
individual cores might turn on their local HA support, cpu_has_hw_af()
represents the sanitized system view.

In mismatched systems (where some cores support HAFDBS and others don't),
cpu_has_hw_af() will be false & mm shall default to software-managed AF/
Dirty for consistency across all threads. Enabling HTTU in the SMMU while
the kernel mm is in 'SW-Managed' mode could cause the SMMU to silently 
flip bits that the kernel is expecting to handle via faults, leading to a
mismatch.

Thanks,
Praan
