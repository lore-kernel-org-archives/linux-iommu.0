Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76DEEBB;
	Fri, 18 Jul 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846437; cv=none; b=rcHTyq8mtkybdsMNpcGbLy1PSnH22b9SXNykDXyLBIS6RvPQC+5k9W+/mx8f4x+EtJGSgUWO6UatPgRlGpSzgsYc9K6JqdjFKj4Y6kkcCCGc+nEwAf5SoVTwQxJoEXZZw/8+Hpa5BxN0BYrRThsp8v2gKS+3Po7MzC3lv1AjIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846437; c=relaxed/simple;
	bh=K6o8NjASe6wViaJFuQvujWx90lgkkbUDOmivtCh4DGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bnr5js27lMD0hh0LNAO+HpwIHyHAkyU7jq6q5l8RZpFv6bVDHdc8ONneKWBtWX/g1nl3pd0eCEO3SLO+JzpQbZgmRIY7yUE8vHuGRneqI6oumOQbHEzA3HhuBPFBOlcLpNlP1RQYs75cGI1l/psM/3Bxn4uDlT/LmOnzKW3ifxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuMujI5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuMujI5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CF5C4CEEB;
	Fri, 18 Jul 2025 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752846437;
	bh=K6o8NjASe6wViaJFuQvujWx90lgkkbUDOmivtCh4DGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuMujI5MdT3wUu7nvneI1RfXlSTj33sW2FjkeunKBiTQoNqX2wy0ZMN8W+zpa0A04
	 cAfoBMuY+pbDGD6nlHuOpIzsldvyDYteuO5x88S21dq/mjFFDStHZtJg+8jeX5Lih2
	 VMkJheWun1cyftQ95JSuJOO+HTzatbMGo9p1I3bAQ0W7Z2edLGWY4V8vRf+7qnqgE+
	 BHilpQkZpY/5QFQucdIx3olXahXNWn2h8bq7LRMFt8au37GV8wddcuXxSzSB2ghxLb
	 Yvqig3q2DYn8Sr0r0EMCUD5Ff89YRE2SNLX4mTJMc0pu4RVMexqAUzcuslCZVH6cHS
	 3BPjFbPKFRAZQ==
Date: Fri, 18 Jul 2025 14:47:11 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, nicolas.dufresne@collabora.com, jgg@ziepe.ca,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <aHpQXy-bnwW56rCn@willie-the-truck>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>

On Fri, Jul 18, 2025 at 01:56:36PM +0100, Robin Murphy wrote:
> On 2025-07-18 12:45 pm, Will Deacon wrote:
> > On Mon, Jul 14, 2025 at 04:56:53PM +0200, Benjamin Gaignard wrote:
> > > Le 14/07/2025 à 14:08, Will Deacon a écrit :
> > > > On Thu, Jul 10, 2025 at 10:24:44AM +0200, Benjamin Gaignard wrote:
> > > > > +/* vsi iommu regs address */
> > > > > +#define VSI_MMU_CONFIG1_BASE			0x1ac
> > > > > +#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
> > > > > +#define VSI_MMU_AHB_CONTROL_BASE		0x388
> > > > > +#define VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE	0x38C
> > > > > +
> > > > > +/* MMU register offsets */
> > > > > +#define VSI_MMU_FLUSH_BASE		0x184
> > > > > +#define VSI_MMU_BIT_FLUSH		BIT(4)
> > > > > +
> > > > > +#define VSI_MMU_PAGE_FAULT_ADDR		0x380
> > > > > +#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
> > > > > +
> > > > > +#define VSI_MMU_BIT_ENABLE		BIT(0)
> > > > > +
> > > > > +#define VSI_MMU_OUT_OF_BOUND		BIT(28)
> > > > > +/* Irq mask */
> > > > > +#define VSI_MMU_IRQ_MASK		0x7
> > > > > +
> > > > > +#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0
> > > > > +#define VSI_DTE_PT_VALID		BIT(0)
> > > > > +
> > > > > +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
> > > > > +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
> > > > > +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
> > > > How does this page-table format relate to the one supported already by
> > > > rockchip-iommu.c? From a quick glance, I suspect this is a derivative
> > > > and so ideally we'd be able to have a common implementation of the
> > > > page-table code which can be used by both of the drivers.
> > > > 
> > > > Similarly:
> > > 
> > > No they comes from different IP providers, this one is from Verisilicon.
> > > I agree they looks very similar and my first attempt was to add it into
> > > rockchip-iommu code but when doing it I realize that registers addresses
> > > where all different so I had to code all the functions twice.
> > 
> > Understood, and I'm not suggesting to merge the drivers or try to
> > consolidate the register layouts. What I _am_ saying is that the
> > in-memory page-table format should be factored out in a way that can
> > be reused by the two drivers and also that some of the logic (as highlighted
> > by vsi_iommu_domain_free()) is practically identical between the drivers
> > and should also be shared.
> 
> All they really have in common is that they're 2-level formats with 32-bit
> PTEs and 10 bits per level (as is tegra-smmu too). The permission encodings
> have some overlap but are not fully equivalent. Crucially, the schemes for
> packing >32-bit PAs into PTEs are incompatibly different, so if you're
> really keen to genericise things to *that* extent, that's what Jason's
> already working on.
> 
> As for domain_free, you could argue that it also looks basically the same as
> exynos_iommu_domain_free(), because at the end of the day, there's only so
> many ways to free a 2-level pagetable, and it's at least better than what,
> say, sun50i, omap or tegra are doing (or rather, not doing...)

Just because the existing drivers are a mess doesn't mean we should
proliferate it!

Will
