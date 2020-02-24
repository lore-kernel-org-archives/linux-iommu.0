Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6733C38BE8
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93344218AC
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+gSmo8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93344218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7897386CD7;
	Mon, 24 Feb 2020 18:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVAR86n+qNeJ; Mon, 24 Feb 2020 18:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 072FE874CF;
	Mon, 24 Feb 2020 18:24:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD69C18DA;
	Mon, 24 Feb 2020 18:24:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E06AAC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CFCD086055
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9GZZewCQzqmh for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B74786027
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:56 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id t14so329352wmi.5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aCHZ2/al18nS+2E0e9l6kgT+YcKjbmb+qVD5r1+/lK8=;
 b=Y+gSmo8lII58Es18d6cmWnjASSfFsl2x7rSop+H1cCniaeVd/mWWI5iBoB1UpuvK70
 WiCmaMu86SH+ozlrxPN0f3fd2cO/JAUaxBiQjRgMuCf7Ml/BcTQQ6QqzwqYLHtbBX4fL
 yyzI0XOaj4GoxBnIawd6Mc5b5sYLmz1hB0hfrlqesUOIHsyuwl6fwe4xrznynuKvPrPm
 urpHxochnQaDTmvE0T8BMvFjyPHBUT4MCdL4NYgnT6YOTbS0T2aSE78xPtZcUQVCujJe
 0MHikP4CvKbRZoTP4zT5mS23Ld+5V1Do2KyHkPn75kcCDLo4LZ5lZQdlY5r/Bb2YxQdE
 7Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aCHZ2/al18nS+2E0e9l6kgT+YcKjbmb+qVD5r1+/lK8=;
 b=t+mrmlSLB1B14G/WGdMp5G6jOJAX1I5w4PuemsX2Av3AeTxLIBP37A1AhaITyh7sJE
 IfxNtTmNmOAukEkNZC30xYDoeb4uRvfFycPqO7tQHBZCrxSTAEj50dmuQCtxK9e9RD3g
 osNzEGqCr3RzjbemQTG5MUSCOIh69mNazmXBEW1+/0QqFW72dD1l2Kt4FF4J3USLKZJ9
 eCYwVpjH8xLXyUYJHuvzD+hwzYq9OhINpdB+s/LINf1pw1NOcdFkNkUrFjfbBzPiN8LI
 8H6Tnf+W7lq2mHpeK6TuKZjF5OQc/a1evJrYHMveBxuRREN9QLC9Uc75heRRiio4naLv
 nxQw==
X-Gm-Message-State: APjAAAXY6z6IyaT878vmGX2AhPAhKC/8ZrrJef/T4Em4xmNalbTE7YKB
 h9RvsG9x44ZWZIJC2OqpK2P5nRZ/pSM=
X-Google-Smtp-Source: APXvYqytXg1jldnNeE/KhXMpeqS2ECo/t3rCI0BZEyvldnBIFN5uQN85/iXzJ1Ss+SSBo62MlVDbIA==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr312611wml.55.1582568692416; 
 Mon, 24 Feb 2020 10:24:52 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:52 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 21/26] iommu/arm-smmu-v3: Ratelimit event dump
Date: Mon, 24 Feb 2020 19:23:56 +0100
Message-Id: <20200224182401.353359-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

When a device or driver misbehaves, it is possible to receive events
much faster than we can print them out. Ratelimit the printing of
events.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
During the SVA tests when the device driver didn't properly stop DMA
before unbinding, the event queue thread would almost lock-up the server
with a flood of event 0xa. This patch helped recover from the error.
---
 drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 28f8583cd47b..6a5987cce03f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2243,17 +2243,20 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
-
+			if (__ratelimit(&rs)) {
+				dev_info(smmu->dev, "event 0x%02x received:\n", id);
+				for (i = 0; i < ARRAY_SIZE(evt); ++i)
+					dev_info(smmu->dev, "\t0x%016llx\n",
+						 (unsigned long long)evt[i]);
+			}
 		}
 
 		/*
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
