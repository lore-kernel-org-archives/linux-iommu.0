From: Christoph Hellwig <hch@lst.de>
Subject: Re: use the generic dma-noncoherent code for microblaze
Date: Fri, 20 Jul 2018 15:26:12 +0200
Message-ID: <20180720132612.GA15416@lst.de>
References: <20180719125440.424-1-hch@lst.de> <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 20, 2018 at 02:33:44PM +0200, Michal Simek wrote:
> Hi,
> 
> On 19.7.2018 14:54, Christoph Hellwig wrote:
> > Hi Michal,
> > 
> > can you review these patches to switch microblaze to use the generic
> > dma-noncoherent code?  All the requirements are in mainline already
> > and we've switched various architectures over to it already.
> > 
> 
> I can't see any issue with them.
> Both applied to next.

!
