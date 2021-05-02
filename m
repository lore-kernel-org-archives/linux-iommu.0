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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F153C433ED
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09112613DC
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09112613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9B2D40002;
	Sun,  2 May 2021 07:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXq362V9VYLm; Sun,  2 May 2021 07:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A936440165;
	Sun,  2 May 2021 07:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2EA4C000E;
	Sun,  2 May 2021 07:05:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CD37C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E0C641D34
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yx7lJd4HwuUf for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3216941D2E
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:11 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 m6-20020a17090a8586b02901507e1acf0fso1568337pjn.3
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
 b=nzAOPawlkFRQBAAKpT/I7SCsKt3G7/7pFFxpmCxNWUu7nCA7k/PR6WqLYOmSsnEfWF
 /SNPniMJHRJDDtKSXh6qsAZ35Eivh60QDg4VJpd/RfmS0lrr1T98g3+ItK15jfZjYd++
 lDjdK5AFe4JyBV9NN2qQOYnWhsAU/HaqXYx49DOu2cAApP8i9AFnhaAA7h9hRKY72WsW
 dhT2Y6mQWFSpZJPPs+fD8d3rOfe2n4qw0ixk4f5MfCn0UQTNFYKaDNm8UrazYPLbag/N
 Wtc/rE7BiMDsp/3X1zVMgDzLMC34egdoYXC7EDl1fhWLkARXvnZwfKi2/CQ3yb5cmLDM
 LXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
 b=NHwIoR46120W7V2U9VSdsetK8TGhth+++xlBGpf7Uco+D0yvZbiSkOnAk/mn9YgRcO
 Zmh4zchx/foXWLyYNVdtekHpBlWZvBsykeUHVZ0NNZW11Sz8ppYBMnYEk3CI+aHMQPme
 vWTroHRFvlzQ8LMXZ+qt+6DFz/U2hIOmGVH8tKyvmoZpRNkrfr7lA1BfIGgLWpOmuneO
 FRblxE4BGj5xBdcRR5E2r03BINbiuggJ6uw6mh6ONVblEqrwkHUJ2bS1LZx8QTpNpqPW
 GdnTJBNVXBSbqu5h5YKSbRzugUs5KSpeOoAYWqjwmL2G6qfxWO/12UCZmlbvB47PIjFr
 Vs4w==
X-Gm-Message-State: AOAM530MWya+Vwt998BADXO7GLylQ43rHxaFHyRJjh9JYGwTkneGkJPM
 iznuon+FIQZtGg3Yeydv3OeZql4/hMCZKA==
X-Google-Smtp-Source: ABdhPJxPBy++Qp4ydPC32XHC9Z7AwhNX5sWUQVB7n/azwsoleB2uXIgRCFnMS3ZIsLSb1QE5ZshhYA==
X-Received: by 2002:a17:90a:7896:: with SMTP id
 x22mr14335204pjk.182.1619939110572; 
 Sun, 02 May 2021 00:05:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:10 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/4] iommu/amd: Fix wrong parentheses on page-specific
 invalidations
Date: Sat,  1 May 2021 23:59:56 -0700
Message-Id: <20210502070001.1559127-2-namit@vmware.com>
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
