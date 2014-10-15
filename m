From: "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
Date: Wed, 15 Oct 2014 16:45:27 +0800
Message-ID: <543E3427.2040207@hp.com>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com> <1398854973.12733.23.camel@i7.infradead.org> <20140702133258.GN26537@8bytes.org> <20140711162745.GA8335@anatevka.fc.hp.com> <543E2BDA.8030906@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <543E2BDA.8030906@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Jerry.Hoemann@hp.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, "Vaden, Tom L (HP Server OS Architecture)" <tom.vaden@hp.com>
List-Id: iommu@lists.linux-foundation.org

Add Tom to CC list.
On 10/15/2014 04:10 PM, Li, ZhenHua wrote:
> David, Joerg,
> I plan to merge this patch set with 3.17 stable kernel, and split this
> patch set into two :
> 1. The core part, including the changed functions, like [Patch 4/8],
> [Patch 8/8].
> 2. For the formatting issues, like [Patch 1/8],[Patch 3/8],  including
> the changes for code formations, creation of new files
> intel-iommu-kdump.c, intel-iommu-private.h.
>
> I believe this will make the patch set more clear to read and understand.
>
> What are your suggestions?
>
> Thanks
> Zhenhua
>
>
> On 07/12/2014 12:27 AM, Jerry Hoemann wrote:
>> On Wed, Jul 02, 2014 at 03:32:59PM +0200, Joerg Roedel wrote:
>>> Hi David,
>>>
>>> On Wed, Apr 30, 2014 at 11:49:33AM +0100, David Woodhouse wrote:
>>>> There could be all kinds of existing mappings in the DMA page tables,
>>>> and I'm not sure it's safe to preserve them. What prevents the
>>>> crashdump
>>>> kernel from trying to use any of the physical pages which are
>>>> accessible, and which could thus be corrupted by stray DMA?
>>>>
>>>> In fact, the old kernel could even have set up 1:1 passthrough mappings
>>>> for some devices, which would then be able to DMA *anywhere*. Surely we
>>>> need to prevent that?
>>>
>>> Ideally we would prevent that, yes. But the problem is that a failed DMA
>>> transaction might put the device into an unrecoverable state. Usually
>>> any in-flight DMA transactions should only target buffers set up by the
>>> previous kernel and not corrupt any data.
>>>
>>>> After the last round of this patchset, we discussed a potential
>>>> improvement where you point every virtual bus address at the *same*
>>>> physical scratch page.
>>>
>>> That is a solution to prevent the in-flight DMA failures. But what
>>> happens when there is some in-flight DMA to a disk to write some inodes
>>> or a new superblock. Then this scratch address-space may cause
>>> filesystem corruption at worst.
>>>
>>> So with this in mind I would prefer initially taking over the
>>> page-tables from the old kernel before the device drivers re-initialize
>>> the devices.
>>>
>>>
>>>     Joerg
>>
>> David, Joerg,
>>
>> What do you think here?  Do you want me to update the patch set for 3.17?
>>
>> Jerry
>>
>
