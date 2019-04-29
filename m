From: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Mon, 29 Apr 2019 13:17:44 +0100
Message-ID: <CAPL0++7G4zNp76z_8bzV84ky2vXeoX2jTCLSCC-CCWZMgwP5Pw@mail.gmail.com>
References: <20190424165051.13614-1-tmurphy@arista.com> <20190426140429.GG24576@8bytes.org>
 <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com> <20190429115916.GA5349@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429115916.GA5349@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, James Sewart <jamessewart@arista.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 12:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 27, 2019 at 03:20:35PM +0100, Tom Murphy wrote:
> > I am working on another patch to improve the intel iotlb flushing in
> > the iommu ops patch which should cover this too.
>
> So are you looking into converting the intel-iommu driver to use
> dma-iommu as well?  That would be great!

Yes. My patches depend on the "iommu/vt-d: Delegate DMA domain to
generic iommu" patch which is currently being reviewed.
