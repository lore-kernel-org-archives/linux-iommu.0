From: Iago Abal <iari-YidNj35/HaM@public.gmane.org>
Subject: [PATCH] iommu: fix double spin_lock_irqsave on `device_domain_lock'
Date: Mon, 17 Oct 2016 10:54:40 +0200
Message-ID: <1476694480-4251-1-git-send-email-iari@itu.dk>
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
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Iago Abal <mail-nS/Qcn0WMKPsq35pWSNszA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Iago Abal <mail-nS/Qcn0WMKPsq35pWSNszA@public.gmane.org>

The EBA code analyzer (https://github.com/models-team/eba) reported
the following double lock:

    1. In function `disable_dmar_iommu' defined at 1706;
    2. the lock `device_domain_lock' is first taken in line 1714:

           // FIRST
           spin_lock_irqsave(&device_domain_lock, flags);

    3. enter the `list_for_each_entry_safe' loop at 1715;
    4. call function `dmar_remove_one_dev_info' (defined at 4851) in line 1726;
    5. finally, the lock is taken a second time in line 4857:

           // SECOND: DOUBLE LOCK !!!
           spin_lock_irqsave(&device_domain_lock, flags);

In addition, within that same loop, there is also a call to `domain_exit', which
calls to `domain_remove_dev_info', which also spin_lock on `device_domain_lock'.

I fixed the potential deadlock by releasing the `device_domain_lock' during the
execution of the loop body. This seems to respect the locking assumptions made
by the rest of the code: both `dmar_remove_one_dev_info' and `domain_exit' will
(directly or indiretly) take that look, so they should not be called with it held.
Function `domain_type_is_vm_or_si' just checks `domain->flags' and there seem
to be no concurrent writes to this field.

Signed-off-by: Iago Abal <mail-nS/Qcn0WMKPsq35pWSNszA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..05796a8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1721,12 +1721,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		if (!info->dev || !info->domain)
 			continue;
 
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+
 		domain = info->domain;
 
 		dmar_remove_one_dev_info(domain, info->dev);
 
 		if (!domain_type_is_vm_or_si(domain))
 			domain_exit(domain);
+
+		spin_lock_irqsave(&device_domain_lock, flags);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
-- 
1.9.1
