Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87D320E
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 15:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3DDC36AE5;
	Mon, 18 Jul 2022 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658157431;
	bh=7vYdhXeQdOu5QO7fBUho2H+EQnIcqXUqzgdSIhY4WMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfCvzksFJwZBgBuzW2Rf+hh7lzSOze0hr87nXoiLN2ybN3Tud+f9IAZyWinu/+q+4
	 54/G/vPbhIslkJvs5NBprcI2JK4ZuZhngkOyoGb60lz1xVSvFxppoQafFejAlyVrkC
	 7V2+GF+MTQqPpFSSpxEo0FSS31QhqZU0P4FaH+v1oe0/+axYqjKdVuWbusikDHTY21
	 OKpKDYcybJc5pOQu6y+7gL3zWWC7q1lLZsC+5mM6o4Ws9NmCaHZB0FwS/bUV5S4EC2
	 au6e+pEswAgMOIvr0ZvKqaBPBH/97Mx0kNtQUyAhqFk3uDqIyvGblLLieQC0diGvk3
	 d+7eJhh2A5HGg==
Date: Mon, 18 Jul 2022 16:17:06 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
Message-ID: <20220718151704.GB12935@willie-the-truck>
References: <20220715110334.6969-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715110334.6969-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 15, 2022 at 01:03:34PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Robin has been acting as a reviewer of the IOMMU Subsystem for a long
> time. He is also defacto maintaining the IOMMU DMA-API Layer, so make
> both roles official by adding Robin to the MAINTAINERS file.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  MAINTAINERS | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f9ed151ad4c..029f49f29982 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10448,9 +10448,20 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>  F:	fs/iomap/
>  F:	include/linux/iomap.h
>  
> -IOMMU DRIVERS
> +IOMMU DMA-API LAYER
> +M:	Robin Murphy <robin.murphy@arm.com>
> +L:	iommu@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +F:	drivers/iommu/dma-iommu.c
> +F:	drivers/iommu/iova.c
> +F:	include/linux/dma-iommu.h
> +F:	include/linux/iova.h
> +
> +IOMMU SUBSYSTEM
>  M:	Joerg Roedel <joro@8bytes.org>
>  M:	Will Deacon <will@kernel.org>
> +R:	Robin Murphy <robin.murphy@arm.com>

It's about time!

Acked-by: Will Deacon <will@kernel.org>

Will
