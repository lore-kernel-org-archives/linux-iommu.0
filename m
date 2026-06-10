Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2837FF49
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073077; cv=none; b=GmI/tZ+M7fsoJaKppJ5WZHH8tvrac35igwJzT18EhvnUo3pxWmRhM3YJSu4f7sovRwKRXeWQlDuv0RtrP0PmiNg1hc1ddpArdW5drOHe5vhnUqSH4N3ALNMz7OdOTwDlgXUGGKtVCnKK1L1Q+KkklGeBqtfyub4a1NQ4ERZbHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073077; c=relaxed/simple;
	bh=eZe08LYils7VJHeRWvi/TwupXgNXkuXQSLuPGs3j7jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHF3TTB65mvm52c+x0o5pOF21977aEijvWfQODiQrkyyd4z9WSMK0OUHTeF06VaHmkCTC3lfszOmRtNnO7L/DqSGl57SqCcXkrwtYsCJEOzVeDsKQ/PgN/UCRRzUHUpHm3pHbDRMHQi1jZrSUP+G+6Wc8JftvwBHKc+sjiitqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JTFq6OBL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e6Zs6gZV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTFq6OBL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e6Zs6gZV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2ehrl2481623
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qn5ubFM57GUQtxxuG0B29OBceMOEOEAhB6ohm3+dMFw=; b=JTFq6OBLAtx9XSE4
	3XwnmD3KDV58Ny/rEmHZ4E5FC/BiDaZLBmhrewwzkdAV/7Fai+IYvXXjVxUs19DQ
	Gx5zr/WlkQgG5S+qS7OKN75mCrKO92geLm1qZfDcT1jUFL/OXkUrKz/mw71+v0QG
	18GaZHrHtAqavq689sULUUuM1uYHmNroSGPJ1tYaziiqLlVyw8+N6qSiVWNXodP2
	ZNzkMYDW4CNfXOV+F+OJU8Wkh10BqmjI1QfRvqSB79Io5eAdwXAw/B3TrqBTIngL
	FwVJ0ayKffZo+OCRfIH2qrFOfnpcpNj15yNHZiYoO7Ba/waZsGDNVWZU2o1aUAvr
	aE5GkQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnes2h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so7101454a91.3
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073067; x=1781677867; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn5ubFM57GUQtxxuG0B29OBceMOEOEAhB6ohm3+dMFw=;
        b=e6Zs6gZVKDTTeulWBZ/I4seGR5mr0AShLwBu+kakIujeUUm9w56ef0P09cK6NpNjwO
         EJNjevR+oJavwLJHzNPvNyfQN/xxIAcOqbDQlfZWloNg5RGm3VJ8vwiIpv/ZklkTcTO5
         lu83izb9B+mDDNQ6wH/+K9J5I2h7xHbdzEwINBxHJ65W+f+WdC7hgPYB9Gmq9YT3NkMb
         pX2t7pvFXMWQY3o5GJGj2TdzAt+Z7U1zFVw7gksRxY5r0L3+Xxh7qM9fjVz3dqY1D9PT
         TjIKyXOWcTgjWelpMEIvu3galV6pEPk+CO8xhZ8H9pknJOaLEw6X1jBqk2vj/x0xjH3W
         IeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073067; x=1781677867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qn5ubFM57GUQtxxuG0B29OBceMOEOEAhB6ohm3+dMFw=;
        b=jScoEDReq2HFP/kPeAxW6U836+L82R4ngMaTyVE7zLgyNq6lJBtDnPOC3jW7uM59xP
         2Xax7+xwosLukmVBKX9G7jSUdl8QTQY9P9/nMgTYlQ/aGaTJMmpswTbiFRoxAXtOPfx1
         ytH8nZjOe1Z5iDEVkWrhPNJRWBNeFWHEHxYBjVRC58VclJzffB2AEBdGOT/qCK6ZdLuI
         m/Us/dLBNquIH7R4aHe7tnnSWdiVJXQ6VWvGlKwBeBGplMFxvtpRorOcxdWdvNZ+MEsy
         iuuQqy6nZDYTF1NCIh+8ROKc8bWKPG4rEYhzZ//2AC1OcXq4vcdMnUNKS3IXc++U3HlU
         1bCA==
X-Forwarded-Encrypted: i=1; AFNElJ/0yknvi/cktZGHFRtn0Og6V9DWf0lsE+zrxJ1bJp79UehvHs6X8ONSpJ+MWjwD5GkEPg0luA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/Vs56QNO0asRBWXDrPN1AssWUoHVxJ1Nc98BM3lXWQAJx9OuL
	m4+xqvqzFg9OjvdpMa0BHDhKOzrmYw+ufLrKv/z5KEodPwFgPCPzzcLB8XQToHjAeK4/xysVb2H
	jvcJ1OQ7Ot5uikWh5UAHhgPbekVaBIL87LeI5xlFTC8D3P+0pv+lwzyo7tA==
X-Gm-Gg: Acq92OHtCzrpyNlT44NAX4ajyKa7nAaJm7uD6WBHzGV3RqYXsup83r0WUjEBKa8UQzi
	I1J8/EXmwRDtrQ0j0TrZagg8DLxB14l9wEnHOazqvyovEsTFbRutIot/yD2IXWJtz+9ux68cJp7
	0KMEMBTYOYpBBDa6XW88goWPK3wQK/MiTfk6URVJyebJznNglJqv9qSQ/XwcstoPOLoXqeDr8z6
	/JeIjx4iwfEtA+BGiweILIGOMujaFbfaPHppXDUmaz3H/bSM+HLLyvYowieTFk9Gzmwc+DBaA6K
	UrX7yLrBl/+XjMmwDdQl5YnVeH/IO7N2IXpbIC0tUkxe/uApYr+1HTF0leJjc3wzhSNf9LF2xu/
	D5+8YTIJH/xoXLSWPLfgdkiXGqsalwsIHSlo1vCK5mxyzTgCAYtJcRySOLt3S/B1khw==
X-Received: by 2002:a17:90b:3503:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-370ee830376mr22936723a91.3.1781073067291;
        Tue, 09 Jun 2026 23:31:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3503:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-370ee830376mr22936671a91.3.1781073066570;
        Tue, 09 Jun 2026 23:31:06 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:31:06 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:45 +0530
Subject: [PATCH v8 09/12] media: iris: Add support to select core for dual
 core platforms
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-9-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=17586;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=eZe08LYils7VJHeRWvi/TwupXgNXkuXQSLuPGs3j7jM=;
 b=qARsqsP1AalRQsXPXKSrJdUwoPOhHIYRIoakz9xdzJPv5WCWPeeCvgOjd+a724YepPU1WpfjV
 CvrW5fBrCm9CmkBQ4uC0OSl3k9YZ+GvRSRW6cL7WT6qRXL3xRfALIs1
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: qjGjjN3y6g8SNt6uiEW8Dp6MlCO0wQBk
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a2904ae cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-5uF22sGoL6VU8B926sA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: qjGjjN3y6g8SNt6uiEW8Dp6MlCO0wQBk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX5pYiuYLJk7jH
 Odf8jrvtEzxhRB72nztPAbkTRmT09+5iKsNDe9xvvrwGUL71eNgLb1nwXxs/RN5dzeMQxu/xu2L
 qP8Xte+VHkRFPbNNECQUU3MJd1z/Ku1iLGdIeKMWx85N26vGYIpKLQIxEUNfbmBAA+fH3Dw6q0y
 YekIbEfrmrv8Z5+DBl/R27Tj9zJJic24pBAVo9JteYqkii9ee9LZq2VaXyNGxnYwy1TXSnexIP/
 //uTZFP8zZxjGdEY4KDoovN1B6mmMEd6Sl8hLnc5QD/jpKjgvvL6WfZJq10Qku2pDaxngIyqwE2
 iX1LRKdITp1DmH3JTBrSI5w4D6fwtBnOGnxskKbo6qn70ZL29d3lkNFzAH5gvOU5cqZwoGS+A4g
 hsZEISLBdjiLO/jkKjyMTRPAgmcjvg+kfZAanF59cCwYEq9ctTaZrOBjrN//Yi8wjAlX9g5nBOl
 436huQ46AT0bw3UML1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100059

On platforms with two video codec cores, select the hardware core for
a new session based on the current Macroblocks Per Frame (MBPF) and
Macroblocks Per Second (MBPS) load on each core. The selected core is
communicated to the firmware via the HFI_PROP_CORE_ID property at
stream-on time.

Since both cores share the same clock source, the required clock
frequency is the maximum of the aggregated frequencies across both
cores.

The total session count limit is scaled by the number of cores, since
each core independently supports sessions up to its own limit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_common.c     | 10 ++++
 drivers/media/platform/qcom/iris/iris_common.h     |  1 +
 drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
 drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 +++++++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
 drivers/media/platform/qcom/iris/iris_power.c      | 20 +++++--
 drivers/media/platform/qcom/iris/iris_utils.c      | 58 +++++++++++++-------
 drivers/media/platform/qcom/iris/iris_utils.h      |  3 +-
 drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
 drivers/media/platform/qcom/iris/iris_vidc.c       |  6 ++-
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 63 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 +
 14 files changed, 171 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 25836561bcf3..abea6807a59e 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	inst->metadata_idx++;
 }
 
+int iris_set_core_id(struct iris_inst *inst)
+{
+	const struct iris_hfi_session_ops *hfi_ops = inst->hfi_session_ops;
+
+	if (!inst->core_id)
+		return 0;
+
+	return hfi_ops->session_set_core_id(inst, inst->core_id);
+}
+
 int iris_process_streamon_input(struct iris_inst *inst)
 {
 	const struct iris_hfi_session_ops *hfi_ops = inst->hfi_session_ops;
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
index 8c36b64153c7..84d4bc32e406 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -37,6 +37,11 @@ enum domain_type {
 	DECODER	= BIT(1),
 };
 
+enum iris_vcodec_core_id {
+	IRIS_VCODEC0 = 1,
+	IRIS_VCODEC1,
+};
+
 struct qcom_ubwc_cfg_data;
 
 /**
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
index a27447eb2519..47786529998d 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
@@ -131,6 +131,7 @@ struct iris_hfi_session_ops {
 	int (*session_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_close)(struct iris_inst *inst);
+	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
 };
 
 struct hfi_subscription_params {
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index ca2954f8bd3a..e73743a391e0 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -1360,6 +1360,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
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
 static const struct iris_hfi_session_ops iris_hfi_gen2_session_ops = {
 	.session_open = iris_hfi_gen2_session_open,
 	.session_set_config_params = iris_hfi_gen2_session_set_config_params,
@@ -1373,6 +1391,7 @@ static const struct iris_hfi_session_ops iris_hfi_gen2_session_ops = {
 	.session_drain = iris_hfi_gen2_session_drain,
 	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
 	.session_close = iris_hfi_gen2_session_close,
+	.session_set_core_id = iris_hfi_gen2_set_core_id,
 };
 
 static struct iris_inst *iris_hfi_gen2_get_instance(void)
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index 776b21cd11b2..2e374c2005ef 100644
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
index a770331d1675..585aa7c51fb0 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -36,6 +36,7 @@ enum iris_fmt_type_cap {
  *
  * @list: used for attach an instance to the core
  * @core: pointer to core structure
+ * @core_id: specifies the hardware core on which the session runs
  * @session_id: id of current video session
  * @hfi_session_ops: iris HFI session ops
  * @ctx_q_lock: lock to serialize queues related ioctls
@@ -83,6 +84,7 @@ enum iris_fmt_type_cap {
 struct iris_inst {
 	struct list_head		list;
 	struct iris_core		*core;
+	u32				core_id;
 	u32				session_id;
 	const struct iris_hfi_session_ops	*hfi_session_ops;
 	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
index 91aa21d4070e..a875647b3162 100644
--- a/drivers/media/platform/qcom/iris/iris_power.c
+++ b/drivers/media/platform/qcom/iris/iris_power.c
@@ -75,14 +75,12 @@ static int iris_vote_interconnects(struct iris_inst *inst)
 	return iris_set_interconnects(inst);
 }
 
-static int iris_set_clocks(struct iris_inst *inst)
+static u64 iris_get_required_freq(struct iris_inst *inst)
 {
 	struct iris_core *core = inst->core;
 	struct iris_inst *instance;
 	u64 freq = 0;
-	int ret;
 
-	mutex_lock(&core->lock);
 	list_for_each_entry(instance, &core->instances, list) {
 		if (!instance->max_input_data_size)
 			continue;
@@ -90,6 +88,22 @@ static int iris_set_clocks(struct iris_inst *inst)
 		freq += instance->power.min_freq;
 	}
 
+	return freq;
+}
+
+static int iris_set_clocks(struct iris_inst *inst)
+{
+	const struct vpu_ops *vpu_ops = inst->core->iris_platform_data->vpu_ops;
+	struct iris_core *core = inst->core;
+	u64 freq;
+	int ret;
+
+	mutex_lock(&core->lock);
+	if (vpu_ops->get_required_freq)
+		freq = vpu_ops->get_required_freq(inst);
+	else
+		freq = iris_get_required_freq(inst);
+
 	core->power.clk_freq = freq;
 	ret = iris_opp_set_rate(core->dev, freq);
 	mutex_unlock(&core->lock);
diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
index ba5c8dc1280c..4608e3f28832 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.c
+++ b/drivers/media/platform/qcom/iris/iris_utils.c
@@ -7,6 +7,7 @@
 #include <media/v4l2-mem2mem.h>
 
 #include "iris_instance.h"
+#include "iris_vpu_common.h"
 #include "iris_utils.h"
 
 bool iris_res_is_less_than(u32 width, u32 height,
@@ -23,7 +24,7 @@ bool iris_res_is_less_than(u32 width, u32 height,
 	return false;
 }
 
-int iris_get_mbpf(struct iris_inst *inst)
+u32 iris_get_mbpf(struct iris_inst *inst)
 {
 	struct v4l2_format *inp_f = inst->fmt_src;
 	u32 height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
@@ -32,6 +33,13 @@ int iris_get_mbpf(struct iris_inst *inst)
 	return NUM_MBS_PER_FRAME(height, width);
 }
 
+u32 iris_get_mbps(struct iris_inst *inst)
+{
+	u32 fps = max(inst->frame_rate, inst->operating_rate);
+
+	return iris_get_mbpf(inst) * fps;
+}
+
 bool iris_split_mode_enabled(struct iris_inst *inst)
 {
 	return inst->fmt_dst->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_NV12 ||
@@ -101,40 +109,52 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
 	return NULL;
 }
 
-int iris_check_core_mbpf(struct iris_inst *inst)
+static int iris_check_core_load(struct iris_inst *inst, bool mbpf)
 {
-	struct iris_core *core = inst->core;
+	const struct iris_platform_data *platform_data = inst->core->iris_platform_data;
+	u32 max_load = mbpf ? platform_data->max_core_mbpf : platform_data->max_core_mbps;
 	struct iris_inst *instance;
-	u32 total_mbpf = 0;
+	u32 total_load = 0;
 
-	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list)
-		total_mbpf += iris_get_mbpf(instance);
-	mutex_unlock(&core->lock);
+	list_for_each_entry(instance, &inst->core->instances, list)
+		total_load += mbpf ? iris_get_mbpf(instance) : iris_get_mbps(instance);
 
-	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
+	if (total_load > max_load)
 		return -ENOMEM;
 
 	return 0;
 }
 
-int iris_check_core_mbps(struct iris_inst *inst)
+int iris_check_core_mbpf(struct iris_inst *inst)
 {
+	const struct vpu_ops *vpu_ops = inst->core->iris_platform_data->vpu_ops;
 	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbps = 0, fps = 0;
+	int ret;
 
 	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list) {
-		fps = max(instance->frame_rate, instance->operating_rate);
-		total_mbps += iris_get_mbpf(instance) * fps;
-	}
+	if (vpu_ops->check_core_load)
+		ret = vpu_ops->check_core_load(inst, true);
+	else
+		ret = iris_check_core_load(inst, true);
 	mutex_unlock(&core->lock);
 
-	if (total_mbps > core->iris_platform_data->max_core_mbps)
-		return -ENOMEM;
+	return ret;
+}
 
-	return 0;
+int iris_check_core_mbps(struct iris_inst *inst)
+{
+	const struct vpu_ops *vpu_ops = inst->core->iris_platform_data->vpu_ops;
+	struct iris_core *core = inst->core;
+	int ret;
+
+	mutex_lock(&core->lock);
+	if (vpu_ops->check_core_load)
+		ret = vpu_ops->check_core_load(inst, false);
+	else
+		ret = iris_check_core_load(inst, false);
+	mutex_unlock(&core->lock);
+
+	return ret;
 }
 
 bool is_rotation_90_or_270(struct iris_inst *inst)
diff --git a/drivers/media/platform/qcom/iris/iris_utils.h b/drivers/media/platform/qcom/iris/iris_utils.h
index 228a5f963812..c36ac494f461 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.h
+++ b/drivers/media/platform/qcom/iris/iris_utils.h
@@ -43,7 +43,8 @@ static inline enum iris_buffer_type iris_v4l2_type_to_driver(u32 type)
 
 bool iris_res_is_less_than(u32 width, u32 height,
 			   u32 ref_width, u32 ref_height);
-int iris_get_mbpf(struct iris_inst *inst);
+u32 iris_get_mbpf(struct iris_inst *inst);
+u32 iris_get_mbps(struct iris_inst *inst);
 bool iris_split_mode_enabled(struct iris_inst *inst);
 bool iris_fmt_is_8bit(u32 pixelformat);
 bool iris_fmt_is_10bit(u32 pixelformat);
diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index a2ea2d67f60d..dbb89396e651 100644
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
index 14d63dc76c9b..059d020f28c3 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -41,16 +41,20 @@ static void iris_v4l2_fh_deinit(struct iris_inst *inst, struct file *filp)
 
 static void iris_add_session(struct iris_inst *inst)
 {
+	const struct iris_platform_data *plat = inst->core->iris_platform_data;
+	u32 max_session_count = plat->max_session_count;
 	struct iris_core *core = inst->core;
 	struct iris_inst *iter;
 	u32 count = 0;
 
+	max_session_count *= max(plat->num_cores, 1);
+
 	mutex_lock(&core->lock);
 
 	list_for_each_entry(iter, &core->instances, list)
 		count++;
 
-	if (count < core->iris_platform_data->max_session_count)
+	if (count < max_session_count)
 		list_add_tail(&inst->list, &core->instances);
 
 	mutex_unlock(&core->lock);
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index bafa2ab645b1..dc491a5aecf5 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -318,6 +318,67 @@ static void iris_vpu36_program_bootup_registers(struct iris_core *core)
 	writel(0x0, core->reg_base + CPU_CS_SCIACMDARG3);
 }
 
+static int iris_vpu36_check_core_load(struct iris_inst *inst, bool mbpf)
+{
+	const struct iris_platform_data *platform_data = inst->core->iris_platform_data;
+	u32 max_load = mbpf ? platform_data->max_core_mbpf : platform_data->max_core_mbps;
+	u32 max_session_cnt = platform_data->max_session_count;
+	u32 core0_session_cnt = 0, core1_session_cnt = 0;
+	u32 core0_load = 0, core1_load = 0;
+	bool select_core0, select_core1;
+	struct iris_inst *instance;
+	u32 load, new_load;
+
+	inst->core_id = 0;
+
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
+	select_core1 = core1_load + new_load <= max_load && core1_session_cnt < max_session_cnt;
+
+	if (select_core0 && select_core1)
+		inst->core_id = (core0_load <= core1_load) ? IRIS_VCODEC0 : IRIS_VCODEC1;
+	else if (select_core0)
+		inst->core_id = IRIS_VCODEC0;
+	else if (select_core1)
+		inst->core_id = IRIS_VCODEC1;
+	else
+		return -ENOMEM;
+
+	return 0;
+}
+
+static u64 iris_vpu36_get_required_freq(struct iris_inst *inst)
+{
+	u64 vcodec0_freq = 0, vcodec1_freq = 0;
+	struct iris_core *core = inst->core;
+	struct iris_inst *instance;
+
+	list_for_each_entry(instance, &core->instances, list) {
+		if (!instance->max_input_data_size)
+			continue;
+
+		if (instance->core_id == IRIS_VCODEC0)
+			vcodec0_freq += instance->power.min_freq;
+		else
+			vcodec1_freq += instance->power.min_freq;
+	}
+
+	return max(vcodec0_freq, vcodec1_freq);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -354,4 +415,6 @@ const struct vpu_ops iris_vpu36_ops = {
 	.program_bootup_registers = iris_vpu36_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu36_set_hwmode,
+	.check_core_load = iris_vpu36_check_core_load,
+	.get_required_freq = iris_vpu36_get_required_freq,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index e2e3e66574fa..0aebe3c74f00 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -25,6 +25,8 @@ struct vpu_ops {
 	int (*set_hwmode)(struct iris_core *core);
 	int (*init_cb_devs)(struct iris_core *core);
 	void (*deinit_cb_devs)(struct iris_core *core);
+	int (*check_core_load)(struct iris_inst *inst, bool mbpf);
+	u64 (*get_required_freq)(struct iris_inst *inst);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);

-- 
2.34.1

