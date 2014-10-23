From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 1/1] pci: fix dmar fault for kdump kernel
Date: Thu, 23 Oct 2014 15:26:18 +0800
Message-ID: <5448AD9A.7060300@hp.com>
References: <1412925191-27970-1-git-send-email-zhen-hual@hp.com>
	<543CEE32.50109@hp.com> <543E2CD5.60708@jp.fujitsu.com>
	<CAErSpo4isVMeBipp3TngVtZ2CmeQva-6RSHgS8O4C9M+p1ua=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo4isVMeBipp3TngVtZ2CmeQva-6RSHgS8O4C9M+p1ua=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Tom Vaden <tom.vaden-VXdhtT5mjnY@public.gmane.org>, rwright-VXdhtT5mjnY@public.gmane.org, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/22/2014 10:47 AM, Bjorn Helgaas wrote:
> [+cc Joerg, Eric, Tom, David, iommu list]
>
> On Wed, Oct 15, 2014 at 2:14 AM, Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
>> (2014/10/14 18:34), Li, ZhenHua wrote:
>>> I tested on the latest stable version 3.17, it works well.
>>>
>>> On 10/10/2014 03:13 PM, Li, Zhen-Hua wrote:
>>>> On a HP system with Intel vt-d supported and many PCI devices on it,
>>>> when kernel crashed and the kdump kernel boots with intel_iommu=on,
>>>> there may be some unexpected DMA requests on this adapter, which will
>>>> cause DMA Remapping faults like:
>>>>       dmar: DRHD: handling fault status reg 102
>>>>       dmar: DMAR:[DMA Read] Request device [41:00.0] fault addr fff81000
>>>>       DMAR:[fault reason 01] Present bit in root entry is clear
>>>>
>>>> This bug may happen on *any* PCI device.
>>>> Analysis for this bug:
>>>>
>>>> The present bit is set in this function:
>>>>
>>>> static struct context_entry * device_to_context_entry(
>>>>                   struct intel_iommu *iommu, u8 bus, u8 devfn)
>>>> {
>>>>       ......
>>>>                   set_root_present(root);
>>>>       ......
>>>> }
>>>>
>>>> Calling tree:
>>>>       device driver
>>>>           intel_alloc_coherent
>>>>               __intel_map_single
>>>>                   domain_context_mapping
>>>>                       domain_context_mapping_one
>>>>                           device_to_context_entry
>>>>
>>>> This means, the present bit in root entry will not be set until the device
>>>> driver is loaded.
>>>>
>>>> But in the kdump kernel, hardware devices are not aware that control has
>>>> transferred to the second kernel, and those drivers must initialize again.
>>>> Consequently there may be unexpected DMA requests from devices activity
>>>> initiated in the first kernel leading to the DMA Remapping errors in the
>>>> second kernel.
>>>>
>>>> To fix this DMAR fault, we need to reset the bus that this device on. Reset
>>>> the device itself does not work.
>
> You have not explained why the DMAR faults are a problem.  The fault
> is just an indication that the IOMMU prevented a DMA from completing.
> If the DMA is an artifact of the crashed kernel, we probably don't
> *want* it to complete, so taking a DMAR fault seems like exactly the
> right thing.
>
> If the problem is that we're being flooded with messages, it's easy
> enough to just tone down the printks.
>
>>>> A patch for this bug that has been sent before:
>>>> https://lkml.org/lkml/2014/9/30/55
>>>> As in discussion, this bug may happen on *any* device, so we need to reset all
>>>> pci devices.
>>>>
>>>> There was an original version(Takao Indoh) that resets the pcie devices:
>>>> https://lkml.org/lkml/2013/5/14/9
>>
>> As far as I can remember, the original patch was nacked by
>> the following reasons:
>>
>> 1) On sparc, the IOMMU is initialized before PCI devices are enumerated,
>>     so there would still be a window where ongoing DMA could cause an
>>     IOMMU error.
>>
>> 2) Basically Bjorn is thinking device reset should be done in the
>>     1st kernel before jumping into 2nd kernel.
>
> If you're referring to this: https://lkml.org/lkml/2013/6/12/16, what
> I said was "It would be at least conceivable to reset the devices ...
> before the kexec."  That's not a requirement to do it in the first
> kernel, just an idea that I thought should be investigated.  And Eric
> has good reasons for *not* doing the reset in the first kernel, so it
> turned out not to be a very good idea.
>
> My fundamental problem with this whole reset thing is that it's a
> sledgehammer approach and it's ugly.  Using the IOMMU seems like a
> much more elegant approach.
>
> So if we are forced to accept the reset solution, I want to at least
> have a concise explanation of why we can't use the IOMMU.
>
In my understanding, the reset is necessary, because no one knows if
there are any other problems if the devices are not reset in the kdump
kernel.  OS must boot with the devices in a clean state.

But this will not prevent us from using Bill's iommu patch. I think the
most important part for Bill's patch is to dump the data, not to fix
the dmar faults, though it also fixed that.

Zhenhua
> The changelog above is perfectly accurate, but it's really not very
> useful because it only explains the code without exploring any of the
> interesting issues.
>
> Bjorn
>
>> And Bill Sumner proposed another idea.
>> http://comments.gmane.org/gmane.linux.kernel.iommu/4828
>> I don't know the current status of this patch, but I think Jerry Hoemann
>> is working on this.
>>
>> Thanks,
>> Takao Indoh
>>
>>
