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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3604C43460
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9764E6101C
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9764E6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D85B60AEB;
	Sun,  2 May 2021 07:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1lYpnKMBF4W; Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6295360AED;
	Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB4BC000E;
	Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA141C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D650D60ADF
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7B3v5w2XFTPK for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E97E60AED
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 h14-20020a17090aea8eb02901553e1cc649so4015410pjz.0
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
 b=HZVuO6/Rey41sy8z0pQayPzweV8rnRftn35sAiSoX5e1Kkqh46ZUmwXTz5crnp5MDD
 KqRPfVQo+19EYhm93km29tf3f3RkxPcBy5WTshI1nUf1OXz8DGqbuH3QughkiO5ww0YJ
 09cV7VS/gPCuKq7997LUBtf830okwiYk8vfPczoCIMUlrdWD2uFwL2DP/Nsq+XYnAock
 JbUm9G6T6w4Ml7jiMAwR9lcVCEg/QhxtK3UVycjLmRYqXSneZgmeTMsVUPlKHO8+N7Ur
 JT3fRPicXILbS8zocKyhYL8XhodzQeXgF/cAWu9y00beZ3WM0g/bbbRrU3l08MT+vdeY
 Zl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
 b=Zw+892BVH+UxYO7J6afRHlyPl0j5ZkvWaO9v3NVvgMXWH34C2J53ReCSJaYl11ZugF
 UHC+AJypaD4dYqXTGYeN4EwQJNAk2QFO6Y365twToVEldAzkIb72FgMNt1oz+rKRrIH+
 4IqOmVlGT17fH/wG2+c2r+miuOXtAWDRgrCu2Ona9yWG0QSTWwiLGZ3ubw2Mz4EPQL+V
 oNPxzwnV/QeOJL9m4dIhYMoWIshCOAzEUFhJHL8Gw23rj/dsOEhQMMFJE7qEI9QhjF8J
 HaDU4IF/OQW1XYsnWGZJl9ojcXiWKXVDhul229ufkFtVZgVQxYWTf3HXHbkEyhmZXrue
 RsdA==
X-Gm-Message-State: AOAM5311CM0P4hRxv9OM+YUK+WKXtwlq5PcfA1JKG6JFeyvRoxez3h9W
 IbqLWYd5xgGDR+FbHstdoyu8NJv0lIBGOQ==
X-Google-Smtp-Source: ABdhPJzn2WBeI+9e6UMooihx3lJshAQ6hxiV/ubr3YTZswhh59uGo5pknPlopUPOlZpRpWoJI2avfQ==
X-Received: by 2002:a17:90a:a611:: with SMTP id
 c17mr10388845pjq.53.1619939114598; 
 Sun, 02 May 2021 00:05:14 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:14 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Date: Sat,  1 May 2021 23:59:59 -0700
Message-Id: <20210502070001.1559127-5-namit@vmware.com>
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

Some IOMMU architectures perform invalidations regardless of the page
size. In such architectures there is no need to sync when the page size
changes or to regard pgsize when making interim flush in
iommu_iotlb_gather_add_page().

Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
whether gather's pgsize is tracked and triggers a flush.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 include/linux/iommu.h     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b8cabbbeed71..1849b53f2149 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2215,6 +2215,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.ignore_gather_pgsize = true,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
 	.def_domain_type = amd_iommu_def_domain_type,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..1fb2695418e9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -284,6 +284,7 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 
 	unsigned long pgsize_bitmap;
+	bool ignore_gather_pgsize;
 	struct module *owner;
 };
 
@@ -508,7 +509,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
+	if ((gather->pgsize != size && !domain->ops->ignore_gather_pgsize) ||
 	    end + 1 < gather->start || start > gather->end + 1) {
 		if (gather->pgsize)
 			iommu_iotlb_sync(domain, gather);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
