Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5828CF5D
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349084; cv=none; b=bRyKye3xwW3ZMoTstSaQ91y2ADGXTNwUdc9hBqfm9UwEC7yBL01lJsboe3/l0YlJCCC6ewHj33dKCfcAqT7+X22zyQaXsdMzspNjWZiU7NZIa20EAJY803G1SfSLfpmi4lo1PFWx8JZN1wM+OHg+zYvCUA12CKM94OqTzSQFUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349084; c=relaxed/simple;
	bh=+r2xDRcrisUIcywjzo35McMm1XwXbw7z06b5fX7LG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abq8yCdX0HsJfpT0T3c4qLQD2zbJhy+8UQM2BZnj2+jflBkZUmKjqFILHFVVuTE6BYdpzaE2wx9052XdKboMSBXXhO+C6eCB3bvfrMv61NoiBdoPeyxdS/mRnzU4xeYpA6FZgYniB6O76euDCPvNw1OBafgbyPOME65hVjSVsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 254E32069E8;
	Mon, 10 Aug 2026 10:04:41 +0200 (CEST)
Date: Mon, 10 Aug 2026 10:04:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: ZhaoJinming <zhaojinming@uniontech.com>, 
	Kevin Tian <kevin.tian@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, Li RongQing <lirongqing@baidu.com>, 
	Desnes Nunes <desnesn@redhat.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19][PULL REQUEST] Intel IOMMU updates for v7.3
Message-ID: <anmF_w7m6SYPquyS@8bytes.org>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>

On Wed, Aug 05, 2026 at 07:42:54AM +0800, Lu Baolu wrote:
> Desnes Nunes (1):
>   iommu/vt-d: Fix UCTP context table slot when copying root entries
> 
> Dmitry Antipov (1):
>   iommu/vt-d: Use kstrtoint_from_user() in dmar_perf_latency_write()
> 
> Guanghui Feng (1):
>   iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in
>     flush loop
> 
> Kevin Tian (9):
>   iommu/vt-d: Fix no_iommu to disable platform opt-in
>   iommu/vt-d: Force requesting ACS when tboot is enabled
>   iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
>   iommu/vt-d: Consolidate dmar policy management and force_on logic
>   iommu/vt-d: Use dmar_can_force_on() for platform opt-in
>   iommu/vt-d: Call dmar_can_force_on() for tboot opt-in
>   iommu/vt-d: Remove the 'force_on' variable
>   iommu/vt-d: Remove dmar_disabled
>   iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit
> 
> Li RongQing (1):
>   iommu/vt-d: Use logical OR operator for privilege mode check
> 
> Lu Baolu (5):
>   iommu/vt-d: Cache max domain ID to avoid redundant calculation
>   iommu/vt-d: Clear Present bit before tearing down copied context entry
>   iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
>   iommu/vt-d: Tear down scalable-mode context on probe failure
>   iommu/vt-d: Flush context cache with correct SID when tearing down
>     aliases
> 
> ZhaoJinming (1):
>   iommu/vt-d: Fix copied_tables bitmap leak on error in
>     copy_translation_tables
> 
>  drivers/iommu/intel/iommu.h   |  73 ++++++++++++++----
>  include/linux/dmar.h          |   1 +
>  drivers/iommu/intel/cache.c   |   5 +-
>  drivers/iommu/intel/debugfs.c |  16 +---
>  drivers/iommu/intel/dmar.c    |  96 ++++++++++++++++++++---
>  drivers/iommu/intel/iommu.c   | 139 +++++++++++++++++++---------------
>  drivers/iommu/intel/pasid.c   |   9 ++-
>  drivers/iommu/intel/prq.c     |   2 +-
>  drivers/iommu/intel/svm.c     |   2 +-
>  9 files changed, 238 insertions(+), 105 deletions(-)

Applied, thanks Baolu.
