From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Date: Thu, 29 Mar 2018 10:50:18 +0200
Message-ID: <20180329085017.tkdtx77u4khiuqhw@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
	<20180315134649.skh2aukcmg5ud74y@8bytes.org>
	<1521123183.2686.7.camel@arista.com>
	<20180315142253.GC5259@8bytes.org>
	<1521124490.2686.16.camel@arista.com>
	<1521124920.2686.20.camel@arista.com>
	<20180315152828.GA11365@8bytes.org>
	<1521579013.2686.83.camel@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1521579013.2686.83.camel-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Cc: 0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 20, 2018 at 08:50:13PM +0000, Dmitry Safonov wrote:
> Hmm, but this fixes my softlockup issue, because it's about time spent
> in printk() inside irq-disabled section, rather about exiting the dmar-
> clearing loop.
> And on my hw doesn't make any difference to limit loop or not because
> clearing a fault is much faster than hw could generate a new fault.
> ITOW, it fixes the softlockup for me and the loop-related lockup can't
> happen on hw I have (so it's the other issue, [possible?] on other hw).

It might solve your issue, but someone else might still run into it with
a different setup. An upstream fix needs to solve it for everyone.

Thanks,

	Joerg
