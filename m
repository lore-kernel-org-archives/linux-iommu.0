From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH v2 1/4] iommu/amd: Fix grammar of comments
Date: Mon,  7 May 2018 14:53:26 +0200
Message-ID: <20180507125329.24648-2-anna-maria@linutronix.de>
References: <20180507125329.24648-1-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180507125329.24648-1-anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Suggested-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c737fffe..6f13c03eba62 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1939,8 +1939,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
 }
 
 /*
- * If a device is not yet associated with a domain, this function does
- * assigns it visible for the hardware
+ * If a device is not yet associated with a domain, this function makes the
+ * device visible in the domain
  */
 static int __attach_device(struct iommu_dev_data *dev_data,
 			   struct protection_domain *domain)
@@ -2061,8 +2061,8 @@ static bool pci_pri_tlp_required(struct pci_dev *pdev)
 }
 
 /*
- * If a device is not yet associated with a domain, this function
- * assigns it visible for the hardware
+ * If a device is not yet associated with a domain, this function makes the
+ * device visible in the domain
  */
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
-- 
2.15.1
