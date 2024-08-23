Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6913C918
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404697; cv=none; b=Ukz3/+Mk727LmcLS30z2gLgH/PCmZ4fYeomW4AZMBuSELPshUuDXD30nDhjW5KdhfoY3xOXjZ8pOrkgI7/TFECXidRGdmBJeqa/1UqnMUyEqwV4gUVHMRrNDb115dnK7J95q+uP263xNjHP/Eei7OVKzmklRM1k09/c17KKZtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404697; c=relaxed/simple;
	bh=/lPWVL30lzbw2Z/KCenJf+gD3M11QjZxo9FsS4BrDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6QVW4MUoZ4z/X29MrFTT2RfhOLHhL7cx8in/CAQH9NhS/lWhfZxJY7H7ogKqthiNEHZjOrTcgSrgmmI1BvQQ4ZcXAL3XMip+ke7w+A5V4sTO5fhfjnY4qfN+nI8dWQi9c+tmrUzRyMSHpcrK3qNS+Y6UfypwRNVrdllVu6eDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=zi0p0Yg4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zi0p0Yg4"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D80AA2A7BA5;
	Fri, 23 Aug 2024 11:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724404694;
	bh=/lPWVL30lzbw2Z/KCenJf+gD3M11QjZxo9FsS4BrDZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zi0p0Yg46Jc5JyxW6ZtXW0XrW9sV+zqiJjzdD3wPHd2pPUKAWSf2tgAphLvYvX8On
	 k0IToqDinkFx8FRhrgB+sPoekPbJdSPnq477y6tTXrnxPD/jYj73YMzk4mheka5bD5
	 4YvaWAfQMA30JTj5qYRl41SbekWlYNzJ/w8AekOfzlNC4UwlK2mM1Cx1SDEGZo8kDC
	 /n0DMkQqDp+/PfWSr/PHnG3H9pudGfvNa4VtCfv5Yeu8A62AmZFTbLLuHCt6DB1hqQ
	 Fn7LPR2BJZay+BqHa8Pu4aSrlVrZtMzN/n1JkCutMZO8wvXmOETZBRgRt25orwVCvx
	 i8zkQYGVrRcwA==
Date: Fri, 23 Aug 2024 11:18:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V2] iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP
 feature related macros
Message-ID: <ZshT1dXiXZR3qkGT@8bytes.org>
References: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>

On Fri, Aug 16, 2024 at 10:16:50PM +0000, Suravee Suthikulpanit wrote:
> Clean up and reorder them according to the bit index. There is no
> functional change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 -----
>  drivers/iommu/amd/amd_iommu_types.h | 16 ++++++----------
>  drivers/iommu/amd/init.c            |  8 +++-----
>  3 files changed, 9 insertions(+), 20 deletions(-)

Applied, thanks.
> 
