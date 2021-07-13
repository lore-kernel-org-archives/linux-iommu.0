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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC6C11F67
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:25:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783386127C
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783386127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 571F160ADC;
	Tue, 13 Jul 2021 17:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6lZY32g5Ewo; Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23DB360AEB;
	Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06410C001A;
	Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C601C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70838403F7
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wG3OliT3Gdd3 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 17:24:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CBE740258
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:58 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id t9so22228037pgn.4
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/OnJyiKdawRczHBK8l+xsNJeqd/pB2iob+dpAm/qBJo=;
 b=aeg79t/ohUq0FJbCDzr7a5tw8ItJtyoU4OWrCIh/1+MB/y0nGiUSUyVcgu/eTB5M7o
 fRpxeyz1rvlTkAouc0YlwrqyXaZCoKwgFLQTO18nekT8a2cpexK8SP3Gk5mMaXDJWVoe
 wUzdtLjLMyhTg6y03r21+ZgL7MeMaMhSn9ivdqwAJ4BZY9fcM2Ok0uN1mBNg+HiGrA8+
 VXxeSK6aYyCz33QokEQwXuJEphgtAjoW+d/qE8eIlwPul7YJ1Wvg06Roc2ZSMxtw7fVR
 6dz3CgfV3vguSi9U0KdyimUgYIh2ghXH//sesh4JVPQQS6IxmeUuihnTpuXyUwc1zv97
 un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/OnJyiKdawRczHBK8l+xsNJeqd/pB2iob+dpAm/qBJo=;
 b=tnGXhzNXX9Ug/wq8ie+rxFn0kiLAszhnziEwNlHxPvWALkz51HB0KzoxyWtOM4BKn6
 i2ju2QnW3mkYaqw8UoLdfmibsseTlBa5vuM1VPklhT41dOiQv/MmUB00fPoCn+IFk3xi
 G/m39O7UB+0lEQEEgU0eaOzuOuUw3YNRKAYR/NrSYQJHwY/dyHMPlukDnD8ex6qT/ONm
 221M03StN4toTMsHQZ1DvOoYLDozE+hdMKhAhtgeFElhFR7k6WCuuXs1scH8uzguofnk
 8lMV/wZXDhwvk0Pb/MOCfgWPPX6LQ+486L7LsgRkRpbDx9+UuaGXcOZkNUE3vjeHcERR
 J0lA==
X-Gm-Message-State: AOAM530k+D5WODI3FRvw6XYmFNAPL+2EocADtuIJqiS454HmkVo9Hh0l
 D/7hzBwJLismHpZflQjOZ90=
X-Google-Smtp-Source: ABdhPJwshrXwPGL19tov8a5uTMLT6la9IlhIdnWkQrxqDkxaa76RMvN0HOBhVnTmoX3Z+QGBkCOUHg==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr5229304pgi.323.1626197097866; 
 Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 7/7] iommu/amd: Use only natural aligned flushes in a VM
Date: Tue, 13 Jul 2021 02:41:51 -0700
Message-Id: <20210713094151.652597-8-namit@vmware.com>
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

When running on an AMD vIOMMU, it is better to avoid TLB flushes
of unmodified PTEs. vIOMMUs require the hypervisor to synchronize the
virtualized IOMMU's PTEs with the physical ones. This process induce
overheads.

AMD IOMMU allows us to flush any range that is aligned to the power of
2. So when running on top of a vIOMMU, break the range into sub-ranges
that are naturally aligned, and flush each one separately. This apporach
is better when running with a vIOMMU, but on physical IOMMUs, the
penalty of IOTLB misses due to unnecessary flushed entries is likely to
be low.

Repurpose (i.e., keeping the name, changing the logic)
domain_flush_pages() so it is used to choose whether to perform one
flush of the whole range or multiple ones to avoid flushing unnecessary
ranges. Use NpCache, as usual, to infer whether the IOMMU is physical or
virtual.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c1fcd01b3c40..cb5ea94055e1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1261,15 +1261,52 @@ static void __domain_flush_pages(struct protection_domain *domain,
 }
 
 static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size)
+			       u64 address, size_t size, int pde)
 {
-	__domain_flush_pages(domain, address, size, 0);
+	if (likely(!amd_iommu_np_cache)) {
+		__domain_flush_pages(domain, address, size, pde);
+		return;
+	}
+
+	/*
+	 * When NpCache is on, we infer that we run in a VM and use a vIOMMU.
+	 * In such setups it is best to avoid flushes of ranges which are not
+	 * naturally aligned, since it would lead to flushes of unmodified
+	 * PTEs. Such flushes would require the hypervisor to do more work than
+	 * necessary. Therefore, perform repeated flushes of aligned ranges
+	 * until you cover the range. Each iteration flushes the smaller
+	 * between the natural alignment of the address that we flush and the
+	 * greatest naturally aligned region that fits in the range.
+	 */
+	while (size != 0) {
+		int addr_alignment = __ffs(address);
+		int size_alignment = __fls(size);
+		int min_alignment;
+		size_t flush_size;
+
+		/*
+		 * size is always non-zero, but address might be zero, causing
+		 * addr_alignment to be negative. As the casting of the
+		 * argument in __ffs(address) to long might trim the high bits
+		 * of the address on x86-32, cast to long when doing the check.
+		 */
+		if (likely((unsigned long)address != 0))
+			min_alignment = min(addr_alignment, size_alignment);
+		else
+			min_alignment = size_alignment;
+
+		flush_size = 1ul << min_alignment;
+
+		__domain_flush_pages(domain, address, flush_size, pde);
+		address += flush_size;
+		size -= flush_size;
+	}
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
-	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
+	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1296,7 +1333,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		domain_flush_pages(domain, iova, size, 1);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2200,7 +2237,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
