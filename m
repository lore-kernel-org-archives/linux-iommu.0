From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/dma: Don't put uninitialised IOVA domains
Date: Tue, 9 Aug 2016 17:36:39 +0200
Message-ID: <20160809153639.GE29650@8bytes.org>
References: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
Sender: stable-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 09, 2016 at 04:23:17PM +0100, Robin Murphy wrote:
> Due to the limitations of having to wait until we see a device's DMA
> restrictions before we know how we want an IOVA domain initialised,
> there is a window for error if a DMA ops domain is allocated but later
> freed without ever being used. In that case, init_iova_domain() was
> never called, so calling put_iova_domain() from iommu_put_dma_cookie()
> ends up trying to take an uninitialised lock and crashing.
> 
> Make things robust by skipping the call unless the IOVA domain actually
> has been initialised, as we probably should have done from the start.
> 
> Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
> Cc: stable@vger.kernel.org
> Reported-by: Nate Watterson <nwatters@codeaurora.org>
> Reviewed-by: Nate Watterson <nwatters@codeaurora.org>
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Wow, that was quick :)

Applied to iommu/fixes, thanks.
