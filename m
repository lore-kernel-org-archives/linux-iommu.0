From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 30/33] iommu/vt-d: Remove pdev from intel_iommu_attach_device()
Date: Fri, 21 Mar 2014 17:19:11 +0000
Message-ID: <1395422354-19762-31-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7b73c42..9a66bf7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4147,13 +4147,12 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
 	struct dmar_domain *dmar_domain = domain->priv;
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
 
-	/* normally pdev is not mapped */
-	if (unlikely(domain_context_mapped(&pdev->dev))) {
+	/* normally dev is not mapped */
+	if (unlikely(domain_context_mapped(dev))) {
 		struct dmar_domain *old_domain;
 
 		old_domain = find_domain(dev);
-- 
1.8.5.3
