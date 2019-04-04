From: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v9 02/13] x86: always set IF before oopsing from page
	fault
Date: Wed, 3 Apr 2019 21:12:16 -0700
Message-ID: <CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ@mail.gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<e6c57f675e5b53d4de266412aa526b7660c47918.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXvwuwkVSJ+S5s7wTBkNNj3fRVxpx9BvsXWrT=3ZdRnCw@mail.gmail.com>
	<20190404013956.GA3365@cisco>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190404013956.GA3365@cisco>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Woodhouse, David" <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joao Martins <joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, H. Peter Anvin
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 3, 2019 at 6:42 PM Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org> wrote:
>
> On Wed, Apr 03, 2019 at 05:12:56PM -0700, Andy Lutomirski wrote:
> > On Wed, Apr 3, 2019 at 10:36 AM Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> > >
> > > From: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
> > >
> > > Oopsing might kill the task, via rewind_stack_do_exit() at the bottom, and
> > > that might sleep:
> > >
> >
> >
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index 9d5c75f02295..7891add0913f 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -858,6 +858,12 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > >         /* Executive summary in case the body of the oops scrolled away */
> > >         printk(KERN_DEFAULT "CR2: %016lx\n", address);
> > >
> > > +       /*
> > > +        * We're about to oops, which might kill the task. Make sure we're
> > > +        * allowed to sleep.
> > > +        */
> > > +       flags |= X86_EFLAGS_IF;
> > > +
> > >         oops_end(flags, regs, sig);
> > >  }
> > >
> >
> >
> > NAK.  If there's a bug in rewind_stack_do_exit(), please fix it in
> > rewind_stack_do_exit().
>
> [I trimmed the CC list since google rejected it with E2BIG :)]
>
> I guess the problem is really that do_exit() (or really
> exit_signals()) might sleep. Maybe we should put an irq_enable() at
> the beginning of do_exit() instead and fix this problem for all
> arches?
>

Hmm.  do_exit() isn't really meant to be "try your best to leave the
system somewhat usable without returning" -- it's a function that,
other than in OOPSes, is called from a well-defined state.  So I think
rewind_stack_do_exit() is probably a better spot.  But we need to
rewind the stack and *then* turn on IRQs, since we otherwise risk
exploding quite badly.
