Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4D1E2313
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283849; cv=none; b=Y6Zib7RLpJGI00nd5oYuU+8vt5qGsan9vdMkgc5aeQujyAHZYJ4emqthd61Sbw8YYefWDlgg5T/aAHbfCJydEefSfEIKIC2sJxp5kyJOAPVbrGHilCBPInj9059xr3kHrmLyBEoDgcZIQy/QrOPOgjNByM8KTUuvMYiokvcLt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283849; c=relaxed/simple;
	bh=LlF+sOJg66O+VtZNap9ROamreGp1SwzJISQDJwL4QG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4URlioELa9y2aZ9NdVzacuIAzjiKtITVwXjdM5Q6yWxa/jDoZwV6dy+CSGBfoLQHtvn83c0ZfRsp7YS2UXQW72Mkr6F20bTFq6WhAaGN+gycumeGceeuCAnAqhageNOXk09yDSO+tt7QfGUp/pYgsL4f918IIdZIq6nJPgmtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lGMUh2Dk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lGMUh2Dk"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7DD392A8F74;
	Wed, 30 Oct 2024 11:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730283845;
	bh=LlF+sOJg66O+VtZNap9ROamreGp1SwzJISQDJwL4QG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGMUh2DkZDe6phpbDO7hFopiO2rKxmjfRwq4IVZSZ0KPpecnAsVtSUFtYcSKIW7nW
	 DwMGBuijRiCJ+2hMWDY9f+SCMfzKEKWtO/bZ8LcnVaBNB9sdUsN7pIIOqKqAG1b502
	 AwNlDnfKe4LsVRyJMclNWGzWqcf/VptvgzPP0GxlqM/ApZalqHKQv+ap4DLXpLKNI8
	 wYQKysOl1Pi1zSVA8qMKQaTxxZPgPaUnD0xd26+Z7wDGkEsLJ8ai3L+0kqzkTcZEHU
	 c5KPvKVl2enbT2fr+TA6jgO7Q5dcxkIKCsR/V18TP/K3rAB2VFEZNIYZF0EDYy2qwL
	 vLzSjArIb2oVA==
Date: Wed, 30 Oct 2024 11:24:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 00/12] iommu/amd: Improve domain allocator and device
 attach code path
Message-ID: <ZyIJRHZW7-oIp_fp@8bytes.org>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>

On Wed, Oct 30, 2024 at 06:35:44AM +0000, Vasant Hegde wrote:
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
>   iommu/amd: Add ops->release_domain
>   iommu/amd: Improve amd_iommu_release_device()
> 
>  drivers/iommu/amd/amd_iommu_types.h |  23 +-
>  drivers/iommu/amd/init.c            |  37 +--
>  drivers/iommu/amd/io_pgtable_v2.c   |   3 +
>  drivers/iommu/amd/iommu.c           | 360 +++++++++++++---------------
>  4 files changed, 194 insertions(+), 229 deletions(-)

Applied, thanks.
