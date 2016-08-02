From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 2/8] iommu/arm-smmu: initialize the msi geometry and
	advertise iommu-msi support
Date: Tue,  2 Aug 2016 17:15:31 +0000
Message-ID: <1470158137-6931-3-git-send-email-eric.auger@redhat.com>
References: <1470158137-6931-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158137-6931-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On ARM, MSI write transactions from device upstream to the smmu
are conveyed through the iommu. Therefore target physical addresses
must be mapped and DOMAIN_ATTR_MSI_GEOMETRY advertises the support of
the IOMMU-MSI API.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v8 -> v9:
- reword the title and patch description

v7 -> v8:
- use DOMAIN_ATTR_MSI_GEOMETRY

v4 -> v5:
- don't handle fsl_pamu_domain anymore
- handle arm-smmu-v3
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5f6b3bc..066d92c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1397,6 +1397,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -1415,6 +1416,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		kfree(smmu_domain);
 		return NULL;
 	}
+	smmu_domain->domain.msi_geometry = msi_geometry;
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9345a3f..9755a1b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1038,6 +1038,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -1056,6 +1057,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	smmu_domain->domain.msi_geometry = msi_geometry;
+
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
-- 
1.9.1
