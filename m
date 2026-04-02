Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D738737C
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114805; cv=none; b=std+q768OApU+CfsCexns/fkFkzOnx6zWF+lcDRhbxfaPgzgr6A6h8YhG4977zygYXoYxvgs5Ev+e6bDQ4xxhoPyXhMK1QovoxUrUaRN6Cjg6QaDKRLSzCezbI5oID/zUKNKTkcu0deflOwFWgi7VzslQNnmBfXTXbNXOd8fyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114805; c=relaxed/simple;
	bh=tPV46pidHWX9a1Zps+5F3EXGgm28Nq/bzHw3cGvK55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9VU5maGtSRImqdSG10xBPM5D8xUo1/kQEFVwRSLP5pF5RzPV5lbn5vWp8MS5YtnPO7Or/YsGiSOr8dKC8z4OO7NWIDvF6qa+rTw2oiCe8vEW1xA2HUgRJl5s2h+nfOYKSSvtaHwa1yrUVfgFn9wGJJf3JqMNHk6VeNdU628uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=0sEwb9rI; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="0sEwb9rI"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0E6611A70EB;
	Thu,  2 Apr 2026 09:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775114797;
	bh=tPV46pidHWX9a1Zps+5F3EXGgm28Nq/bzHw3cGvK55A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0sEwb9rICRYVjIVr0tyMYQRtnag2t/z7k+lgFLJ5JLL4O1GrENXrrZUGKSW0aFuzp
	 uQggkPnRRDQVUgI/7k1ir5aISq/L/FZ7dQg4eJFMA8n72+3j3Y0nUeBMY+zTOmPHeC
	 WWG5f22gJETQOSqlwXFHt0wf1LkgLzUbXF9ypKGNmaYUqH8W05CN+S6zoWK86lB0kq
	 sCZRqtX0iO+J4HAmayVJdniM5oeUOVp2RvBTstiqrKQDFawPTS7TSZVkdVZwj2JVKJ
	 Jniy5H/VTAHt0m9RTRrtrYSiYQMiY7WmX7XCq6rZ23rU9OuB3g5P+CNZk0D92UjAxh
	 KMhvEpsMr3Axg==
Date: Thu, 2 Apr 2026 09:26:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] [PULL REQUEST] Intel IOMMU updates for v7.1
Message-ID: <gzg3w5ztxhp5tsdtcyleswxkrgdopjcnlfkuhmbw6e5ec6tjbl@nizit5duxkti>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>

On Thu, Apr 02, 2026 at 02:57:23PM +0800, Lu Baolu wrote:
> Bjorn Helgaas (2):
>   iommu/vt-d: Remove dmar_readl() and dmar_readq()
>   iommu/vt-d: Remove dmar_writel() and dmar_writeq()
> 
> Jason Gunthorpe (4):
>   iommu/vt-d: Split piotlb invalidation into range and all
>   iommu/vt-d: Pass size_order to qi_desc_piotlb() not npages
>   iommu/vt-d: Remove the remaining pages along the invalidation path
>   iommu/vt-d: Simplify calculate_psi_aligned_address()
> 
> Zhenzhong Duan (4):
>   iommu/vt-d: Block PASID attachment to nested domain with dirty
>     tracking
>   iommu/vt-d: Rename device_set_dirty_tracking() and pass dmar_domain
>     pointer
>   iommu/vt-d: Support dirty tracking on PASID
>   iommufd/selftest: Test dirty tracking on PASID

Applied, thanks Baolu.
