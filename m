Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144CC07E95
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 04:24:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDA0613E5
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 04:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDA0613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB7A84343;
	Fri, 16 Jul 2021 04:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQ6FyHsTi_hr; Fri, 16 Jul 2021 04:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D082842FE;
	Fri, 16 Jul 2021 04:24:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62C3C001A;
	Fri, 16 Jul 2021 04:24:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71886C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 04:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CD0F84300
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 04:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1vrTwjilkeD for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 04:24:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9871842FE
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 04:24:36 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id j3so4685450plx.7
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 21:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jeA8/QJwIuaoq07p3zXt49yP9rXhPX14YEL5plmNTTE=;
 b=eaYqYDla/1UeEKXZx7Ij0DutP7wvZNbi8Dcgg7R8UgEineeDI8N4Zf3pDJsMEhDkIB
 UOkFus56q//aBpx1HsCTcjQYbRhSEqcI+8HB1ANTCqImxS7Y4SPb+lqh4slpRNaHrZER
 v9Am9dGj4FsIwBgX/KbmgnCosMkho+8so+3O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jeA8/QJwIuaoq07p3zXt49yP9rXhPX14YEL5plmNTTE=;
 b=hysjiquMgAcDUh+9pN5J6XmGFhUsZysqoPhqhdfLzkw6aA3JkAR5iO9SypI6XdyYq2
 iUzdPyK2IB9yTPPgfL6laYiFJE2qrgQFtWuHf11dE4+zt0vOG5Jw26MQ4zIHKjeqJw+U
 ioQOHZwJ3NFCIMJNia9lBiRXROq3b1swRUKT9PFLo7GpE0d1T3QbsX7u81FQ5ov1O6k6
 5PSxFQnTXgQx7/yBUBDzwXBPzUM5/Azoc2OoPEYwuVijkbDFimHSH9IfB3bSQFwrkqjw
 Jji/Ymfjm7PgD6+Qhm5shk6BKxzex5h0fg+SVpWNlgWr2fNVxtOE+zugUAe5QKvnZr/4
 Hkxw==
X-Gm-Message-State: AOAM532f7L/Uwmk/YGAEn89+51qojWef5LOmCvsl8kcsHM3wVmjrPz1z
 yLbVFwKOHyJgyp6XUSk1t5cUtA==
X-Google-Smtp-Source: ABdhPJw25am4owtb+e9yeoQv4fOzNBq6oWPWnqODQ01UZQDeKtEMv6E8OmnwHqvZEsuqz7v8i5kMLA==
X-Received: by 2002:a17:90a:a6a:: with SMTP id
 o97mr13944357pjo.179.1626409476196; 
 Thu, 15 Jul 2021 21:24:36 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:3685:a3f6:891d:2a86])
 by smtp.gmail.com with UTF8SMTPSA id u24sm8513343pfm.156.2021.07.15.21.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 21:24:35 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] iommu/sun50i: fix protection flag check
Date: Fri, 16 Jul 2021 13:24:31 +0900
Message-Id: <20210716042431.3195155-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-sunxi@lists.linux.dev,
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

Fix RW protection check when making a pte, so that it properly checks
that both R and W flags are set, instead of either R or W.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 181bb1c3437c..11cf5af30956 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -271,7 +271,7 @@ static u32 sun50i_mk_pte(phys_addr_t page, int prot)
 	enum sun50i_iommu_aci aci;
 	u32 flags = 0;
 
-	if (prot & (IOMMU_READ | IOMMU_WRITE))
+	if ((prot & IOMMU_READ) && (prot & IOMMU_WRITE))
 		aci = SUN50I_IOMMU_ACI_RD_WR;
 	else if (prot & IOMMU_READ)
 		aci = SUN50I_IOMMU_ACI_RD;
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
