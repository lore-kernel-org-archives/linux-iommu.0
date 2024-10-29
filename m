Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C51DED5A;
	Tue, 29 Oct 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201177; cv=none; b=BLMq4Q+mD1qWL42kLsUEWjRvaxbM3zTpiUbEtYI144O9z/cchIoX2RjxTYJO4+cmGDm0puriN1CX1Ji4V2s26SSuLeTchkGnyOxryfc6oXGbNyyqCmyxR7vy/uQL+dU/YiPdSONh5r/JRvsuARV59rbpZXeGAGAo2KCqatdj+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201177; c=relaxed/simple;
	bh=IvSOkBRME/ivvjqb0yFuBaygFKibzaAYTxZDxD7x1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWLcAEn7aVHy/RYYMVNGbtafN6Axcxr5gS8StrWHuoaNtLGXR5b3wWFqj3bFd555d5mrYqlbwel7J5uGsbFNtIcfL940lUVRadr42ChDEY4axYacWG2SmajDdxoJkGFjfWEb29Zr2Em4GEW/PeRP6WwXuVyspcgt4tjLHgijbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY8kHlHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY8kHlHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82214C4CEE3;
	Tue, 29 Oct 2024 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730201176;
	bh=IvSOkBRME/ivvjqb0yFuBaygFKibzaAYTxZDxD7x1w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cY8kHlHczj3IBiOEhPli0utebFeKi4Ai0P0eWWJWroQaqdSLix7gaRWY7LE5O39Q5
	 yvSX+KAcYLnjWDb5BH6DghjGb3okJNBy7DuYeH0lFr2ZBwdZJfb5ARorvplKDHB5WG
	 p5t7K/UvFiRRCymnXOPqWagVh4msDOpAgfK51IhEybDK+POwu2oFDFE7ZYGlFCuRkf
	 7IMDaWwXZs089HrbWsW8xGzMYA/e2Q+XhhcDKCrOrNbyagNcGNW5l5utW0XPMtwVlh
	 H/W03WVQVZWve7n3953TvbrC6G2sWRIsf5BHhb+eKQFqFg8vuD8hKVqv70ymHriY/p
	 cXkDREgxt7vpA==
Date: Tue, 29 Oct 2024 11:26:12 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <20241029112611.GA3881@willie-the-truck>
References: <20241029112302.63639-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029112302.63639-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 29, 2024 at 12:23:02PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This patch restores the iommu_flush_iotlb_all() function.
> Commit
> 
> 	69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> 
> claims it removed the last call-site, except it did not. There is still
> at least one caller in
> 
> 	drivers/gpu/drm/msm/msm_iommu.c
> 
> so keep the function around until all call-sites are updated.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/iommu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
