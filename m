From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 03/28] x86/irq: Use irq_remap specific print_IO_APIC
 paths only on Intel
Date: Fri, 6 Jul 2012 16:00:37 +0200
Message-ID: <20120706140037.GA22845@gmail.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
 <1341491808-23083-4-git-send-email-joerg.roedel@amd.com>
 <20120706085036.GB24449@gmail.com>
 <20120706130530.GC2639@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120706130530.GC2639@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <joerg.roedel@amd.com> wrote:

> On Fri, Jul 06, 2012 at 10:50:36AM +0200, Ingo Molnar wrote:
> > 
> > * Joerg Roedel <joerg.roedel@amd.com> wrote:
> > >  extern int irq_remapping_enabled;
> > > +extern int intel_irq_remap_debug;
> 
> > Instead of yet another set of global flags thrown around the 
> > kernel please properly factor out this code, its data structures 
> > and methods: introduce a single descriptor structure that 
> > describes this piece of hardware, with debugging flags part of 
> > this structure - with operations function pointer structure and 
> > such.
> 
> Not sure I understand what you mean. So, simplified, from a 
> hardware point of view we have IO-APICs and MSIs. This doesn't 
> change with IOMMU-based interrupt remapping. The IO-APICs and 
> MSIs are properly abstraced through 'struct irq_chip'.

I wouldn't call the IO-APIC code 'properly abstracted' - it's 
basically minimally abstracted to make genirq work, but 
otherwise it's still stock full of global data and methods, 
remnants of the old monolithic IO-APIC code.

( A proper abstraction would stick it all into some sort PCI 
  driver alike structure, including enumeration, initialization, 
  debugging and other non-core details. )

> When an IOMMU comes into play the IO-APICs and MSIs need to be 
> programmed differently so that they send the IRQ messages in a 
> way the IOMMU can remap. This is done by using a different 
> 'struct irq_chip' when interrupt remapping is enabled.

So the way this could work in a cleaner fashion is to 
encapsulate the logic even more. Today we have a per irq_desc 
irq_cfg data descriptor, but there's still global knowledge in 
actual vector allocation such as create_irq() or 
msi_compose_msg(). Patterns like:

        if (irq_remapped(cfg)) {
                compose_remapped_msi_msg(pdev, irq, dest, msg, hpet_id);
                return err;
        }

        if (x2apic_enabled())
                msg->address_hi = MSI_ADDR_BASE_HI |
                                  MSI_ADDR_EXT_DEST_ID(dest);
        else
                msg->address_hi = MSI_ADDR_BASE_HI;

all all signs of insufficient abstraction.

Methods like the ->set_affinity() variants are sufficiently 
abstracted out. Others, including the bits I commented on, not 
so much.

> For IRQ remapping there are two (not so much) different 
> implementations which are abstracted through 'struct 
> irq_remap_ops' made accessible via functions.
> 
> So what I _think_ you mean is to add another call-back to the 
> irq_remap_ops to print out debugging information and use that 
> call-back when IRQ remapping is enabled instead of the routine 
> in io_apic.c. Is that right?

This would be part of it, yes - and doing that alone would make 
this patch more palatable.

I'd also suggest other reductions of complexity - for example 
CONFIG_IRQ_REMAP should probably be an unconditional feature - 
it's not a huge amount of code.

More importantly, all the silly open-coded if 
(irq_remapping_enabled) checks should be eliminated from core 
x86 code. IRQ remapping should be either be an irq_chip detail 
or should live in a separate layer.

So before extending all this please get this into shape.

Thanks,

	Ingo
