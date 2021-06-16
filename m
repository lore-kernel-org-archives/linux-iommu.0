Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D39C49EA2
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F29161356
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F29161356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9F49404D8;
	Wed, 16 Jun 2021 17:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtBZOLNEwY6f; Wed, 16 Jun 2021 17:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5A84404D3;
	Wed, 16 Jun 2021 17:34:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C523C000B;
	Wed, 16 Jun 2021 17:34:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 062ECC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2FD6404CA
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9hlKEoHE7A6P for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 17:34:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2554F404CB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:31 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id e33so2587453pgm.3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kXz09feWPyifbFoBfjgnokAvwGkjdufnieFRhQ4k4Lw=;
 b=sn+QHskEW4APRjJ/4YJ6VC71n3rWCfqKk0RxSN1LP0jolG2LkFkPUuDif/RzFpsS5F
 3pGFbfm4iNWuHxUNL8c3t4PW5r7PGnGz1vYQApJZYY3FNTjwECI8CRkREHDRGlPuh+JH
 59szRa/GdoKPoWnuNbrUNwVL9BzC0nXbLRQlvS1be1ckLsXLuqLLY5vlsA2izpl4GmHt
 TZGIsfNMZA/S3OdKUy3tEiVj1dfNydBJlMKn9UX+dARMhgez4c9RSeNdT3QKOapotae1
 hMGloj1vev9h70+CYkusbHfBJ+hyXA8KMntIDAXmcm7YmaZO0lPXwgsD27G2d+byqIle
 ASoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kXz09feWPyifbFoBfjgnokAvwGkjdufnieFRhQ4k4Lw=;
 b=bGxDEGtS9Y8SWqwuT4bPJMZH2lNSaLaeHca/p2pPviuF9ykb8TcpE9hfKJ87JJe1H0
 U30MJZp2WJwWhGhT6ToF5X1/sx8tTniFzDJtJrXj19nePynGYYWc/fZcfO8WqmoADC/q
 ZfV8amz4CL1yR9kcOQRTJRPF9tB91usWX3WGwKKnJE5cVRJBoe8N6p/D5JT1WSsbpsF4
 imLH3cdthgB9qNn6Eaz5vrFPEJi/mZiW0cTIA3hZoqvTqQEiJDUZOGeCj9fTr/wMi6pe
 CJopOApajK1cgEdrnnuWGovEYweemTSCTW8plVXhTjvmXB4nCU28zFat+IkRguOmHxAF
 PqAw==
X-Gm-Message-State: AOAM530lbzdAzYuZRNREk6XX46hqjWMCtvFS/Q7xgVDHur24hTHV/Pmo
 28PH0Qz/KFLzA4NohaeYv9I=
X-Google-Smtp-Source: ABdhPJyXUc6GXMXaKYm8BTeRe+ZiQUequ43eZFEax2cadQZha4bUdFPsd2WlcP/kuUxqulwbwIWiNA==
X-Received: by 2002:a62:7711:0:b029:2f3:5a03:5a31 with SMTP id
 s17-20020a6277110000b02902f35a035a31mr882731pfc.81.1623864870282; 
 Wed, 16 Jun 2021 10:34:30 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 10:34:29 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 5/7] iommu/amd: Tailored gather logic for AMD
Date: Wed, 16 Jun 2021 03:04:58 -0700
Message-Id: <20210616100500.174507-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
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

AMD's IOMMU can flush efficiently (i.e., in a single flush) any range.
This is in contrast, for instnace, to Intel IOMMUs that have a limit on
the number of pages that can be flushed in a single flush.  In addition,
AMD's IOMMU do not care about the page-size, so changes of the page size
do not need to trigger a TLB flush.

So in most cases, a TLB flush due to disjoint range is not needed for
AMD. Yet, vIOMMUs require the hypervisor to synchronize the virtualized
IOMMU's PTEs with the physical ones. This process induce overheads, so
it is better not to cause unnecessary flushes, i.e., flushes of PTEs
that were not modified.

Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
of the generic iommu_iotlb_gather_add_page(). Ignore disjoint regions
unless "non-present cache" feature is reported by the IOMMU
capabilities, as this is an indication we are running on a physical
IOMMU. A similar indication is used by VT-d (see "caching mode"). The
new logic retains the same flushing behavior that we had before the
introduction of page-selective IOTLB flushes for AMD.

On virtualized environments, check if the newly flushed region and the
gathered one are disjoint and flush if it is.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3e40f6610b6a..63048aabaf5d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2053,6 +2053,27 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	return ret;
 }
 
+static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
+					    struct iommu_iotlb_gather *gather,
+					    unsigned long iova, size_t size)
+{
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache && gather->end != 0 &&
+	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
+		iommu_iotlb_sync(domain, gather);
+
+	iommu_iotlb_gather_add_range(gather, iova, size);
+}
+
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      size_t page_size,
 			      struct iommu_iotlb_gather *gather)
@@ -2067,7 +2088,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
 
 	return r;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
