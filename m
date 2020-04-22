Return-Path: <SRS0=sVNY=6G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56AC54FCB
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 13:59:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0762077D
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPmMIwCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0762077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 127CB85DF5;
	Wed, 22 Apr 2020 13:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K89Bq9vx97qw; Wed, 22 Apr 2020 13:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5060D85DB1;
	Wed, 22 Apr 2020 13:59:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC87C1797;
	Wed, 22 Apr 2020 13:59:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 788A3C0175
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 65E9120413
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fuqUrDbY4wC7 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Apr 2020 13:59:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 3794D20377
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:59:31 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id u127so2494960wmg.1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LGJn2EBGUopJoaM2LWaeSAL+Bvk/4ps4hPFTtZUoi54=;
 b=LPmMIwCXFLoANa9QCBduOahStOy4ODFalIn042aXj/Vi5nSiq02QTd7vTcJa7Nj09U
 DDqNXLLBHe0Oi9+UY957hLnTRGHrudRFtCJlsIruLSkzkekGniIKXT89FYFfV1CeWHFZ
 oWxJIO/mKTHTOgqUlYdLfaZS8pScv5UZvg5PQkM524bKHuOg+ElZAsF5gF9Tg+J9syO2
 Iq0Y40/9Kz40xSxeoJuOnlWlrGDYNvcAr0ySy3iwmA4Ay2QkYZIl0oSw9tp3sC0jeg++
 9VUP7PLXwPqIpZvB71AEwMolkIJLNgMxCe7yNbJWGNM997Q6PQaWR/yyaQRS2ZW5o3zd
 DEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LGJn2EBGUopJoaM2LWaeSAL+Bvk/4ps4hPFTtZUoi54=;
 b=Z3/fpwzeiETv4y5cyvHasb1H/sIfS+Bn7Gxno6sGtVj5n0xvZdLi/Ea8MMgNj2YXd2
 o50HUdUORzYba8qIFcUQi0x19nzTeomsR329gKb/EUoZKMpVx2odDU9xcvDJqafI7y6R
 QjXtUMoSBZq37KFXWVJb4FNCPtBpQyIjC2tmtJ+aldaG6BYnQC2u9xQWEBzLGZCBvanL
 3i4R/KxjlJ5H58KyyxU1K4DLFxWg5gzXQnuSjz8cNd6Udv1/qjaZYkJHWnC1vDQcLYmB
 xNl07n2RYdiyHJDvIyqSDUbDC7eZ/MGVZi7/GoGc+OKS8izDfjAi5qe0AhHQPWPrRgQ4
 EB/w==
X-Gm-Message-State: AGi0PuakZ+K+z7SByPIDdPtpQeZAkNtm1+R/k115EOmsF4h0kt8j5Hvw
 Op7Wuy7sRiAxjQIe6LfNNjoEaw==
X-Google-Smtp-Source: APiQypLYAxD3694NDrLP9f3MZqnASzwJNKNsqZ2SlrXG+04CqKEvj1S62FlDQL1zHDuXxvWYLsRIDA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr2982381wma.122.1587563969565; 
 Wed, 22 Apr 2020 06:59:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm7433266wmb.16.2020.04.22.06.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:59:28 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH] iommu: Free fwspec with the dev_iommu object
Date: Wed, 22 Apr 2020 15:55:14 +0200
Message-Id: <20200422135513.617599-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
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

Kmemleak reports that iommu_fwspec is leaked during device probe
deferral. For example:

1. The first device probe allocates a dev_iommu and a fwspec, then
   returns with -EPROBE_DEFER (because the IOMMU hasn't been probed
   yet).

2. The IOMMU driver registers the IOMMU on the PCI bus, which calls
   iommu_probe_device(). However at this point the device doesn't have
   IOMMU ops associated, so add_device() fails and iommu_probe_device()
   calls dev_iommu_free(), which leaks the fwspec allocated in 1.

3. The deferred device probe allocates a new dev_iommu and fwspec,
   before calling iommu_probe_device() which succeeds this time.

Fix this leak by freeing the fwspec in dev_iommu_free().

Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c3..54757c404866c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -170,6 +170,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 
 static void dev_iommu_free(struct device *dev)
 {
+	iommu_fwspec_free(dev);
 	kfree(dev->iommu);
 	dev->iommu = NULL;
 }
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
