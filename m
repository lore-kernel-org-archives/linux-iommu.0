From: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Subject: Re: BUG unpinning 1 GiB huge pages with KVM PCI assignment
Date: Fri, 1 Nov 2013 12:01:26 -0600
Message-ID: <20131101180126.GD7961@psuche>
References: <20131028193756.GA1653@psuche> <20131029231943.GA29828@psuche>
	<20131101174734.GA27370@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131101174734.GA27370-I4X2Mt4zSy4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 01, 2013 at 10:47:35AM -0700, Marcelo Tosatti wrote:
> On Tue, Oct 29, 2013 at 05:19:43PM -0600, Greg Edwards wrote:
>> On Mon, Oct 28, 2013 at 12:37:56PM -0700, Greg Edwards wrote:
>>> Using KVM PCI assignment with 1 GiB huge pages trips a BUG in 3.12.0-rc7, e.g.
>>>
>>> # qemu-system-x86_64 \
>>> 	-m 8192 \
>>> 	-mem-path /var/lib/hugetlbfs/pagesize-1GB \
>>> 	-mem-prealloc \
>>> 	-enable-kvm \
>>> 	-device pci-assign,host=1:0.0 \
>>> 	-drive file=/var/tmp/vm.img,cache=none
>>>
>>>
>>> [  287.081736] ------------[ cut here ]------------
>>> [  287.086364] kernel BUG at mm/hugetlb.c:654!
>>> [  287.090552] invalid opcode: 0000 [#1] PREEMPT SMP
>>> [  287.095407] Modules linked in: pci_stub autofs4 sunrpc iptable_filter ip_tables ip6table_filter ip6_tables x_tables binfmt_misc freq_table processor x86_pkg_temp_thermal kvm_intel kvm crc32_pclmul microcode serio_raw i2c_i801 evdev sg igb i2c_algo_bit i2c_core ptp pps_core mlx4_core button ext4 jbd2 mbcache crc16 usbhid sd_mod
>>> [  287.124916] CPU: 15 PID: 25668 Comm: qemu-system-x86 Not tainted 3.12.0-rc7 #1
>>> [  287.132140] Hardware name: DataDirect Networks SFA12KX/SFA12000, BIOS 21.0m4 06/28/2013
>>> [  287.140145] task: ffff88007c732e60 ti: ffff881ff1d3a000 task.ti: ffff881ff1d3a000
>>> [  287.147620] RIP: 0010:[<ffffffff811395e1>]  [<ffffffff811395e1>] free_huge_page+0x1d1/0x1e0
>>> [  287.155992] RSP: 0018:ffff881ff1d3ba88  EFLAGS: 00010213
>>> [  287.161309] RAX: 0000000000000000 RBX: ffffffff818bcd80 RCX: 0000000000000012
>>> [  287.168446] RDX: 020000000000400c RSI: 0000000000001000 RDI: 0000000040000000
>>> [  287.175574] RBP: ffff881ff1d3bab8 R08: 0000000000000000 R09: 0000000000000002
>>> [  287.182705] R10: 0000000000000000 R11: 0000000000000000 R12: ffffea007c000000
>>> [  287.189834] R13: 020000000000400c R14: 0000000000000000 R15: 00000000ffffffff
>>> [  287.196964] FS:  00007f13722d5840(0000) GS:ffff88287f660000(0000) knlGS:0000000000000000
>>> [  287.205048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  287.210790] CR2: ffffffffff600400 CR3: 0000001fee3f5000 CR4: 00000000001427e0
>>> [  287.217918] Stack:
>>> [  287.219931]  0000000000000001 ffffea007c000000 0000000001f00000 ffff881fe3d88500
>>> [  287.227390]  00000000000e0000 00000000ffffffff ffff881ff1d3bad8 ffffffff81102f9c
>>> [  287.234849]  0000000000000246 ffffea007c000000 ffff881ff1d3baf8 ffffffff811035c0
>>> [  287.242308] Call Trace:
>>> [  287.244762]  [<ffffffff81102f9c>] __put_compound_page+0x1c/0x30
>>> [  287.250680]  [<ffffffff811035c0>] put_compound_page+0x80/0x200
>>> [  287.256516]  [<ffffffff81103d05>] put_page+0x45/0x50
>>> [  287.261487]  [<ffffffffa019f070>] kvm_release_pfn_clean+0x50/0x60 [kvm]
>>> [  287.268098]  [<ffffffffa01a62d5>] kvm_iommu_put_pages+0xb5/0xe0 [kvm]
>>> [  287.274542]  [<ffffffffa01a6315>] kvm_iommu_unmap_pages+0x15/0x20 [kvm]
>>> [  287.281160]  [<ffffffffa01a638a>] kvm_iommu_unmap_memslots+0x6a/0x90 [kvm]
>>> [  287.288038]  [<ffffffffa01a68b7>] kvm_assign_device+0xa7/0x140 [kvm]
>>> [  287.294398]  [<ffffffffa01a5e6c>] kvm_vm_ioctl_assigned_device+0x78c/0xb40 [kvm]
>>> [  287.301795]  [<ffffffff8113baa1>] ? alloc_pages_vma+0xb1/0x1b0
>>> [  287.307632]  [<ffffffffa01a089e>] kvm_vm_ioctl+0x1be/0x5b0 [kvm]
>>> [  287.313645]  [<ffffffff811220fd>] ? remove_vma+0x5d/0x70
>>> [  287.318963]  [<ffffffff8103ecec>] ? __do_page_fault+0x1fc/0x4b0
>>> [  287.324886]  [<ffffffffa01b49ec>] ? kvm_dev_ioctl_check_extension+0x8c/0xd0 [kvm]
>>> [  287.332370]  [<ffffffffa019fba6>] ? kvm_dev_ioctl+0xa6/0x460 [kvm]
>>> [  287.338551]  [<ffffffff8115e049>] do_vfs_ioctl+0x89/0x4c0
>>> [  287.343953]  [<ffffffff8115e521>] SyS_ioctl+0xa1/0xb0
>>> [  287.349007]  [<ffffffff814c1552>] system_call_fastpath+0x16/0x1b
>>> [  287.355011] Code: e6 48 89 df 48 89 42 08 48 89 10 4d 89 54 24 20 4d 89 4c 24 28 e8 70 bc ff ff 48 83 6b 38 01 42 83 6c ab 08 01 eb 91 0f 0b eb fe <0f> 0b eb fe 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57
>>> [  287.374986] RIP  [<ffffffff811395e1>] free_huge_page+0x1d1/0x1e0
>>> [  287.381007]  RSP <ffff881ff1d3ba88>
>>> [  287.384508] ---[ end trace 82c719f97df2e524 ]---
>>> [  287.389129] Kernel panic - not syncing: Fatal exception
>>> [  287.394378] ------------[ cut here ]------------
>>>
>>>
>>> This is on an Ivy Bridge system, so it has IOMMU with snoop control, hence the
>>> map/unmap/map sequence on device assignment to get the cache coherency right.
>>> It appears we are unpinning tail pages we never pinned the first time through
>>> kvm_iommu_map_memslots().  This kernel does not have THP enabled, if that makes
>>> a difference.
>>
>> The issue here is one of the 1 GiB huge pages is partially in one
>> memslot (memslot 1) and fully in another one (memslot 5).  When the
>> memslots are pinned by kvm_iommu_map_pages(), we only pin the pages
>> once.
>>
>> When we unmap them with kvm_iommu_put_pages(), half of the huge page is
>> unpinned when memslot 1 is unmapped/unpinned, but when memslot 5 is
>> unpinned next, iommu_iova_to_phys() still returns values for the gfns
>> that were part of the partial huge page in memslot 1 (and also in
>> memslot 5), and we unpin those pages a second time, plus the rest of the
>> huge page that was in memslot 5 only, and then trip the bug when
>> page->_count reaches zero.
>>
>> Is it expected the same pages might be mapped in multiple memslots?  I
>> noticed the gfn overlap check in __kvm_set_memory_region().
>>
>> It appears pfn_to_dma_pte() is behaving as expected, given half the huge
>> page is still mapped.  Do I have that correct?  If so, then we really
>> can't rely on iommu_iova_to_phys() alone to determine if its safe to
>> unpin a page in kvm_iommu_put_pages().
>>
>> Ideas on how to best handle this condition?
>
> iommu_unmap should grab lpage_level bits from the virtual address
> (should fix the BUG), and should return correct number of freed pfns in
> case of large ptes (should fix the leak). Will send a patch shortly.

Thanks, Marcelo.  This patch also fixes the BUG:

http://www.spinics.net/lists/kvm/msg97784.html
