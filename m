From: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RFC: additional domain attributes specific to PAMU
Date: Mon, 4 Feb 2013 21:37:20 -0600
Message-ID: <CALRxmdChbSk1gLXc2pqVd0GPdM09SofyjA5L_KuvSn4SQZJoXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg,

The attributes you have defined look good and are mechanisms we need
to determine if iommu is aperture based, get max # of windows, set
actual number of windows, etc.

However, there are a couple of other attributes we need:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8330df1..0038c39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -61,6 +61,8 @@ enum iommu_attr {
        DOMAIN_ATTR_GEOMETRY,
        DOMAIN_ATTR_PAGING,
        DOMAIN_ATTR_WINDOWS,
+       DOMAIN_ATTR_ENABLE,
+       DOMAIN_ATTR_FSL_PAMUV1,
        DOMAIN_ATTR_MAX,
 };

We need a mechanism to enable/disable the overall aperture, and that
is what DOMAIN_ATTR_ENABLE is for.   After everything is configured we
enable the overall aperture...and can't do it before.

There are a lot of quirky, very specific constraints that apply to
PAMU only (most likely) and may not be generic.   Here are the ones I
can think of:
   -aperture must be power of 2, and naturally aligned
   -number of windows must be power of 2, and address space size
    of each window is determined by aperture size / # of windows
   -the actual size of the mapped region of a window must be power
    of 2 starting with 4KB and physical address must be
    naturally aligned

Instead of advertising those constraints somehow, it seem easier just
to advertise that this IOMMU is a PAMU v1.  The attribute would be
read only and would be a boolean--  if the attribute is present then
it's a PAMU v1.

Wanted to get your thoughts on that.

Thanks,
Stuart
