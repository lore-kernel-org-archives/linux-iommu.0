From: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
Subject: Re: [RFC PATCH v9 02/13] x86: always set IF before oopsing from page
	fault
Date: Thu, 4 Apr 2019 09:47:27 -0600
Message-ID: <20190404154727.GA14030@cisco>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<e6c57f675e5b53d4de266412aa526b7660c47918.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXvwuwkVSJ+S5s7wTBkNNj3fRVxpx9BvsXWrT=3ZdRnCw@mail.gmail.com>
	<20190404013956.GA3365@cisco>
	<CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, marco.antonio.780-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Amir Goldstein <amir73il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, deepa.srinivasan-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, cpandya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Joao Martins <joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, LSM List <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>an
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 09:12:16PM -0700, Andy Lutomirski wrote:
> On Wed, Apr 3, 2019 at 6:42 PM Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org> wrote:
> >
> > On Wed, Apr 03, 2019 at 05:12:56PM -0700, Andy Lutomirski wrote:
> > > On Wed, Apr 3, 2019 at 10:36 AM Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> > > >
> > > > From: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
> > > >
> > > > Oopsing might kill the task, via rewind_stack_do_exit() at the bottom, and
> > > > that might sleep:
> > > >
> > >
> > >
> > > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > > index 9d5c75f02295..7891add0913f 100644
> > > > --- a/arch/x86/mm/fault.c
> > > > +++ b/arch/x86/mm/fault.c
> > > > @@ -858,6 +858,12 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > > >         /* Executive summary in case the body of the oops scrolled away */
> > > >         printk(KERN_DEFAULT "CR2: %016lx\n", address);
> > > >
> > > > +       /*
> > > > +        * We're about to oops, which might kill the task. Make sure we're
> > > > +        * allowed to sleep.
> > > > +        */
> > > > +       flags |= X86_EFLAGS_IF;
> > > > +
> > > >         oops_end(flags, regs, sig);
> > > >  }
> > > >
> > >
> > >
> > > NAK.  If there's a bug in rewind_stack_do_exit(), please fix it in
> > > rewind_stack_do_exit().
> >
> > [I trimmed the CC list since google rejected it with E2BIG :)]
> >
> > I guess the problem is really that do_exit() (or really
> > exit_signals()) might sleep. Maybe we should put an irq_enable() at
> > the beginning of do_exit() instead and fix this problem for all
> > arches?
> >
> 
> Hmm.  do_exit() isn't really meant to be "try your best to leave the
> system somewhat usable without returning" -- it's a function that,
> other than in OOPSes, is called from a well-defined state.  So I think
> rewind_stack_do_exit() is probably a better spot.  But we need to
> rewind the stack and *then* turn on IRQs, since we otherwise risk
> exploding quite badly.

Ok, sounds good. I guess we can include something like this patch in
the next series.

Thanks,

Tycho


>From 34dce229a4f43f90db823671eb0b8da7c4906045 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
Date: Thu, 4 Apr 2019 09:41:32 -0600
Subject: [PATCH] x86/entry: re-enable interrupts before exiting

If the kernel oopses in an interrupt, nothing re-enables interrupts:

Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at
./include/linux/percpu-rwsem.h:33
Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name:
lkdtm_xpfo_test
Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D
4.13.0-rc5+ #228
Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.1-1ubuntu1 04/01/2014
Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20

do_exit() expects to be called in a well-defined environment, so let's
re-enable interrupts after unwinding the stack, in case they were disabled.

Signed-off-by: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
---
 arch/x86/entry/entry_32.S | 6 ++++++
 arch/x86/entry/entry_64.S | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..8ddb7b41669d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1507,6 +1507,12 @@ ENTRY(rewind_stack_do_exit)
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
+	/*
+	 * If we oopsed in an interrupt handler, interrupts may be off. Let's turn
+	 * them back on before going back to "normal" code.
+	 */
+	sti
+
 	call	do_exit
 1:	jmp 1b
 END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..c0759f3e3ad2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1672,5 +1672,11 @@ ENTRY(rewind_stack_do_exit)
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
+	/*
+	 * If we oopsed in an interrupt handler, interrupts may be off. Let's turn
+	 * them back on before going back to "normal" code.
+	 */
+	sti
+
 	call	do_exit
 END(rewind_stack_do_exit)
-- 
2.19.1
