From: Jim Quinlan <jim2101024-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
Date: Wed, 18 Oct 2017 10:41:17 -0400
Message-ID: <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
	<1507761269-7017-6-git-send-email-jim2101024@gmail.com>
	<589c04cb-061b-a453-3188-79324a02388e@arm.com>
	<20171017081422.GA19475@lst.de>
	<CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
	<20171018065316.GA11183@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171018065316.GA11183-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 18, 2017 at 2:53 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> On Tue, Oct 17, 2017 at 12:11:55PM -0400, Jim Quinlan wrote:
>> My understanding is that dma_pfn_offset is that it is a single
>> constant offset from RAM, in our case, to map to PCIe space.
>
> Yes.
>
>> But in
>> my commit message I detail how our PCIe controller presents memory
>> with multiple regions with multiple different offsets. If an EP device
>> maps to a region on the host memory, yes we can set the dma_pfn_offset
>> for that device for that location within that range,.  But if the
>> device then unmaps and allocates from another region with a different
>> offset, it won't work.  If  I set dma_pfn_offset I have to assume that
>> the device is using only one region of memory only, not more than one,
>> and that it is not unmapping that region and mapping another (with a
>> different offset).  Can I make those assumptions?
>
> No, we can't make that assumption unfortunately.  But how is your
> code going to work if the mapping spans multiple of your translation
> regions?

That's what brcm_to_{pci,cpu} are for -- they keep a list of the
dma-ranges given in the PCIe DT node, and translate from system memory
addresses to pci-space addresses, and vice versa.  As long as people
are using the DMA API it should work.  It works for all of the ARM,
ARM64, and MIPS Broadcom systems I've tested, using eight different EP
devices.  Note that I am not thrilled to be advocating this mechanism
but it seemed the best alternative.

>memorymaintiners
> Also I really don't think the stacking of dma_ops as in this patch
> is a good idea.  For MIPS you should do the variant suggested in
> the patch description and hook into dma_to_phys/phys_to_dma helpers,
> and for ARM/ARM64 you should talk to the maintainers on how they
> want the translation integrated.

I would prefer that the same code work for all three architectures.
What I would like from ARM/ARM64 is the ability to override
phys_to_dma() and dma_to_phys(); I thought the chances of that being
accepted would be slim.  But you are right, I should ask the
maintainers.
