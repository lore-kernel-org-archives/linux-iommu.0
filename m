Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4D16D9B5;
	Thu, 11 Jul 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723511; cv=none; b=fzDQzu44h9N+/IILvN0fDKRw9QKzeEym1F9bqdWm89dxxlDdXjUWGE5N6VsFgTNoPQOAFYAx3cmhPMpBFguVy8N/KlcJJxuQR5vN9oEYW/yJ0YihXgnn1MdT3M9VhQ47BAitmJDkYeMtSeldG+jctrQizIKdGXoIpoAu544ekno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723511; c=relaxed/simple;
	bh=07F7lD/Mj8pIf/zpE9QN028Rx6IcfYkiuAnvEMEZjj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWqIdQC96R3lJoSDLOW5B7WdORuNdenNHPE04SBYzgk5rQVuXPqk+lS7Us36Y33EozUt/BU8K9kpkCguK9kP52RT7No/8hSGjNbqTDY+DPsxpAYZcK418ZCaV7+zRnIORmmZHddsZX18lZthucumkpTLvX0Evaw7+HGEILGHRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juuSL9YL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juuSL9YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201FDC116B1;
	Thu, 11 Jul 2024 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720723510;
	bh=07F7lD/Mj8pIf/zpE9QN028Rx6IcfYkiuAnvEMEZjj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juuSL9YLyiuwygfhdkTPLqF2n4dnAVsogosXi0ZyqDsPerH8U+8qC6v+vktywumWu
	 CavhPtyp4MoHKDrsQWgsku6EhYd9K9OhhcZp0Hbyw9tD6yVHyzXF3j2J7oi1pouWOA
	 Wjv95v9VP65bl+r3pCi4QdHx8aYN4cHYs8b9VbNghcZqTcpd57Y50Zju+zpRxmqujZ
	 G+D8cebfiRICxEkK6anxHl51Hgiu+HgbnPKPXNEoDToTpbymd9VcfF4r90IofmFlq9
	 g81dicsxpgcoPQcIps+h4sXxewOd+UvBN5/E96YqbwsBRqnsTTRvqhZckCfElb7yZN
	 TqbAVfPcbtrNg==
Date: Thu, 11 Jul 2024 21:45:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240711184505.GB1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <0e665ec4-2449-4140-b1ad-41ae01bf3592@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e665ec4-2449-4140-b1ad-41ae01bf3592@linux.microsoft.com>

On Thu, Jul 11, 2024 at 11:17:28AM -0700, Easwar Hariharan wrote:
> On 7/11/2024 3:38 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Most of the IOMMU drivers are using the same DMA operations, which are
> > default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> 
> s/iomem/iommu?

Thanks, will fix it.

> 
> > to properly set them as a default with direct call without need to
> > perform function pointer dereference.
> > 
> > During system initialization, the IOMMU driver can set its own DMA and
> > in such case, the default DMA operations will be overridden.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  MAINTAINERS               |  1 +
> >  drivers/iommu/dma-iommu.c | 24 +++++++-------
> >  include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
> >  kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
> >  kernel/dma/mapping.c      |  9 +++---
> >  5 files changed, 134 insertions(+), 17 deletions(-)
> >  create mode 100644 include/linux/iommu-dma.h
> >  create mode 100644 kernel/dma/iommu.h
> > 
> 
> <snip>
