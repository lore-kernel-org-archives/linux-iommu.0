From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [patch] iommu/amd: Missing error code in amd_iommu_init_device()
Date: Tue, 29 Nov 2016 17:40:04 +0100
Message-ID: <20161129164004.GB13850@8bytes.org>
References: <20161124110544.GE17225@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124110544.GE17225@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 24, 2016 at 02:05:44PM +0300, Dan Carpenter wrote:
> We should set "ret" to -EINVAL if iommu_group_get() fails.
> 
> Fixes: 55c99a4dc50f ("iommu/amd: Use iommu_attach_group()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

