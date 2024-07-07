Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F52914
	for <iommu@lists.linux.dev>; Sun,  7 Jul 2024 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720334193; cv=none; b=escOjYQKgQwe33LJGc0NjgPzUJF9xYjS6fbA8m7i9jksbry/auJ2EnkgkBAt1fZUnMts46Vo97AqBxh4Sb/p4PPOyMiCrRsWGtcHPruCVV8OZbpbA12hskbcjKEWrRKOaK70d8nM7uLtQVkA3vd7WXzcCAv90Mac7eaJxpx8H6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720334193; c=relaxed/simple;
	bh=1gSig6dxedc1Iz3F+WJX59cOy51csAlYj68koxgY7d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixne4j8R5IgFvxrw2mSe2OqVw/y8kOnJt7f6DHE0cZSSlpH7JZ1bOvVxQ1cjq548zz7KuJLiRNN5Mv4Lext/JmS6jJFvRs9MACxBuU21tFswgXGCWfkTn/tfCL3oJYstHy9iGhMkPNL4/wUMRtKnC/Nh3Aor7W1gUWsVa+ya9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A847E68AFE; Sun,  7 Jul 2024 08:36:19 +0200 (CEST)
Date: Sun, 7 Jul 2024 08:36:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240707063619.GA387@lst.de>
References: <20240701165746.1358-1-mhklinux@outlook.com> <20240706055019.GA13280@lst.de> <SN6PR02MB4157141FBF8252BDEAD831C1D4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157141FBF8252BDEAD831C1D4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 07, 2024 at 02:11:48AM +0000, Michael Kelley wrote:
> This works pretty well. It certainly avoids the messiness of declaring
> a "pool" local variable and needing a separate assignment before the
> "if" statement, in each of the 9 call sites. The small downside is that
> it looks like a swiotlb function is called every time, even though
> there's usually an inline bailout. But that pattern occurs throughout
> the kernel, so not a big deal.
> 
> I initially coded this change as a separate patch that goes first. But
> the second patch ends up changing about 20 lines that are changed
> by the first patch. It's hard to cleanly tease them apart. So I've gone
> back to a single unified patch. But let me know if you think it's worth
> the extra churn to break them apart.

I think it's perfectly fine to keep one big patch.

> Yes, this works as long as the declarations for the __swiotlb_foo
> functions are *not* under CONFIG_SWIOTLB. But when compiling with
> !CONFIG_SWIOTLB on arm64 with gcc-8.5.0, two tangentially related
> compile errors occur. iommu_dma_map_page() references
> swiotlb_tlb_map_single(). The declaration for the latter is under
> CONFIG_SWIOTLB. A similar problem occurs with dma_direct_map_page()
> and swiotlb_map(). Do later versions of gcc not complain when the
> reference is in dead code? Or are these just bugs that occurred because
> !CONFIG_SWIOTLB is rare? If the latter, I can submit a separate patch to
> move the declarations out from under CONFIG_SWIOTLB.

A reference to dead code is fine as long as the condition is a compile
time one.  I think your next mail sugests you've sorted this out, but
if not let me know or just shared your current work in progress patch.

> > 	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
> 
> The "IS_ENABLED" doesn't work because the dma_uses_io_tlb
> field in struct dev is under CONFIG_SWIOTLB_DYNAMIC. I guess
> it could be moved out, but that's going further afield. So I'm back
> to using #ifdef.

Yes, we'd need the field definition.

> Petr Tesařík had commented [1] on my original RFC suggesting that
> __swiotlb_find_pool() be used here instead of open coding it. With
> the changes you suggest, __swiotlb_find_pool() is needed only in
> the CONFIG_SWIOTLB_DYNAMIC case, and I would be fine with just
> open coding the address of defpool here. Petr -- are you OK with
> removing __swiotlb_find_pool when !CONFIG_SWIOTLB_DYNAMIC,
> since this is the only place it would be used?

Yes.  That was indeed the intent behind the suggstion.
