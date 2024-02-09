Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666220311
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475486; cv=none; b=LizNf75rBxV2GfRPOY4FOEEE/CjG7+ATP9ZcHte3MNcV44HKXYiv5ENCkGYgA39pnG1V0N/15oflKukE04PFk/n+mu9jyvsDRLwwDl0V0DJdIUrnSvIlo6Svchu8mamtflt90ZQwnOjQ+ymtO0hpPvWWCBWssXIl66e8cQPdMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475486; c=relaxed/simple;
	bh=xGFWhnS5ZZiN+fO/B9cMwnVCKuEC/QQHMGWz17XN9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz5cjAzJBs0TBcz2+spPP7W9YiO1Eo9sX8aHp/T3Dnftzn+8BYqwD1qG5QwuI4Ny/W1krc1zi00fbVKF7JMQBzjbk6wBAzb3eboxgUFF6u484w/GwMpShXPMB4ptmvVXQ5jhvg7wAh/VeFU+YeC5IMEzYrNhlnFAGecr+fK9QXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mGvDSzOJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mGvDSzOJ"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 61BE81C176E;
	Fri,  9 Feb 2024 11:44:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707475482;
	bh=xGFWhnS5ZZiN+fO/B9cMwnVCKuEC/QQHMGWz17XN9EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGvDSzOJXNDuEsFN7QKCySQYbDiEUny6Y2gJE+k/xCfEzshMrskje/Dd92iOVu3uu
	 nlTBO4YgqKzhMNbDzgmv9kJezNZUZVv8iONmXPqI+Hp6EYaj2Q4t90d2UcgpBpNyKY
	 9SZA4PDLs+xkgNa2RFJDTFDljAy1UNJb4y+6lxw4I17a4YFW6a8HpPuYuSnLo7YkYm
	 mcCea8UFzWbTayr1eao19J3ddxccSK1Q9ANpCFJ/sIs6tlNY1Y9RjYuRtSCuqdDI0o
	 S4WdZpiqzsdrcOprVPIwSxUQWpNXG5OINoi0wOvPwZlzvR9mdgDVMdKtXvH5A8H3QH
	 xL/vrV0vcOrIQ==
Date: Fri, 9 Feb 2024 11:44:41 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v7 00/17] iommu/amd: SVA Support (part 3) - refactor
 support for GCR3 table
Message-ID: <ZcYCGdZQo82ZcMDD@8bytes.org>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>

On Mon, Feb 05, 2024 at 11:55:58AM +0000, Vasant Hegde wrote:
> Suravee Suthikulpanit (8):
>   iommu/amd: Introduce get_amd_iommu_from_dev()
>   iommu/amd: Introduce struct protection_domain.pd_mode
>   iommu/amd: Introduce per-device GCR3 table
>   iommu/amd: Refactor helper function for setting / clearing GCR3
>   iommu/amd: Refactor attaching / detaching device functions
>   iommu/amd: Refactor protection_domain helper functions
>   iommu/amd: Refactor GCR3 table helper functions
>   iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
> 
> Vasant Hegde (9):
>   iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
>   iommu/amd: Enable Guest Translation before registering devices
>   iommu/amd: Use protection_domain.flags to check page table mode
>   iommu/amd: Add support for device based TLB invalidation
>   iommu/amd: Rearrange GCR3 table setup code
>   iommu: Introduce iommu_group_mutex_assert()
>   iommu/amd: Remove unused flush pasid functions
>   iommu/amd: Rearrange device flush code
>   iommu/amd: Introduce per-device domain ID to fix potential TLB
>     aliasing issue
> 
>  drivers/iommu/amd/amd_iommu.h       |  29 +-
>  drivers/iommu/amd/amd_iommu_types.h |  26 +-
>  drivers/iommu/amd/init.c            |   6 +-
>  drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
>  drivers/iommu/amd/iommu.c           | 627 +++++++++++++---------------
>  drivers/iommu/iommu.c               |  19 +
>  include/linux/iommu.h               |  24 ++
>  7 files changed, 376 insertions(+), 376 deletions(-)

Applied, thanks.
