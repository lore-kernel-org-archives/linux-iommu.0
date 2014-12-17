From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Fix dmar_domain leak in iommu_attach_device
Date: Wed, 17 Dec 2014 11:43:36 +0100
Message-ID: <1418813017-24888-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Since commit 1196c2f a domain is only destroyed in the
notifier path if it is hot-unplugged. This caused a
domain leakage in iommu_attach_device when a driver was
unbound from the device and bound to VFIO. In this case the
device is attached to a new domain and unlinked from the old
domain. At this point nothing points to the old domain
anymore and its memory is leaked.
Fix this by explicitly freeing the old domain in
iommu_attach_domain.

Fixes: 1196c2f (iommu/vt-d: Fix dmar_domain leak in iommu_attach_device)
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.18
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1232336..7610121 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4428,6 +4428,10 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 				domain_remove_one_dev_info(old_domain, dev);
 			else
 				domain_remove_dev_info(old_domain);
+
+			if (!domain_type_is_vm_or_si(old_domain) &&
+			     list_empty(&old_domain->devices))
+				domain_exit(old_domain);
 		}
 	}
 
-- 
1.9.1
