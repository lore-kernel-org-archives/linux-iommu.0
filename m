From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 4/6] iommu/fsl: Add window permission flags for
	iommu_domain_window_enable API.
Date: Mon, 18 Feb 2013 18:22:17 +0530
Message-ID: <1361191939-21260-5-git-send-email-Varun.Sethi@freescale.com>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1361191939-21260-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Each iommu window can have access permissions associated with it. Extended the
window_enable API to incorporate window access permissions.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/iommu.c |    5 +++--
 include/linux/iommu.h |    7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b972d43..1a2564d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -854,12 +854,13 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
 
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-			       phys_addr_t paddr, u64 size)
+			       phys_addr_t paddr, u64 size, int iommu_prot)
 {
 	if (unlikely(domain->ops->domain_window_enable == NULL))
 		return -ENODEV;
 
-	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size);
+	return domain->ops->domain_window_enable(domain, wnd_nr, paddr, size,
+						 iommu_prot);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_window_enable);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba3b8a9..529987c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -105,7 +105,7 @@ struct iommu_ops {
 
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
-				    phys_addr_t paddr, u64 size);
+				    phys_addr_t paddr, u64 size, int iommu_prot);
 	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
 	/* Set the numer of window per domain */
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
@@ -171,7 +171,8 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-				      phys_addr_t offset, u64 size);
+				      phys_addr_t offset, u64 size,
+				      int iommu_prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
@@ -257,7 +258,7 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
-					     u64 size)
+					     u64 size, int iommu_prot)
 {
 	return -ENODEV;
 }
-- 
1.7.4.1
