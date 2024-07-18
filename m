Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB439FE4
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274555; cv=none; b=VZZWog7XzjyzVdHp1GFnsFc2onmZ3f1Bvsdd+hoHmHjToMqACwJasv47pxxozf4HSPQntI5Z9MqGoWRQ8kB1BXHEcFICnYIrWM7F3IfTUQMOev4t0s5KvOgoQRQY4ZPOWk2Sz3yVEhp1Dmi+dFgc6XT25dPFyGoGt0KTZEf6Kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274555; c=relaxed/simple;
	bh=ckbfWJjz+54NYPngTBO5HEX2BPlYpiYBXK60K41e/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQIQ3f1rXG2bJuVy7hhUyKHvq+FRo1k49kINwDXCPU4ophTiECqLd0R4YHMjqWrUrRS+B67u0dqpizWjJG0x6FGb3h7IR7Hxa61QvQj+ZRf4VxlWEQdcfdbSqy7N7K+fsynznqukpdF5A18iLTF1qZV7pJGdkFfgXUAUwtUnhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EAC368AA6; Thu, 18 Jul 2024 05:49:10 +0200 (CEST)
Date: Thu, 18 Jul 2024 05:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] dma: call unconditionally to unmap_page and
 unmap_sg callbacks
Message-ID: <20240718034910.GB31912@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 03:37:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Almost all users of ->map_page()/map_sg() callbacks implement
> ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> is dummy DMA ops interface, and the use of this interface is to fail
> the operation and in such case, there won't be any call to
> ->unmap_page()/unmap_sg().
> 
> This patch removes the existence checks of ->unmap_page()/unmap_sg()
> and calls to it directly to create symmetrical interface to
> ->map_page()/map_sg().

I don't think you even need this any more, do you?

