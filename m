From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 0/5] Fix Intel IRQ remapping initialization order
Date: Mon, 15 Dec 2014 20:54:10 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1412152012000.17382@nanos>
References: <1418656404-28575-1-git-send-email-joro@8bytes.org>
	<548EFE88.3000307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <548EFE88.3000307-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 15 Dec 2014, Jiang Liu wrote:
> On 2014/12/15 23:13, Joerg Roedel wrote:
> > Hi,
> > 
> > here is a patch-set against tip/x86/apic to fix an initialization order
> > problem with the IRQ remapping code.  The problem is in the ordering of
> > the irq_remapping_prepare and irq_remapping_supported functions.
> > 
> > Currently the call-order is irq_remapping_prepare ->
> > irq_remapping_supported, so that 'prepare' can succeed but 'supported'
> > fails, so that interrupt remapping gets initialized but not enabled.
> > This causes a broken interrupt setup on affected systems (machines with
> > an Intel IOMMU without, or broken, IRQ remapping support). The result
> > are lost interrupts and a non-bootable system.
> > 
> > Both functions do checks whether IRQ remapping can be enabled on the
> > machine.  The reason for this is that some checks rely on
> > dmar_table_init() and thus have to be done in irq_remapping_prepare().
> > 
> > This patch-set moves all these checks into the irq_remapping_prepare()
> > path with the right ordering and removes the irq_remapping_supported()
> > function and its call-backs. This fixes the initializion order problem
> > and simplifies the exported API from the IOMMU code.
> > 
> > Please review.
> Hi Joerg,
> 	I have posted a patch set for the same purpose at:
> https://lkml.org/lkml/2014/12/10/20
> 	Seems we need to combine these two patch sets:)

Actually you want to combine it also with these patches:

326c2bb2c526: iommu/vt-d: Convert allocations to GFP_KERNEL
e9220e591375: iommu/vt-d: Move iommu preparatory allocations to irq_remap_ops.prepare
e88edbd316ea: iommu, x86: Restructure setup of the irq remapping feature
dd60143c04f2: x86, smpboot: Remove pointless preempt_disable() in native_smp_prepare_cpus()

against 3.19 independent of the irqdomain stuff.

So that would be a clean base to put the rest of the irqdomain and
hotplug stuff on top.

So the ordering of the patches for 3.20 would become:

   iommu cleanup (init and allocations)
   acpi cleanup and parser extensions
   ioapic hotplug
   irqdomain conversion

I will route dd60143c04f2 "x86, smpboot: Remove pointless
preempt_disable() in native_smp_prepare_cpus()" into -rc1.  I'm going
to do so for a few other cherry-picks from x86/apic.

So can you please create a combined series, which just deals with the
init cleanup and the allocation conversion (ATOMIC -> GFP) based on
current Linus tree should be fine.

Thanks,

	tglx
