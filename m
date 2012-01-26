From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Thu, 26 Jan 2012 15:59:16 +0100
Message-ID: <20120126145915.GG6269@8bytes.org>
References: <20120124142521.GE6269@8bytes.org> <20120125.093932.783007031082378997.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120125.093932.783007031082378997.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 25, 2012 at 08:39:32AM +0100, Hiroshi Doyu wrote:
> From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Thu, 17 Nov 2011 07:31:31 +0200
> Subject: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
> 
> Tegra 30 IOMMU H/W, SMMU (System Memory Management Unit). This patch
> implements struct iommu_ops for SMMU for the upper IOMMU API.
> 
> This H/W module supports multiple virtual address spaces(domain x4),
> and manages 2 level H/W translation pagetable.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/include/mach/smmu.h |   63 ++
>  drivers/iommu/Kconfig                   |   11 +
>  drivers/iommu/Makefile                  |    1 +
>  drivers/iommu/tegra-smmu.c              | 1034 +++++++++++++++++++++++++++++++
>  4 files changed, 1109 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/include/mach/smmu.h
>  create mode 100644 drivers/iommu/tegra-smmu.c

Removed 'default y' and applied to arm/tegra as well. Thanks.


	Joerg
