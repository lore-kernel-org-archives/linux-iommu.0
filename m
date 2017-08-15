From: Jike Song <jike.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Tue, 15 Aug 2017 09:16:53 +0800
Message-ID: <59924B85.5040405@intel.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
	<8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
	<ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ca2a4550-fb26-28db-0eea-a5940dfa612f-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vlad Tsyrklevich <vlad-NIZqynvkaCU43zv7NVfAiQ@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kyle Mahlkuch <Kyle.Mahlkuch-qyM6JfAXOaQ@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauricio Faria de Oliveira <mauricfo-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 08/14/2017 09:12 PM, Robin Murphy wrote:
> On 14/08/17 10:45, Alexey Kardashevskiy wrote:
>> Folks,
>>
>> Is there anything to change besides those compiler errors and David's
>> comment in 5/5? Or the while patchset is too bad? Thanks.
> 
> While I now understand it's not the low-level thing I first thought it
> was, so my reasoning has changed, personally I don't like this approach
> any more than the previous one - it still smells of abusing external
> APIs to pass information from one part of VFIO to another (and it has
> the same conceptual problem of attributing something to interrupt
> sources that is actually a property of the interrupt target).
> 
> Taking a step back, though, why does vfio-pci perform this check in the
> first place? If a malicious guest already has control of a device, any
> kind of interrupt spoofing it could do by fiddling with the MSI-X
> message address/data it could simply do with a DMA write anyway, so the
> security argument doesn't stand up in general (sure, not all PCIe
> devices may be capable of arbitrary DMA, but that seems like more of a
> tenuous security-by-obscurity angle to me).

Hi Robin,

DMA writes will be translated (thereby censored) by DMA Remapping hardware,
while MSI/MSI-X will not. Is this different for non-x86?

--
Thanks,
Jike

> Besides, with Type1 IOMMU
> the fact that we've let a device be assigned at all means that this is
> already a non-issue (because either the hardware provides isolation or
> the user has explicitly accepted the consequences of an unsafe
> configuration) - from patch #4 that's apparently the same for SPAPR TCE,
> in which case it seems this flag doesn't even need to be propagated and
> could simply be assumed always.
> 
> On the other hand, if the check is not so much to mitigate malicious
> guests attacking the system as to prevent dumb guests breaking
> themselves (e.g. if some or all of the MSI-X capability is actually
> emulated), then allowing things to sometimes go wrong on the grounds of
> an irrelevant hardware feature doesn't seem correct :/
> 
> Robin.
> 
>> On 07/08/17 17:25, Alexey Kardashevskiy wrote:
>>> This is a followup for "[PATCH kernel v4 0/6] vfio-pci: Add support for mmapping MSI-X table"
>>> http://www.spinics.net/lists/kvm/msg152232.html
>>>
>>> This time it is using "caps" in IOMMU groups. The main question is if PCI
>>> bus flags or IOMMU domains are still better (and which one).
>>
>>>
>>>
>>>
>>> Here is some background:
>>>
>>> Current vfio-pci implementation disallows to mmap the page
>>> containing MSI-X table in case that users can write directly
>>> to MSI-X table and generate an incorrect MSIs.
>>>
>>> However, this will cause some performance issue when there
>>> are some critical device registers in the same page as the
>>> MSI-X table. We have to handle the mmio access to these
>>> registers in QEMU emulation rather than in guest.
>>>
>>> To solve this issue, this series allows to expose MSI-X table
>>> to userspace when hardware enables the capability of interrupt
>>> remapping which can ensure that a given PCI device can only
>>> shoot the MSIs assigned for it. And we introduce a new bus_flags
>>> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
>>> for different archs.
>>>
>>>
>>> This is based on sha1
>>> 26c5cebfdb6c "Merge branch 'parisc-4.13-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux"
>>>
>>> Please comment. Thanks.
>>>
>>> Changelog:
>>>
>>> v5:
>>> * redid the whole thing via so-called IOMMU group capabilities
>>>
>>> v4:
>>> * rebased on recent upstream
>>> * got all 6 patches from v2 (v3 was missing some)
>>>
>>>
>>>
>>>
>>> Alexey Kardashevskiy (5):
>>>   iommu: Add capabilities to a group
>>>   iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if MSI controller enables IRQ
>>>     remapping
>>>   iommu/intel/amd: Set IOMMU_GROUP_CAP_ISOLATE_MSIX if IRQ remapping is
>>>     enabled
>>>   powerpc/iommu: Set IOMMU_GROUP_CAP_ISOLATE_MSIX
>>>   vfio-pci: Allow to expose MSI-X table to userspace when safe
>>>
>>>  include/linux/iommu.h            | 20 ++++++++++++++++++++
>>>  include/linux/vfio.h             |  1 +
>>>  arch/powerpc/kernel/iommu.c      |  1 +
>>>  drivers/iommu/amd_iommu.c        |  3 +++
>>>  drivers/iommu/intel-iommu.c      |  3 +++
>>>  drivers/iommu/iommu.c            | 35 +++++++++++++++++++++++++++++++++++
>>>  drivers/vfio/pci/vfio_pci.c      | 20 +++++++++++++++++---
>>>  drivers/vfio/pci/vfio_pci_rdwr.c |  5 ++++-
>>>  drivers/vfio/vfio.c              | 15 +++++++++++++++
>>>  9 files changed, 99 insertions(+), 4 deletions(-)
>>>
>>
>>
> 
