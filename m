Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F537416E
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070063; cv=none; b=SxasFFCJQtU58B7qGpkq2i5wDps5pMvP7pF6p0O7EjfxiF9sbMGXp/Qep3pMKRRcVgGqzDjEqCNZVyytl2+2RzPboeju+ZZeyXQwssIrSg4WgV25uU/kKrHAr9vIzDzm2AWgYEm3LWiWoFka9lTzlkRmojS1lNMomHiha0eeVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070063; c=relaxed/simple;
	bh=P/lOqSeBUuxCMUUomMTG+WKn9mcunS8HgAw3QFBTX3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4v5vzC27EeWtTOwMeaL4SI4Q8eUAWAvMERV1Nq5lfkhrmmINeQokVQUJ5CmS53E3dL4RqakWa3qvcl8V62somFFMyfwvJgO4vDF4k+BLRJTLeoa3u9sffqE+zT9483U+Oq2G6wri5wJhVdbormWcMpSe6Sz/6qkq4DMYP5V0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UxHiKq+D; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UxHiKq+D"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D7CFC1C03FC;
	Thu, 22 Jan 2026 09:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769070060;
	bh=P/lOqSeBUuxCMUUomMTG+WKn9mcunS8HgAw3QFBTX3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxHiKq+DVw8Ykf4DAWKAtxi9X43HV9oCcMhAyR0Zxh5EGHUZt//BINpE/3K2MGHOK
	 5cCtudjm3hx2yrzqPypsmrns3JbAAzB3EBJE3vv4TuxAnQhuq71+lqZ04QARtKIODr
	 PZwwN1bdCmdOSgoTTELpGH4iDJJJ3wYO69eln3AHKvroL/tlQlQvxhDsgw31fltn2B
	 upqqnFPlOONVt+kFdXkG/kqEC7BuJEed1xnNvwglKDpueExpXCloHrvJJOg2MO7JHc
	 N6szpggkhGsNSubuffytrL4RM54qs2+A6nBEi+XfQVPED8ArqxZxsRFExmI4NQfy2s
	 iWYUrD/DYKmRw==
Date: Thu, 22 Jan 2026 09:20:58 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Dmytro Maluka <dmaluka@chromium.org>, 
	Jinhui Guo <guojinhui.liam@bytedance.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.20
Message-ID: <5s7q45wy6zqraatc3we2zblj7kb523q43wep35fcigaudixxmk@bckk4jfg54lt>
References: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122014856.2457052-1-baolu.lu@linux.intel.com>

On Thu, Jan 22, 2026 at 09:48:49AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.20-rc1. They are about
> some non-critical fixes, including:
> 
>  - Skip dev-iotlb flush for inaccessible PCIe device
>  - Flush cache for PASID table before using it
>  - Use right invalidation method for SVA and NESTED domains
>  - Ensure atomicity in context and PASID entry updates
> 
> These patches are based on v6.19-rc6. Please consider them for the
> iommu/vt-d branch.
> 
> Best regards,
> baolu
> 
> Dmytro Maluka (1):
>   iommu/vt-d: Flush cache for PASID table before using it
> 
> Jinhui Guo (2):
>   iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
>     scalable mode
>   iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
>     scalable mode
> 
> Lu Baolu (3):
>   iommu/vt-d: Clear Present bit before tearing down PASID entry
>   iommu/vt-d: Clear Present bit before tearing down context entry
>   iommu/vt-d: Fix race condition during PASID entry replacement
> 
> Yi Liu (1):
>   iommu/vt-d: Flush piotlb for SVM and Nested domain
> 
>  drivers/iommu/intel/iommu.h  |  21 +++-
>  drivers/iommu/intel/pasid.h  |  28 ++---
>  drivers/iommu/intel/cache.c  |   9 +-
>  drivers/iommu/intel/iommu.c  |  33 +++---
>  drivers/iommu/intel/nested.c |   9 +-
>  drivers/iommu/intel/pasid.c  | 212 ++++-------------------------------
>  6 files changed, 83 insertions(+), 229 deletions(-)

Applied all, thanks Baolu.
