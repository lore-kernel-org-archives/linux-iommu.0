Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C8C139
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 11:51:29 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-307d84f5ce4so3558289f8f.2
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684151487; x=1686743487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZxrLhbMqm9tPsig+ULpfo3eVRUq7zl+eSt53OmHcko=;
        b=bOD9yY7he8bOP4vGifYwZxj73H9sGfaKjhUIG2mfk5hvv6Dg2FxfWMFXFzKxD7Hzkg
         xBd4q4/49Z8k2Q4CToovriHAYv4xjWmJQnzbCCGhQ4EnBflG6bgPOgEinwiK6RB7kCB1
         OSaxmBw5z9g1pHsl1nvaLCHFaUsSzxcJRDdChZuXmMo4E0rFhxEez6GDaAHRmkNfSYPb
         gi/8lXkjAa3szTdovcnRiqKonQbDnpYCviHRnLJatCwKR7fB7tp30wojLIjn70Eld4nl
         CL+SbfDH29owrcs/gyvTK/ELZU8WBYlc71oFKANzghmZED7BoRDCi0ai4glk2WAoFqPU
         0SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684151487; x=1686743487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZxrLhbMqm9tPsig+ULpfo3eVRUq7zl+eSt53OmHcko=;
        b=B9gj0hdHq4SttapupyJcb9RtRB/RRpm4HuONjBupyv6XD+qhENEuopYgbkDUcwbyMz
         N/qiquVNeoGBATU6TC5nDPqAy2ouraGFLFaQNuJ4V27j86y5TYS+35AT6ndnnwGDpwTu
         YNoVGm1fZn9mqrSuJib32ZjWpZwLj53xy/cgwu7E/CTsljFJlDB7qSDk/a2TPBOrdAcT
         /PeSucBxdItFGd8WyX0x3uuPcPEd/Ot+Yn23E5h7BK90EhmsNjkAMbu/EZGWK8ssli9W
         fW8TD/J2UPbprIi0XmSdU/QGMC37t7FqwebKfRuzvrOFR0MGzCTPTjFO1FA951K1Ndxd
         GWCw==
X-Gm-Message-State: AC+VfDwYWdbiXY5ji3t7en7vzngBqTh6HGVCCFwc1UWFD0lHY+za0ToY
	w/eS5M6cMQ52fuwAmoDvfLG1Hw==
X-Google-Smtp-Source: ACHHUZ4V3Qog11yuZXD7nJ2Hy/NH2/YCvWaYTADQRCZiytBjuiZAVb4Ic6lBz+Kvcci1bbuTc4Oq3Q==
X-Received: by 2002:adf:e552:0:b0:307:7be5:90da with SMTP id z18-20020adfe552000000b003077be590damr21729916wrm.68.1684151487437;
        Mon, 15 May 2023 04:51:27 -0700 (PDT)
Received: from localhost.localdomain (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b003090cb7a9e6sm7555395wru.31.2023.05.15.04.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:51:27 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	akihiko.odaki@daynix.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 2/2] iommu/virtio: Return size mapped for a detached domain
Date: Mon, 15 May 2023 12:39:50 +0100
Message-Id: <20230515113946.1017624-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230515113946.1017624-1-jean-philippe@linaro.org>
References: <20230515113946.1017624-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When map() is called on a detached domain, the domain does not exist in
the device so we do not send a MAP request, but we do update the
internal mapping tree, to be replayed on the next attach. Since this
constitutes a successful iommu_map() call, return *mapped in this case
too.

Fixes: 7e62edd7a33a ("iommu/virtio: Add map/unmap_pages() callbacks implementation")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index fd316a37d7562..3551ed057774e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -833,25 +833,26 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	if (ret)
 		return ret;
 
-	map = (struct virtio_iommu_req_map) {
-		.head.type	= VIRTIO_IOMMU_T_MAP,
-		.domain		= cpu_to_le32(vdomain->id),
-		.virt_start	= cpu_to_le64(iova),
-		.phys_start	= cpu_to_le64(paddr),
-		.virt_end	= cpu_to_le64(end),
-		.flags		= cpu_to_le32(flags),
-	};
+	if (vdomain->nr_endpoints) {
+		map = (struct virtio_iommu_req_map) {
+			.head.type	= VIRTIO_IOMMU_T_MAP,
+			.domain		= cpu_to_le32(vdomain->id),
+			.virt_start	= cpu_to_le64(iova),
+			.phys_start	= cpu_to_le64(paddr),
+			.virt_end	= cpu_to_le64(end),
+			.flags		= cpu_to_le32(flags),
+		};
 
-	if (!vdomain->nr_endpoints)
-		return 0;
-
-	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
-	if (ret)
-		viommu_del_mappings(vdomain, iova, end);
-	else if (mapped)
+		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		if (ret) {
+			viommu_del_mappings(vdomain, iova, end);
+			return ret;
+		}
+	}
+	if (mapped)
 		*mapped = size;
 
-	return ret;
+	return 0;
 }
 
 static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
-- 
2.40.0

