From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: use dev_get_platdata()
Date: Wed, 22 Oct 2014 16:30:21 +0200
Message-ID: <20141022143021.GI10074@8bytes.org>
References: <1412947870-10033-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412947870-10033-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 10, 2014 at 07:01:10PM +0530, Kiran Padwal wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/iommu/msm_iommu_dev.c |    4 ++--
>  drivers/iommu/omap-iommu.c    |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

This touches 2 drivers, can you please split it up into per-driver
patches?

Thanks,

	Joerg
