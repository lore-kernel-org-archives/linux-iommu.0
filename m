From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/of: Handle PCI aliases properly
Date: Wed, 26 Jul 2017 11:12:25 +0200
Message-ID: <20170726091225.GA15833@8bytes.org>
References: <20170531175230.16529-3-robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170531175230.16529-3-robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 31, 2017 at 06:52:29PM +0100, Robin Murphy wrote:
> When a PCI device has DMA quirks, we need to ensure that an upstream
> IOMMU knows about all possible aliases, since the presence of a DMA
> quirk does not preclude the device still also emitting transactions
> (e.g. MSIs) on its 'real' RID. Similarly, the rules for bridge aliasing
> are relatively complex, and some bridges may only take ownership of
> transactions under particular transient circumstances, leading again to
> multiple RIDs potentially being seen at the IOMMU for the given device.
> 
> Take all this into account in the OF code by translating every RID
> produced by the alias walk, not just whichever one comes out last.
> Happily, this also makes things tidy enough that we can reduce the
> number of both total lines of code, and confusing levels of indirection,
> by pulling the "iommus"/"iommu-map" parsing helpers back in-line again.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This applies on top of the fix currently queued in the IOMMU tree:
> "iommu/of: Ignore all errors except EPROBE_DEFER"
> 
>  drivers/iommu/of_iommu.c | 104 +++++++++++++++++++++--------------------------
>  1 file changed, 47 insertions(+), 57 deletions(-)

Applied, thanks.
