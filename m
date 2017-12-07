From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Thu, 7 Dec 2017 14:56:41 -0700
Message-ID: <20171207145641.50830562@t450s.home>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
        <20171204133715.50c45136@jacob-builder>
        <a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
        <20171206112521.1edf8e9b@jacob-builder>
        <39fcbbd2-2e6a-f05a-8cb4-8e3ad4ead369@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39fcbbd2-2e6a-f05a-8cb4-8e3ad4ead369@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Jean Delvare <khali@linux-fr.org>, Will Deacon <Will.Deacon@arm.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 7 Dec 2017 12:56:55 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 06/12/17 19:25, Jacob Pan wrote:
> [...]
> >>   For SMMUv3, the stall buffer may be shared between devices on some
> >>   implementations, in which case the guest could prevent other
> >> devices to stall by letting the buffer fill up.  
> >>   -> We might have to keep track of stalls in the host driver and set  
> >> a credit or timeout to each stall, if it comes to that.  
> >>   -> In addition, send a terminate-all-stalls command when changing  
> >> the device's domain.
> >>  
> > We have the same situation in VT-d with shared queue which in turn may
> > affect other guests. Letting host driver maintain record of pending page
> > request seems the best way to go. VT-d has a way to drain PRQ per PASID
> > and RID combination. I guess this is the same as your
> > "terminate-all-stalls" but with finer control? Or
> > "terminate-all-stalls" only applies to a given device.  
> 
> That command terminates all stalls for a given device (for all PASIDs).
> It's a bit awkward to implement but should be enough to ensure that we
> don't leak any outstanding faults to the next VM.
> 
> > Seems we can implement a generic timeout/credit mechanism in IOMMU
> > driver with model specific action to drain/terminate. The timeout value
> > can also be model specific.  
> 
> Sounds good. Timeout seems a bit complicated to implement (and how do we
> guess what timeout would work?), so maybe it's simpler to enforce a quota
> of outstanding faults per VM, for example half of the shared queue size
> (the number can be chosen by the IOMMU driver). If a VM has that many
> outstanding faults, then any new fault is immediately terminated by the
> host. A bit rough but it might be enough to mitigate the problem
> initially, and we can always tweak it later (for instance disable faulting
> if a guest doesn't ever reply).
> 
> Seems like VFIO should enforce this quota, since the IOMMU layer doesn't
> know which device is assigned to which VM. If it's the IOMMU that enforces
> quotas per device and a VM has 15 devices assigned, then the guest can
> still DoS the IOMMU.

VFIO also doesn't know about VMs.  We know that devices attached to the
same container are probably used by the same user, but once we add
viommu, each device(group) uses its own container and we have no idea
they're associated.  So, no to VM based accounting, and it seems like
an IOMMU problem, X number of outstanding requests per device.  Thanks,

Alex
