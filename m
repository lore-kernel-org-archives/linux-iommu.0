From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Correct iommu_map / iommu_unmap prototypes
Date: Wed, 26 Jul 2017 11:27:44 +0200
Message-ID: <20170726092744.GE15833@8bytes.org>
References: <20170705172753.24701-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705172753.24701-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 05, 2017 at 08:27:53PM +0300, Dmitry Osipenko wrote:
> Commit 7d3002cc8c16 ("iommu/core: split mapping to page sizes as supported
> by the hardware") replaced 'int gfp_order' with a 'size_t size' of
> iommu_map / iommu_unmap function arguments, but missed the function
> prototypes for the disabled CONFIG_IOMMU_API case, let's correct them
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/iommu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
