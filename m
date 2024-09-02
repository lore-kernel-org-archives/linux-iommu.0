Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C6185B4C
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293736; cv=none; b=WR++gJ0Xg5ACqqwfSu5LOZr2EhPGcjYxKede8zTAyf20mufHyoTPi9gqVjqcFnA4dYA/3z+wuA49nKsth6G4PUMf31XluNo/xE7dJ3ZnYtpKDMEeiYDQYmoSlDp3HmG4ehZphkKf3nMPWwptjF9kMiOmO21/cj8AIPcJq63Wkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293736; c=relaxed/simple;
	bh=rhcvJ204D0k0g+Nk80ZMVOEWO2mrj+Y7PHB7oPKRJyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqRl0VW5MRs0hRUJyF8xRdH1CBXyWhYhs8T4mPQLadY0Y9SAmsmEJjfghEmtO2QWYXUuYAMsg2TB7GBRUZflry6K04x3oHylLEx35QEA/LIGHB/XPvx4wyNwfv1gOEnb1xcJiO3PnBiedt/oXUPvHXUa/hseq+7d6eGI9vPYWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=x21eeWzk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="x21eeWzk"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D57E52850CC;
	Mon,  2 Sep 2024 18:15:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725293727;
	bh=rhcvJ204D0k0g+Nk80ZMVOEWO2mrj+Y7PHB7oPKRJyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x21eeWzkK9hBgCDDbS5vBOCENUOkdrI9CTBTJBwXXfv3eZYqZyBLm53kCQnAPUfWp
	 URXvxjcnrh0d5H2yXCQ7yOFs3ZLTtdU+LSFxtITVc5/bQVHY5iuQeCB0r6kUHv4v0g
	 gySFeXIY5g3VHVTwXiF9LcsHqt86Qpxt1dGmU4avvKOAogFnGqGY+flK8Kco0AwfxY
	 vqdFf4pQKPsxWcyr1xPYnWHy6B6NHUv0bq2xtuGveSRvZvQTAeykRpv3rYAFLGydLk
	 MEzxHY0NOb0fa1IV3EqODZlsri7N/B5OCkj6iH2RSWctLUjcczRpanFgUt17jAayFj
	 b0x3pIXj4yVYg==
Date: Mon, 2 Sep 2024 18:15:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] [PULL REQUEST] Intel IOMMU updates for v6.12
Message-ID: <ZtXknq0jChzgq2iV@8bytes.org>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>

On Mon, Sep 02, 2024 at 10:27:10AM +0800, Lu Baolu wrote:
> Lu Baolu (10):
>   iommu/vt-d: Require DMA domain if hardware not support passthrough
>   iommu/vt-d: Remove identity mappings from si_domain
>   iommu/vt-d: Always reserve a domain ID for identity setup
>   iommu/vt-d: Remove has_iotlb_device flag
>   iommu/vt-d: Factor out helpers from domain_context_mapping_one()
>   iommu/vt-d: Add support for static identity domain
>   iommu/vt-d: Cleanup si_domain
>   iommu/vt-d: Move PCI PASID enablement to probe path
>   iommu/vt-d: Unconditionally flush device TLB for pasid table updates
>   iommu/vt-d: Add qi_batch for dmar_domain
> 
> Sanjay K Kumar (1):
>   iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count
> 
> Tina Zhang (3):
>   iommu/vt-d: Factor out invalidation descriptor composition
>   iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
>   iommu/vt-d: Introduce batched cache invalidation

Applied, thanks Baolu.
