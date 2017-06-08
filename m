From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/2] acpica: iort: Update SMMUv3 header for proximity
	domain mapping
Date: Thu,  8 Jun 2017 10:14:18 +0530
Message-ID: <1496897059-8272-2-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ARM IORT specification (rev. C) has added two new fields to define
proximity domain for the SMMUv3 node in the IORT table.

Proximity Domain Valid:
	Set to 1 if the value provided in the Proximity Domain field is
	valid. Set to 0 otherwise.

Proximity domain:
	If the Proximity Domain Valid flag is set to 1, this entry
	provides the proximity domain to which this SMMU
	instance belongs.

Update header file to reflect this.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 include/acpi/actbl2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 4b306a6..389e91f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
 	u32 pri_gsiv;
 	u32 gerr_gsiv;
 	u32 sync_gsiv;
+	u8 pxm;
+	u8 reserved1;
+	u16 reserved2;
 };
 
 /* Values for Model field above */
@@ -817,6 +820,7 @@ struct acpi_iort_smmu_v3 {
 
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
 #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
 
 /*******************************************************************************
  *
-- 
1.8.1.4
