Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0647F2E8
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844247; cv=none; b=oz+q5eM7seJ1TZjvrX3/QLtrosUm95mtOGsfa0NpC4zcpO19HDx6IOZUXn55s6YpVsskWE40CuRS05xUDUj1P7nfBCZ/YIfDrh5uXYiKwcGtRi0yHlccjZL4yjifrcDpEjbjSrWoYyHSVhK4QNETu9kS3CVHf6CgAMwUStOnb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844247; c=relaxed/simple;
	bh=HbJDO7h4MkXgsgKVbQfCPfPwW5H3OtSc6iVBjpNeMBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPmyTfniyt6Pkw+gfufpnNaAZW/tK3h8rrhhQM8sn3Dn11tYWKXwz9mS+6RlVliUZuabAINGnuTfQ118kNJqsXznAedp5gHj0ST5JayQTQbKc85ja4YxYPx3n7jB3zvBWUXKgKjKDvGb0hr9fe5d4nIbHJ+KxMs+1ThF+q/xoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHLY65yp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nw2HT71k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHLY65yp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nw2HT71k"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5USUa3200389
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BeUeck/PnJeaOYXxZG3voZpfankG9NVFAX+3uH7MhSk=; b=NHLY65yphjy4Fq7y
	VoH5KiywMXn3IbSSHFXnj1SouXITkPl/vrs0uwKYv25HgKSP9BD6iCMF77ZHSS1J
	+zV6toe6EMD4/DHsKMY/mcRRnXeb1HNk7wbcMmgqO790DsJ9MOkVc9p3tyL3LndB
	3jarjdv4qto1jqmeUfcrRjnvKdtTrpkWsu8IR7c33CuiXgWRspPGbkqMlr/aFuES
	6tjdkGUbiGtURXKcG9dtDqdP5Kn5g0h4JsSEaWx/hwKmA8X5/Bi8+5X5EsRn0i99
	qDonOzIqtVK2d4MQ3e+DmLGzmctRbobP4tyZPtxCSA5iba6ibz5lfkaWOpqiE4lp
	druOlQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qtynx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so5740381a91.3
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844245; x=1779449045; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeUeck/PnJeaOYXxZG3voZpfankG9NVFAX+3uH7MhSk=;
        b=Nw2HT71k8qt8xlfL3ecD+sWx1fpUkPgTJ+tgicjZ31LFSAcfBAY0bUiNt8YycEB5sT
         lBH9LNpRezli1kllcbcrvkem1SHD0WxWt8Qa1YP3TFYvnh/VYlzRJkNsML5C783/lrqX
         sQqU78qAR3zn7U8Hfh2vXfC8DxOXvC8u8QqWTk3FEOOw9s7CMhPlmxM2VKnt4FkBwHSp
         HrpCR3bqz5ZChUvs/omagCAUXZnJEckqLla9BG8MM+uNfjutHuUOKXMuY60t+A4lJ8Ab
         gGEzUM3BnD6zXlG5pFC8K1sNmlTqs1IzTgEx8T09jVTKzCTNhdsLkenrd8CWhKZ55jma
         XHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844245; x=1779449045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BeUeck/PnJeaOYXxZG3voZpfankG9NVFAX+3uH7MhSk=;
        b=PABYt3wTfxhq052SFQ+udsxNfrK90acas2m/loAs1p2MZllh95LeHLQDgscNxX7VEP
         7juTZtdpLY/CJvFIAOyQgPVwB8re5yRM5TBL/r8aZ+r0UFd2LM86dNrVVtNtVNosUyfl
         eGhvluKX9PPxr07imCQNWicnjQC7mnOHcXb1rI5MVljA+Ufr9laD32BGrr6Fq+dIWgCY
         1asNgJN5Osl8Af5cBMcHtyMwk6psUEOh998IUAyRqJdL8Rk59mpkgFgmOAxD9SlYyn3o
         x12mvK5wsEYXRhSX5xVJHTFE7jMlHj+ORoL2xsY8yB1OASZx8Lg+SMw2L4ojuCtf5/0U
         KytA==
X-Forwarded-Encrypted: i=1; AFNElJ8Y9e+dbqvPcrd5uawvSsRcklMiG7Qg1hGd2X4WUvUf1qO1tnPG1mQmf0ZmlLrGV2Cd0fEYGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMdZX4I1OU1VlH34hKngpyF9LyAJunsRF9qMcqD/K4L9H29dk/
	seOazsrX1TdZ8fkc+nu/gpj0iJVy1vdRJNc4cjN0rIVWVA4hIGaIoe8qwtFgKe3IMk2O8GSq6oX
	5kXbq3qUcI6JSesvs6RmiIwtI8yb2KqKOMjuJ1ui5UqYpu601IoqxLTet0g==
X-Gm-Gg: Acq92OHovvuDDbfzj5R+2+o4CSqdZpSgkcepcU8CiSAfrQVPdLofAoBUNnOrpuOxMdr
	A1pnbZcH7MUH+e2J4rkLMNiUVU/0qeWSIfUjoYSpUiFzTJYQoQD2mtzWmO6VCN3cJ6HqP+sPQb3
	bl024DApk0uaKgR9OiZ0SpwWe+ftPeb0ElacO/YNmBL29UAVYIdaEjQrAl6IKEAP4tZ7yDCfe1z
	eZMkaZrdH/7nZk8ZTnW2RMPekkfLVSp/o8Bvkqq9Tdsx6W4vo4px61XzGtAG3nAkh2lM4GSSGw/
	/4jNXbaSGw+BCBpWCj8E0F3qxeaiTGrHFn9s7I0eaI4qJHh18gsRA2utkED5czGRy483fOVT2kl
	8w1UJ6/PF/RU+Disu3L84i02nFv1hccRmP4+NRvgK+6S6ymvexMuq9NjPXtsLG2QYmA==
X-Received: by 2002:a17:90b:2d08:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-36951ca6064mr3530025a91.23.1778844244680;
        Fri, 15 May 2026 04:24:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2d08:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-36951ca6064mr3529993a91.23.1778844244145;
        Fri, 15 May 2026 04:24:04 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:24:03 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:21 +0530
Subject: [PATCH v6 06/14] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-6-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=2952;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HbJDO7h4MkXgsgKVbQfCPfPwW5H3OtSc6iVBjpNeMBo=;
 b=5Ql20Vud027qUgCrsDdN8eNBl6av5FzP2NS6aw/2+3z6TP0/pO36FuTHTiqw0h3Z2qRWiyCI6
 lTq0CqYJvDvCxrxV5MVdBvRFrCeQ97yAv4xs0DQ0aERecLQ3g5rcKki
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a070255 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: OBw0yBVzo-AVUgFA9EKC8MFGk7Aa-5rC
X-Proofpoint-ORIG-GUID: OBw0yBVzo-AVUgFA9EKC8MFGk7Aa-5rC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfXwLP+4EBxVXEw
 AMtTZ1Min2vuBVX4AZJy948oyPB82g7SEZqQPGLq+9fPthNpudN/Xe+xCDnOuNYP/K1JIZOMnPN
 U1NXehtYb+9pFOci5N8LPTIskYsxCElZkoDFem0Qe2t7B/4HWckh9H1CEMrx/deORQc2o9MR2tB
 3StYsKfurxlNYZPFXBj3tEVmXavggIv4PCC0FdDDNoC6QSPR2j5uM/f2chzml7YPzERgDpozIFC
 ZMd6NRLeNCSNYhrp0zDAbCM+XobsS8q3iAPvgNUQj08tj9SE4LeXFFtOHK1uXbPaecKA5V3BvHT
 Tjx9M0Z8n3QimTc6M6Ddj5OnFwLDdeOG0D88bBrWI6dOZboQBfbeFxVgKYl+sVXIVjeuJsleqQS
 UMNvg/QNKtOTKdFNDKigtbmYFCaTh43YynKEvW7svjJ0rUO5Dhe4xYOCRJlvUCRBIAOmV5XfqR8
 tbTBrHRlIxtVbWgIU7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

The Glymur platform requires a dedicated firmware context bank device
which is mapped to the firmware stream ID to load the firmware.

Add init and deinit hooks in the platform data for context bank setup.
These hooks allow platform specific code to initialize and tear down
context banks.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 6a108173be35..84fc68128c70 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -263,6 +263,8 @@ struct iris_platform_data {
 	 */
 	const struct iris_firmware_desc *firmware_desc;
 
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 	const struct vpu_ops *vpu_ops;
 	const struct icc_info *icc_tbl;
 	unsigned int icc_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index d36f0c0e785b..12596c9a3cbf 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -150,6 +150,20 @@ static int iris_init_resources(struct iris_core *core)
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
@@ -206,6 +220,7 @@ static void iris_remove(struct platform_device *pdev)
 	video_unregister_device(core->vdev_enc);
 
 	v4l2_device_unregister(&core->v4l2_dev);
+	iris_deinit_cb_devs(core);
 
 	mutex_destroy(&core->lock);
 }
@@ -272,11 +287,15 @@ static int iris_probe(struct platform_device *pdev)
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
@@ -311,6 +330,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_deinit_cb:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

