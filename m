Return-Path: <SRS0=F1RC=PL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A645C433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Oct 2021 19:49:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C86A60F36
	for <iommu@archiver.kernel.org>; Sat, 23 Oct 2021 19:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C86A60F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CE36606FA;
	Sat, 23 Oct 2021 19:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PtvAqjnAWoTK; Sat, 23 Oct 2021 19:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 370A8605D2;
	Sat, 23 Oct 2021 19:49:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9FEC0012;
	Sat, 23 Oct 2021 19:49:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3544DC000E
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 19:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BE6040314
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 19:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oBuDfYMSPg6t for <iommu@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 19:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06F03402F1
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 19:49:47 +0000 (UTC)
Received: from pop-os.home ([92.140.161.106]) by smtp.orange.fr with ESMTPA
 id eN1TmCsSATdRTeN1TmKNqu; Sat, 23 Oct 2021 21:49:45 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Oct 2021 21:49:45 +0200
X-ME-IP: 92.140.161.106
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
Date: Sat, 23 Oct 2021 21:49:42 +0200
Message-Id: <cb7a3e0a8d522447a06298a4f244c3df072f948b.1635018498.git.christophe.jaillet@wanadoo.fr>
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

'iommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify code
and improve the semantic.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/intel/iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..2ae75b7f7dec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1880,17 +1880,16 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
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
 
@@ -1905,7 +1904,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	if (!iommu->domains || !iommu->domains[0]) {
 		pr_err("%s: Allocating domain array failed\n",
 		       iommu->name);
-		kfree(iommu->domain_ids);
+		bitmap_free(iommu->domain_ids);
 		kfree(iommu->domains);
 		iommu->domain_ids = NULL;
 		iommu->domains    = NULL;
@@ -1966,7 +1965,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
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
