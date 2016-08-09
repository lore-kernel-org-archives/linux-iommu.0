From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Tue, 09 Aug 2016 16:17:57 +0300
Message-ID: <7796705.iS1mBl6Cq9@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple>
	<2464365.ZvRSQB46Pc@avalon>
	<CANqRtoSfzZhMXwLpbwr2k22qgcA=GJ5pxV82FPLkB4FKOqsX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANqRtoSfzZhMXwLpbwr2k22qgcA=GJ5pxV82FPLkB4FKOqsX4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Wednesday 08 Jun 2016 18:12:31 Magnus Damm wrote:
> On Wed, Jun 8, 2016 at 5:48 PM, Laurent Pinchart wrote:
> > On Wednesday 08 Jun 2016 09:04:17 Geert Uytterhoeven wrote:
> >> On Wed, Jun 8, 2016 at 2:18 AM, Laurent Pinchart wrote:
> >>>> --- 0031/drivers/iommu/ipmmu-vmsa.c
> >>>> +++ work/drivers/iommu/ipmmu-vmsa.c   2016-06-06 11:19:40.210607110

[snip]

> >>>> @@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
> >>>>                ipmmu_vmsa_iommu_of_setup);
> >>>>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
> >>>>                ipmmu_vmsa_iommu_of_setup);
> >>>> +IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
> >>>> +              ipmmu_vmsa_iommu_of_setup);
> >>> 
> >>> How about a Gen3 generic compatible string in addition to the
> >>> SoC-specific ones ?
> >> 
> >> Do we want to specify the number of utlbs here?
> >> Does it differ between r8a7795, r8a7796, and future members?
> > 
> > It differs between IPMMU instances on a given SoC, so if we want to
> > specify it it should be a DT property.
> 
> Can you please point out which documentation that says it varies with
> IPMMU instance?
> 
> Based on IMUCTRn register description "H3-ES1" has 0-31 range while
> "Others" have 0-47.

The maximum number of uTLBs is indeed the same according to that part of the 
documentation, but not all uTLBs are available in all IPMMU instances. We even 
have holes in the uTLB ranges, maybe a mask would be more appropriate.

-- 
Regards,

Laurent Pinchart
