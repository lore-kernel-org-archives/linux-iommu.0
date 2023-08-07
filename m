Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D97D51D;
	Mon,  7 Aug 2023 12:54:23 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 25DD82802BA;
	Mon,  7 Aug 2023 14:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691412862;
	bh=RCZynHVqfbeOZx3jI34/l35dFAKb3CMwoa3BIreKS+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGr8F9B0aS0Et/yMiDok+a8BBdIJfQJn8IvZaZMcTGkw+80JeIT0I+QJZShTmdlSh
	 8tG7+BVV/DRwccyatKUTqLDtDIs9X3QPYTXREWYPmi28Kb9d001zxoJdww1erlf4U/
	 A8GVyxh+0LEVblFHoVEubpXv8e/o7mHiTeZpKpcd7LoZWXdb7mycb7IjKyY05tyKTz
	 XEotNQ/1tcFFJ+G6x5Ps9Nv/XP7gFoDomSt/QgrD/obEehtDBpki3mNuHDKSr9ogSI
	 QP1Z3xiAKhzAlgmyVImuMYK0LWNeKdXleI9W0R2jkS4KXKNiMA8W9ZNqNnq3NPpWtI
	 kXrWS4M4fQofA==
Date: Mon, 7 Aug 2023 14:54:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
Message-ID: <ZNDpfCoeFxA56ZlU@8bytes.org>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>

On Mon, Jul 31, 2023 at 02:50:23PM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (10):
>   iommu: Remove useless group refcounting
>   iommu: Add a lockdep assertion for remaining dev->iommu_group reads
>   iommu: Add generic_single_device_group()
>   iommu/sun50i: Convert to generic_single_device_group()
>   iommu/sprd: Convert to generic_single_device_group()
>   iommu/rockchip: Convert to generic_single_device_group()
>   iommu/ipmmu-vmsa: Convert to generic_single_device_group()
>   iommu/omap: Convert to generic_single_device_group()
>   iommu: Complete the locking for dev->iommu_group
>   iommu/intel: Fix missing locking for show_device_domain_translation()
> 
>  drivers/iommu/intel/debugfs.c  |  34 ++++----
>  drivers/iommu/iommu.c          | 155 +++++++++++++++++++++------------
>  drivers/iommu/ipmmu-vmsa.c     |  22 ++---
>  drivers/iommu/omap-iommu.c     |  30 +------
>  drivers/iommu/omap-iommu.h     |   2 +-
>  drivers/iommu/rockchip-iommu.c |  22 +----
>  drivers/iommu/sprd-iommu.c     |  24 +----
>  drivers/iommu/sun50i-iommu.c   |  29 ++----
>  include/linux/iommu.h          |   3 +
>  9 files changed, 138 insertions(+), 183 deletions(-)

Applied, thanks for the nice cleanup!
