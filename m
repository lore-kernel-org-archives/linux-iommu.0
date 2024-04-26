Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9D143C4D
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129057; cv=none; b=saNDEsbYUP0XAcG8aQ7G8LfBLKj5nE9XGEnilBAiEMJQqFglFbBEJ7DyRPimMA9p7q8IGD2emgrSabY21UYC+Qsl/IEeRJVAkP6X66C0iSeoLNfvwwuhhYLrrDUslEA5SuIazS3aU1JQdCdw0rWAPjO2gFwtZ0XHicLsgTFEw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129057; c=relaxed/simple;
	bh=O2ek7f04QphKDy19NBdVwaX6ovXwR9ovVL7LXVtxGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIYBhDG+Epq5WWqPfjVLrYm6wQqaR2xfxdaMXYfBcFoHF+HfnorK0qpCnkPrZcJpYmUdA4GFTeHSWzJi7srllqZ7VRXLVg10dlITRhEwpi3Tt7FQgpR/g3WjJ8Hg/2o1N8CSoAWHlnoLpW/Ac5C/65Xm6O/JA1rCfxSpDs+meho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=k9kkdIC1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="k9kkdIC1"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6B4891C7F00;
	Fri, 26 Apr 2024 12:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714129054;
	bh=O2ek7f04QphKDy19NBdVwaX6ovXwR9ovVL7LXVtxGWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9kkdIC1gkQT2xbR+zaou//OGg1Ht/KjME2XrobsYOXU0DeZstJ+uTPwSyHsE1Twz
	 Q1Kn6jE4hVxGSioIWQ92Qn51ML5286o9/kclndIscOPv8ud9g9sJaAgNLCS7NsjKbY
	 Y/GXZ6eHk6n+OglxVMdKye7qMYXngZYqyVecFnfuZmAq8N7x4s/Fgn9XVGqHAc2pvB
	 l29upYmPBTvardlAfaXie1k01wuYUpi09QZPmZfEIUB/GR/zKQaqOqZoNYEcq9DyHG
	 FS4KKaIq8R7TpUq6VA6E5uyX6eAPERsMFU5QHhZP47BjZNIdTICjvEHhwfEAF3Uk5A
	 s1LWp8gqlp+DQ==
Date: Fri, 26 Apr 2024 12:57:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v8 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Message-ID: <ZiuIneLj690wcrIU@8bytes.org>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>

On Thu, Apr 18, 2024 at 10:33:45AM +0000, Vasant Hegde wrote:
> Jason Gunthorpe (1):
>   iommu: Add ops->domain_alloc_sva()
> 
> Suravee Suthikulpanit (3):
>   iommu/amd: Move PPR-related functions into ppr.c
>   iommu/amd: Define per-IOMMU iopf_queue
>   iommu/amd: Add support for page response
> 
> Vasant Hegde (9):
>   iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
>   iommu/amd: Introduce per device DTE update function
>   iommu/amd: Fix PPR interrupt processing logic
>   iommu/amd: Introduce iommu_dev_data.max_pasids
>   iommu/amd: Setup GCR3 table in advance if domain is SVA capable
>   iommu/amd: Enable PCI features based on attached domain capability
>   iommu/amd: Add support for enable/disable IOPF
>   iommu/amd: Initial SVA support for AMD IOMMU
>   iommu/amd: Add SVA domain support
> 
> Wei Huang (2):
>   iommu/amd: Add support for enabling/disabling IOMMU features
>   iommu/amd: Add IO page fault notifier handler

Applied, thanks.
