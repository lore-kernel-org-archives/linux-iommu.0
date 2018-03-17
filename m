From: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL allocation
Date: Sat, 17 Mar 2018 16:43:39 -0500
Message-ID: <1521323019.3722.98.camel@redhat.com>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
	<1521316194.3722.74.camel@redhat.com>
	<20180317211013.rlou66s542ad4y2i@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180317211013.rlou66s542ad4y2i-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, 2018-03-17 at 22:10 +0100, Sebastian Andrzej Siewior wrote:
> On 2018-03-17 14:49:54 [-0500], Scott Wood wrote:
> > On Fri, 2018-03-16 at 21:18 +0100, Sebastian Andrzej Siewior wrote:
> > > The goal here is to make the memory allocation in get_irq_table()
> > > not
> > > with disabled interrupts and having as little raw_spin_lock as
> > > possible
> > > while having them if the caller is also holding one (like desc-
> > > >lock
> > > during IRQ-affinity changes).
> > > I reverted one patch one patch in the iommu while rebasing since
> > > it
> > > make job easier.
> > 
> > If the goal is to have "as little raw_spin_lock as possible" -- and
> > presumably also to avoid unnecessary complexity -- wouldn't it be
> > better to leave my patch in, and drop patches 4 and 9?
> 
> 9 gives me GFP_KERNEL instead atomic so no.
> 4 is needed I think but I could double check on Monday. 

If that's worth the lock dropping then fine (though why does only one
of the two allocations use GFP_KERNEL?), but it doesn't need to be a
raw lock if the non-allocating users are separated.  Keeping them
separate will also preserve the WARNs if we somehow end up in an atomic
context with no table (versus relying on atomic sleep debugging that
may or may not be enabled), and make the code easier to understand by
being explicit about which functions can be used from RT-atomic
context.

-Scott
