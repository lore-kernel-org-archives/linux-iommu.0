Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8F3E5EE7
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621320; cv=none; b=f2SAA4RSvSjMMcG1KNX/5XYQ4mfEbhoHfZp5AU9bTYP3NKroxzoysey8+Xqx8aJ6r7EBQ1C2ZG9BPg+tra4+AjlDrKhyyhNNKOUQHPL2ybhJMc6B5r9sRj40WX8OfiK9dg7iNsENG9qG+Sd8g2PwT/fDX3amXLipCM/Zpm39xnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621320; c=relaxed/simple;
	bh=MFjdCiIFtje0IFKh3Xra6G/jDUvrMtnFOLx7XQIfVYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BO4fW1UP96DF2F52rzcPAXho3u9SuZw3shj60Mo3wOREdxIZCERFrajJ2I9auR3bmUe92wQO10hvEMMsK0d3PGtCqOYHCtPMi/InGeT/9hc2Jb0PTeO400QBII6MdXsT4JG+1c2eiATpSliOTK3uTki9jJrTSBtDMe+nQMUVooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGw1wujX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjYbzJy2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGw1wujX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjYbzJy2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMkuXT2600368
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	70cmDDdanj723Xy7ZFiRtQ56r/+2UB1pDkcwqs2pWtk=; b=bGw1wujXn59mzaAt
	dWgkIjLLuYmvTIz8OHryhzWKV6s0h2sjvdL9YW5mgXg8BamysMQO6M8fjLnnaoaK
	BS5T8hQECbMLzDM/bK9sLmu3j66f2vqVbXFD2eQ3CT4/QIBrL3S8vy08sVHwl4be
	5zMHEAS/1/OofeKqWhEUk6CuNtQNdR0XBEy7oEVeWM3v/7apPCwIYRZLelYcA+Pv
	n3X4yRm9IvUdrg5KhtRyjOg4nwWecEF642ozHy4A+u4WINhDsfiAPBrvyKoKyKqp
	u1DCQ4qTc3vLQNVmxp4y+sboFVyMyxjcb8WBkQjrPYjtn8myIgh+nzN6KsXvisZ3
	g9a18w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb3kkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:57 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c307941971so656276b6e.1
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 22:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789621317; x=1790226117; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70cmDDdanj723Xy7ZFiRtQ56r/+2UB1pDkcwqs2pWtk=;
        b=DjYbzJy2DXtMTZatk18AoPSbZh/YfkAS45L9YDYP/au5xE6VOw9FVADOzvjCR1NVmE
         pjX4lYJ+UBtzXY82WFHcGHO/d5AudvQRlGGHb2b6+3jWfG0KmCoBIJznWUnCSWPHn16Z
         RXAAdxZKycrW8OyaJQvIaljsOZ9wzkStp6UY+vTHTIAbWQ5VW6Z8XqS/Hj2Nka0habgJ
         +q6c1520AOEPcUAD6SSkcRw5QIqj1W4hTg3t3PaZICLK/AElNMu6MLwa3Q6kDULJYSTF
         /RM/uPl2Zsd5S8wM49PEZShjPTqaAqSXGTXqOYPnyl91ErILvY2/aJbduEY7yUuOXkIF
         ZYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621317; x=1790226117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70cmDDdanj723Xy7ZFiRtQ56r/+2UB1pDkcwqs2pWtk=;
        b=hSd6SeAncUrHaHuq6UeSzgMx/5NPtjI4TGW0bZZLZhXjkqw9RKYHqf9Hmb5PdzpiAd
         kO/ULiUL4FByVY/Jdn/7hKCoASC7eWK/5NuuPJ08iulYSFa/C7+4ZxTDYen1NpSABhpc
         IAPDKUBRkbWU5D/G+WS24QyIR5rMCMT4oc1wm7o6gmvuhrZaN2fHpbtVjsi1DHzzV82l
         heN+HYToQ0s1AScKu4QxLzbdTa9b1SOeLiInkqlnN9EDz/pwmlN2LMLgOSXGs59/Be2A
         S1BfD9sfehfY+dEVQH/MZ9/84LT8Y3bmG0F24u0HQwBgpB0i3wUJOlDXMSsK1bukwR/Q
         z9WA==
X-Forwarded-Encrypted: i=1; AKwUvBxjoiwhQHd8bLZ6OaGr9N7JIB9000cfeVFIERJ7uWxzqM0pTdchqrz60OlJ1quAwrr+//4gCg==@lists.linux.dev
X-Gm-Message-State: AFuF++npd59Nwcen/KTI6FiNM5YzyB439ZelmCg44BppF5pvhkn/vGtO
	j2Tz40FdbOS5MiB1HCHle6HnpQk8yoT18BuVmBETKxGNIHfw8C8ptV3tJFKSK7sYK/DcXiWtu00
	KomXo8k3P3HFa/5sb+46P/o8ZQUezXQ49J62jA75aQFwUW/UsZ4GOsv8jxA==
X-Gm-Gg: AYBFou1fpju7Cp/ADLvxudNmWS21GEh9Rz17iMMzqUuVZGVxGyCBL6KKVje12/hJSSM
	nxiUSFDdb5EVCt/0ewWSGEVyM/znxZosXKg/criS1V/2K+xyR6RZy/rEYJIYSVlDFnCr49loVzB
	bSu7OyM8NlrY8Rmlb+jqutVIYD5jEC91AShwpKUKgLq/9ZCtEWsCWQydNLKNpmlsbcJm2rdMS9o
	BThTpvWWQnDB7FpjHvow4ytkhQB/NLMFLncgnwBrKMVdxhgupTxLGDNZHAqHmYW3Vrlt0tEiNtv
	CL+bKpi3OU3k+kOKL7Rz2REpaclejNXVoPpKH74yLxw7Uy2MoN16nsYhCGtuCZY5LX3eLPydLa6
	xpjoVGas358WW79SCJpMDJF0GhEP24zkrnA==
X-Received: by 2002:a05:6808:5190:b0:4b9:a829:f00b with SMTP id 5614622812f47-4ca4bc70415mr5950472b6e.23.1789621316747;
        Wed, 16 Sep 2026 22:01:56 -0700 (PDT)
X-Received: by 2002:a05:6808:5190:b0:4b9:a829:f00b with SMTP id 5614622812f47-4ca4bc70415mr5950437b6e.23.1789621316147;
        Wed, 16 Sep 2026 22:01:56 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm23544223eec.31.2026.09.16.22.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:01:55 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:30:25 +0530
Subject: [PATCH v11 6/9] media: iris: Add support to select core for dual
 core platforms
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-glymur-v11-6-e0c8bc914742@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789621265; l=17834;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=MFjdCiIFtje0IFKh3Xra6G/jDUvrMtnFOLx7XQIfVYc=;
 b=CopaY4iQnvpcvfW9Gy9KQl1/ZtBtGOvoz2JiUQNLyBgPyfFMB4xgFxyARyejFBejEDFHjGiwv
 ci601l4d2IcBJpgHEAz/9xkPCCznt8T+wlfUYdwWbs7gF/M60e5jrZx
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab7445 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-5uF22sGoL6VU8B926sA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: QW9tUE70-ZfqXqeOr7pxgCGX6MDY2uhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfXxR/IttA/t2N8
 ZjnYT6EdyIpQpCQ1gZYD+ZvyAJL6oYIVVrCbAjpwzqaeGeFSM3+xlJW6ccWorxtAIv6avixoVJs
 Z4QG6Mt4yG05y3E1QkzMdTANZzf7CorYUC4T7MaLp+8Is+CcEQ0fnlr16fdfTwuDzJ7ZKoG6amh
 JDqCSVoBuDJ2hkLpo4vm2/f8pOA030whrMwGefjDst832PSBRqc6zZN+YOVP53WX9ibpYmk9B77
 BHJumezkelaa90x+xsF5stNAR90euonRS5Dnv0m3D0Byb2ByTn022GDOg2AWGj90zYGcLa0A4ZG
 rE9JN67JtArOZHyvqIMuMN6skieVV7yULTvFpE3NR44ynW4GGtEc4vSjQLIeXNhE86+suts7Y++
 5e3RnbHp+oI8ND3gX/+mHUJm85KRiYNWMvIopmbDUW9S3T3uMSPY2m8W8dErxa2s/dnZg9U+Wmn
 qfC4cNFfAjgKZRTLuBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX4wXzyxWZS1vY
 KzTouHhOwITwnslcuZmpenFXlwOLUmPSsAS2Mm7lu6HsxUYkC50v1YJaf6E7UaoiVOwddfVEPP4
 koKOA1+UPQ/qHrnwrYdINtvetK/x7xc=
X-Proofpoint-ORIG-GUID: QW9tUE70-ZfqXqeOr7pxgCGX6MDY2uhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170063

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
 drivers/media/platform/qcom/iris/iris_power.c      | 20 ++++++-
 drivers/media/platform/qcom/iris/iris_utils.c      | 58 ++++++++++++-------
 drivers/media/platform/qcom/iris/iris_utils.h      |  3 +-
 drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
 drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 66 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 +
 14 files changed, 174 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 25836561bcf3..4e1e7d38e3fb 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	inst->metadata_idx++;
 }
 
+int iris_set_core_id(struct iris_inst *inst)
+{
+	const struct iris_hfi_session_ops *hfi_ops = inst->hfi_session_ops;
+
+	if (!inst->core_id || !hfi_ops->session_set_core_id)
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
index f528f53f20fc..cf75e53524b0 100644
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
index 388a36ff2b07..b071980ddd27 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -1359,6 +1359,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
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
@@ -1372,6 +1390,7 @@ static const struct iris_hfi_session_ops iris_hfi_gen2_session_ops = {
 	.session_drain = iris_hfi_gen2_session_drain,
 	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
 	.session_close = iris_hfi_gen2_session_close,
+	.session_set_core_id = iris_hfi_gen2_set_core_id,
 };
 
 static struct iris_inst *iris_hfi_gen2_get_instance(void)
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index f43aea10090d..2b70649d7e3e 100644
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
index 064cf0a80748..79523e42f344 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -42,16 +42,20 @@ static void iris_v4l2_fh_deinit(struct iris_inst *inst, struct file *filp)
 
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
index f3c4ee2c4003..375defbb9594 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -334,6 +334,70 @@ static void iris_vpu36_program_bootup_registers(struct iris_core *core)
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
+	if (inst->core_id == IRIS_VCODEC0)
+		return core0_load <= max_load ? 0 : -ENOMEM;
+	else if (inst->core_id == IRIS_VCODEC1)
+		return core1_load <= max_load ? 0 : -ENOMEM;
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
+		else if (instance->core_id == IRIS_VCODEC1)
+			vcodec1_freq += instance->power.min_freq;
+	}
+
+	return max(vcodec0_freq, vcodec1_freq);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -370,4 +434,6 @@ const struct vpu_ops iris_vpu36_ops = {
 	.program_bootup_registers = iris_vpu36_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu36_set_hwmode,
+	.check_core_load = iris_vpu36_check_core_load,
+	.get_required_freq = iris_vpu36_get_required_freq,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 63bf0cec58e2..0de715bd810d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -23,6 +23,8 @@ struct vpu_ops {
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 	int (*set_hwmode)(struct iris_core *core);
+	int (*check_core_load)(struct iris_inst *inst, bool mbpf);
+	u64 (*get_required_freq)(struct iris_inst *inst);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);

-- 
2.34.1

