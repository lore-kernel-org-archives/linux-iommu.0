Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99009C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:19:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6678321783
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 11:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWvxUvQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6678321783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3FD87C97;
	Mon, 11 Nov 2019 11:19:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2B9F8B62
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:19:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9C1218A7
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 11:19:49 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id j18so2923700wmk.1
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=XnVW9bguitmUqMyEzPyrdobpTBV9agELBQFiFzsMASE=;
	b=NWvxUvQ/prTUimwY97GIQlgTgNl41e08mLpTMGv4KJOq+UxyJg2fFHfs8X53ApnHNi
	f8mkVM+dSc3xmlUFNqXsZHg6sjI4gaqzEBowrn5OwZtialhqeJc/8JncFwyY8Xh+BNmO
	W2GYyvTyGA/OWpzGjmf/+z6PPmvHSbvZR5oiC/zeER9ex5CPm3JbqAfxLkiuPiWViGd1
	++E7W3ZTxlTvdALC10siBBEdVTHq/2s6inIh/EPoIOQp/T22gWIpNfYQnL6UveTRnWMK
	HpSJrD02yRFG0OiLQZKPgunG43Y4sJgRjaROuvwomWrfmeqsMsRJVuP4dZDtEjGerz7+
	TOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=XnVW9bguitmUqMyEzPyrdobpTBV9agELBQFiFzsMASE=;
	b=HjjLw6jnqv+77V/FwETsoMqy0HnjeD8/cHafw8nUZBC4tnkhMSwtKFcCSHTIzSHDns
	9Jyx8fQOTAuxSfAq8x4v9Z8p9ZKRkCCqe8FjPLckTLzVw5vdlg3Vs7ED2mHEM3qm5M7F
	B9foWp8N25M2H4wYaDHGaETjp41g6MQJB1fSMbtY6CXYKYUB0mCew8rmNHY389kCf9ZN
	8CvnbyXzmQcTwfOXhuuux20pX2NbVDXVrd+QYTVafwewVo4dKWHCJQDlt+ZrMHZjKER4
	V7PGt9Q1Xno9Mow1JaGBckkmrsVAuQ2ur1c32aQRdei2Xl8PouAzJWtA3B/ryQiuqF0r
	5sbA==
X-Gm-Message-State: APjAAAUypJl3xK8lTBYHNtJeemuqG8LajSm6EM8jJ0LgPNT8GkcWK7RL
	6cne0sk9fGmdpqVFi477eDvP+A==
X-Google-Smtp-Source: APXvYqzGQ3QVzcNTYM4NAqtpCqAkQsd1J3dJLZz7ae1spgUxQRXgtYMtpooW/xUzp4UWOAct7GnneA==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr9244871wme.89.1573471188204; 
	Mon, 11 Nov 2019 03:19:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
	[188.155.204.106]) by smtp.gmail.com with ESMTPSA id
	w81sm22933452wmg.5.2019.11.11.03.19.46
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 03:19:47 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Don't display an error when IRQ lines
	are missing
Date: Mon, 11 Nov 2019 12:17:20 +0100
Message-Id: <20191111111721.4145919-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
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
to platform_get_irq*()"), platform_get_irq_byname() displays an error
when the IRQ isn't found. Since the SMMUv3 driver uses that function to
query which interrupt method is available, the message is now displayed
during boot for any SMMUv3 that doesn't implement the combined
interrupt, or that implements MSIs.

[   20.700337] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ combined not found
[   20.706508] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ eventq not found
[   20.712503] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ priq not found
[   20.718325] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ gerror not found

Use platform_get_irq_byname_optional() to avoid displaying a spurious
error.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index bfa4a0f39ed0..a89797f346a4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -5207,19 +5207,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	/* Interrupt lines */
 
-	irq = platform_get_irq_byname(pdev, "combined");
+	irq = platform_get_irq_byname_optional(pdev, "combined");
 	if (irq > 0)
 		smmu->combined_irq = irq;
 	else {
-		irq = platform_get_irq_byname(pdev, "eventq");
+		irq = platform_get_irq_byname_optional(pdev, "eventq");
 		if (irq > 0)
 			smmu->evtq.q.irq = irq;
 
-		irq = platform_get_irq_byname(pdev, "priq");
+		irq = platform_get_irq_byname_optional(pdev, "priq");
 		if (irq > 0)
 			smmu->priq.q.irq = irq;
 
-		irq = platform_get_irq_byname(pdev, "gerror");
+		irq = platform_get_irq_byname_optional(pdev, "gerror");
 		if (irq > 0)
 			smmu->gerr_irq = irq;
 	}
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
