From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Tue, 29 Aug 2017 12:58:46 +1000
Message-ID: <79581f70-a4c9-dac9-a671-4de7f55bd86e@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <3be3fca3-7f66-0f13-b93a-d3db40a8a934@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3be3fca3-7f66-0f13-b93a-d3db40a8a934@ozlabs.ru>
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>, iommu@lists.linux-foundation.org, linux-kerne
List-Id: iommu@lists.linux-foundation.org

On 21/08/17 12:47, Alexey Kardashevskiy wrote:
> Folks,
> 
> Ok, people did talk, exchanged ideas, lovely :) What happens now? Do I
> repost this or go back to PCI bus flags or something else? Thanks.


Anyone, any help? How do we proceed with this? Thanks.



> 
> 
> 
> On 14/08/17 19:45, Alexey Kardashevskiy wrote:
>> Folks,
>>
>> Is there anything to change besides those compiler errors and David's
>> comment in 5/5? Or the while patchset is too bad? Thanks.
>>
>>
>>
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
> 


-- 
Alexey
