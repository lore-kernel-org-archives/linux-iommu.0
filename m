Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9318027;
	Wed, 26 Mar 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032754; cv=none; b=Vp8RGosC/FOQYPiFeGtk4sc5k+ea6AiD38O767ORQZsPoE47o27KS57qdoHjjSIYv37exO7dKxHOGttFpLGghETa0eB9ogCtW07nRuBoWiwj2afhENCI5ahnP15ICtSn/J3loco9X/33mMi50PMwyVbHE3mrEEyI6nezGJQvVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032754; c=relaxed/simple;
	bh=xenkETHNq21MnE2o5q2f8tGsWGGsqyf3/hSbvPMf/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX70JN0X98v23nV2wQrhZdW9uO5zSiDpTIYkUNL7aoZfdPBMUFEpilDIE/BMZBlmCNEb1bsTxbXPs4qG7mlnrIFakveilk8sYWgTwBAVS9qulqQEWCM+/V6PFk4BkZHj/8B1thdyhp2MQKUE9hj3QJ5//Uotw7dFkXSpFCILFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opg24X0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opg24X0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F64C4CEE2;
	Wed, 26 Mar 2025 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743032752;
	bh=xenkETHNq21MnE2o5q2f8tGsWGGsqyf3/hSbvPMf/SM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=opg24X0/bGiv56vNxDDcZdo1UJoz5PWVnh4h5LFfFnudRKEaU2AX7XRMK1XIALnZQ
	 nFUuQYEz/RvxwSmJzPJ2+GhXrO/oSuF2eskQAVSqU4EnLpF+9IW5sRlPvz/jZnRRMY
	 12X0Wjrq9aKm1Tf55DnDMQ6+d60RU5SHNtTtxInLlFpzvg0wQMMBu9sGrUqk8qDE1M
	 ZsrtAz7zQH2Lwy6VPdLKmrOrI2UIcqydjFvZPKWjjk+OArTqE8MgzSAid9YFSO3ZNW
	 HSTpH1DrCiv4EtGw2ORbx6A5k5RenXvM9M6BCQWcaglci7tzAE6VwQMo8rlGJNDNzQ
	 mlj1TRxuGzpsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5BBFACE0C2A; Wed, 26 Mar 2025 16:45:52 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:45:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: Re: [BUG] vmlinux.o: warning: objtool: iommu_dma_sw_msi() falls
 through to next function alloc_io_pgtable_ops()
Message-ID: <88ef4efd-9736-4c37-9b05-212e65602322@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop>

On Wed, Mar 26, 2025 at 04:18:51PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Building next-20250326 using clang version 19.1.7 (CentOS 19.1.7-1.el9)
> gets me the following warning:

Apologies, but make that gcc version 11.5.0 20240719 (Red Hat 11.5.0-5) (GCC).
(Hey, it has almost always been clang in the past...)

Also, the runs that have this problem are the ones whose kernels are
built with CONFIG_DEBUG_LOCK_ALLOC=y, but that do *not* enable KASAN.
For rcutorture, these are scenarios SRCU-P, TREE02, TREE05, TASKS01,
TRACE02, RUDE01, SRCU-T, and TINY02.

							Thanx, Paul

> vmlinux.o: warning: objtool: iommu_dma_sw_msi() falls through to next function alloc_io_pgtable_ops()
> 
> This surprised me for a couple of reasons.  First, from what I
> can see, iommu_dma_sw_msi() does not fall through.  Second, it
> is in drivers/iommu/dma-iommu.c while alloc_io_pgtable_ops() is in
> drivers/iommu/io-pgtable.c, though maybe the compiler and/or linker saw
> fit to rearrange these functions' object code.
> 
> Please let me know of any debug patches or fixes that I could apply,
> or any additional information that you might need.
> 
> 						Thanx, Paul
> 
> Note to self: Run 2025.03.26-14.37.10-remote on first test system.  ;-)
> 
> ------------------------------------------------------------------------
> 
> int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> 		     phys_addr_t msi_addr)
> {
> 	struct device *dev = msi_desc_to_dev(desc);
> 	const struct iommu_dma_msi_page *msi_page;
> 
> 	if (!has_msi_cookie(domain)) {
> 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
> 		return 0;
> 	}
> 
> 	iommu_group_mutex_assert(dev);
> 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> 	if (!msi_page)
> 		return -ENOMEM;
> 
> 	msi_desc_set_iommu_msi_iova(desc, msi_page->iova,
> 				    ilog2(cookie_msi_granule(domain)));
> 	return 0;
> }
