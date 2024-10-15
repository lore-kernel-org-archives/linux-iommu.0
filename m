Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A418A6B7
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981538; cv=none; b=u0/exrGKp7sFL7YlgSE1pSgyDK7CgSvfIPTLOwYYCuGr6kqxz97utTu4RJb9wZOjuKNuVnU81KJLIG8GYmwaahCfYeeOUd1thuJPI/WMRwLSnRajMJUxm+JqYXTpvn330UAjR3U3ngJ5GGCAiyWxSemxvC5QNtb4gCR47GKYcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981538; c=relaxed/simple;
	bh=0FbnWK8i7zh/Uzcrh9SXp7p6PHAOtyguRZjxi5hwyqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brFapKSKMxopHYhCc3zr4tWc+PW21SaCQ1VgTJObEiRAJZFwlLy/nFz9jZhwTBID5CeIMAEfJWWyUx1TKq3wpYa2sSf/E44mTQY6odtIYkk1I8n5U7A96gxiH4S2UMbsjiwNBI9wchQjksU1ttR0aToIVZQvjOgsNkODm21WKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4ZfsAFl6; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4ZfsAFl6"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 50FF62A6C15;
	Tue, 15 Oct 2024 10:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981536;
	bh=0FbnWK8i7zh/Uzcrh9SXp7p6PHAOtyguRZjxi5hwyqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4ZfsAFl6383aQCCFOfzGUTezbb0jcBVCVReb1DmC/i6D2eVq6o4+4LLlvNBiu+W8Z
	 W8MN3B8dmRHRfV/DfzdIBk3lbHcSPzXnBgoIEDn6sVmosuXm51+cT/ByxIaEce5j0j
	 7PvlpVrEMVW2K/KrEab+Vpn6R6C++zGdwvgBfEBjYZKca8wDrfzA4ZRMzgdw+Db0Zw
	 rYF+ytvSI9NdZ+SnI9F6gdXKuyYHSaY//scxWwPxxPEmLnmzmcHjiywmZumA95Z/s6
	 ROJal8TD1980+3gtjCly0N13ds3lEux5qQkeLoXHFZSLOkDGs9emTAw9CvM5w/PEVm
	 rOWmmqJNg9QHw==
Date: Tue, 15 Oct 2024 10:38:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 01/10] iommu/amd: Use ida interface to manage
 protection domain ID
Message-ID: <Zw4qHwmZ0vRuyHNI@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-2-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:03AM +0000, Vasant Hegde wrote:
> Replace custom domain ID allocator with IDA interface.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 +
>  drivers/iommu/amd/amd_iommu_types.h |  3 --
>  drivers/iommu/amd/init.c            | 29 +++++----------
>  drivers/iommu/amd/iommu.c           | 58 ++++++++++++++---------------
>  4 files changed, 40 insertions(+), 52 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
