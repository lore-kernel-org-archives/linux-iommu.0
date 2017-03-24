From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a
 task
Date: Fri, 24 Mar 2017 19:08:47 +0000
Message-ID: <7386120a-2848-059f-4de0-7888a2698923@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
 <20170323145311.GA22972@e106794-lin.localdomain>
 <20170323165218.GL7266@8bytes.org>
 <9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
 <20170324110045.GM7266@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170324110045.GM7266@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 24/03/17 11:00, Joerg Roedel wrote:
> On Thu, Mar 23, 2017 at 05:03:46PM +0000, Jean-Philippe Brucker wrote:
>> On 23/03/17 16:52, Joerg Roedel wrote:
>>> Thanks for that, I have a closer look. Is that stopper packet visible to
>>> software (e.g. is an entry created in the queue)?
>>
>> As far as I understand, it should be added to the queue like a normal PPR,
>> and software should check the R/W/L flags combination. For SMMU at least,
>> it is the same. The only difference is that when the PRI queue overflows,
>> the SMMU would discard a Stop Marker instead of sending an automated
>> response to the device (as it would do with others PPR that have the L
>> flag.) Software shouldn't send a response to a Stop Marker either.
> 
> The document you posted is an addition to the spec, so we can't rely on
> a stop marker being sent by a device when it shuts down a context.
> Current AMD GPUs don't send one, afaik.

Fair enough, though on the SMMU side we still don't know which shutdown
model hardware vendors are more likely to choose. Devices could use the
stop marker and never wait for completion of PPRs. In that case context
shutdown would only have to make sure that PPRs are outside the PCI
network, return immediately and allow the device driver to call unbind().

So to be on the safe side I think I will by default assume that PPRs are
in flight during unbind, and drain both software and hardware queue to
ensure we catch them all.

As an optimization, we can later add ways for device drivers or firmware
to inform the IOMMU which PASID shutdown model is implemented (maybe a
callback in svm_ops?), in which case we wouldn't have to flush the queue
and if necessary, we can wait for a stop marker before throwing away a PASID.

Thanks,
Jean-Philippe

> I think the best we can do is shutting down processing for this PASID
> when and inform the device driver, when we receive a stop marker. An
> additional, optional call-back would do the job.
> 
> 
> 
> 	Joerg
> 
