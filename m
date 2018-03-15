From: Dmitry Safonov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Date: Thu, 15 Mar 2018 14:34:50 +0000
Message-ID: <1521124490.2686.16.camel@arista.com>
References: <20180215191729.15777-1-dima@arista.com>
	<20180315134649.skh2aukcmg5ud74y@8bytes.org>
	<1521123183.2686.7.camel@arista.com> <20180315142253.GC5259@8bytes.org>
Reply-To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315142253.GC5259-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On Thu, 2018-03-15 at 15:22 +0100, Joerg Roedel wrote:
> On Thu, Mar 15, 2018 at 02:13:03PM +0000, Dmitry Safonov wrote:
> > So, you suggest to remove ratelimit at all?
> > Do we really need printk flood for each happened fault?
> > Imagine, you've hundreds of mappings and then PCI link flapped..
> > Wouldn't it be better to keep ratelimiting?
> > I don't mind, just it looks a bit strange to me.
> 
> I never said you should remove the ratelimiting, after all you are
> trying to fix a soft-lockup, no?
> 
> And that should not be fixed by changes to the ratelimiting, but with
> proper irq handling.

Uh, I'm a bit confused then.
- Isn't it better to ratelimit each printk() instead of bunch of
printks inside irq handler?
- I can limit the number of loops, but the most of the time is spent in
the loop on printk() (on my machine ~170msec per loop), while
everything else takes much lesser time (on my machine < 1 usec per
loop). So, if I will limit number of loops per-irq, that cycle-limit
will be based on limiting time spent on printk (e.g., how many printks
to do in atomic context so that node will not lockup). It smells like
ratelimiting, no?

I must be misunderstanding something, but why introducing another limit
for number of printk() called when there is ratelimit which may be
tuned..

-- 
Thanks,
             Dmitry
