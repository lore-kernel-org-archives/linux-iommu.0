From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
Date: Tue, 25 Sep 2018 22:16:19 +0200
Message-ID: <20180925201619.GB8413@lst.de>
References: <20180827084711.23407-1-hch@lst.de> <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180922150119.GA14761@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

Looking at the code I think this commit is simply broken for
architectures not using arch_setup_dma_ops, but instead setting up
the dma ops through arch specific magic.

I'll revert the patch.
