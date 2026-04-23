Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D6282F2F
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951046; cv=none; b=p7/6u5uMiUdbj/BKmRec57eqdPdVmzsCYCBpIwEgbCwlYY6dGJjVBrSVe/XFq2fjqY6E/IohY9rYEHiNdnCoppK3MKd6me/aMhqOckQySL+re9fKeQjMOEx//wFmWh1myHEX5fI6x9CEhSNUYGkVEuZle5nMh7YJ7wUfmQABufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951046; c=relaxed/simple;
	bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxDjZReucNF2rbst3FubdJzW/usQ3a3RGiACLGoTo0QYOZjNYwJVvITOEcur7JOr2TXUS2pY2yM6RB9lIIK20ANRhFOGAcq1d6Xq6lmjy/KftXrF1jAYDap/vb6dFYALERxvpae/WZD67HsVsxs2MPHBXCpEOrnZA60psm21Gtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JQjdEduo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+XLeG1n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQjdEduo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+XLeG1n"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uGMh3044149
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=; b=JQjdEduo3jUB4J80
	UxY01Cnk4y+htGI6K4HB4Q9VDGH+RDJj4KsPymFhpf7PdRne3+z38qSjHKKdTCTI
	maE419NrLKzQIFyJf80l3FKqZANQx+9NL7JKfQQHU1+o1rKZxXuy82M4oLkjzL8N
	jN9t1SdVEGYdvdegpuVRKFp6Jx7PbciC3MVFdfDNs1cwXyCDIM0kAOaSON+6dEbg
	5URf07jh1XQ0GReKmv3koAWR9AfJUeoyqq/4F4qrrVz0Tkb1rrJZ4kiXluiwghpb
	Txi5+QjMDdGLFLpydNyXVjC1een+SDhfTCXse8e0xMENr3xxdMdvW3qTppJ6q1gi
	drl6iA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh436b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso61535775ad.2
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951043; x=1777555843; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=W+XLeG1nPta4uV9OF2/U+Roa/CtxV7C/fm40IxhSEg5UNVOfsuX8NDKeSdGRv4Apw/
         YNvzh6MF81oArfC8Ve2DFkGaU05rt3vUXsH4N7yPrbcznbaqQVQ8gUOoPkAqi6/gR6xC
         sxyossaC4G3AA+4KuNojPRtt24V8887nurxLngMljJCMpGCzW9ZDkbLDLCmj9U2KugEK
         7Ii04OeuJYRBpTTMpZDDIfH5uwHQaaypXysulQGAaJX366AZptICTQ2egIs3xYmxUXNy
         W99MhNUmeNDesJ0lodwv624KfnZWHwxP/vTn//NWS8RxvJUJTiFPAo5KIrO57h8vIlvs
         dbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951043; x=1777555843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=pmyIw8QbuxgCjlWuNvlWWe8zW4sE/fYYNksYhos77QCch9+70qfcuo2aHvX7U7RR6R
         m5RDI9ciuvPHp+kieMMWXD8L1Og/85Y3QZnoRn1l4TiROQEGjLsrbsCYLJAQreO+TgHO
         QqEp1Ajr44mZ3wjbTwMFBdfPsl8OyxQS9K6HArs1iXQ7nN050ybHTNvoirq/f4fdwer9
         5lCUajPhj5sAtwLWbIUWzI2BrGJmmUow8/TqXMbVf7fxs9Hdzvuy+0TP/nDpzj/4lwTW
         WsdBQzpygf6naUudXKsXMnuhMjVL+udpibOa8xRohKG5CiET4D+p8N539djwsx/wqYx+
         kkWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pgQKQEYLxQHNa5dG4rPxE6iiCGrw04v7241X5EUdtTbdfT3DUXiscBumnxnXoYxmMa0BcnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUmZjXgxt1v4H/5bvZnRSs/3mlVT6DxkyfOb5hamMhmbSZiPka
	YwwjIHU34Vt78s2f5pmvNtgvL/tmMRCUISp783hIB+7ENlyvPT9iq8SAX9C206NfgM9C20nR7tL
	dJuDHMncN8FD13cWYyYMIY5NzEs8zo5DMRkA5eXnJU6nppi2Vd0RnaqRRYg==
X-Gm-Gg: AeBDiesiPVlW5tipul+Yk1nMoQdRzEgEXae15rAAKk9zNsYWUg9lQSoKMG9d+j4JtQy
	uogFUQwD8k7Ujf+X2C6hPNUmyV3rS9K4B57Pq03fMAWle0uYzp3UnOXR4k0Hq5Bhja4FZQrhBHE
	GGlNu65npHe6LHc7xbI9vrWHqEPZY4QMivzK26DvOtEpUinTEQhCi/rNvnVTDi5k86QLtxELs35
	zlVOYWWlz2/MDCyOmMUBw93vnmHjfdcpOBRcSdStqk4akm1o+az8dZ8Bp50wIyusEsMuuwo2I6W
	iWXLNivg5+Xqqg4ZF9y/2/942wdmfk20Ww2yrpoFKGlkG+mv1ncWdJyyUSKHGSw+Q3gXFNeJCux
	YHIBCgXImQrP8F1+5j6qc+yI6/GhhRB3la7KTYFplj4yCpwOIR7V/TLa2SzK8QVRfkA==
X-Received: by 2002:a17:903:246:b0:2b6:309:9f72 with SMTP id d9443c01a7336-2b603099feamr251901995ad.21.1776951042374;
        Thu, 23 Apr 2026 06:30:42 -0700 (PDT)
X-Received: by 2002:a17:903:246:b0:2b6:309:9f72 with SMTP id d9443c01a7336-2b603099feamr251901185ad.21.1776951041662;
        Thu, 23 Apr 2026 06:30:41 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:30:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:34 +0530
Subject: [PATCH v2 05/13] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-5-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=3016;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
 b=gOrXRuyYOx63Ro+9sR82pXcBF5nq7YQVv4DGUiouKMpmgBheyBYqtRlAtDz0YtwxU4xK4b9hl
 ZU9S3UONyzDCyAMpp7MxY5zrCrXMGnz4RUuNOm3Zcit7fSDGObuuaq4
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX6ERDuT5Ar7wW
 rCF71s/0UpIgqkkGcItrXFCcg3JKChX8LggOJAT3M/6+Rp6Yq9f2fBpwGt4ClHwKOa9B2SZDHFV
 3CMoQfEoCUjftQVpnbuZIcLziiw0bqISyVsB++Luqa9BdNiPQbDN+iGflKyFdMFHAHwmqhaUB8B
 zgs+S/xaZFSDd1czwgDUUF7f6F4YhTjQj8bvwMwLBJ4yKBLoPb0+Lmy1eVw1ZmdAtN2WuarJ4Rz
 iENL1sAdoYsAR94cuLqhmv7pPRY0Wk+orDXr19tKXRdwpUrVEpf4+X+idwrSC7jNseNpDLvwJJx
 EW0jWWTs0h+7OWSvXeHtBX5+s3qWnTtnyVDv/GqM863+pFjHdZ/iCZ2gcuVArNigk/mMopEHdGx
 HQdgxecx724DnA2zree6284OnCYvn2Fbt492pN/vUPi+ENjODSFBtnbPdm5CD7/Ei/+MAU+BvxJ
 PeGn/nZwjZD7hzGZ7bA==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69ea1f03 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yaMLNBOTWWK0lvrwl5_U472G4K0F2GGo
X-Proofpoint-ORIG-GUID: yaMLNBOTWWK0lvrwl5_U472G4K0F2GGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230134

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

