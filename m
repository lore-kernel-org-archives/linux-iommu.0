Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF6337117
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430422; cv=none; b=eHB1kClhktq8f5jOsd2E76rznWURE5/yIEQPndtDppQ/OwJFzJzhwpAKqKntOgdvruWG8STpH0EOLo4/NxqMRvCPyArO4WEmOH7FIuOaCk1Q+VzR3yQBKxRLYASB3Erbwooh90pA052+GFbUnZvVy5ATEtetRTzVTxAAs/1kvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430422; c=relaxed/simple;
	bh=vtFI6mihbvZCNBhpCUC4IoqyoPFGBZHbA1j3YMa1ttA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U88ZR3P4zVhrqBv6QPIPaKvshk2lsQ3J0p49DWwOIXW5OQ/JdL4ZiNKoAgmaHBMP9jWYp43BraKgFZ3rfqZ3nfV0HDRT7xaX9mPnV4/nEgMAK/cdlv+hLmm7m1XfERqaNkRB2kpV8c3bR/+98AXpgCs4G8hcPIueWTNOPg+eL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQnQxhTX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IayH1j0C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQnQxhTX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IayH1j0C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q5UN2J1019267
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hdWpNZWn4nQsY52qlMev2apCckLHnrTywvI+NelvIQ=; b=TQnQxhTXNH+sN09R
	13TH5S9m0X3HT3wDKKbS3F+rWe5TiDQsfu2oijSBruWANjWUF664zhFrmSyTUEb6
	jj6+aUU9pM/Keequsue4sU9jcYNHhTjWi34rNmpHGjC+g53t9H2x54yKaSilcNe4
	5cwAfYHwf8QtgNDl+NPQcfFoJgLkjZ8P74k8VbMLOkWHxqpXEfbA32/2nzy+E5m5
	ToGuowWCb+2UH+ZQ0yXN4MRpr1NwoLx41k31zZciCUfZWL4Ge5+WU0OpGTZWwCdF
	aC7tUi2GhMZ0xIeKk99s5DkwgMTyou1XPvti7T2bSZWf3ygPqeWrL1rMHIdKELzN
	5JIiUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx2680yjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2841257a12.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430419; x=1770035219; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hdWpNZWn4nQsY52qlMev2apCckLHnrTywvI+NelvIQ=;
        b=IayH1j0Cjz57nMXPoTkoMTw8fNAQ399uDlM9ynKCNQLOpLs2+8zVmM5SqDDZCRtGYn
         LT4buqAQOXUDDGyinnXP1L0kSNymNhL1qdhFd8jtt6pyp14dfQm43p+Z+xSqJ5NDmPAu
         o71GFc3Sx9kIKVWKuV6PPc2jHRm8Bpw+kukcC7+7KDx3+7cKj4FLlYQSu2fVE83/QzB0
         1fdegOQm/wi4DYQTuZq/S5bldTcwxSbNWLC8jwOpKFTU6S/oSo5f7KME/VU4Zrnl9qpz
         qfE1XnizshbZBnlumqROM2e6g+WwgVcypHikzjoJljPEoq9tuPL+VFdhtxFkxwSKSOMP
         vRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430419; x=1770035219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4hdWpNZWn4nQsY52qlMev2apCckLHnrTywvI+NelvIQ=;
        b=tqXXsi/HS2srfq+lgG0oZR48cRvBqrtU1izP+PA1awwZ8tKqEaCt4/BhEo9NkukzOm
         0S7Cl9Q5+5rGHNXxJx/zQBFeJZzp8BX4QRh/qj7zHkPbOQc876lKjHT9J1p/5C/R1psi
         g7JMv2G+1rhczk21NHMYhwFfFgwWzlq6ijoJbFrWhIZCY6Wi0sz6q82RxJ9zEsINbMJB
         zfmq7e1dHB8JO7zUrYs7ihzP+ViKf7zCMsbBVSWO8XVDYvKz7ElcGlYjWd1dBF08OSX/
         /7gjB3u956WsAc5BOpiD24+UT9aSjM113k/IGB0cf3kPGzg1Xw6OdBmSKr1NTXp0zybq
         hUlw==
X-Forwarded-Encrypted: i=1; AJvYcCWzA+xlzl3aSKUw5pMbR0kDj7geQ2GIPdRTVVxb+2NRUtmOr2lVEmD/Lip7nORdHUua/jYvJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTmV8WGfxKZ5bvYF5GJEZwne80PqXL+2ts2Hy+RUvqd6zmVM/A
	/7jQVNHbjpuk2R9Gh3QarxB7UOjg+WIgcE1tUux/i2cI6/iHIpIqm39D3aEqellXWZRfZjTwjrE
	iRqSmkM/f+uSAmABgFkZcw6vIcXA9P5J0mD6YC+fDn34a/2CSYfmrFHTIIg==
X-Gm-Gg: AZuq6aIotaVxzK4FGsbr1TuWUZkTQWOmKzjEbpdKRbk9r/v3VBgri3CcuH+pUBPhGa0
	rR95EH5U0vH+XWr70/xKgG/eMZ2K9oYGiUodk5hPktvYXfbmH30XhorkF37jG6bAz3zX1ZK+RJW
	6pLaSJ4JE4fnWHPuQDlYDzueYq/nIFFuAjDlMsDM8wOOHp/36qGdtcDPz0kFXfS7n7K6Ci4GMWk
	6/h8cdfNmg2FVUkt4qm+qDGhabe2yAUwrFCscsogmXorjBAYoNb2ZRJnm0rqxFW7l7+jEUf6kf3
	IHKAmLAZbX6bl0tEtKgEmMXOB/MqM/Nroedr2tnNmeXD8u62sbryOTsZQmL6gApNF6hoW3mzB9f
	bgSb+pCENEHSZgfKd5gId/fM4sr5KC2AELLSc12dhOs1+
X-Received: by 2002:a05:6a21:6009:b0:366:14b0:4b0b with SMTP id adf61e73a8af0-38e9f22b832mr3912154637.71.1769430418641;
        Mon, 26 Jan 2026 04:26:58 -0800 (PST)
X-Received: by 2002:a05:6a21:6009:b0:366:14b0:4b0b with SMTP id adf61e73a8af0-38e9f22b832mr3912121637.71.1769430418165;
        Mon, 26 Jan 2026 04:26:58 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:26:57 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:48 +0530
Subject: [PATCH 5/7] media: iris: add context bank devices using iommu-map
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-5-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=7379;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=vtFI6mihbvZCNBhpCUC4IoqyoPFGBZHbA1j3YMa1ttA=;
 b=3x2QxH2A5ItlGt1C/LKX5pg5hXXM617Hf4dTm2ITEHRf1AOwR/t0blMoLsCOT+TF3yLA0F1kY
 knM0InaGYGlAk97PqVgBsi0KbIStbOx0kDuiVyZnES783trGHhCSPWF
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69775d93 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vM_uiRQ4VLTwqj5zvH8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfX9lIHMNv62FyP
 XidqAk1g/TtJrlLcjfdB1sbmKkkWjThjWWIELPq+8fBLIwXW2A9pXxXLEy3l65Czi25lmhRu+xO
 eNP75SOFbJFOJ73o+qn8kmDH9dQX1YOm1OMX8SVWyT6SC/+6hxocfFI8ceDhs5rAYYVMKZ22j12
 pzVuWVxqX2B7mXOJPDZReAXjrMNa9XYvL9LsCzULkocPZ52cGikXgR5vWeVqvtiqELLCPriNLXH
 scoOvdMXPWxCNFrGPb8rHn5HD7YOnP1yuLoJaJhmfm7HC4HsqTA81kQSol1D55vVu37hgF5b5MY
 6pO0UuoFm0QpekvYyjtB3KOKI/9Slr3eNcfqNkqIbOjj2iZnuffvVs4QDLv50Mn4cNB1Wgkzkio
 pCti/WVpfbRHyA8+d6ElcAqnQkt9lpT/7i6RvGkfiunuXwE7sUhAGSpUwRTQOsHHPMgxsh1s2iJ
 xp3WYhd/VRjX3GdISWA==
X-Proofpoint-ORIG-GUID: 9L0ht1KgKczfdEeDLnZlJSScsbA6yhgm
X-Proofpoint-GUID: 9L0ht1KgKczfdEeDLnZlJSScsbA6yhgm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260105

Introduce different context banks(CB) and the associated buffer region.
Different stream IDs from VPU would be associated to one of these CB.
The patch ensures to handle CBs which are described as iommu-map in DT.
Multiple CBs are needed to increase the IOVA for the video usecases like
higher concurrent sessions.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      | 29 ++++++++++++
 drivers/media/platform/qcom/iris/iris_probe.c      | 55 ++++++++++++++++++++--
 drivers/media/platform/qcom/iris/iris_resources.c  | 35 ++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580eb10022fdcb52f7321a915e8b239d..d2d7c898fc8ef0de1b16aebd72681ea3c5b736ae 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -204,6 +204,33 @@ struct icc_vote_data {
 	u32 fps;
 };
 
+enum iris_iommu_map_function_id {
+	IRIS_CB_NON_SECURE_NON_PIXEL	= 0x100,
+	IRIS_CB_NON_SECURE_PIXEL	= 0x101,
+	IRIS_CB_NON_SECURE_BITSTREAM	= 0x102,
+	IRIS_CB_SECURE_NON_PIXEL	= 0x200,
+	IRIS_CB_SECURE_PIXEL		= 0x201,
+	IRIS_CB_SECURE_BITSTREAM	= 0x202,
+	IRIS_CB_FIRMWARE		= 0x300,
+};
+
+enum iris_buffer_region {
+	IRIS_NON_SECURE_NON_PIXEL	= BIT(0),
+	IRIS_NON_SECURE_PIXEL		= BIT(1),
+	IRIS_NON_SECURE_BITSTREAM	= BIT(2),
+	IRIS_SECURE_NON_PIXEL		= BIT(3),
+	IRIS_SECURE_PIXEL		= BIT(4),
+	IRIS_SECURE_BITSTREAM		= BIT(5),
+};
+
+struct iris_context_bank {
+	struct device *dev;
+	const char *name;
+	const enum iris_iommu_map_function_id f_id;
+	const enum iris_buffer_region region;
+	const u64 dma_mask;
+};
+
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_HW_POWER_DOMAIN,
@@ -246,6 +273,8 @@ struct iris_platform_data {
 	u32 inst_fw_caps_enc_size;
 	const struct tz_cp_config *tz_cp_config_data;
 	u32 tz_cp_config_data_size;
+	struct iris_context_bank *cb_data;
+	u32 cb_data_size;
 	u32 core_arch;
 	u32 hw_response_timeout;
 	struct ubwc_config_data *ubwc_config;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ecb9990af0dd0640196223fbcc2cab..c1a6aac5a3d65d980c5a34ba5fa1c1dbcf790ec5 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -123,6 +123,37 @@ static int iris_init_resets(struct iris_core *core)
 				     core->iris_platform_data->controller_rst_tbl_size);
 }
 
+static int iris_init_context_bank_devices(struct iris_core *core)
+{
+	struct iris_context_bank *cb;
+	const __be32 *map_data;
+	int tupple_size = 5;
+	int i, j, ret, len;
+	u32 fid;
+
+	map_data = of_get_property(core->dev->of_node, "iommu-map", &len);
+	if (!map_data)
+		return 0;
+
+	len /= sizeof(__be32);
+
+	for (i = 0; i < len; i += tupple_size) {
+		fid = be32_to_cpu(map_data[i]);
+
+		for (j = 0; j < core->iris_platform_data->cb_data_size; j++) {
+			cb = &core->iris_platform_data->cb_data[j];
+
+			if (fid == cb->f_id && !cb->dev) {
+				ret = iris_create_child_device_and_map(core, cb);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int iris_init_resources(struct iris_core *core)
 {
 	int ret;
@@ -139,7 +170,11 @@ static int iris_init_resources(struct iris_core *core)
 	if (ret)
 		return ret;
 
-	return iris_init_resets(core);
+	ret = iris_init_resets(core);
+	if (ret)
+		return ret;
+
+	return iris_init_context_bank_devices(core);
 }
 
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
@@ -187,6 +222,8 @@ static int iris_register_video_device(struct iris_core *core, enum domain_type t
 static void iris_remove(struct platform_device *pdev)
 {
 	struct iris_core *core;
+	struct device *dev;
+	int i;
 
 	core = platform_get_drvdata(pdev);
 	if (!core)
@@ -194,6 +231,14 @@ static void iris_remove(struct platform_device *pdev)
 
 	iris_core_deinit(core);
 
+	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
+		dev = core->iris_platform_data->cb_data[i].dev;
+		if (dev) {
+			platform_device_unregister(to_platform_device(dev));
+			core->iris_platform_data->cb_data[i].dev = NULL;
+		}
+	}
+
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
 
@@ -277,9 +322,11 @@ static int iris_probe(struct platform_device *pdev)
 
 	dma_mask = core->iris_platform_data->dma_mask;
 
-	ret = dma_set_mask_and_coherent(dev, dma_mask);
-	if (ret)
-		goto err_vdev_unreg_enc;
+	if (device_iommu_mapped(core->dev)) {
+		ret = dma_set_mask_and_coherent(core->dev, dma_mask);
+		if (ret)
+			goto err_vdev_unreg_enc;
+	}
 
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a257b8ae7332242544266cbbd61a9..647f6760f2b7a6bab8a585a13eb03cf60a9c047e 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/interconnect.h>
+#include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -141,3 +142,37 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc(cb->name, 0);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	ret = of_dma_configure_id(&pdev->dev, core->dev->of_node, true,
+				  (const u32 *)&cb->f_id);
+	if (ret)
+		goto error_unregister;
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, cb->dma_mask);
+	if (ret)
+		goto error_unregister;
+
+	cb->dev = &pdev->dev;
+
+	return 0;
+
+error_unregister:
+	platform_device_unregister(to_platform_device(&pdev->dev));
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db095ec05e53c894e048285f82446c6..b7efe15facb203eea9ae13d5f0abdcc2ea718b4d 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb);
 
 #endif

-- 
2.34.1

