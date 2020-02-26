Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E87C4BA21
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2954F24656
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="c+fqP6D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2954F24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7A7E8510C;
	Wed, 26 Feb 2020 21:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecX5eYj5NB9N; Wed, 26 Feb 2020 21:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B131D84D8A;
	Wed, 26 Feb 2020 21:36:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9449AC08A0;
	Wed, 26 Feb 2020 21:36:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B638FC0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 21:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9ED0186B85
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 21:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ZNOyTMQ_83M for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 21:36:44 +0000 (UTC)
X-Greylist: delayed 01:06:03 by SQLgrey-1.7.6
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C73C686B1A
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 21:36:44 +0000 (UTC)
Received: by mail-pf1-f201.google.com with SMTP id d127so385257pfa.7
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=9oP9ZiTU1p6lF1U2mfS1bBIXLROAWtwOnKtBSbb21XQ=;
 b=c+fqP6D62YFfsQ+J6OBoM/aeGgTpFFp6n879QHcWNXJ9rZEA3joGLu5Khb/SAjaZwv
 yuSXfO/WvDezMPhKpeVoFdIUBiyrw6CTx1pApaHbssDflsPf1+RC+6DY3+GGhGx1KWJi
 68lBGhbGdFAoGu5K/nKOUhdyJFwYc1TMGRkYFAiIJdged0YFP76LlT38a9DbwBqXK/34
 uqyyBLmJYNXz6tE9+Vxhch09eMpn2UNX2P8D5sVB1B5FfKn4HMfwfAeoDg9p45rz8FfS
 oW+WQOJnUW8nbgJlwUcd7MT8SiMAl5sjpmCP8PUdcc+IJsja6qKXu13jzTYanXCb+8Fv
 f9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=9oP9ZiTU1p6lF1U2mfS1bBIXLROAWtwOnKtBSbb21XQ=;
 b=YpP1jGCcUD+rAFd04g+OZUuQaA1TLBKtfRN6uNX2RuvDd6AXgdUkcDyCl3v/OB+UqQ
 8E3YnyA5j/E/k6h8ATWBHzqbsOPb+wnIv86z7YzWAvtIWIRNQdEechVds7AQegyEY4O4
 LkRbi/xCFpcT+am8V7+xGXvzd8Ftc60WggwBgHBpM50Syxo1+0IsO1uXjsCvyrw/ycaI
 sy9l2tYHbco/KLKdfhFDpVuC4UcbD9HEl+PzgVv0TlY/KHsKOO35QccWMCzyRfXwf8T0
 u6p6Psw3uH96sVXO1/gT0WrUn7rrNAWp6l7+TRK0N+Z3axAJ+lrwrwwQOC+Eo0tbsyU+
 LtSA==
X-Gm-Message-State: APjAAAVjW/XwEQBQaLvzrB6FUogPKFNvkbiNWUxhbKsTKjSmxM2K1ivf
 jamSpSHnjMth5LdWsB99sut+mtisatoogQ==
X-Google-Smtp-Source: APXvYqxc3+QtUOXjvCNDTiXAo4RmNzOVk/qFDGek88Tooc1vbUAVhLRDfbsX+YtSCJhE/899DR3rlT69jwQ5PA==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr568086pgm.367.1582749040887;
 Wed, 26 Feb 2020 12:30:40 -0800 (PST)
Date: Wed, 26 Feb 2020 12:30:06 -0800
Message-Id: <20200226203006.51567-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Yonghyun Hwang <yonghyun@google.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Havard Skinnemoen <hskinnemoen@google.com>,
 iommu@lists.linux-foundation.org, Moritz Fischer <mdf@kernel.org>,
 Deepa Dinamani <deepadinamani@google.com>
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Cc: <stable@vger.kernel.org>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---

Changes from v2:
- a new condition is added to check whether the pte is present.

Changes from v1:
- level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
- a macro, BIT_MASK, is used to have a bit mask

---
 drivers/iommu/intel-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 932267f49f9a..0837e0063973 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5553,8 +5553,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	u64 phys = 0;
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-	if (pte)
-		phys = dma_pte_addr(pte);
+	if (pte && dma_pte_present(pte))
+		phys = dma_pte_addr(pte) +
+			(iova & (BIT_MASK(level_to_offset_bits(level) +
+						VTD_PAGE_SHIFT) - 1));
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
