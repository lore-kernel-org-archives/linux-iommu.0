Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB223DA
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 15:12:02 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so17910706wmb.3
        for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681485121; x=1684077121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGndh23ci0NG/qxJMvZcia5Fbbz6IQHdr0UISxwOqvc=;
        b=sHOIntrxl6oK5QB4mGnSAK4orpW3A+vpY0JVxMNpcCRPoBMhQkFB2h121qwblj0sK7
         Fqeco22GrFRtTYFiEyT8BopH4T9fy+/nDcMgmBbTk7vSu9J8i44z61te8oUSwRr3bXl3
         D3qElxC5xoSZ6HIPlFgg5RHJdkN9sxqwhnUcqzJKlOo3DwnLK1f0LiSv8CZiJaCCWGw9
         5RgpBqLdCmuqh9O/YnT0k/ZOJGm2kOKFS+hkMs0vavZrjc53ZKPbbtgpAv237MVJ9V4G
         +WSQIwSnhsdRuG8Pee8KGctF8045xwFUL3Z0Qz9fDnA/6Lvhu47jmmE9ozBTTKxC48Kg
         WFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485121; x=1684077121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGndh23ci0NG/qxJMvZcia5Fbbz6IQHdr0UISxwOqvc=;
        b=czGOGpXuFZCPI8zi6b+wQmQticEmBnMig8i2XaNLepZof8qkFxDogixbia3VNMtZI0
         NJ44OdtfQxyoBoVi/O84cBqJ+2COvkqR3jeuk1YSgolz+lbLrqvWqOXL+N2PNfSj64Up
         Clc5vrhc+VwbWABC9zE0HtyE9HWT17B3kzwjWkVBwp4P9It1PNUtbl1t0M5w8M+6FJ5g
         RF63NMh2XEeAnFzldY6AUnDct2YdC51N53USbn8mkgshs6wLe8frwv9H+WUko6U3pELp
         JV8mIg8mgaFDjgJTfJ6wcJCZgN+XqHJWzp+O+DhZuhCMB0LpvaYslkRoDIv3A5Llgcin
         nUNA==
X-Gm-Message-State: AAQBX9cV9nbQb1VRDjHZDHS2HAW3XGL6wjykl0iM0t7IBBJExhjfWItQ
	uDoYtlbGMbT720Hxp0VklGn8GA==
X-Google-Smtp-Source: AKy350bO3qOiPJ+Vk7/7iHsWjVOfKH4KpjFVsU11XW/qvxNENhKYYADSOXszgx5+KvjxYLnNqQHe+Q==
X-Received: by 2002:a1c:6a05:0:b0:3ee:42fd:7768 with SMTP id f5-20020a1c6a05000000b003ee42fd7768mr4573637wmc.1.1681485121054;
        Fri, 14 Apr 2023 08:12:01 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm10217839wmb.1.2023.04.14.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:12:00 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	akihiko.odaki@daynix.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu/virtio: Detach domain on endpoint release
Date: Fri, 14 Apr 2023 16:07:45 +0100
Message-Id: <20230414150744.562456-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an endpoint is released, for example a PCIe VF is disabled or a
function hot-unplugged, it should be detached from its domain. Send a
DETACH request.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5..3d3d4462359e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void viommu_detach_dev(struct viommu_endpoint *vdev)
+{
+	int i;
+	struct virtio_iommu_req_detach req;
+	struct viommu_domain *vdomain = vdev->vdomain;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
+
+	if (!vdomain)
+		return;
+
+	req = (struct virtio_iommu_req_detach) {
+		.head.type	= VIRTIO_IOMMU_T_DETACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
+	}
+	vdev->vdomain = NULL;
+}
+
 static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
-- 
2.40.0

