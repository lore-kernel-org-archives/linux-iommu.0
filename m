From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for v3.7-rc1
Date: Wed, 10 Oct 2012 09:30:22 +0200
Message-ID: <20121010073022.GB16151@8bytes.org>
References: <20121005152312.GA4649@8bytes.org>
	<20121009224532.1e515664@ado-amd-gentoo.moore.slainvet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121009224532.1e515664-IjT0q3EH84DI7ueSY2wKCeWwSe/Luo9VmGrBRn/+eNheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Andrew,

On Tue, Oct 09, 2012 at 10:45:32PM +0100, Andrew Oakley wrote:
> On Fri, 5 Oct 2012 17:23:12 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> wrote:

> ACPI: Core revision 20120711
> ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> Pid: 1, comm: swapper/0 Not tainted 3.6.0+ #2
> Call Trace:
>  [<ffffffff8163f617>] ? panic+0xc5/0x1d0
>  [<ffffffff8163f76e>] ? printk+0x4c/0x51
>  [<ffffffff81c96b52>] ? setup_IO_APIC+0x325/0x710
>  [<ffffffff81c947b5>] ? native_smp_prepare_cpus+0x2b9/0x334
>  [<ffffffff81c87b53>] ? kernel_init+0x59/0x190
>  [<ffffffff81643b84>] ? kernel_thread_helper+0x4/0x10
>  [<ffffffff81c87afa>] ? start_kernel+0x2c7/0x2c7
>  [<ffffffff81643b80>] ? gs_change+0x13/0x13
> 
> There is a patch to fix a similar problem (32ab31e) for the Intel IRQ
> remapping code but I don't know if this is likely to be the same issue
> or not.

Can you please boot with 'amd_iommu_dump nointremap' on your kernel
command line and post dmesg? I guess your ACPI table is broken in some
way.

The problem seen on VT-d exists on AMD too, but I have a workaround for
that in the code already. This must be something else...

Thanks,

	Joerg
