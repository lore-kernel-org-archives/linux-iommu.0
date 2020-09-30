Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF66DC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:45:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBA82075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WmZ73VAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA82075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B266C86855;
	Wed, 30 Sep 2020 07:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XV7GzYodGHKZ; Wed, 30 Sep 2020 07:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8A4B85F6D;
	Wed, 30 Sep 2020 07:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF46C016F;
	Wed, 30 Sep 2020 07:44:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C5C1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 978FD8653D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYLFQhxrgfSu for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 07:44:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A55B85F6D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:44:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1601451894; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=y2RACSNbM/VuhRY0W6oMfPilp6Rd9tTfRILzRpy1sVY=;
 b=WmZ73VAdm3ZtZ3Dn0DPSeDh9sRHuVT2HQeiMGA/ijfpgkhhBzI29xDCfKi06UQK9QHknRM6/
 jx10guRW5TXIR96iGskcsdLdNPVk/HNkOqAcFnYBhzWRvIce7AAyVU0uOmEibyRBTX9Ylc8e
 OFQ9OX28pwUigyJ1hN0wJnJ9jBw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f74376b3a7e097c8c6e3b35 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 07:44:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CC1A6C43385; Wed, 30 Sep 2020 07:44:43 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D7ADDC433CA;
 Wed, 30 Sep 2020 07:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7ADDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
From: vjitta@codeaurora.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
Date: Wed, 30 Sep 2020 13:14:24 +0530
Message-Id: <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
Cc: vjitta@codeaurora.org, robin.murphy@arm.com, vinmenon@codeaurora.org,
 kernel-team@android.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever an iova alloc request fails we free the iova
ranges present in the percpu iova rcaches and then retry
but the global iova rcache is not freed as a result we could
still see iova alloc failure even after retry as global
rcache is holding the iova's which can cause fragmentation.
So, free the global iova rcache as well and then go for the
retry.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c3a1a8e..faf9b13 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -25,6 +25,7 @@ static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
+static void free_global_cached_iovas(struct iova_domain *iovad);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -442,6 +443,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 		flush_rcache = false;
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
+		free_global_cached_iovas(iovad);
 		goto retry;
 	}
 
@@ -1057,5 +1059,26 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	}
 }
 
+/*
+ * free all the IOVA ranges of global cache
+ */
+static void free_global_cached_iovas(struct iova_domain *iovad)
+{
+	struct iova_rcache *rcache;
+	unsigned long flags;
+	int i, j;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		spin_lock_irqsave(&rcache->lock, flags);
+		for (j = 0; j < rcache->depot_size; ++j) {
+			iova_magazine_free_pfns(rcache->depot[j], iovad);
+			iova_magazine_free(rcache->depot[j]);
+			rcache->depot[j] = NULL;
+		}
+		rcache->depot_size = 0;
+		spin_unlock_irqrestore(&rcache->lock, flags);
+	}
+}
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_LICENSE("GPL");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
