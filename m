Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C59C4332F
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 10:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D237A605CB;
	Tue, 23 Nov 2021 10:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJGIEhfhQFMJ; Tue, 23 Nov 2021 10:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 15C7F60622;
	Tue, 23 Nov 2021 10:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 009EFC001E;
	Tue, 23 Nov 2021 10:55:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEDDC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5854F40132
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IIujg7m7aHm0 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 10:55:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB8B640019
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:38 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adbee.dip0.t-ipconnect.de
 [84.154.219.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 4155ED7A;
 Tue, 23 Nov 2021 11:55:34 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/vt-d: Remove unused PASID_DISABLED
Date: Tue, 23 Nov 2021 11:55:06 +0100
Message-Id: <20211123105507.7654-2-joro@8bytes.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123105507.7654-1-joro@8bytes.org>
References: <20211123105507.7654-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

From: Joerg Roedel <jroedel@suse.de>

The macro is unused after commit 00ecd5401349a so it can be removed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 00ecd5401349a ("iommu/vt-d: Clean up unused PASID updating functions")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/fpu/api.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 6053674f9132..c2767a6a387e 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -102,12 +102,6 @@ extern void switch_fpu_return(void);
  */
 extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
-/*
- * Tasks that are not using SVA have mm->pasid set to zero to note that they
- * will not have the valid bit set in MSR_IA32_PASID while they are running.
- */
-#define PASID_DISABLED	0
-
 /* Trap handling */
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern void fpu_sync_fpstate(struct fpu *fpu);
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
