From: "Raj, Ashok" <ashok.raj-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 22 Oct 2018 03:07:43 -0700
Message-ID: <20181021194426.GA11201@araj-mobl1.jf.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 19, 2018 at 07:11:52PM +0100, Jean-Philippe Brucker wrote:
> This is a first prototype adding auxiliary domain support to Arm SMMUv3,
> following Lu Baolu's latest proposal for IOMMU aware mediated devices
> [1]. It works, but the attach() API still doesn't feel right. See (2)
> below.
> 
> Patch 1 adapts iommu.c to the current proposal for auxiliary domains.
> Patches 2-4 rework the PASID allocator to make it usable for SVA and
> AUXD simultaneously. Patches 5-6 add AUXD support to SMMUv3.
> 
> 
> When a device can have multiple address space, for instance with PCI
> PASID, an auxiliary domain (AUXD) is the IOMMU representation of one
> address space. I distinguish auxiliary from "main" domain, which
> represents the non-PASID address space but also (at least for SMMUv3)
> the whole device context, PASID tables etc.
> 
> Auxiliary domains will be used by VFIO for IOMMU-aware mdev, and by any
> other device driver that wants to use PASID for private address spaces
> (as opposed to SVA [2]). The following API is available to device
> drivers:
> 
> (1) Enable AUXD for a device. Enable PASID if necessary and set an AUXD
>     flag on the IOMMU data associated to a device.
> 
>     For my own convenience I've been using the SVA infrastructure since
>     I already had the locking and IOMMU ops in place. The proposed
>     interface is also missing min_pasid and max_pasid parameters, which
>     could be needed by device drivers to enforce PASID limits.

Variable PASID limits per-device is hard to manage. I suppose we can play
some games to get this right, but I suspect that wont be very useful in 
the long run.

#1: Given that PASID is a system wide resource, during boot iommu driver needs 
to scan and set the max PASID to be no more than min(iommu_supported_max_pasid) 
of all available IOMMU's. 

#2: In addition if any device supports less than the choosen system max PASID
we should simply disable PASID on that device.

The reason is if the process were to bind to 2 or more accelerators and
the second device has a limit smaller than the first that the application
already attached, the second attemt to bind would fail. (Because
we would use the same PASID for a single process)

In addition for Intel IOMMU's PASID is a system wide resource. We have
a virtual capability for vIOMMU's to allocate PASID's. At the time of
allocation we don't know what device this PASID is even being allocated 
for. Certainly we could add other intelligence to pass a hint for 
max_pasid in the virtiual interface. 

I suppose when this becomes real, most serious accelerators will 
support the full width. Hence doing #1 and #2 above should be good
for most cases.

Cheers,
Ashok
