Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD428A1C7
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618062; cv=none; b=PhtQ0xshd0L1JhY+Njqs+37Gv0EvyCBt/lrPv7RphvEa29x1SMIc4UdPQrHtlqN6G8PyFwWGwKSyYdw67lyAxQIVcFm0gF8omb1q3/l7aIdJQuYkxO1g0ZH/Y+s9e3d1GyEDIl+eKiauv9LR7/Sy7+UGgdei+DIbimamZSq/6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618062; c=relaxed/simple;
	bh=EJn/cSZXH7BBYxWEIF85KO4s0OrkM0th50JGrpPlczQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGAY97hR3GdJYW1sZnKsy+nnjtTjmhiRGW29KtjU0BldkAXD2EF21I0CXNIMobiznc4O9yTuj0BYLZ/bJ66eaCueoQQ8jzXwWSdCtw/3QXnJ8qavc7Vzsh1PMysKU6wCJ1I/WOwq5/MtXlNLdcBpnDnxu9vqxgJtQiQhJuns/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PAixT2Em; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PAixT2Em"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7E2434D68A;
	Fri,  4 Jul 2025 10:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751618059;
	bh=EJn/cSZXH7BBYxWEIF85KO4s0OrkM0th50JGrpPlczQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAixT2EmfXRxmojutrLqbaeynKVHpFL+FqcT9uPjAV5kLPNQXCtsvVJ3kXJLc4cDC
	 pHAOs/FGu3F89M4v4mkaef2g7jWLV8gzWlX5VGp9aY7wQ92bMm3QkikvcfOUTuREYo
	 ENEfdU/T8+4W5MEp1UEYc9l0JYo2eXnrAinNAFDYgPUBs3gHjqZG83NxSLYWYKSWI0
	 P9ErZ1/A69/H1FvxBLyj/TSl78rREkIj5oNgOuUdUBoVgwTpGSuwWwF6eTTj9RYDUz
	 5hb+41JwUBygA8kLFrbnRn56JMHzmoyd+iSZQwTp4ZGxJxuy6IBfr/4Cp+Hu369lmA
	 ZPgn4Xi5W5nEQ==
Date: Fri, 4 Jul 2025 10:34:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.16-rc
Message-ID: <aGeSCv7ewZl5o3SS@8bytes.org>
References: <20250628100351.3198955-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628100351.3198955-1-baolu.lu@linux.intel.com>

On Sat, Jun 28, 2025 at 06:03:50PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following fix has been queued for v6.16-rc4:
> 
> - Assign devtlb cache tag on ATS enablement
> 
> It fixes a critical cache invalidation issue for ATS-capable devices. It
> has been reviewed and is ready for merge. Can you please consider it?
> 
> Best regards,
> baolu
> 
> 
> Lu Baolu (1):
>   iommu/vt-d: Assign devtlb cache tag on ATS enablement
> 
>  drivers/iommu/intel/cache.c |  5 ++---
>  drivers/iommu/intel/iommu.c | 11 ++++++++++-
>  drivers/iommu/intel/iommu.h |  2 ++
>  3 files changed, 14 insertions(+), 4 deletions(-)

Applied, thanks Baolu.
