Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA3E0C7A
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964471; cv=none; b=kutNYLSMaaYojroMv5pmB2g3dDvIOadXWwyYUvDBUy+BnA5Cl9INBdE+DroER4FquhAPjsRRpIPmNBNvWuf3alZI4gNKW53S85Z/QXiYk94d8ZvUt+zL5lA3U0XGBQ53p3r9YUEzurwTSHnAD32ZE6nGYMU4Uf1nDJrwOX9957w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964471; c=relaxed/simple;
	bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkbQKOOOOJki6r579rBttUsyrZ5kQvu0E0U0lUWpclVpllHJOonwN6U6A4lXUQNIMLQ6fS3wkYgbVfake7ctkaOLjlGzNyZL6FcVPxEazTLSqDDk9f1fVB4mRHrEuO1Vpv7OCYqmED+2U3p8eb28IYk2aLVypwj6xmZAMoQUKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LdjCu4P/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OCIQM5Iw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdjCu4P/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OCIQM5Iw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456j1LS331221
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=; b=LdjCu4P/8xtim++H
	11ySw/8csdxm7YeaptSggci7OMVSaCGBF4xeVOyXcx7gVzCfzBNHiJdGV7lZFoMK
	ezw57U65lW9LW99UC/Kt102lan8RhFEYhpp1v3c0UJI20DYN5DjN3wyRD5HQecKO
	CYh98HbTIHRetymrNc/kmpCWqvgscUZH7w+fAFntRaxaeIm0IvRiVc1o89rvlMa6
	fvyes115G99cxv6SAmOmj1qHKPqa97JxkTfEVOw+EpgZteOB6MC2S5MIoxgrSl+P
	zcSWZsidybdF7FzUEec60YwoTU2xNjGO6RbRHkKIPg1XGNFhVV5wvnrF0q+oUahv
	jXB8lg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1b893-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:01:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365312a27a8so2012796a91.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964469; x=1778569269; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=OCIQM5Iwn+F/9R/2EE6HLGROLvIGRP5rutJxhmwQwBY/WwXn5BAvHqE0k/H36vTSIn
         YsMiz58e/skhMW183aQfd48deoq8AoNff6ZAYKNjctrGEsVhTf/pPwl2LGtoH4eTBqYS
         NyT45YZ/m3Ddn2R0frjx8Vpz9ny0Tiauk888jwVyo5dUk++HC/c+yiM/9fKH8frhr7vS
         LAb2R3O1ajKTSbQAySnNUGQDodHvJHwCob2Mp2YIipTZ7zYqPC44WmH6eowa0+ktHXls
         WoqZAWtiWMnsdM3ze5asQwC3XOzdHza5bLnzbhpc9kIDSs/D4XhbWGUa1K4+2JnAiVZa
         3/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964469; x=1778569269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
        b=SzqmR911MnD3r/L20BK8hNBKfaImoI9d1v0CrfbzPxGaRZAioHvmqPdV/Wqq07opn9
         4paUDoNMPOd/o4MvMvioGOcxz/Fz0F+Xf5hF5s7VWSdoUNl43IDre4HH1ng+koMu/D9V
         kslCPAoUEzJPsklH1+DtPLt+6+Cp64Sm/jhW7ymnvlmR1RjnFTo7/g+3pDrbkuCutgsM
         Iij0+wENIzEBkwMuOsXOE8gp/ERxPXgSg4bEwKbpqo6SjKPEjC0S/y8pk90xRWgQ13AA
         yA+UOeJQszWlvWpDKyn8Ht+sAIzABsCDSBBHXaGyRfIFeNLv13U6Ywb1PoIGSVWCPwOy
         dq1w==
X-Forwarded-Encrypted: i=1; AFNElJ+GQDY0ezMcwWPxG3PZ56xkCJO1ZUioOOMHZ/lgkJwgX+/xchFbKHoDeS/OT10yTixTN91RJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOyNC/VNI/emZmNMSdb0IW1cWLZTAwMsPGM6/zuRTKODOyB2HI
	X+3zLU4T6UcIkl8nsdh0EP/0RZwYINC2SzrdXVihbSzf8Xo/5uuffae8t3TTY2xQVGXW/VI5HIu
	cxwIo4q2h3q5+NKuRtOb4WWMoZ26/gP/1DN99pZgqhKS0dHk27AVjtb254A==
X-Gm-Gg: AeBDieuVtL5aDTlOzV9lx12BpPdFI4VwvczA/NyXMwS4vNWHExA8I4bOHg/GurvrRaA
	zAMXNQoQa5n+2r5QQELy3yggHpostnuRIv6n+2LfZQG8my4SgA1JohUm6jEjI8+X5DIWe1dNk8R
	hwJFwf54bH2hFnhDCvDfteME1p6CO4K0rkvJQQQ3VGg3kyn99Pn5UelC1L010f5vFD6KnNPLf9q
	IzinNh8+bEj9BoVK/BIiFxaiOhicVYyxBwY3OebmYkXnE/u7nMydWJ0dYvEL2VWwu66MYfiKUbT
	RAVLFN2pLQwzwlirTBqlFNO8x4X/tJtfvcGiROsG51Bt+WKNU9gQPhtgevubNDAzfOvjtTvr5Yh
	k6xklWV1/XtqHZM06Y8g+o2dfMVqZTHLAqnbQFf6msQ9MX4Aks4dY4Gx1r65WaZTmdN+4H8/y0n
	rR
X-Received: by 2002:a17:90b:4a:b0:362:bfd6:a875 with SMTP id 98e67ed59e1d1-36577369c85mr1964946a91.1.1777964468597;
        Tue, 05 May 2026 00:01:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4a:b0:362:bfd6:a875 with SMTP id 98e67ed59e1d1-36577369c85mr1964891a91.1.1777964468052;
        Tue, 05 May 2026 00:01:08 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:07 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:27 +0530
Subject: [PATCH v4 06/13] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-6-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=3016;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
 b=gsq9OxYUHQTzG9WaiC2/lfHisQcvobFOu9F3SM0jPXdGrbQ3ToFwtcC7nTt2I2lSoKXnT3nkO
 Ac2QeRNg2mbAez7nZcKlVIZXGff1VBznkJqWiAmryQnRSp7Q6fkMsYh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: RkB98nOQDsWOJkHgY-eepzcFD9kIEfen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfX/hYEsz+vDhY9
 /SBtOvsfN/8D2h0O0WnX1kFJP21e6fT2m5w9o0fdN9Ik4QMQJ12uv7s2a8aYxZb5eR7KBfdhpl5
 h9SZNv7hPPfa0KBb6b3QlrNuu3Xdzd9HKyEFqVpaupiYYP8UG1yDuogHHk138BAJhEv15ShvtHE
 3nc6DyKUQw89m2ijfj7lUdlfY0eey+ZkMijk2CNG5AyQz06d1HBB6W+SDpeq+iIUeV5OCVbp84I
 UIy8gs6MvlcOxXXr6GiYY1KTEtzNquLpSCEwT0LnpPeeWbFRaxP1Vsu12j87nERKGB3PQadFpmW
 VS4bGVEupqtvfAOAHN4iSxtMth96h6uk8gR+VJLDsIyOdHWZoc4FQx1CmxjzW7YjkuUorToejMS
 Yo0ogZ90UTIrkag9OxJGS7LRqvCy2m0VvDZuMze0P7sbxKe0H6MjDLi24XMzSlcLNUHRJbYBXJk
 exzaqDhrNW2MPrGGeHA==
X-Proofpoint-GUID: RkB98nOQDsWOJkHgY-eepzcFD9kIEfen
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f995b5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

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

