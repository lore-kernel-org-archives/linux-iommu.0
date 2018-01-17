From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: use domain instead of cache fetching
Date: Wed, 17 Jan 2018 14:46:07 +0100
Message-ID: <20180117134606.duf22tresqonahmt@8bytes.org>
References: <20180110055137.5711-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110055137.5711-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>, dwmw2@infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 10, 2018 at 01:51:37PM +0800, Peter Xu wrote:
> after commit a1ddcbe93010 ("iommu/vt-d: Pass dmar_domain directly into
> iommu_flush_iotlb_psi", 2015-08-12), we have domain pointer as parameter
> to iommu_flush_iotlb_psi(), so no need to fetch it from cache again.
> 
> More importantly, a NULL reference pointer bug is reported on RHEL7 (and
> it can be reproduced on some old upstream kernels too, e.g., v4.13) by
> unplugging an 40g nic from a VM (hard to test unplug on real host, but
> it should be the same):
> 
[...]
> 
> CC: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
