From: Christoph Hellwig <hch@lst.de>
Subject: Re: dma mask related fixups (including full bus_dma_mask support)
 v2
Date: Mon, 1 Oct 2018 16:32:59 +0200
Message-ID: <20181001143259.GA5655@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927223539.28449-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

FYI, I've pulled this into the dma-mapping tree to make forward
progress.  All but oatch 4 had formal ACKs, and for that one Robin
was fine even without and explicit ack.  I'll also send a patch to
better document the zone selection as it confuses even well versed
people like Ben.
