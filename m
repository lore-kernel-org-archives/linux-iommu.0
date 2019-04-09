From: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Date: Tue, 9 Apr 2019 15:31:58 +0200
Message-ID: <20190409133157.GA10876@lst.de>
References: <20190408105525.5493-1-hch@lst.de> <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com> <20190409095740.GE6827@lst.de> <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Singh Rawat <drawat@vmware.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 01:04:51PM +0000, Thomas Hellstrom wrote:
> On the VMware platform we have two possible vIOMMUS, the AMD iommu and
> Intel VTD, Given those conditions I belive the patch is functionally
> correct. We can't cover the AMD case with intel_iommu_enabled.
> Furthermore the only form of incoherency that can affect our graphics
> device is someone forcing SWIOTLB in which case that person would be
> happier with software rendering. In any case, observing the fact that
> the direct_ops are not used makes sure that SWIOTLB is not used.
> Knowing that we're on the VMware platform, we're coherent and can
> safely have the dma layer do dma address translation for us. All this
> information was not explicilty written in the changelog, no.

We have a series pending that might bounce your buffers even when
using the Intel IOMMU, which should eventually also find its way
to other IOMMUs:

    https://lists.linuxfoundation.org/pipermail/iommu/2019-March/034090.html

> In any case, assuming that that patch is reverted due to the layering
> violation, Are you willing to help out with a small API to detect the
> situation where streaming DMA is incoherent?

The short but sad answer is that we can't ever guarantee that you
can skip the dma_*sync_* calls.  There are too many factors in play
that might require it at any time - working around unaligned addresses
in iommus, CPUs that are coherent for some device and not some, addressing
limitations both in physical CPUs and VMs (see the various "secure VM"
concepts floating around at the moment).

If you want to avoid the dma_*sync_* calls you must use
dma_alloc_coherent to allocate the memory.  Note that the memory for
dma_alloc_coherent actually comes from the normal page pool most of
the time, and for certain on x86, which seems to be what you care
about.  The times of it dipping into the tiny swiotlb pool are long
gone.  So at least for you I see absolutely no reason to not simply
always use dma_alloc_coherent to start with.  For other uses that
involve platforms without DMA coherent devices like arm the tradeoffs
might be a little different.
