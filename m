From: Joerg Roedel <joro@8bytes.org>
Subject: Re: per-device dma_map_ops for intel-iommu?
Date: Thu, 11 Apr 2019 15:57:49 +0200
Message-ID: <20190411135749.GE4518@8bytes.org>
References: <20190409135924.GA11431@lst.de>
 <b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 05:03:52PM +0300, David Woodhouse wrote:
> On Tue, 2019-04-09 at 15:59 +0200, Christoph Hellwig wrote:
> > Hi David and Joerg,
> > 
> > do you remember a good reason why intel-iommu is not using per-device
> > dma_map_ops like the AMD iommu or the various ARM iommus?
> > 
> > Right now intel-iommu.c contains a half-asses reimplementation of the
> > dma direct code for the iommu_no_mapping() case, and it would seem
> > much nicer to just fall back to that case and not even call into
> > intel-iommu in that case.
> 
> Other than the complexities about passthrough mode and various "oh shit
> we forgot to actually test that iommu+gfx actually works before
> shipping hardware" type of quirks that bypass the IOMMU for certain
> devices — and retpolines, which I think you already dealt with — no, no
> good reason that I recall.

Same here, I looked into this in the past as well, but I can't recall
any reason this was left in place.


	Joerg
