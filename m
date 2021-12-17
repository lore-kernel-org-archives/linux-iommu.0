Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A878C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 13:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84F02402E0;
	Fri, 17 Dec 2021 13:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZbkIk-U461xU; Fri, 17 Dec 2021 13:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D663401CA;
	Fri, 17 Dec 2021 13:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12121C002F;
	Fri, 17 Dec 2021 13:49:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 720BBC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 13:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5278741DD9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 13:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5cgp3TfBvlZ for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 13:49:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B632C41DBF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (ip5f5aed08.dynamic.kabel-deutschland.de
 [95.90.237.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E19661EA1924;
 Fri, 17 Dec 2021 14:49:37 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH] =?UTF-8?q?iommu/amd:=20Fix=20typo=20in=20*glues=20?=
 =?UTF-8?q?=E2=80=A6=20together*=20in=20comment?=
Date: Fri, 17 Dec 2021 14:49:16 +0100
Message-Id: <20211217134916.43698-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
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

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1eacd43cb436..29d55a99c39f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1523,7 +1523,7 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
 }
 
 /*
- * This function clues the initialization function for one IOMMU
+ * This function glues the initialization function for one IOMMU
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
  */
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
