Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2618A92A
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980644; cv=none; b=t+/xXWxYfnhZt1/H5DBV74tCcdDELtVYhK1IraKX3IceULDgkMFCsSYLFqDD0dR84OhFEgyXtDyw2zqvNltScM2ivIIXnCk+oxa9BicwqklkVblJH9Ltc80L6rT/JsxtSUdfGli8v6idwNkEcStX0zpHBT8CDcphDHNxJ3SSg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980644; c=relaxed/simple;
	bh=tETNuYHVSMgSZcgmOsTTQxvYt5JokXBLHVq1MUYiq6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTilNMFy1xJ+oHEN9PdpP4+sGRxIsEwdJpIwYcl8M30I6zAychudvH9RIuE8dPCz5JCwG6nAI9EzmdBqllZAitwt016EmlAr1+RVGJ/goz5q1c12+s6VAc5tCYJK+PKkBZQGxOT1bXUKjCU3sGF+KM6tiPSlEpGScyzJFdi/QGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=tu2oXq0C; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tu2oXq0C"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 417F82A7853;
	Tue, 15 Oct 2024 10:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980642;
	bh=tETNuYHVSMgSZcgmOsTTQxvYt5JokXBLHVq1MUYiq6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tu2oXq0CfPR8yJDXsvcbHSIvMSsHWYetMd1HWkQAkHEDT2vpTurX5kc7XMDKeIM8u
	 pl6g0q8xO3O3VDt4i1r4CITPhYUxTNaxBPOJUOvrWgQpZVw1D8a5xV3wI2jMgS4liS
	 iWo4emcSou3uuVFKJbBOMslFNT5pdHf1vaByeF5x+PB048AQ2F8p9Q1QcPZcBtUiDd
	 EqFyd7+3SIqkgQ5PRifj87L8uHAXQkE6L2kXWvCW5fCWkey3l0vf5Mk3fwxHTART/l
	 TroK/7OUSXQV139bCsSuIUuwNaK5w0BLcFMfS6kcFh+gCJQvexpxfDzceGztHcIfjj
	 WwTqCNrc7F2/g==
Date: Tue, 15 Oct 2024 10:24:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 1/1] iommu: Remove iommu_present()
Message-ID: <Zw4moeFYFDmn6t4b@8bytes.org>
References: <20241009051808.29455-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009051808.29455-1-baolu.lu@linux.intel.com>

On Wed, Oct 09, 2024 at 01:18:08PM +0800, Lu Baolu wrote:
> The last callsite of iommu_present() is removed by commit <45c690aea8ee>
> ("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
> code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 25 -------------------------
>  2 files changed, 31 deletions(-)

Applied, thanks.
