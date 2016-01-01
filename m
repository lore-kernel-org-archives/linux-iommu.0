From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v2 3/6] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Fri, 1 Jan 2016 12:13:37 -0600
Message-ID: <1451672020-2150-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

This patch introduces amd_iommu_get_num_iommus(). Initially, this is
intended to be used by Perf AMD IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c            | 8 +++++++-
 include/linux/perf/perf_event_amd_iommu.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 275c0f5..33dbf3f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1030,7 +1030,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
-	iommu->index             = amd_iommus_present++;
+	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
 		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
@@ -2244,6 +2244,12 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
+int amd_iommu_get_num_iommus(void)
+{
+	return amd_iommus_present;
+}
+EXPORT_SYMBOL(amd_iommu_get_num_iommus);
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
index 815eabb..cb820c2 100644
--- a/include/linux/perf/perf_event_amd_iommu.h
+++ b/include/linux/perf/perf_event_amd_iommu.h
@@ -25,6 +25,8 @@
 #define PC_MAX_SPEC_CNTRS			16
 
 /* amd_iommu_init.c external support functions */
+extern int amd_iommu_get_num_iommus(void);
+
 extern bool amd_iommu_pc_supported(void);
 
 extern u8 amd_iommu_pc_get_max_banks(void);
-- 
1.9.1
