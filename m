From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V5
Date: Thu, 22 Sep 2016 16:47:24 +0200
Message-ID: <20160922144724.GL3541@8bytes.org>
References: <20160920134355.25470.93701.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920134355.25470.93701.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 20, 2016 at 10:43:55PM +0900, Magnus Damm wrote:
> iommu/ipmmu-vmsa: IPMMU multi-arch update V5
> 
> [PATCH v5 01/07] iommu/ipmmu-vmsa: Remove platform data handling
> [PATCH v5 02/07] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
> [PATCH v5 03/07] iommu/ipmmu-vmsa: Break out utlb parsing code
> [PATCH v5 04/07] iommu/ipmmu-vmsa: Break out domain allocation code
> [PATCH v5 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> [PATCH v5 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
> [PATCH v5 07/07] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency

So except for patch 5 this looks good to me. Please add

Reviewed-by: Joerg Roedel <jroedel@suse.de>

to all patches, except patch 5, when you resend.


Thanks,

	Joerg
