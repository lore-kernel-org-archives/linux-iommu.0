Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D7C43217
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0438760F23
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0438760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A3F3407A6;
	Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snZQ3Yd1gzPP; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45148407B3;
	Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90CBEC002C;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C875DC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A89A8404D1
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AiewzYJYMC5q for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A59F040247
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id e3so7570405wrc.11
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CESbIfHjkcp8AHxtpyq2wv8/zdsEnlsxsFJih/d16kc=;
 b=CY4+6+76W9v/nsW7+ysWaUlj0z1TyOghyvSoSLAPF4u0ynIt1O5Zc67BS5qNKrkUma
 z/RAUrWpCNWXKvNvDGfAKIakLoRYL1LCxm9laDM+IJY7d18WvafyTJOzoBwiQJNTx5Oj
 Gr5xdcklRktypspgaZX5oGeMi9A2yIaoLICpD05nJZBRW41Of5t7GnmgaQYoMfBiSL7/
 Ay8MprMGVjctkvnkZLTP6cM0LpyqwKlujR2LEyzOnWs2Uc2xlwP2OydymGrj3S4SMV43
 rYgN5lmIp0xWBokaxSDsCkfQmu3VO6MTwVoSBP1UMXd6B7X1PDgrR9CJoOhFcOc+v3q1
 k/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CESbIfHjkcp8AHxtpyq2wv8/zdsEnlsxsFJih/d16kc=;
 b=gHgJsnbxQYoacg3FCRYvLee9b9xGTYZWAotWDEvFC2Hp27skMxTxVPRixcbbbj/8UZ
 xXKyeKM5pcLzUDD+46MWgctxToUuuh2ZCsS4BWA3mZg3cdjZcq7AKDxVMUR27GA6yY1c
 IuqmKynK9ztAtkpJazUg36RzRiwBeQx0kkfOGX3HkJVZ3/P0YnpD2JDxROUhc4CtcciP
 XvHyDZn/hRUQbHbAv/EkqNrWTzbYSd0t9rYt8s4UdjxDisE+gm9C9zCKlypp9EFYeUCu
 WqkpdNHBUYmQwObBK7hri0Paocfcj4WUqxoBes5b3/j7WymOt0CbmmIUSflf4YWjl0Kq
 MiQg==
X-Gm-Message-State: AOAM531HrRqTKSoknwQsDuY61CqK5scJ/p2S92EBFq4vQiDIV6hefSeI
 DMCnF9vVQ1j2tNl3kUxPJbyxFHhS19hPOg==
X-Google-Smtp-Source: ABdhPJzxNJodZ4KFQIrVUBn4bcXA/19FUDclzR5xzaSwZSzDAyP4vVYiMUl5q7a/jlWrluWca1DLGw==
X-Received: by 2002:a5d:410d:: with SMTP id l13mr39973957wrp.301.1634127503942; 
 Wed, 13 Oct 2021 05:18:23 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:23 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 2/5] iommu/virtio: Support bypass domains
Date: Wed, 13 Oct 2021 13:10:50 +0100
Message-Id: <20211013121052.518113-3-jean-philippe@linaro.org>
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

The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
request, that creates a bypass domain. Use it to enable identity
domains.

When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
currently fail attaching to an identity domain. Future patches will
instead create identity mappings in this case.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80930ce04a16..ee8a7afd667b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -71,6 +71,7 @@ struct viommu_domain {
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
+	bool				bypass;
 };
 
 struct viommu_endpoint {
@@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 {
 	struct viommu_domain *vdomain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
@@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->map_flags	= viommu->map_flags;
 	vdomain->viommu		= viommu;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		if (!virtio_has_feature(viommu->vdev,
+					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			ida_free(&viommu->domain_ids, vdomain->id);
+			vdomain->viommu = 0;
+			return -EOPNOTSUPP;
+		}
+
+		vdomain->bypass = true;
+	}
+
 	return 0;
 }
 
@@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		.domain		= cpu_to_le32(vdomain->id),
 	};
 
+	if (vdomain->bypass)
+		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		req.endpoint = cpu_to_le32(fwspec->ids[i]);
 
@@ -1132,6 +1149,7 @@ static unsigned int features[] = {
 	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
 	VIRTIO_IOMMU_F_MMIO,
+	VIRTIO_IOMMU_F_BYPASS_CONFIG,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
