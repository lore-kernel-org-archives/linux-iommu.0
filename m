Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F08C01
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:45:42 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DBE85242DF9;
	Wed, 22 Mar 2023 15:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679496342;
	bh=8j2T+ZlX4ZdTrhXu8KGdXO9F9DabmzZ92pCdTRnFhPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=83CfWM2r6ZRSwKy4szm9mVcN5wWE8AHgXjbnvCtozx9kdOxTPpyEyMMDlL/yPJyu2
	 ro4y7rRt+L7Ua53Sf3mzYzPI6B9LIKMBqc7IjTn8TVlwbrRowL2airzwgkw5O/Gd0K
	 qR9baF41TN1EjQu1GrC1t5uGt8vjQjCz8wPDJHiXV0qAc8F25wFLcTqCyHzvjMhQve
	 9lZJSjqj51lOLYeoU/AsNFrIkb/PpsXAJMNK1WVIRC7k1wbApPWTSw9l7+c5kwT5k0
	 QKoKAbmke0KbQhX9/iNWO8+nC8RTQCm4hHyQIoEmdCVtQ/YGJ9FHSnDCLDKdKKVIam
	 +PA+CMMNeRb+g==
Date: Wed, 22 Mar 2023 15:45:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iommu: Extend changing default domain to normal
 group
Message-ID: <ZBsUlHuZ4kLfSGXI@8bytes.org>
References: <20230322064956.263419-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322064956.263419-1-baolu.lu@linux.intel.com>

On Wed, Mar 22, 2023 at 02:49:50PM +0800, Lu Baolu wrote:
> Lu Baolu (6):
>   iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path
>   iommu: Split iommu_group_remove_device() into helpers
>   iommu: Same critical region for device release and removal
>   iommu: Move lock from iommu_change_dev_def_domain() to its caller
>   iommu: Replace device_lock() with group->mutex
>   iommu: Cleanup iommu_change_dev_def_domain()
> 
>  drivers/iommu/iommu.c                         | 273 ++++++++----------
>  drivers/iommu/ipmmu-vmsa.c                    |  14 +-
>  .../ABI/testing/sysfs-kernel-iommu_groups     |   1 -
>  3 files changed, 130 insertions(+), 158 deletions(-)

Applied, thanks.
