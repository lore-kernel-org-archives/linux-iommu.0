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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91756C47086
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4711261419
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 06:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711261419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2499B82CF9;
	Tue, 25 May 2021 06:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_e7dFyrHyQ4; Tue, 25 May 2021 06:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22F6F83BF4;
	Tue, 25 May 2021 06:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEBFC000D;
	Tue, 25 May 2021 06:11:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A95AC0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 584DA403BF
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K_FgeYJLVJOl for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 06:11:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F393403A9
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 06:11:15 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id p39so6426488pfw.8
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
 b=J6FREe56XLQaskKPKpIZY8o/6rKQlqbWXWrWOfgs/0PcIBeJl/RrtbGyhl1knOo5j7
 3pPDCa6SHqmCtTegO+vl6A8NaRyI74dSAM3qNVn06MPqtP9o6UEW4Bov7ttLqs3w5NwT
 zbgKCQQwE5vZaQBL73afqhlGWftYxCEuscg0htIrTCAP8lXFtpzvaOww/VBzCAu6b5ko
 eIo5mL0oVXbIh0F7+tdmiWPXP7iLseDh73Q7/5GCoIjwzjiL8dEMyzY2Mm/zYgpg5qTw
 iI3GWdrGSYT5FgXgBZk5sKxcGoAc8EGQOWzc0ZDM7DFTg6TS6naiBR/7AFNat6MrOKla
 SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
 b=kSh04TnmzFsm7vO6M4laM1aKpvRRpNxY1ZTCBKcMnqk4ts6npLmtV9IBj2kmw/H9Cl
 U/xAFyjrLGeXSqHtmqPhkj//d+GdUW0koxKcwjYPo33fa9SFwXTvog0Bpc1+bHF36Fbz
 lPwLRSwC4sOuahfvvWtpGGSDrPBk5NBAd18nreCyAoMu1yfiOO7gAQ/kXVzCaRjCyjDg
 40psyWsPvzTTnASo8OsfNqm81BwNeBo1PkGTU3ONMy/z5KxIpXD3F4ld7RXxohyVrxcN
 6CpQbjgJhGmSe/8EsInAEfhbpKS5jTEdATionUX5XVObmBukIZXIb8I/icxQy7voP8Rz
 dTCg==
X-Gm-Message-State: AOAM533MYS46MYmMezBanTGm6ROwl9o1zTIyCYFbyTSXCD7hzjOB/bv0
 PIMrciN1wBcnP50cPs5924Q=
X-Google-Smtp-Source: ABdhPJwmcRO1j0zX20F/VDoYPpFBrwgF6Aj3KuLNE0KTzIMXQkWwqWMAnAiOKWrCXg/i7eEibVFYhw==
X-Received: by 2002:a63:9316:: with SMTP id b22mr17750398pge.70.1621923075049; 
 Mon, 24 May 2021 23:11:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 23:11:14 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/4] iommu/amd: Fix wrong parentheses on page-specific
 invalidations
Date: Mon, 24 May 2021 15:41:56 -0700
Message-Id: <20210524224159.32807-2-namit@vmware.com>
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

The logic to determine the mask of page-specific invalidations was
tested in userspace. As the code was copied into the kernel, the
parentheses were mistakenly set in the wrong place, resulting in the
wrong mask.

Fix it.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Fixes: 268aa4548277 ("iommu/amd: Page-specific invalidations for more than one page")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 80e8e1916dd1..6723cbcf4030 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -884,7 +884,7 @@ static inline u64 build_inv_address(u64 address, size_t size)
 		 * The msb-bit must be clear on the address. Just set all the
 		 * lower bits.
 		 */
-		address |= 1ull << (msb_diff - 1);
+		address |= (1ull << msb_diff) - 1;
 	}
 
 	/* Clear bits 11:0 */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
