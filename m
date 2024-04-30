Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DA152799
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489683; cv=none; b=JREVZtoEIgC3Aaa3aZabIblX8WLs/WT3X54o752Xx6CBw+okrf4uZM5Iu8XGv6kcTQa1WvXBPgVUpNIi1rVByltw3ZXdK7oEF95NZoPPON6RUh8/GYRo2yRi46NTQ1po4aXQWjKbcPn/znEgrU/zLd0eg6cuEVUPiZgh94oemG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489683; c=relaxed/simple;
	bh=MDkOJQg4KnjGvckY96pEHT93LoxZJwMpnB7px600+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7822UObFD80+kBzYgXLiLpS+DEP9nMqZ3OQv4kHZ25IfB3/5IV0CGxMpkQwm9TYFfiowKZeb92MPvNkBy/dB7vtAwSrjJ5HnV3uxQrJBGkT8YhEzSulehSS6GhZRBWq92eAIkXO9yq1XZ9Z7GOUyMcbdKiPCGRB077uUthbYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiU/2/Gf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiU/2/Gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FCDC4AF1B;
	Tue, 30 Apr 2024 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489682;
	bh=MDkOJQg4KnjGvckY96pEHT93LoxZJwMpnB7px600+h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiU/2/Gf4ky7NV8VDlIsNEbXVKPdzx8M6WwHKpTaTTpbv+Yjsmd87dSaw3ZvXrynQ
	 H50VEmQQiGoogHWgKZuquY5KARibi3PsXAALi6cbx/7//9y9IBAu6xj2IexASKYn5b
	 rRlpSZQvDTKZyzXKRcjuuUeLJlNJA0IM/EofKvzOnKsL/OAsW6fXZoAGEgM0neOLf9
	 cfFgvP0au/xOLSkZZ8Ya+qlqvdNxW2aR7zz690rT2QTmVqXLZInIxzy7HREBVcysAh
	 OMlj9/p/tM89u5NbSWenBsZhW47n3IkqFcrwE94pijzIIsfqInV5pQ9wh954Ns0UVA
	 HL/9j2lk2j8Qw==
Date: Tue, 30 Apr 2024 16:07:58 +0100
From: Will Deacon <will@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Subject: Re: [PATCH][v2] iommu/iova: Consider NUMA affinity when allocating
 per-CPU iova_magazine
Message-ID: <20240430150758.GC14187@willie-the-truck>
References: <20240426051619.10323-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426051619.10323-1-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 26, 2024 at 01:16:19PM +0800, Li RongQing wrote:
> per-CPU iova_magazine are dominantly accessed from their own local CPUs,
> so allocate them node-local for performance reason.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v1: not consider num node in  __iova_rcache_insert 
> 
>  drivers/iommu/iova.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Do you have any numbers showing that this is worthwhile?

Will
