From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
        traffic
Date: Fri, 20 Oct 2017 18:17:19 +0200
Message-ID: <20171020161719.GA6247@lst.de>
References: <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com> <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com> <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com> <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com> <20171020145752.GA4694@lst.de> <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Linux-MIPS <linux-mips@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foun
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 20, 2017 at 11:27:41AM -0400, Jim Quinlan wrote:
>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> 
> This leaves a one-page gap between phsyical memory regions which would
> normally be contiguous. One cannot have a dma alloc that spans any two
> regions.  This is a drastic step, but I don't see an alternative.
> Perhaps  I may be missing what you are saying...

Ok, IFF we are guranteed to always have a gap between physical memory
locations we are fine indeed.
