From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 10/20] powerpc/dma-noncoherent: don't disable irqs over
	kmap_atomic
Date: Thu, 23 Aug 2018 09:45:43 +1000
Message-ID: <a1a258002571aca84fd884ccfa7ec9e84ff0b051.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-11-hch@lst.de>
	<bfa22816fee0759cfee28705b427be3586c7d2e3.camel@kernel.crashing.org>
	<20180822070241.GD19284@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180822070241.GD19284-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-08-22 at 09:02 +0200, Christoph Hellwig wrote:
> On Thu, Aug 09, 2018 at 10:27:46AM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> > > The requirement to disable local irqs over kmap_atomic is long gone,
> > > so remove those calls.
> > 
> > Really ? I'm trying to verify that and getting lost in a mess of macros
> > from hell in the per-cpu stuff but if you look at our implementation
> > of kmap_atomic_prot(), all it does is a preempt_disable(), and then
> > it uses kmap_atomic_idx_push():
> > 
> > 	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
> > 
> > Note the use of __this_cpu_inc_return(), not this_cpu_inc_return(),
> > ie this is the non-interrupt safe version...
> 
> Looks like the powerpc variant indeed isn't save.
> 
> I did look a bit more through the code and history, and it seems
> like we remove the need to disable irqs when called from process
> context a while ago, but we still require disabling irqs when called
> from irq context.  Given that this code can also be called from
> irq context we'll have to keep the local_irq_save.

This is the same with x86 no ?

32-bit x86 kmap_atomic_prot is the same as ours...

In fact I wonder why the preempt_disable() in there since it needs to
be protected against interrupt ?

Or is it that we never actually call kmap_atomic_* these days from
interrupt, and the atomic versions are just about dealing with
spinlocks ?

Cheers,
Ben.
 
