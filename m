Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3261E1A2
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 14:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4187EC433C8;
	Thu, 10 Aug 2023 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691678314;
	bh=wPlT1kTX+LJbVgI71KW4aFe+lchw8z+KNrjLkFIDmUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+GZx5jwV0YuOSBiNzPZ9Ylu3xHqnFx0Zj48w/baa8eZEFkKn3xnD9pUeqDPQQi1c
	 rkQLPKm015E8nUfBFnbwMGFjseLRBpEjJ7+DT1rVU2Xpcsn9CPnpiyJ92M1ZZKJSPc
	 +FsLzTy93/H25XnFhH7RoelRif42lEGXMyF3DXSgAjoy8r/wjdaSmO7EBhTDB80hw6
	 Qxr17zn0f5l9y3fz3vYRWRCxaT6YjvA7aU785/KKOw20to8FeNI+IZeiQCqEnJSnqC
	 oDunMAPUDX4xcD81E0wQp59pIK9q7wqIjSHnpcF2DylKO5SLhAWeEgy9kTqBlFcObp
	 x781MZAwcr6zA==
Date: Thu, 10 Aug 2023 15:38:29 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <20230810143829.GC5795@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
 <CAKHBV24ybm1gT+mQs1fDPZY_kGzop8+dQjccP+_qOFCmx69spQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24ybm1gT+mQs1fDPZY_kGzop8+dQjccP+_qOFCmx69spQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 10, 2023 at 05:23:37PM +0800, Michael Shavit wrote:
> >
> > > @@ -2465,6 +2450,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >       if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > >               master->ats_enabled = arm_smmu_ats_supported(master);
> > >
> > > +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > > +             if (!master->cd_table.cdtab) {
> > > +                     ret = arm_smmu_alloc_cd_tables(master);
> > > +                     if (ret) {
> > > +                             master->domain = NULL;
> > > +                             return ret;
> > > +                     }
> > > +             }
> > > +
> > > +             ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
> > > +             if (ret) {
> > > +                     master->domain = NULL;
> > > +                     return ret;
> >
> > Can you leak the cd tables here if you just allocated them?
> 
> The CD table is only de-allocated when the SMMU device is released, so
> this isn't "leaked" anymore than on a successful attachment. In a
> previous version of this patch, this CD table was even pre-allocated
> at probe time but is deferred to first attach following this
> discussion: https://lore.kernel.org/lkml/ZMOzs1%2FxoEPX2+vA@nvidia.com/

Thanks, that makes sense.

> > > @@ -2472,10 +2473,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > >
> > >       arm_smmu_enable_ats(master);
> > > -
> > > -out_unlock:
> > > -     mutex_unlock(&smmu_domain->init_mutex);
> > > -     return ret;
> > > +     return 0;
> > >  }
> > >
> > >  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
> > > @@ -2719,6 +2717,8 @@ static void arm_smmu_release_device(struct device *dev)
> > >       arm_smmu_detach_dev(master);
> > >       arm_smmu_disable_pasid(master);
> > >       arm_smmu_remove_master(master);
> > > +     if (master->cd_table.cdtab_dma)
> >
> > Why are you checking 'cdtab_dma' here instead of just 'cdtab'?
> 
> cd_table is statically allocated as part of the arm_smmu_master
> struct. I suppose it could be allocated by arm_smmu_alloc_cd_tables()
> instead?

I just mean you could check 'master->cd_table.cdtab' like you do in other
places. The DMA pointer is supposed to be opaque.

Will
