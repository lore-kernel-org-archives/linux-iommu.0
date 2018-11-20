From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Date: Tue, 20 Nov 2018 10:25:16 +0100
Message-ID: <20181120092516.GC7270@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com> <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com> <20181114141311.GA26677@lst.de> <20181114161239.GA29462@lst.de> <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 19, 2018 at 03:22:13PM -0800, John Stultz wrote:
> > +               sg->dma_address = dma_addr;
> >                 sg_dma_len(sg) = sg->length;
> >         }
> 
> I know Robin has already replied with more detailed info, but just to
> close the loop as I'm finally home, applying this patch didn't seem to
> help with the IO hangs I'm seeing w/ HiKey960.

If Robins observation is right this should fix the problem for you:

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..1833f0c1fba0 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -5,7 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mem_encrypt.h>
 
-#define DIRECT_MAPPING_ERROR		0
+#define DIRECT_MAPPING_ERROR		(~(dma_addr_t)0x0)
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
