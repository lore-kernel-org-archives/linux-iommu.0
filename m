Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9DA7C
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 11:09:30 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9DAD7243F79;
	Fri, 14 Apr 2023 13:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1681470569;
	bh=jufgXyg11cFPpOClefAPAP/p4V/nAG7L1v/Un+6/c3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8iICzt6+zaQ7YqtOiLC8NwKSoPkZ2LE3+Dj7x2b4FVQU3gtKe2PYDyF5IDYWad85
	 EhlraHHuYAL/0faGDkAwPbmlrw/+2gewKjEiAFyhNcNkns5ZKm0jXQ+7i3d0JI2bOU
	 CULPFrEunraHuimkJoIz/KQ2A2oRZjzUaTGunwebQj9TVD15dHvy/0BV7XzNjZKe1e
	 sf71DtwaUAZfRj/94lgtOgzqJDPpB2m58R6HshD/6MZ2EMe1gqZ9DYhSNM0zu2L+Ua
	 SEj0MwMG9NCE3siRZF3knnUwfQZ+Ds33YH6bxIPMDMLSMrTIhrPkIJeV3HHa2Ksxwv
	 MQCr3+gJbDWjQ==
Date: Fri, 14 Apr 2023 13:09:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu: Remove iommu_group_get_by_id()
Message-ID: <ZDk0aLJkeTR0uVir@8bytes.org>
References: <0-v1-60bbc66d7e92+24-rm_iommu_get_by_id_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-60bbc66d7e92+24-rm_iommu_get_by_id_jgg@nvidia.com>

On Wed, Apr 12, 2023 at 11:11:58AM -0300, Jason Gunthorpe wrote:
> This is never called.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 29 -----------------------------
>  include/linux/iommu.h |  6 ------
>  2 files changed, 35 deletions(-)

Applied, thanks.
