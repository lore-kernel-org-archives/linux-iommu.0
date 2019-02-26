From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Fix IOMMU debugfs fallout
Date: Tue, 26 Feb 2019 11:16:35 +0100
Message-ID: <20190226101635.GE20740@8bytes.org>
References: <20190220130505.1188-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220130505.1188-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 20, 2019 at 02:05:05PM +0100, Geert Uytterhoeven wrote:
> A change made in the final version of IOMMU debugfs support replaced the
> public function iommu_debugfs_new_driver_dir() by the public dentry
> iommu_debugfs_dir in <linux/iommu.h>, but forgot to update both the
> implementation in iommu-debugfs.c, and the patch description.
> 
> Fix this by exporting iommu_debugfs_dir, and removing the reference to
> and implementation of iommu_debugfs_new_driver_dir().
> 
> Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/iommu-debugfs.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)

Applied, thanks.
