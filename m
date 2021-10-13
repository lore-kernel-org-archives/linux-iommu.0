Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE3C433FE
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8974A610F8
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8974A610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DE78404F3;
	Wed, 13 Oct 2021 12:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QMknTqU0AyDX; Wed, 13 Oct 2021 12:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69046404EB;
	Wed, 13 Oct 2021 12:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35A50C0027;
	Wed, 13 Oct 2021 12:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D81FBC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B89C782B34
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id An4yRbetKFyc for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3453482B69
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id r7so7668728wrc.10
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xDTnrRgnMEuuTfEvTLplaIb3+nnniqO6/rA2MJHbSrw=;
 b=rkxNKwX8eGwNx3N9Hj4qSLFIQCSnuiQRyYIKSQpGsDX9mKBCMFkExf+yENn1TgK/Zd
 xWUpxVv7d1xpfIY9TlijY3ru4meFrloXp3CMJyugemTLCQfGt0IFgdnA6GvtUK8hPaC0
 3xm4JrNs4OTDTpC/m304sAXGM7Sbo34n4HNb+qaySQnHAKvRMepayKsPo6RFFQpOpQ1L
 UVpXy7K84LAkKjJexhq53ZwTSffopYZyD1qswfUnMAumQ8p+c+TDUTAJFepqkFAliveY
 pHWpdEDFPtmhzW61r4t+VBIapjHlc9Hy8jS9OHzMknvYZOfbP1WK+QT3H6sP5Ku6c8dA
 hqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xDTnrRgnMEuuTfEvTLplaIb3+nnniqO6/rA2MJHbSrw=;
 b=yoFBvoEp0mc8jEbbCEzhhpDz1lqhuFxw8A4QVPLMuR8hVcBC6Yh9/FlcDEy5KTPuAq
 BE602TzfB//Ifg/E51y2TpoRYpOtJBgajgsjW9l98OFbB+2Jzxe1HbzlnCobFQ9Rjj2+
 b3M46zg25RqpgI8JlNanhOe7URxTDcEwVwn99cWwMtJsZIy6AC12P/aCiBkvVUbzhnxn
 MrnhZW7O4byG9iFV8LLAWT7w/JKDme9mT/8E2/BNtZ+CYz4MbQ8hU+l4sp0BlzpIOzNt
 mnaIwivx3TFC8F5p/dPPtIOAnV9uu3bYyn9zUvdkMLww4oZHJ/OMCFJcX0SWFZl9yID8
 jXtA==
X-Gm-Message-State: AOAM531SD66n2lsvKmmMU4JLwQpATy0NH6aNakNNjdXUjRgZDIQPVmzp
 f5gruOHz+UrRB622JDF/ekTXbA==
X-Google-Smtp-Source: ABdhPJyiIj7cagszl43qelX64tnsElhFAX8abGbe0Mht7HnTjVwP0mAeCWVonXD55c+1tfGFhH2Tlw==
X-Received: by 2002:adf:8b98:: with SMTP id o24mr39770186wra.302.1634127507203; 
 Wed, 13 Oct 2021 05:18:27 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:26 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 5/5] iommu/virtio: Support identity-mapped domains
Date: Wed, 13 Oct 2021 13:10:53 +0100
Message-Id: <20211013121052.518113-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, will@kernel.org,
 jasowang@redhat.com
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

Support identity domains for devices that do not offer the
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, by creating 1:1 mappings between
the virtual and physical address space. Identity domains created this
way still perform noticeably better than DMA domains, because they don't
have the overhead of setting up and tearing down mappings at runtime.
The performance difference between this and bypass is minimal in
comparison.

It does not matter that the physical addresses in the identity mappings
do not all correspond to memory. By enabling passthrough we are trusting
the device driver and the device itself to only perform DMA to suitable
locations. In some cases it may even be desirable to perform DMA to MMIO
regions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 61 +++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index eceb9281c8c1..c9e8367d2962 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -375,6 +375,55 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 	return unmapped;
 }
 
+/*
+ * Fill the domain with identity mappings, skipping the device's reserved
+ * regions.
+ */
+static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
+				      struct viommu_domain *vdomain)
+{
+	int ret;
+	struct iommu_resv_region *resv;
+	u64 iova = vdomain->domain.geometry.aperture_start;
+	u64 limit = vdomain->domain.geometry.aperture_end;
+	u32 flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
+	unsigned long granule = 1UL << __ffs(vdomain->domain.pgsize_bitmap);
+
+	iova = ALIGN(iova, granule);
+	limit = ALIGN_DOWN(limit + 1, granule) - 1;
+
+	list_for_each_entry(resv, &vdev->resv_regions, list) {
+		u64 resv_start = ALIGN_DOWN(resv->start, granule);
+		u64 resv_end = ALIGN(resv->start + resv->length, granule) - 1;
+
+		if (resv_end < iova || resv_start > limit)
+			/* No overlap */
+			continue;
+
+		if (resv_start > iova) {
+			ret = viommu_add_mapping(vdomain, iova, resv_start - 1,
+						 (phys_addr_t)iova, flags);
+			if (ret)
+				goto err_unmap;
+		}
+
+		if (resv_end >= limit)
+			return 0;
+
+		iova = resv_end + 1;
+	}
+
+	ret = viommu_add_mapping(vdomain, iova, limit, (phys_addr_t)iova,
+				 flags);
+	if (ret)
+		goto err_unmap;
+	return 0;
+
+err_unmap:
+	viommu_del_mappings(vdomain, 0, iova);
+	return ret;
+}
+
 /*
  * viommu_replay_mappings - re-send MAP requests
  *
@@ -637,14 +686,18 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->viommu		= viommu;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		if (!virtio_has_feature(viommu->vdev,
-					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+		if (virtio_has_feature(viommu->vdev,
+				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			vdomain->bypass = true;
+			return 0;
+		}
+
+		ret = viommu_domain_map_identity(vdev, vdomain);
+		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = 0;
 			return -EOPNOTSUPP;
 		}
-
-		vdomain->bypass = true;
 	}
 
 	return 0;
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
