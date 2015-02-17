From: Mark Hounschell <markh@compro.net>
Subject: IOMMU/DMA API inquiry
Date: Tue, 17 Feb 2015 14:48:03 -0500
Message-ID: <54E39AF3.1090409@compro.net>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org >> Linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "joro@8bytes.org >> Joerg Roedel" <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

I've searched the Doc tree and web to no avail. I was hoping I might get 
some  answers to a couple of questions that have arisen as a result of 
actually trying to take advantage of the IOMMU in our out of tree GPL 
drivers. The AMD IOMMU in particular. I'm currently using the 3.18.x 
kernel versions. Both 32 and 64 bit.

I understand that AMD IOMMU support is not available for 32-bit kernels. 
  I believe the INTEL IOMMU is supported there. Not knowing why, I was 
curious if that is going to remain that way?

I've learned that the AMD IOMMU does not play well with the kernels 
"Contiguous Memory Allocator" (CMA). I also believe, but could be 
mistaken, that the INTEL IOMMU does. Again, not knowing why, I was 
curious if that is going to remain that way also?

Is the fact that the AMD IOMMU is not supported on 32 bit kernels the 
reason that dma_map_page always returns 0 on 32 bit kernels. I found 
this strange because the dma_alloc_coherent function returns a 
page_to_phys address in the dma_handle when no IOMMU is enabled. I was 
sort of expecting dma_map_page to do the same. Other wise I seem to have 
to KNOW if an enabled and supported IOMMU is present. How does a driver 
tell if an IOMMU is present? I suspect it should not have to?

I've read the DMA-API-HOWTO.txt concerning dma_map_sg and at first I 
thought that maybe dma_map_sg could be used to get around the fact that 
AMD IOMMU doesn't work with CMA. But it looks as though I was mistaken 
and I would actually have to do a DMA for_each_sg(sglist, sg, count, i). 
Is that correct or can dma_map_sg somehow enable you to do a single DMA 
using a single address for the entire sglist?

Sorry if these questions seem ignorant. It was not intentional.

Thanks for any insight.

Regards
Mark
