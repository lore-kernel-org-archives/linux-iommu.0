Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53473C139
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 11:51:07 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3063433fa66so8159521f8f.3
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684151465; x=1686743465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMyHC9pQClYTJqDoQAfkFzjBLC/t080M5U1EcEdPfZY=;
        b=igkrhFkh08x2YsMCeAvMMAe0SFfzztydrm3ZJjc2Mir8dj7yMFyFTFg3oGbORQH+Qs
         JUKLv3zrjMCxwbDxx+NDJPNTBzwiu+z890zD/yMw6MQzXOGLkwHSYKs+41zjQof3YiNn
         QueCkn46tIwyGN2YGjwmu7M5/MRFntdka8h0+bXa07wqnuDRadWjhKK7ZtVDBz33SRvK
         KK4/WYRVH6gHqvTf05MB+ikI7G8G7sS87fvyGCDNykmZxWauJTYeXA5suig9NrtAkV+9
         C1IrScTCKRZDuJqja2J8wsjPRVLPslxB5vhJIpBrIQ0p+c18sgoLkJGud7iX++L5kRME
         cAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684151465; x=1686743465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMyHC9pQClYTJqDoQAfkFzjBLC/t080M5U1EcEdPfZY=;
        b=Vf5xmfHOwGRKHWT8fKNFANieMtyVLjQLJkS944YE37L/yjPs3YQ7zgp1sbqCR54KtF
         pcak2Rn3E66POIkDGSW30WxJirH4cA46mTANawvcpk9OeKnxU9Vv2EZwOEnkhlLBhsF3
         hpZUAOX0H/PqMXKto46eUOVUOBQ1GJ8XiyKAWxRHlzOrnuc8VAiXH5ATLI3bPbOeJhMv
         yQ2yuTv/ItEbE8GdF1dJDCiiHgtzIs7ETnH7j08Mrnz4CxazSmY37ruZ1Q/9H00D0TTI
         i/ie3PJ/Uh7susjsuRny+cxLAMpnZhWfjuITqwKsSbDF2PEqs+iUPDHG1Z6cQNIa6xeq
         gV2w==
X-Gm-Message-State: AC+VfDy3f0nIGGYsj2T/tKVfIfsIR2HQs5QmrQsvQygloZ3LeX8ncmHb
	XoF/GH4Mq//uKtoPwauZaXgVfhsqtMmE08gYjAo=
X-Google-Smtp-Source: ACHHUZ5SZl/PE5+AtEId5xzehL1k3Eb4OG0FMa0JvJvuJtb/eeHROEXuFz/QNLebunUadXO3qsHKlQ==
X-Received: by 2002:adf:fc46:0:b0:2f4:9f46:6865 with SMTP id e6-20020adffc46000000b002f49f466865mr24451854wrs.30.1684151465528;
        Mon, 15 May 2023 04:51:05 -0700 (PDT)
Received: from localhost.localdomain (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b003090cb7a9e6sm7555395wru.31.2023.05.15.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:51:05 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	akihiko.odaki@daynix.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 1/2] iommu/virtio: Detach domain on endpoint release
Date: Mon, 15 May 2023 12:39:48 +0100
Message-Id: <20230515113946.1017624-2-jean-philippe@linaro.org>
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

When an endpoint is released, for example a PCIe VF being destroyed or a
function hot-unplugged, it should be detached from its domain. Send a
DETACH request.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
v1: https://lore.kernel.org/linux-iommu/20230414150744.562456-1-jean-philippe@linaro.org/
v2: fixed nr_endpoints count reported by Eric
---
 drivers/iommu/virtio-iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5b..fd316a37d7562 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,6 +788,29 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
+	vdomain->nr_endpoints--;
+	vdev->vdomain = NULL;
+}
+
 static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -990,6 +1013,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
-- 
2.40.0

