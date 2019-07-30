Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A671AC433FF
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFBA20665
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EUVUdN1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFBA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1C5253222;
	Tue, 30 Jul 2019 18:26:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 86A23315A
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 18:16:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B8BF6A8
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 18:16:17 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id t16so30229685pfe.11
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kDBEcnQJfsnw+mnIW0/b6FtORHu9LZqCk2VAafP4T0g=;
	b=EUVUdN1/7hvdK11XyCYMXsZEejo/CxmxXn4Y/wTf8+Uo7K6CAROlOtgLd26sAATKoV
	e1DcUT64uWeNCTsKxI1u9N29+I/X3eZBnaEEAVaDt0qCDVj7HgGZDC0k3TqWVlyMgQ+5
	yzTpfG4SOA1+CX3MBN4/B1TJpa8VV1k5EozbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kDBEcnQJfsnw+mnIW0/b6FtORHu9LZqCk2VAafP4T0g=;
	b=QkAUhHrtDz8T2oCMoztuEr+1WclJBpKXPUsnfOWzmfmbO43WakrfmIkiOg60m4AwXf
	gMmKi/huKudCcU8vparMQOaJd0QJsZdPmjCSxQ6BxgbICuKLS1kABAd5DM3nqe8FTRae
	gKfKSimulap41QO25OXd4FCWr8s6Oz8TP/ylpZQfgStv0+JglxD71x4DCQKdnQKOcvFa
	ewC9okWv+kPg2KOHE27lsR/3sSpovxGGkK6sGVm8u+ivjW899w7Co5JMv0oVqmOkOrKU
	lG27YNwElMYwszpgcKfqSi9Lh7XbVxl11L35M0piy01XgD+3ZpyrlVVQoW8gSELbaO9X
	LEhA==
X-Gm-Message-State: APjAAAXKcEK9pBPEiACb0B/zckLpZouDkb+Qe97QADrI49W5a0TsaGtU
	wRf3exGahnrTVJA26pdi7m5XLg==
X-Google-Smtp-Source: APXvYqzu0Xs5GSslsQNll4ElHggYuH6Nv74MqChqVeexVNeRIb/yb4UL4y72L4llU+NELMP+k/XYFw==
X-Received: by 2002:a17:90a:9903:: with SMTP id
	b3mr117381729pjp.80.1564510577354; 
	Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	g1sm106744083pgg.27.2019.07.30.11.16.16
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 22/57] iommu: Remove dev_err() usage after
	platform_get_irq()
Date: Tue, 30 Jul 2019 11:15:22 -0700
Message-Id: <20190730181557.90391-23-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	iommu@lists.linux-foundation.org
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

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/iommu/exynos-iommu.c | 4 +---
 drivers/iommu/msm_iommu.c    | 1 -
 drivers/iommu/qcom_iommu.c   | 4 +---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0c1e5f9daae..1934c16a5abc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -583,10 +583,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->sfrbase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Unable to find IRQ resource\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b25e2eb9e038..3df9266abe65 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -750,7 +750,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	iommu->irq = platform_get_irq(pdev, 0);
 	if (iommu->irq < 0) {
-		dev_err(iommu->dev, "could not get iommu irq\n");
 		ret = -ENODEV;
 		goto fail;
 	}
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 34d0b9783b3e..fb45486c6d14 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -696,10 +696,8 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
-- 
Sent by a computer through tubes

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
