From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Mon, 24 Oct 2016 22:54:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610242242320.4815@nanos>
References: <1> <1477112061-12868-1-git-send-email-gakula@caviumnetworks.com>
	<fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 24 Oct 2016, Marc Zyngier wrote:
> On 22/10/16 05:54, Geetha sowjanya wrote:
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index be3c34e..6add8da 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -585,6 +585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> > +	if (chip->irq_ack)
> > +		chip->irq_ack(&desc->irq_data);
> > +#endif
> >  	kstat_incr_irqs_this_cpu(desc);
> >  	if (desc->istate & IRQS_ONESHOT)
> >  		mask_irq(desc);
> > 
> 
> Overall, this workaround is not acceptable as it is.

Aside of being not acceptable this thing is completely broken. 

If that erratum is enabled then a interrupt chip which implements both EOI
and ACK callbacks will issue irq_ack when using the fasteoi handler. While
this might work on that cavium trainwreck, it will just make other
platforms pretty unhappy.

Platform specific hacks have no place in the core code at all. We have
enough options to handle oddball hardware, you just have to use them.

Thanks,

	tglx
