From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/12] intel-ipu3: Add DMA API implementation
Date: Wed, 7 Jun 2017 18:45:12 +0100
Message-ID: <20170607184512.0e627965@lxorguk.ukuu.org.uk>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
        <1496695157-19926-4-git-send-email-yong.zhi@intel.com>
        <CAAFQd5CLXUsDv6H1C22tc4qjG9e7tm5jtxwYBjV5gx9qrDw50A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5CLXUsDv6H1C22tc4qjG9e7tm5jtxwYBjV5gx9qrDw50A@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: Yong Zhi <yong.zhi@intel.com>, linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, "Zheng, Jian Xu" <jian.xu.zheng@intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Toivonen, Tuukka" <tuukka.toivonen@intel.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

> > +       struct ipu3_mmu *mmu = to_ipu3_mmu(dev);
> > +       dma_addr_t daddr = iommu_iova_to_phys(mmu->domain, dma_handle);
> > +
> > +       clflush_cache_range(phys_to_virt(daddr), size);  
> 
> You might need to consider another IOMMU on the way here. Generally,
> given that daddr is your MMU DMA address (not necessarily CPU physical
> address), you should be able to call
> 
> dma_sync_single_for_cpu(<your pci device>, daddr, size, dir)

Te system IOMMU (if enabled) may be cache coherent - and on x86 would be,
so it doesn't think it needs to do anything for cache synchronization
and the dma_sync won't actually do any work.
 
Alan
