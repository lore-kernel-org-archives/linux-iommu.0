From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 07/20] iommu/amd: Remove special mapping code for dma_ops
 path
Date: Tue, 12 Jul 2016 12:42:59 +0100
Message-ID: <5784D7C3.4010104@arm.com>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
 <1467978311-28322-8-git-send-email-joro@8bytes.org>
 <5784CCAB.8000007@arm.com> <20160712110839.GF12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160712110839.GF12639@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 12/07/16 12:08, Joerg Roedel wrote:
> Hi Robin,
> 
> On Tue, Jul 12, 2016 at 11:55:39AM +0100, Robin Murphy wrote:
>>>  	start = address;
>>>  	for (i = 0; i < pages; ++i) {
>>> -		ret = dma_ops_domain_map(dma_dom, start, paddr, dir);
>>> -		if (ret == DMA_ERROR_CODE)
>>> +		ret = iommu_map_page(&dma_dom->domain, start, paddr,
>>> +				     PAGE_SIZE, prot, GFP_ATOMIC);
>>
>> I see that amd_iommu_map/unmap() takes a lock around calling
>> iommu_map/unmap_page(), but we don't appear to do that here. That seems
>> to suggest that either one is unsafe or the other is unnecessary.
> 
> At this point no locking is required, because in this code path we know
> that we own the memory range and that nobody else is mapping that range.
> 
> In the IOMMU-API path we can't make that assumption, so locking is
> required there. Both code-path use different types of domains, so there
> is also no chance that a domain is used in both code-paths (except when
> a dma-ops domain is set up).

Ah, that's the angle I was missing, yes. So if, say, someone is mapping
a page at IOVA 0x0000 while someone else is mapping a page at 0x1000,
there could still be a race between both callers writing the non-leaf
PTEs, but it's benign since they'd be writing identical entries anyway.
Seems reasonable to me (I assume in a similar map vs. unmap race, the
unmapper would just be removing the leaf entry, rather than bothering to
check for empty tables and tear down intermediate levels, so the same
still applies).

Robin.

> 
> 
> 	Joerg
> 
