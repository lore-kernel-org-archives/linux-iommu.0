Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AFE2038D6
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192992; cv=none; b=CYf0EAH/exj8m1CJG2JNassxAqyiDOG75jUz6hvVjQKN/IwV5RI8HdIRyW8cZPcGGo5Z0skZW81zTBDVuxmc6/Pb8UDURRAQCjBdfaAfN6pcTx2tfpXFrd3v7rz7tX8sWO37J/l+iJ46uWMfHj6gD4Y8uxuJBwlAiwZYvgwmjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192992; c=relaxed/simple;
	bh=LH3okWY1yE5X//VpsdixoG+HT//HAj0I3NcSboo/sks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOUlc+ngGIRP9EIyFmN7emaVGFWVNiA/XwCr9byedhjlQDqOUK8tyHN0fbYPiaoqrvdCPn2tMG6SQ2C+JL4wbMqF85pmmSDiLChjNvK3O65pHBWc1yPFXSWi5WQFW2vFWpaqqV1kh4xtPyK9v9zcmP4lPY6wZ0gjdrWzD2Lx5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=nwCOWScD; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nwCOWScD"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DCB482A8D55;
	Tue, 29 Oct 2024 10:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730192989;
	bh=LH3okWY1yE5X//VpsdixoG+HT//HAj0I3NcSboo/sks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwCOWScDhCOWvQtDXC6+1yeFyi6UB2mYcOVx3cjHfcnP5lPVoyVffbcqsosXvM7Mn
	 PyGDC+yUyAxsuuch41si+lOm/QfifgsvfjR0fGsA7Jlwi5i64RGcsmIg/f4T2730QX
	 0liDia3iJPGyCT3Rn70iKanuCgkuIAh9xbXzEpGp6zZLFbKDl3TGU66eV9r30sOMmi
	 hOttTS3ui7NF+NVgJfdWexBk/a5VqxYzAUYaptloUirlnFBJ0lCSglN0QRrmVaPCPI
	 aoKFRvhLZRhl5cop2lhZRwSdiA4Q2xG5DUJgj//B3gnhFzxJY6w83UawIY3ujYrAko
	 6o2515gcWo+lw==
Date: Tue, 29 Oct 2024 10:09:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 00/12] iommu: Domain allocation enhancements
Message-ID: <ZyCmW7ngH0mYBj3W@8bytes.org>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 09:37:58AM +0000, Vasant Hegde wrote:
> Jason Gunthorpe (5):
>   iommu: Refactor __iommu_domain_alloc()
>   iommu: Introduce iommu_paging_domain_alloc_flags()
>   iommu: Add new flag to explictly request PASID capable domain
>   iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
>   iommu: Create __iommu_alloc_identity_domain()
> 
> Vasant Hegde (7):
>   iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID
>     capable domain
>   iommu/amd: Add helper function to check GIOSUP/GTSUP
>   iommu/amd: Move V2 page table support check to early_amd_iommu_init()
>   iommu/amd: Separate page table setup from domain allocation
>   iommu/amd: Pass page table type as param to pdom_setup_pgtable()
>   iommu/amd: Enhance amd_iommu_domain_alloc_user()
>   iommu/amd: Implement global identity domain
> 
>  drivers/iommu/amd/amd_iommu.h               |   8 +-
>  drivers/iommu/amd/init.c                    |  18 +-
>  drivers/iommu/amd/iommu.c                   | 141 ++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
>  drivers/iommu/iommu.c                       | 186 ++++++++++++++------
>  include/linux/iommu.h                       |  14 +-
>  include/uapi/linux/iommufd.h                |   8 +
>  7 files changed, 270 insertions(+), 111 deletions(-)

Applied, thanks.
