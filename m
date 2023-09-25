Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D446F13FFA;
	Mon, 25 Sep 2023 09:53:23 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 570451A1EA9;
	Mon, 25 Sep 2023 11:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695635602;
	bh=iPcKxDgh7uKZSeXFS4UZzWRTdid6JKONVfiiv0MiYUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNn2ZSuFZ10pkhmA9CcEJ+VPx9LmV+ml9gXpZuasmDVx7GcpqOnsSIR9cTBl5Nxjo
	 eKAvHbL4VOu4rFaPhAajyxJxYVqTN40yHUwJzi30fWH8zOmwIBPZkkJCX9Jn6HHHdb
	 XckvBZ++gEIYVeOJcMnsu7HqkmPev9bblw1SoRIj0taoq+CrTd7cggcqL55Ju+Q3oE
	 JLZWLdCQM1fmTb5RGZ5Ah9nmCPHPczfz4MSegkThaYKrpJV3yDCydkUYvNOXqI+net
	 ylp37ayhM+EL81UJwGwathmQhH38pSCya+CoOsPb7ulxfGNAYbZyfH5+2HOoeEEh2X
	 pbKAC6DTnIhPA==
Date: Mon, 25 Sep 2023 11:53:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/7] Introduce generic_single_device_group()
Message-ID: <ZRFYkYXUXFOpvk_T@8bytes.org>
References: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>

On Tue, Aug 22, 2023 at 01:15:55PM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (7):
>   iommu: Remove useless group refcounting
>   iommu: Add generic_single_device_group()
>   iommu/sun50i: Convert to generic_single_device_group()
>   iommu/sprd: Convert to generic_single_device_group()
>   iommu/rockchip: Convert to generic_single_device_group()
>   iommu/ipmmu-vmsa: Convert to generic_single_device_group()
>   iommu/omap: Convert to generic_single_device_group()

Applied on-top of the default-domain patch-set, thanks.

It caused some conflicts, but those were easy to resolve.
