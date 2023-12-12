Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858815ADF
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lVtlpzcO"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4CE841A4F1D;
	Tue, 12 Dec 2023 10:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702372618;
	bh=3mw5c2s43EoXfOonhkPHbbLEkkw3V57oAh17CvQIgj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVtlpzcO9jbf/R/j1Xgtidxl3Z01rGwCu8IoNGQ3FlizsM+vaKVSvJK+S1r2cBrQv
	 tKGjhN3mL5EKSZDDYW1S2AzIIWsFMPnQSgU1ipmTbQhA1YP1s6bRWOu1XBjNZ0JGji
	 ANDiSuOpW+bd4lV1FHnhGfy/K2vlg07qDcx6D+akjk48ugCiXRv/Nt271yEtXciQag
	 FmS+eujGHTLO9bDp8HQ23uQ+5nj7tmT1qjXQq8A4oJ3YU04sJ6xMFBRsOXNR2g1a1W
	 tTrbkLFU/Qv0lRvTm3dYg9EtfexpEMo9htQ/eOr2JBkArQ0oG0xYihbRcLVCsMrX32
	 Gu9ecyzXCkPZw==
Date: Tue, 12 Dec 2023 10:16:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: Set owner token to SVA domain
Message-ID: <ZXglCeP3YT1Eq2Er@8bytes.org>
References: <20231208015314.320663-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208015314.320663-1-baolu.lu@linux.intel.com>

On Fri, Dec 08, 2023 at 09:53:14AM +0800, Lu Baolu wrote:
>  drivers/iommu/iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
