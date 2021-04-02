Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAB5C433ED
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985BE610CE
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985BE610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E2334066C;
	Fri,  2 Apr 2021 14:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id meFdaTli_MgI; Fri,  2 Apr 2021 14:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A43440224;
	Fri,  2 Apr 2021 14:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35B68C000B;
	Fri,  2 Apr 2021 14:33:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B06CCC000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CBC084BB2
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBbWVuEaspOg for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0543984BCF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=RCaGDS64Qjh91OzspK20qUmcNHQhy3C1RLZNGlz0c+0=; b=yKviUgHCtKj5qPUOm33g+by/VE
 WtVxMpnsXrLEU6c8VUNfRhq/HcUAdGky8hZviN46looHzcGewJWwkD6c92SKaKIAq4nRm3WODPjYN
 1IqpYcv+mleLEBLAKLR93xccpa03E2couGbrQF+u9GYRyA+hsz5nSBN72G3SPOsdKB1G+MwCDGwVa
 VP961q66Uc1EqbFbHWt8rNT50Pz9kPtSiXgBaSXW3bVAdVBkwFdbM0JWf12yGEhl318Xtjn4zFqMM
 hykrI+1V/3AA4Vt+pkZVditOKwQ40GAGKtGu8H7EIVUp79v7Mq7rgJsLDhnIQIuP+TRZ+8tCiFybK
 BHo9afzQ==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lSKrU-00FAFi-VQ; Fri, 02 Apr 2021 14:33:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/4] iommu/amd: move a few prototypes to
 include/linux/amd-iommu.h
Date: Fri,  2 Apr 2021 16:33:12 +0200
Message-Id: <20210402143312.372386-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210402143312.372386-1-hch@lst.de>
References: <20210402143312.372386-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

A few functions that were intentended for the perf events support are
currently declared in arch/x86/events/amd/iommu.h, which mens they are
not in scope for the actual function definition.  Also amdkfd has started
using a few of them using externs in a .c file.  End that misery by
moving the prototypes to the proper header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/events/amd/iommu.c            |  1 +
 arch/x86/events/amd/iommu.h            | 19 -------------------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c |  4 ----
 drivers/iommu/amd/amd_iommu.h          |  1 -
 include/linux/amd-iommu.h              | 12 ++++++++++++
 5 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index be50ef8572cceb..a573fac1ece8c8 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <linux/slab.h>
+#include <linux/amd-iommu.h>
 
 #include "../perf_event.h"
 #include "iommu.h"
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 0e5c036fd7bea1..095505c6213b03 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -21,23 +21,4 @@
 #define PC_MAX_SPEC_BNKS			64
 #define PC_MAX_SPEC_CNTRS			16
 
-struct amd_iommu;
-
-/* amd_iommu_init.c external support functions */
-extern int amd_iommu_get_num_iommus(void);
-
-extern bool amd_iommu_pc_supported(void);
-
-extern u8 amd_iommu_pc_get_max_banks(unsigned int idx);
-
-extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
-
-extern int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value);
-
-extern int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value);
-
-extern struct amd_iommu *get_amd_iommu(int idx);
-
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 66bbca61e3ef5e..3c56333bbb9cdd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -329,10 +329,6 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	return 0;
 }
 
-extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
-
 /** kfd_iommu_add_perf_counters - Add IOMMU performance counters to topology
  */
 int kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ed46dc754a2ad4..55dd38d814d926 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,7 +11,6 @@
 
 #include "amd_iommu_types.h"
 
-extern int amd_iommu_get_num_iommus(void);
 extern int amd_iommu_init_dma_ops(void);
 extern int amd_iommu_init_passthrough(void);
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 474065ed88a495..58e6c3806c09d4 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -10,6 +10,8 @@
 
 #include <linux/types.h>
 
+struct amd_iommu;
+
 /*
  * This is mainly used to communicate information back-and-forth
  * between SVM and IOMMU for setting up and tearing down posted
@@ -194,4 +196,14 @@ static inline int amd_iommu_deactivate_guest_mode(void *data)
 }
 #endif /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
+int amd_iommu_get_num_iommus(void);
+bool amd_iommu_pc_supported(void);
+u8 amd_iommu_pc_get_max_banks(unsigned int idx);
+u8 amd_iommu_pc_get_max_counters(unsigned int idx);
+int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
+		u64 *value);
+int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
+		u64 *value);
+struct amd_iommu *get_amd_iommu(unsigned int idx);
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
