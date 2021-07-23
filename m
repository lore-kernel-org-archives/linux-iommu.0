Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31658C4320E
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD07260EB4
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD07260EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F4D83B1F;
	Fri, 23 Jul 2021 17:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1c_qIKd0KSx5; Fri, 23 Jul 2021 17:02:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B77B583B2A;
	Fri, 23 Jul 2021 17:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2362C0024;
	Fri, 23 Jul 2021 17:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11F5AC001B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E211A40144
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VquNefvvz_PL for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:02:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05B5440588
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:01 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id c11so3754069plg.11
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
 b=H/V5/yWkynYmSW8o0j4NWtH05Et3lvod20vgWvq1x9CeXtoj6iceIn4C8BEjEWEPzP
 hr30+khZ/66DovGzi2qzsaqQlbKPVJK30FaKMYUCTIQ2hSFGTSnbdJNQFcwPdNIQCtBP
 ZB8qRez/W8v9EYmntRr+wL3LF4MPkcVQ+1SZNA/54I4n3H02E0VnksJMltwYWAadx2OY
 qj2xEVAQ0VFRWKwPnMT6apHfuQ6BaWddwTzrEzszMMOZjhlUO0kMIHYBbItQXFT0bogQ
 NfJIZjclGHSjF57KSqPZsvopFyzSgT0MQMeagVZ3mqhBeAHi5CyBXoGJId0jYo6/OOiZ
 ybXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
 b=r1ID+cMbFbDt1NqRmQQmUqdaRP6MR7jVZjnjN6j4tMpR3vJ/8/I8n2pfuhfV7RTE/D
 JnZla4j0bOUJM+aFLQCkp9rNEsfGWqsuvHhYLcjtNMxdfotGr2UP33SiXEX6FjhI1ssu
 imEEiE9tgbAiTMlrGBowuX6zD1EtnweEJTghLjNa+r/zCRCNwM1pzklsqpYZMUpCEcQQ
 b1QFCQYzGKHKFkarUIAmhK8CpnylgFuuK2pqMqbYSP/y8TS23uCfTmgzy90W82CCjwvl
 OKwjlAViflC7+6Mw/kqcAHPBE2qGpdVYeGawaMHQsO6HSkKj0DwJ4DTipUySxCEd5n3b
 gTaA==
X-Gm-Message-State: AOAM531H5bqy8Ir9i3Gd9oPgM22ce1kwatm7jWwksKAJNRyWjrqElJgx
 QLR2QDivW00CYuN6dldCypo=
X-Google-Smtp-Source: ABdhPJyTddjeUVT07xUgh/lw1kS9bu8a3qI5oK7vLKlmSpFpNzOCvASJ5Y0ej1rDgh88K9hNb4rOQA==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr5735888pgf.65.1627059721160; 
 Fri, 23 Jul 2021 10:02:01 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 10:02:00 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date: Fri, 23 Jul 2021 02:32:04 -0700
Message-Id: <20210723093209.714328-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

From: Nadav Amit <namit@vmware.com>

Do not use flush-queue on virtualized environments, where the NpCache
capability of the IOMMU is set. This is required to reduce
virtualization overheads.

This change follows a similar change to Intel's VT-d and a detailed
explanation as for the rationale is described in commit 29b32839725f
("iommu/vt-d: Do not use flush-queue when caching-mode is on").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..1c7ae7d3c55d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_info("IOMMU batching is disabled due to virtualization\n");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
