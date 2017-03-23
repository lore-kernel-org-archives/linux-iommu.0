From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a
 task
Date: Thu, 23 Mar 2017 15:30:14 +0100
Message-ID: <20170323143014.GK7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 23, 2017 at 01:37:41PM +0000, Jean-Philippe Brucker wrote:
> On 22/03/17 22:53, Joerg Roedel wrote:
> > That can't happen, when the device driver does its job right. It has to
> > shut down the context which causes the PPR requests for the PASID on the
> > device. This includes stopping the context and waiting until all PPR
> > requests it sent are processed.
> 
> By "processed", do you mean that they are committed to the IOMMU, or that
> they came back with a PRG response?

By processed I mean the device received a response to the request, or is
at least no longer waiting for responses.

> The driver might not be able to do the latter, since PCI defines two ways
> of shutting down a context:
> 
> * Either wait for all PPR requests to come back with a PRG response,
> * Or send a Stop Marker PPR request and forget about it.

Are you sure about the meaning of the stop-marker? Can you point me to
where it is specified?

I know about a different marker, which allows a device to issue several
PPR requests and only get one response for all of them. The last request
then has that marker set.

But I am not aware (yet) of a marker with which the device says it no
longer sends requests with this PASID.

> My intent with passing flags to unbind() was to handle the case where VFIO
> is unable to tell us whether PPRs are still being issued by the device.
> But the issue seems moot to me now that I have a better understanding, as
> there will be a detach_dev/attach_dev sequence before we start rebinding
> PASIDs, and we can simply reset the PRI interface there (I'm currently
> doing that in add_device, but I should move it.)

VFIO should completly reset the device before it is re-used, so I don't
think we run into problems there.



	Joerg
