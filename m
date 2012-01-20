From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Fri, 20 Jan 2012 06:44:09 +0100
Message-ID: <20120120.074409.1835198567920956646.hdoyu@nvidia.com>
References: <201201191646.13798.laurent.pinchart@ideasonboard.com><20120119160739.GB2205@amd.com><201201191727.10176.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201201191727.10176.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org" <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 19 Jan 2012 17:27:09 +0100
Message-ID: <201201191727.10176.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> Hi Joerg,
> 
> On Thursday 19 January 2012 17:07:39 Joerg Roedel wrote:
> > On Thu, Jan 19, 2012 at 04:46:13PM +0100, Laurent Pinchart wrote:
> > > > +struct iommu_domain_geometry {
> > > > +	u64 aperture_start;	/* First address that can be mapped    */
> > > > +	u64 aperture_end;	/* Last address that can be mapped     */
> > > 
> > > Would it make sense to use a platform-dependent type that represents
> > > physical addresses instead of u64 ?
> > 
> > Well, u64 is a catch-all datatype which should suit all drivers. Is this
> > a problem at ARM?
> 
> No, it's not a problem for ARM, at least to my knowledge. It just struck me as 
> weird, as we have specific data types for other kinds of addresses (such as 
> dma_addr_t).
> 
> > We can also go the more complicated way of introducing an iova_addr_t or
> > something. But if possible I would like to avoid that.

"dma_addr_t" sounds nicer(and makes still sense) to me than a new "iova_addr_t".
