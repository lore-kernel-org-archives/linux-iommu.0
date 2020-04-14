Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD9C54FD0
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7EC2074D
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="po6t4my3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7EC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9CBD85C52;
	Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5ZIN9XdpJhM; Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 71BCB85DD1;
	Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60EA7C089E;
	Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B032DC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D3EB86DEA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPzDljnlcG+5 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E917286DAB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:28 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id o81so8229749wmo.2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCsqjS+Tnwu1hr3WMvNuD+P9uXkPM0pVKS2lTlLCiJU=;
 b=po6t4my3Go9g7beq4oi5gBqHe0K8I8gLjjolwSf6g7Inuex/2pKCElDmTw05chnprB
 VpcDmTm9mJndKQ44OUnWiFNGWAnRefKxTsOEpgZkGH6fmib0dAJkrwdNZzEReQlfHRLw
 zmHfO/enRYNLngF50Q/ItNGZfOVNZOP1Wjn1Tm/UzlvI3Aq2ub4XSW6+HyraLp5KrRtN
 gUQ66eIR/V7LC06nJlZF2rLHNx0sFnWE5LcK9o3Z9V83oIkL5irCCS39MKos1xZK1qWT
 MZY9xrqkkCHiVCztI/hzFS5XxD5U/SGIE/6AMMBqlAMbF3wtNCRxo5V2z/5fM3LcFagm
 S0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GCsqjS+Tnwu1hr3WMvNuD+P9uXkPM0pVKS2lTlLCiJU=;
 b=NseOVHeeYpoTh+wG5QIr9769CsroUwsXi+ElKk8d25vkcfoJZnQtqWyPm0PfUpOjJx
 iJW7AuB1xdovi8Zkq8RtkPSQJs28O9MJHntUghSq/gBPIBc+0ODzpThUWPGr0eK0lwkO
 KGMm/P57phsxJHXRSe2cVKS0zJfWJyHoIsBeaLgLUeTio/kFn9K0Skks8gdZeYZd6l4T
 yUp9XFmDKiAJrElLnhWfIQvSd6CfnvcnfzIviG8D0sx3pCv76Lo+d5dKtT3uZuvnciVD
 YskJT1ah0fbDQuc2mOI+x8BEiJH4oPAx7eyVnp3bDG/nJQp2NItMlierQb1CtGXHptgJ
 fw3g==
X-Gm-Message-State: AGi0PuY6panw6CsIjl2LMWjb2Iuqf7HNr1OYsoAVNs1HgYDFp4KKW38I
 urTO6mnag2Qn02eRrcYJosUMpyEQHX/80w==
X-Google-Smtp-Source: APiQypItrJFyYm1dKZ3R07kVZC02nj/EnEUI4s9HX58/CnIZwkPk4I7z7a9PSJbV36nuH4swD5HWaA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr814694wmy.30.1586883867167; 
 Tue, 14 Apr 2020 10:04:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:26 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 07/25] arm64: mm: Add asid_gen_match() helper
Date: Tue, 14 Apr 2020 19:02:35 +0200
Message-Id: <20200414170252.714402-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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
v4->v5: new
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
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
