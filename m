Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80629C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 10:43:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E565B600EF
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 10:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E565B600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 862FF6F593;
	Tue,  2 Mar 2021 10:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1nvtF2dfAIW; Tue,  2 Mar 2021 10:43:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66CF56F5EC;
	Tue,  2 Mar 2021 10:43:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 419A4C000A;
	Tue,  2 Mar 2021 10:43:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2091CC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8376A43103
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NjtdfxAKEXLk for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 10:43:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68AB1430D8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 10:43:05 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id v15so19325977wrx.4
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 02:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=16ndR0culV70eBRfrAIf/Iqsopy47tMS+8Hc4+8NLq4=;
 b=LNIfD2/9kUa5gsShvPrj9HSoAezE4hGXMEtjwCwql99NspoIMcYCDiJOmWmzlZWr3N
 FflwBo7hbWoZgs62C+5WCMzHmnHq6N8sDITI9X+XJSFfbNZ2+Hs8zMsnoksPTCiZlC1s
 hA+AeEL/HCd0lwgXSH/pOhgTJSFYYFAYVdit12hO9ZsH7L5K7vqdbWoiMBfQGc1GcTHz
 mQV1e+EysS6POIx+8gQkbMAkf+pIEheLVw2qYJ5StSJ1EGORwlLuBGucducX5xG/RvXZ
 21FASigLJUog8BQl/tn8D6rshtfS0KNvdtHOYjhsKD49Oj5oY2HDOkfLDwd4Oanb55Tl
 SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=16ndR0culV70eBRfrAIf/Iqsopy47tMS+8Hc4+8NLq4=;
 b=RByjLVELKcPBfViXDdjzLVk555Hc3YP+X4d4QdHoyOt6BdXGlVOR5iyWHjKKiG5u0e
 vcaCiLGxUZNiOm6KwNuwE8X7MMjDq2x8BnFNSFeTtYAiE5Ecu5e4C+ygL+S4mvwOKHrf
 KDoZvD2++9FpSjLbnUedjoREwflarLUdugbBBFDUHeF4R5WMcJvyJxE2jiMEweGsSk4B
 f32A/cM8UtC55Q96Iqlx8uydMV3Nw7xFCVm2ETLDH9a7JzIbr2uuYsebZZhFAEi4THMj
 lcfpgJv6nhtxQf2ePF8+rf/PEp/9+y+fU9eKQMsqPZl03KkXLJKn/cTtRgvAoV0YVcUX
 5Ukg==
X-Gm-Message-State: AOAM532PV/GMA8H0ck33qSkKaJhFwtP3r85V1GtDpWtme6epYR/UImPS
 5SWZX31b3yOxIV7qEOwxy+UBjg==
X-Google-Smtp-Source: ABdhPJw/LEgT2VB6PYvwcSM0I19tDQNUmxKIzuQ2IHCBj9pgXC2hbaDJkSeAiI1c7DsPknzgbrGKhg==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr21077411wrs.317.1614681783671; 
 Tue, 02 Mar 2021 02:43:03 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u63sm2146457wmg.24.2021.03.02.02.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 02:43:03 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: akpm@linux-foundation.org
Subject: [PATCH] mm/fork: Clear PASID for new mm
Date: Tue,  2 Mar 2021 11:38:40 +0100
Message-Id: <20210302103837.2562625-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, zhangfei.gao@foxmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

From: Fenghua Yu <fenghua.yu@intel.com>

When a new mm is created, its PASID should be cleared, i.e. the PASID is
initialized to its init state 0 on both ARM and X86.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This patch was part of the series introducing mm->pasid, but got lost
along the way [1]. It still makes sense to have it, because each address
space has a different PASID. And the IOMMU code in iommu_sva_alloc_pasid()
expects the pasid field of a new mm struct to be cleared.

[1] https://lore.kernel.org/linux-iommu/YDgh53AcQHT+T3L0@otcwcpicx3.sc.intel.com/
---
 include/linux/mm_types.h | 1 +
 kernel/fork.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0974ad501a47..6613b26a8894 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -23,6 +23,7 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
+#define INIT_PASID	0
 
 struct address_space;
 struct mem_cgroup;
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..808af2cc8ab6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -994,6 +994,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
+static void mm_init_pasid(struct mm_struct *mm)
+{
+#ifdef CONFIG_IOMMU_SUPPORT
+	mm->pasid = INIT_PASID;
+#endif
+}
+
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1024,6 +1031,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
+	mm_init_pasid(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
