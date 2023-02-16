Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE77B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 10:18:49 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A750A2218D1;
	Thu, 16 Feb 2023 11:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676542728;
	bh=s6xuKNMT23Rdm01FGJmDiggF/XrDkhgUsRCFu/DZNms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kr+vone90EbSi+eojJhKGDIBhSUjgq1dTthn2Pazz9lvqdO1zu35v+D+g//SNeySa
	 c6HxGx6lCKTujGtMC8gAk1f/4VkEDLlCnLCxXRVtUBrodIEVfch7qzAM0SIkB7dgu6
	 ItS39k9zBhhvtJnYDhj91IYxVUuJ2CQ9SSGEKFdlCd5cByrJhC4t3HRb1TiEqfV5i8
	 4hVq/rU465tOSmP13KtGGMSn1uEVMgJKiQaIrMEhKayZfCNXsP9nXvbik4aILJbVkm
	 y0nCXbDpeNrC47rpwIjHgRPWIYdDZWMm9ykD5olQ1EWkHjzd3lkJxMXbZDZYurp1dW
	 FzIddzpK6OkOw==
Date: Thu, 16 Feb 2023 11:18:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	will@kernel.org, Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH v3 3/3] iommu/amd: Improve page fault error reporting
Message-ID: <Y+4DB0y5z5GLcfVP@8bytes.org>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <20230215052642.6016-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215052642.6016-3-vasant.hegde@amd.com>

On Wed, Feb 15, 2023 at 05:26:42AM +0000, Vasant Hegde wrote:
> If IOMMU domain for device group is not setup properly then we may hit
> IOMMU page fault. Current page fault handler assumes that domain is
> always setup and it will hit NULL pointer derefence (see below sample log).

Edited the commit message a bit and added Thorstens Link tags. This patch
is now queued for v6.3.

Thanks,

	Joerg
