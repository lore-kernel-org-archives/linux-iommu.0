Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B89204035
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193296; cv=none; b=PBz7Ww2lqsteCidMPwnWm/4FJXl9eu+VE7xOOYHVk0BwkHePCqHiCXD/pGrsbpzvsU21lXsm40eCuro9F6FvAgIsRlptfVSkFD8tfBpIwLrVP3+IFby+rrw4lOEQbZSUKnyC0gER0fq3CTLJElj0aKWeEWYJT87UPLS9Pty1VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193296; c=relaxed/simple;
	bh=LAMBoAunfE7+z+hMRKHBYSfAwQezpaHs6AnLT5VYtHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prS2q61laXioWIL1ImEkAD2JdXbtHYs0SP1O6QqnnlwTNSC9v4lADCnjaU35g8PVAHrAX+4Aws8K4RhwCbsgtIPaZ9Z8bd7NclAsnq/OwqRole/AKeZzSjDU1eMS9wh5QRhQJjWXhV7UlGLIyCOqSHoegQuZMWRhCdtX3YCBKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=eKRIL3YF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eKRIL3YF"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D37E52A8D55;
	Tue, 29 Oct 2024 10:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730193292;
	bh=LAMBoAunfE7+z+hMRKHBYSfAwQezpaHs6AnLT5VYtHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKRIL3YFUO9WUORwKO1ccH/gZOqS0gwLfw0cj2MSRQkT7eWYgXfDfh4+aCD++XTzH
	 TSuoPnKZ0lXLVH5anXAI6bo4epRNseQDlWdUzWGq2nGMHNfN2+4nAcU0XWajwgwlgN
	 P3E6qbNhh0k3EIT7rN7aKZM+mEtpHMPatT8PDVqbMOxB5mR+uNQtxokNAoXRBC5a1v
	 6W2XvPqXVvW50IDcGa/iV/fMlTD3YefVfivqwVCTFS4Mrf240rR+qUq/ShaN/pqRGZ
	 ggcK5Ciqt99NXgj6Bmt+yQLmmp2YOYhUjBX132IrArNB3j8arx9fPRxRcn4/fENbl2
	 Eyn4bKfSJ166Q==
Date: Tue, 29 Oct 2024 10:14:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 00/12] iommu/amd: Improve domain allocator and device
 attach code path
Message-ID: <ZyCni2HHjXqivNwl@8bytes.org>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:36AM +0000, Vasant Hegde wrote:
> Vasant Hegde (12):
>   iommu/amd/pgtbl_v2: Take protection domain lock before invalidating
>     TLB
>   iommu/amd: Use ida interface to manage protection domain ID
>   iommu/amd: Remove protection_domain.dev_cnt variable
>   iommu/amd: xarray to track protection_domain->iommu list
>   iommu/amd: Remove unused amd_iommus variable
>   iommu/amd: Do not detach devices in domain free path
>   iommu/amd: Reduce domain lock scope in attach device path
>   iommu/amd: Rearrange attach device code
>   iommu/amd: Convert dev_data lock from spinlock to mutex
>   iommu/amd: Reorder attach device code
>   iommu/amd: Add opa->release_domain
>   iommu/amd: Improve amd_iommu_release_device()
> 
>  drivers/iommu/amd/amd_iommu_types.h |  23 +-
>  drivers/iommu/amd/init.c            |  37 +--
>  drivers/iommu/amd/io_pgtable_v2.c   |   3 +
>  drivers/iommu/amd/iommu.c           | 359 +++++++++++++---------------
>  4 files changed, 193 insertions(+), 229 deletions(-)

Applied, thanks.
