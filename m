Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D842078;
	Thu, 18 Jul 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284447; cv=none; b=M9tDXVyvUwjYvjOxfIcWa+RuEQgTnslVBxv4NiZR2FKiKCDGZ/SIdzdx1SmD+OLgul6hX8oFkVxaTd9oXNrB2eHKDz1HFl9s5NJ7dGGqJpWTjz52ixnO2DrASCpr2eitJk+rBVBqYRCzonsBiISF3b+p4LKZNlN2u8druHDA2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284447; c=relaxed/simple;
	bh=9o4w9VXRsSsY1Qh8N3TvvWYRi1ARV+J9O/L+ejZSuZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgLLBy1HxfhOTzs+z7PnS7wT0Rn7PNMQYUhbdcgAGBgls+zVM29A0rl+ecY3o38fgXxz77kTNJ2zuAiSa5om68DxPLVdxu6NOaj09k541X9hSjkZNNGEqf7UQD9LfWthRoeykY6ZwOYJSaskEUpALWdhX97m8DgaiXprhZ7uUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFjxKZDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFjxKZDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB0BC116B1;
	Thu, 18 Jul 2024 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721284447;
	bh=9o4w9VXRsSsY1Qh8N3TvvWYRi1ARV+J9O/L+ejZSuZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFjxKZDrRWTG5bA9ALEH5+WZqRBqjMIk8T1G3uZowQ75Li8t0fzfx269p4f60zTQp
	 g9XtQXBH36RCXBIv7/klCRRUPHeeLDQepNzIEwgNw0Ea5kIYsb1xisZ4ymhE5tP5DK
	 EjXV3v6DxCJ0Dngod6H2xUo/VOo2dkSY05374wO5JJmXIZlkah1In0HpAzB1KTYzbF
	 DE9KWVlLRNn9fnCKYN2maYzFXgPpkDJ5k6J73rpPjkwud8RXrijdLuP5SDCgkLu7I+
	 Zw9saaX+npvjh9toJumiC9b1g3X1RBnZ48ouhcLZ6PqjOJQ/VuCrINnfREzQ2CSczt
	 D97gZBDeL6EjA==
Date: Thu, 18 Jul 2024 09:33:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] dma: call unconditionally to unmap_page and
 unmap_sg callbacks
Message-ID: <20240718063359.GJ5630@unreal>
References: <cover.1721219730.git.leon@kernel.org>
 <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
 <20240718034910.GB31912@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718034910.GB31912@lst.de>

On Thu, Jul 18, 2024 at 05:49:10AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 03:37:10PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Almost all users of ->map_page()/map_sg() callbacks implement
> > ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> > is dummy DMA ops interface, and the use of this interface is to fail
> > the operation and in such case, there won't be any call to
> > ->unmap_page()/unmap_sg().
> > 
> > This patch removes the existence checks of ->unmap_page()/unmap_sg()
> > and calls to it directly to create symmetrical interface to
> > ->map_page()/map_sg().
> 
> I don't think you even need this any more, do you?

Strictly saying, I don't need it, but it is still worth to have this
patch. It removes unnecessary "if" check and makes sure that all callers
of map_XXX() will provide unmap_XXX() too.

Without this patch, the code will look like:

  313         else if (dma_is_default_iommu(dev))
  314                 iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
  315         else if (ops->unmap_sg)
  316                 ops->unmap_sg(dev, sg, nents, dir, attrs);

With this patch:

  313         else if (dma_is_default_iommu(dev))
  314                 iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
  315         else
  316                 ops->unmap_sg(dev, sg, nents, dir, attrs);

Thanks
