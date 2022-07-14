Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509262C9D
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 11:14:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id z23-20020a7bc7d7000000b003a2e00222acso3419594wmk.0
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mXResJww73UpBUgXzU26mfeHumFONoVe1fD4+eidgY=;
        b=A0fZCQUjeq/rnKRmKsFqQikxnljB0/oTNVfWBPFQQ840VUkpTS5fWUl/5L+rCXf7Hm
         AikKqmPcSJSZAEwCWh4LQCHP5j6HOzz5AA7t6vJfQ/IAB8Opt5PAzalXMoHTNnxDTh2z
         JU/GlYXx6OCGVBY1F0XpsnrE7PA2IYvudA4RUi4rAz4ecUSN8LwoufL75PXZKnUo+Lcg
         tuOIWx7p4AUWrhIa3o9i+G4PS/JmVsC4qAHnb0qCE8HTuUyBkfdo6UEzOklU4xUwyl8f
         ObGzdQw0PvBpl7WrkTa+ns6aiNp2CR2KK/fSrXdyrV8j5qjvhqoZiUGDVwFa92y9kVDQ
         n8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mXResJww73UpBUgXzU26mfeHumFONoVe1fD4+eidgY=;
        b=vuLBdkp7ztEWS0vtPZkRVpyvmNWGVpSThJyS4hr0o0tu4voPzuz76OVqIyWysv426O
         NGXZ33BnNxzuECn8gZxdaSx1Hf/ptIi7TJLuCZYMzohzhuepknHYqTMhheH45ZFM1UKD
         KuCc7p7r37w8m5tSpMVEtdspzoq649U8aIyv3jRhsDnaLdmEfrCTSaZIJaEZVdkjH7cK
         eCy8BmBubqGHDtJDJ+SfRDQv1DrUstFJxEQTgcp1u2W257yoxuEB1Mwh2XTfJUaum7Iq
         f4PPQP16gd1Bj073clkBhxjz2B+lI1UHfQVxsxYknRVlRJ/kClDn05ZR8twPSis/Ribi
         8L9A==
X-Gm-Message-State: AJIora85PHPYNe8ucXCHAPlIi1tOyiQy3Zli9LouSIen5ITmbw6ySbUw
	zA9R6ipDB2o6WTSMUS/F1fayOjDpQzKVHQ==
X-Google-Smtp-Source: AGRyM1uIAChlItXoVW28WYAYQc/hahdPbVdJHphRVg5mE36QmQZpgZSceexJEoWn6QBcqzQFpoiNvg==
X-Received: by 2002:a05:600c:41c2:b0:3a2:dc9f:959e with SMTP id t2-20020a05600c41c200b003a2dc9f959emr8797324wmh.166.1657797251503;
        Thu, 14 Jul 2022 04:14:11 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b0021db2dcd0aasm1357609wrx.108.2022.07.14.04.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:14:11 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Cc: will@kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	eric.auger@redhat.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Date: Thu, 14 Jul 2022 12:11:01 +0100
Message-Id: <20220714111059.708735-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix virtio-iommu interaction with VFIO, as VFIO now requires
IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
mappings, and always expects to be called with IOMMU_CACHE.

Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..bf340d779c10 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool viommu_capable(enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct iommu_ops viommu_ops = {
+	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
 	.probe_device		= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
-- 
2.36.1

