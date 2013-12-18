From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/shmobile: Allocate archdata with kzalloc()
Date: Wed, 18 Dec 2013 15:14:30 +0100
Message-ID: <2654806.jEV5NhJKD5@avalon>
References: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1387300730-28783-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20131218011521.GI18992@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131218011521.GI18992-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
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
Cc: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday 18 December 2013 10:15:21 Simon Horman wrote:
> On Tue, Dec 17, 2013 at 06:18:49PM +0100, Laurent Pinchart wrote:
> > The archdata attached_list field isn't initialized, leading to random
> > crashes when accessed. Use kzalloc() to allocate the whole structure and
> > make sure all fields get initialized properly.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Thank you Simon.

Joerg, could you please pick those two patches up for v3.14 ?

> > ---
> > 
> >  drivers/iommu/shmobile-iommu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/shmobile-iommu.c
> > b/drivers/iommu/shmobile-iommu.c index d572863..7a3b928 100644
> > --- a/drivers/iommu/shmobile-iommu.c
> > +++ b/drivers/iommu/shmobile-iommu.c
> > @@ -380,14 +380,13 @@ int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
> >  		kmem_cache_destroy(l1cache);
> >  		return -ENOMEM;
> >  	}
> > -	archdata = kmalloc(sizeof(*archdata), GFP_KERNEL);
> > +	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
> >  	if (!archdata) {
> >  		kmem_cache_destroy(l1cache);
> >  		kmem_cache_destroy(l2cache);
> >  		return -ENOMEM;
> >  	}
> >  	spin_lock_init(&archdata->attach_lock);
> > -	archdata->attached = NULL;
> >  	archdata->ipmmu = ipmmu;
> >  	ipmmu_archdata = archdata;
> >  	bus_set_iommu(&platform_bus_type, &shmobile_iommu_ops);

-- 
Regards,

Laurent Pinchart
