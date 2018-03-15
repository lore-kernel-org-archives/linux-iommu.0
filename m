From: Dmitry Safonov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Date: Thu, 15 Mar 2018 14:13:03 +0000
Message-ID: <1521123183.2686.7.camel@arista.com>
References: <20180215191729.15777-1-dima@arista.com>
	<20180315134649.skh2aukcmg5ud74y@8bytes.org>
Reply-To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315134649.skh2aukcmg5ud74y-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: 0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2018-03-15 at 14:46 +0100, Joerg Roedel wrote:
> On Thu, Feb 15, 2018 at 07:17:29PM +0000, Dmitry Safonov wrote:
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index accf58388bdb..6c4ea32ee6a9 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1618,17 +1618,13 @@ irqreturn_t dmar_fault(int irq, void
> > *dev_id)
> >  	int reg, fault_index;
> >  	u32 fault_status;
> >  	unsigned long flag;
> > -	bool ratelimited;
> >  	static DEFINE_RATELIMIT_STATE(rs,
> >  				      DEFAULT_RATELIMIT_INTERVAL,
> >  				      DEFAULT_RATELIMIT_BURST);
> >  
> > -	/* Disable printing, simply clear the fault when
> > ratelimited */
> > -	ratelimited = !__ratelimit(&rs);
> > -
> >  	raw_spin_lock_irqsave(&iommu->register_lock, flag);
> >  	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
> > -	if (fault_status && !ratelimited)
> > +	if (fault_status && __ratelimit(&rs))
> >  		pr_err("DRHD: handling fault status reg %x\n",
> > fault_status);
> 
> This looks aweful. Have you tried to limit the number of loops in
> this
> function and returning? You can handle the next faults by the next
> interrupt. This ensures that the cpu visits a scheduling point from
> time
> to time so that you don't see soft-lockups.

So, you suggest to remove ratelimit at all?
Do we really need printk flood for each happened fault?
Imagine, you've hundreds of mappings and then PCI link flapped..
Wouldn't it be better to keep ratelimiting?
I don't mind, just it looks a bit strange to me.

-- 
Thanks,
             Dmitry
