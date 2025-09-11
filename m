Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2674345735;
	Thu, 11 Sep 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602708; cv=none; b=Ac47e8QUtOJGCb5q/AR1plpdgGT8osWRJiDZ8IQ/L8tc9Fhbwnj3sdR3t9+Oen5N43DF4cyxon4beh+++2Eye4tdbBmcYVbJkyCxNdlTqAYaxcNCKnngKraaeVmPc0bnoeY11e5u2XKd9RoKyheKtqlzgZjD17D9iEeWv99/IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602708; c=relaxed/simple;
	bh=HeodYYa2ARM+3jXZTHDptckWgA9wcPV5Pp4/+zghwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvi+FjdsnuUui9uc27dlPjEpqA22WrZQLYsCWdteam/C+d39tJ0UlvPekaEe3vSpy1J9DBZFkoykWYvVnpdsMF95U89b/mHqc/UYe2J9Lo2A3CW6sMPEhF+b1V0iJ24PL8400QWhb2RPsRvgbf97TZJCMV2UnMdoOS8d1i1xMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4ppPzU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4ppPzU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0211C4CEF0;
	Thu, 11 Sep 2025 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602707;
	bh=HeodYYa2ARM+3jXZTHDptckWgA9wcPV5Pp4/+zghwa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4ppPzU/92e5jZEtYxQNnLuvVF4YdjiL4YbwnvjtjiIycgyZYLN5zlWHBq8nJVmqF
	 SOxopzS4DbaUTOTh0oiaJgH5oQa+1/6RNfyYdFs2eexO3SOTRBBZinG1/pxHmQXNp6
	 nwcQ8xqMeu2KACfIyIuaI18EDltZX6IOC9wPpnFJj1X88p8d4g9Zipamjb7jIDjQIl
	 WuyN8unPafOXY3SDoPZDNj0Yb8VEZ0RVar3YwXdirG3i2T2SAm8bA4c45KJMjN5N8M
	 toG6ci2Kl/h83ydrEq0j7Uifr3Kh+qCygXA8weT7KpgViBiNHB7lkHcuHUC/BIRgrj
	 3UgtRHcMT2SBQ==
Date: Thu, 11 Sep 2025 15:58:22 +0100
From: Will Deacon <will@kernel.org>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
Message-ID: <aMLjjl4nsBuQML3Y@willie-the-truck>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250814093005.2040511-2-xiaqinxin@huawei.com>
 <aMAmWQJy_G50xoBf@willie-the-truck>
 <534119b8-8221-4991-b308-05e8d5918aca@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534119b8-8221-4991-b308-05e8d5918aca@huawei.com>

On Wed, Sep 10, 2025 at 10:58:09AM +0800, Qinxin Xia wrote:
> 
> 
> On 2025/9/9 21:06:33, Will Deacon <will@kernel.org> wrote:
> > On Thu, Aug 14, 2025 at 05:30:04PM +0800, Qinxin Xia wrote:
> > > +/**
> > > + * iova_info_dump - dump iova alloced
> > > + * @s - file structure used to generate serialized output
> > > + * @iovad: - iova domain in question.
> > > + */
> > > +static int iommu_iova_info_dump(struct seq_file *s, struct iommu_domain *domain)
> > > +{
> > > +	struct iova_domain *iovad;
> > > +	unsigned long long pfn;
> > > +	unsigned long i_shift;
> > > +	struct rb_node *node;
> > > +	unsigned long flags;
> > > +	size_t prot_size;
> > > +
> > > +	iovad = iommu_domain_to_iovad(domain);
> > > +	if (!iovad)
> > > +		return -ENOMEM;
> > > +
> > > +	i_shift = iova_shift(iovad);
> > > +
> > > +	/* Take the lock so that no other thread is manipulating the rbtree */
> > > +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> > > +	assert_spin_locked(&iovad->iova_rbtree_lock);
> > > +
> > > +	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
> > > +		struct iova *iova = rb_entry(node, struct iova, node);
> > > +
> > > +		if (iova->pfn_hi <= iova->pfn_lo)
> > > +			continue;
> > > +
> > > +		for (pfn = iova->pfn_lo; pfn <= iova->pfn_hi; ) {
> > > +			prot_size = domain->ops->dump_iova_prot(s, domain, pfn << i_shift);
> > > +			pfn = ((pfn << i_shift) + prot_size) >> i_shift;
> > > +		}
> > > +	}
> > > +
> > > +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> > 
> > Why is the IOVA rbtree lock sufficient for serialising the page-table
> > accesses made by ->dump_iova_prot()? I don't see anything here that
> > prevents the walker walking into page-table pages that are e.g. being
> > freed or manipulated concurrently.
> > 
>  Thank you for catching this critical race condition.I will fix this in
>  next version. And,Jason suggests putting io_ptdump on top of iommu pt.
>  What do you think?

I guess it depends on whether or not you want to tie this debug feature
to drivers that support the new page-table stuff.

Will
