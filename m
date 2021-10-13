Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C29C433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2DA60F23
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B2DA60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 670EE404E4;
	Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9UUH_4ibvKa4; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8730404D6;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 543AFC0028;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E1FC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7F50404D1
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPqa7zUIVtMO for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7DEE40151
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:24 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id u18so7745012wrg.5
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZD3Ok2TwliENFGvIwPCFSxS2aqiNfZH/LoIWUGMYMKQ=;
 b=s3z9pDFUlv1MO5CAsaxRRjaPrCwv2eo3vMjWabipdZekLL6rB+krS95l5DI0zMzcxO
 Wc3JfWLRNhVIXpUNQOFqDy4QMeMrWd4POurNIWMaNwl3OMY9ejZYcsqEGgzM6WLlB6cg
 Y5wMe/kXxhUeLeL+3s0F1dada5SbJpUqsAIukQy6rMlcxXmBMvbPDvH2nLNQLvGRa8hP
 cHbO/DGgSeoPyMQRuh7DhQP+MgQ10NTxOwAB5CdN64ZzosqdEpin4ZubaZNuiiyOzZlu
 nZFHZneUcqIAIgvACCcu5p+d1+XbqWnhVSG3UvJWpYCbQpJmxEL8oMP4HO1rkkIqQqsY
 JVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZD3Ok2TwliENFGvIwPCFSxS2aqiNfZH/LoIWUGMYMKQ=;
 b=6x3ICVKsPpFER4HR+F6dLn73Dz63WIZ0BEieupyfq2q0P/Wnu2ukz3Ru/d59bglZW3
 EXmoVXNZRN+XG/qwd0bmXBgjN8E5d9JW1SqeB7zbmHdgVUlOKTlQGd1VwBuHl8a1wIbW
 oomX3iHWlHO4aEAZFDVYE+Ir9FOIuzk6MVvjA/dUCDmWggZfFH5ahMtfdTZVkyYkSVl8
 xoaLt1JvSAF1BlWRcp4+lUG8ku+yQGCt/wHzksMPS2B9OPTtjzr1+ekZ+UkYCAipcb66
 xuA4GNaRDc/PcB0AOGkk/IagF6m5boy2msvMGXRMvmjNAv63SLtic97U6qX/Zij5tFrw
 M6gA==
X-Gm-Message-State: AOAM532Ll7aIwjG+/6YrhcCXbR/Kcf39R+6vjjoyq5r6l9QN/do3nB4E
 YlC1dYz4NMQxFyzQPmxkoj1j5A==
X-Google-Smtp-Source: ABdhPJz8MbguhOLd+szcyryREWwerC5YViQh8/Al2ilQNtNz25jJYyRCE5CNPeIk0mpRCAPzitIwag==
X-Received: by 2002:adf:b355:: with SMTP id k21mr39676160wrd.380.1634127503031; 
 Wed, 13 Oct 2021 05:18:23 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Date: Wed, 13 Oct 2021 13:10:49 +0100
Message-Id: <20211013121052.518113-2-jean-philippe@linaro.org>
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

Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
VIRTIO_IOMMU_F_BYPASS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..cafd8cf7febf 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,8 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	__u8					bypass;
+	__u8					reserved[7];
 };
 
 /* Request types */
@@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
 	__le32					endpoint;
-	__u8					reserved[8];
+	__le32					flags;
+	__u8					reserved[4];
 	struct virtio_iommu_req_tail		tail;
 };
 
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
