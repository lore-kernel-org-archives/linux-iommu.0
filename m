Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CEAC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44CC22ADC
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44CC22ADC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 37FFD2E154;
	Mon, 25 Jan 2021 11:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46JdRG+s42Zn; Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC32520508;
	Mon, 25 Jan 2021 11:08:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDF9DC1786;
	Mon, 25 Jan 2021 11:08:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B40C3C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A233E8671C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xm0Pg1LY8lgk for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BE9E866F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id o10so10251776wmc.1
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
 b=KsPtTSBAe0tkUxNLmUgmnZTm9c5AfkV2YTEWV91OLlxWU6JSKf4TB8V0VJ52+PRz5M
 T5EtOM+4J3dfMdgyBbN7bdeDrXK6f1CJQo70cwWWD2/PdUJDA3fzcDOPJ2vYObqfF2iz
 xdypk+jPI41aBtU/ZlFSq13WhFnBQS9ToWK69kW6nrQMv7Nyla9UJoQMzKFheu3jHi5r
 42J2XKlP8z3Virz2svl9Lpi88Feg2unVcV98HLW1m8p4U+ZKpsCGfTBD/OnfHXowYuYQ
 AxnygmlRoR39X1p70/TI395nERXf7alKLVOR4sbR/F+VOGSzOgjGLYQNZmWywJVK71mT
 JpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
 b=p5wsDBp6LREmKmEZpLzFeYnr+aOH/zAtwEMFFHGseDfyUKaBuvgyZ3bxkdo58XVvnU
 QJApAHizpC+k3MDzMazLYhe7yzHho5Ed9EnbSW+pYD0YJKwCwgVDXfX16LGql+NAKuDh
 kZ+xZhFpJHZhpfgWnjmZJVLt3pXmSmSAbl7x+JXZw65w0THrIQzbS+6to25GtbXNlowm
 UBLrwHq++Ci/WwPOaN/Kwikh2QeXcYB2yovpCJ+KReiiN2GT+pGyZOdVzJT8oLmFutSU
 SSh/KnighBa6WGh3naLp9P5ur1Mgsu1qg3qbrgEyiloHQS7cAS/Cf3n22ThfJyMboAxu
 NKEA==
X-Gm-Message-State: AOAM530qSSq4QYO0V/YU7QMg9DvrA6jBt5TwjjE9dSy4tgSyA65JOzyC
 oDwnMq1rnsrTQjzzFt/WxOFfWg==
X-Google-Smtp-Source: ABdhPJyLrBTT0kgFcNfmxF11DJ3wmyawbClV/oUy/a3x37BteWrb2CKO+1xtg2+3GQCB+H4fNeXgOQ==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr1104717wma.147.1611572928161; 
 Mon, 25 Jan 2021 03:08:48 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 03:08:47 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v11 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Date: Mon, 25 Jan 2021 12:06:46 +0100
Message-Id: <20210125110650.3232195-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

The IOPF (I/O Page Fault) feature is now enabled independently from the
SVA feature, because some IOPF implementations are device-specific and
do not require IOMMU support for PCIe PRI or Arm SMMU stall.

Enable IOPF unconditionally when enabling SVA for now. In the future, if
a device driver implementing a uacce interface doesn't need IOPF
support, it will need to tell the uacce module, for example with a new
flag.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4edfcac..6db7a98486ec 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -385,6 +385,33 @@ static void uacce_release(struct device *dev)
 	kfree(uacce);
 }
 
+static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
+{
+	if (!(flags & UACCE_DEV_SVA))
+		return flags;
+
+	flags &= ~UACCE_DEV_SVA;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
+		return flags;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
+		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
+		return flags;
+	}
+
+	return flags | UACCE_DEV_SVA;
+}
+
+static void uacce_disable_sva(struct uacce_device *uacce)
+{
+	if (!(uacce->flags & UACCE_DEV_SVA))
+		return;
+
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
+}
+
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -404,11 +431,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
 
-	if (flags & UACCE_DEV_SVA) {
-		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
-		if (ret)
-			flags &= ~UACCE_DEV_SVA;
-	}
+	flags = uacce_enable_sva(parent, flags);
 
 	uacce->parent = parent;
 	uacce->flags = flags;
@@ -432,8 +455,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	if (flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -487,8 +509,7 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
-	if (uacce->flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
