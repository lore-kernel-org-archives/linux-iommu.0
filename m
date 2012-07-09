From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 03/28] x86/irq: Use irq_remap specific print_IO_APIC
	paths only on Intel
Date: Mon, 9 Jul 2012 14:32:30 +0200
Message-ID: <20120709123230.GA25282@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
	<1341491808-23083-4-git-send-email-joerg.roedel@amd.com>
	<20120706085036.GB24449@gmail.com> <20120706130530.GC2639@amd.com>
	<20120706140037.GA22845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120706140037.GA22845-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 06, 2012 at 04:00:37PM +0200, Ingo Molnar wrote:
> ( A proper abstraction would stick it all into some sort PCI 
>   driver alike structure, including enumeration, initialization, 
>   debugging and other non-core details. )

This is certainly a multi-cycle process to make sure we do not break
everything from one release to another. But cleaning that 4000+ lines
monster up is a good thing, I agree with that. 

> So the way this could work in a cleaner fashion is to 
> encapsulate the logic even more. Today we have a per irq_desc 
> irq_cfg data descriptor, but there's still global knowledge in 
> actual vector allocation such as create_irq() or 
> msi_compose_msg(). Patterns like:
> 
>         if (irq_remapped(cfg)) {
>                 compose_remapped_msi_msg(pdev, irq, dest, msg, hpet_id);
>                 return err;
>         }
> 
>         if (x2apic_enabled())
>                 msg->address_hi = MSI_ADDR_BASE_HI |
>                                   MSI_ADDR_EXT_DEST_ID(dest);
>         else
>                 msg->address_hi = MSI_ADDR_BASE_HI;
> 
> all all signs of insufficient abstraction.

Why was this code merged when you are unhappy with it?

About the irq_remapped() thing: to abstract this properly it has to be a
per-irq abstraction, because in the MSI case some interrupts may be
remapped and others may be not. In the AMD IOMMU case for example, the
MSI interrupt of the IOMMU device itself is not remapped but all others
are. So function pointers in 'struct irq_cfg' come into mind for that.
What do you think about that?

> More importantly, all the silly open-coded if (irq_remapping_enabled)
> checks should be eliminated from core x86 code. IRQ remapping
> should be either be an irq_chip detail or should live in a
> separate layer.

I'll start with factoring out these irq_remapping_enabled and post the
results so that we can agree on the right direction. I gained some
experience with this code while factoring out all the VT-d internals
from it in one of the last cycles.

> So before extending all this please get this into shape.

What about Patches 1 and 2? Any comments on these or are they fine?


Kind Regards,

     Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
