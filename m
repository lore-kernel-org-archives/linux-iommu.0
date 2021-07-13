Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8365EC11F66
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4398861249
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398861249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1612F403A6;
	Tue, 13 Jul 2021 17:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JS_9RmyZ300m; Tue, 13 Jul 2021 17:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF26D404E4;
	Tue, 13 Jul 2021 17:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8535C001A;
	Tue, 13 Jul 2021 17:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CACDBC0022
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC41683A5C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GvlXd5XL6EHK for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 17:24:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90BBB83B01
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:51 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id y4so20258463pfi.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
 b=EUXrjWHqkH0BxXsmRSm3dqAmFXWbJKeF1oaVvbleGkXtZij1hf305qas49Tv1KT/aP
 UP9cfopwzY1fE7Ex+HV3eVpmNWMG721o+alH+pe90tCuHsyBDEEcYfS1XhrMlfO5c3fp
 Nreb+1fGLP6eTV/xo3r2qnnM3P6SDZoLlNKri0SmLmXp4pJD/GRMg2MQ5YDYjvGmpPuG
 A9gyZ+MWba3cH3dR0hjIepcm98PdRc7rddJrFBG2yEGr6UMioUl3PjflHMkLzcD1VwZ2
 nfmxJKqMSV5Gj4TouvrDF+C5+xoXEp69BpNa9mGVG8AlHgWM5cL0XB7PTYD6WxRJTrSZ
 CEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
 b=fWB40yiu7oTdEw33bES0DMSR9xnHKAmorbctxxxxXGYiSxA9k61loUVfCRvKyX+Jso
 thDkd5MpWMe76bCjpdxn3yY0N227LC3U+23xVGrXVSq4Y0bZvn+9c4pGtbM71GuAI3jU
 rt+E+j3D4BdtH1HZ+ur3TWX6ARhHKlJtUwYD+tkqQGexUTQz18KJK83ZgDEHAP1mu141
 KIEF/N2PLCezlt8FyqnD33nFQe/zYrgVkQY7er+DbjfG1sdWwo65Hwz2aHHr25Aq3h7r
 aE3pNwzC/H6YpUmccQyzyv6zICR9sz7ukxKUgQiKos4shME2MPSNcm3aZGuY83PatGya
 +jfQ==
X-Gm-Message-State: AOAM5335Wn1rIfq5D50UuZTKxqmp6Fbhp0A+vnCX/CDWmzAYEZpfRE+y
 q6bQTv0At+cck6dTp3/jGXI=
X-Google-Smtp-Source: ABdhPJwvy73Brnre+MjqvuOUmw+yRf0jy/k9L3a5HcjCN33acOxQ1z3HwooFLIJXNhp/iE9o7Su3QA==
X-Received: by 2002:a63:d54b:: with SMTP id v11mr5251964pgi.450.1626197090907; 
 Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date: Tue, 13 Jul 2021 02:41:46 -0700
Message-Id: <20210713094151.652597-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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
