Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA75C433F5
	for <iommu@archiver.kernel.org>; Sat,  2 Apr 2022 10:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 348FE419DB;
	Sat,  2 Apr 2022 10:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bqx_GAFkpkHb; Sat,  2 Apr 2022 10:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D519E41916;
	Sat,  2 Apr 2022 10:20:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD5C9C001D;
	Sat,  2 Apr 2022 10:20:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC69C0012
 for <iommu@lists.linux-foundation.org>; Sat,  2 Apr 2022 10:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1300A83E74
 for <iommu@lists.linux-foundation.org>; Sat,  2 Apr 2022 10:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ra4ZvHP10PQH for <iommu@lists.linux-foundation.org>;
 Sat,  2 Apr 2022 10:20:14 +0000 (UTC)
X-Greylist: delayed 00:11:20 by SQLgrey-1.8.0
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1545A83E7B
 for <iommu@lists.linux-foundation.org>; Sat,  2 Apr 2022 10:20:14 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4KVt6V37fXz9sSQ;
 Sat,  2 Apr 2022 12:08:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjJaduITydCT; Sat,  2 Apr 2022 12:08:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4KVt6V2JbRz9sSK;
 Sat,  2 Apr 2022 12:08:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D47F8B76D;
 Sat,  2 Apr 2022 12:08:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iF9RxfsW8Iav; Sat,  2 Apr 2022 12:08:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0962E8B768;
 Sat,  2 Apr 2022 12:08:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 232A8cOS684345
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 2 Apr 2022 12:08:39 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 232A8c9u684344;
 Sat, 2 Apr 2022 12:08:38 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/fsl_pamu: Prepare cleanup of powerpc's asm/prom.h
Date: Sat,  2 Apr 2022 12:08:38 +0200
Message-Id: <06862cca930068e8fa4fdd0b20d74872d3b929d6.1648833431.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648894117; l=1091; s=20211009;
 h=from:subject:message-id; bh=NWEQQSEGweH5QQ1/ViVd36IBMW3h78Fi4MZNGXLHOCc=;
 b=EtgOic5Jx3wJmS0/Mu5+W3OalOOGwvbU49c1Af0rSKyzeq80mRmsol8y1c8nsH7AM3ZlxeYnoeAR
 RY64tCrYCeDsWZK2u7hyWOke0Smd2LWkKkZk6kiatMl1DI/4dnQz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
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

powerpc's asm/prom.h brings some headers that it doesn't
need itself.

In order to clean it up, first add missing headers in
users of asm/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/iommu/fsl_pamu.c        | 3 +++
 drivers/iommu/fsl_pamu_domain.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index fc38b1fba7cf..0d03f837a5d4 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -11,6 +11,9 @@
 #include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include <asm/mpc85xx.h>
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 69a4a62dc3b9..94b4589dc67c 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -9,6 +9,7 @@
 
 #include "fsl_pamu_domain.h"
 
+#include <linux/platform_device.h>
 #include <sysdev/fsl_pci.h>
 
 /*
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
