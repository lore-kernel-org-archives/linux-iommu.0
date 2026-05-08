Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3741B36A
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266941; cv=none; b=UnKQBuFPZZK6e3WToJVAbL11eKJXdsWHfrAQqxKMvnXdtssoaBET3erlw29PtzFei+7YSaGsQt29uMZf4gnWefE96y3WiCaN0/CgRSfHXJaM7szbIcbemP9HSuQLbxTtfqQoMg+LmP8R3foAmMj7+tMLDQPPCY0S5pnVtVHSKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266941; c=relaxed/simple;
	bh=xSTCuduleCdTS3ksmwRYWM8cOaNbocIn1Ie2DQQi3e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUSgw2QSCMIlI2FjWg1caW/yG2U22cEZoLMcsSQ/Csz8jLZKDD5UgLp6bbWqdmuUXXSQe+tRIB7xixaaZEI4VC40vg/1Wf0m3NVV7YqFFlJ0ksDBVU9RBw9qMvVGiHMU/MgId7YIhxp3M1/dn2b7g0VV0PsI5d6PdssrRTUVMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WyYuZ52H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqT3g+DY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyYuZ52H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqT3g+DY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648He23t874583
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CX/mLQxL0XM122mOD78xRebannrP0Pl/tNL9f8AVJkY=; b=WyYuZ52HjufpGIos
	+yiGavtnaKFdJEsWGHuMjHU4fSai5vk2WY+LarwyeWYJPuii8uIer4OkNnekvx13
	ut+2/SR2NMAlUUYtYC7Zaenra6m7rMIfOKuH02wIYWYNqulsM1exILeKrEIKabOu
	5iEduw3ygAqC13auVux0LhLKzwChbaLUYWqfHVxasTq+3CMN46sBBAOkVmromFw9
	xX6Zae6TravoAE4T7AUUc74C3L0qsUBAuus/HYVZ3AvTJxz/dua0qtTD3sL31bO4
	bTIRAHigzfd28hv81UzHgQiKXxJXhFv6xMoaENUZYuCyxZfJB9xKKiweyPtj8cs7
	Fi6p1A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me808kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:02:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8354503d9acso2679900b3a.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266937; x=1778871737; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX/mLQxL0XM122mOD78xRebannrP0Pl/tNL9f8AVJkY=;
        b=dqT3g+DYYxFBkZ0323D0759MopOIyd3Lnb4H1JLUfZLQO8vclZy9rpmDCcAOJW05HG
         VsClTNe2Xr2UpOonN6O0RwCg8zQmhwcH5RefG2Wh1W+McqRLOW1OuVgYX8GPmo5ZFSRE
         YLzndAe3k9ek7X4sLHo+fzGHnAHEQl378aBxxy264aqNlkikyxX7HMtImw+9uJyCGc3m
         A34gSUDkjU6UWUeiPu63YRUNvqJF4UofOTiO6h1A9vw1fZogk2Eiwk+HW5kVzf5ehta0
         sXXei9XZIstM6JsBgXgPBgUHp55n0L7YoGWW8FoeQvReOEfwkjueP8VEsg8fzh6TmRqn
         RztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266937; x=1778871737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CX/mLQxL0XM122mOD78xRebannrP0Pl/tNL9f8AVJkY=;
        b=ZESTYBfi+a2nMWv0w344iP3Ji94p4whfWAzBIM8p6fTCQnjqXfcHqVdReKmEYZ9+Fm
         MMlHt58VO1I8MztDl4M1RfwWC8N9DSzeUFa84u9tGECmv9TFYIV0YxQ9PWoAWw1YTwNu
         vvKFmoARZ4+QnBekBiO49xlIXIQ6vONmMQ5QaqnnI9jhEB8w+xKtalYBoep0wUybVsNE
         fIiT/FKsIU+VIWDo0GDSHcJ7g+ezZg8zK3wMUgDA/0zg3k2AbqrR20K8x1CW7D/IWDP4
         MCL8Cm+AlYgsGiqwJW9SCcR5incu1/XVimLjfZpYHmnycx4+bJQVYR55Kxt8dKgSciM6
         0Zmw==
X-Forwarded-Encrypted: i=1; AFNElJ8vB03eU9zT2yRwQmRmm4nlEVge4DKamX5pzUIJOY5DRm958ojTU55qKQ6GDCLurJzBnoU0rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuEF21Gt4+Hafh2Ujxfh9DwL6Y0AdzDgjT/QU9I+dh4zn0qaL5
	t5H5YnDCfTdP4kr6Fw/eDNo3QTdpxdVVd6fjSFuJoWshTkvJ7/CbZjRv2qShTdO6Ku+5ky0NaUQ
	2KJ+FGXumYkVvrZ5f77E18sgM9a5MQJXVroih//9LIcVQ6zHfjiuYICdEwg==
X-Gm-Gg: AeBDies1u4FdPmFhWFp5DpEjmdCVDyqa8Z3i7g/C+Zep1kr7VvSdjKgls7udtNjqXYo
	eVF2EMQwElYq4TgbMI8MjIBaSNy3Tp5Gu49lSQD6rTv9uXHqtVYPZRBEpvyvSjdW1/GsQ8pNVDN
	GoNNJN5lGfh8LxLOIobmkzu6Vq3lFpB4gbvBHeJ5Wonll/eJwUE965Kh+OPs70Io3gp+fMUvLOG
	ntsFcqe4w4Gp7U2s/9UnZfW82g9b5ONWz1zyljPM6BWIrNT9fRtGsFXcbkfImMH6rArNv2aCP7p
	L8Ir6sDzPj97/GTAAwyIkylC2ssKhFH59GuWTBeLets4NgyOwMEd5K+ExLCHnxL328FvPHS3JQh
	qcoAMnHNWPIb58cBq2IqkA98rHuZV+lLs3i9a5I/Lx3g7hYGnzXNmsxw=
X-Received: by 2002:a05:6a00:2411:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-83a5df487e9mr13633878b3a.25.1778266937036;
        Fri, 08 May 2026 12:02:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:2411:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-83a5df487e9mr13633803b3a.25.1778266936365;
        Fri, 08 May 2026 12:02:16 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:02:15 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:30:00 +0530
Subject: [PATCH v5 11/14] media: iris: Add support to select core for dual
 core platforms
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-11-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=13228;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=xSTCuduleCdTS3ksmwRYWM8cOaNbocIn1Ie2DQQi3e8=;
 b=Ch8yJ0r7/VA/fvTdggbVVY033Dd8GshfLUvSqE5JorukITqbv6j6Zol6oOvHHxrGusVJYJvpP
 XlV45BZTORxDOKDKHpf3OHok3nfZEADEgb4AEhyOAgcAuLVsMqS0Dbz
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX/+SLAr/HZMBA
 4WS0avYwur9HKOLMX8BC2oSri9eu4lBt4XWRPMC5GfbrPpesSwfcxhA14QF6o+l98loE5Xm8YGd
 QMK3BVtg3eo4MaFCv/M+QPS2hk3sukMo1k7wYPW+3ABvypnuWw2ZxwfmgRQza0cFfqEMJOxTUYK
 GnQE0UPp8pZ/i7NzOzQsvP3Ls0kLXKjTXz4zl1A7FiWwQ1Ah20yNM003jVTaugUxN8vP5ITvh5V
 Wz3zZA5ZQNR8+ubshxwO8yJPmDf7WhD5fUseydAMgg9jSAYtAfGV/B++OPDom7WitGUB9M0wYhq
 9tjOpQq0HVNAZ+cKqkiNMNxVFF3LvZLrMxuSS+ilVIFMQEBCgXKvfImzIfz8DdrUUqQcwcWuT7z
 +szWo9k2XBMzMZr23vgc6ALFwV1j5ZIqTN2JIcPMhN+R7IkkNBPIXWK1DkuPi8BR1UyQk/Z2fgB
 t24Jr37GrpMYRQakRfg==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fe333a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=bXJvY2iSGLnMjMWPEVkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: d4mmnIHUfyMfVcjl2e2Hpcldb4gNxUMP
X-Proofpoint-ORIG-GUID: d4mmnIHUfyMfVcjl2e2Hpcldb4gNxUMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

On platforms with dual vcodec cores, select the hardware core for a
session based on current load. Assign the session to vcodec0 if its
MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
the selected core to firmware using the new HFI_PROP_CORE_ID property.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_common.c     | 10 +++
 drivers/media/platform/qcom/iris/iris_common.h     |  1 +
 drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
 drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 ++++++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 drivers/media/platform/qcom/iris/iris_power.c      | 11 ++--
 drivers/media/platform/qcom/iris/iris_utils.c      | 75 ++++++++++++++++------
 drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
 drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
 12 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 7f1c7fe144f7..3b3fc482e194 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	inst->metadata_idx++;
 }
 
+int iris_set_core_id(struct iris_inst *inst)
+{
+	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+
+	if (!inst->core->iris_platform_data->dual_core)
+		return 0;
+
+	return hfi_ops->session_set_core_id(inst, inst->core_id);
+}
+
 int iris_process_streamon_input(struct iris_inst *inst)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
diff --git a/drivers/media/platform/qcom/iris/iris_common.h b/drivers/media/platform/qcom/iris/iris_common.h
index b2a27b781c9a..34e32c60f768 100644
--- a/drivers/media/platform/qcom/iris/iris_common.h
+++ b/drivers/media/platform/qcom/iris/iris_common.h
@@ -11,6 +11,7 @@ struct iris_buffer;
 
 int iris_vb2_buffer_to_driver(struct vb2_buffer *vb2, struct iris_buffer *buf);
 void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf);
+int iris_set_core_id(struct iris_inst *inst);
 int iris_process_streamon_input(struct iris_inst *inst);
 int iris_process_streamon_output(struct iris_inst *inst);
 int iris_session_streamoff(struct iris_inst *inst, u32 plane);
diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index b396c8cf595e..54a8649841e4 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -30,6 +30,11 @@ enum domain_type {
 	DECODER	= BIT(1),
 };
 
+enum iris_vcodec_core_id {
+	IRIS_VCODEC0 = 1,
+	IRIS_VCODEC1,
+};
+
 /**
  * struct iris_core - holds core parameters valid for all instances
  *
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
index 3edb5ae582b4..fbaf852a6b99 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
@@ -124,6 +124,7 @@ struct iris_hfi_command_ops {
 	int (*session_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_close)(struct iris_inst *inst);
+	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
 };
 
 struct iris_hfi_response_ops {
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 30bfd90d423b..9d9fae587297 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -1300,6 +1300,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
 					inst_hfi_gen2->packet->size);
 }
 
+static int iris_hfi_gen2_set_core_id(struct iris_inst *inst, u32 core_id)
+{
+	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
+	u32 payload = core_id;
+
+	iris_hfi_gen2_packet_session_command(inst,
+					     HFI_PROP_CORE_ID,
+					     HFI_HOST_FLAGS_NONE,
+					     HFI_PORT_NONE,
+					     inst->session_id,
+					     HFI_PAYLOAD_U32,
+					     &payload,
+					     sizeof(u32));
+
+	return iris_hfi_queue_cmd_write(inst->core, inst_hfi_gen2->packet,
+					inst_hfi_gen2->packet->size);
+}
+
 static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
 	.sys_init = iris_hfi_gen2_sys_init,
 	.sys_image_version = iris_hfi_gen2_sys_image_version,
@@ -1317,6 +1335,7 @@ static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
 	.session_drain = iris_hfi_gen2_session_drain,
 	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
 	.session_close = iris_hfi_gen2_session_close,
+	.session_set_core_id = iris_hfi_gen2_set_core_id,
 };
 
 void iris_hfi_gen2_command_ops_init(struct iris_core *core)
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index cecf771c55dd..600e9dc07669 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -56,6 +56,7 @@
 #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
 #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
 #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
+#define HFI_PROP_CORE_ID			0x030001a9
 
 enum hfi_rate_control {
 	HFI_RC_VBR_CFR		= 0x00000000,
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 16965150f427..dd341ca5be57 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -37,6 +37,7 @@ struct iris_fmt {
  *
  * @list: used for attach an instance to the core
  * @core: pointer to core structure
+ * @core_id: specifies the hardware core on which the session runs
  * @session_id: id of current video session
  * @ctx_q_lock: lock to serialize queues related ioctls
  * @lock: lock to seralise forward and reverse threads
@@ -79,6 +80,7 @@ struct iris_fmt {
 struct iris_inst {
 	struct list_head		list;
 	struct iris_core		*core;
+	u32				core_id;
 	u32				session_id;
 	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
 	struct mutex			lock; /* lock to serialize forward and reverse threads */
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 8995136ad29e..502d7099085c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -258,6 +258,7 @@ struct iris_platform_data {
 	const struct tz_cp_config *tz_cp_config_data;
 	u32 tz_cp_config_data_size;
 	u32 core_arch;
+	bool dual_core;
 	u32 hw_response_timeout;
 	struct ubwc_config_data *ubwc_config;
 	u32 num_vpp_pipe;
diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
index 91aa21d4070e..b72ce5b596b8 100644
--- a/drivers/media/platform/qcom/iris/iris_power.c
+++ b/drivers/media/platform/qcom/iris/iris_power.c
@@ -77,9 +77,9 @@ static int iris_vote_interconnects(struct iris_inst *inst)
 
 static int iris_set_clocks(struct iris_inst *inst)
 {
+	u64 vcodec0_freq = 0, vcodec1_freq = 0;
 	struct iris_core *core = inst->core;
 	struct iris_inst *instance;
-	u64 freq = 0;
 	int ret;
 
 	mutex_lock(&core->lock);
@@ -87,11 +87,14 @@ static int iris_set_clocks(struct iris_inst *inst)
 		if (!instance->max_input_data_size)
 			continue;
 
-		freq += instance->power.min_freq;
+		if (instance->core_id == IRIS_VCODEC0)
+			vcodec0_freq += instance->power.min_freq;
+		else
+			vcodec1_freq += instance->power.min_freq;
 	}
 
-	core->power.clk_freq = freq;
-	ret = iris_opp_set_rate(core->dev, freq);
+	core->power.clk_freq = max(vcodec0_freq, vcodec1_freq);
+	ret = iris_opp_set_rate(core->dev, core->power.clk_freq);
 	mutex_unlock(&core->lock);
 
 	return ret;
diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
index cfc5b576ec56..da8a89d3dd41 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.c
+++ b/drivers/media/platform/qcom/iris/iris_utils.c
@@ -90,40 +90,79 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
 	return NULL;
 }
 
-int iris_check_core_mbpf(struct iris_inst *inst)
+static u32 iris_get_mbps(struct iris_inst *inst)
 {
-	struct iris_core *core = inst->core;
+	u32 fps = max(inst->frame_rate, inst->operating_rate);
+
+	return iris_get_mbpf(inst) * fps;
+}
+
+static int iris_check_and_assign_core(struct iris_inst *inst, bool mbpf)
+{
+	const struct iris_platform_data *platform_data = inst->core->iris_platform_data;
+	u32 max_load = mbpf ? platform_data->max_core_mbpf : platform_data->max_core_mbps;
+	u32 max_session_cnt = platform_data->max_session_count;
+	u32 core0_session_cnt = 0, core1_session_cnt = 0;
+	bool dual_core = platform_data->dual_core;
+	u32 core0_load = 0, core1_load = 0;
+	bool select_core0, select_core1;
 	struct iris_inst *instance;
-	u32 total_mbpf = 0;
+	u32 load, new_load;
 
-	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list)
-		total_mbpf += iris_get_mbpf(instance);
-	mutex_unlock(&core->lock);
+	inst->core_id = 0;
 
-	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
+	list_for_each_entry(instance, &inst->core->instances, list) {
+		load = mbpf ? iris_get_mbpf(instance) : iris_get_mbps(instance);
+
+		if (instance->core_id == IRIS_VCODEC0) {
+			core0_load += load;
+			core0_session_cnt++;
+		} else if (instance->core_id == IRIS_VCODEC1) {
+			core1_load += load;
+			core1_session_cnt++;
+		}
+	}
+
+	new_load = mbpf ? iris_get_mbpf(inst) : iris_get_mbps(inst);
+
+	select_core0 = core0_load + new_load <= max_load && core0_session_cnt < max_session_cnt;
+	select_core1 = dual_core && core1_load + new_load <= max_load &&
+		     core1_session_cnt < max_session_cnt;
+
+	if (select_core0 && select_core1)
+		inst->core_id = (core0_load <= core1_load) ? IRIS_VCODEC0 : IRIS_VCODEC1;
+	else if (select_core0)
+		inst->core_id = IRIS_VCODEC0;
+	else if (select_core1)
+		inst->core_id = IRIS_VCODEC1;
+	else
 		return -ENOMEM;
 
 	return 0;
 }
 
-int iris_check_core_mbps(struct iris_inst *inst)
+int iris_check_core_mbpf(struct iris_inst *inst)
 {
 	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbps = 0, fps = 0;
+	int ret;
 
 	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list) {
-		fps = max(instance->frame_rate, instance->operating_rate);
-		total_mbps += iris_get_mbpf(instance) * fps;
-	}
+	ret = iris_check_and_assign_core(inst, true);
 	mutex_unlock(&core->lock);
 
-	if (total_mbps > core->iris_platform_data->max_core_mbps)
-		return -ENOMEM;
+	return ret;
+}
 
-	return 0;
+int iris_check_core_mbps(struct iris_inst *inst)
+{
+	struct iris_core *core = inst->core;
+	int ret;
+
+	mutex_lock(&core->lock);
+	ret = iris_check_and_assign_core(inst, false);
+	mutex_unlock(&core->lock);
+
+	return ret;
 }
 
 bool is_rotation_90_or_270(struct iris_inst *inst)
diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index bf0b8400996e..5a05f7d65501 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -176,6 +176,10 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto error;
 
+	ret = iris_set_core_id(inst);
+	if (ret)
+		goto error;
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
 		if (inst->domain == DECODER)
 			ret = iris_vdec_streamon_input(inst);
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index 5eb1786b0737..a1ce3cd524a3 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -41,16 +41,20 @@ static void iris_v4l2_fh_deinit(struct iris_inst *inst, struct file *filp)
 
 static void iris_add_session(struct iris_inst *inst)
 {
+	u32 max_session_count = inst->core->iris_platform_data->max_session_count;
 	struct iris_core *core = inst->core;
 	struct iris_inst *iter;
 	u32 count = 0;
 
+	if (inst->core->iris_platform_data->dual_core)
+		max_session_count *= 2;
+
 	mutex_lock(&core->lock);
 
 	list_for_each_entry(iter, &core->instances, list)
 		count++;
 
-	if (count < core->iris_platform_data->max_session_count)
+	if (count < max_session_count)
 		list_add_tail(&inst->list, &core->instances);
 
 	mutex_unlock(&core->lock);

-- 
2.34.1

