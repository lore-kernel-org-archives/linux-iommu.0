Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09647C
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 11:08:20 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 29C33243F79;
	Fri, 14 Apr 2023 13:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1681470494;
	bh=lwtBIFmNUkW89199mfVuhwtx0BQIbwYhBYqCvpYaZ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDR2gjXO2HjObseAAA0Z2aYnnw35DSGt/P9fCgvOjqtWtuI6KAqGRooLPkPVLMEYW
	 FoOuODHp1iw3FtkFruFpKSWOFdxe/G39fSmbqoxtLWcIS3LztFy0N8IzzQJbygveBu
	 mg+2B3f0+ZmyOBVDc5o/+g6BdLGCfgjiaGUXvmuiwMjBj30EjonaeoEjhhEL8K3BLZ
	 HmWBf96Hbl9ZSnUEKeB8teTgXdt/2olpfQvGNqXbl1w70sJdoVPc9dqZp1hMX0KU+0
	 BGev7NHt9Ziy2qJRl+e5r+oGYwFBIaFAhwAiY6hdRG+wrowloY687aoYIjEla/qNaM
	 3E87h3uNuZU2g==
Date: Fri, 14 Apr 2023 13:08:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu: Make iommu_release_device() static
Message-ID: <ZDk0HAlEoBtOmK/J@8bytes.org>
References: <0-v1-c3da18124d2d+56-rm_iommu_release_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-c3da18124d2d+56-rm_iommu_release_jgg@nvidia.com>

On Wed, Apr 12, 2023 at 11:10:45AM -0300, Jason Gunthorpe wrote:
> This is not called outside the core code, and indeed cannot be called
> correctly outside the bus notifier. Make it static.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  include/linux/iommu.h | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
