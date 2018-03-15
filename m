From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
	get_irq_table()
Date: Thu, 15 Mar 2018 14:07:23 +0100
Message-ID: <20180315130723.dunmpmbkswwvq54g@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
	<20180223222736.18542-6-bigeasy@linutronix.de>
	<20180315125342.q74wurk6bdbhl6hy@8bytes.org>
	<20180315130153.3ba2loj5oplogdew@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180315130153.3ba2loj5oplogdew-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 15, 2018 at 02:01:53PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-03-15 13:53:42 [+0100], Joerg Roedel wrote:
> > On Fri, Feb 23, 2018 at 11:27:31PM +0100, Sebastian Andrzej Siewior wrote:
> > > @@ -4103,10 +4093,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
> > >  		return ret;
> > >  
> > >  	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
> > > -		if (get_irq_table(devid, true))
> > > +		struct irq_remap_table *table;
> > > +		struct amd_iommu *iommu;
> > > +
> > > +		table = get_irq_table(devid);
> > > +		if (table) {
> > > +			if (!table->min_index) {
> > > +				/*
> > > +				 * Keep the first 32 indexes free for IOAPIC
> > > +				 * interrupts.
> > > +				 */
> > > +				table->min_index = 32;
> > > +				iommu = amd_iommu_rlookup_table[devid];
> > > +				for (i = 0; i < 32; ++i)
> > > +					iommu->irte_ops->set_allocated(table, i);
> > > +			}
> > 
> > I think this needs to be protected by the table->lock.
> 
> Which part any why? The !->min_index part plus extending(setting to 32)?

In particular the set_allocated part, when get_irq_table() returns the
table is visible to other users as well. I have not checked the
irq-layer locking to be sure that can happen, though.
