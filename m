From: Laura Abbott <labbott@redhat.com>
Subject: Re: Warning from AMD IOMMU performance counters
Date: Tue, 23 Feb 2016 09:26:18 -0800
Message-ID: <56CC963A.1080607@redhat.com>
References: <56C798B8.6080009@redhat.com> <56CA69C7.3050508@iommu.org>
 <56CBB789.4020704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CBB789.4020704@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>, Joerg Roedel <joro@8bytes.org>, Suravee.Suthikulpanit@amd.com
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 02/22/2016 05:36 PM, Laura Abbott wrote:
> On 02/21/2016 05:52 PM, Wan Zongshun wrote:
>>
>>
>> -------- Original Message --------
>>> Hi,
>>>
>>> Since about 4.4, we've been seeing reports of this warning on every boot
>>> from some users:
>>>
>>> WARNING: CPU: 2 PID: 1 at drivers/iommu/amd_iommu_init.c:2301
>>> amd_iommu_pc_get_set_reg_val+0xa8/0xe0()
>>> Modules linked in:
>>> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.4.2-300.fc23.x86_64 #1
>>> Hardware name: Hewlett-Packard HP EliteBook 755 G2/221C, BIOS M84 Ver.
>>> 01.10 10/20/2015
>>>   0000000000000000 0000000026124b43 ffff88042d687d20 ffffffff813b0c9f
>>>   0000000000000000 ffff88042d687d58 ffffffff810a2f12 ffff88042f014800
>>>   0000000000000040 0000000000000000 ffffffff81d6c73d 0000000000000000
>>> Call Trace:
>>>   [<ffffffff813b0c9f>] dump_stack+0x44/0x55
>>>   [<ffffffff810a2f12>] warn_slowpath_common+0x82/0xc0
>>>   [<ffffffff81d6c73d>] ? memblock_find_dma_reserve+0x16a/0x16a
>>>   [<ffffffff810a305a>] warn_slowpath_null+0x1a/0x20
>>>   [<ffffffff814d3f48>] amd_iommu_pc_get_set_reg_val+0xa8/0xe0
>>>   [<ffffffff81dafda7>] iommu_go_to_state+0x4d6/0x1384
>>>   [<ffffffff813c02ea>] ? kvasprintf+0x7a/0xa0
>>>   [<ffffffff81d6c73d>] ? memblock_find_dma_reserve+0x16a/0x16a
>>>   [<ffffffff81db0cbd>] amd_iommu_init+0x13/0x201
>>>   [<ffffffff81d6c74f>] pci_iommu_init+0x12/0x3c
>>>   [<ffffffff81002123>] do_one_initcall+0xb3/0x200
>>>   [<ffffffff810c0935>] ? parse_args+0x295/0x4b0
>>>   [<ffffffff81d621c8>] kernel_init_freeable+0x189/0x223
>>>   [<ffffffff8178dc00>] ? rest_init+0x80/0x80
>>>   [<ffffffff8178dc0e>] kernel_init+0xe/0xe0
>>>   [<ffffffff81799c8f>] ret_from_fork+0x3f/0x70
>>>   [<ffffffff8178dc00>] ? rest_init+0x80/0x80
>>>
>>> Full bugzilla https://bugzilla.redhat.com/show_bug.cgi?id=1310258
>>>
>>> Any idea what might be causing this spew?
>>
>> I also see this warning.
>>
>> Suravee's the one of this patch series might be fix this issue, you can try it.
>>
>> [PATCH V4 0/6] perf/amd/iommu: Enable multi-IOMMU support
>>
>>
>
> That patch had other dependencies. I brought what I thought were enough of
> them in to at least compile for the reporter to test (perf_event changes
> from Borislav Petkov). Apparently the kernel doesn't boot with the series
> so suspect there is an integration issue somewhere. I'm going to see if
> I can more information from the reporter about what exactly went wrong
> to see if I need more dependencies.
>

It was an issue with build signing on the testers machine. Once that was
fixed it was confirmed that the patches did fix the issue.
  
> It would be nice to get a single patch which could be applied to stable.
> Tainting the kernel immediately on bootup makes sorting through problems
> more difficult.
>
> Thanks,
> Laura
>
>
