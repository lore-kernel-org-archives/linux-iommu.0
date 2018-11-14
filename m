From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Date: Wed, 14 Nov 2018 15:13:11 +0100
Message-ID: <20181114141311.GA26677@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com> <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

Does the patch below make a difference for you?  Assigning an
address to the S/G list is the only functional difference I could
spot.  Drivers really should never look at the S/G list on an
error return, but..

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 75c82f050c9e..a896f46d0c31 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -788,7 +788,7 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 	for_each_sg(sgl, sg, nelems, i) {
 		dma_addr_t dma_addr;
 
-		dma_add = swiotlb_map_page(dev, sg_page(sg), sg->offset,
+		dma_addr = swiotlb_map_page(dev, sg_page(sg), sg->offset,
 				sg->length, dir, attrs);
 		if (dma_addr == DIRECT_MAPPING_ERROR)
 			goto out_error;
