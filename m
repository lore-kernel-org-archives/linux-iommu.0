Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31217E908;
	Wed, 17 Jul 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210016; cv=none; b=olQdgiuemRb1fqdDkvYaYJ8Lli/y7sKGol00bgfbgyUCn/GUg0xzbGkseM8RYZLK1tKPXuXeOYzixmCE1vnGFA/VTSjhxuXPF+vJGMNvO5+PKyG/aHeEYoq7f+bNahs0zalix1EWVNj72pvyyo09/iNW11hHTMKNdiy/hreZx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210016; c=relaxed/simple;
	bh=N5KTE/RBiUwGRlJgeXiZSHiX9FdHVUBgtTpGL78tPcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsoJroyPbklhaITzXfGE1iiG21DXneT6hXndQ2QaAs3QQjtNlnNhxXhyoNkF3dEsaO2dtysabHGC2G9/nDv4IxpeHbVZd0Egwp5qAZ9Nl9LZugqcD09QpwXlZUX5LzzxFna4FvVG7PB2gORRd3kOMEmgmsD2bdRmKATKtfQEg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uen35YsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uen35YsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19237C32782;
	Wed, 17 Jul 2024 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210015;
	bh=N5KTE/RBiUwGRlJgeXiZSHiX9FdHVUBgtTpGL78tPcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uen35YsQIUNtqnlSRyao9ajeFQ9ahKFjyxKoo+bhHE5G+BV6gnn6/M5U7VeMN9oJQ
	 l+H5gC2chPsxGOTiMWURSFyb6M1P3LNC2ga9r1kdw1Ek44fchA0kOrtmqpeBXvRxFx
	 m7FYcYaffeDvpKdIZzfNMidVqtqicewHIuPwgjaCqPFobM30cO9J89BdZdksz4dcOU
	 T4sR+XTy4bFxAZUEG3na6c9GAwjds9S6/zh78yrl5aLYPqXvHN41S9pXw7cODdhvoF
	 6KkaSK/CqvkplM/BL2K1tWROSV0FlWBDTK8tt9LeqNr4y5/K5JxZiMhT6wh89TTqWZ
	 ovvhmZaWudAGg==
Date: Wed, 17 Jul 2024 12:53:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240717095330.GH5630@unreal>
References: <cover.1721041611.git.leon@kernel.org>
 <7758cbe20bfd34506d943bb93097565b9c4dced4.1721041611.git.leon@kernel.org>
 <20240717082145.GA15484@lst.de>
 <20240717084713.GG5630@unreal>
 <20240717085652.GA18554@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717085652.GA18554@lst.de>

On Wed, Jul 17, 2024 at 10:56:52AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 11:47:13AM +0300, Leon Romanovsky wrote:
> > It will cause to the situation where "struct device" memory footprint
> > will increase, while we still need to keep dma_ops for archs that don't
> > want to use default IOMMU.
> 
> It won't.  Even with the new bit we still have 28 more spare bits next
> to it :)
> 
> > Because dma_ops pointer exists anyway and has already specific flags. I
> > decided to take evolutive approach and add a new flag to it, instead of
> > revolutionary approach and add a new field to struct device.
> 
> The point is that with a little more work we can actually kill that
> for common configuration.  For non-Xen setups that basically just means
> removing the dummy ops, so it's a pretty big quick win.

No problem, I'll do it.

Thanks
