From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/11] iommu/ipmmu-vmsa: Write IMCTR twice
Date: Mon, 06 Jun 2016 12:58:40 +0900
Message-ID: <20160606035840.31763.40773.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Write IMCTR both in the root device and the leaf node.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- 0021/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:03:22.610607110 +0900
@@ -261,6 +261,16 @@ static void ipmmu_ctx_write(struct ipmmu
 	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
+static void ipmmu_ctx_write2(struct ipmmu_vmsa_domain *domain, unsigned int reg,
+			     u32 data)
+{
+	if (domain->mmu != domain->root)
+		ipmmu_write(domain->mmu,
+			    domain->context_id * IM_CTX_SIZE + reg, data);
+
+	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
+}
+
 /* -----------------------------------------------------------------------------
  * TLB and microTLB Management
  */
@@ -287,7 +297,7 @@ static void ipmmu_tlb_invalidate(struct
 
 	reg = ipmmu_ctx_read(domain, IMCTR);
 	reg |= IMCTR_FLUSH;
-	ipmmu_ctx_write(domain, IMCTR, reg);
+	ipmmu_ctx_write2(domain, IMCTR, reg);
 
 	ipmmu_tlb_sync(domain);
 }
@@ -445,7 +455,8 @@ static int ipmmu_domain_init_context(str
 	 * software management as we have no use for it. Flush the TLB as
 	 * required when modifying the context registers.
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+	ipmmu_ctx_write2(domain, IMCTR,
+			 IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
 
 	return 0;
 }
@@ -471,7 +482,7 @@ static void ipmmu_domain_destroy_context
 	 *
 	 * TODO: Is TLB flush really needed ?
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
+	ipmmu_ctx_write2(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
 	ipmmu_domain_free_context(domain->root, domain->context_id);
 }
