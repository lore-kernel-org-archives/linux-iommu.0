Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD55C433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 12:25:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEF120882
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="m1sx4C55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEF120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EE82586E08;
	Thu, 10 Sep 2020 12:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfN3UagCgbID; Thu, 10 Sep 2020 12:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C613384C99;
	Thu, 10 Sep 2020 12:25:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 864ABC0859;
	Thu, 10 Sep 2020 12:25:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13882C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D89602E1A9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nkFM9qeBW9C for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 12:25:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 60F67204E1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 12:25:49 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id bh1so836195plb.12
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hJMQ3l7D9c1jHa3lkbxsVQsPn/mQ9PWhdKwZ9KNTL6I=;
 b=m1sx4C55eJpUl/NnpzeEMYTsIQfCoVNwoG8sK1YYCwSWbS6ebtldCBKjzYquGLJjNb
 QIkcdQuSa6qC23sA76PmOxA0DkhHCbwLrOhCEHp1G0PBy1xjZp/tUNmksgcasW7GOT0j
 E9LXqk9iqt+2QCWGibI/eDous4DmVn8USIg9HEQU3Kay7RmqvtCf+q4GWnMism4PPEgM
 SQymKP32ZUnheFlxQNdm9dPFNFQZjZDRu8ZIHOuCFTwW7TGer0Ztk/FbzPMimjfA9q1J
 izcM2lTlMcR61ypwwE6qfjLhQC7PrBL/SE/MpsfAFJXSHemJijDGeKQ7xQIGqWaTMYcG
 t7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hJMQ3l7D9c1jHa3lkbxsVQsPn/mQ9PWhdKwZ9KNTL6I=;
 b=F46n9A2CPSPEKz6U87SoRBaZ2Kp06kkxnrP574NQC99fx47O64Q+clO98zYK1aBGz7
 yrJnGnbig0CkGXbnbjJlRfCzCh8sL9nPb0WmST/CXrbMIod57Elc6W5602TWeXGeknMl
 1oIh/GClsOdMP8MS7NnHGpsiqc2/9s95+hHqvDZ/8XzrcU66qqsdmi1L4huVM6sKADXX
 8gDnvT0CvkgfOrph69EHY/fbCQvTX2PpDXIajSGtweskNOBu7HR98e9u3jkH/0L0lQw6
 67YzMyWLHtRAw1g61S8dtYpW9VHVwivMKfbMamZihy4cum3dkHUoRKEOrlboXuKX2imR
 qhYQ==
X-Gm-Message-State: AOAM533O7imC5SQkSWkOGYRsyYeawy97sE/CSmbNLP2CxnoaINOdOyUk
 l114Mq6BucnEXcY9mYscCSEnXzmgtQDvUg==
X-Google-Smtp-Source: ABdhPJxF0L7lT3zbj43remcUB5Nu+6dRtVmxE0rsS/gucrCs0yEG8pClpd02cocKxEcMYApUlX0oyQ==
X-Received: by 2002:a17:90b:1046:: with SMTP id
 gq6mr4966136pjb.231.1599740748465; 
 Thu, 10 Sep 2020 05:25:48 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.teksavvy.com ([69.172.145.184])
 by smtp.googlemail.com with ESMTPSA id z18sm5884124pfn.186.2020.09.10.05.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 05:25:47 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] Handle init_iova_flush_queue failure in dma-iommu path
Date: Thu, 10 Sep 2020 13:25:38 +0100
Message-Id: <20200910122539.3662-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

init_iova_flush_queue can fail if we run out of memory. Fall back to noflush
 queue if it fails.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..5f69126f3e91 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -343,8 +343,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
-		cookie->fq_domain = domain;
-		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
+					NULL))
+			pr_warn("iova flush queue initialization failed\n");
+		else
+			cookie->fq_domain = domain;
 	}
 
 	if (!dev)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
