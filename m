Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8782FD69A
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142888; cv=none; b=f77FgcDLfa/RXVTDX3mMPtfW28xch4wTEMcWhKA5KVTfvOZCnOW54NDby+THd5eOE10sVgjj/SkaV1HnX6jTSlyBgBgdQAVkQdYk3QRF4l1FeW3OqUen3VPHQoOPSwVjzFAh5qRe9KoZySYBdcYIF/fNqMkSh5LslTn2JyNIysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142888; c=relaxed/simple;
	bh=Na5TubomgVuDD7yKf84igivMKpdfxkQPlVnbL5NqEQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgjIaNp8zcZn4hEmc6Xb5cs9euY9w6x9JqDhKHhhL/2EYDcW3DYiYeusq2GXgpGRz3yZ2qIYDCDz2gTPXH55WfwaruBNhuq8qrVf/YrAcS15Lz7F+/lKSlsze8fvRVmvYNLFEYHQlFDFSShJzESh19rViZAp8enh9CBtWKthIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cVbK0L6/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vjde29UZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVbK0L6/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vjde29UZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCZjd280927
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LmFJLF69G/HzboWBVC7yI7ZUIn4bIbcDXzoAqxDyCG8=; b=cVbK0L6/coVs0Ggt
	LVPO+Falsz8Xh1rA6o2TK4F+FyiUYskjFwQ6eU8JWRGkMH1Loz/qMsH+iSnbgLWK
	ICDirvKkkeN+Qt1jmHlZXfcE2GrFcv5jDXRCklDkYX1Jwuce9DzPpaCSNMXlzO4m
	ES7EKW9yKSBgAkM3rK01lEHBGUYc32xbg0ykAH8wRRPkiLCOKieE9QvkvoAEG2lk
	kgo1es4nHjd+dmbL+b8GSVzHhOy5QSMT/VJKG8HshbE7DoEnsItp+1m4DWGDaN+H
	Jgdyq7rI1n0myI/VWT0GBvXZgHQ6KQ5lXGfJPbBgLQT/e6v4iuLxApqIwLUCXkM2
	2DCgnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vh22v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2eba42b8dso19576515ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142885; x=1776747685; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmFJLF69G/HzboWBVC7yI7ZUIn4bIbcDXzoAqxDyCG8=;
        b=Vjde29UZNSgEMGbSClwm+VemeQz+B+z76Dz9IhyIBEN2yHKJHAVAC3uvCefMTYUwco
         vKKO/zE7sS46IlcElbJ1h7voTzCzKIlgX/8qyTfxyBYVXsrATKyeadk/CJElusDpGSDL
         VeLmHbwnLodJYW4EnRcaZYWu+BCSG2cfkrN7pRpu2VVv44p3nN8OHMnG6NXolRlsGf7C
         hV5V6fAY8tQX+qRq48GnjHB7WidJyJoqPpFnsbpx50A9dXoNotRZCJWD858hTMGsyuAx
         4BOzZOAmBvr3l2xtEKJ2mtj6jCkzR7aXpV7sdCWchWYtqVdK2REc2O4WBK3oiiZ3vuEz
         EaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142885; x=1776747685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LmFJLF69G/HzboWBVC7yI7ZUIn4bIbcDXzoAqxDyCG8=;
        b=T0kX7MYfzH2UzilfwKSLwaDCUuuD1XXUJxaHFcpMYHK3gTbRlU/5Nr/nTbQXzm3BXh
         cUxwMX1hN6GQkVASwEi8Nm8A8zv0RTC89An+3BAd99M5hGa1exK1hxKfLm965mCUUroT
         ONYpnJl0Ueh/eSubXbNsfEAao6kbMxYEHQ9EQhtRblmkQc10dAoNlrK0BIf3tVWy0BGn
         iub2VCSrWY8Ka/E6QBfkLfrv9UZ8tARc7Ax1l6zHbEnFSy/9Zt5mzNPvvhxVZ/ji4uGj
         AZVkUa695xis7EQNgjnqNioOkMtnExD2ugGpzA6qV+Mp7f558qCNq+1Ueb4UmnUmJfd1
         QMSA==
X-Forwarded-Encrypted: i=1; AFNElJ8Yo0hJA2+aU5nCCMgCzLMWidR5KVvCTlsKxNRUooxuJkp3q4lsN0fAf9+CdGqhRTkmCtBsSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS1Epbvod14l6Ydr2lOVLvC8OWouWB8vXaLqz0jU5xors9dBsx
	kp2zgs6lXQ3/bKl0xzhiNdwelMS8RwoJtKS95UrGJIPJaSaKN4ttOgOIimAD0uKSkaVMO1ilERc
	9XMIi4DbXqH9yF0VGk9Ym+5cn9+Sa5eQpYXkumN69CUqCiFAQ9tuz8M6mRw==
X-Gm-Gg: AeBDieubumUHhS3JnK7iSIh1a/Fc9yhIbF3qTicedz4/6rO26MjW+DKF56RNrVwIJGh
	cGl7xXOmDFFXmENvPhSECSl4M7cvRCS1tZu+sUp0tPmTcK8hZ3E3Sa/IqDmWc44/hhtSmpG+wub
	Kw2L2mnnETipYEGOLZVk061Iy4uSQJDwTIpNeHMZKN5ByJLvQXng4fApEpWgR06xzGJeUQitDyj
	lzgEBfVa40ryJT+Nk0UbfFwJhXNh33yKJa9k0VsZcvHe8pifILWgzUkWfQzj9AISn0n8s0jR8mQ
	B3uQEJcf2wqBIeqf2ai9xctml62JSc3VeMZUa/VW5ioOoDDE98pcSvG0WCUMgvv1SuS2Lr+2wy1
	gq2lgy3neaW99t59Ipf7BS5mdtu1/n8eQ6DTqpm17C+kwd+IT0k4eY0s=
X-Received: by 2002:a17:902:ebc1:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2b45e0fde9amr59671985ad.10.1776142884689;
        Mon, 13 Apr 2026 22:01:24 -0700 (PDT)
X-Received: by 2002:a17:902:ebc1:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2b45e0fde9amr59671465ad.10.1776142884139;
        Mon, 13 Apr 2026 22:01:24 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:01:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:05 +0530
Subject: [PATCH 09/11] media: iris: Add support to select core for dual
 core platforms
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-9-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
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
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=8976;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Na5TubomgVuDD7yKf84igivMKpdfxkQPlVnbL5NqEQE=;
 b=IZjZXUDzGpLRRoljt6U6FOwySMBheBu/yARjYTCSmn64Bz49ZwpCy8BgX1YCG9fQy7xGXKsiv
 emY63IfGR7IBrLtzyPRJ/LUqB1J6/HcaKV3bMVV7bOmxZ6104Sgd/jG
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: f3rjlknmW145FvLLhS3e9X9bsoX6KVId
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69ddca25 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=y4DQSFRNPWCXgWzwaCEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: f3rjlknmW145FvLLhS3e9X9bsoX6KVId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfX8Y3M2kPMKI80
 zf0gCGeORhbRMWcUHXe9o+sPmm5nxByW76hx1JnTHcC50zt0+AzHYG0i+Z000Vu3bU6OPqNsQ3T
 O4fXSMPLeNUZOsW3sNUWYZXJqwkbqE4HEQqIZtNUJ3WIXIMvDwur349jsPHNdrKHyJEy3o0MwkD
 ipmDMkZUv+kgO99M8Y7tcO6cpeGVp8DreVZt31o0JwrjuVsPEccA1H35VdIuNhatsyKOR3mUbLo
 pMBoRtOyd+KrUDzH4/pfO7zRLb9SfGk8qR0Zqa/AVFTwOh1fvxqU6PUA8hiMMkLLDJ5Voh/Z374
 fkFS6RGgvOXA0oTlTeymyNaVmNf+9uYS1gKLnvxW1zLjeid8oyky5OIr9jILntglMrd4NF9GzW7
 6p6BtwYccMhbFFHiKMQ/PTys0lxS2i0ylIVxRLohl9KQF8f5LGwdlaO9z490rz3i6AkQUPfAiKK
 WBo7OCV7OhdGWlRNQnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140045

Select the hardware core (vcodec) for a session, based on load when the
platform supports dual vcodec cores. Assign the session to vcodec if its
MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
the selected vcodec core to firmware using new HFI_PROP_CORE_ID property.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_common.c     |  7 +++
 drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 ++++++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 drivers/media/platform/qcom/iris/iris_utils.c      | 68 +++++++++++++++++-----
 7 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 7f1c7fe144f7..e31d4c988c55 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -49,11 +49,18 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
 int iris_process_streamon_input(struct iris_inst *inst)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+	bool dual_core = inst->core->iris_platform_data->dual_core;
 	enum iris_inst_sub_state set_sub_state = 0;
 	int ret;
 
 	iris_scale_power(inst);
 
+	if (dual_core) {
+		ret = hfi_ops->session_set_core_id(inst, inst->core_id);
+		if (ret)
+			return ret;
+	}
+
 	ret = hfi_ops->session_start(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 	if (ret)
 		return ret;
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
index cecf771c55dd..1926a5344427 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -56,6 +56,7 @@
 #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
 #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
 #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
+#define HFI_PROP_CORE_ID			0x030001A9
 
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
index e3c1aff770dd..aeb70f54be10 100644
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
diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
index cfc5b576ec56..38ede9f76d0b 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.c
+++ b/drivers/media/platform/qcom/iris/iris_utils.c
@@ -90,18 +90,51 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
 	return NULL;
 }
 
-int iris_check_core_mbpf(struct iris_inst *inst)
+static u32 iris_get_mbps(struct iris_inst *inst)
 {
-	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbpf = 0;
+	u32 fps = max(inst->frame_rate, inst->operating_rate);
+
+	return iris_get_mbpf(inst) * fps;
+}
+
+static void iris_get_core_load(struct iris_core *core, u32 *core_load, bool mbpf)
+{
+	bool dual_core = core->iris_platform_data->dual_core;
+	struct iris_inst *inst;
+	u32 load;
 
 	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list)
-		total_mbpf += iris_get_mbpf(instance);
+	list_for_each_entry(inst, &core->instances, list) {
+		if (mbpf)
+			load = iris_get_mbpf(inst);
+		else
+			load = iris_get_mbps(inst);
+
+		if (inst->core_id == BIT(0))
+			core_load[0] += load;
+		else if (dual_core && inst->core_id == BIT(1))
+			core_load[1] += load;
+	}
 	mutex_unlock(&core->lock);
+}
 
-	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
+int iris_check_core_mbpf(struct iris_inst *inst)
+{
+	struct iris_core *core = inst->core;
+	u32 max_core_mbpf = core->iris_platform_data->max_core_mbpf;
+	bool dual_core = core->iris_platform_data->dual_core;
+	u32 core_mbpf[2] = {0, 0}, new_mbpf;
+
+	inst->core_id = 0;
+	iris_get_core_load(core, core_mbpf, true);
+	new_mbpf = iris_get_mbpf(inst);
+
+	if (core_mbpf[0] + new_mbpf <= max_core_mbpf)
+		inst->core_id = BIT(0);
+	else if (dual_core && core_mbpf[1] + new_mbpf <= max_core_mbpf)
+		inst->core_id = BIT(1);
+
+	if (!inst->core_id)
 		return -ENOMEM;
 
 	return 0;
@@ -110,17 +143,20 @@ int iris_check_core_mbpf(struct iris_inst *inst)
 int iris_check_core_mbps(struct iris_inst *inst)
 {
 	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbps = 0, fps = 0;
+	u32 max_core_mbps = core->iris_platform_data->max_core_mbps;
+	bool dual_core = core->iris_platform_data->dual_core;
+	u32 core_mbps[2] = {0, 0}, new_mbps;
 
-	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list) {
-		fps = max(instance->frame_rate, instance->operating_rate);
-		total_mbps += iris_get_mbpf(instance) * fps;
-	}
-	mutex_unlock(&core->lock);
+	inst->core_id = 0;
+	iris_get_core_load(core, core_mbps, false);
+	new_mbps = iris_get_mbps(inst);
+
+	if (core_mbps[0] + new_mbps <= max_core_mbps)
+		inst->core_id = BIT(0);
+	else if (dual_core && core_mbps[1] + new_mbps <= max_core_mbps)
+		inst->core_id = BIT(1);
 
-	if (total_mbps > core->iris_platform_data->max_core_mbps)
+	if (!inst->core_id)
 		return -ENOMEM;
 
 	return 0;

-- 
2.34.1

