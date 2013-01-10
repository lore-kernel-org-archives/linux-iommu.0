From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu: moving initialization earlier
Date: Thu, 10 Jan 2013 13:40:17 -0700
Message-ID: <CAKocOOP=V=kZ=4661YSs4b+7GLcNqzVvvhb+ONBO=LiR3txvTA@mail.gmail.com>
References: <1357545112-17375-1-git-send-email-aik@ozlabs.ru>
	<20130110170941.GA2556@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130110170941.GA2556-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 10, 2013 at 10:09 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 07, 2013 at 06:51:52PM +1100, Alexey Kardashevskiy wrote:
>> The iommu_init() initializes IOMMU internal structures and data
>> required for the IOMMU API as iommu_group_alloc().
>> It is registered as a subsys_initcall now.
>>
>> One of the IOMMU users is going to be a PCI subsystem on POWER.
>> It discovers new IOMMU tables during the PCI scan so the logical
>> place to call iommu_group_alloc() is the moment when a new group
>> is discovered. However PCI scan is done from subsys_initcall hook
>> as IOMMU does so PCI hook can be (and is) called before the IOMMU one.
>>
>> The patch moves IOMMU subsystem initialization one step earlier
>> to make sure that IOMMU is initialized before PCI scan begins.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
>
> Applied, thanks.

Joerg,

Could you please consider this patch for stable releases.

I am currently debugging IO_PAGE_FAULTS on 3.6.11 (happens on all
pre-3.7 releases). I root-caused the reason 3.7 works is because in
3.7 amd iommu driver moving up the early iommu initialization from
irq_remap_ops with the irq remapping feature.

I looked into back-porting a small sub-set of the changes from 3.7. In
the process, I back-ported the following change that fixes
IO_PAGE_FAULTS the problem to some extent.

33f28c59e18d83fd2aeef258d211be66b9b80eb3
[PATCH] iommu/amd: Split device table initialization into irq and
 dma part

My back-port reduced the IO_PAGE_FAULTS, but still happen. I applied
Alexey's patch on top of my back-ported change, and I no longer see
any IO_PAGE_FAULTS. So my second question/request is would you
consider my back-ported patch for stables which I will send out.

Here is the snippet from dmesg from 3.7 and 3.6.11 that illustrates
the change in early initialization during kernel boot process:

Snippet from 3.7:
[    0.009980] Freeing SMP alternatives: 24k freed
[    0.011486] ACPI: Core revision 20120913
[    0.017291] ftrace: allocating 24968 entries in 98 pages
[    0.025792] SK: before iommu_init_flags()
[    1.015392] SK: before iommu_set_device_table()
[    2.004989] SK: before iommu_enable_command_buffer()
[    2.994600] SK: before iommu_enable_event_buffer()
[    3.984469] SK: before iommu_set_exclusion_range()
[    4.974066] SK: before iommu_enable()
[    5.963662] SK: after iommu_flush_all_caches()
[    8.024776] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    8.064424] smpboot: CPU0: AMD Opteron(tm) Processor 6328 (fam: 15,
model: 02, stepping: 00)

Snippet from 3.6.11:
[    3.305383] PCI: CLS 64 bytes, default 64
[    3.305424] Trying to unpack rootfs image as initramfs...
[    5.137815] Freeing initrd memory: 118756k freed
[    5.169817] SK: before iommu_init_flags()
[    6.159717] SK: before iommu_set_device_table()
[    7.149435] SK: before iommu_enable_command_buffer()
[    8.139149] SK: before iommu_enable_event_buffer()
[    9.128868] SK: before iommu_set_exclusion_range()
[   10.118581] SK: before iommu_enable()
[   11.108460] SK: before iommu_flush_all_caches()
[   13.141141] SK: after iommu_flush_all_caches()
[   15.120755] pci 0000:00:00.2: can't derive routing for PCI INT A
[   15.120819] pci 0000:00:00.2: PCI INT A: no GSI
[   15.120880]

In 3.6, early iommu initialization occurs way later.

-- Shuah
