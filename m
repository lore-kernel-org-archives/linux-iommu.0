From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
        traffic
Date: Fri, 20 Oct 2017 16:57:52 +0200
Message-ID: <20171020145752.GA4694@lst.de>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com> <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com> <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com> <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Linux-MIPS <linux-mips@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foun
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
> I am not sure I understand your comment -- the size of the request
> shouldn't be a factor.  Let's look at your example of the DMA request
> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
> what is available, there is no 15 page span that can happen across the
> 0x40000000 boundary.  For SG, there can be no merge that connects a
> page from one region to another region.  Can you give an example of
> the scenario you are thinking of?

What prevents a merge from say the regions of
0....3fffffff and 40000000....7fffffff?
