Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EDC47260
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5DD21BE5
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5DD21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FF1B888CF;
	Mon,  4 May 2020 12:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVzZ68YVsIM8; Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1313E8895B;
	Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E9E5C088E;
	Mon,  4 May 2020 12:54:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C412C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 395C386C7E
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbN-TKNzYaKl for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7C69E86FBB
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:17 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 189864BB; Mon,  4 May 2020 14:54:15 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/5] iommu/amd: Update Device Table in increase_address_space()
Date: Mon,  4 May 2020 14:54:12 +0200
Message-Id: <20200504125413.16798-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The Device Table needs to be updated before the new page-table root
can be published in domain->pt_root. Otherwise a concurrent call to
fetch_pte might fetch a PTE which is not reachable through the Device
Table Entry.

Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 49 ++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d2499c86d395..2ae1daac888a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -101,6 +101,8 @@ struct kmem_cache *amd_iommu_irq_cache;
 static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
 static void detach_device(struct device *dev);
+static void update_and_flush_device_table(struct protection_domain *domain,
+					  struct domain_pgtable *pgtable);
 
 /****************************************************************************
  *
@@ -1461,8 +1463,16 @@ static bool increase_address_space(struct protection_domain *domain,
 
 	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
 
-	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode + 1);
+	pgtable.root  = pte;
+	pgtable.mode += 1;
+	update_and_flush_device_table(domain, &pgtable);
+	domain_flush_complete(domain);
 
+	/*
+	 * Device Table needs to be updated and flushed before the new root can
+	 * be published.
+	 */
+	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode);
 	atomic64_set(&domain->pt_root, root);
 
 	ret = true;
@@ -1893,19 +1903,17 @@ static bool dma_ops_domain(struct protection_domain *domain)
 }
 
 static void set_dte_entry(u16 devid, struct protection_domain *domain,
+			  struct domain_pgtable *pgtable,
 			  bool ats, bool ppr)
 {
-	struct domain_pgtable pgtable;
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable->mode != PAGE_MODE_NONE)
+		pte_root = iommu_virt_to_phys(pgtable->root);
 
-	if (pgtable.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(pgtable.root);
-
-	pte_root |= (pgtable.mode & DEV_ENTRY_MODE_MASK)
+	pte_root |= (pgtable->mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
@@ -1978,6 +1986,7 @@ static void clear_dte_entry(u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
+	struct domain_pgtable pgtable;
 	struct amd_iommu *iommu;
 	bool ats;
 
@@ -1993,7 +2002,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain, ats, dev_data->iommu_v2);
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	set_dte_entry(dev_data->devid, domain, &pgtable,
+		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
 
 	device_flush_dte(dev_data);
@@ -2304,22 +2315,34 @@ static int amd_iommu_domain_get_attr(struct iommu_domain *domain,
  *
  *****************************************************************************/
 
-static void update_device_table(struct protection_domain *domain)
+static void update_device_table(struct protection_domain *domain,
+				struct domain_pgtable *pgtable)
 {
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled,
-			      dev_data->iommu_v2);
+		set_dte_entry(dev_data->devid, domain, pgtable,
+			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(dev_data->pdev);
 	}
 }
 
+static void update_and_flush_device_table(struct protection_domain *domain,
+					  struct domain_pgtable *pgtable)
+{
+	update_device_table(domain, pgtable);
+	domain_flush_devices(domain);
+}
+
 static void update_domain(struct protection_domain *domain)
 {
-	update_device_table(domain);
+	struct domain_pgtable pgtable;
 
-	domain_flush_devices(domain);
+	/* Update device table */
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	update_and_flush_device_table(domain, &pgtable);
+
+	/* Flush domain TLB(s) and wait for completion */
 	domain_flush_tlb_pde(domain);
 	domain_flush_complete(domain);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
