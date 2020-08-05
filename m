Return-Path: <SRS0=9QAy=BP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B08C433DF
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E627C2065C
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzAZTo55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E627C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCB3A875B4;
	Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFMmpqxqmuqv; Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41BF887836;
	Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F556C088E;
	Wed,  5 Aug 2020 13:45:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E557C004C
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 13:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D1102268C
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 13:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y7Vk91axaZRH for <iommu@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 5A30522091
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
 b=GzAZTo5563V04HdZeYLUVjzEi9aVlzazZ7ISGud9vUTOY68055Bh41p9ohgxuzx7/vqoAY
 IMoXzO1iJCPaSiAlPRQce/mmik/QA9EP8wSxy3vHap3tIPfRXRxdzBP15Y/aWsKd9TSIY9
 6+YVEismahF29MW5MGiDc9k6fQzuhQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-2pqukUl6O6St81ZKXwEYkA-1; Wed, 05 Aug 2020 09:44:58 -0400
X-MC-Unique: 2pqukUl6O6St81ZKXwEYkA-1
Received: by mail-wr1-f69.google.com with SMTP id t12so13690144wrp.0
 for <iommu@lists.linux-foundation.org>; Wed, 05 Aug 2020 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
 b=bw8UOZJFPHlti4VKb2rXwY2MWoqJsuc4qZoLeLalxVGWUTA9I88osYn2kae3NqFl4n
 YmkLmmsQHtg6EjiALSRtpsXByKtEy3HCXU+Qhdb8tZwwZoxUjqcnMtbm8kG6f4g0ThJF
 dzOpe802EfBHHYBytKFA/4IfPpVyFQGCoLaklsh7RY/Rr7pcq3Zt+898b2PlRL4JAt1b
 G9zdlju0IONZa5pf1cKGXiBxwDsboRhb4GHDhN+jepHn1/Z3+vDeYjRX96ZHXCYeATgD
 IK4E29lxMCvIzS+YFJUPJI4dkMrxXk/uwSUu+1EvzabMBoDTaLmRqxiPTIv07VPVvIch
 HSbg==
X-Gm-Message-State: AOAM532thETM1WcNC2hrcrAdB+rwkqieU/S3UZuohCXdVwjCOMs6qR6P
 1gzwEHUFWiLVd80OKYO9QLce0CWWRmAcu0dctCZvvNMcNZNnlEYn0VE/QaFeTl7rs48aZWHPIDP
 URhoIE3TSmhs/yiAYgssSsJ/WQEH/Fg==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753635wrq.85.1596635096342; 
 Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIX/R1ocyCLsQIShtCU4c22XE3xHsPPWnbXDGuQ6U2zNmRfwjcU+K6dqulnNoNKqfVGu6vnw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753620wrq.85.1596635096132; 
 Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b203sm2926580wmc.22.2020.08.05.06.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:55 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/38] virtio-iommu: convert to LE accessors
Message-ID: <20200805134226.1106164-37-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
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

Virtio iommu is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/iommu/virtio-iommu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f6f07489a9aa..b4da396cce60 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1010,8 +1010,8 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
-		     &viommu->pgsize_bitmap);
+	virtio_cread_le(vdev, struct virtio_iommu_config, page_size_mask,
+			&viommu->pgsize_bitmap);
 
 	if (!viommu->pgsize_bitmap) {
 		ret = -EINVAL;
@@ -1022,25 +1022,25 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->last_domain = ~0U;
 
 	/* Optional features */
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.start,
-			     &input_start);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.start,
+				&input_start);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.end,
-			     &input_end);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.end,
+				&input_end);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.start,
-			     &viommu->first_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.start,
+				&viommu->first_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.end,
-			     &viommu->last_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.end,
+				&viommu->last_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
-			     struct virtio_iommu_config, probe_size,
-			     &viommu->probe_size);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_PROBE,
+				struct virtio_iommu_config, probe_size,
+				&viommu->probe_size);
 
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
