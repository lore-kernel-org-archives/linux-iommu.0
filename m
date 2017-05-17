From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 00/08] iommu/ipmmu-vmsa: IPMMU multi-arch update V8
Date: Wed, 17 May 2017 15:29:41 +0200
Message-ID: <20170517132940.GF11068@8bytes.org>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Wed, May 17, 2017 at 07:06:16PM +0900, Magnus Damm wrote:
> iommu/ipmmu-vmsa: IPMMU multi-arch update V8
> 
> [PATCH v8 01/08] iommu/ipmmu-vmsa: Remove platform data handling
> [PATCH v8 02/08] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
> [PATCH v8 03/08] iommu/ipmmu-vmsa: Break out utlb parsing code
> [PATCH v8 04/08] iommu/ipmmu-vmsa: Break out domain allocation code
> [PATCH v8 05/08] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> [PATCH v8 06/08] iommu/ipmmu-vmsa: Use fwspec iommu_priv on ARM64
> [PATCH v8 07/08] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
> [PATCH v8 08/08] iommu/ipmmu-vmsa: Fix pgsize_bitmap semicolon typo

Applied, thanks.
