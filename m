Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A544C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 04:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C044364E38
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 04:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044364E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A90783A54;
	Fri, 19 Mar 2021 04:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFjOCwKjjesn; Fri, 19 Mar 2021 04:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2FE483A7C;
	Fri, 19 Mar 2021 04:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99A1CC000B;
	Fri, 19 Mar 2021 04:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A2DC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F3F783A54
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bno38Prn-6U2 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 04:03:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4879583478
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:03:38 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id bt4so3982155pjb.5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 21:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ryeZqjeyYgMVyJ2yaoJp0ylfGz6ueh5H5F2dT0FCD+4=;
 b=NEapts2xA7NIOuh03lb2AfHJiMCEq2c9+HhCbqNF1ZLNnT3sOAOrgUHGF8LylRFR64
 54Oo13jXEFjx27m3Blc1t1sOFcxy2ajFjm48s2K2HdKcoj/R9LPGBV7r7/+vWshTgyuw
 lTv23UVUs7HckciSLX98yORfNgmVndcjlhnuzx+r/LB51spj65OJBzqVt8rI2OdTa7AF
 1IXKDoP7EQLYyB5prCP6meBtuGt0JThbFkswykK80FWRYblqrP6pC3e77L+nWCWZXuBN
 IIBuMO1vYsVuROQiMUKF2zjoBnw1HyGirYSYI/zFlnLGo6TFGUyEQx/x7UA+Du17zsZd
 S5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ryeZqjeyYgMVyJ2yaoJp0ylfGz6ueh5H5F2dT0FCD+4=;
 b=JrlP72wuv8ZgxvKbTCahwZ12AmiCETla9rEs5j2Dr5MtuvC2OXLl1VqWJB/PfH9lrL
 eD7nJ4mII12H0YjEG+4KWAUUyXUcww8sZcZA0tIcGN7+h9WUDqdHO04ZnO31HKv57nl9
 /CfXy5Q+Kt1PyW/m5tndGKGY/JpwsWMjGCw/cNjon34RLmCavhfbRohWAr9qGfrCZf+C
 wP7Ev+5rbGqk6umwcXJG7HoM8iRsfYEeMwLjJWNbYL3OMjqj2EG1HO5FxsjsqiaRDOYf
 6aXFm7l4NRVcyFXkM+hOP3trYVOjHK0h6dyunrpp2+OYHvj14pEBbRyvgbuZCvFRVdof
 O8eg==
X-Gm-Message-State: AOAM530FUMCYIte2DBEgA3YgcC/8qEzFCEdRbkY5Tadpv0LMtyGIhzj9
 ni1EaJudxf3Sa5zZ8X0F3Ss=
X-Google-Smtp-Source: ABdhPJxZ3c4SvE803b8zFFu+UyX5aqgBp0K5SuPW9aexu1KTNF02FpBMiTobs5HTmQueK0iWEmUBOA==
X-Received: by 2002:a17:90b:fd2:: with SMTP id
 gd18mr7792951pjb.115.1616126617718; 
 Thu, 18 Mar 2021 21:03:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id c24sm3752517pfi.193.2021.03.18.21.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 21:03:37 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: Qualify enabling of swiotlb_init()
Date: Thu, 18 Mar 2021 21:03:33 -0700
Message-Id: <20210319040333.183827-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 opendmb@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Mike Rapoport <rppt@kernel.org>
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

We do not need a SWIOTLB unless we have DRAM that is addressable beyond
the arm_dma_limit. Compare max_pfn with arm_dma_pfn_limit to determine
whether we do need a SWIOTLB to be initialized.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..8356bf1daa28 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -301,7 +301,11 @@ static void __init free_highpages(void)
 void __init mem_init(void)
 {
 #ifdef CONFIG_ARM_LPAE
-	swiotlb_init(1);
+	if (swiotlb_force == SWIOTLB_FORCE ||
+	    max_pfn > arm_dma_pfn_limit)
+		swiotlb_init(1);
+	else
+		swiotlb_force = SWIOTLB_NO_FORCE;
 #endif
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
