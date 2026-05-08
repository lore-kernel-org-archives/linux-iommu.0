Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031F41B363
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259647; cv=none; b=l8Afd5RckrVt83o0Q/hNgmIEj8Kj/xReL/8dqbsf12yHfel2MR2mi+BK3WZhGzQfhoTmm0Knbvfjtsaux2AFDdd8jIHG+z/FIHrxyO+vyK/8p6PzflkS+YPpVn5wlDFIucdLeXcAE9lJ7KoV07YBQsyBXUnY36F3YwCJypIyCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259647; c=relaxed/simple;
	bh=LQZWr2unc8sVlAWk2yUZEeONw0MTY23swA4fe2VvNAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s23SH9fefVrsiVhgRmQsQsaxGhnZwW1LvlitsC31M6UPaWZRAKr5Qup4CHbn7PtKWoHwMdPpUPcs6YSdHKbdv1MfhuO1AIirTVQMVT17jciuY5k9a0Za9QGlxr4A1qEuz8bgs+BmteYWkGIncKr47LL5dgiDMm4Kx+lLYYCMxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i56LZ7LE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i56LZ7LE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso114745ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778259641; x=1778864441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSX0WcNOlkvsZCAblteUbbAr85dTr3acCULxV7BG/80=;
        b=i56LZ7LEu2SN+mVGHsYDyH/SmRb8EtB4l1e4fY6fd6O1DmAoMxUefiJJT721cIVPAQ
         LKzbOHUqNhkrkdQsJUvZqc3p/05XWnCLG+L3F37DvwSuLFMYU57vlJ2fqfdWu3hXYOVS
         wQJix9uA3tYAlug5FHggTUsne1UZeMqK2L4PL+PVWm1fABOa7JbAx/A+WYccLPYkmCKb
         cAEtY8pRMsENkqCp0F6eM2UYbfuhjXI2QR5+Y9UvkG0Ldct3k4bV4ARtL3DdCIxunuCH
         vPbghOQqY9Ku7I/rYkNKwcdvzAntm/PlK6yasjnC9ifOUgWpnamXnPBtHPZp3Y21P4SJ
         xnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259641; x=1778864441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSX0WcNOlkvsZCAblteUbbAr85dTr3acCULxV7BG/80=;
        b=MmvUcxDGC8KRICft0dcknXJ9Wauk/AyEk2kcsOW65JkG5Y6Pq10kzLrM8Unr8ywPTI
         XK2PusJMGtiYIkx03DG6kMRqbt+JDdZ0xLa7HyRmqkxVDKkoit51MQkUsxpjTrBhLsZI
         3/ICNOwEtTZvTpccwlLOgMh0XSDwPLOH09ZIfgJyuqH2odjmHGXf+r6uL6zAJQAm6Xhr
         3IEmLUAnI0Fj3HgrWjBK8jXAK8OERpJsNkyugxsTlOlLnjWB4XWu7pO5hV6pnsllcfUg
         2HH6PGMTOdXzOSw1OPAD0kwktJ+/4jxq/79zbzEVY1DDsp3QLRXLL7K3pFubjM5+amcU
         UKtQ==
X-Gm-Message-State: AOJu0YzETX0R3nPXXhdumT1hOQo+mcESRv6/d+34WQBChMWRh8OXegHr
	SOmbEBaVPbNlbh96PP1ylYEDpI6yUuiIMybzq5zkXSAvmejrY8ed7ZOUXJQ7c4cuSbRIOY6y7u+
	mkbOh3Q==
X-Gm-Gg: Acq92OGCdu7VKCZsEgdte/3jTdaiC+KDsXO4dtaodc4OCohcsUmVXD1swOk+7FEGHXQ
	f+MQNmwJbExICy2yaZ2VEWAWN7no3/RFZdW5lMDHvNE13eFxAoT2qISSvw15HvEEFOs8NThORe9
	vGthPdNNhf4l8lm44eu2y7jk4mNAILspLPC0FbbmwoUUtmN9f5xKBYF9BpXTtkuJ06atoe+qmIG
	CLxURciSSRFZJK6aUXB0seY77IniuG/acJapvXfb3W427xt3fHBavomVCOALAgIPIGy5q5vr8cU
	1kixjjfjGQ74m/Mhtx5mPQrNv70TAP4VR+4BCHYiw3UwhdYoiqyDIvB5k3JY9xviLmyixRMjLUg
	nxON0AgJw6n2Af0VWp0TFzMgBbnSmy3dxfpUrwAvWtpr0Bc1cBHQi9EDUmBqk5RrewcYgTkshXx
	kyAtTfqpMwOIdJ8nLvkmCNJqYlfAK3vlvnQBzftH2j0OaEndbRW1eaZXfoKgC7UePXlme1
X-Received: by 2002:a17:902:da87:b0:2ba:f71:57a8 with SMTP id d9443c01a7336-2bae9e663eamr4007225ad.10.1778259640757;
        Fri, 08 May 2026 10:00:40 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d26944sm25742125ad.10.2026.05.08.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:00:39 -0700 (PDT)
Date: Fri, 8 May 2026 17:00:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 3/9] iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq
 submission functions
Message-ID: <af4WsCVOlOFBzy_Z@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <3-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <af2ebtfgOPzJMXFK@google.com>
 <20260508160041.GF9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508160041.GF9254@nvidia.com>

On Fri, May 08, 2026 at 01:00:41PM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 08:27:26AM +0000, Pranjal Shrivastava wrote:
> > >  /* Should be installed after arm_smmu_install_ste_for_dev() */
> > > @@ -4823,7 +4826,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> > >  {
> > >  	int ret;
> > >  	u32 reg, enables;
> > > -	struct arm_smmu_cmdq_ent cmd;
> > > +	struct arm_smmu_cmdq_ent ent;
> > 
> > This shouldn't be uninitialized, we only seem to be setting ent.opcode
> > later in the function. 
> 
> Yes, that's how the existing code is.
> 
>         struct arm_smmu_cmdq_ent cmd;
> 
>         cmd.opcode = CMDQ_OP_CFGI_ALL;
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> 
>                 cmd.opcode = CMDQ_OP_TLBI_EL2_ALL;
>                 arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> 
>         cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> 
> > Since arm_smmu_cmdq_build_cmd reads other fields
> > of ent to build the cmd, we are potentially sending stack garbage in ent
> 
> Ah, it is tricky, it doesn't:
> 
> static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> {
>         memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>         cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
>         switch (ent->opcode) {

Right!

>         case CMDQ_OP_TLBI_EL2_ALL:
>         case CMDQ_OP_TLBI_NSNH_ALL:
>                 break;
> [..]
>         case CMDQ_OP_CFGI_ALL:
>                 /* Cover the entire SID range */
>                 cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>                 break;
> 
> Only opcode is used, so it's "fine"
> 
> Later patches remove ent and this trickyness so let's just leave it:

Ack. Sure. No strong feelings here. 

Praan
