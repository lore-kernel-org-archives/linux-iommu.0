Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5450BC433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 21:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E406A611A4;
	Fri, 17 Dec 2021 21:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bV6qZmvz7I7E; Fri, 17 Dec 2021 21:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFBCD6117D;
	Fri, 17 Dec 2021 21:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA220C002F;
	Fri, 17 Dec 2021 21:59:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FEFFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 21:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AA2340192
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 21:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOx4yO9UKYUJ for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 21:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr
 [80.12.242.125])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E240A40C4A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 21:59:01 +0000 (UTC)
Received: from pop-os.home ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id yLFamDpNSUGqlyLFamEgAB; Fri, 17 Dec 2021 22:58:59 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 17 Dec 2021 22:58:59 +0100
X-ME-IP: 86.243.171.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
Date: Fri, 17 Dec 2021 22:58:49 +0100
Message-Id: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

'ommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify
code and improve the semantic, instead of hand writing it.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/intel/iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b6a8f3282411..4acc97765209 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1878,17 +1878,16 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
-	u32 ndomains, nlongs;
+	u32 ndomains;
 	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
 	pr_debug("%s: Number of Domains supported <%d>\n",
 		 iommu->name, ndomains);
-	nlongs = BITS_TO_LONGS(ndomains);
 
 	spin_lock_init(&iommu->lock);
 
-	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
+	iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
 	if (!iommu->domain_ids)
 		return -ENOMEM;
 
@@ -1903,7 +1902,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	if (!iommu->domains || !iommu->domains[0]) {
 		pr_err("%s: Allocating domain array failed\n",
 		       iommu->name);
-		kfree(iommu->domain_ids);
+		bitmap_free(iommu->domain_ids);
 		kfree(iommu->domains);
 		iommu->domain_ids = NULL;
 		iommu->domains    = NULL;
@@ -1964,7 +1963,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		for (i = 0; i < elems; i++)
 			kfree(iommu->domains[i]);
 		kfree(iommu->domains);
-		kfree(iommu->domain_ids);
+		bitmap_free(iommu->domain_ids);
 		iommu->domains = NULL;
 		iommu->domain_ids = NULL;
 	}
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
