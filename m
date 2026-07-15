Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD736C582
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124627; cv=none; b=XLZ/ZEFPm89pB5tjV5n+kk4isQ8OIUOw7yUcUpUzvlbbVx8cbV1FNQfz0HUdc/XIfw8hqJByiNTHm413m25UYtfjKGoyIClio2JhxRfqVSQRq2dgSDKXTrebHByWbcw7J7+QQ6ikM2XGA/PcM1lXDUnOnvWxBAjkUH7w0fjpi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124627; c=relaxed/simple;
	bh=tBM4xBzn/Xu0jRn9xB3qtH2PBSvLI/9VGMLOvNw3o5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjINlIQ4U1jv2u3Hxhio1mr+vE0DrhjAxuTt/500L2Fqy2sO5KiAKKD0UnIu0NfSnbEhl+FXOsq08GozBeBrwrxQoBsu6R51AAzG66kuQQ2eSjGiPCt2Mm7/aHSmzfKRVVxCRbZHGqHbUWrqJnY9dfmdDP9DWoulaSSYwjOuXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQDuOgD2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IADduXS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQDuOgD2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IADduXS1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3VuT3775645
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=; b=AQDuOgD2MPFx9Qk+
	jDvhXq33rTOeaktqP5IzDqtn7k7bRJ27BeoGxWQnnqKJTeyJ9jyUp7Bny46xAdlF
	lnNSJoTCCuVoXExD8ydeftMvOkU55zKEXspr5XGZMJIdC29ACW8zb6falFpcQ/2L
	5Pk/rZ/NIBc9my3hCuSTth/vSzzaffFvpymxtBT0TKH11L5iLUj7p+DAmAC2m5k9
	KBSP/DSRmS6JVykgq97Pg06r2UraJs1Sw0VVn3SthKWQcYfvItovrrWc65lpmTwp
	xOgUHAtfORPRnoXZyaxfZoxGXaRhzsuTlCq2lNfSS0+E85yyYDirV/ycLwGlOtrB
	GNrtWg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7ka942a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88da04b719so2068737a12.2
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124624; x=1784729424; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=;
        b=IADduXS1/JI/epQ9mKHTTsa+Bkor7F+ECNaK2fh17lsPfXDnZcz3jWqFoGygxZ/wLc
         iYSZeeaHGK5EmsH44gyWUf6PVpL5lKdoumh+0ymVvWJvmHiTVe3v7b0UkXRgqFDns7R0
         t47NFRvrDSOsGYV75880xC3y6Mfb34OasN7Pz/Q9nXTBch5rnx8Gs4MEm7sT1K4sErQ1
         cVOdT1ExkyjTOuVHzrKSDtJJt84i37Ag+QjeB3cog814pHLHBfzi3i24b0iz3QqGqSBq
         tjXI2E7/5wufebscayZ2kLFGMOUWZquEv2zilxxJ49nrOILba4tLDYw5X6V4OhWqQOSh
         Gidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124624; x=1784729424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=;
        b=KCqSLuRJAXMsTB1HL3Hhw8fNV3GY8Zm5NTM32YaXqu37jtBLMH92sni/Sm8PfNihQe
         zAMmtds0fe/wT4Vqu+u/W4Q6oMwPy8lrqvTjNXquV9WGsFUUH/JYUu3hhTaHsStyQ2kg
         YeItPkGrhS+b3xLWdqcMiYE1KnZcE2Ug1xCmMnZzQu9YpiDBIKbwZKlD6is0dI6U/tmU
         XlUsbFAsbvuZyZciGYOvBcCFV/e24TYbdKz7DWLpkNxXC9EY3B6aA8Kshyh1RwzWHa2P
         ZynhYs7N+cZfr/GPDzSmecNha/GyOSBu8VBPJ4ZgaJRcsq+J8mcQqjII2BFR6JzEbENn
         nrwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwNJ2iEyxMW0BfHJOxRAWbW2Oif4POjOjw7SdYnJTRpR115J3OZ0rC+ASSAiRw68GXG/emoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8w6ntL9b6Y8GMdxzHcxbKf/eMfjjP/J2XvTO6WiENGcP4HSk1
	q6P/KQm1ArfirQH+fbV6PSVgg1JjCqWVa+Z+EuRHGIgPLBMZcZtCc//mRr9EblhI7P/uNV+UgAz
	h1b/5wmGAqMlD+PLZggTyxOK52JF5A/BJrUn6+iibZbEL4wgRQPyGBpzVmQ==
X-Gm-Gg: AfdE7cm6YWQjRSvVqRPXkiwzBEqXaCECAsRkDbQ6xuYFkHoGatfnAP931CLwn03WI9F
	PigFh+/GJ4ND7mSjVsokLn0r5NtFQIsCaXLeM+Gee1n1g+LiYVq12y4pTPUC/LKyHPyUTNF1lbl
	7FVQaBpsFG8axNR6rYxN2LICHd3005VgKtbdm1BlHCpns4y7X7Fyo5mjpaELd1nGl84Ve9LJc+L
	zzSdhm7wO8xwfsVRLw8SuhWMYT3rwLnGzkae2mqVK02H9u3jrTs2Ua6H9HtO4ZNWza3fDCsiaIl
	7SEFJZ19pVgI2nvei6lQ0Xf3LgX2hzpowqz5l/bmGxEb/lvedR60ghhUJFd8bafb7OnIDFLHpb3
	S49WwnhgHVeu9bGp922lJyInJktPtzv6ALc+F/J/KGgsV
X-Received: by 2002:a17:902:c405:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2ce9ee1143amr182310235ad.31.1784124624392;
        Wed, 15 Jul 2026 07:10:24 -0700 (PDT)
X-Received: by 2002:a17:902:c405:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2ce9ee1143amr182309755ad.31.1784124623841;
        Wed, 15 Jul 2026 07:10:23 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:10:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:39:56 +0530
Subject: [PATCH v9 02/14] media: iris: Add hooks to initialize and tear
 down context banks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-2-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=3226;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=vPJQbRQVpDgoYGPs3GH5JVsYjK3ZXwBn3AcrWWr9aTo=;
 b=YMlHOOpdBxPUQfilr8FFvs7rxdpEwUrOIv6CUO72aj/DfFHXZ1yBpMUAyh3JdQPWw6a4B1g7i
 0vDkxE1LkISBimhCDQKIHtl9/ukK1HkLgY3dv2aXdOluIoc0X7ucy6/
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a5794d1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=UiTy4FYwoVgUUf68WHMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: 7HeG_vlsK6_TA0yDzQpIhfF_JkhEQDzG
X-Proofpoint-ORIG-GUID: 7HeG_vlsK6_TA0yDzQpIhfF_JkhEQDzG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXyhS2sBLVBxV+
 NT8pfLyS9icxKLrcXrFtH0ZDtl6K6xfytfgKOcbnny0oeIcs0Tm5ciij3+JVTj/Q86H4SCMwgA5
 4Y0yDEjZafCqQdfOn3uZBJfXz8Y1jpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXwixh9WovtScF
 JKzRDLXXnSC1biP2Nw6p63TVPNyxbbFQtqQ8q3Ua+JRmDy0TgO3liYcPXSDxYfjUZ5y6dvpuJUM
 FsK4WjDRLK7ti45TAeXvqGp2K+LFJuUmGxRRBkMTq6L/VFJs/jI/UwCC/tQdCJRhXvCI4E/0fM8
 yppPGzRj1wZky61ZARwckeqY1GwuMGNe5Oyg/3Su5/TcXBwZPa1yd1+w4myqtM4qQtB4cZe5eIX
 I89cQ9QV9dtT+/0Ni5J6RB1Pdwm/mJGYlTAOEeGDpbeLLSXgtG6D0b08kmuqnWu/44OYMlVkWp9
 ketW1NBUHfz8uNrdWOmFrzch9kYzkJRRixgx9hs/+8c8v+br0k4Cycbj903HImyylpFPLMaJRVI
 FMxsn3wrcsDF+ibQXZNgSlH6tIYi+z2Ir58poqlI7tSNBetKSck42Y/97vTqh5MhqGCDNf7p5Ne
 SPcbS2bzi8Sr9FfKgMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add platform hooks to set up and tear down context bank devices.
Different iris platforms may require different context bank setup, so
let platform data provide the required operations via vpu_ops.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_probe.c      | 25 +++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index c2dcb50a2782..2594f5a67378 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -15,6 +15,7 @@
 #include "iris_core.h"
 #include "iris_ctrls.h"
 #include "iris_vidc.h"
+#include "iris_vpu_common.h"
 
 static int iris_init_icc(struct iris_core *core)
 {
@@ -150,6 +151,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->init_cb_devs)
+		return core->iris_platform_data->vpu_ops->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->deinit_cb_devs)
+		core->iris_platform_data->vpu_ops->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +222,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_deinit_cb_devs(core);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -273,10 +290,14 @@ static int iris_probe(struct platform_device *pdev)
 
 	iris_session_init_caps(core);
 
-	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	ret = iris_init_cb_devs(core);
 	if (ret)
 		return ret;
 
+	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	if (ret)
+		goto err_cb_deinit;
+
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
 		goto err_v4l2_unreg;
@@ -310,6 +331,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_cb_deinit:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 09799a375c14..a8df9af0d3da 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -22,6 +22,8 @@ struct vpu_ops {
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 	int (*set_hwmode)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);

-- 
2.34.1

