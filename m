From: lijiang <lijiang@redhat.com>
Subject: Re: [PATCH 0/4 v7] Support kdump for AMD secure memory
 encryption(SME)
Date: Wed, 26 Sep 2018 14:03:50 +0800
Message-ID: <06a211dc-5bd4-b76a-56e5-0f3cf47a03bb@redhat.com>
References: <20180907081805.368-1-lijiang@redhat.com>
 <fd8af3af-3b7c-75a6-ad67-b2efe78011fb@amd.com>
 <bdf6961d-3013-f707-bfc9-c55f0c02aba0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bdf6961d-3013-f707-bfc9-c55f0c02aba0@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kexec@lists.infradead.org, Thomas.Lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Also cc maintainer and other reviewer. Thanks.

在 2018年09月26日 13:52, lijiang 写道:
> 在 2018年09月26日 03:10, Lendacky, Thomas 写道:
>> On 09/07/2018 03:18 AM, Lianbo Jiang wrote:
>>> When SME is enabled on AMD machine, we also need to support kdump. Because
>>> the memory is encrypted in the first kernel, we will remap the old memory
>>> to the kdump kernel for dumping data, and SME is also enabled in the kdump
>>> kernel, otherwise the old memory can not be decrypted.
>>>
>>> For the kdump, it is necessary to distinguish whether the memory is encrypted.
>>> Furthermore, we should also know which part of the memory is encrypted or
>>> decrypted. We will appropriately remap the memory according to the specific
>>> situation in order to tell cpu how to access the memory.
>>>
>>> As we know, a page of memory that is marked as encrypted, which will be
>>> automatically decrypted when read from DRAM, and will also be automatically
>>> encrypted when written to DRAM. If the old memory is encrypted, we have to
>>> remap the old memory with the memory encryption mask, which will automatically
>>> decrypt the old memory when we read those data.
>>>
>>> For kdump(SME), there are two cases that doesn't support:
>>>
>>>  ----------------------------------------------
>>> | first-kernel | second-kernel | kdump support |
>>> |      (mem_encrypt=on|off)    |   (yes|no)    |
>>> |--------------+---------------+---------------|
>>> |     on       |     on        |     yes       |
>>> |     off      |     off       |     yes       |
>>> |     on       |     off       |     no        |
>>> |     off      |     on        |     no        |
>>> |______________|_______________|_______________|
>>>
>>> 1. SME is enabled in the first kernel, but SME is disabled in kdump kernel
>>> In this case, because the old memory is encrypted, we can't decrypt the
>>> old memory.
>>>
>>> 2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
>>> It is unnecessary to support in this case, because the old memory is
>>> unencrypted, the old memory can be dumped as usual, we don't need to enable
>>> SME in kdump kernel. Another, If we must support the scenario, it will
>>> increase the complexity of the code, we will have to consider how to pass
>>> the SME flag from the first kernel to the kdump kernel, in order to let the
>>> kdump kernel know that whether the old memory is encrypted.
>>>
>>> There are two methods to pass the SME flag to the kdump kernel. The first
>>> method is to modify the assembly code, which includes some common code and
>>> the path is too long. The second method is to use kexec tool, which could
>>> require the SME flag to be exported in the first kernel by "proc" or "sysfs",
>>> kexec tools will read the SME flag from "proc" or "sysfs" when we use kexec
>>> tools to load image, subsequently the SME flag will be saved in boot_params,
>>> we can properly remap the old memory according to the previously saved SME
>>> flag. But it is too expensive to do this.
>>>
>>> This patches are only for SME kdump, the patches don't support SEV kdump.
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>>
> 
> Thank you, Tom. I'm very glad that you would like to review my patches, and
> also gave me some advice to improve these patches.
> 
>> Just curious, are you planning to add SEV kdump support after this?
>>
> 
> Yes, we are planning to add SEV kdump support after this.
> And i also welcome that you would like to review my SEV kdump patch again.
> 
>> Also, a question below...
>>
>>>
>>> Test tools:
>>> makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
>>> commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
>>> Note: This patch can only dump vmcore in the case of SME enabled.
>>>
>>> crash-7.2.3: https://github.com/crash-utility/crash.git
>>> commit 001f77a05585 (Fix for Linux 4.19-rc1 and later kernels that contain
>>>                      kernel commit7290d58095712a89f845e1bca05334796dd49ed2)
>>>
>>> kexec-tools-2.0.17: git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>> commit b9de21ef51a7 (kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error)
>>> Note:
>>> Before you load the kernel and initramfs for kdump, this patch(http://lists.infradead.org/pipermail/kexec/2018-September/021460.html)
>>> must be merged to kexec-tools, and then the kdump kernel will work well. Because there
>>> is a patch which is removed based on v6(x86/ioremap: strengthen the logic in early_memremap_pgprot_adjust()
>>> to adjust encryption mask).
>>>
>>> Test environment:
>>> HP ProLiant DL385Gen10 AMD EPYC 7251
>>> 8-Core Processor
>>> 32768 MB memory
>>> 600 GB disk space
>>>
>>> Linux 4.19-rc2:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> commit 57361846b52bc686112da6ca5368d11210796804
>>>
>>> Reference:
>>> AMD64 Architecture Programmer's Manual
>>> https://support.amd.com/TechDocs/24593.pdf
>>>
>>> Changes since v6:
>>> 1. There is a patch which is removed based on v6.
>>> (x86/ioremap: strengthen the logic in early_memremap_pgprot_adjust() to adjust encryption mask)
>>> Dave Young suggests that this patch can be removed and fix the kexec-tools.
>>> Reference: http://lists.infradead.org/pipermail/kexec/2018-September/021460.html)
>>> 2. Update the patch log.
>>>
>>> Some known issues:
>>> 1. about SME
>>> Upstream kernel will hang on HP machine(DL385Gen10 AMD EPYC 7251) when
>>> we execute the kexec command as follow:
>>>
>>> # kexec -l /boot/vmlinuz-4.19.0-rc2+ --initrd=/boot/initramfs-4.19.0-rc2+.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug nokaslr"
>>> # kexec -e (or reboot)
>>>
>>> But this issue can not be reproduced on speedway machine, and this issue
>>> is irrelevant to my posted patches.
>>>
>>> The kernel log:
>>> [ 1248.932239] kexec_core: Starting new kernel
>>> early console in extract_kernel
>>> input_data: 0x000000087e91c3b4
>>> input_len: 0x000000000067fcbd
>>> output: 0x000000087d400000
>>> output_len: 0x0000000001b6fa90
>>> kernel_total_size: 0x0000000001a9d000
>>> trampoline_32bit: 0x0000000000099000
>>>
>>> Decompressing Linux...
>>> Parsing ELF...        [---Here the system will hang]
>>
>> Do you know the reason for the hang?  It looks like it is hanging in
>> parse_elf().  Can you add some debug to parse_elf() to see if the
>> value of ehdr.e_phnum is valid (maybe it is not a valid value and so
>> the loop takes forever)?
>>
> 
> Previously, i had loaned a speedway machine, however i could not reproduce this
> issue on this machine. But on the 'HP ProLiant DL385Gen10' machine, this issue
> was always reproduced.(btw: the code is the same.)
> 
> I'm not sure whether this issue is relate to hardware. I had printed these values,
> and i remembered that the value of ehdr.e_phum was valid.
> 
> Because this issue is only reproduced on DL385Gen10 machine, i decreased the priority
> of dealing with this issue.
> 
> If you also care about this issue, i can create a new email thread to trace this issue.
> What do you think about this?
> 
> Thanks
> Lianbo
> 
>> Thanks,
>> Tom
>>
>>>
>>>
>>> Lianbo Jiang (4):
>>>   x86/ioremap: add a function ioremap_encrypted() to remap kdump old
>>>     memory
>>>   kexec: allocate unencrypted control pages for kdump in case SME is
>>>     enabled
>>>   amd_iommu: remap the device table of IOMMU with the memory encryption
>>>     mask for kdump
>>>   kdump/vmcore: support encrypted old memory with SME enabled
>>>
>>>  arch/x86/include/asm/io.h            |  3 ++
>>>  arch/x86/kernel/Makefile             |  1 +
>>>  arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
>>>  arch/x86/mm/ioremap.c                | 25 ++++++++-----
>>>  drivers/iommu/amd_iommu_init.c       | 14 ++++++--
>>>  fs/proc/vmcore.c                     | 21 +++++++----
>>>  include/linux/crash_dump.h           | 12 +++++++
>>>  kernel/kexec_core.c                  | 12 +++++++
>>>  8 files changed, 125 insertions(+), 16 deletions(-)
>>>  create mode 100644 arch/x86/kernel/crash_dump_encrypt.c
>>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
