Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C43ACF1C
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487243; cv=none; b=rTF/V7LAGfdRiaekrGKYm0bgUbJv0M7pCkkKEu852Y+p9bBzID9jp1T3W2yVnL0H9yEhDR95qauX+hzSyv232b41Le2P39Z0MBi8qy8s+EdnqlrZtHQob1TlS15BsnVph9o3z3g9CfVU/DJUsUdt2pZNuYfDX9Cj32B7GyQdAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487243; c=relaxed/simple;
	bh=0DvqQBlt3gljLeEo6ZrxfhFW8GIa1uyFtPs9IsLL+pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N17bS+TZjHaUFmlaGRT3ulHsdZHBo5EUmrIJ9PvgcMq3fRohUacFsx7V9ZOoBMvfuQik8gZn0tuZmLJivCI46emzWJjAPtZWtM1hi6qj1DZ+ABgruXDex61NX8U9YKMIyaLAweCx02nNDREr9y+wXMKRNUCbGJFp9833cT2HSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=LMKh12Yg; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LMKh12Yg"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F107E1C44E0;
	Mon, 11 May 2026 10:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778487230;
	bh=0DvqQBlt3gljLeEo6ZrxfhFW8GIa1uyFtPs9IsLL+pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMKh12YgctwyGx7SsUYcCleOH/ChnHbBzKFUAZcpUAZBehlaJy0/6E3tuyKwtfbiG
	 WyQNM7YiYSfCSE6OyggGisYUKdb9vrs98L1fxyi40bIBFwQr8m3mT88nwZozvtc7wt
	 c9y2ZYOBT9MRR5XmVzuBPBTbSBjciEj5QWdzVoNXav4xgDTSpckrBfzRi0e7D5DsvX
	 huTLZg6rXATP5HMhv2Z/vO6MD0Hpssww+krOpAZ+14VO31AythjEpRQ+Tqe6QFZbCQ
	 Pma2NWa6JRHJxBrVV1xJQpUzCytaXoxyH4xXn+NNdV5usjpW5m0/hOKSVcsZy5uS0h
	 cHO5YzxXy205w==
Date: Mon, 11 May 2026 10:13:48 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, jgg@nvidia.com, will@kernel.org, 
	robin.murphy@arm.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v8 0/8] iommu: Fix pci_dev_reset_iommu_prepare/done()
Message-ID: <v5ho7btw6blweqgo335blyyaf6gr4vh37yjtwqynawu44ufkj5@zwilvdbxm6gu>
References: <cover.1777074513.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>

On Fri, Apr 24, 2026 at 06:15:19PM -0700, Nicolin Chen wrote:
> Nicolin Chen (8):
>   iommu: Fix NULL group->domain dereference in
>     pci_dev_reset_iommu_done()
>   iommu: Fix kdocs of pci_dev_reset_iommu_done()
>   iommu: Replace per-group resetting_domain with per-gdev blocked flag
>   iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
>   iommu: Fix nested pci_dev_reset_iommu_prepare/done()
>   iommu: Fix ATS invalidation timeouts during
>     __iommu_remove_group_pasid()
>   iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
>   iommu: Warn on premature unblock during DMA aliased sibling reset
> 
>  drivers/iommu/iommu.c | 223 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 181 insertions(+), 42 deletions(-)

Applied for -rc, thanks.
