From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
Date: Tue, 21 Jun 2016 15:18:49 +0200
Message-ID: <2015742.xhx642kbrC@diego>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
	<CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
	<20160621125435.GE11432@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160621125435.GE11432-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Dienstag, 21. Juni 2016, 14:54:35 schrieb Joerg Roedel:
> Hi Tomasz,
> 
> On Tue, Jun 21, 2016 at 09:42:16PM +0900, Tomasz Figa wrote:
> > In simple words, DRM patches depend on IOMMU patches.
> > 
> > More precisely: The IOMMU patches alone are supposed to not break
> > anything. Same goes for the first DRM patch (7/8). Only second DRM
> > patch (8/8) depends on changes introduced by its predecessors.
> 
> The first DRM patch is 6/7, so it is 7/8 with the iommu dependency,
> right? Anyway, I think the best is I take the iommu patches when Heiko
> is ok with them and then the DRM tree can merge that branch in to apply
> the DRM patches.
> 
> But first Heiko should have a look at the patches.

I think from all his previous work on the rockchip iommus Tomasz is a lot more 
qualified to judge them - which I guess he did when picking up the ones from 
Rockchip devs :-) .

>From a style-side, please don't carry the Reviewed-on gerrit tags over to 
mainline patches (patches 1 and 2).

Other than that, I didn't see anything jump out and it looks all pretty nice.


Heiko
