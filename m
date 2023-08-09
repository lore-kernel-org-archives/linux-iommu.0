Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC317752
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1117C433C9;
	Wed,  9 Aug 2023 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592948;
	bh=RstcmDjitf3VE+sqHRb0jBKHbUC65fA41JgJoreOdZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMkhiJrDNXcnOWjqeCiE879G8K15cFnCSkPW83MJZ3fWKmd82APotaJrQXuS7/2Jm
	 5w17xvX8DmRulfCXAHIGs2k/1tyg+MPCZ6M2jCg2NL6NFiDiC9dVuHM2pnnKjkkzRL
	 bGL9/gsGEQtoS0au4gvLF0UNbJ4hQ0kXLcCpxJoTnIjbJG/DzsZq7IBXy6E2vDfWOv
	 MEhrE9LlUjthDXWXNpEQfwGroiN8UJPUgPGLyK2jJuhcnICswnklKRz+Zjbd1oCYR3
	 kVPkCvLf+BWe5adeW4hzqib36cVpmepCO93Q82hS+Di0wK0KGP/bSi/69o9kdIp73T
	 IlS3S0icFNiWQ==
Date: Wed, 9 Aug 2023 15:55:43 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230809145542.GB4472@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNObxeogswAYyDQ5@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 10:59:33AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 02:49:41PM +0100, Will Deacon wrote:
> 
> > > @@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > >  		    !master->stall_enabled)
> > >  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> > >  
> > > -		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> > > -			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> > > +		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > +		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > +		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
> > > +				  cd_table->max_cds_bits) |
> > > +		       FIELD_PREP(STRTAB_STE_0_S1FMT,
> > > +				  cd_table->l1_desc ?
> > > +					  STRTAB_STE_0_S1FMT_64K_L2 :
> > > +					  STRTAB_STE_0_S1FMT_LINEAR);
> > 
> > magically know that we're using 64k tables.
> > 
> > Why is this an improvement to the driver?
> 
> Put the above in a function 
> 
> arm_smmu_get_cd_ste(struct arm_smmu_ctx_desc_cfg *cdtab, void *ste)
> 
> And it makes more sense.

Sorry, but I'm not seeing it :/

> We don't need the driver to precompute the "s1_cfg" parameters and
> store them in a redundant struct along side the ctx_desc_cfg when we
> can compute those same values on the fly with no cost.

But the computation isn't happening -- the STRTAB_STE_0_S1FMT_64K_L2
constant is hardcoded here. If we want to use 4k leaf tables in some
cases, how would you add that? Such a change shouldn't need the low-level
strtab creation code to change.

Will
