Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875B42BC33
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124687; cv=none; b=uQBirt2Y/CYDiBr1dFMtCsEj+H5FlmOXyWCOGCivFbLDKnF0DnJesmrkRqtvsrVvCr6hzj7kw2WJEfGOqvMLXLibZP9nxlc3Ar0LMEmsFwJdAMH0NqT3dLa6FmCbiG50tSYuc135b/YeB2cuggb5PIu0eLy8RLH8JzLKrlH2KKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124687; c=relaxed/simple;
	bh=Os8dAYcamOJnzmJwoFzvqrtNqrNmAEwuEyi9dkHQWvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qg2/3ZmgRQVN+x8baz5c9+rpQsalvY5+XgHsU4B7yqTcsdb2o7AHy/AalEFvp+9q/xamrFmY7oHoI9NRl/m1iF81+EXW/SJ2YdCqJOPsXlxQHUKssYFHyF48WfeG4svOQbOMgZGqnGSIv0sqBMqZt19MUHdvHyWq7maOAtbRTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XR4554go; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kv0mk75h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XR4554go";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kv0mk75h"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3beM3664222
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XEG8f3Kfr2qhIFwiOsUL7RgFXaPXEOjds0oQ+2XH17o=; b=XR4554gozXNl4XXk
	0h60A5r8VAJ9hknUhtKQVwaY0r4thiDXypH+ok0OXpm/+RlCkphTBJLdu7N/hAf4
	ZDfk4awK3vwNBErdsGXRJJX192OahlGUyrUgCaUi7FlyRHayrpBPh6IY7jpLWX43
	Nq13s2PE5ZmR0RIRbV8smpOFqc4Eq3mrR3BJktCmuor6xK8wrHDLKOvI/6Uufyb6
	ZRLPjn9pSek6eR+u/gBiFDvEGBggqEI06u8wYEvbYXV1hcMItrGEWy6AawmiEc7E
	j8MUcigUPr/sGOzE2lnoWdkohxf5OeopJzEy7f4BB1QOXaE3rTXb8EFSsbqDmaQQ
	lYL6tA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mm26y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so105812675ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124684; x=1784729484; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEG8f3Kfr2qhIFwiOsUL7RgFXaPXEOjds0oQ+2XH17o=;
        b=kv0mk75hwezxvi3YEma/CjS7lXhhX1zabcaxwfTox3piU3eombrj/g0SdGEQdQEgul
         eKDt1FF2QRpYdCMpy328Zw+dWrtXS76NQ3XBrxZsvnV6FVP8sSblrf1bv69ppspi8g2l
         Z5vVlx+FxJ+v24U93PL5Mg+ZxLSNuJPAAJoOEMNZGCh/jFY0I+B5yYb8cXcmBgFbmKjI
         T6DI7GKEvzyBQZbg/5PbvI3+gsxyPrHPVUEnK0La/PIivkrEjC/CGyzjJKLUjspP1Auz
         YfdEfHTgMeCKhWNupsiM09+luuRzm+ER7g23jo5cI8mzsm5yl/dUtCsa49o5/u5Qd55H
         CcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124684; x=1784729484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEG8f3Kfr2qhIFwiOsUL7RgFXaPXEOjds0oQ+2XH17o=;
        b=lAQfp2MeOwh4UqhllpRr5lr0b7/pfvw1zRwO+FsjP1s6Ac9IFUmY3y7uKxdjzGJcwG
         ik/c9fM1ptEEAVcbySvhxGsl7apyT5oZsO8IouB7uJEmI/9+ExIe4UeCAGef6ThYyK6V
         0QWXV+SHI4LNdlu+he2TjNvlSsNu35v4ScEe4hRNcNoVgc0yc1mFkonh781+cWIrqDCU
         pQja/EQZD60YYaXht5qt7oJXjt1d/JaW/i8sn9R+fnxcWWRYXI2A+sZnPem43hPRHEOx
         6wxqOLmvZ8HLXcK5+1S6Fi/zhrm53GAX5RXPa45quRKaUuMrLRXoe7BMemx3PlxmGNqr
         flFA==
X-Forwarded-Encrypted: i=1; AHgh+RpIH0MaqLlRK85hU/bdTQ2kz49UZ1mn52D/m/KTy8aM0flb/OPpPxTH+2U4KtOlE/RKVFzqWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxarDZXR02Z1HkhmlCcH1U4MGtU/OipJ2Lrq1AZ1m6qFaVHXVOj
	SX2+81guxT02VsxxRcW5LlspxJRvDE6spoScf1T5Dnr8opjGTTa0NcojVRjJP/LtCOHJab1pOP8
	XA3F1qWFHU2a34kRxP1dWehhfgJ5OJhWhnIHfjxDrxyGMd+/GAVPJKe0AAQ==
X-Gm-Gg: AfdE7cm2PkMiTQz5ZXP47QGT4jfA1sODOKubebPFj3dmAOdGmu44ktvEeplUHGYjYTM
	U7Z8oaJ+rVE/UpsR6mjs8KBEhWDPPUUaIsYvrgTKp+GOQ6hZlnZB86HGPmKKCSvD/QmFa8aml7H
	XJECAE1e0B82jdoTL9uoJQXTf0dceX0QlSlng60aCALQoEaUNyPXmVJlDwuryXYJbL950dN65WD
	pGaFvjek2Aivzz1f4X/oR48yxl7nlFmxz3v5CHtB+UBRqwEKlGn9CrLYqFAHCv1YALX+iNpKgAN
	BFecElAiiwfizBZiYvYAseIAPKWoIOTTljvYDCsphNfxBdnj3h1Eb36+A/JNDXgQrRfF/Xcz9mF
	ZWtCnwvYD4cei4R6cRE06DOkByT/27tt681rLgTs+Dkcs
X-Received: by 2002:a17:903:32c8:b0:2cc:9179:325 with SMTP id d9443c01a7336-2cf03c10898mr26403545ad.13.1784124684005;
        Wed, 15 Jul 2026 07:11:24 -0700 (PDT)
X-Received: by 2002:a17:903:32c8:b0:2cc:9179:325 with SMTP id d9443c01a7336-2cf03c10898mr26403205ad.13.1784124683532;
        Wed, 15 Jul 2026 07:11:23 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:11:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:40:05 +0530
Subject: [PATCH v9 11/14] media: iris: Add hooks for pixel and non-pixel
 context banks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-11-8cf2cbe12a07@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=2481;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=eGnX+6v9T5zpKul/tvLceKVXAucGjQ/Ox0wKkhH16hE=;
 b=XTUm0A5+WBQQvrJ7bH3a7F4TVZFJ1E+maaDXdHezHIWQ8ibMU6bR/hhxP9jrLE6Vv74l9t2oQ
 1tAzf8XbjHrCLajDgBrdQEjQDPrTzAVmlzxoiPx2PFNIOZfVNEss1iS
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX2uq6nisgpV0n
 EAbdgU1ruMdTrcoTvgEAGeW0py7W20UwOH9JXZa8ORbCrKWCug7aynNRxyolFk0dgWgeAXwHV9A
 T0ETkHHFm1B2XvOb4YjSNQfFE8/jB8V6H8QzVzHPub2ktw7Mk1jOvRY4PB5gUDUwS0NuRh+7yO0
 EwTRP/Ax/GAXUs84xqWBRbx0HYsqzeZd82eOy8O0sAC4aBwtjnMoAh/om1sT9aSOrD1bArQtp1r
 NEVBVaI3+auhbirAOXsS7X+XLOfCKMvdTYNJV05UNDDZX3qdd5AUxFNbA0HngrxdfXJo8vDuH4U
 r+hOdDyaJT2m32YF7U7D2A2Kuzzh0mlCtwxlSf6c/lwSvhxt0Txi0oWCaZWeCd1O0zWnBAQiG8+
 JvY6zyQKf8MS9ydy3CXeZgzHW+surp5FzOWy7HCB/xB7UbxROxmDUT8Z4EXqm2zDg0VPgEhAom/
 GObtZn/v9+bQp2K1Ktg==
X-Proofpoint-ORIG-GUID: 1n2gR-hdc4vgvm9MET30Q-cUTDmfY6lM
X-Proofpoint-GUID: 1n2gR-hdc4vgvm9MET30Q-cUTDmfY6lM
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a57950c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=Ysd7Cdeu6pd1DDnCSN4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXwyADHC4gk2Qn
 GMikCZXyKyP/ee8d6LcBJThyi5E+clPu6rVSk75Zd+8Qh0YLeO3I0oW6DWA2hPhYbEmbSVOZbNm
 EVa7m/7/Yu9OwEEwMfYmaTENBrWZcIA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150141

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Iris platforms use separate context-bank devices for the pixel, non-pixel
firmware domains. Add platform hooks to create and destroy those
subdevices, and wire them up for the affected platforms.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 97563bf89939..7d9d67baf22a 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -399,6 +399,52 @@ static u64 iris_vpu36_get_required_freq(struct iris_inst *inst)
 	return max(vcodec0_freq, vcodec1_freq);
 }
 
+static int iris_vpu3x_init_cb_devs(struct iris_core *core)
+{
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "non-pixel");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	core->np_dev = dev;
+
+	dev = iris_create_cb_dev(core, "pixel");
+	if (IS_ERR(dev))
+		goto unreg_np_dev;
+
+	core->p_dev = dev;
+
+	dev = iris_create_cb_dev(core, "firmware");
+	if (IS_ERR(dev))
+		goto unreg_p_dev;
+
+	core->fw_dev = dev;
+
+	return 0;
+
+unreg_p_dev:
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	core->p_dev = NULL;
+unreg_np_dev:
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+	core->np_dev = NULL;
+
+	return PTR_ERR(dev);
+}
+
+static void iris_vpu3x_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->fw_dev)
+		platform_device_unregister(to_platform_device(core->fw_dev));
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -437,4 +483,6 @@ const struct vpu_ops iris_vpu36_ops = {
 	.set_hwmode = iris_vpu36_set_hwmode,
 	.check_core_load = iris_vpu36_check_core_load,
 	.get_required_freq = iris_vpu36_get_required_freq,
+	.init_cb_devs = iris_vpu3x_init_cb_devs,
+	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
 };

-- 
2.34.1

