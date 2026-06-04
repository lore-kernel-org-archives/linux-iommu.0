Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754993A962C
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567346; cv=none; b=KQHrBYEBEJIMO4euca1w3n0pmJNezeJTbLUlWkA+lu+ZsKjdrZOnNqyfDl0bWtqmL2HDE3QdWKZNL1JC2YRatUNQa/ouef4DrzoEqg1XmQfzwqPi0VTNSpW6sCbZoO8/U4YCdPb714BIBHVhaFC7ce5qk8B/05wbM6uSwdl2xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567346; c=relaxed/simple;
	bh=jr3h4XwkI7/Hfe7M/LLtHbmtmrYwaMxTT68AQcKH0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDyObQSjE7H4x+UYlOAeL/QcolyYYDPF3MKxWMjaFp3MDXrMtDMDtJqy3q6CTwXhOkPmZgcAlBkHu54dmCQyX9nPgAKk7Yy/EIFfgBYbZVeXXD+NMO4Pu1dZtBJBZNVGYraw5sT0ZuPu45n+87II/yNqdoarvA13516pNHzZosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500cb168346ed3abba9.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cb16:8346:ed3a:bba9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DA6AA201C4B;
	Thu,  4 Jun 2026 12:02:20 +0200 (CEST)
Date: Thu, 4 Jun 2026 12:02:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Pranjal Shrivastava <praan@google.com>, 
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Michael Bommarito <michael.bommarito@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] [PULL REQUEST] Intel IOMMU updates for v7.2
Message-ID: <aiFNG6UH1qNzRW_1@8bytes.org>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>

On Thu, Jun 04, 2026 at 02:03:05PM +0800, Lu Baolu wrote:
> Guanghui Feng (1):
>   iommu/vt-d: Improve IOMMU fault information
> 
> Lu Baolu (1):
>   iommu/vt-d: Avoid WARNING in sva unbind path
> 
> Michael Bommarito (1):
>   iommu/vt-d: Clear Present bit before tearing down scalable-mode
>     context entry
> 
> Michał Grzelak (1):
>   iommu/vt-d: Remove typo from pasid_pte_config_nested()
> 
> Pranjal Shrivastava (1):
>   iommu/vt-d: Fix RB-tree corruption in probe error path
> 
>  drivers/iommu/intel/iommu.h | 11 +++++++++++
>  drivers/iommu/intel/dmar.c  |  9 ++++++---
>  drivers/iommu/intel/iommu.c |  6 +++++-
>  drivers/iommu/intel/pasid.c | 16 +++++++++-------
>  drivers/iommu/intel/svm.c   | 12 ++++--------
>  5 files changed, 35 insertions(+), 19 deletions(-)

Applied, thanks.
