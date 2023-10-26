Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E615AD0
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="7hXKGtTy"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7A72A1A6582;
	Thu, 26 Oct 2023 09:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698305081;
	bh=imEBUMoMnJ11bhtOMKZdu+fWgs5XY6RIcln8XGroUKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7hXKGtTydVfrZ/ir3xgATqn4SiC6otKrLWnNt1K+LzOmLLfxYj2tr8T4Xnt55E1gP
	 zmGRsL5n7IV4RfCc36vq2aS6xpMh2AkzXOZ4GbOv/NwzsIbJEKtGYX4j1mAIwuzGvw
	 2AtkWzomWj379hYHd6reTgpbNB0P1Rq9iJwBbgsZ1QVOgAh1a0mc/K8aMOgEncAwm0
	 rdUpKDMY0g6VsmTpuqEDIgVHFXMiYev6UVHWlpyJRzNsXktTvQ7Y7nmioAM/ZcIpBl
	 R5TXwoAPCM6Xvm5YS6REGFjn2eMofQSUFPCE7sZQCthfusx22fOe69vgr7aEXboy5a
	 HB++oErAZ4+og==
Date: Thu, 26 Oct 2023 09:24:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZToUOKSqqI6Bh_03@8bytes.org>
References: <20231018050640.24936-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>

Hi Tina,

On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

Thanks for doing this, it all looks reasonable to me. But there is one
thing missing which needs to be done before we can move forward with
this.

There was a discussion about the Kconfig symbol naming used in
mm_struct. Please see the discussion here:

	https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/

Please update this patch-set to solve this and I will take the series.

Regards,

	Joerg
