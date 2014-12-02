From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix an off-by-one bug in __domain_mapping()
Date: Tue, 2 Dec 2014 13:04:30 +0100
Message-ID: <20141202120430.GA32294@8bytes.org>
References: <1416966130-866-1-git-send-email-jiang.liu@linux.intel.com>
	<20141201162740.GK3762@8bytes.org>
	<1417516475.5525.57.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417516475.5525.57.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 02, 2014 at 10:34:35AM +0000, David Woodhouse wrote:
> __domain_mapping() is an amalgamation of the old domain_pfn_mapping()
> and domain_sg_mapping() functions. When I did that, in commit 9051aa026,
> the 'sg_res' variable was used *only* for tracking how many pages were
> left in the current scatterlist element, before we had to get the next
> one from the sglist.
> 
> For reasons which are lost now, in the case of a simple pfn range I was
> setting 'sg_res = nr_pages + 1' to ensure that we *never* got down to
> sg_res=0 and tried to look for more from the (non-existent, in this
> case) sglist.
> 
> Later in commit 6dd9a7c73 we added large page support, using sg_res in a
> way which actually required it to be accurate. And now we have an
> off-by-one because we'll actually *try* to use a 2GiB large page for a
> mapping of size 0x1ff000, because of that '+1'.
> 
> The BUG_ON is entirely correct here, and correctly highlighted the
> problem.
> 
> However, the +1 is no longer necessary, because the check that needed it
> was also modified to read 'if (sg_res && nr_pages)', which is perfectly
> sufficient and arguably how it should have been done in the first place.
> 
> I had an almost identical patch last week for internal testing, because
> I stupidly hadn't noticed that Jiang had beaten me to it.
> 
> Acked-By: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> > > 	This issue was introduced in v2.6.31, but intel-iommu.c has
> > > been moved into drivers/iommu in v3.1. So what's the preferred way
> > > to deal with stable kernels between v2.6.31 and v3.1?
> > 
> > Just remove the kernel version marker from the stable tag. The stable
> > kernel maintainers for kernels >3.1 will ask you to backport the patch
> > or just backport it by themselfes.
> 
> I think this is only an issue since commit 6dd9a7c737 added super page
> support in 3.0, isn't it? Before that, the +1 was *needed*.

Okay guys, thanks for the explanations. I applied the patch to the
x86/vt-d branch and changed the stable tag to >= 3.0.


	Joerg
