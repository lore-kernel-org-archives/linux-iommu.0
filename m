From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a
 task
Date: Thu, 23 Mar 2017 13:37:41 +0000
Message-ID: <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170322225320.GF7266@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/03/17 22:53, Joerg Roedel wrote:
> On Wed, Mar 22, 2017 at 06:31:01PM +0000, Jean-Philippe Brucker wrote:
>> The problem might be too tied to the specifics of the SMMU. As implemented
>> in this series, the normal flow for a PPR with the SMMU is the following:
>>
>> (1) PCI device issues a PPR for PASID 1
>> (2) The PPR is queued by the SMMU in the (hardware) PRI queue
>> (3) The SMMU driver receives an interrupt, dequeues the PPR and moves it
>>     to a software work queue.
>> (4) The PPR is finally handled and a PRI response is sent to the device.
> 
> There are two ways a PASID could get shut down:
> 
> 	1) The device driver calls unbind()
> 	2) The mm_struct bound to that PASID is going away
> 
> Case 1) is the easy one, we can safely assume that the device driver did
> anything to stop new PPR requests from being created for that PASID. In
> this case we just shut down PPR processing by waiting until everything
> is handled and reply INVALID to any further PPR request before we remove
> the PASID from the per-device IOMMU data structures and flush caches.
> 
> In case 2) we have more work to do. The mm_struct is going away
> (probably because the task segfaulted) and we can't assume that the
> device driver shut everything down already. But for this case we have
> the call-back into the device driver to tell it should clean everything
> up for that PASID and stop the device from creating further requests.
> 
> After that call-back returns it is the same as in case 1), we drain the
> queue and deny any further request that comes in.

I agree on the semantics (I didn't implement case 2) here but I will have
to in the next version.)

>> The case that worries me is if someone unbinds PASID 1 between (2) and
>> (3), while the PPR is still in the hardware queue, and immediately binds
>> it to a new address space.
>>
>> Then (3) and (4) happen, the PPR is handled and the fault is for the new
>> address space. It's certainly undesirable, but I don't know if it could be
>> exploited. We don't kill the task for an unhandled fault at the moment,
>> simply report a failed PPR to the device, so I might be worrying for nothing.
> 
> As I wrote above, when the device driver calls unbind() we should
> assume that the device does not sent any further requests with that
> PASID. If it does, we just answer with INVALID.
> 
>> Having the caller tell us if PPRs might still be pending in the hardware
>> PRI queue ensures that the SMMU driver waits until it's entirely safe:
>>
>> * If the device has no outstanding PPR, PASID can be reallocated
>> * If the device has outstanding PPRs, wait for a Stop Marker, or drain
>>   the PRI queue after a while (if the Stop Marker was lost in a PRI queue
>>   overflow).
> 
> That can't happen, when the device driver does its job right. It has to
> shut down the context which causes the PPR requests for the PASID on the
> device. This includes stopping the context and waiting until all PPR
> requests it sent are processed.

By "processed", do you mean that they are committed to the IOMMU, or that
they came back with a PRG response?

The driver might not be able to do the latter, since PCI defines two ways
of shutting down a context:

* Either wait for all PPR requests to come back with a PRG response,
* Or send a Stop Marker PPR request and forget about it.

The second one is problematic, all the device says is "I've stopped
sending requests, some might still be in flight, but a Stop Marker ends
the flow".

Without having the device driver tell us which of the two models the
device is implementing, draining the hardware queue is our best bet to
ensure that no request is pending.

In any case, this is a property of the device, and passing flags to
unbind() as I suggested is probably excessive. The IOMMU driver could
store that info somewhere and use it whenever it has to unbind(), as an
indication of the minimum amount of work required to clean the context.
Without this hint the default should be to drain both queues.

My intent with passing flags to unbind() was to handle the case where VFIO
is unable to tell us whether PPRs are still being issued by the device.
But the issue seems moot to me now that I have a better understanding, as
there will be a detach_dev/attach_dev sequence before we start rebinding
PASIDs, and we can simply reset the PRI interface there (I'm currently
doing that in add_device, but I should move it.)

> And the device driver has to do this either before it calls unbind() or
> in the call-back it provided. Only after this the PASID should be freed.
>
>> Draining the PRI queue is very costly, we need to block the PRI thread to
>> inspect the queue, risking an overflow. And with these PASID state flags
>> we avoid flushing any queue.
> 
> There is a configurable maximum of PPR requests a device can have
> in-flight. If you take that into account when allocation the PPR queue
> for the SMMU, there can't be any overflows. The AMD driver allocates a
> queue for 512 entries and allows devices to have a maximum of 32
> outstanding requests.

Yes, the SMMU specification also tells that over-committing the PPR queue
is a programming error. I wonder how well it scales with hot-plugging of
devices however. At the time when we start allocating PPR credits, we
might not be sure that the number of devices with a PRI will be limited to
16. So even if overflow is a programming error, I'm not comfortable with
ruling it out just yet.

Thanks,
Jean-Philippe

>> But since the problem seems too centered around the SMMU, I might just
>> drop this patch along with the CLEAN/FLUSHED flags in my next version, and
>> go with the full-drain solution. After all, unbind should be a fairly rare
>> event.
> 
> I don't think all this is SMMU specific, it is the same on all other
> IOMMUs that have the ATS/PRI/PASID features.
> 
> 
> 
> 	Joerg
> 
