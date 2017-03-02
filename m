From: okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Thu, 02 Mar 2017 08:11:03 -0500
Message-ID: <e9a266680830b40907bfd5441200e4df@codeaurora.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-5-jean-philippe.brucker@arm.com>
	<5a7822f2-3991-aa51-169f-78ef49567feb@codeaurora.org>
	<20170302105153.GB15742@e106794-lin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170302105153.GB15742-lfHAr0XZR/FyySVAYrpuPyZi+YwRKgec@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Harb Abdulhamid <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2017-03-02 05:51, Jean-Philippe Brucker wrote:
> Hi Sinan,
> 
> On 01/03/17 19:24, Sinan Kaya wrote:
>> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
>>> /* Initialise command lazily */
>>> +		if (!cmd.opcode)
>>> +			arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
>>> +
>>> +		spin_lock(&smmu_group->devices_lock);
>>> +
>>> +		list_for_each_entry(master, &smmu_group->devices, group_head)
>>> +			arm_smmu_atc_invalidate_master(master, &cmd);
>>> +
>>> +		/*
>>> +		 * TODO: ensure we do a sync whenever we have sent ats_queue_depth
>>> +		 * invalidations to the same device.
>>> +		 */
>>> +		arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
>>> +
>> 
>> It is possible to observe ATS invalidation timeout up to 90 seconds 
>> according to PCIe
>> spec. How does the current code deal with this?
>> 
> 
> Currently we give up waiting for sync after 100us 
> (ARM_SMMU_POLL_TIMEOUT_US).
> A successful sync guarantees that all ATC invalidations since last sync
> were successful, so in case of timeout we should resend all of them.
> The delay itself isn't important at the moment, since we don't handle
> invalidaton failure at all. It's fire and forget, and I haven't come up
> with a complete solution yet.
> 
> The simplest error handling would be to retry invalidation after 90
> seconds if the sync didn't complete. Then after a number of failed
> attempts, maybe try to reset the device. Given that ats_invalidate is
> generally called in irq-safe context, we would be blocking the CPU for
> minutes at a time, which seems unwise. A proper solution would be to
> postpone the unmap and return an error, although unmap errors are
> usually ignored.
> 
> To avoid letting anyone remap something at that address until we're 
> sure
> the invalidation succeeded, we would need to repopulate the page tables
> with the stale mapping, and add a delayed work that inspects the status
> of the invalidation and tries again if it failed. If the invalidation
> comes from the IOMMU core, we control the page tables and it should be
> doable. If it comes from mm/ however, it's more complicated. MMU
> notifiers only tell us that the mapping is going away, they don't
> provide us with a way to hold on to them. Until all stale mappings have
> been invalidated, we also need to hold on to the address space.
> 
> I think the problem is complex enough to deserve a series of its own,
> once we confirm that it may happen in hardware and have a rough idea of
> the timeout values encountered.

Ok, fair enough. I think arm smmuv3 driver should follow the same design 
pattern other iommu drivers are following to solve this issue as other 
drivers are already handling this.

Based on what I see, if there is a timeout happenibg; your sync 
operation will not complete (consumer! = producer) until timeout 
finishes.



> 
> Thanks,
> Jean-Philippe
