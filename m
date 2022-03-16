Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF197C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 05:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54DE184276;
	Wed, 16 Mar 2022 05:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJlJ8OFFYjqu; Wed, 16 Mar 2022 05:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29BE284275;
	Wed, 16 Mar 2022 05:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E33CBC001D;
	Wed, 16 Mar 2022 05:08:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACBFAC0012
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 05:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8657C401FB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 05:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2DgEcxps8AJx for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 05:08:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8654E400E4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 05:08:20 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 kx6-20020a17090b228600b001bf859159bfso4073846pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EW7VxVIhAVIvz2Mal/uBqtSahBJB+Cq+MnvTSwrQaIo=;
 b=D6XcqVyj8GGsMs37ehRYc+HeJN7yvl2QK/gEHSBqN1ZvbC3WVFHesqF5tQECJIzuQE
 JnXWj2nVRzSincmH3KsovPsJYXM0OTAZwnZ1m8vcFMyMXrExVWzf7oHc6JHBs2g1JMf5
 4nhaAGaMdE+pg3zfHp0Cptot8uGlQru55ve6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EW7VxVIhAVIvz2Mal/uBqtSahBJB+Cq+MnvTSwrQaIo=;
 b=L/bCEgRxLeUt3hDwuOlYRP+xXpAMM+7NJBNpUqrVpDAXcz1Kx0lLcdn1GNxnASjoAT
 HBp9I60x/vPUqx3ITT6HFc6vAqLM0sbLBmru9DcjXZZtIVU8tfonDOE/mIxhzJ0+BCbW
 rFLHAKoo8HB76LdREAOlpjMZooh8cXVU36iYgiVPTvFy+YTBWWGEYBKG9Pllyy3ldbnL
 l3wg/BB6VazKY4B4DaCVVxTFgmZCtq8i7U7EKquKDAaZ4jyUTPheO0c0mYWMcox+56vu
 pdNbDXMB793AgYfnrD9Cl+kuEh3F/p29TSYC+ofaDsV1a9FchmGAU6FMFGCHrxhAW5Ua
 lGLQ==
X-Gm-Message-State: AOAM530iOnmg5ZbXiqDAXs+xoSV0mHuBIR8TNIBfC5x6jY8EflPEE6EF
 cLB6h0EfJqwrn1QAL8HALH06Tw==
X-Google-Smtp-Source: ABdhPJz6AHG+E8sSh2/+XaimwQGJWW8QhdmvMKJnICGVZ2r6mCz6wGhhSUNZrNy7ClH1qZWeqowFog==
X-Received: by 2002:a17:90a:a018:b0:1c6:5dac:3da with SMTP id
 q24-20020a17090aa01800b001c65dac03damr688731pjp.195.1647407299654; 
 Tue, 15 Mar 2022 22:08:19 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:3e4f:fba6:88d:becd])
 by smtp.gmail.com with UTF8SMTPSA id
 u8-20020a056a00098800b004f702473553sm995913pfg.6.2022.03.15.22.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 22:08:19 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: check alignment before using psi
Date: Wed, 16 Mar 2022 14:07:11 +0900
Message-Id: <20220316050711.1855533-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 David Stevens <stevensd@chromium.org>
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

From: David Stevens <stevensd@chromium.org>

Fall back to domain selective flush if the target address is not aligned
to the mask being used for invalidation. This is necessary because page
selective invalidation masks out the lower order bits of the target
address based on the mask value, so if a non-aligned address is targeted
for psi, then mappings at the end of [pfn, pfn+pages) may not properly
be flushed from the iotlb.

This is not normally an issue because iova.c always allocates iovas that
are aligned to their size. However, iovas which come from other sources
(e.g. userspace via VFIO) may not be aligned.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5b196cfe9ed2..c122686e0a5c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1735,7 +1735,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		 * and the base address is naturally aligned to the size.
 		 */
 		if (!cap_pgsel_inv(iommu->cap) ||
-		    mask > cap_max_amask_val(iommu->cap))
+		    mask > cap_max_amask_val(iommu->cap) ||
+		    unlikely(((1 << mask) - 1) & pfn))
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 							DMA_TLB_DSI_FLUSH);
 		else
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
