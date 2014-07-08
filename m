From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Moving PPR fault flags macros definitions
Date: Tue, 8 Jul 2014 17:30:17 +0300
Message-ID: <1404829817-19584-2-git-send-email-oded.gabbay@amd.com>
References: <1404829817-19584-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404829817-19584-1-git-send-email-oded.gabbay-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>

Any kernel source registering the invalid PPR calback may include the header file with PPR fault flags macros definitions.
Thus we move them to include/linux/amd-iommu.h

Signed-off-by: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_types.h | 6 ------
 include/linux/amd-iommu.h       | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 557a20e..8e43b7c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -390,12 +390,6 @@ struct amd_iommu_fault {
 
 };
 
-#define PPR_FAULT_EXEC	(1 << 1)
-#define PPR_FAULT_READ  (1 << 2)
-#define PPR_FAULT_WRITE (1 << 5)
-#define PPR_FAULT_USER  (1 << 6)
-#define PPR_FAULT_RSVD  (1 << 7)
-#define PPR_FAULT_GN    (1 << 8)
 
 struct iommu_domain;
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 15f6b9e..2b08e79 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -119,6 +119,13 @@ typedef int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev,
 extern int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
 					amd_iommu_invalid_ppr_cb cb);
 
+#define PPR_FAULT_EXEC	(1 << 1)
+#define PPR_FAULT_READ  (1 << 2)
+#define PPR_FAULT_WRITE (1 << 5)
+#define PPR_FAULT_USER  (1 << 6)
+#define PPR_FAULT_RSVD  (1 << 7)
+#define PPR_FAULT_GN    (1 << 8)
+
 /**
  * amd_iommu_device_info() - Get information about IOMMUv2 support of a
  *			     PCI device
-- 
1.9.1
