Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8B33554F
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348595; cv=none; b=L1jw/kgvPvhesjrO2HHPF8U5ZR2GAMBJNj/WH0OCoOtgazuuV80+AWLDaGgCZUavoC0EkFMnOUL0BCfVbfpnkGMbjfO8vfVSgCbhjmfm/CAL9mI53Kzf/tXybW7MC232oKLchuOxOKe+Vii576HwsUEThO0PQsi1RYi5KJ/D7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348595; c=relaxed/simple;
	bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lK+eCybeJBx5mboeLy5zf+aq5jfh7/uOGu9BLDRaAKpEh068k+Y0R6OCcbH1imo06US/b6i0AX3wMJ7P1bmOD+K0Db7jAS0+rNpoPTQceW37lQSstGu4uWYyeJ0IqNmCeaMxLP4QonUwj9ezZ+CVkLUWIJmYKufWxpwd6b5LonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iz1in51z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJy0DhMn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iz1in51z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJy0DhMn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S0eQQq3760741
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=; b=Iz1in51zLm2pEO7J
	F3GoHTsi05CRzvHuzP7z1vlvbcyEav7K5qoMLAfZ2vcxiqq8kj5LDBkOt6lmoyIT
	y/pMCC+PoinA/UGZizCrVQLTGJ0a4zt+gaLU7smvukYPCBN4+lDTQ5FkRP4sFXZQ
	C/nnAwl56yw1u9H1ZhlGCQPBC8DTu4+gpNAJGeJcPhSjMCGTS2ncpb3El9wK8deZ
	4eG3DmIBtq3RY49RndFd21xQA7cc901yu+a//+9h1V4Bw/M30htf5WQ8Qfu9Y+Bq
	fDNcOc2U7vrRrkB/5lpY1PzGoC7RdoiiJjoM1OUbrhSyca/Ky47GmrF5STk4GNaQ
	16dOcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtacdtgf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c44bf176so12846561a91.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348592; x=1777953392; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=aJy0DhMniL7Tjoy3D8g7pGecTpZ1oiYHYKlXZLzUisGDXQtce1WtjtIlmDXqJk/SES
         IUb4NpVh0aYCDZGFE4ANtkJxgwzUi0OZ8KjuRromEHW5PxY59CDvG0tkh9dAQZi27BMT
         zu62sWEA7bwYKjFCfkElF7nDrtW51SE5vbEsb6fXelZn3cSropIh5Ut6LPRAIPYXS94/
         rZQvAdsh33vkTkC7WdQ0EihzFV4PDsTd+6WcLQeK1p1BF88XTFw0swHw3XCMUM58LuUM
         TxdtU+I6Yyb4hIHW78JN3TfQov8iZPtboO0GhU/2JuAkAF/BSnxzHpddJfX+Yg7BxKL6
         DBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348592; x=1777953392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=DpviRWsVSzYmIlGir7BKvPK9wpz2yZNu0qhDwsPYecN2mwNqXcv1tup78j4fx2wat/
         DWWAaa3h9FeOqOPnHubRrJYR+oR9UU395l/jgGhu+BOcbTFP3kBmdZgehLB4EiwBaZ7R
         Q3K5RMTpagnTY3AKFw8DH/8rpXuVHXfklJ3WCeV6uDpg02dpgYo9dsqWU+J0ezmyiEZw
         aNOJIs6xNLYCarAo388lRhbcBeZZDcAnVUWK/qzmL+QyBoowAyXExVlpL4j7ZJ9OmPqZ
         NVw3eIlyd4A4CCqjXaP9K4ecRs3Z+afvp05FJo5EzsBga8FqbFYSz0bm8PbTGHqDOhXo
         A0LA==
X-Forwarded-Encrypted: i=1; AFNElJ960V8hsb38HmSwYyMW6vGveDS9bcXPEusf0yP/ZBZDT20YhMbcHl9i07+OXthnbMB/dwoYlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR9jawg7M+uCQHQ8fVTbgNdhtaWucZnAhTttqTEPzQSFWXNFb5
	LgD48ULUaO6M2BjtM2kdn+rW7A2Y7Iuzx0N2fx3VRzEuK7/78/wRyM3O02gxR40IeV8HCIOsRmL
	GSRgVpojwe+DV2s2QTzhSaI50PTULhhxJPJ23ygB+QG+IP1VBkN6wlvou7Q==
X-Gm-Gg: AeBDiesj8smzB51zo0J9QrzMXCxiEZYc8nIAr59wvWzxwuBUzESk8jcVcFVlAPLgk1f
	nu4OMXhxZx2EThOyNw4O776a0FM6H1xliO4AtqEl1OBvyXLh+ens6q4rUQY58JqYG3z7awebm96
	Mqoh16W/A/LV/eR15v869iecPFmpOkzyw7hJbLK36xqJ6ILbqIZ806OgBzoT85+yU3CG6QfnAuq
	PYkmlVESIhnm6zjFRCx0sc2rmqsRKUIqf/tTbwQSQfpW9DMHfDkaT2W3D0ITbCParsf4rum9STl
	zrKDaKE5eYsBkkA9ZcGiFa0+S/ELNY5VPxvScqa2434Rqas4tV4wkXLWBJ0v93QBonwit55LA9U
	uFZjO8Sf0S4iFakZLHfwl/q1auxAjk1/bSzpFUCYM8C3t3A0AgcvB780WcEpM/hR8Bw==
X-Received: by 2002:a17:90b:3ec1:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-3649202efc7mr1409544a91.15.1777348592532;
        Mon, 27 Apr 2026 20:56:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec1:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-3649202efc7mr1409498a91.15.1777348592040;
        Mon, 27 Apr 2026 20:56:32 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:31 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:11 +0530
Subject: [PATCH v3 05/12] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-5-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=3016;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
 b=eH0/Yk+y/GIExJ5JU+BKGEQ7AroZObH05OnbDmYhj+LP/8r5nK4poXvcv8o1f0KNc56zIXkbl
 paiGTgO/pIfDUJMGeIuoxTseODSS+S8kcu2T3U63FwjjNLuGQ4Ug7I/
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfX2YjXbg6NMBXy
 puZxkGUmh6/3CpwB+pJOwvXft6dbW09H+34xAMasZ3zzq4A/d9EbOKWjr97ybaJG+A9ObiOGb9C
 M6B3wRvh8jFIba36nksXrzRN5EWy51SWx9xcnbVYZERiDI4gxQQI+SgvHD0vJBt8HtoUhXHgLzH
 LdSZ2qYsyAcXSUgFYBHRSUdYlDYK3KE/zMLLSIG3AXoDZ44hYH4Dwd6x2/xLK70fQgGmgAIky2t
 h1ZvrhsugGpZCBirr6IbZTaZ0EkfeDKuVH9GxT1EgAiM4WrDc3DPhihgONxFuKn/Nzg70/0QkaB
 GDgFZN0fzTA5vUqBXhRefo8PJMmFuBNguq7HGgwva8yjcvOO4m/rTG4zdL3fsxrDocHiaB3X1O7
 pOs57Ne0oVFXXvCl07ybVDA/bLp5CojO8pUrSNfWrgvbRCTEIel+1YfMm0duztww4jzzCANNGan
 yebUFEP1z72TQq7crZQ==
X-Authority-Analysis: v=2.4 cv=QsduG1yd c=1 sm=1 tr=0 ts=69f02ff1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Kew-V8bE77LO7OHl0QW71ssOgI893B-6
X-Proofpoint-ORIG-GUID: Kew-V8bE77LO7OHl0QW71ssOgI893B-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033

The Glymur platform requires a dedicated firmware context bank device
which is mapped to the firmware stream ID to load the firmware.

Add init and deinit hooks in the platform data for context bank setup.
These hooks allow platform specific code to initialize and tear down
context banks.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580e..55ff6137d9a9 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -219,6 +219,8 @@ struct iris_platform_data {
 	u32 (*get_vpu_buffer_size)(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 	const struct vpu_ops *vpu_ops;
 	void (*set_preset_registers)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 	const struct icc_info *icc_tbl;
 	unsigned int icc_tbl_size;
 	const struct bw_info *bw_tbl_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ec..34751912f871 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -142,6 +142,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->init_cb_devs)
+		return core->iris_platform_data->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->deinit_cb_devs)
+		core->iris_platform_data->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -193,6 +207,7 @@ static void iris_remove(struct platform_device *pdev)
 		return;
 
 	iris_core_deinit(core);
+	iris_deinit_cb_devs(core);
 
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
@@ -259,11 +274,15 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iris_init_cb_devs(core);
+	if (ret)
+		return ret;
+
 	iris_session_init_caps(core);
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_deinit_cb;
 
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
@@ -298,6 +317,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_deinit_cb:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

