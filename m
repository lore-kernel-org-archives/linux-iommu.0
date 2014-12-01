From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix an off-by-one bug in __domain_mapping()
Date: Mon, 1 Dec 2014 17:27:40 +0100
Message-ID: <20141201162740.GK3762@8bytes.org>
References: <1416966130-866-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416966130-866-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 26, 2014 at 09:42:10AM +0800, Jiang Liu wrote:
> There's an off-by-one bug in function __domain_mapping(), which may
> trigger the BUG_ON(nr_pages < lvl_pages) when
> 	(nr_pages + 1) & superpage_mask == 0

What is the superpage_mask?

> The issue was introduced by commit 9051aa0268dc "intel-iommu: Combine
> domain_pfn_mapping() and domain_sg_mapping()", which sets sg_res to
> "nr_pages + 1" to avoid some of the 'sg_res==0' code paths.
> 
> It's safe to remove extra "+1" because sg_res is only used to calculate
> page size now.

>From your description and the (hard to read) code in __domain_mapping I
don't really understand the issue yet. Can you please elaborate on this
issue can be triggered?

Is the BUG_ON the only issue and, if yes, can that be fixed by just
changing the BUG_ON condition?

> 	This issue was introduced in v2.6.31, but intel-iommu.c has
> been moved into drivers/iommu in v3.1. So what's the preferred way
> to deal with stable kernels between v2.6.31 and v3.1?

Just remove the kernel version marker from the stable tag. The stable
kernel maintainers for kernels >3.1 will ask you to backport the patch
or just backport it by themselfes.


	Joerg
