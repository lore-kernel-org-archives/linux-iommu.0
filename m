Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56443D4E3
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831111; cv=none; b=BkYzXpHodZUeusFHQ/LAIoXSqIYnAhgHg7vJVUaVNQHSJ3j9+NzhtfwcD1Pusxiy998wwsBNbWTaQjqN2dKAXZ0VBDBAcqjQ8sW7C2CpP/OUKdaKTJWqGf8DA44SNIivPCxLlJs/Dn6TdktC+j1tcfQCnYUXnNkjmSkvPtwj2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831111; c=relaxed/simple;
	bh=E4G4LPQQ3Dkwous6BybFpxhhimjU64PRxq0Qq1ULgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtdN0h/DHy6o+akKFDJ5/9oe1DAVbRos0+MdM5cvsDtk5fyusxawZgrkQEsf8X/NRF8pSyICCLV+bpnYtQrDSrpY2K/IK1SJsuc4ws70CWlby9KjURkrX4gS7Nn/r3OSJfcssX9v4lEHmUn8vhHtT2Pi54XknUY3LVkjho/9ZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDsyjz7a; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDsyjz7a"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b1db4964so54655ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782831107; x=1783435907; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yhTYmczFL2uCxVu8k1+oZGQNpSYllSaCHFjNudZdlY=;
        b=YDsyjz7aidwSAkxYA08yvUlMyw+iuKiOKjezgrWWgStWe225r+MgHsz6OLXiE1KO2n
         DGn8hWkUpssKBZVukXXZQLWxISnwsqLWa4iilHdCdYJtp5TLCE+y0RuYsu+prWfCTMZi
         wbPTRHJi7VC3h7MuRbNAxtAUKx1qJbQx9Brw2x1BRfcJYK+DPMzmNk5bXWm6DofjixQf
         +MIOPVR+iX6fgFjalOJg2Ha+snWx8bozx15NZuG/tfpPabRd8QM909IKU/9VdsxRjhwJ
         E/ItNk5+bFGx+vKx/R9vNXAs1YuWTUo7xzKJ3nEq9SiK+TPatC6ExPcRcA70ptCaPSyZ
         I8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831107; x=1783435907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yhTYmczFL2uCxVu8k1+oZGQNpSYllSaCHFjNudZdlY=;
        b=Um96Np7VShj1z1MmrPoP0O2/p+v+WChpCe+I+coMwuppJimRl1ORK+/D/MtLfN17qX
         MKs3j1S7ujhbPB/USOi7akkzFfi8Rhh88Pup8M0NlShxyoz20aPyizEnAQyI8VKIMfEk
         Pax0Q71F+zckIyHeRVHI55V1D5MWnXQgMNpj/YiUdDC3PUXxKbSxDcm1R+ivYEn5pfI5
         sSX2/GbE2XttZ4Rz3fwzsqD9672CCrWth4YJbvDmfmDL+Z0rIKC4QYlYuDs1aQ1TAP8f
         xtzQIJJP1bdcxDO95RcrXrqqBmAg0ZLAlpFRcCQyw+Oz4tJRe4J8Zz1ShNz0nYMl+x8P
         Eh0w==
X-Forwarded-Encrypted: i=1; AHgh+RqCzdiIplEpMYWBv5AmBefvmQp+s90Y1FWXKB5KQyaA53hrAnuk1F+d27E1WRG6xLuLgJbe9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhit9wyo9Wk5NBeEM60M97ForofSFeW3d/2qttj1dUC+AXWtI1
	UUt9qRmQTaYmo8AVT2RLv3nDwscTM3YuVZKKMN1uoYNOMJL5ikySMLnG6S4Z9Z4WHg==
X-Gm-Gg: AfdE7clWECgGTZElkDqSxfusXN0Ti+8EghFVHOexmSTDTrgELlEvYW34UAYpf2DHwDw
	iGB7BEPfla0XcYd3caT7RopG2H2wJ7uQpmyXASI0XvYtuYqu4WRM4WHQZusxX96dvqGwq6fCHvf
	qiud6L/R8DsdEM3tlasoRqFAUGkFHtaud7D6oSHRkNB1zT6wUrNM8g9KCYUKoTs8H6XCkJt7opv
	1Lex8lKVENQ3V4F3JUtB2flO3vS9/MW1RWvCzfX+shKwcNZN4vp8amIzmo0bNj4M7lMuTCzUjoQ
	VvABvUt/a+F7YSBUFI0p7/Q0GeMZhp9j5llxn0OSY7vWUPvQn8TWtR5R40HEEe0v3Wz/qWOnD9L
	lLs4s56wEmG37iEYCcTv7crm9YS8jvmyFibMkE7dm759fphxy2IuezQQeoHxQdhyu/4NU3HhCr6
	fX9Auv5yOY7mzsEwrupOCIHfPsTJZGwD2ue+ghbAE2XDbyBws=
X-Received: by 2002:a17:903:ac6:b0:2ca:4f33:e87a with SMTP id d9443c01a7336-2ca5d8db7b3mr287655ad.17.1782831106989;
        Tue, 30 Jun 2026 07:51:46 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d64c6sm15636325ad.82.2026.06.30.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:51:46 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:51:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akPX_N0P2EcI_jbV@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPB6l-fuJUcg4a2@google.com>

On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> > When transitioning to a kdump kernel, the primary kernel might have crashed
> > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > 
> > In a kdump scenario, this aggressive reset is highly destructive:
> > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> >    PCIe AER or SErrors that may panic the kdump kernel
> 
> Can you please clarify more on those errors, what conditions will
> trigger that?
> For example, patch 4 disables the EVTQ to avoid events as there might
> be a lot, why are they not fatal also?
> 
> > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> >    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> > 
> > To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> > and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> > flight DMA using the crashed kernel's page tables until the endpoint device
> > drivers probe and quiesce their respective hardware.
> > 
> > However, the ARM SMMUv3 architecture specification states that updating the
> > SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> > 
> > This leaves a kdump kernel no choice but to adopt the stream table from the
> > crashed kernel.
> 
> In many cases the patches assume that the CDs/STE might be corrupted,
> but still attempt to retrieve them with some validation
> (log2size/split...)
> However, the base address might be broken, TLBs state is unknown...
> 
> IMO, although that might improve the status quo, there are still
> heuristics, in addition to noticeable complexity to transition the
> stream tables. I wonder if FW can deal with AER in that case before
> booting the kdump kernel.

I guess we're reading the base address from the HW register itself so
that should be fine? CDs are in-memory so that's why they could be
corrupted?

About the TLB state, I'm not sure what might pollute it, since this is a
kexec, I don't expect any non-kernel entity to gain program control
before the kdump kernel.. Hence, IMO, we can't configure FW to deal with
AER here..

Thanks,
Praan
