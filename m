Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBC4A21
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379278; cv=none; b=geSg6Wu4QQrFusrfj8ZgM1eIZa4ob1UrFRSDUr0dsQx2uhHHG2p16UVB4HgFBzmu+ZKP75lq4hhMkDYPskb9ajOkHzSIr2OPNQtw2nR7wKWW86grH8scbOlO23OPKZ4Zxr1TWiyWv+I+XHVdQFAAm5rF99DYq/way5fvsw20Yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379278; c=relaxed/simple;
	bh=bXmVqZi5/XxGwHoRNC2qo8trHPL/JUWYt6dxPjrbbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvzi89+aVdg104llDMjsl52RhGGSJ+3f1Y/N1DIKW/zebZxkwuaL2T/xy3xRKqvtyavs6Mz4Ek3Ye3kpAIxB9RXUGo/hNtRoQTbWkXHAp2GuwXB5NwwyFxiwwDcRYRNHAYGjXxswXJqKkmT1TG6iIiWcGeoIfmtJ/+fBBKjeg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=inm+Urue; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="inm+Urue"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8be92e393f8so18055185a.1
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767379276; x=1767984076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbKNq3OzvNgOXwfOYEfmEuaPS05vXN54NlE6TZcUdp4=;
        b=inm+UrueNIvp340/VDhkTVrtjxkkd3mjdlOa/kBkiQ7cY6R32lUq2w+j8pnr3qfkiE
         7QaKbIv9ygjvYpNQX/jL7lZ5CejP+r/UcJBGYfY1mM+wHeDE5dgSoMCbBJw/u4A+xcA0
         4VfIYhdEmz/0GIcMx753KVzYgmdQqKWUoRAUkU2yI5D9cRx7qn65ghjzpw0avumCrMbI
         1ifS2LEYCoCYMDuZrDC7qPl61yXdWdG/f5IrjKIuTAMOevORaM4YJtE1q4U4GxGfbSg5
         yZCLjxIl4Zxk5u445rE1nHqOQZ4gXPELKthEVazDKEcJO1opiZe4/YO6Qzqad05T5VlL
         s/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379276; x=1767984076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbKNq3OzvNgOXwfOYEfmEuaPS05vXN54NlE6TZcUdp4=;
        b=n2a27wtpUbfua45JaBhRDL/xyhIKTOvPEuoLzo8ILBstDRFmlocDqJwmkShUBUKRtB
         Evnf8uQZSGqM1L2rseipUaPv9vMj9ST7hcoc+MTgXE8x3XU/gm1ISTtHO0hBXMDab1wV
         8kfPVcpUV0ZtQh4ToJXjm1msR3BK95+nsuDBLUJrvCcMfRNkxPK4vnj9MkUrIyWp+lNe
         hdDnNIsirc33KwY2xLEX4Vah6GNbyG8EL6h10jHY8usQCwSv8mDppq3iOj2BG9JvE4qZ
         n1ZuheyKzPBS1w6qtPQIPNJKHKKgWyBS0PpvhO7YhSgMwrfvlqy2iI2DAEQ6+mtflYlM
         yywQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1XZOLdcnl3xcME57hMtiJuR1ZIZm10ujaMlwABQBj7xXz5J0CFDJ/5Iiifm1Y3Aq1F0ZYhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrNsMU8/8nIvgve1o+mlJxNQ6WSTk5udJJHV8eXEQi5OWBUwCn
	LZnU9C+CZ4q7YBIwIG4+XXQuuRr+goP3IXloAvYYjlpoDxwTmWqbQOhzewtv3piGerI=
X-Gm-Gg: AY/fxX7V6CpEL+TTfYV4pn+5YtR56PIjrJAB53tlkh2XUkTFor1UzbE4Gy7r5QuQOkW
	sTfeF1V8LZCYKV8SyJSLmcN/W6GzjO3JQZM6VBIlaIzHeX3XJrUwvhhGXljQYBezyK9uA9AiEMK
	1r8bE481Mj6BQ4F8i/sp/Dp7mnS6kRF3T9hVmfVCNEEVnW9Q2WOvJXYdd3FPJFI5ybTFdp9qki8
	lUEtWNBM1bkzr0KMjp7CMVR42pPhz2ciNIzH+6AiMadVa+ayy5Yq3fCpcQnAxZ5SB6qpjOcDs34
	W6Cv1Sb5cmF/W7lq0ZpTg01+HIiPO24RStEHXSncK+h8BgG0Gakql5lWk6TEyq/Dg9FckG8mF+5
	PfvdSzSsHtmsDF7B38kt2Iuikk3kvinGDzjMv1Me4Orz9/Bmp7dKarGa1u1E0wJ/Gr1FZl6095P
	Bi27Xqt04IW0611eE4e6XZZaLjdb0W1aFXgsXmd2HMByNpK6lupCMFgS3I8Wsrrvc6ZYk=
X-Google-Smtp-Source: AGHT+IFf1uKGIwRHqgDuPoJHVm8is9Z+z+ElqpNBRFLqGHyGLWLw+ECPqzKaTxkx0tZNT3guYluMgA==
X-Received: by 2002:a05:620a:7111:b0:8a3:90cb:9224 with SMTP id af79cd13be357-8c3568a0131mr102879985a.2.1767379274814;
        Fri, 02 Jan 2026 10:41:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678afa6sm3293504685a.2.2026.01.02.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:41:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vbk5J-00000000neJ-2b6O;
	Fri, 02 Jan 2026 14:41:13 -0400
Date: Fri, 2 Jan 2026 14:41:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dawei Li <dawei.li@linux.dev>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260102184113.GA125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229002354.162872-1-dawei.li@linux.dev>

On Mon, Dec 29, 2025 at 08:23:54AM +0800, Dawei Li wrote:
> According to SMMUv3 architecture specification, IO-coherent access for
> SMMU is supported for:
> - Translation table walks.
> - Fetches of L1STD, STE, L1CD and CD.
> - Command queue, Event queue and PRI queue access.
> - GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported

I was recently looking at this too..  IMHO this is not really a clean
description of what this patch is doing.

I would write this description as:

When the SMMU does a DMA for itself it can set various memory access
attributes which control how the interconnect should execute the
DMA. Linux uses these to differentiate DMA that must snoop the cache
and DMA that must bypass it because Linux has allocated non-coherent
on the CPU.

In Table "13.8 Attributes for SMMU-originated accesses" each of the
different types of DMA is categorized and the specific bits
controlling the memory attribute for the fetch are identified.

Make this consisent globally. If Linux has cache flushed the buffer,
or allocated a DMA incoherenet buffer, then it should set the
non-caching memory attribute so the DMA matches.

This is important for some of the allocations where Linux is currently
allocating DMA coherent memory, meaning nothing has made the CPU cache
coherent and doing any coherent access to that memory may result in
cache inconsistencies.

This may solve problems in systems where the SMMU driver thinks the
SMMU is non-coherent, but in fact, the SMMU and the interconnect
selectively supports coherence and setting the wrong memory attributes
will cause non-working cached access.

[and then if you have a specific SOC that shows an issue please
describe the HW]

> +static __always_inline bool smmu_coherent(struct arm_smmu_device *smmu)
> +{
> +	return !!(smmu->features & ARM_SMMU_FEAT_COHERENCY);
> +}
> +
>  /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent,
> +				   struct arm_smmu_device *smmu)
>  {
>  	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>  	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> @@ -358,8 +364,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		} else {
>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>  		}
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> +		if (smmu_coherent(smmu)) {
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> +		} else {
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_OSH);
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OINC);
> +		}

And then please go through your patch and add comments actually
explaining what the DMA is and what memory is being reached by it -
since it is not always very clear from the ARM mnemonics

For instance, this is:
 /* DMA for "CMDQ MSI" which targets q->base_dma allocated by arm_smmu_init_one_queue() */

> @@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
>  
> +	if (smmu_coherent(smmu)) {
> +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> +	} else {
> +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> +	}

This one is "CD fetch" allocated by arm_smmu_alloc_cd_ptr()

etc

And note that the above will need this hunk too:

+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -432,6 +432,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
            !(smmu->features & ARM_SMMU_FEAT_S2FWB))
                return 0;
 
+       /*
+        * When running non-coherent we can't suppot S2FWB since it will also
+        * force a coherent CD fetch, aside from the question of what
+        * S2FWB/CANWBS even does with non-coherent SMMUs.
+        */
+       if (!smmu_coherent(smmu))
+               return 0;

> @@ -3746,7 +3765,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  	q->cons_reg	= page + cons_off;
>  	q->ent_dwords	= dwords;
>  
> -	q->q_base  = Q_BASE_RWA;
> +	q->q_base  = smmu_coherent(smmu) ? Q_BASE_RWA : 0;

CMDQ fetch, though do we even need to manage RWA? Isn't it ignored if
IC/OC/SH are set to their non-cachable values?

etc..

Jason
