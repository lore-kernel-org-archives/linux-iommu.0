Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABE18AE1
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 16:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664BC433C8;
	Wed,  9 Aug 2023 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691598475;
	bh=1TIrPLAB+pltO94ANnOelKVEZYEOgEmbVBQg99MGMTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2tDQLF1FDZ4OyY9IXNg55EhM3W98VPZN4lZHwJKU1YbPrQ9+n9NqKPPUHWh3u4uN
	 Bj+dXJNWUmBIXiajTWliV2sbU5OmtNgmAXgFlxkHUwQD7k8ip1X4OUE4+0GJQMkPuf
	 VRNOI68v+sK6awn82j7NdSkWqS6WTqVIxSFvRGqsdPyW1RuRliNmqaKOo8Kn4acdAz
	 6UX9v9E9ApOmbM3AZNlDi0mRozExk72d3TIsYgRE40/K7ZOIaXtq+BZv/xiuZIj7SO
	 gGsSqNPaLo7WO7VVULDmDWfZGsw5wciLmS1jXYcoYhQmCIoYN8HPej3RW+IsFki4pE
	 BEFIUE1PvIPsw==
Date: Wed, 9 Aug 2023 17:27:49 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230809162749.GA4663@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
 <ZNO+QVkXcHG78KG3@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO+QVkXcHG78KG3@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 01:26:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 05:22:54PM +0100, Will Deacon wrote:
> 
> > > > If we want to use 4k leaf tables in some cases, how would you add
> > > > that? Such a change shouldn't need the low-level strtab creation
> > > > code to change.
> > > 
> > > You would modify arm_smmu_ctx_desc_cfg to teach it about the different
> > > format. It would gain some (enum?) member that specifies the CD table
> > > layout and geometry. arm_smmu_get_cd_ste() will interpret that member
> > > and generate the correct STE for the specifc cd table.
> > 
> > Sounds a lot like the existing s1fmt field. Can we keep it?
> 
> If you are OK with the dead code, I don't object. But let's put it in
> the struct arm_smmu_ctx_desc_cfg.

Ok, we have a deal!

Will
