Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A337E5D7
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348334; cv=none; b=ucIyfMT3Eth4jDIWVxMpuh3R1fbYJuRk33PR01zBvaPZGA9CvSTEqBlFijqpdAQSPE7r2iVzaawFJAO6I01jygg3ij9F61M7JzqitiDo3hiYxRHFqJE+fbCTrvIQmk7a6LxABlyRFVrghEXPLL0MRt3xbDdy3hRU7RXODI1OWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348334; c=relaxed/simple;
	bh=EoKHedXFJVgHKb++MuFRnKL0Rd00lGFlwfm/WzkS/2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy76Q8YIsrkv4wAfLoLTv1P4K2x7KGDn+wqoUlRGMPrqntioOuDd/9HIH/5kBelVcDoHaiX+9LLs+D6aBcYE2Pd+V1orhGUy8dR6H3b4/o5ZGIvzBAtwzvVCBAynhZPhRZagbLUmiRA6jogIpgo6WIPdpIhuW88vciPlXDQXc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1CF4D206A2E;
	Mon, 10 Aug 2026 09:52:12 +0200 (CEST)
Date: Mon, 10 Aug 2026 09:52:11 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH 0/4] iommu: Fix SVA, iommufd, and iommupt error paths
Message-ID: <anmDHI07-PDaynZD@8bytes.org>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785050951.git.xueshuai@linux.alibaba.com>

On Sun, Jul 26, 2026 at 03:43:28PM +0800, Shuai Xue wrote:
> Shuai Xue (4):
>   iommu/sva: Set handle->dev before the SVA handle is visible
>   iommufd: Avoid locking internal accesses during unmap
>   iommufd: Release current IOAS on xa_store() failure
>   iommupt: Return zero for invalid iova_to_phys() ranges

Applied, thanks.
