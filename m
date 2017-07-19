From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/5] FlexRM support in VFIO platform
Date: Wed, 19 Jul 2017 11:57:24 +0100
Message-ID: <0dc860ed-a40c-1bfd-f584-225807edb25b@arm.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup.patel@broadcom.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: iommu@lists.linux-foundation.org

On 19/07/17 10:33, Anup Patel wrote:
> This patchset primarily adds Broadcom FlexRM reset module for
> VFIO platform driver. We also have minor improvments in IOMMU
> and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.

I'm struggling to understand the IOMMU changes here - what's the
FlexRM's hardware relationship with the IOMMU, and how is it different
from any other device? Furthermore, if there *is* a relevant IOMMU
present, why would no-IOMMU mode need to be involved at all?

Robin.

> The patches are based on Linux-4.13-rc1 and can also be
> found at flexrm-vfio-v1 branch of
> https://github.com/Broadcom/arm64-linux.git
> 
> Anup Patel (5):
>   iommu: Add capability IOMMU_CAP_BYPASS
>   iommu/arm-smmu: add IOMMU_CAP_BYPASS to the ARM SMMU driver
>   iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM SMMUv3 driver
>   vfio: Allow No-IOMMU mode for IOMMUs with bypass capability
>   vfio: platform: reset: Add Broadcom FlexRM reset module
> 
>  drivers/iommu/arm-smmu-v3.c                        |  2 +
>  drivers/iommu/arm-smmu.c                           |  2 +
>  drivers/vfio/platform/reset/Kconfig                |  9 +++
>  drivers/vfio/platform/reset/Makefile               |  1 +
>  .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 91 ++++++++++++++++++++++
>  drivers/vfio/vfio.c                                | 13 +++-
>  include/linux/iommu.h                              |  4 +
>  7 files changed, 119 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> 
