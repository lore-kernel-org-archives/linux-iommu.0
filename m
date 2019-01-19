From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
Date: Sat, 19 Jan 2019 11:46:22 -0700
Message-ID: <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
References: <20190119000559.12784-1-logang@deltatee.com>
 <20190119094002.GA21653@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119094002.GA21653@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-19 2:40 a.m., Christoph Hellwig wrote:
> Which resources do you plan to map?  At least for PCIe P2P adding
> an address translation seems wrong to me.

It's mapping a PCI BAR but not for PCIe P2P. In this case, we are using
the Intel I/OAT DMA engine to copy data from a PCI BAR to/from memory. See:

http://lkml.kernel.org/r/20190119001001.13087-1-logang@deltatee.com

>>
>> The implementation for intel_map_resource() is nearly identical to
>> intel_map_page(), we just have to re-create __intel_map_single().
>> dma_unmap_resource() uses intel_unmap_page() directly as the
>> functions are identical.
> 
> Instead of having two tiny wrappers I'd just revert
> 964f2311a6862f1fbcc044d0828ad90030928b7f if we need to pass a real
> physical address now.

Ok, I can resubmit this with that cleanup. Should I do it in two commits
(1 revert + 1 new) or is one commit that just restores the original
helper fine?

Thanks,

Logan
