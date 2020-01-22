Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34922C2D0DB
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 14:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FE621835
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 14:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jds4Ok5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B42E186B38;
	Wed, 22 Jan 2020 14:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Rdd1BTzWN-Z; Wed, 22 Jan 2020 14:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2700D86B30;
	Wed, 22 Jan 2020 14:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B557C1796;
	Wed, 22 Jan 2020 14:37:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F7F7C0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 14:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 459D587CB8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 14:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HJjYxWNA8p8 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 14:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE2F887C8C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 14:36:59 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id x185so3508716pfc.5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 06:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=//w42q+qBbGvT7qPAjJmwfNgPPBQAXL4ZKZvItt7FSs=;
 b=Jds4Ok5iM8g1LzLArlC8aVs0AhGTcKpharU+HZCD+c8dUGMTOfMPDTpTDGYvdyz/H4
 MCgDmLRBbV/Uc2r5++KQyy7QJhWQpZf+JULalpE7JEo88StDsndx2s0nhoBeE29ZaVGp
 DvU9Pra7QOpLE4pTCCT6iubiFm+pIg6D/mEvJXFgMPWt6A8Vz+v3uz80dDPRcnA7Kl3/
 Z0UDMvspmofwkzoEl+udmU93tjktNje+glwp/hZ9v1hZfhIwhHssk1nEbbxATNPlI+3G
 MWk5cU38DYAti76UEaLGbeMO+DXqL61n/yZUzrdpMHCKjzJxeSVycQ1ULo83C1DDzFI7
 v62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=//w42q+qBbGvT7qPAjJmwfNgPPBQAXL4ZKZvItt7FSs=;
 b=tyJJl/vdEeONGdwUPYTYuTzMhDoeK9+uvnxgS8ytjTyrVhF8aWDoaUdujvl32ZaUcn
 TzZiDWWMbBpvF7rJNA33cHaWQw8S7cvVclvcBoWb5yhQDO0bwdZhSJt4UoJhvMcY5wNi
 hfLbw6n+jfugFnMLFfT4gu8SaztV7I5lE5mhNcQXmJm1V/me5o87NK9Nilez+WoIUooA
 /JSzhS+9uGrdVgbngsGZb6NKk4MOPOw+1uQCtomP9yLj0c70El1u8MKgqzgz9LhiZAt7
 lsajWBXd6W2qfe3eus5JJE9l+1wg9bLSPrmfCqRFLD1uvyQP64tU6OiJ8QXMQW4sOnS5
 exsw==
X-Gm-Message-State: APjAAAVWoTzubaqFMjF+MSfGwfLMhTNEr+FVhxL/sW7nZC/0FZEpCQY1
 UuHXdbBHBPqDV5dZS6goVzw=
X-Google-Smtp-Source: APXvYqydPCNrlSZG1r5t81Jkby7LrEEIHrg5ciYKRrMCqFmXBlIh5gZUY81Ce6X7/IOQQbp6yXqnRg==
X-Received: by 2002:a62:28e:: with SMTP id 136mr2826619pfc.256.1579703819232; 
 Wed, 22 Jan 2020 06:36:59 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (36-237-123-54.dynamic-ip.hinet.net.
 [36.237.123.54])
 by smtp.googlemail.com with ESMTPSA id m3sm47054052pfh.116.2020.01.22.06.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 06:36:58 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/amd: Remove the unnecessary assignment
Date: Wed, 22 Jan 2020 22:36:29 +0800
Message-Id: <20200122143629.21161-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

From: Adrian Huang <ahuang12@lenovo.com>

The assignment of the global variable 'iommu_detected' has been
moved from amd_iommu_init_dma_ops() to amd_iommu_detect(), so
this patch removes the assignment in amd_iommu_init_dma_ops().

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd_iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bd25674ee4db..79f08c0a1f00 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2297,7 +2297,6 @@ int __init amd_iommu_init_api(void)
 int __init amd_iommu_init_dma_ops(void)
 {
 	swiotlb        = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
-	iommu_detected = 1;
 
 	if (amd_iommu_unmap_flush)
 		pr_info("IO/TLB flush on unmap enabled\n");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
