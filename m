From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
Date: Thu, 19 Oct 2017 11:16:44 +0200
Message-ID: <20171019091644.GA14983@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
	<1507761269-7017-6-git-send-email-jim2101024@gmail.com>
	<589c04cb-061b-a453-3188-79324a02388e@arm.com>
	<20171017081422.GA19475@lst.de>
	<CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
	<20171018065316.GA11183@lst.de>
	<CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jim Quinlan <jim2101024-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 18, 2017 at 10:41:17AM -0400, Jim Quinlan wrote:
> That's what brcm_to_{pci,cpu} are for -- they keep a list of the
> dma-ranges given in the PCIe DT node, and translate from system memory
> addresses to pci-space addresses, and vice versa.  As long as people
> are using the DMA API it should work.  It works for all of the ARM,
> ARM64, and MIPS Broadcom systems I've tested, using eight different EP
> devices.  Note that I am not thrilled to be advocating this mechanism
> but it seemed the best alternative.

Say we are using your original example ranges:

 memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
 memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
 memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
 memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
 memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
 memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

and now you get a dma mapping request for physical addresses
3fffff00 to 4000000f, which would span two of your ranges.  How
is this going to work?

> I would prefer that the same code work for all three architectures.
> What I would like from ARM/ARM64 is the ability to override
> phys_to_dma() and dma_to_phys(); I thought the chances of that being
> accepted would be slim.  But you are right, I should ask the
> maintainers.

It is still better than trying to stack dma ops, which is a receipe
for problems down the road.
