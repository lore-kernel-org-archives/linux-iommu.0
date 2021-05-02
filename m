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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76981C43461
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249816101C
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249816101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEF6B40165;
	Sun,  2 May 2021 07:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7evB9nB-Z_cd; Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id E85FC400C0;
	Sun,  2 May 2021 07:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6038C0011;
	Sun,  2 May 2021 07:05:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4409AC0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33F0384C74
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvz106Zj_vQy for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87CE684C6F
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:12 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 l10-20020a17090a850ab0290155b06f6267so3970008pjn.5
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MkBwgwXs+4jvJxjQud3WrSBilsdtFonBHCFrnhB3HGo=;
 b=GsZkw0z4oL6vGd0oEaLLS9wU7WtNKvQxU4C9agSNsQPRrkTI4UONrk6q1mc10WGag0
 hlCvZ/+yn1OJKYF0Z85/l7/OXE16U67OF33sNfRnarWZwStLreY3yPis1vpH/ZCKb0dg
 ZYptl4CsCUW+FDkRZTISNmpDoHd/+o95Eqfl/5vDAmYynB70oNshRlaiYCTMs203nchg
 odmIb7YFQeW1KmfutT0h4WVb30hbrAAEZCYWmUaWRP3XxeSBjqi7GSZtYlUZ3I7kJWgH
 /DVE3EnGKBgmpR0XTXgacv4C0NKrGkq2KvTrgEtu5nLe+y/NdXgOkbYKeMJJCS8B+mI8
 CfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MkBwgwXs+4jvJxjQud3WrSBilsdtFonBHCFrnhB3HGo=;
 b=qfXLkyHafRX8eUtJ4GgsrnsLIzEVPy20rKypCIDNmo4ugMHQYR+ciMWKoSyRPRug6q
 KZOWLNxm7UPp0mf5MMbKUlsCUT9MnmINe3gIsdLQSISn5JU9j6u/JsbLgyMjW3+tx8F5
 XZwvyJzEZDExZv0ac+Xhm5QhrUuTI2I+gzj6+JhZVu1rDAfMaYcuRhzF6M5KhXh0tq+d
 9zBr2kjCF1U0k/puyHjqOzHZocR3yXW+XedbODw7Yj583lW1VFkPXlFX5Wdzj6VmZhyK
 6DjVguyHmtivrUmIm977194p5BtpRnzMxejcA82Ek64hkRdQMSRnLxEXNUFEhE9Ry0W6
 wy/Q==
X-Gm-Message-State: AOAM532CSOmlR81IDmoZdepTqMMrJxotHhHpxw9LPilQ6iFwPPtJjsAB
 pf1oVMoUO6e115mhxnMUZfg=
X-Google-Smtp-Source: ABdhPJxj+vmr2G9NHQBUOYaj0xUU1m5zqVf+s++g/nVi+l8GFvpPUZYqy7JIO0Hfoc3IvS5E7j0DUw==
X-Received: by 2002:a17:90a:4482:: with SMTP id
 t2mr14687194pjg.141.1619939111881; 
 Sun, 02 May 2021 00:05:11 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:11 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/4] iommu/amd: Do not sync on page size changes
Date: Sat,  1 May 2021 23:59:57 -0700
Message-Id: <20210502070001.1559127-3-namit@vmware.com>
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
changes. In such architecture, there is no need to regard pgsize when
making interim flush in iommu_iotlb_gather_add_page().

Add a "no_sync_on_pgsize_change" property for each IOMMU ops to decide
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
index 6723cbcf4030..8a71ad477c34 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2204,6 +2204,7 @@ const struct iommu_ops amd_iommu_ops = {
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
