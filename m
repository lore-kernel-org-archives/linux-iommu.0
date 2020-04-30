Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8879C47261
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBF62074A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcrvGlQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF62074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E0AB86DF6;
	Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cprwWjZKx5JW; Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 27D3386DFA;
	Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15533C0864;
	Thu, 30 Apr 2020 14:40:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED3B9C0864
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DCE2386DF8
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zGVPeTmJ7v8 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2481486B18
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:27 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x25so2159148wmc.0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oH09lE6EyF+7ddnT7acJ3k+jJHyiqaDtNA7hzb2+sc4=;
 b=DcrvGlQp3aypCcqoN+dkF/d0nkxcpxpMBKeHygdxhq6pA3zd8XZM4QH4aGcjJ/4Tht
 9Tqg6MvR7s2TeMD2dsMqnAePywvLPYenkSK2kqY1aeQ5SP9/rKss1+vPSjAOTqdrBVzC
 3Hk3sNXrPCV4FacRXsy5+JDyySaQuCd99SZEr2yUC/DEQ+NMzYMOHy2AFCct+xzP/4sC
 h8tNesK9eh+4jAyMW+Myo5oIfE7BWYBL5NXT4aV3gr63yJiHIm1CQMdWqcy+2LlMGvC5
 0q2zH9+Bx3SJDZIJOYsGForK5bwlhaFFDJLuGWuknwxC3tkJTHPS6KG3KsC4W4x0HmYe
 /uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oH09lE6EyF+7ddnT7acJ3k+jJHyiqaDtNA7hzb2+sc4=;
 b=ifRidZLwSjoQRbYXqr7IO1mqs/wVLg8dEWmMPAqRgkJaLmSnCzsAmUDV++4wy1aIrL
 3Ho+n+WbYEhvqf2/Z+M3raPkz5gsGqQ3lD2z2ATNMoL9fJDs6EH5+bu3gAM1gmIt8vwb
 6IvP4P7xCa2nhx+oBOVhpanFqhfRi2MOrGE7eKFQkdWylGWprJOWL+GuP5myf8hWxGip
 2cZddmHRMr377+71Q1Tom0hT68TBMSjXedyN/5OPQDhAu0XBJ0Rrcmpfs3Dx6vB/Ltck
 5eHRN2fAr58e7W0iMQf6MCHywdP+K8MZL+kNHBcQ+D1RS7mnykGBG77WwZ15R9r3k6Sg
 h7cg==
X-Gm-Message-State: AGi0PuZk5n0b0KvXrFn0XH46p6PzbcP+9/46wAkLdB5d0if5OiAd01U4
 Xy2i+RjHvFNv69uAx7TpuswsxCXrUfo=
X-Google-Smtp-Source: APiQypK39c6e8iviTZ8YwC7ivNBAH/kpcwBHJCtUr7sjyJdgvl1DlUReTsvBACR1UGiEnN8Ql6GmcA==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr3256603wmh.96.1588257625192;
 Thu, 30 Apr 2020 07:40:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 06/25] arm64: mm: Add asid_gen_match() helper
Date: Thu, 30 Apr 2020 16:34:05 +0200
Message-Id: <20200430143424.2787566-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

Add a macro to check if an ASID is from the current generation, since a
subsequent patch will introduce a third user for this test.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/mm/context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 9b26f9a88724f..d702d60e64dab 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -92,6 +92,9 @@ static void set_reserved_asid_bits(void)
 		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 }
 
+#define asid_gen_match(asid) \
+	(!(((asid) ^ atomic64_read(&asid_generation)) >> asid_bits))
+
 static void flush_context(void)
 {
 	int i;
@@ -220,8 +223,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
 	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
-	if (old_active_asid &&
-	    !((asid ^ atomic64_read(&asid_generation)) >> asid_bits) &&
+	if (old_active_asid && asid_gen_match(asid) &&
 	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
@@ -229,7 +231,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
-	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
+	if (!asid_gen_match(asid)) {
 		asid = new_context(mm);
 		atomic64_set(&mm->context.id, asid);
 	}
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
