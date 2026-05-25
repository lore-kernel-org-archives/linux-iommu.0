Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CE3F0A94
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722968; cv=none; b=iDH5esWiK8jmIeAOfuRL/hqQu7TvzPFkCiZgP54n8MBKgshbp6EzGAF1g+SBU42zawkcE0cPEu+VrAENdVTg0fo4OW5VUNRTzmYb0nxVtoLQaWUlv3I5f3Cthw31UNyAzK5f2AdH1BxUqIVYewFKbx4qeG0GSVqbil1iSy1AYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722968; c=relaxed/simple;
	bh=fKq4aVwbvax1aR4yy8POrWwpM2YYfG4hq56u4z+Cm4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfR9tlZQwp68IiG6EgV09rRFZRh4btNoVEtQcpbXGpgbLugUrljrREf8ZxXcvCxPH7XjQxyM2h/4LEQ7koDGosam72dt8k2haSgOcHvY3HDIIoFdac3jN81loBETxGHqvZlxTXhFjD8oZPKwEn9DrEsY2Vdn/sq9HZpHjwj2uKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VotLtTy+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VotLtTy+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836cfd84728so4954326b3a.0
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779722966; x=1780327766; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4b1oC5HhUnRhm7z2afBn84VUcPa5B5EWRXQvz0Iqfxc=;
        b=VotLtTy+pJet1CxUU2MhFWpKTATIVKMIuWxrDPTWOI3b1zkact8CHZd4iiaHWU5tBD
         k6wdKRrLp7RuAGD7KVYPrzbA43LjuaaGhXXMmHDH6BLfpXJRSn5z8lXuZckTbPWdVf3T
         6lZ9TBGuyXMaaCDnHDZYcnUuJnhTCpFBBLAKY+w3hGgSIDzBhCPTl8AAC+iqjVV4gjHI
         Z+GpxBV35oPUMqVF1gBLHu7GGBcnWfoW2H6o7oYLAGVuS0gtpYuQVawvv3F7K87X7dNV
         iIL0/+A9rda4Awxkzmp2AwepqZQhmvwtlG14JXvX75fI5iKSuvOWAics7NhoFpZX1E4c
         2t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722966; x=1780327766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4b1oC5HhUnRhm7z2afBn84VUcPa5B5EWRXQvz0Iqfxc=;
        b=Q9D56JG969nDh9bbgRjp9oM/E+/urizMgNrs9XJsGqc51TRAkY0/Jj3TgQmdPgG3v4
         KZc2IbFPZp2Ih7XsyIDkiou6N4elC6jmfiXMuVydCVe8lY4/Kdp4H5J6xO8UIwokks0G
         dPpS8J71h5dQWERWk9HcMzgBdPqdNQR7+uj8AvBqh9026YyFesu6RZarAmHl9UPKe/Nt
         oK4NXgzSWTZA1APEJm8ektjCj2DXrOurIg3y8ZB9tMjf1eHLEymnoOQtFN8FFKfm2VOC
         WjwPw14eowyyU8w9DKyU3gCTgyTLsW+lg2fKujkn/kRSwYkFjh9uoPpAcepoDt0pypXi
         FAIw==
X-Forwarded-Encrypted: i=1; AFNElJ9Odt7LmEwxIGo08fMGUZPwiH48Ul+NMLZTBYXVrZWyDSuV74pBYMURgPRBEwA4KB3M4OeyFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhR8z1PQ9kRRfXBps+j91VHoLvHxRHLdCtRMN6/tyjzhcD/CCu
	K8jkim6THE/jUvzDxP2JeUoQAqIG9qMv/uMKj2iMaM9Iued9IgEwi2BgaNNAiGsW/7KJ4IE3rUH
	LWaGiOpKCSnqPVsbpGsHhTAoNAA==
X-Received: from pffv22.prod.google.com ([2002:aa7:8096:0:b0:83f:8b6a:7319])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:808f:b0:837:21dc:6ad4 with SMTP id d2e1a72fcca58-84160b8441cmr10891888b3a.2.1779722965809;
 Mon, 25 May 2026 08:29:25 -0700 (PDT)
Date: Mon, 25 May 2026 15:29:24 +0000
In-Reply-To: <BL1PR11MB52710D3CCFA2F75F6B540A468C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <BL1PR11MB52710D3CCFA2F75F6B540A468C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525152924.524721-1-joonwonkang@google.com>
Subject: RE: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: kevin.tian@intel.com
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, 
	kas@kernel.org, kees@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com, 
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com, 
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com, 
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

Hi Kevin, thanks for your review.

> > This commit resolves the issue by allowing device driver to maintain its
> > own PASID space and assign a PASID from that for the process-device bond
> > via a new API called `iommu_sva_bind_device_pasid(dev, mm, pasid)`. Doing
> > that, however, will disallow the process to execute the ENQCMD-like
> > instructions at EL0. It is because the process cannot change its PASID in
> > IA32_PASID(or ACCDATA_EL1 on ARM) for each device without the kernel's
> > intervention. For this reason, calling `iommu_sva_bind_device()` and then
> > `iommu_sva_bind_device_pasid()` for the same process will not be allowed
> > and vice versa.
> > 
> > Currently, there is a limitation that a process simultaneously doing SVA
> > with multiple devices with different PASIDs is not supported. So, calling
> > `iommu_sva_bind_device_pasid()` multiple times for the same process with
> > different devices will not be allowed for now while that for
> > `iommu_sva_bind_device()` will be.
> > 
> > Another limitation is that a process cannot do `iommu_sva_bind_device()`
> > if it has ever done `iommu_sva_bind_device_pasid()` even though it has
> > been unbound after use.
> 
> Why not making it clean in one step instead of leaving many unsupported
> cases which are likely required soon in this "1" to "many" transition?
> 

Since I did not know much about the IOMMU team's future plans on the IOMMU
core structure, I narrowed down the scope just enough to resolve our
specific problem and avoided introducing big change. But now that I have
two queries to support the 1-to-many relationships in this patchset, not
in a later one, I think it is fair enough to start working on it now. I
will try it and lift the limitations.

> for each mm:
> - one global pasid for ENQCMD or ST64BV0
> - an array of device local pasids tracked in [struct device *, pasid] tuple.
> 
> upon gp fault or equivalent, fetch the global pasid.
> 
> upon device-specific bind, match [dev, pasid].
> 
> > 
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> > ---
> > v2: Reuse iommu_mm->pasid after SVA bound by
> > iommu_sva_bind_device_pasid()
> >     is unbound.
> 
> No idea what it talks about.
> 

There was a bug in v1 that the second call for `iommu_sva_bind_device_pasid()`
failed after the first call with a different PASID was released. Will
rephrase it in a clearer language in v3.

> btw a new kAPI always needs accompanied users to review together.

Currently, the only known expected user of the new kAPI is our team. Since
I test if the patch resolves our problem before sending it, I believe it
should be good enough. Do you mean more than our team by "accompanied
users"?

Thanks,
Joonwon Kang
