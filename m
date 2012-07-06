From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/28] x86/irq: Use irq_remap specific print_IO_APIC
	paths only on Intel
Date: Fri, 6 Jul 2012 10:50:36 +0200
Message-ID: <20120706085036.GB24449@gmail.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
	<1341491808-23083-4-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341491808-23083-4-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:

> The VT-d IOMMU requires a special setup of the IO-APIC to
> remap its interrupts. Therefore the print_IO_APIC routine
> has seperate code paths to accout for that and print out the
> special setup. This is not required on AMD IOMMU systems, so
> make these path really Intel specific.
> 
> Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/include/asm/irq_remapping.h |    2 ++
>  arch/x86/kernel/apic/io_apic.c       |    4 ++--
>  drivers/iommu/intel_irq_remapping.c  |    2 ++
>  drivers/iommu/irq_remapping.c        |    1 +
>  4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
> index 5fb9bbb..228d5e5 100644
> --- a/arch/x86/include/asm/irq_remapping.h
> +++ b/arch/x86/include/asm/irq_remapping.h
> @@ -27,6 +27,7 @@
>  #ifdef CONFIG_IRQ_REMAP
>  
>  extern int irq_remapping_enabled;
> +extern int intel_irq_remap_debug;

Sigh.

Instead of yet another set of global flags thrown around the 
kernel please properly factor out this code, its data structures 
and methods: introduce a single descriptor structure that 
describes this piece of hardware, with debugging flags part of 
this structure - with operations function pointer structure and 
such.

This code came from the "we have a single, known type of system 
global IOMMU" world - and we now want to transform this into 
something that is properly abstracted out and made flexible, as 
we extend its capabilities .

Thanks,

	Ingo
