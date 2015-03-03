From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Tue, 3 Mar 2015 11:38:47 +0800
Message-ID: <1425353927.4555.10.camel@mhfsdcap03>
References: <cover.1423226542.git.robin.murphy@arm.com>
 <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
 <1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>
 <1423901011.27922.7.camel@mhfsdcap03> <54E24D50.408@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54E24D50.408@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "ritesh.harjani@gmail.com" <ritesh.harjani@gmail.com>, "lauraa@codeaurora.org" <lauraa@codeaurora.org>, "arnd@arndb.de" <arnd@arndb.de>, "stefano.stabellini@eu.citrix.com" <stefano.stabellini@eu.citrix.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, Will Deacon <Will.Deacon@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "josephl@nvidia.com" <josephl@nvidia.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-02-16 at 20:04 +0000, Robin Murphy wrote:

> >       2)int (*domain_init)(struct iommu_domain *domain);
> >         About this function, it will alloc pagetable for the iommu
> > domain. And We expect the pagetable memory is uncacheable, so try to
> > call "dma_alloc_coherent", unfortunately the "struct device *" can't be
> > passed into this function. so is it possible if adding a parameter in
> > this function.
> 
> ...one of the ideas of the new of_iommu_configure framework is that 
> iommu_ops structures can represent individual IOMMU devices if 
> necessary. The ops->priv pointer was included for that purpose, but 
> isn't very clean so Will has plans to remove it again - it's easy enough 
> to achieve the same effect by having the driver embed the ops in its 
> private instance data instead. I've done that with the ARM SMMU driver 
> which has a similar issue of needing hardware details at domain_init() 
> time (no patches ready yet but I have an iommu/dev branch on top of the 
> iommu/dma branch with some current work-in-progress bits)
> 
> Thanks,
> Robin.
> 
Dear Robin,
        Thanks very much for your suggestion.

        I have a more question: how to do cache maintenance in arm64.

        a) "__dma_flush_range" can not be expected to used directly.
        b) Following Documentation\DMA-API.txt, section: Streaming DMA
mappings. dma_map_single should be used, But I am not sure how to pass
the first "struct device *".
         We have a device which call arch_setup_dma_ops to create the
iommu domain, if we use this device, it will enter __iommu_map_page;
        If we input NULL for dmap_map_single, it will assert at
dma_capable in swiotlb_map_page...

        And normally, we always need do cache maintenance only for some
bytes in the pagetable but not whole a page. Then is there a easy way to
do the cache maintenance?
