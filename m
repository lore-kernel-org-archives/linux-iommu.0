From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/intel-iommu: fix memory leak in
 intel_iommu_put_resv_regions()
Date: Tue, 22 Jan 2019 14:03:51 +0100
Message-ID: <20190122130351.qflz37jyqyrpulgt@suse.de>
References: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2019 at 08:11:44PM +0100, Gerald Schaefer wrote:
> Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
> the reserved region type in intel_iommu_get_resv_regions() from
> IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
> the type in intel_iommu_put_resv_regions().
> 
> This leads to a memory leak, because now the check in
> intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
> be true, and no allocated regions will be freed.
> 
> Fix this by changing the region type in intel_iommu_put_resv_regions()
> to IOMMU_RESV_MSI, matching the type of the allocated regions.
> 
> Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
