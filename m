Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B7C4320A
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E2A60E8F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21E2A60E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0701405C5;
	Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUjJNTH6o9ky; Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4590405A4;
	Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A34C0020;
	Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3ADC000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EABF483B30
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTNDFZGb1q0B for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:02:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7412A831EF
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:06 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id mt6so3156812pjb.1
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QRkB641yJcCb/0Kn6mAvfKfDyauYX+C6J+z3H+KwMfg=;
 b=jQfz++avmVQMEReAxFj3brhki689C89BCVDNGxMOcCfznbObjTlWUnEexzSFGaHFyh
 tSEryqbZeEQmfN+9XcezrcUZSrNWx4bnU9RhOJKliVYxaDRT4ZHFPpArW1i1/UKckYta
 cWUwulh34peaEvf+C+IbaBJaUbsLOhjJX18Oi3jBHhmbc4T5R00uvcRI+9XdGIC1hLiW
 itX7CKyNUOABg9EUpIlvBfnTcI8e8IFBEEyhUDLY3gXLhuRIylNcJhlvSi10xGWIGuX3
 TRgkqXU7NCw7+/z1Toh6n8YCbyKwq8GgJoyoKkO1otOwY134NrVlUMQpanMjDUcqfyce
 791g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QRkB641yJcCb/0Kn6mAvfKfDyauYX+C6J+z3H+KwMfg=;
 b=BIfu8mEiRp/a3rCuuHCDWM/JqXFEtK82uccE3WeWbnp7Wg6j792SYjQO/XEQ/NgN4i
 i+z8xBzauLzOU3fiRegzdDCkfqR7x0m0Y8WRb2q14etGxEOtDDH2CAHqIiadnDqPMlHg
 lEXm/VWhKBeceE56ZfwzX60An4Qzg3aUFc+LZx/PS8TaLp7qIKji2IY3GFBijNfYR0QO
 4i0vaIahkwgiRwdXH1+VmefvdKz7msluKucNU5Aw7ksSqqF0upgSSaoVon4wOFroQlqD
 AfrkZs8mLAbbpysLiA9rzWYl6crbkqa1od93p2V/4xGo8CB83A8hOuVlpF3ldS9PCvbX
 iftw==
X-Gm-Message-State: AOAM533/n+BcAV8ZcAuoWfBmirhZy7sX2lg68a0W54HVgWjwubSRwtl7
 vmOMw9T9JDhYZddBaEPVXrI=
X-Google-Smtp-Source: ABdhPJypGkANe53XromAl/C7tLdnNuJ8pJVuEb9XxPGL3iRHTCLSy65H6OkjAs5kuYYOP2b0jqsm9Q==
X-Received: by 2002:a65:6088:: with SMTP id t8mr5636818pgu.371.1627059725733; 
 Fri, 23 Jul 2021 10:02:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 10:02:05 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 5/7] iommu/amd: Tailored gather logic for AMD
Date: Fri, 23 Jul 2021 02:32:07 -0700
Message-Id: <20210723093209.714328-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bfae3928b98f..f5d5f2124391 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2048,6 +2048,27 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
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
+	if (amd_iommu_np_cache &&
+	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
+		iommu_iotlb_sync(domain, gather);
+
+	iommu_iotlb_gather_add_range(gather, iova, size);
+}
+
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      size_t page_size,
 			      struct iommu_iotlb_gather *gather)
@@ -2062,7 +2083,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
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
