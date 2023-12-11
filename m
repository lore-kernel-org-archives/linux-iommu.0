Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C848785
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="WUw7tWQo"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7D6DB1A367B;
	Mon, 11 Dec 2023 15:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702304050;
	bh=MsmJ0+kw3kuGXT7ti3wJ+ymRsCzrQz95soBzb/3baXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUw7tWQoOas25acQXfxHnsgu5Yoc/ntX9zVR7cSqYEuPe6pxFLjdQX+W8xVfdLJiq
	 vvKUA2v05JKyW3V/cWYLUXT+W5CJNoxQVjH25TleX8hqB/26rEjdCMUUIEWlfIadFt
	 /SrS4Va0ayhUcrHVO/R2rZ4SndtUTDHyVBPP8ticiWgf+uFYLy5Q+/bITFQE3/XI9f
	 jLw0qk9XS5144qT8lhs6EmeUJUmqdm58gdbTv3wnerhXUJ/u3QtPmDBejvOKApn01Q
	 xgdqGORzHnVTOOXo1T4Sn5TYVttMM279RdpAnc3rBOgz0qU6Z4pC7Kk0X/bIAz55Sy
	 sPsqFPsuxL6fw==
Date: Mon, 11 Dec 2023 15:14:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 0/7] Convert SMMU to domain_alloc_paging()
Message-ID: <ZXcZL19OLbctV_W-@8bytes.org>
References: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <20231130004905.GA1395649@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130004905.GA1395649@nvidia.com>

On Wed, Nov 29, 2023 at 08:49:05PM -0400, Jason Gunthorpe wrote:
> This is still pending, it doesn't need rebasing on v6.7
> 
> The DART patches were merges so all the dependencies are in v6.7 now.

This is mostly ARM-SMMU, so I leave it to Will and Robin to
decide/pick-up.

Regards,

	Joerg
