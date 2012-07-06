From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 03/28] x86/irq: Use irq_remap specific print_IO_APIC
 paths only on Intel
Date: Fri, 6 Jul 2012 15:05:30 +0200
Message-ID: <20120706130530.GC2639@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
 <1341491808-23083-4-git-send-email-joerg.roedel@amd.com>
 <20120706085036.GB24449@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120706085036.GB24449@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, x86@kernel.org, Yinghai Lu <yinghai@kernel.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 06, 2012 at 10:50:36AM +0200, Ingo Molnar wrote:
> 
> * Joerg Roedel <joerg.roedel@amd.com> wrote:
> >  extern int irq_remapping_enabled;
> > +extern int intel_irq_remap_debug;

> Instead of yet another set of global flags thrown around the 
> kernel please properly factor out this code, its data structures 
> and methods: introduce a single descriptor structure that 
> describes this piece of hardware, with debugging flags part of 
> this structure - with operations function pointer structure and 
> such.

Not sure I understand what you mean. So, simplified, from a hardware
point of view we have IO-APICs and MSIs. This doesn't change with
IOMMU-based interrupt remapping. The IO-APICs and MSIs are properly
abstraced through 'struct irq_chip'.

When an IOMMU comes into play the IO-APICs and MSIs need to be
programmed differently so that they send the IRQ messages in a way the
IOMMU can remap. This is done by using a different 'struct irq_chip'
when interrupt remapping is enabled.

For IRQ remapping there are two (not so much) different implementations
which are abstracted through 'struct irq_remap_ops' made accessible via
functions.

So what I _think_ you mean is to add another call-back to the
irq_remap_ops to print out debugging information and use that call-back
when IRQ remapping is enabled instead of the routine in io_apic.c. Is
that right?

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
