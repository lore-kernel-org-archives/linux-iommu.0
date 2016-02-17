From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
	support
Date: Wed, 17 Feb 2016 14:31:07 +0000
Message-ID: <20160217143106.GC1459@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
	<1453857386.28284.4.camel@mhfsdcap03> <56AA1A89.6080706@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56AA1A89.6080706-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Jan 28, 2016 at 01:41:29PM +0000, Robin Murphy wrote:
> On 27/01/16 01:16, Yong Wu wrote:
> >On Tue, 2016-01-26 at 17:13 +0000, Robin Murphy wrote:
> >>Add a nearly-complete ARMv7 short descriptor implementation, omitting
> >>only a few legacy and CPU-centric aspects which shouldn't be necessary
> >>for IOMMU API use anyway.
> >>
> >>Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >>Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >
> >This looks good to me.
> >And actually our disp/vdec/venc works well on your v2.
> >
> >You could choose the two below,
> >Reviewed-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Great, thanks!
> 
> Will, it seems to make the most sense for Joerg to pick these patches up
> directly with the MTK series that depends on them - any objections?

As discussed with Joerg, I'll pick these up and send him a pull request
containing all the pgtable bits. I've taken the liberty of updating
MAINTAINERS too, assuming you don't mind being a reviewer for this?

Will

--->8

>From bccb08d096703bd790fcf2f934553dd9c8503fc9 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Date: Wed, 17 Feb 2016 14:18:00 +0000
Subject: [PATCH] MAINTAINERS: update ARM SMMU entry

Ensure that the short-descriptor page table code is included under the
SMMU entry, and add Robin as a designated reviewer.

Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2f753cb357..a01bae148b89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,11 +1793,13 @@ F:	drivers/edac/synopsys_edac.c
 
 ARM SMMU DRIVERS
 M:	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
+R:	Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
 L:	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/iommu/arm-smmu.c
 F:	drivers/iommu/arm-smmu-v3.c
 F:	drivers/iommu/io-pgtable-arm.c
+F:	drivers/iommu/io-pgtable-arm-v7s.c
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
-- 
2.1.4
