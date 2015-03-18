From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [V4.0 REGRESSION FIX] [PATCH] iommu: ipmmu-vmsa: Add terminating
	entry for ipmmu_of_ids
Date: Wed, 18 Mar 2015 18:05:53 +0200
Message-ID: <2015507.Elz8zHjKzf@avalon>
References: <1426550805.4837.0.camel@phoenix> <1711107.1vuWNY7q60@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1711107.1vuWNY7q60@avalon>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wednesday 18 March 2015 01:28:50 Laurent Pinchart wrote:
> On Tuesday 17 March 2015 08:06:45 Axel Lin wrote:
> > The of_device_id table is supposed to be zero-terminated.
> > 
> > Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> Joerg, I don't have anything queued up at the moment, could you please pick
> the patch from the list ?

Thinking twice about this, as DT support has been introduced in v4.0-rc1, so 
this is a v4.0 regression fix. Could you push it to Linus for v4.0 ?

> > ---
> > 
> >  drivers/iommu/ipmmu-vmsa.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 10186ca..bc39bdf 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -851,6 +851,7 @@ static int ipmmu_remove(struct platform_device *pdev)
> > 
> >  static const struct of_device_id ipmmu_of_ids[] = {
> >  	{ .compatible = "renesas,ipmmu-vmsa", },
> > +	{ }
> >  };
> >  
> >  static struct platform_driver ipmmu_driver = {

-- 
Regards,

Laurent Pinchart
