From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/ipmmu-vmsa: Add device tree support
Date: Mon, 31 Mar 2014 16:09:41 +0200
Message-ID: <4940423.MM1jLpQkNj@avalon>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1396049781-12941-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdU7esZ35xe+iTRNbeXmD7bSHXEakTOrTfXEs8h5yQLFfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdU7esZ35xe+iTRNbeXmD7bSHXEakTOrTfXEs8h5yQLFfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Monday 31 March 2014 10:45:00 Geert Uytterhoeven wrote:
> On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart wrote:
> > @@ -828,16 +829,31 @@ static phys_addr_t ipmmu_iova_to_phys(struct
> > iommu_domain *io_domain,> 
> >  static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device
> >  *dev) {
> > 
> > +       ret = of_parse_phandle_with_fixed_args(dev->of_node, "iommus",
> > +                                              1, 0, &args);
> 
> drivers/of/base.c:of_parse_phandle_with_fixed_args():
> 
> "Caller is responsible to call of_node_put() on the returned out_args->node
>  pointer."

Thank you for the review. I'll fix that in v2.

> > +       if (ret < 0)
> > +               return -1;
> > +
> > +       if (args.np != mmu->dev->of_node)
> > +               return -1;
> > +
> > +       return args.args[0];
> >  }

- 
Regards,

Laurent Pinchart
