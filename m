Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB126F9CB
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595509; cv=none; b=nmP+tavtdoHFtGm4DDobRs8eXjzAGyBLsyHNiHgXKH+syVuWEx/Mprk8h8ql2/1TSvkrS5+LO57tcZD32k12qp7IO/f9J1h9leHHTKJBPUqZJ6PqNR6jPBJqvRCR7eBo4VoP//88/nEn+gy83nDGG03aNbulBOAuLm72NgnEcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595509; c=relaxed/simple;
	bh=3vl10KU33CDG6uF+Ma1XE6fxWf0kXpX43klRjqGvjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUafGPWz2RTII5ErV21erxFPutaE+tKgn5EaLsB2l/FtRQgghOzOW0BVZ0pov8zdxUU0talfQoinY0niQqZGI8vPGrqIJ1njZ1qwTr82eTpEnS1SeEMHjnx7N51sp/L8QlGQxnBrUTVi6KwUnMPfMRspe3Bxd1Sc1wuUeqYZfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ikXX1Iyt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ikXX1Iyt"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3ACA144C5C;
	Mon, 10 Mar 2025 09:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595507;
	bh=3vl10KU33CDG6uF+Ma1XE6fxWf0kXpX43klRjqGvjF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikXX1Iyti49HeA5hJ4hkLsG11glf2mTTE7Ixs3lnPZEcgpgUO2ac4yC/SdgZa2YYr
	 VGWTrtotRfrEZMZ4lTjMkO138ke6bSjgm6y0PFtrNhtl694qotEDm9qTihXGcJnwBc
	 viuR+D+csfcsnnNrPg4N69DPgxhmvXg7WCjvT0usF61AtxHrB6zuMxkgTQdHA67WVO
	 A/EW1TB6vZylRm4h5SLUUsh9Ntp/UKtN8L/tCxMtezrfVV7Tmjy52/420kkGpJsYLB
	 lQuWNxCl0dHs806ODt5BMv8GvIKpnn//Q7UlGYd2VunlVEm/gm4NkzJVojENPis2i2
	 Nzgh0vq79DoCQ==
Date: Mon, 10 Mar 2025 09:31:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v6.15
Message-ID: <Z86jcijk6U-3Li5G@8bytes.org>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>

On Mon, Mar 10, 2025 at 10:47:43AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.15-rc1. They are about new
> features and code refactoring, including:
> 
>  - Checking for SVA support in domain allocation and attach paths
>  - Move PCI ATS and PRI configuration into probe paths
>  - Fix a pentential hang on reboot -f
>  - Miscellaneous cleanups
> 
> These patches are based on v6.14-rc6. Please consider them for the
> iommu/vt-d branch.
> 
> Best regards,
> baolu
> 
> Jason Gunthorpe (2):
>   iommu/vt-d: Use virt_to_phys()
>   iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> 
> Lu Baolu (3):
>   iommu/vt-d: Move scalable mode ATS enablement to probe path
>   iommu/vt-d: Move PRI enablement in probe path
>   iommu/vt-d: Cleanup intel_context_flush_present()
> 
> Yunhui Cui (1):
>   iommu/vt-d: Fix system hang on reboot -f
> 
>  drivers/iommu/intel/iommu.c | 237 +++++++++++++-----------------------
>  drivers/iommu/intel/iommu.h |  28 +----
>  drivers/iommu/intel/pasid.c |  43 ++-----
>  drivers/iommu/intel/prq.c   |   2 +-
>  drivers/iommu/intel/svm.c   |  43 +++++++
>  5 files changed, 143 insertions(+), 210 deletions(-)

Applied, thanks Baolu.
