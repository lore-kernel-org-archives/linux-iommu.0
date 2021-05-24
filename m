Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE5C2B9F8
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BED36140F
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BED36140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51FAE404DC;
	Tue, 25 May 2021 06:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3aQgrx6kbPb; Tue, 25 May 2021 06:11:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FE88404C7;
	Tue, 25 May 2021 06:11:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC242C000D;
	Tue, 25 May 2021 06:11:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDDFC0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15CCE404B8
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-lCFGWjz3Jz for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:11:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 498EB404C7
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:20 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id v12so15813230plo.10
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
 b=MmLzG7y59sZYQcrjYGcKmhKp1oMwcv0fCumRzjkE1uwG/p86vc9uhUENNmqwR/CfQ3
 D7IO2cPpgHW1TkJhrqdNrxIdrDJzQwaBab+NGUXsdhoLFYgFpCcuf8qfmZshMb00O1ee
 w9A3YLJlBcb05tvqnAqhqonMvCA7hnKHcVJQygTuYmUeepQ/6hBZz7pWCcylt+M74PlF
 5hTFDQkSCfV5S/Ggt+eeHQz/lPOcsKVVr/gib3qXTAP8+12Mp0xfwLZX1ZBZsNTi3mxp
 BqaJWZ/+K2yM/ih1cT5xXbG+uLZjWJmcDu3oGbCi9HG5mHECIJLUAwe0QmFeiD50kv0F
 X/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
 b=g9ILMq458pypjzfPwkiabBNle+f3Uv8IZngzo9RuQxanJNVCvcUUS2+fFt5mwKEObk
 FIANvHvpsF4LXpzBcnR0dIn+JL2iGM6Db0y72OX8df8JPFhBxrKqauBkkm7W+ZKqVDak
 3kD95ul6KL9lCMoV+8eDk6a3f1Yfc9u9dFdQmY79/LegC3wruDVMS/vSNexeUKG4SSNH
 mM+yUzfyS8c2fJKUjyqs2sjSbqm2QZj2BXojlkpbV5g3WGB9NxlmrePG4oKuUx5n2MNJ
 lOj+mUJVBigXjPmYI5gu03Ox23RlgSbWjTViRSY3/NnWzSSwn6//20V6XsAqeKSUGJYx
 nS2g==
X-Gm-Message-State: AOAM530wfNb8fyFzdlbCJcL4Cc0pICXqtceef7UZqVCp7yW0BSeePUnu
 +suMNq2GnPwT19cnTVKBcxY=
X-Google-Smtp-Source: ABdhPJwhyiOGqXzf3w88EuYECEbaunS2WVlc/eoo6GTlGCCWykLxa+XEes3OwdZf7Yd4M1K2xV69ww==
X-Received: by 2002:a17:902:f2c2:b029:f0:d72f:4f97 with SMTP id
 h2-20020a170902f2c2b02900f0d72f4f97mr28829418plc.65.1621923079634; 
 Mon, 24 May 2021 23:11:19 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 23:11:19 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 4/4] iommu/amd: Do not use flush-queue when NpCache is on
Date: Mon, 24 May 2021 15:41:59 -0700
Message-Id: <20210524224159.32807-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
 linux-kernel@vger.kernel.org
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
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..ba3b76ed776d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_warn_once("IOMMU batching is disabled due to virtualization");
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
