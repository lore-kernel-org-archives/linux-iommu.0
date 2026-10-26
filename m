Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995851;
	b=4ckZj5HzMIkG1Il1c+mPgQ2gsxjjNlsMeqvZh32RA5nhSABEn5YmTGSRJP6GJc+8vHKY
	 A/KmgshCkgtgCPOTKX8N03YD/P9mVOjB0Z4yeJ5weiXeAgRMWYqjbgJqZ+LJLMOcGols4
	 ypGwZ4j/5/yBs/NTVdOt7SO/I6jlzNBcG0GUB80+IsE/yKJ3FoP8KiK1DGrudsgYLtJiG
	 IjPG1tP3FjeBaekozI0Ini4fI4CAzLQDO0AvOJZfhFOzE0oy0NZRFSJMFN//MRnm53SnF
	 KIZ92dMdJJF30loaZqeh058VzKShP4jA49JYTgR1y2W32k+EkowmvRrJidd23mgxw9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995851;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=;
	b=5r435ZLTFGldpCMQFELZpq9npdWXRCP2dMbvUpOi2UHmToKGkdNJwoZmMLNZsu3kSquq
	 wQGp0rUagYspotWNZz/ldpIzeGVjXNsO2/15OAlJ9G6IdxRnVpnkWlChw5GP8t2NFqKh6
	 DHsb+gTU0f2GByE7nQRQ7JrMtJHL3ZGf+4LE4C4OnsXwBF4klOCXr8pCeKIzNVChW2oOi
	 k0I0w2N0Yk/Ldjh1k3psfs2iw0B71U4UIFi+5gjpqyWvaafgqkWgkEdL1ScmWL7sIwrkc
	 HPckeabMQJjY9iMOquuynvO/BZDC7NdVzhAemo0XADpjmSu6gQgNi4dVNJzPNK2/IxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A2CpUTms;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JobyHCbI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68738606A31B
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68738606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A2CpUTms;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JobyHCbI
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b17e2806329
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=; b=A2CpUTms71nD3qMT
	L4/4i1Uxo6TbXp+ULA2JOUWJq2RPs5f7/Is5LQtEIqUBqSyJwG5yTytIEXmlYRnO
	LlnaVPZUXEekEjDBabYAdzux3qlYkdyLq0g8l1+AvZZWmFLVO21gMmpWwEoVt1qj
	YsSmT283eahVnjKt0dFeClSdA8tZQU6rF5Gn+syDn5y98A4CjtkOzmeVfWv1onop
	UWGrWmNmrL5TfcN9N6C0sVttd2bdPucg+iCOMhT3yuWDzTo6Zlq0H9peHrL+DlC8
	iPvSEXoDaHTUTjKzgijekV06B18x+lZcNECmkQ5j6TXlKExQXExoHjPWjGHppbzU
	uXYOEg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xn4c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae62796dso12547355ad.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995849; x=1793600649; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=;
        b=JobyHCbIeQTJHs5cd+eBedAPJsacDzPdEnLvt0AL8j+fOMD3qDP8kA2T7HgzlzTBkt
         YM80o3GjdsRo2enxaxc34SuXP3Iv9/lM3xFFyEFG0IZSLDqKHPargTV7XEc9q3G95bMH
         k+pFVxVEcD0iE19+wD8en5qO6CptRxrKCypi4bHT5Lmv0Tl/oqzfPJv6KBkDnFaaPJNB
         0TvcFmAR2i7d6Mp78VdC+MX80ViS1cWgxijmJfyDf8ezT6U3Rv5I3GU6IZdpTp3tkgas
         zWowGhBPyQA0DC4ot3VyZeo2Pr42GLnWXTvBuBZGGOjUhqe1a0bgh8Wab5TLgDx/HO/k
         EtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995849; x=1793600649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=;
        b=L47vEMbi8CofhKNKNfhasi89YYO9mnIGGsneWIngYF773wNqWSymD5HlU7j+SLmcxb
         Wv8MLBZMtjesOl9qW8wh2ot4PsypvZXh6qUSZTarJULZaBdI/VGR2F7O56PDoGSI2QlW
         R2C87U9gGDFvDzE1ccSwaWk4NCsayr/4/rTWIpstzmybyuXeLoW2IMW5uRyM0ZGbNOdG
         rVEhfWVIhk9IGFGtsKpz4Jmrl7f691mb/T/QQwOJwRvHTwR2Yr7MqXJ/SEExnutVnTc/
         4BYiYnBwV5Sf3l1Qvj9XvUGf/V8gAxOV74GAzThNv5wZrrUnG4SaEq1wOl+5kOUEYe61
         Bufw==
X-Forwarded-Encrypted: i=1; AKwUvBwFaZu6EttaHTWhYFkEu9En0PtNYY6/g5dIxUS0wZ5tWi5KDh7724JAj9Qn2toaQygkZW37wg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLMY1xIfJXyAuZmIMtwc2CeCu6GbfU4zVNaMyNd+cPecIkL4Wqz
	7tnRV9AyA4hwZ1JPSmB1X6KUQl4sL73/v6pNI8loldIvBPK7h3+TNDv3lOiZG7Hbj3F0NQvXav1
	zCd7OMAm4BkJ4SuEqiYUWIwSSVpzdSbqNZ5zJp39Ym1dNwogLb+6NDsxbpg==
X-Gm-Gg: AYBFou03sfmr+dccwYjkLNuB7FDM7jQPUm4h8XmRpU6xhqC5LSt2gVXST7wLi6vA4kh
	ynMQOyTb3IsmJmrJctnt1tbIUfBIoAXOTAn5t4cdCIzXmB9k+cXcsLG6SpPcY1DwTjhkOc//ZHQ
	fMfH3Z0scNlYbPx9dUYQ+po7TPvg0t1MidQD7z7esOLxDlIxOz94k9wouwZRTrVZF7dM705xnhJ
	auxptjO8pYb9m0T/z0Uwe9SpfQCLihhkJDAO2CoCNUFkyD8jN8LHrLaL8b+33vrq4jJ36tgs2i2
	V7gAYSdIZKIZzjAGtUJJ62I3rKMQEx2ti8cbJ+KFzwimN6jTCOhlQnYpr4Qxxi6NYkGblrxlvtb
	j++Z7XjDQHXJ8dyCsckolkXnzRZSp7+bi6w==
X-Received: by 2002:a17:902:f60c:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2ea9c63d377mr43098995ad.36.1792995849357;
        Sun, 25 Oct 2026 23:24:09 -0700 (PDT)
X-Received: by 2002:a17:902:f60c:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2ea9c63d377mr43098645ad.36.1792995848887;
        Sun, 25 Oct 2026 23:24:08 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:24:08 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:24 +0530
Subject: [PATCH v2 14/23] drm/msm/dcp: Add DCP encoder
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-14-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=2736;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=13ayK5iaWertmFXymKPgINfX7fwgPHD+tgYvEDAKLs8=;
 b=zmwgbeRZoqTMrzpI8+a/t3MlIu3IDSlRDVgwwS54kYHPLh7/+sgEF+x7gACCHhdFfzZZj8Vly
 V7W/Eljs9FoDWuakAW53sDKzOr21oUkTPeVA72jFeTstFMQfl57YL2J
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: CLLw-oA0_q640cRH_DTkbc74ITmou5V6
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adef20a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qqiwZq75wgHyRPlt0ZYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4b+F8015Jn0U
 BuXj954sxjsey8XaN9vLjkGn5AV8L8LDW8J+ITS2CSjLnS1zHFnlKufNDLwjskLBvJ9wqrkc6i1
 nwtAF7WcB3L+KDuqkJQeqlo5VakP9dM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4UPG6ApbDctZ
 iLevIzYhI+LBjb7rAmrrlONFbl+mFjbW8+XMY6ZdnoG715r1COYELxXtin/b+0Y+g4ONeWl1vw4
 01zs1UOkiRBjKnCStwRmpgVuswMxpXnSKQ8W9r2NbOg2GIBbA6W22LOiOg1P3wgV3Dbzd36ndJD
 VZskByDUe05s5bx8IWXwQi68VGkf5VJ5YExRzhne+56xVmQ5PNFkVG6AGYs49FPgRJ3w77UN7is
 nMNAZuZVK24jBV8dFmTeQHLmrTzrQhL014xTeoR7uYnobgqGPhq6TRjMOdd45yiKdsvCyCQajxn
 Brb4Se1hbgrlijPdJp416VvB7ouCzfKbwMy6wRBf5HzW76SC/9z4Y91O5Gklo/Qsa6cRSTKFgH2
 ng5vqmH+s4PBN+hpkM73QcwHFVmpGIpW70SWSMHNnYTPKsnQPsvjg2kVJlINQq9Vj6+KFEjAFLO
 DHruCzXtG/4nOWPkkNA==
X-Proofpoint-ORIG-GUID: CLLw-oA0_q640cRH_DTkbc74ITmou5V6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Create the DRM encoder required to connect a DCP CRTC to its
firmware-backed output bridge. The encoder must fit the existing MSM
DRM object model while remaining independent of bridge discovery and
KMS registration.

Implement the DCP encoder wrapper, allocation, and DRM object
initialization.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile          |  1 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_encoder.h | 16 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index b425fefda890..4024f6b1e3cf 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -83,6 +83,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
 	dcp/dcp_ipcc.o \
+	dcp/dcp_encoder.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
new file mode 100644
index 000000000000..e7a64c960bdc
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP encoder wrapper for the CRTC-to-bridge connection.
+ * Hardware programming and mode sequencing are handled by the bridge and HFI.
+ */
+
+#include <drm/drm_encoder.h>
+#include <drm/drm_managed.h>
+
+#include "dcp_encoder.h"
+
+struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drmm_encoder_init(dev, encoder, NULL, enc_type, "encoder%d",
+				dev->mode_config.num_encoder);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return encoder;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.h b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
new file mode 100644
index 000000000000..de40c9bca4bb
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP encoder interface between the CRTC and bridge chain.
+ * Hardware programming is delegated to DCP firmware.
+ */
+
+#ifndef __DCP_ENCODER_H__
+#define __DCP_ENCODER_H__
+
+#include <drm/drm_encoder.h>
+
+struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type);
+
+#endif /* __DCP_ENCODER_H__ */

-- 
2.43.0

