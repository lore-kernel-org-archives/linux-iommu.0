Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF5C3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A5524650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMkAGME7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A5524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A1560214D2;
	Thu, 13 Feb 2020 16:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GkP+ySA9zZOe; Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E17421526;
	Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BDAFC07FE;
	Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5395CC0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 42A8A86E69
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfnA9H0mmYpM for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:40:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1752386E6F
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:19 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id q9so6986490wmj.5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ljIvDHLN6tog1gjQ51iNc2XMRU3cMi+uSkVVHu8cuT4=;
 b=OMkAGME7j7rQnbLnlKwKqvhjvo5FGigM7wlHU4CrcLnpiLC86ihdKcBsofYTSxPYRa
 KGW5vVaAF/GZ3G/ddvB9xGhznGLkrPRgmy1cagbrgJD4JfTiVEpTAZrru5VrHjeeaPWI
 kE4FOcM/lEx5lU7e3eD+mqvL3xOyFU1BQORJ26Q6jaH6IbjDtsO9XLK8oUVw478zdqa/
 peqvVcAUWFVhRbH9/zAv/g/e40YHVFdd6Zm8zBdbxlsYd8GAFHF+Va2g313xWjGqd/gX
 Ax+Hi+JHQVG0hbR23B73PHZWmAtYDIDUPCFX5cW8ktC2+XWiC1JDzhN4Ka03y8Fsh5cM
 /C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ljIvDHLN6tog1gjQ51iNc2XMRU3cMi+uSkVVHu8cuT4=;
 b=ZAJYMTWsaEQiC3TYlMoloKCbQe5cVxOmRiZYbI8zY/3bIx4qa1csfx9c7cuU6d1NLP
 JF4Gd3hc8XKqw82kZGZNO4mPQ/qmKuBuXsCqMvEvgTYsh3QTTLBPa62ZaocNBO44LB3u
 TbDXDmmHF5U/jyV7xLlcRLYe0Z766A2VLxppqezd3+O27DP6i1OHabyJyI70k1A+zO0v
 HadjnvQ90Slx608CcsHFlnlbQZF0WmhzJCuxiDiCG1qZmifXFJfPkkFgpbBbwrh2/177
 5PNqDosYHBcyhJQ5HnwsH6MW7prKaB0IIl45e674iyx4Zt1118IETl8GauPR7xvvvUci
 2sGw==
X-Gm-Message-State: APjAAAU8Q2MqlOjbCHVi+huYjOeIhs7ee+5JeO5s3pIqd5h7+LAkWKCY
 jUv0s7pJ6G9q9hySHkZ5QQA=
X-Google-Smtp-Source: APXvYqw7sINzUbnoD5ydFKpKcLaCTZ30fHyF6HFAksiO/pDQK8NvJDQvWRxVCSqMtK3CJfsOF10GSg==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr6643132wmi.75.1581612017438;
 Thu, 13 Feb 2020 08:40:17 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id y7sm3352850wrr.56.2020.02.13.08.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:40:16 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 5/5] iommu: arm-smmu: Get reference to memory controller
Date: Thu, 13 Feb 2020 17:39:59 +0100
Message-Id: <20200213163959.819733-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Use the memory controller framework to obtain a reference to the memory
controller to which the SMMU will make memory requests. This allows the
two drivers to properly order their probes so that the memory controller
can be programmed first.

An example where this is required is Tegra186 where the stream IDs need
to be associated with memory clients before memory requests are emitted
with the correct stream ID.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 drivers/iommu/arm-smmu.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..862ea55018e8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2109,6 +2109,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	smmu->mc = devm_memory_controller_get_optional(dev, NULL);
+	if (IS_ERR(smmu->mc)) {
+		err = PTR_ERR(smmu->mc);
+
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to get memory controller: %d\n",
+				err);
+
+		return err;
+	}
+
 	if (dev->of_node)
 		err = arm_smmu_device_dt_probe(pdev, smmu);
 	else
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 8d1cd54d82a6..d38bcd3ce447 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -18,6 +18,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/memory-controller.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -253,6 +254,7 @@ enum arm_smmu_implementation {
 
 struct arm_smmu_device {
 	struct device			*dev;
+	struct memory_controller	*mc;
 
 	void __iomem			*base;
 	unsigned int			numpage;
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
