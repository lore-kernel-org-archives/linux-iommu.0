From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a
 task
Date: Thu, 23 Mar 2017 17:52:18 +0100
Message-ID: <20170323165218.GL7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
 <20170323145311.GA22972@e106794-lin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323145311.GA22972@e106794-lin.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 23, 2017 at 03:52:14PM +0000, Jean-Philippe Brucker wrote:
> On 23/03/17 14:30, Joerg Roedel wrote:
> > Are you sure about the meaning of the stop-marker? Can you point me to
> > where it is specified?
> 
> The concept is introduced in the PCI ECN that adds PASIDs to the ATS
> specification. I have the following link, which is probably behind a
> wall:
> 
> https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf
> 
> A Stop Marker is a PPR with flags Read=Write=0, Last=1, targeting the
> PASID that is being decommissioned. In section 4.1.2, the specifications
> details the two device-specific ways of stopping use of a PASID, with or
> without a Stop Marker. When done with a Stop Marker, the function doesn't
> have to wait for any outstanding PPR to return, the Stop Marker serves as
> a PASID barrier.

Thanks for that, I have a closer look. Is that stopper packet visible to
software (e.g. is an entry created in the queue)?

I have to check whether the AMD IOMMU makes this visible.



	Joerg
