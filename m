Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A13ACA5A
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752731; cv=none; b=GOPuLh0SAgZwEneDtLtpCDm5VUBZf1aY4N/s+786CnODhniL1ywZxoW74qrrno+M7Elzh0CIz3AL016epZVQtotiIzW/hBCDjkhhBfs5dNJ7pmxTNM7/2mADghiNGIBHRRgWTNqPiEE/ggUot4LqMLiNmAs6PZ9is+8aQon3wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752731; c=relaxed/simple;
	bh=SuAsvNUVzv6MV7XixanbdPCNnTVmejlBtvJbrcLykz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEj8Vp0dbHw2mNkqI9/3o29flPC/jQGbTgIbAS8Dgg8lxW1zOniTkyvQcoC1s5DHPC3B8wM9ZKnB5C4W7mmg7z4NGp3uCqQ6p4jDai09eGmS3N05j9DgGgkzSw1ok17Ykzs1BzOHxhTr1Ygz3jB56ePI+p0V/Yi0QAr/AXbs3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=C3KYrzpz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="C3KYrzpz"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 396381A5941;
	Tue, 17 Mar 2026 14:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773752728;
	bh=SuAsvNUVzv6MV7XixanbdPCNnTVmejlBtvJbrcLykz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3KYrzpzWiLrlJJcK3AA/u7s+mcmrJqUct+/1KqEM6lmE1iGrkRJKB+b8F5FV/SSY
	 QYqn/AIbko1Eny9x9haJTRGJ0PvoKv0Avv90TTNhfrIa6sLUJi9Fdgq3nS9rR12aEU
	 DJFEmPfUQAfEbkCR2IAbn10uCeicfCT8d4nFGOi02NALvwEyqy2QhW6aPPaLKVTtIt
	 BtU29SwNRwpV37R+MHJkw8Brs+zsgc5CGiDEmBk2Z0yDJzWhNQfoi1w+dL34eKRTs5
	 E9KI1+CN9Oxl5+h/QqVPVC9XPNCkSSxdl0fnID6Z5ES6UjO3IwmIDJ+8aR4ZIb7Chm
	 KMrkTgi9F72hQ==
Date: Tue, 17 Mar 2026 14:05:27 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, will@kernel.org, 
	robin.murphy@arm.com, baolu.lu@linux.intel.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	skhawaja@google.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, 
	kjaju@nvidia.com
Subject: Re: [PATCH v2 0/2] iommu: Report effective PCIe ATS support status
Message-ID: <mddloeyz3icr2fy7haibik3hhx4dzdvparffrtrcblwxxpw5rh@ped2vxgsnydr>
References: <20260317111603.101456-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317111603.101456-1-skolothumtho@nvidia.com>

On Tue, Mar 17, 2026 at 11:16:01AM +0000, Shameer Kolothum wrote:
> Shameer Kolothum (2):
>   iommu: Add device ATS supported capability
>   iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO
> 
>  include/linux/iommu.h                       | 2 ++
>  include/uapi/linux/iommufd.h                | 4 ++++
>  drivers/iommu/amd/iommu.c                   | 6 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>  drivers/iommu/intel/iommu.c                 | 2 ++
>  drivers/iommu/iommufd/device.c              | 4 ++++
>  6 files changed, 21 insertions(+)

Applied, thanks.
