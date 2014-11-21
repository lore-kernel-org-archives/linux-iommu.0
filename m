From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC] add a struct page* parameter to dma_map_ops.unmap_page
Date: Fri, 21 Nov 2014 12:18:32 -0800
Message-ID: <vnkwh9xs2tpj.fsf@mitchelh-linux.qualcomm.com>
References: <alpine.DEB.2.02.1411111644490.26318@kaball.uk.xensource.com>
	<alpine.DEB.2.02.1411211147450.12596@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1411211147450.12596-7Z66fg9igcxYtxbxJUhB2Dgeux46jI+i@public.gmane.org>
	(Stefano Stabellini's message of "Fri, 21 Nov 2014 11:48:33 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Ian Campbell <Ian.Campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 21 2014 at 03:48:33 AM, Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org> wrote:
> On Mon, 17 Nov 2014, Stefano Stabellini wrote:
>> Hi all,
>> I am writing this email to ask for your advice.
>> 
>> On architectures where dma addresses are different from physical
>> addresses, it can be difficult to retrieve the physical address of a
>> page from its dma address.
>> 
>> Specifically this is the case for Xen on arm and arm64 but I think that
>> other architectures might have the same issue.
>> 
>> Knowing the physical address is necessary to be able to issue any
>> required cache maintenance operations when unmap_page,
>> sync_single_for_cpu and sync_single_for_device are called.
>> 
>> Adding a struct page* parameter to unmap_page, sync_single_for_cpu and
>> sync_single_for_device would make Linux dma handling on Xen on arm and
>> arm64 much easier and quicker.
>> 
>> I think that other drivers have similar problems, such as the Intel
>> IOMMU driver having to call find_iova and walking down an rbtree to get
>> the physical address in its implementation of unmap_page.
>> 
>> Callers have the struct page* in their hands already from the previous
>> map_page call so it shouldn't be an issue for them.  A problem does
>> exist however: there are about 280 callers of dma_unmap_page and
>> pci_unmap_page. We have even more callers of the dma_sync_single_for_*
>> functions.
>> 
>> 
>> 
>> Is such a change even conceivable? How would one go about it?
>> 
>> I think that Xen would not be the only one to gain from it, but I would
>> like to have a confirmation from others: given the magnitude of the
>> changes involved I would actually prefer to avoid them unless multiple
>> drivers/archs/subsystems could really benefit from them.
>
> Given the lack of interest from the community, I am going to drop this
> idea.

Actually it sounds like the right API design to me.  As a bonus it
should help performance a bit as well.  For example, the current
implementations of dma_sync_single_for_{cpu,device} and dma_unmap_page
on ARM while using the IOMMU mapper
(arm_iommu_sync_single_for_{cpu,device}, arm_iommu_unmap_page) all call
iommu_iova_to_phys which generally results in a page table walk or a
hardware register write/poll/read.

The problem, as you mentioned, is that there are a ton of callers of the
existing APIs.  I think David Vrabel had a good suggestion for dealing
with this:

On Mon, Nov 17 2014 at 06:43:46 AM, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org> wrote:
> You may need to consider a parallel set of map/unmap API calls that
> return/accept a handle, and then converting drivers one-by-one as
> required, instead of trying to convert every single driver at once.

However, I'm not sure whether the costs of having a parallel set of APIs
outweigh the benefits of a cleaner API and a slight performance boost...
But I hope the idea isn't completely abandoned without some profiling or
other evidence of its benefits (e.g. patches showing how drivers could
be simplified with the new APIs).


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
