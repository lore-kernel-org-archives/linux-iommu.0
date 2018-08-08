From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/8] Tegra GART driver clean up and optimization
Date: Wed, 8 Aug 2018 11:52:27 +0200
Message-ID: <20180808095227.ll723ibwtyclih32@8bytes.org>
References: <20180804143003.15817-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Thierry,

On Sat, Aug 04, 2018 at 05:29:55PM +0300, Dmitry Osipenko wrote:
> Dmitry Osipenko (8):
>   memory: tegra: Provide facility for integration with the GART driver
>   iommu/tegra: gart: Provide access to Memory Controller driver
>   iommu/tegra: gart: Clean up drivers module code
>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>   iommu/tegra: gart: Clean up driver probe errors handling
>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>   iommu: Introduce iotlb_sync_map callback
>   iommu/tegra: gart: Optimize mapping / unmapping performance
> 
>  drivers/iommu/iommu.c      |  8 ++-
>  drivers/iommu/tegra-gart.c | 99 +++++++++++++++++++++++---------------
>  drivers/memory/tegra/mc.c  | 26 ++++++++--
>  include/linux/iommu.h      |  1 +
>  include/soc/tegra/mc.h     | 13 +++++
>  5 files changed, 103 insertions(+), 44 deletions(-)

Can you have a look please whether this is safe to go upstream?

Thanks,

	Joerg
