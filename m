From: Tom Wimmenhove <tom.wimmenhove-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regression since 4.1
Date: Mon, 4 Apr 2016 17:06:11 +0000 (UTC)
Message-ID: <loom.20160404T185813-468@post.gmane.org>
References: <5418503.92eb9JWhCR@t400> <1449688068.15753.461.camel@redhat.com>
	<6847091.8HQyRDvvTU@pc> <20151228164918.GN18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel <joro@...> writes:

> 
> Hi Tobias,
> 
> On Thu, Dec 10, 2015 at 12:07:57AM +0100, Tobias Geiger wrote:
> > It all comes down to kernel > 4.1 && iommu=on = not working here
> > 
> > Hardware is:
> > Intel DX58SO, Intel CPU i7 920... all pretty solid running for years 
now, 
> > always with iommo=on.
> > 
> > I'd love to debug this further, just dont know how...
> 
> Sounds like only bisecting the issue will help here. You can find an
> introduction on bisecting here:
> 
> 	https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git
> 
> Would be great if you can find the time to bisect the issue.
> 
> 	Joerg
> 
> 

I can confirm this bug with kernel "4.2.0-16-generic #19-Ubuntu" on an 
Intel DX58SO board with a W3520 Xeon CPU.
Before I was running 3.16.0 which did not lock up at boot but did have 
occasional DMAR issues with GPU passthrough while running a Windows 7 gues 
in Qemu. I don't know if the two are related.
