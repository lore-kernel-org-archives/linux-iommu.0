From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
Date: Wed, 26 Sep 2018 14:20:19 +1000
Message-ID: <87r2hgga9o.fsf@concordia.ellerman.id.au>
References: <20180827084711.23407-1-hch@lst.de> <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net> <20180925201619.GB8413@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925201619.GB8413@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

Christoph Hellwig <hch@lst.de> writes:

> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.

I arch_setup_dma_ops() called from of_dma_configure(), but
pci_dma_configure() doesn't call that for this device:

static int pci_dma_configure(struct device *dev)
{
	...
	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
	    bridge->parent->of_node) {
		ret = of_dma_configure(dev, bridge->parent->of_node, true);

bridge->parent is NULL.

So I don't think arch_setup_dma_ops() would help here?

> I'll revert the patch.

Thanks.

cheers
