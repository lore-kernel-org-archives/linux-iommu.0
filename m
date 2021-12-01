Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD11C43219
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DEF5B40549;
	Wed,  1 Dec 2021 17:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWCXmZwhXvEP; Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64E1740189;
	Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 335B3C0046;
	Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB84FC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC22B40343
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8RcDZyGxLaRg for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6F7540168
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:37 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id s13so54049138wrb.3
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gI8jmGzKKnCmYH34en61qDCkKeNA1WwA+hI1C6dVb8=;
 b=T1oIcl98gNRGch1gVVBd1tDJ3Fjo5D34DPkcAul4gwKPCmkQ5XmpiqoUOS2pCQbWnp
 nMk41+FQpGRbZyvSvgBRVyNpVocwgS9xilq6ad6SlmDvlXd2mpvPxJzVNIezRzcTNiQA
 xNX/ZEMru35fApHUlER+DuWlNU1vH9r67TAeARUFdPHYfievdEbWLO+YZeY8rpSwEwvQ
 gZmGcz2btJHB2sAV/5f7uVOntw5owlOYKrV8F7nTEOc1ZaL4ZUl0g5c3jmJyEKZ1YRVf
 Jc9CLgjqh4VX5rYzpc/jPRHAhm/VNP2Hz7Erx3fF3albkbxhiHR6rzutUPy8/xv1pUQe
 hC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gI8jmGzKKnCmYH34en61qDCkKeNA1WwA+hI1C6dVb8=;
 b=d0X6yHrLcEmKXqjsKtBLmqBR3tBB1W9rg9Nys+As0AqHL+ZiViwJmoDcBVqLHEJCEy
 R6CDxE0WnngvPYbFSgYcgXWVBysaTWQdCrhVYJ7mQzwX6hMPMiCO7Zfkh9vXsehiVHmI
 PNvs1Ziiu9ncfLjRu2B09wzjkiEIa61rvGZGlf3BbpSzkMt5UiX+DcM0/3lFMNM4TnA7
 BK6zAYsZfu3xT8YBrzlx6gad+jQpRs11pw4D+ptrtwJXtjyQgx1JPS43FrDhc8BDjj5U
 GFbPy6bmLxrbC8cfRrMLpqwF1fNTsxIHRLbSuceOHaaXmL6cJh0+WSXe4qOnbDNDq9TK
 Le9w==
X-Gm-Message-State: AOAM532ftjBVtetlUFlI90zb5N4GX4DPBwTqmyq4nvsp2dH5SHjgfai/
 KgUOuof4hBywYpKokbvdCGl0tQ==
X-Google-Smtp-Source: ABdhPJy7WiC3xFOOZU9G6+kHZ1yJe5pHZv1rykBfjssEI3H50l3btNc0PctcpiJxRVe5uKYd2csYNw==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr7977155wrv.427.1638380075955; 
 Wed, 01 Dec 2021 09:34:35 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:35 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Date: Wed,  1 Dec 2021 17:33:21 +0000
Message-Id: <20211201173323.1045819-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201173323.1045819-1-jean-philippe@linaro.org>
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..1ff357f0d72e 100644
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
+	__u8					reserved[3];
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
2.34.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
