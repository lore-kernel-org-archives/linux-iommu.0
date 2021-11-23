Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638FEC43219
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B52481011;
	Tue, 23 Nov 2021 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MHXnnLeImg0; Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30BED80DD7;
	Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3C0FC004B;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 175C2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A66A4041C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dX2gGXuoYMIT for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20D1340267
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso2711289wms.3
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
 b=oyFy1LKvGJMU30/ivLT59O6Xv6m8YFTa3CmSp2WeA7ArdHN2pzN+8sYsZh0nJB1rpm
 TF2I8Klekcd8bV9ApA6N1uTUyS+MUUPbynsMx4R5A7Wuyv1B5BKPm2uTRN6YeON/kPub
 yyRWOLDWRI1135M63lVXQy4MGA4jh4oAUFMS7zaipKmEzLy373q6vZwbIlKtl78brDNa
 JAkYtMYeNwzNcnU98E9rav1aRV38fLddadpd7wkFzWzWq1zA+rbE+5ZBuBmu9GPBuQBX
 CIiYeKo+REQAxyrq77xvWAEZhujL1tBYi9MpEFBN3q4lRcvhtD2i9khCA7kRcnUalSyj
 U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
 b=kE53r87+dPFCiAJ/zb8BMV1miiDDNvymXd2ckPBq/ADzzCy+HkzPqZsMb33gM0d3r8
 aZMQ6oyy6KeeO2BB/xSDTHo0QXc2yDIRECDBvpcdUtgBQMvIKtTfYaEZj9bEe9b09uMx
 jQmds25Q6bzAQ8JwSvVECYoK4hMfyNSEH3fsVyYYVnW6JRhj8QGIbUAkkBQNTYV4xqlu
 D91y068uuWdcbeu6NnyF5QOtXxDq5uTXq6Mf3zfoSiRx3xLndvyKcPL1YcaR0nfavxS5
 qiUxX99tbEkHYwQBH0jeorjcmf4a0xTX1Gh7RVo1DkDzzbG6zAoB2NZiRrp2ZDbqhHiI
 ZSmw==
X-Gm-Message-State: AOAM530wwLIUuwYMarq9NnR2iSU2371HON6Up3F5ab2vqchADUrWGXf7
 9xt3/O5SlCxx3MN3Jq0Ix/vTYA==
X-Google-Smtp-Source: ABdhPJyRqECTbpPYHH5uCjl08AXcBFe2Levxz9M2D0pbrVXsv3m/dDvD18pCR8flubLYh4b2z40a9g==
X-Received: by 2002:a05:600c:2292:: with SMTP id
 18mr4489566wmf.6.1637683002293; 
 Tue, 23 Nov 2021 07:56:42 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:41 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
Date: Tue, 23 Nov 2021 15:53:02 +0000
Message-Id: <20211123155301.1047943-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index eceb9281c8c1..6a8a52b4297b 100644
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
-			vdomain->viommu = 0;
+			vdomain->viommu = NULL;
 			return -EOPNOTSUPP;
 		}
-
-		vdomain->bypass = true;
 	}
 
 	return 0;
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
