Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E175C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABAA20828
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYdOxD2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABAA20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A770C2154E;
	Mon,  9 Dec 2019 14:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0YzzpqUGkJ7; Mon,  9 Dec 2019 14:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EF1D12155C;
	Mon,  9 Dec 2019 14:50:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3719C1D8F;
	Mon,  9 Dec 2019 14:50:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80043C1D85;
 Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C5B287675;
 Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JIF503z7Vpmu; Mon,  9 Dec 2019 14:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8C8F08769B;
 Mon,  9 Dec 2019 14:50:20 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id d16so16479509wre.10;
 Mon, 09 Dec 2019 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I3aVjWdLXvLOfDvHl+80UOXgd4T3MYRIvZkx/WAfvow=;
 b=XYdOxD2z70YIt3ZS9joDPOLCuZDMHOr+p5n+49OM1+kg4Yc/Hxhrk5rkXDN4vE8qEl
 dQYNDkBLp/eGMnRMlGljZnwMFHJV+E147Pvt2Acjoc+c+81H012A8L14Uy5ZN4+i/SKl
 7S7a4eteQjj9rVp7uX9smhSTLH0jqehZdOB940kVbuSiI6RoMRiax35WQ9KxsrlYUPbA
 jR0uSuV6tFMZKWuZNPY+UDm8OcIR95YPafvM7+wGa4ufN5NPyemPAjtFMtXmyYtnGVyM
 RHD4FmCCnCamgojLAXcDcLT6ZJRRZ68IGI393N4Aa7h9N1Sv9zUIJ6OA4cVV8XXMeg//
 tdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I3aVjWdLXvLOfDvHl+80UOXgd4T3MYRIvZkx/WAfvow=;
 b=T1gIqsNZqFH+Dvq7e0e98UTrCDLIjcfCDhsuVNWE1vqY+iAYyZWtPZlIW3YaDiPhIa
 V/3a6AKZlVVFMiOVNm22BNpgmb9/IuVBCBlYqabOE5IWCgSp4vUQ5NurLzouOMxNrPA/
 evZD53BakyEK+XsjQfBsWnjYFqfWgKi60fSi7iVv++AOT1mw7hkDvAJtoMlqw3kI6phF
 zuHxgPQfIAc/yi0nHTgl3NIBvVyFv0SUXU4f8ExNs55jNlxud3P/7++NnwGG3fkeravG
 Uhsdya2tp2JpCIpAktkbVkFh7/nSk1rw/Ubqiyz8g8c61saAP/Qlgi2u62P45LChOAhz
 WsQA==
X-Gm-Message-State: APjAAAW43H4irjbpF59oF/JSy+UmXZdaGnKMP/pKFPWqOW7cf0yU9pe2
 iGtbBy5oXqF48hmiHONpVL4=
X-Google-Smtp-Source: APXvYqyzb+Gr3fnT6bZnw6Qeyd7z43gdd6oakIDoqaNzca4I3GYvDjohjO+w8mvyuTBM2hpMZlM+/Q==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr2615868wrl.117.1575903018924; 
 Mon, 09 Dec 2019 06:50:18 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id x17sm27547138wrt.74.2019.12.09.06.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:50:17 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 4/5] iommu: intel: Use iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:06 +0100
Message-Id: <20191209145007.2433144-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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

Use the new standard function instead of open-coding it.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..480f424f6a47 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5752,15 +5752,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	list_add_tail(&reg->list, head);
 }
 
-static void intel_iommu_put_resv_regions(struct device *dev,
-					 struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
@@ -5995,7 +5986,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
