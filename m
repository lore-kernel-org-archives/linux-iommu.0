From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 22 Oct 2018 17:03:30 +0100
Message-ID: <d45c5222-68e9-1d6e-730b-bb8dbc060586@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181021194426.GA11201@araj-mobl1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181021194426.GA11201-7RUrO8UaCDyr4tA6zuQqW9h3ngVCH38I@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22/10/2018 11:07, Raj, Ashok wrote:
>>     For my own convenience I've been using the SVA infrastructure since
>>     I already had the locking and IOMMU ops in place. The proposed
>>     interface is also missing min_pasid and max_pasid parameters, which
>>     could be needed by device drivers to enforce PASID limits.
> 
> Variable PASID limits per-device is hard to manage. I suppose we can play
> some games to get this right, but I suspect that wont be very useful in 
> the long run.

Devices may have PASID limits that are not discoverable with the PCI
PASID capability (https://patchwork.kernel.org/patch/9989307/#21389571).
Even if we simply reject devices that don't support enough PASIDs, I
think it's still better to return an error on bind or init_device than
to return a valid PASID that they can't use

> #1: Given that PASID is a system wide resource, during boot iommu driver needs 
> to scan and set the max PASID to be no more than min(iommu_supported_max_pasid) 
> of all available IOMMU's. 
> 
> #2: In addition if any device supports less than the choosen system max PASID
> we should simply disable PASID on that device.
> 
> The reason is if the process were to bind to 2 or more accelerators and
> the second device has a limit smaller than the first that the application
> already attached, the second attemt to bind would fail. (Because
> we would use the same PASID for a single process)

But that's not reason enough to completely disable PASID for the device,
it could be the only one bound to that process, or PASID could be only
used privately by the host device driver.

> In addition for Intel IOMMU's PASID is a system wide resource. We have
> a virtual capability for vIOMMU's to allocate PASID's. At the time of
> allocation we don't know what device this PASID is even being allocated 
> for. 

Ah, I had missed that part, I thought the PV allocation had the device
ID as well. That's a significant change.

I was still hoping that we could go back to per-device PASID spaces in
the host, since I still haven't seen any convincing argument in favor of
system-wide PASID. Get rid of #1 in order to solve #2, and as a bonus
support more PASIDs in total. Until now PASID was a per-device resource
except for choices made when writing the IOMMU driver.

> Certainly we could add other intelligence to pass a hint for 
> max_pasid in the virtiual interface. 
> 
> I suppose when this becomes real, most serious accelerators will 
> support the full width.

I don't know if that's obvious from the device perspective. If I had to
implement one, I would simply size my PASIDs to the number of contexts
supported by my device (which might be especially small in the embedded
space), given that technically nothing prevents software from supporting
that and the specification allows me to choose a width.

This was the intended model for PCI, but thankfully version 4.0 added an
implementation note (6.20.2.1 - PASID Field) advising against this
approach, and to instead support 20 bits for interoperability. Maybe it
will set a trend for non-PCI devices as well.

Thanks,
Jean
