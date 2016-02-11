From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 3/6] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Thu, 11 Feb 2016 16:15:24 +0700
Message-ID: <1455182127-17551-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: andihartmann@freenet.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

This patch introduces amd_iommu_get_num_iommus(). Initially, this is
intended to be used by Perf AMD IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/include/asm/perf/amd/iommu.h | 2 ++
 drivers/iommu/amd_iommu_init.c        | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/perf/amd/iommu.h b/arch/x86/include/asm/perf/amd/iommu.h
index 97e1be5..40919eb 100644
--- a/arch/x86/include/asm/perf/amd/iommu.h
+++ b/arch/x86/include/asm/perf/amd/iommu.h
@@ -25,6 +25,8 @@
 #define PC_MAX_SPEC_CNTRS			16
 
 /* amd_iommu_init.c external support functions */
+int amd_iommu_get_num_iommus(void);
+
 bool amd_iommu_pc_supported(void);
 
 u8 amd_iommu_pc_get_max_banks(void);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a62b5ce..ffa057e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1030,7 +1030,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
-	iommu->index             = amd_iommus_present++;
+	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
 		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
@@ -2244,6 +2244,11 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
+int amd_iommu_get_num_iommus(void)
+{
+	return amd_iommus_present;
+}
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
-- 
2.5.0
