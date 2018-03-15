From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/14] x86: use dma-direct
Date: Thu, 15 Mar 2018 13:53:52 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803151352170.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de> <20180314175213.20256-4-hch@lst.de> <alpine.DEB.2.21.1803150951540.1525@nanos.tec.linutronix.de> <20180315115348.GA16210@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1111037880-1521118432=:1525"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315115348.GA16210@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw2@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1111037880-1521118432=:1525
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Mar 2018, Christoph Hellwig wrote:

> On Thu, Mar 15, 2018 at 09:56:13AM +0100, Thomas Gleixner wrote:
> > On Wed, 14 Mar 2018, Christoph Hellwig wrote:
> > 
> > > The generic dma-direct implementation is now functionally equivalent to
> > > the x86 nommu dma_map implementation, so switch over to using it.
> > 
> > Can you please convert the various drivers first and then remove the
> > unused code?
> 
> Which various drivers?
> 
> > > Note that the various iommu drivers are switched from x86_dma_supported

The various iommu drivers ....

> > > to dma_direct_supported to provide identical functionality, although the
> > > checks looks fairly questionable for at least some of them.
> > 
> > Can you please elaborate? From the above it's not clear which checks you
> > are referring to. If you convert these drivers seperately then explicit
> > information about your concerns wants to be in the changelogs.
> 
> This bit:
> 
> 	/* Copied from i386. Doesn't make much sense, because it will
> 	   only work for pci_alloc_coherent.
> 	   The caller just has to use GFP_DMA in this case. */
> 	if (mask < DMA_BIT_MASK(24))
> 		return 0;
> 
> in x86_dma_supported, or the equivalent bit in dma_direct_supported.
> Kept for bug to bug compatibility, but I guess I should reword or
> just drop the changelog bit іf it causes confusion.

Reword please.

Thanks,

	tglx

--8323329-1111037880-1521118432=:1525--
