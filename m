Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF2C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08B520643
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P2kKdoZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08B520643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F395F1BFC;
	Thu, 18 Apr 2019 18:22:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BC5C31BF9
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:22:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from usvae2-clmxp01.aristanetworks.com (smtp.aristanetworks.com
	[52.0.43.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5504A828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:22:02 +0000 (UTC)
Received: from usvae2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
	by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id
	B662F30C1545; Thu, 18 Apr 2019 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1555611291;
	bh=OG5iz7Y2otWoE83PZVl2kJS3N6qNz01B8T1Adm2jXHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2kKdoZMNBpysYiVV3ZRHdCJ48ko9diG+wZtymsNs/BxIH/KvRFsoR8V62uxKx7bx
	ZStkH11wXB8zXnSQk07zA2XrRPdaulh/tIZnet5Q2pqDC2vNkrK/iTAShlBmgYhphj
	lpGfml8UzhHzpkMTBFnV9Nkk7e59A5EylCweN5Iv/5Y05THmm6P8mAiFPmLjvwS2kF
	D6N+MZv6QSzWRJ4/QXSjJVYHxp+/YBSf8s3WpzH4N1B+Be4D4a+obw+LE+4OJ55tvl
	r3uq00nWSItUQdqtzirdh+KOTmY6hkG8FFqpd3RACnKWUC6jqbg4w/ypH6TXVJBcdC
	/xbfJHzen9xmw==
Received: from chmeee (unknown [10.80.4.152])
	by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id
	9CCB930C1542; Thu, 18 Apr 2019 11:14:51 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
	(envelope-from <kevmitch@chmeee>)
	id 1hHBLA-0003pV-5w; Thu, 18 Apr 2019 11:00:52 -0700
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] iommu/amd: only free resources once on init error
Date: Thu, 18 Apr 2019 10:57:49 -0700
Message-Id: <20190418175744.6229-4-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418175744.6229-1-kevmitch@arista.com>
References: <20190418175744.6229-1-kevmitch@arista.com>
MIME-Version: 1.0
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Kevin Mitchell via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418175749.UF0cw3xNJvuKBrVjIAZIp4uSI5JCE7pFoJN-PpQpSrM@z>

When amd_iommu=off was specified on the command line, free_X_resources
functions were called immediately after early_amd_iommu_init. They were
then called again when amd_iommu_init also failed (as expected).

Instead, call them only once: at the end of state_next() whenever
there's an error. These functions should be safe to call any time and
any number of times. However, since state_next is never called again in
an error state, the cleanup will only ever be run once.

This also ensures that cleanup code is run as soon as possible after an
error is detected rather than waiting for amd_iommu_init() to be called.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5f3df5ae6ba8..24fc060fe596 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2638,8 +2638,6 @@ static int __init state_next(void)
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
 			pr_info("AMD IOMMU disabled on kernel command-line\n");
-			free_dma_resources();
-			free_iommu_resources();
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		}
@@ -2680,6 +2678,19 @@ static int __init state_next(void)
 		BUG();
 	}
 
+	if (ret) {
+		free_dma_resources();
+		if (!irq_remapping_enabled) {
+			disable_iommus();
+			free_iommu_resources();
+		} else {
+			struct amd_iommu *iommu;
+
+			uninit_device_table_dma();
+			for_each_iommu(iommu)
+				iommu_flush_all_caches(iommu);
+		}
+	}
 	return ret;
 }
 
@@ -2753,18 +2764,6 @@ static int __init amd_iommu_init(void)
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
-	if (ret) {
-		free_dma_resources();
-		if (!irq_remapping_enabled) {
-			disable_iommus();
-			free_iommu_resources();
-		} else {
-			uninit_device_table_dma();
-			for_each_iommu(iommu)
-				iommu_flush_all_caches(iommu);
-		}
-	}
-
 #ifdef CONFIG_GART_IOMMU
 	if (ret && list_empty(&amd_iommu_list)) {
 		/*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
