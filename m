From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: dma mask related fixups (including full bus_dma_mask support) v2
Date: Tue, 02 Oct 2018 06:51:23 +1000
Message-ID: <7b94786fb357c70f905a90f9172ab984418271ce.camel@kernel.crashing.org>
References: <20180927223539.28449-1-hch@lst.de>
         <20181001143259.GA5655@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001143259.GA5655@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-10-01 at 16:32 +0200, Christoph Hellwig wrote:
> FYI, I've pulled this into the dma-mapping tree to make forward
> progress.  All but oatch 4 had formal ACKs, and for that one Robin
> was fine even without and explicit ack.  I'll also send a patch to
> better document the zone selection as it confuses even well versed
> people like Ben.

Thanks. I"ll try to dig out some older systems to test.

Cheers,
Ben.
