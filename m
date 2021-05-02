Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFBC43461
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6D16101C
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6D16101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA49F60AF6;
	Sun,  2 May 2021 07:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLcSHO2fxynH; Sun,  2 May 2021 07:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 976B160AED;
	Sun,  2 May 2021 07:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F1DC0011;
	Sun,  2 May 2021 07:05:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED42C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EEA8403A9
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-suwbeJXog8 for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F9B9403A7
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 t2-20020a17090a0242b0290155433387beso8432645pje.1
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
 b=Rszc7fTuxN9/0Hiy0uUfWYHVhGXjizzxbTwgjZQg2n9lNOVwFdujGVU9u30XYFk0NF
 ls8kmQuJiQPx4PqHkEYK/Fe6fc3cqaWYW1rnJOvg+ZeY7rBIW8WL3PyxJoxjQH3dZ1zH
 75cmjZtmMNnLq4SbIyVwM5lI4PtivUMbN4xXc0xEovhI9mq56Mhhfrur3vYCqv/eEMH8
 akmoKFiPe+LkX6WHqxXbzyDb4lmxWVO4JZl3xsmSSkkiv9r0tYvZ2Qftxm7n2aF761TC
 XWorXU9G4jMXsWoWwU2zfCYdH/uovC2cUT/Y9U6pXs/D0sQImo0R1Ol6LejbJMxoFrdT
 PHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UhWuHO15mzJ0eEmkfCxQQ410IKmY3/zDpjWtbS+BUSw=;
 b=lYMw/kbRHqk/U5Frk9HhNT9iAY8j71Eh1vZYtv0xKJIp4X++oKzukuQLM2RoAfJikR
 sNEnvlHCZ+/kux/TL9XFiCYhP6DGZmah7sahmXkB5osjbUDXGKn3MkBaf5CEPEdak2bu
 /lyPePyEa04U6s1ui/hfl6XOKzWFvJTo696LHJwkyAlYNtRSP5fJ0QrE/k7TkJev8KIP
 pnpKoTCkB8ptcr2G+CMX/86jzBEs2FQoDvTlOnoxrTpS2dG4q01JHr1sDdebi5x4e4GW
 5+P/YVjvWHAt651xBC6Prwen3O3wE8mVELPjax/uXEDKCGSgRe7rQs93Q6Aa+EMagvNL
 TY1g==
X-Gm-Message-State: AOAM532rOUHAI9Fb1f7wqmPaonncBevIYVCzZz4oXRug2ZDcDOz4e8NX
 dezJPzqC9EJxQFLUEGWkuN0=
X-Google-Smtp-Source: ABdhPJyHFOshXt7GygOdxmGPBFevReHiOMEMndS9v5KQUb0kc5sQ/hKgnOfR1C5DtpRX8pRCa9LN6g==
X-Received: by 2002:a17:90b:3689:: with SMTP id
 mj9mr14582792pjb.154.1619939117103; 
 Sun, 02 May 2021 00:05:17 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:16 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 4/4] iommu/amd: Do not use flush-queue when NpCache is on
Date: Sun,  2 May 2021 00:00:01 -0700
Message-Id: <20210502070001.1559127-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
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
