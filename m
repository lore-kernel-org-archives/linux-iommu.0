Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383382D97A5;
	Fri, 18 Jul 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839110; cv=none; b=AE93Uh7716B99SV0ioHvbkAUFTmHnwVyHhSwVNDRZKeJEd6CZX1yBmrKl67JvcikEP7jfIiZw+twQbVUVN9nc4VB34fx/wRjMq6ktWUmYO1ijmLQyiood2lW1dDQdNcaBfotiuvn/03JbVhTkzykOtH3xaPnGf7yj3fX4vtSfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839110; c=relaxed/simple;
	bh=HbxsrY6f+PgZxKEKxckwhH+ILsDOG7Ptpr1hT4rRhik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOtyKuO2MT4jj7kmg5a4JolqpxiKV1KBd5Q7FBUhM+BqixuiLGu1EJwpVIj7gxVTpDKatoiBVU9u7YLyEo1mi2aAGf4epHkyaa8VdcV/XuJvC1j1VWXuKoy1V1xBAgaTiEQXvgg/NommAhUKeacxvLeNPnHe40W6vegcEdE9Res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7c14dnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7c14dnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE5C4CEEB;
	Fri, 18 Jul 2025 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752839109;
	bh=HbxsrY6f+PgZxKEKxckwhH+ILsDOG7Ptpr1hT4rRhik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7c14dnPqFzEHprwuqRuqBH4A31YK/vjPD7bg/OgG//kFji0cP6j8P7cMAKbndDRF
	 rKsWOgE2CfDrLtQzTg9Tqqos4qKLP4KHp+l2i6KDmrO8WOEDsr24ZXCsleC0qc1HET
	 knrWhdx+ShuOrfaAN8nP0tV+cc11BduoFFOf1gd/nFT4eR1Rs/cR3Jru23P5g6gzZX
	 lc+rDf4K7Z86NG2LZ5LjBIs1Pv4IzC9cOC5SIL8PswY0FDgm3nOMYK+iKOjuIRvH7R
	 V0dC2kC+lfW2D2JfJthyTEEuwFcYXw8oyqAqWrViF0bK9rjv86EgfM6yQLYTUjTLLG
	 82pD9rTZr27Eg==
Date: Fri, 18 Jul 2025 12:45:03 +0100
From: Will Deacon <will@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <aHozv0NG1OBlAH6c@willie-the-truck>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>

On Mon, Jul 14, 2025 at 04:56:53PM +0200, Benjamin Gaignard wrote:
> Le 14/07/2025 à 14:08, Will Deacon a écrit :
> > On Thu, Jul 10, 2025 at 10:24:44AM +0200, Benjamin Gaignard wrote:
> > > +/* vsi iommu regs address */
> > > +#define VSI_MMU_CONFIG1_BASE			0x1ac
> > > +#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
> > > +#define VSI_MMU_AHB_CONTROL_BASE		0x388
> > > +#define VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE	0x38C
> > > +
> > > +/* MMU register offsets */
> > > +#define VSI_MMU_FLUSH_BASE		0x184
> > > +#define VSI_MMU_BIT_FLUSH		BIT(4)
> > > +
> > > +#define VSI_MMU_PAGE_FAULT_ADDR		0x380
> > > +#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
> > > +
> > > +#define VSI_MMU_BIT_ENABLE		BIT(0)
> > > +
> > > +#define VSI_MMU_OUT_OF_BOUND		BIT(28)
> > > +/* Irq mask */
> > > +#define VSI_MMU_IRQ_MASK		0x7
> > > +
> > > +#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0
> > > +#define VSI_DTE_PT_VALID		BIT(0)
> > > +
> > > +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
> > > +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
> > > +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
> > How does this page-table format relate to the one supported already by
> > rockchip-iommu.c? From a quick glance, I suspect this is a derivative
> > and so ideally we'd be able to have a common implementation of the
> > page-table code which can be used by both of the drivers.
> > 
> > Similarly:
> 
> No they comes from different IP providers, this one is from Verisilicon.
> I agree they looks very similar and my first attempt was to add it into
> rockchip-iommu code but when doing it I realize that registers addresses
> where all different so I had to code all the functions twice.

Understood, and I'm not suggesting to merge the drivers or try to
consolidate the register layouts. What I _am_ saying is that the
in-memory page-table format should be factored out in a way that can
be reused by the two drivers and also that some of the logic (as highlighted
by vsi_iommu_domain_free()) is practically identical between the drivers
and should also be shared.

Will
