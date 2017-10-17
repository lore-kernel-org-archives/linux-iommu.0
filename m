From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
        traffic
Date: Tue, 17 Oct 2017 10:14:22 +0200
Message-ID: <20171017081422.GA19475@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com> <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <589c04cb-061b-a453-3188-79324a02388e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Just took a quick look over this and I basically agree with the comments
from Robin.

What I don't understand is why you're even trying to do all these
hacky things.

It seems like the controller should simply set dma_pfn_offset for
each device hanging off it, and all the supported architectures
should be updated to obey that if they don't do so yet, and
you're done without needing this giant mess.
