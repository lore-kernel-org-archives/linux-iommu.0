Return-Path: <SRS0=FiUI=EY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E5C63777
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 11:24:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BAB2078D
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq+E3vVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BAB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9173F85487;
	Wed, 18 Nov 2020 11:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6Lw8FVV8XPn; Wed, 18 Nov 2020 11:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DBC0854B4;
	Wed, 18 Nov 2020 11:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 091EDC0891;
	Wed, 18 Nov 2020 11:24:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F922C07FF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 11:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0AC06854B4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 11:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRIV3KS_0mDh for <iommu@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:24:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6377F85487
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605698640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMV1y86LEZa3kYwZ8iP5D6nppr21q5lgJ0OynKLwxhg=;
 b=Xq+E3vVrSatiwtD/9KCOTSha80m5wH/x4wY4cMK/BE3tEzvyMs9EOzLwtjtD3i+eN9JUoO
 03+WshSDVLpKKV3wie9A+qHz8IzNolA3ozrZL8lR+xaZMy4iB5P5sigVlyI1WGd+8g6f7r
 cRdCi86QfnnyXN15+Cwq8Vtr4STvw/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-ARgRYGBNPxCWe6YeN5iJ6Q-1; Wed, 18 Nov 2020 06:23:56 -0500
X-MC-Unique: ARgRYGBNPxCWe6YeN5iJ6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE05873115;
 Wed, 18 Nov 2020 11:23:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-115-104.ams2.redhat.com [10.36.115.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17EEE51512;
 Wed, 18 Nov 2020 11:23:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
 alex.williamson@redhat.com
Subject: [PATCH v13 14/15] iommu/smmuv3: Accept configs with more than one
 context descriptor
Date: Wed, 18 Nov 2020 12:21:50 +0100
Message-Id: <20201118112151.25412-15-eric.auger@redhat.com>
In-Reply-To: <20201118112151.25412-1-eric.auger@redhat.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, zhangfei.gao@linaro.org
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

In preparation for vSVA, let's accept userspace provided configs
with more than one CD. We check the max CD against the host iommu
capability and also the format (linear versus 2 level).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 977c22d08612..ed64699a4a0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2905,14 +2905,17 @@ static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
 		if (smmu_domain->s1_cfg.set)
 			goto out;
 
-		/*
-		 * we currently support a single CD so s1fmt and s1dss
-		 * fields are also ignored
-		 */
-		if (cfg->pasid_bits)
+		list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+			if (cfg->pasid_bits > master->ssid_bits)
+				goto out;
+		}
+		if (cfg->vendor_data.smmuv3.s1fmt == STRTAB_STE_0_S1FMT_64K_L2 &&
+				!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
 			goto out;
 
 		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
+		smmu_domain->s1_cfg.s1cdmax = cfg->pasid_bits;
+		smmu_domain->s1_cfg.s1fmt = cfg->vendor_data.smmuv3.s1fmt;
 		smmu_domain->s1_cfg.set = true;
 		smmu_domain->abort = false;
 		break;
-- 
2.21.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
