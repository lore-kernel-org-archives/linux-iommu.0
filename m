Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60FC43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 14:24:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A44023119
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etyuSs3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A44023119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1569A8769B;
	Fri, 18 Sep 2020 14:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9R492UE2AP7C; Fri, 18 Sep 2020 14:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFE4687672;
	Fri, 18 Sep 2020 14:24:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C47B0C0888;
	Fri, 18 Sep 2020 14:24:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB95C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5B8F9877F4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJUQNPIeg372 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 14:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6FC2877F2
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:24:36 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id j2so5836103wrx.7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=na8GpyYv85aOpBP11Jf6WZFgTxl3Aw/L6OpSLjetFwg=;
 b=etyuSs3OVyjL99gzmzOYa6/wAPbebA1BYrwwkxCK9XKe1A6IVQ0v2SXgDjNoLKezuc
 ck0VEzaRB3HzkLRbjLyAnAECc6n9M8kQwDWCA35xzibRYmiDyAcJ90ws7gSyxFZk2e70
 i88u8jYGcB3H6hdRp5+hJspEoLe7CGaxjLng1XBzzOwA1H5An6X7BHvO7VEoxY+cHoiS
 O4l6dCGu2t28LBxwAazoFAxYD/Y1vmfSR7QClV6+vQ8VPM0MpcgW1eWpGYgZajon9EP/
 vkjSgUtw1vq7SnLJ/7ZFSU0/QfdskCKwtA36Q85GP386hKsqbT5gSSXfAdFARo+Wbpx1
 2cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=na8GpyYv85aOpBP11Jf6WZFgTxl3Aw/L6OpSLjetFwg=;
 b=heX7+z/ldeEGw/lJxjVZFgBX6J5P5FXhRmyKTf4aKWPxhVBQSKLxQB4o2zlj0PSUsS
 vGNtsdfrdnsNdTXkdaIH+hqXOAWbXBy3QPIu93FZzFJAMdG8aHV0sl1/ebIhZlJRx+uf
 ofc0J0navVRyM8l1SvgT9rNonAVs0MGFh3sC+o8p/gcN7yVa8Vo4ie0sqlt5uy80bKSH
 0aOdPZk04GNuYZFQiHExLyIgbeqSudZNyAfYOAJ9a094dpj0W+UVghQoXspwP007NzVX
 slohrOSZyRvJwIBhgqiu2dm/gYQKJj+pRpe1G8DN6JmSr3K6Lah3viTflheocAcWWssO
 QXUw==
X-Gm-Message-State: AOAM532JkQiy9f/olVL0PGpzJBFj4YWK8fB71AJ3V+mjxCa+kubVupHf
 hG+RMXz2jv8mPs/6sVfekrpzbQ==
X-Google-Smtp-Source: ABdhPJxhb/XdGI5twiyu6Et5QnvfDr3z2mqQ/PgX8GXAydmlCfw1sUFl/ffh4Zyvvz+7vVjvbKPM4Q==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr40672714wrm.150.1600439075299; 
 Fri, 18 Sep 2020 07:24:35 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c25sm5231151wml.31.2020.09.18.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:24:34 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH] iommu/arm-smmu-v3: Fix endianness annotations
Date: Fri, 18 Sep 2020 16:18:57 +0200
Message-Id: <20200918141856.629722-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

When building with C=1, sparse reports some issues regarding endianness
annotations:

arm-smmu-v3.c:221:26: warning: cast to restricted __le64
arm-smmu-v3.c:221:24: warning: incorrect type in assignment (different base types)
arm-smmu-v3.c:221:24:    expected restricted __le64 [usertype]
arm-smmu-v3.c:221:24:    got unsigned long long [usertype]
arm-smmu-v3.c:229:20: warning: incorrect type in argument 1 (different base types)
arm-smmu-v3.c:229:20:    expected restricted __le64 [usertype] *[assigned] dst
arm-smmu-v3.c:229:20:    got unsigned long long [usertype] *ent
arm-smmu-v3.c:229:25: warning: incorrect type in argument 2 (different base types)
arm-smmu-v3.c:229:25:    expected unsigned long long [usertype] *[assigned] src
arm-smmu-v3.c:229:25:    got restricted __le64 [usertype] *
arm-smmu-v3.c:396:20: warning: incorrect type in argument 1 (different base types)
arm-smmu-v3.c:396:20:    expected restricted __le64 [usertype] *[assigned] dst
arm-smmu-v3.c:396:20:    got unsigned long long *
arm-smmu-v3.c:396:25: warning: incorrect type in argument 2 (different base types)
arm-smmu-v3.c:396:25:    expected unsigned long long [usertype] *[assigned] src
arm-smmu-v3.c:396:25:    got restricted __le64 [usertype] *
arm-smmu-v3.c:1349:32: warning: invalid assignment: |=
arm-smmu-v3.c:1349:32:    left side has type restricted __le64
arm-smmu-v3.c:1349:32:    right side has type unsigned long
arm-smmu-v3.c:1396:53: warning: incorrect type in argument 3 (different base types)
arm-smmu-v3.c:1396:53:    expected restricted __le64 [usertype] *dst
arm-smmu-v3.c:1396:53:    got unsigned long long [usertype] *strtab
arm-smmu-v3.c:1424:39: warning: incorrect type in argument 1 (different base types)
arm-smmu-v3.c:1424:39:    expected unsigned long long [usertype] *[assigned] strtab
arm-smmu-v3.c:1424:39:    got restricted __le64 [usertype] *l2ptr

While harmless, they are incorrect and could hide actual errors during
development. Fix them.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

There is another false positive due to passing INT_MIN to cmpxchg, and
__cmpxchg* to truncate them to u8 and u16:

arch/arm64/include/asm/cmpxchg.h:172:1: warning: cast truncates bits from constant value (ffffffff80000000 becomes 0)
arch/arm64/include/asm/cmpxchg.h:172:1: warning: cast truncates bits from constant value (ffffffff80000000 becomes 0)

I haven't found a satisfying fix so far, except adding __force to
__cmpxchg_case* which could hide actual bugs.
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c192544e874b..83acc1e5888e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -867,7 +867,7 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
 		*dst++ = cpu_to_le64(*src++);
 }
 
-static void queue_read(__le64 *dst, u64 *src, size_t n_dwords)
+static void queue_read(u64 *dst, __le64 *src, size_t n_dwords)
 {
 	int i;
 
@@ -1939,7 +1939,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
 }
 
-static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
+static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent)
 {
 	unsigned int i;
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
