Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD3198B8
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 16:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759E9C433C7;
	Fri, 18 Aug 2023 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692375084;
	bh=+gzO0gKiOTRvCJKQsYSXROLf2cSwuATfh8XfDlyDbx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePlCY5fFLfTm9fu9uOgrC8vID6pmWPF3IhzlNcRfiyIwCNyPfW1OJtn9UtAY6XmmJ
	 30VZEPFtEWomODVYC7C/7CylpIyZ0S6HMK31+bppdDlimHRcQbIEz1OB77jqDgXFKw
	 fJY+Tlos4YGqlH21Q3LXS39C+f5dOdk1a2DubODM697WU3Kc/k+lbJWhB1o5nvpgNN
	 rqsmt5NKhF3ZuiqmM+KCiokVMpqn50n5JURg2VTNZuwk1gb51khD19irICWbaogpGN
	 9Px3+jtCisHbYjCA4zDLGoMIAxwYsdu6kyf7l1N5r2z3DZ0fgFImHKoW3IuEDgTO6O
	 pUCuDTKgC3yDw==
Date: Fri, 18 Aug 2023 17:11:19 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	jean-philippe@linaro.org, apopple@nvidia.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add a user-configurable
 tlb_invalidate_threshold
Message-ID: <20230818161119.GA16216@willie-the-truck>
References: <20230816204350.29150-1-nicolinc@nvidia.com>
 <ZN5oojF6vKOKB/eI@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN5oojF6vKOKB/eI@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 17, 2023 at 11:36:18AM -0700, Nicolin Chen wrote:
> On Wed, Aug 16, 2023 at 01:43:50PM -0700, Nicolin Chen wrote:
>  
> > When receiving an __arm_smmu_tlb_inv_range() call with a large size, there
> > could be a long latency at this function call: one part is coming from a
> > large software overhead in the routine of building commands, and the other
> > part is coming from CMDQ hardware consuming the large number of commands.
> > This latency could be significantly large on an SMMU that does not support
> > range invalidation commands, i.e. no ARM_SMMU_FEAT_RANGE_INV.
> > 
> > One way to optimize this is to replace a large number of VA invalidation
> > commands with one single per-asid invalidation command, when the requested
> > size reaches a threshold. This threshold can be configurable depending on
> > the SMMU implementaion.
> 
> I'm rethinking about this size-based threshold, since what really
> affects the latency is the number of the invalidation commands in
> the request. So having an npages-based threshold might be optimal,
> though the idea and implementation would be similar.

On the CPU side, we just have:

#define MAX_TLBI_OPS    PTRS_PER_PTE

in asm/tlbflush.h

Can we start off with something similar for the SMMU? I'm not massively
keen on exposing this as a knob to userspace, because I don't think most
people will have a clue about how to tune it.

Will
