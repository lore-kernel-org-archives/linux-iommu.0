Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2A3A1E68
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767571355; cv=none; b=SQnX+QkHov2q8QUhfu8x/TMOPyaW6ss4WbFtejwEWsowZrOWNgD5xSpfhUoAe31mlBOle5qfoal79RoZMKalpAWPTNYBvUKyIyGE4IyTGci9Pg1sHwjhcr8hILlHPk9P3y19qoFJBDE4pql8hNzqbiegjkzc/1JqRATXZ6f+WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767571355; c=relaxed/simple;
	bh=5Pd8XHirDAvBeGnaTQQoB4X3T4keVMq6ZwvkHBRkwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWgJ1Ir1+03BkQmQNAR/dHhzf2RwE6nSUNs/CJZP0glMHUcsyxXePMLs4+5k8Zb4uyzvuWj0lC3wA2jc5w9b3TdZODjXkbb+gwTBsOqfzlNXiF7NHKMwJb6DUaYGnzaPkX0UfOFa1+M2IsFKd4rpSnKK70uhR2U0wuGCnNuX7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zt7RhYAR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zt7RhYAR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8be92e393f8so157500385a.1
        for <iommu@lists.linux.dev>; Sun, 04 Jan 2026 16:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767571351; x=1768176151; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+jSiPWTak82xdkGqmhBxUT/Rw7weH7GEOHsr3Ick4Q=;
        b=Zt7RhYARxejrDcTLcrHBu+LzuDzO5VzcigpeDl2KfgcAeDpjdDASGZtet3+BIr22up
         MNz4mXwksh2SdR/t9S1CCkIKtmGq7DXTZUCZvgmcejLH2ndvClV+6sTiPL5WJQB7cbI/
         jLeKsMXe0/xM/ESZBMV0cu983RTOOno0H02zLqkq5k272+axNWVGZhQ93IqbN5XrDa/P
         gJSV5hsSaGPVuTNB2IvUBHfYvvmqG7tZsKOXWRZn4YRsA6HsIBOtJ+0yJEOks21oq+73
         aBuSSEC3iFeTEAPfSwJa6FbKT5YI0zYWKJOxkPqOP9vL4ZI6GMF+wXpV1/SKVIEVRd3S
         g+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767571351; x=1768176151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+jSiPWTak82xdkGqmhBxUT/Rw7weH7GEOHsr3Ick4Q=;
        b=uIgd555+UXF6VqS0ZlerA+fUITyeN6Himngp64H7GDCOWHvz1Y3/xlRgZVLm7qeis6
         38a7kfZ2XashY1WRMp1tP02P/Mxe5P0Qwh7d1HUI8x0EmZd1RmBq9uX3CXf2hF9b3MSB
         9/pRs//urZZbw34gSng8H69B78bLnKz3EtNijKXuyhxA8hkRf20zUYpY5AFVlgj+IPax
         zfX5DRaahydbfaUTrahrGgWJm7Nk7to6PygTRXjwtY5VHhL14i+0erIRSt2MLoGAkgT9
         hIp4cRkimBFSLNLy6GDDMPXXTTas658wa9o+NkiuW3nCLVaWWGdUlacrBqwy5qYKTl0t
         7J9A==
X-Forwarded-Encrypted: i=1; AJvYcCVAfy9LfE6UBvo++DV2hH+LgA6Y56jU1fT2EcHUWY7ITHG3oa6u1oYBlJEgJJ31ihJfYVOuIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzpDYyJhPnRDN7TVyQ2WYhPg1ng2DS+M9RJwBhoghp+NqNn1K9
	Cu/IMLpu/4eObQy9m2CJe5IfqJEwOE+53uXpdsw8s8G88Xv13U6hmSoyTd/L8hDbxyY=
X-Gm-Gg: AY/fxX50pyYCQS/xkfCY+iPvd7aXcnMhXsDoAnez7Mbc/vJwlEtBIgoHVbW0iGyULaV
	fMuSrDCECDjL23llymTSbKH1SZ+UDNnm8LIrOV2rURpNB55HBaiDPV2pPouZKKYfwyAyuPH6m6t
	mf6bH4+PWtzNImPdTS7XTSzNEJ7JMpVgoycH770qRonNSbqvb5/GZFGodHkk7fWlGJC08O7Zp4G
	C0oCctAGXOPMSO3TZ1/u02ySO71upEzT/mH/VqPx/KNLkPgQOFZD/lD0vtawPZTn+eyDEoyK9mq
	HQFDENqf/jCUyLi40FShY0XETWRDbUSPCuheanMMXo4Pvpvf/04uiixBln9w6So9zOs8v3hYZ79
	9jv2V/KNazmpCqZam1atNiKRZq0g+/tX3iZo1cyyWPYkqs2x37lP485XTQYHbdp64YPiMRFMteg
	otdPSUilNbVlDH0cUntKZ0POLZF4FdFlnPVI7Zup3UXj526PJzATUb4Etc0SaaR43kcPU=
X-Google-Smtp-Source: AGHT+IGiRum5OAeqK7KwLoeA3fYC8uB4/qk0h6ByodkxfauKgGSblQTUCpTabkdDEAjM1i6E2aZiIQ==
X-Received: by 2002:a05:620a:440b:b0:8a2:595f:657 with SMTP id af79cd13be357-8c356f10068mr814244585a.21.1767571350945;
        Sun, 04 Jan 2026 16:02:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm3545746985a.13.2026.01.04.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:02:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcY3J-0000000156c-2OeL;
	Sun, 04 Jan 2026 20:02:29 -0400
Date: Sun, 4 Jan 2026 20:02:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dawei Li <dawei.li@linux.dev>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105000229.GC125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <20260102184113.GA125261@ziepe.ca>
 <20260104133532.GA173992@wendao-VirtualBox>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104133532.GA173992@wendao-VirtualBox>

> >  /* DMA for "CMDQ MSI" which targets q->base_dma allocated by arm_smmu_init_one_queue() */
> > 
> > > @@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> > >  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > >  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> > >  
> > > +	if (smmu_coherent(smmu)) {
> > > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> > > +	} else {
> > > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> > > +	}
> > 
> > This one is "CD fetch" allocated by arm_smmu_alloc_cd_ptr()
> > 
> > etc
> > 
> > And note that the above will need this hunk too:
> > 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -432,6 +432,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
> >             !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> >                 return 0;
> >  
> > +       /*
> > +        * When running non-coherent we can't suppot S2FWB since it will also
> > +        * force a coherent CD fetch, aside from the question of what
> > +        * S2FWB/CANWBS even does with non-coherent SMMUs.
> > +        */
> > +       if (!smmu_coherent(smmu))
> > +               return 0;
> 
> I was wondering why S2FWB can affect CD fetching before reading 13.8.

Yeah, that table is super useful

> +               if (!fwb) {
> +                       val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> +                               FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> +                               FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> +               } else {
> +                       dev_warn(&smmu->dev, "Inconsitency between COHACC & S2FWB\n");
> +                       /* FIX ME */
> +                       return;

I prefer we block it as I showed instead of printing a warning, cache
inconsistencies in virtualization can become security problems.

Though it is probably good to add a comment here about s2fwb also

Jason
