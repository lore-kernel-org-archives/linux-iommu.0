Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F7C48BCD
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDAA61278
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDAA61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4793883A91;
	Tue,  8 Jun 2021 01:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2Xm0frM803T; Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D10483AB8;
	Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DB7C0022;
	Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C8D8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E8A8403DF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kn5eFWW26K_w for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:55:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1397F40401
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:27 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 m13-20020a17090b068db02901656cc93a75so13085950pjz.3
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uFTvQbgSS4vjW1gLIskRix1ckdU0+Wo0UqmTHN+t/Oo=;
 b=UslctD1uuZDXjRPn9kbMb1uXQWhxu5trekbHnKso09R6mgvBjFzNAQlyo8I+ahVEfZ
 0k4ZmCs3dKcKylKpbrltAlEUyjK7ei2HysqIxxpI/2EzsREF5wFfopu6ffsQgDTawv2n
 ry14xl2EScYHVs3l4Zve44TG1BgRIICqZxSU6Zos2CIINb7g0slOALyxb85gFMzZgOyg
 3Ro0mIqnPVTtTkBMGeRoAQ4cA+suYIZNYZMuci6a9ZfJ7FFAEY5d3iDH94pxccw6Z5Ko
 Y9vxmWnXMuLc6dHNtANbfJ3nYrGr6TV1O5YCy1+6xPL3WlvMU9PmpTneY/eQoKgZcSHQ
 FsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uFTvQbgSS4vjW1gLIskRix1ckdU0+Wo0UqmTHN+t/Oo=;
 b=BFuMu09C3AgxuTeYEP2xxkLR6+fU4S+jJ8YBlaMFkraRpKuagCYjlRThvBA/qEgrOu
 SFC8GCkN9CS7nJjB1lsG0uZHatexaDBOtbV7XiY8zxeqTSvYFf4A2a7gB0IdTezW3fIK
 6aNqqaLrCrT130TG1yjUDqRm2/ggnrS77yU5fAlOYbsTB6CUX+06BI/MeejXw6DEw5XB
 qzFdyrOQ/xM7Lt43fdf3md6FxUPmN/QZ+5Vs9arN5YVIH6nDzgFxUTRx8P5A/iTyoYwV
 W0T3ZDdFg1RXxcV/MS5WkmJQb03Gv0Al2QCVfbS1qJROxx63IMVCMWQee9ah25I9E4+N
 aRvw==
X-Gm-Message-State: AOAM530Q6ehCIHihce60CD/lGL7EM2vq20e4fCyA3JcMScsPXwF88Mh3
 U1KyKbCjkBZEwfmiq5eSpU4=
X-Google-Smtp-Source: ABdhPJzBYc5vEysdDZtlWaGoWcLV2RlUWUcJiiQJes3awhZZc2nidmFv9Uafm9CZ9JHLE/ThkgNIDQ==
X-Received: by 2002:a17:902:8341:b029:fa:2aef:7e3c with SMTP id
 z1-20020a1709028341b02900fa2aef7e3cmr20953159pln.9.1623117327417; 
 Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Date: Mon,  7 Jun 2021 11:25:40 -0700
Message-Id: <20210607182541.119756-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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

So in most cases, a TLB flush due to disjoint range or page-size changes
are not needed for AMD. Yet, vIOMMUs require the hypervisor to
synchronize the virtualized IOMMU's PTEs with the physical ones. This
process induce overheads, so it is better not to cause unnecessary
flushes, i.e., flushes of PTEs that were not modified.

Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
of the generic iommu_iotlb_gather_add_page(). Ignore page-size changes
and disjoint regions unless "non-present cache" feature is reported by
the IOMMU capabilities, as this is an indication we are running on a
physical IOMMU. A similar indication is used by VT-d (see "caching
mode"). The new logic retains the same flushing behavior that we had
before the introduction of page-selective IOTLB flushes for AMD.

On virtualized environments, check if the newly flushed region and the
gathered one are disjoint and flush if it is. Also check whether the new
region would cause IOTLB invalidation of large region that would include
unmodified PTE. The latter check is done according to the "order" of the
IOTLB flush.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3e40f6610b6a..128f2e889ced 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2053,6 +2053,48 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
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
+	if (amd_iommu_np_cache && gather->end != 0) {
+		unsigned long start = iova, end = start + size - 1;
+
+		if (iommu_iotlb_gather_is_disjoint(gather, iova, size)) {
+			/*
+			 * If the new page is disjoint from the current range,
+			 * flush.
+			 */
+			iommu_iotlb_sync(domain, gather);
+		} else {
+			/*
+			 * If the order of TLB flushes increases by more than
+			 * 1, it means that we would have to flush PTEs that
+			 * were not modified. In this case, flush.
+			 */
+			unsigned long new_start = min(gather->start, start);
+			unsigned long new_end = min(gather->end, end);
+			int msb_diff = fls64(gather->end ^ gather->start);
+			int new_msb_diff = fls64(new_end ^ new_start);
+
+			if (new_msb_diff > msb_diff + 1)
+				iommu_iotlb_sync(domain, gather);
+		}
+	}
+
+	iommu_iotlb_gather_add_range(gather, iova, size);
+}
+
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      size_t page_size,
 			      struct iommu_iotlb_gather *gather)
@@ -2067,7 +2109,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
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
