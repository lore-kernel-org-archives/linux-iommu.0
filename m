Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733AEC433FE
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 13:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08EF941853;
	Tue, 26 Apr 2022 13:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jfc0YVmF4hFv; Tue, 26 Apr 2022 13:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7F0AA417D2;
	Tue, 26 Apr 2022 13:06:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59F11C0032;
	Tue, 26 Apr 2022 13:06:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4803DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26D3840272
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mahnRL-RJwLU for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 13:06:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5730B4019F
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:06:48 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id i27so35923880ejd.9
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mwzH9W7Cu0qz9AyabHpIFVDOQWWOlWSfNGPXeS7fSYg=;
 b=oR6kM84QR4mwVawVtrWWbZAFckuRHFg4rb1d1y9tE+rCoRPyzOjazyqGFToLZnpxUg
 yFTqPNKZzAC9jUWKF7MLSw2fP3SSqQ7RxiWMwhjIQC+sABP4Kdgd+jjnlRVQna9ZbFzk
 zvPDzBxYQ8Gkv8wX4TBBEF4u0EvnKPxRK+ZHkviLVOqFSXPUR4RllIfLBPzODgalTdY6
 x61G8eR5pFJ6ECAPmVok5fUjdvYZyS+vtGkvE5wSDmfLqpeIGth3gqPrTkoIVkUJ/3eL
 VdmVRFHQ7rYoS1us6SSpMTcWprKVYXzI+wRbi36FyZuZxSrMh4UhP/WT8toSmApZjSlq
 CdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mwzH9W7Cu0qz9AyabHpIFVDOQWWOlWSfNGPXeS7fSYg=;
 b=KT4T8srgFMVcZiUO3iAg9/1qVk0HxbjhoAC3HQHWTu3nIAeEj/sWmPGqjCRUG5WEQr
 Ac7h7NZSWrmDxaTwE46h6i5IQGd+KfdZs7FANGuOuwpBMsmFcSCmzq2TzYDwHpKxSbMq
 jgHgF1aM9U7hU7icLq5jyGLxa6DbctB2ws/IZGz17C8VsySuQoGRLGykNKnvQst8jq8b
 arfNlq5DIgjFUkeTa+EC52p+8MfVJYPaAgces8V9FyS5b2nPmVW9Ietyabd6PAuhOvvT
 VgK9EJJOD34PGdCsnzIc7VrjG1NWez+INzrfbDqSoxp3NGTcCKRQrakpqEsPVIQahMRq
 wShg==
X-Gm-Message-State: AOAM530xTGBcF/crPN9y1PBZVYd1Yj4if1xnnqHSYWW4i+rU3WpRZqZh
 SmHxujvYBPDodpPc7UrGJVb4pg==
X-Google-Smtp-Source: ABdhPJw+GN6xeqt0cVSBsEc4itJjktUzGN3BoV+hsw9ykqiSu/E6RLgQ56rN5zP1W9mTZVIMhDZOWw==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id
 hq37-20020a1709073f2500b006b05e9a0083mr22291890ejc.659.1650978406511; 
 Tue, 26 Apr 2022 06:06:46 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a1709060a0e00b006f01e581668sm4840486ejf.209.2022.04.26.06.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 06:06:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH v2] iommu/arm-smmu-v3-sva: Fix mm use-after-free
Date: Tue, 26 Apr 2022 14:04:45 +0100
Message-Id: <20220426130444.300556-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
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

We currently call arm64_mm_context_put() without holding a reference to
the mm, which can result in use-after-free. Call mmgrab()/mmdrop() to
ensure the mm only gets freed after we unpinned the ASID.

Fixes: 32784a9562fb ("iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2: Add missing include
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..5d029e87c8af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
 #include <linux/mmu_notifier.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
@@ -96,9 +97,14 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_ctx_desc *ret = NULL;
 
+	/* Don't free the mm until we release the ASID */
+	mmgrab(mm);
+
 	asid = arm64_mm_context_get(mm);
-	if (!asid)
-		return ERR_PTR(-ESRCH);
+	if (!asid) {
+		err = -ESRCH;
+		goto out_drop_mm;
+	}
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd) {
@@ -165,6 +171,8 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	kfree(cd);
 out_put_context:
 	arm64_mm_context_put(mm);
+out_drop_mm:
+	mmdrop(mm);
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
@@ -173,6 +181,7 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	if (arm_smmu_free_asid(cd)) {
 		/* Unpin ASID */
 		arm64_mm_context_put(cd->mm);
+		mmdrop(cd->mm);
 		kfree(cd);
 	}
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
