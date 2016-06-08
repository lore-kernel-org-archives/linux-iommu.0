From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Wed, 08 Jun 2016 11:48:20 +0300
Message-ID: <2464365.ZvRSQB46Pc@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple>
	<10108662.fYf10pMtGa@avalon>
	<CAMuHMdUr6P=xiiw02wEeJdBw+K_q2ATE9jHgiQ0KCOangYv=tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdUr6P=xiiw02wEeJdBw+K_q2ATE9jHgiQ0KCOangYv=tw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Wednesday 08 Jun 2016 09:04:17 Geert Uytterhoeven wrote:
> On Wed, Jun 8, 2016 at 2:18 AM, Laurent Pinchart wrote:
> >> --- 0031/drivers/iommu/ipmmu-vmsa.c
> >> +++ work/drivers/iommu/ipmmu-vmsa.c   2016-06-06 11:19:40.210607110 +0900
> >> @@ -1074,7 +1074,7 @@ static const struct ipmmu_features ipmmu
> >>       .twobit_imttbcr_sl0 = false,
 >>  };
> >> 
> >> -static const struct ipmmu_features ipmmu_features_r8a7795 = {
> >> +static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
> >>       .use_ns_alias_offset = false,
> >>       .has_cache_leaf_nodes = true,
> >>       .has_eight_ctx = true,
> >> @@ -1088,7 +1088,10 @@ static const struct of_device_id ipmmu_o
> >>               .data = &ipmmu_features_default,
> >>       }, {
> >>               .compatible = "renesas,ipmmu-r8a7795",
> >> -             .data = &ipmmu_features_r8a7795,
> >> +             .data = &ipmmu_features_rcar_gen3,
> >> +     }, {
> >> +             .compatible = "renesas,ipmmu-r8a7796",
> >> +             .data = &ipmmu_features_rcar_gen3,
> >>       }, {
> >>               /* Terminator */
> >>       },
> >> @@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
> >>                ipmmu_vmsa_iommu_of_setup);
> >>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
> >>                ipmmu_vmsa_iommu_of_setup);
> >> +IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
> >> +              ipmmu_vmsa_iommu_of_setup);
> > 
> > How about a Gen3 generic compatible string in addition to the SoC-specific
> > ones ?
> 
> Do we want to specify the number of utlbs here?
> Does it differ between r8a7795, r8a7796, and future members?

It differs between IPMMU instances on a given SoC, so if we want to specify it 
it should be a DT property.

-- 
Regards,

Laurent Pinchart
