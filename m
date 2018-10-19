From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 5/6] iommu/arm-smmu-v3: Implement detach_dev op
Date: Fri, 19 Oct 2018 19:11:57 +0100
Message-ID: <20181019181158.2395-6-jean-philippe.brucker@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To prepare for auxiliary domains, add detach_dev() to the IOMMU ops.
There shouldn't be any functional change.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1da41fb8111e..665365b5f02e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2202,7 +2202,7 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	}
 }
 
-static void arm_smmu_detach_dev(struct device *dev)
+static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	unsigned long flags;
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
@@ -2241,8 +2241,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	ste = &master->ste;
 
 	/* Already attached to a different domain? */
-	if (ste->assigned)
-		arm_smmu_detach_dev(dev);
+	if (master->domain)
+		arm_smmu_detach_dev(&master->domain->domain, dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -2833,7 +2833,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	smmu = master->smmu;
 	iopf_queue_remove_device(dev);
 	if (master->ste.assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(&master->domain->domain, dev);
 	iommu_group_remove_device(dev);
 	arm_smmu_remove_master(smmu, master);
 	iommu_device_unlink(&smmu->iommu, dev);
@@ -2947,6 +2947,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
+	.detach_dev		= arm_smmu_detach_dev,
 	.sva_init_device	= arm_smmu_sva_init,
 	.sva_shutdown_device	= arm_smmu_sva_shutdown,
 	.mm_alloc		= arm_smmu_mm_alloc,
-- 
2.19.1
