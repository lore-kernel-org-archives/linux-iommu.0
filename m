Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B7145A07
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502098; cv=none; b=tOpE11QRFNpJlk5DFGgVcIwRZYbmI4OM6cFPvTyMoWxbhKvK7EGMybUUgb2hYupGN8IYw4B+k3LmHxfsfN40buCcQDw1XWo5pgLmBTsxzYvqSEpRGZ4iNVO+KPNVUAnQOXkmUOtOM20f9a/nHtK9qNWzhvu1SSiUeE755PYMZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502098; c=relaxed/simple;
	bh=5GsNVSe6EKC8yF6n4zSmVZY81SgyiLDWt4Wu33R47i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ANfM0/eiBEPb+RJeQUpYU9WEsux1amlomW3+ZycVJy5g3zNIeJuOPMu+kpXWbDgrxaqU1ds+GoOnvMphsNKG2gCslnG4XVEjGpfIwCv8qfa1HgcQHP1FgwMPJ+JRMpFdoMKrslBNNm7/iH0bYtLIXNA3Fd/p69Gpbapg9R2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=o1CeSeNA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="o1CeSeNA"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0F3991C7901;
	Tue,  4 Jun 2024 13:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717502095;
	bh=5GsNVSe6EKC8yF6n4zSmVZY81SgyiLDWt4Wu33R47i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1CeSeNAVS9tEpK+JKAL3LC9hjLy9pcVbn8ydsT7TfdB0/4pL2HMghOzOp7oc59id
	 yariM0i2Iv8FjLxnlxSfp13HwVB/dd7HOndQeB0rVPMC2E930n98SVtosjCpZORdCj
	 K40SVxEvuU0mxLCbTCYWOHPeJJE1QkAwcCO9I59oWIV3dnsDK1aqS6Z+AR79dNwhY4
	 Jr6IG0I+9dT0JhKLGnMWSb7I8tkOv1O5DLBt+awT77gyl5RfuyTyJgryJ0beBNZxV1
	 H/OJd3S7r+u230CWCkPI+NHxIE3UGUNIcQqA3H5GNq2t9uOIZJd44el1pEe1JdOS7y
	 n/1MmBFF/EorA==
Date: Tue, 4 Jun 2024 13:54:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Message-ID: <Zl8AjeOFdIagHliv@8bytes.org>
References: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528042528.71396-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:25:28PM +0800, Lu Baolu wrote:
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
