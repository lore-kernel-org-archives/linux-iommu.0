From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Don't print warning when IOMMU driver only
 supports unmanaged domains
Date: Mon, 25 Mar 2019 14:37:36 +0100
Message-ID: <20190325133736.GA11654@suse.de>
References: <20190322160426.1480-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322160426.1480-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 22, 2019 at 05:04:26PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Print the warning about the fall-back to IOMMU_DOMAIN_DMA in
> iommu_group_get_for_dev() only when such a domain was
> actually allocated.
> 
> Otherwise the user will get misleading warnings in the
> kernel log when the iommu driver used doesn't support
> IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY.
> 
> Fixes: fccb4e3b8ab09 ('iommu: Allow default domain type to be set on the kernel command line')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied.
