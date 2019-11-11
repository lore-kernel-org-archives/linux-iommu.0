Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C8C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:19:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2D8214DB
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDHXmduj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2D8214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67056C96;
	Mon, 11 Nov 2019 11:19:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A006DB62
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:19:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 241AC8A7
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:19:54 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id p4so14162791wrm.8
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fse92Wud5bezxZYvhZ7ctPlPrYXVpEQegC0mUXWfzdA=;
	b=KDHXmdujPpOVoxwCfokYbPDdczVXKG3NR0DDqhzWCWFa1XWwtDgSeMSlCFb6aXEReo
	VrNJQdA0QUpBIEGr6ZyQbp8nTNpcKFQezlXGhh+4yxbNEJA3MWtGlXRiLe8nP0U8ZJE8
	kIhb20pUWG3ttEfHm7g91TDX8wnGr2HMefzQZOmiZD7BVOGzZQ9NLt81UcSeajHTbdIk
	dLcbZHwUJGGiuku5HStUWVxOQMOvg7SEj4IEkln6XyD1w3XZr4NddHgBkjh5LGtVHca6
	aI/K1djQoD9/uvzqE8WzwYMxLKaKhW3AqHivxb1OkRbEA5/6vo7wNUeypsYSXjmUp8Tp
	RGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fse92Wud5bezxZYvhZ7ctPlPrYXVpEQegC0mUXWfzdA=;
	b=YMXSySaPx8LLd8LU1UWao+1Eouekz3mnU32hkygmRj4SQRteWrvp4rFdxw91j5mjUn
	aIw9suDMvfb64dZ7y34VL/v0Zs0i8kamVQ12hwKFPM3w3g/KUHEIMPR59saXm1Cz7B+w
	TBqvQaxvSf8zQydZaFdoHFOLyip1bQ1bNryaImR+ImBYTeamO2RgjxGmJcu40Fex2vma
	4nGjss7N6yg4ssv4b2PG05qKx4mqTKsErIaYnb3lqRgquNRpvvJyJYWXiTXQ7G4WURyu
	0m2DFlMJ0P2x8XaftRXieI5kVL6Rt0hmvHAgUHONHB5y+bxdcLUjULwgpsNO7BpKTwFF
	3fbQ==
X-Gm-Message-State: APjAAAWbn8xmoyAVhZqAnHXMoO1qGUSu+kUTGegEiYgGJyt9AeqEDZOd
	4L9PaJxJVPW1Ic1mMXGjsZpZXQ==
X-Google-Smtp-Source: APXvYqxzlDnHmYA4fbPKCb3MThMMHYCJFylL3vcWwjWHDLrqEvnOebecSDuj2VoS/pRaTVqEnIIb8g==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr20648267wrm.366.1573471192731;
	Mon, 11 Nov 2019 03:19:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
	[188.155.204.106]) by smtp.gmail.com with ESMTPSA id
	w81sm22933452wmg.5.2019.11.11.03.19.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 03:19:52 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/arm-smmu: Remove duplicate error message
Date: Mon, 11 Nov 2019 12:17:21 +0100
Message-Id: <20191111111721.4145919-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111111721.4145919-1-jean-philippe@linaro.org>
References: <20191111111721.4145919-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: robin.murphy@arm.com, will@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
to platform_get_irq*()"), platform_get_irq() displays an error when the
IRQ isn't found. Remove the error print from the SMMU driver. Note the
slight change of behaviour: no message is printed if platform_get_irq()
returns -EPROBE_DEFER, which probably doesn't concern the SMMU.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c503a6bc585..6f676686752c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2062,10 +2062,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	for (i = 0; i < num_irqs; ++i) {
 		int irq = platform_get_irq(pdev, i);
 
-		if (irq < 0) {
-			dev_err(dev, "failed to get irq index %d\n", i);
+		if (irq < 0)
 			return -ENODEV;
-		}
 		smmu->irqs[i] = irq;
 	}
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
