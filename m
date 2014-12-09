From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Only remove domain when device is removed
Date: Tue, 9 Dec 2014 13:15:25 +0100
Message-ID: <20141209121525.GM3762@8bytes.org>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
	<1412074923-6342-3-git-send-email-joro@8bytes.org>
	<1415117537.27420.428.camel@ul30vt.home>
	<20141106125405.GI8354@suse.de>
	<1415290565.16601.92.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415290565.16601.92.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 06, 2014 at 09:16:05AM -0700, Alex Williamson wrote:
> But the domains are unlinked from device_domain_list using
> unlink_domain_info() which is called from both domain_remove_dev_info()
> and domain_remove_one_dev_info() which are both part of that more
> likely, unlikely branch in intel_iommu_attach_device().  So it seems
> like any time we switch a device from the DMA-API to the IOMMU-API, we
> lose the reference to the domain.  Is that incorrect?  I'll try to test.

Okay, I thought a while about that and it looks like a real fix needs a
rewrite of the domain handling code in the VT-d driver to better handle
domain lifetime. We'll get this for free when we add default domains and
more domain handling logic to the iommu core, so I think we don't need
to start rewriting the VT-d driver for this.
But for the time being, here is a simple fix for the leak in
iommu_attach_domain:

>From d65b236d0f27fe3ef7ac4d12cceb0da67aec86ce Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 9 Dec 2014 12:56:45 +0100
Subject: [PATCH] iommu/vt-d: Fix dmar_domain leak in iommu_attach_device

Since commit 1196c2f a domain is only destroyed in the
notifier path if it is hot-unplugged. This caused a
domain leakage in iommu_attach_device when a driver was
unbound from the device and bound to VFIO. In this case the
device is attached to a new domain and unlinked from the old
domain. At this point nothing points to the old domain
anymore and its memory is leaked.
Fix this by explicitly freeing the old domain in
iommu_attach_domain.

Fixes: 1196c2f 'iommu/vt-d: Only remove domain when device is removed'
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1232336..9ef8e89 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4424,10 +4424,13 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 		old_domain = find_domain(dev);
 		if (old_domain) {
-			if (domain_type_is_vm_or_si(dmar_domain))
+			if (domain_type_is_vm_or_si(dmar_domain)) {
 				domain_remove_one_dev_info(old_domain, dev);
-			else
+			} else {
 				domain_remove_dev_info(old_domain);
+				if (list_empty(&old_domain->devices))
+					domain_exit(old_domain);
+			}
 		}
 	}
 
-- 
1.8.4.5
