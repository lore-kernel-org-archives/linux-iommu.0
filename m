From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Small fixes and cleanups
Date: Tue, 27 Jan 2015 09:14:59 +0200
Message-ID: <3395052.hcL4E8rFcL@avalon>
References: <1422316230-18893-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422316230-18893-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>, Varun Sethi <Varun.Sethi@freescale.com>, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thank you for the patches.

On Tuesday 27 January 2015 00:50:26 Joerg Roedel wrote:
> Hi,
> 
> here are a couple of iommu fixes and cleanups to fix compile
> errors and some warnings on ARM and PPC.

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (4):
>   iommu: Make more drivers depend on COMPILE_TEST
>   iommu/exynos: Make driver depend on REGULATOR
>   iommu/omap: Print phys_addr_t using %pa
>   iommu/fsl: Use %pa to print phys_addr_t
> 
>  drivers/iommu/Kconfig      | 11 +++++++----
>  drivers/iommu/fsl_pamu.c   |  4 ++--
>  drivers/iommu/omap-iommu.c |  2 +-
>  3 files changed, 10 insertions(+), 7 deletions(-)

-- 
Regards,

Laurent Pinchart
