From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus
 dma_sync_single_for_device call
Date: Mon, 11 Feb 2019 14:12:43 +0100
Message-ID: <20190211131243.GA21917@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com> <20190201161026.GE6532@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201161026.GE6532@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 05:10:26PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > 
> > > dma_map_single already transfers ownership to the device.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Do you want me to take the USB bits or will you take the entire series?
> > In case you're taking the entire series:
> 
> If you want to take the USB feel free.  I just want most of this in
> this merge window if possible.

I didn't see in the USB tree yet, so please let me know if you want to
take it.
