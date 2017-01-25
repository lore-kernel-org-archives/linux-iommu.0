From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC 4/4] iommu: ipmmu-vmsa: enable force_reset_when_empty
Date: Wed, 25 Jan 2017 21:54:02 +0900
Message-ID: <1485348842-23712-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: magnus.damm@gmail.com, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: iommu@lists.linux-foundation.org

The IPMMU of R-Car Gen3 will mistake an address translation if
IMCTR.FLUSH is set while some related devices that on the same doamin
are running. To avoid this, this patch uses the force_reset_when_empty
feature.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 11550ac..4b62969 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -302,7 +302,8 @@ static void ipmmu_tlb_flush_all(void *cookie)
 {
 	struct ipmmu_vmsa_domain *domain = cookie;
 
-	ipmmu_tlb_invalidate(domain);
+	if (!domain->io_domain.geometry.force_reset_when_empty)
+		ipmmu_tlb_invalidate(domain);
 }
 
 static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
@@ -555,6 +556,13 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 	kfree(domain);
 }
 
+static void ipmmu_domain_reset(struct iommu_domain *io_domain)
+{
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+
+	ipmmu_tlb_invalidate(domain);
+}
+
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
@@ -832,6 +840,7 @@ static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.domain_free = ipmmu_domain_free,
+	.domain_reset = ipmmu_domain_reset,
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
@@ -858,8 +867,10 @@ static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
 
 	case IOMMU_DOMAIN_DMA:
 		io_domain = __ipmmu_domain_alloc(type);
-		if (io_domain)
+		if (io_domain) {
 			iommu_get_dma_cookie(io_domain);
+			io_domain->geometry.force_reset_when_empty = true;
+		}
 		break;
 	}
 
@@ -927,6 +938,7 @@ static int ipmmu_of_xlate_dma(struct device *dev,
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc_dma,
 	.domain_free = ipmmu_domain_free_dma,
+	.domain_reset = ipmmu_domain_reset,
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
-- 
1.9.1
