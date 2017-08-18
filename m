From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Avoid NULL group dereference
Date: Fri, 18 Aug 2017 11:42:09 +0200
Message-ID: <20170818094209.GA16257@8bytes.org>
References: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
 <20170817154101.GL16908@8bytes.org>
 <eef03509-2b1f-0e49-4e47-84e968a07746@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eef03509-2b1f-0e49-4e47-84e968a07746@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, shawn.lin@rock-chips.com, marc.zyngier@arm.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 05:56:23PM +0100, Robin Murphy wrote:
> On 17/08/17 16:41, Joerg Roedel wrote:
> > Okay, so just to check I got it right: Drivers do the above to check
> > whether a device is managed by an IOMMU, and that crashes now because
> > the 'group == NULL' check was removed?
> 
> Indeed - the typical context is network descriptors that don't have
> space to store the CPU virtual address of the buffer, so when a packet
> arrives the driver has to work backwards from the DMA address, in this
> sort of pattern:
> 
> 	addr = desc[idx]->addr;
> 	domain = iommu_get_domain_for_dev(dev);
> 	if (domain)
> 		addr = iommu_iova_to_phys(domain, addr)
> 	buf = phys_to_virt(addr)
> 
> (the GIC thing is similar but in reverse, with a physical address which
> may or may not need replacing with an IOVA). Unless we were to change
> the interface to be iommu_get_domain_for_group(), I think it makes sense
> for it to remain valid to call for any device.

Okay, we should find a better solution for this at some point, but I
applied the patch for now.


	Joerg
