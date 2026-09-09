Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCC582B8B
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965902; cv=none; b=ovVevHsrDG5JWJVTC0kuCMLZk+lYoTDHkAUUyTWSh6ZET6BjMsRqy4f/6XN+4Mh8z8YGkQ8rUhg9A6U2M2BN+Kfpi81p/E9RnnLXGCq5wHRy6zBOHPpedf+iK4kFKsqqyVsHxoI0hVDE3R/LAjGXOsZR8PxTZDrgW7VYWLwqYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965902; c=relaxed/simple;
	bh=fqABz+QRgPQSuehU4mHZGuHjcg1K8k452p65GQ8Wh5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQfOeqFR6qWyMbAaoP3PmENCMshiRxhC8FeT2cayQnUM3e6oBKnfLjX6w5IFwFY/yn+qyV4i2bBdH+OZhR77x+mw/w6yBC+HAg5FJWfI3fsgTg7+Mc34Jps2aBcN3j2AnNXURlsX1OQ5K9tpdBb9BnZc942sIzDCgXLvplyrQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3VbZmSd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MGahsQuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3VbZmSd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MGahsQuN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU1UX1723028
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3FXSLpfX1uuKQ48PVTJAV5lMhV6YqUrz9fFUADq20lE=; b=C3VbZmSdKULWga1P
	FJDHhtXTxE5Qr6AGkjiZ4mrtP6xHQzYbYv8v/pJqCLg7dDzhXn4YrOC8Pce1ZK4G
	4s68dp0hc8xZGGgHUzTu0Ii5uA/AqGUloMFwKVd4bcDrcXAdQdq/KuFEUcLSe6+N
	L43XrEyZXpyP6dk4/hMp7quxw5ppZTTObdmkjV0WTLEUnNnB5PKWJONPMcSU5hdZ
	2e1Deu1TL1SsHZ8WFYHn8XtD5eiLxFnVPyUqhjbEvPB1bbmZuOTLGsZI6U5GWQw0
	D2y1TEVfBCgARU4ADJ331JIfl9suH3AgQ8J+PCsSS6hCCqLJkJsZMfEmL2Cn2ch3
	mfwKjA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cns70b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85602449126so4675120b3a.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965898; x=1789570698; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FXSLpfX1uuKQ48PVTJAV5lMhV6YqUrz9fFUADq20lE=;
        b=MGahsQuN/Zv9QiYWnIrw22FSmVg6kJilA8b2y/ay2iyPpGvbxpDAXJLSQ1seaPKney
         D5suBSZke54dp8QPIyqepY4fCRzaqy67ASyLPMDOMZOsNd15p1gUw00Fu+3yvuoR1PMt
         VGqZArDdBAqJHCgNIDxzXfxz+4hKjSEO3wJN8BDSiq3tTVb7NYcEMW8J4rXIhn5F7Yj0
         t14TPJwuheEozYvxNEApzNXUOl9OtgYSOazXD5VxQo/n1jTceUcfjY1jgFKHtNDGaohx
         MYAQStVai/QIESXvuueCDmPZV5i5R+4YptHALi+xZifjUd7E7bRs8BFDzfQ0OkoNc2dv
         qsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965898; x=1789570698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FXSLpfX1uuKQ48PVTJAV5lMhV6YqUrz9fFUADq20lE=;
        b=R0U3tarSrOhCtsBHPdVM1+Vyfv72FUzM4AlvcNtmc7BWVJV5SAahSeWSVsBYcnMfFz
         9Fa+lJwcpBkEaPPRkuOK+pVYMhaIxYy47JXSQNIF2qRwFUjnx+2brQIEYnDYBOn+tqp/
         SoGvGniFK5fBQnD6qdBweO+pqFhRaUwH0Zbkov949tp9Hfrg+/5TRFB0WMDhJzSCO8JV
         4uUceR/FYbNYGYGFYPwmjaG/rFw3isTsiH4s8Qbz8pQr/G7GVaL5+nP6e0t7aZcLSPq1
         YvakollmGEU0amgWktT95+HZPGiVMZYFYu+ASRzK7AF00KT+ftB0uJjBX04bivayOMTS
         5mMw==
X-Forwarded-Encrypted: i=1; AKwUvBw1R37w3inxdORWtsm6JnboGryARfROQpAeQZgbYiAcG1CfKjJ1Ftp3VwmVt1C9S4xLSzYXMw==@lists.linux.dev
X-Gm-Message-State: AFuF++mgee+Gm2BifAdCav0m7LnGzMDSEuAD25Zb7UTuFvuOHrZyZdYx
	qjKELiJLnrnrpzA7cqdTV+zWsSW5bjXRzgKNdlI37f8QwkvicnrtT+uD6fsWQ97lVIv4o7vmYgr
	NSO4oYBfkm9rsSlIuiBiN72godd2L8zMoKThQQS84Pp3OO19fzQn+gmqKJw==
X-Gm-Gg: AYBFou3+UPZAZyZQmCIZAZ+A2WDRluoGxPICfqBcU+k7ajwqNltIYjyQL9AmVzFRpqG
	2Q762tZOkKr/QMaRhTImx8QtWYI74VKvLT5x5LyNw2xZdwEWMDEDshdwkZiXv4u10s51+tu8MhC
	mW2dyDy+sZL+gcQx2WezlG0Ram6A3T1eadxukrfBi/rtao51Fi+mgrFyCqd7Y8JFG1jeROqNwnk
	HpMny6cIB5UzAuhIDaDm504UXggnaZ7GEN8rSxMrqvezVXSJxE2D5R+X4TesFLzIQyNbVO90juB
	Oy3dlTpiHJ5gPdf/UE0kb1GYJSA9xb6hyc2xuMFvzlbkVo9xuuNC0+dj4/haxzgY5dTts7dVPo5
	WR+mJSSDBiQAQ1Pmr6tKj8kY4Hu0/wgddXE4=
X-Received: by 2002:a05:6a21:6b02:b0:3da:3492:83d0 with SMTP id adf61e73a8af0-3da3a173d6cmr58825898637.23.1788965897715;
        Wed, 09 Sep 2026 07:58:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b02:b0:3da:3492:83d0 with SMTP id adf61e73a8af0-3da3a173d6cmr58825809637.23.1788965897160;
        Wed, 09 Sep 2026 07:58:17 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:16 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:13 +0530
Subject: [PATCH v3 06/13] media: iris: Route buffers to the matching
 context bank device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-6-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965840; l=9298;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=fqABz+QRgPQSuehU4mHZGuHjcg1K8k452p65GQ8Wh5k=;
 b=nSkMGkc7UUvqzbrcKlJfJdOn3dhj9vie5jQrrGbRglKj1HkcAnyhx1n2VTK6r6psJSxkH0jlt
 GfptyPTI650D1uDjfEttc9RA6Q+ICqZOWn7kl4yKVgDSrT/rl38esWy
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: np5Y3Q4MZ4Bt9AzJr7R0lyZKd9DCMXfX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfXwQ2E50OOMWj4
 FgcnD8EEGqeclDsWICmtxmkKI3f5eFk0p2zd49tAWIRoSieloK+gqp2UOAX6IcKeplSfLHV/o/9
 y26DWexzNqIpelrQCCzPfgQBoKL3Vsc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX7hdVQHvs6US+
 UK2a/wAyOOMGBHpufBsKyqbBNqjkdaukhqN5b0LMYumZepJpzeZNhU1AhMKP3hDw/eWhmaTwTny
 V/VV7tvavaxEk2WCkyn+4tSzNHqCB8CPXlanUTTitPEa6ayfdnipKO5NRgW9Ahxh1ytRCs98aBp
 yd3weD7CQFxVT9HAyChLJ9WIth5hq+2Qw39nO29hR+BHAstR+NXg0WTvJjw7yVMIon4e59+0s7H
 10TOKM+hAX/NX3J00S5sDRm/xsT5m98OinJi9jL0SAEMJPkHAkO6QGFzG1+2Cha5YfNlClAvm+8
 /cMfFxLfWk1a7gy5cXD1UwYinl2aoeEdfYTZ3UFIZ5c3idp09ecu1P6ExMbFdnLajA0XPab1AUp
 GzGgVd7e+BBTcDBh3ScHEsxb2ItmAcq3WslyCEZxOUVd7dh+9zGlu0dS4FKfjEvmes7cv+2rOUw
 j2lIE1IPZkxUMMDCDEA==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa1740a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8 a=XoEKZCkTUFqVY0t_PIAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: np5Y3Q4MZ4Bt9AzJr7R0lyZKd9DCMXfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range.
Add iris_get_cb_dev(), which maps a buffer type to the owning context
bank device. Bitstream and internal buffers (BIN, ARP, COMV, LINE,
NON_COMV, PERSIST) belong to the non-pixel device, and uncompressed
buffers (DPB, PARTIAL, SCRATCH_1, SCRATCH_2, VPSS) to the pixel device.
BUF_INPUT and BUF_OUTPUT depend on direction and are resolved from
inst->domain: for a decoder the input is non-pixel and the output pixel,
and the other way round for an encoder.
Fall back to core->dev whenever the relevant context bank device is
absent, so platforms still describing "iommus" on the parent iris node
behave exactly as before to maintain backward compatibility.

Tested-by: Daniel J Blueman <daniel@quora.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c    |  8 ++---
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++++----
 drivers/media/platform/qcom/iris/iris_resources.c | 41 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +--
 5 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index eb8de60c1177f5e1ab83b90a3c8c80e0b4d1f02e..6e03d13ac1a792c539bf8fe6d26354aa29d7b3a2 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -531,7 +531,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 				       enum iris_buffer_type buffer_type, u32 index)
 {
 	struct iris_buffers *buffers = &inst->buffers[buffer_type];
-	struct iris_core *core = inst->core;
+	struct device *dev = iris_get_cb_dev(inst, buffer_type);
 	struct iris_buffer *buffer;
 
 	if (!buffers->size)
@@ -547,7 +547,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 	buffer->buffer_size = buffers->size;
 	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
 
-	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
+	buffer->kvaddr = dma_alloc_attrs(dev, buffer->buffer_size,
 					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
 	if (!buffer->kvaddr) {
 		kfree(buffer);
@@ -650,10 +650,10 @@ int iris_queue_internal_buffers(struct iris_inst *inst, u32 plane)
 
 void iris_destroy_internal_buffer(struct iris_inst *inst, struct iris_buffer *buffer)
 {
-	struct iris_core *core = inst->core;
+	struct device *dev = iris_get_cb_dev(inst, buffer->type);
 
 	list_del(&buffer->list);
-	dma_free_attrs(core->dev, buffer->buffer_size, buffer->kvaddr,
+	dma_free_attrs(dev, buffer->buffer_size, buffer->kvaddr,
 		       buffer->device_addr, buffer->dma_attrs);
 	kfree(buffer);
 }
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index bf6db23b53e2106c08f2139b643f8626af8bc40a..ce6a682b0f9ada79f9fae26289db298855d777c2 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -245,25 +245,26 @@ static void iris_hfi_queue_deinit(struct iris_iface_q_info *iface_q)
 
 int iris_hfi_queues_init(struct iris_core *core)
 {
+	struct device *dev = core->np_dev ? core->np_dev : core->dev;
 	struct iris_hfi_queue_table_header *q_tbl_hdr;
 	u32 queue_size;
 
 	/* Iris hardware requires 4K queue alignment */
 	queue_size = ALIGN((sizeof(*q_tbl_hdr) + (IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ)), SZ_4K);
-	core->iface_q_table_vaddr = dma_alloc_attrs(core->dev, queue_size,
+	core->iface_q_table_vaddr = dma_alloc_attrs(dev, queue_size,
 						    &core->iface_q_table_daddr,
 						    GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
 	if (!core->iface_q_table_vaddr) {
-		dev_err(core->dev, "queues alloc and map failed\n");
+		dev_err(dev, "queues alloc and map failed\n");
 		return -ENOMEM;
 	}
 
-	core->sfr_vaddr = dma_alloc_attrs(core->dev, SFR_SIZE,
+	core->sfr_vaddr = dma_alloc_attrs(dev, SFR_SIZE,
 					  &core->sfr_daddr,
 					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
 	if (!core->sfr_vaddr) {
-		dev_err(core->dev, "sfr alloc and map failed\n");
-		dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
+		dev_err(dev, "sfr alloc and map failed\n");
+		dma_free_attrs(dev, queue_size, core->iface_q_table_vaddr,
 			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
 		return -ENOMEM;
 	}
@@ -291,6 +292,7 @@ int iris_hfi_queues_init(struct iris_core *core)
 
 void iris_hfi_queues_deinit(struct iris_core *core)
 {
+	struct device *dev = core->np_dev ? core->np_dev : core->dev;
 	u32 queue_size;
 
 	if (!core->iface_q_table_vaddr)
@@ -300,7 +302,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
 	iris_hfi_queue_deinit(&core->message_queue);
 	iris_hfi_queue_deinit(&core->command_queue);
 
-	dma_free_attrs(core->dev, SFR_SIZE, core->sfr_vaddr,
+	dma_free_attrs(dev, SFR_SIZE, core->sfr_vaddr,
 		       core->sfr_daddr, DMA_ATTR_WRITE_COMBINE);
 
 	core->sfr_vaddr = NULL;
@@ -309,7 +311,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
 	queue_size = ALIGN(sizeof(struct iris_hfi_queue_table_header) +
 		(IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ), SZ_4K);
 
-	dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
+	dma_free_attrs(dev, queue_size, core->iface_q_table_vaddr,
 		       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
 
 	core->iface_q_table_vaddr = NULL;
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 2c4d34c7bd77d1f78d3572f659da656eb3b12113..a6c3df892ca9888d82414ca6b48c80efbf7b06d0 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -12,6 +12,7 @@
 #include <linux/reset.h>
 
 #include "iris_core.h"
+#include "iris_instance.h"
 #include "iris_resources.h"
 
 #define BW_THRESHOLD 50000
@@ -138,3 +139,43 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+struct device *iris_get_cb_dev(struct iris_inst *inst, enum iris_buffer_type buffer_type)
+{
+	struct iris_core *core = inst->core;
+	struct device *dev = NULL;
+
+	switch (buffer_type) {
+	case BUF_INPUT:
+		if (inst->domain == DECODER)
+			dev = core->np_dev;
+		else
+			dev = core->p_dev;
+		break;
+	case BUF_OUTPUT:
+		if (inst->domain == DECODER)
+			dev = core->p_dev;
+		else
+			dev = core->np_dev;
+		break;
+	case BUF_DPB:
+	case BUF_PARTIAL:
+	case BUF_SCRATCH_1:
+	case BUF_SCRATCH_2:
+	case BUF_VPSS:
+		dev = core->p_dev;
+		break;
+	case BUF_BIN:
+	case BUF_ARP:
+	case BUF_COMV:
+	case BUF_LINE:
+	case BUF_NON_COMV:
+	case BUF_PERSIST:
+		dev = core->np_dev;
+		break;
+	default:
+		dev_err(core->dev, "invalid buffer type: %d\n", buffer_type);
+	}
+
+	return dev ? dev : core->dev;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db095ec05e53c894e048285f82446c6..a9a5bddb19c24917de4c5dba52567934b77e5c59 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+struct device *iris_get_cb_dev(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index fcbc60016beec693f2ce27927a09a2d51494bc38..064cf0a80748dab1be0515c4c2b6688aeb2b7022 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -108,7 +108,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct iris_buffer);
 	src_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	src_vq->dev = inst->core->dev;
+	src_vq->dev = iris_get_cb_dev(inst, BUF_INPUT);
 	src_vq->lock = &inst->ctx_q_lock;
 	ret = vb2_queue_init(src_vq);
 	if (ret)
@@ -122,7 +122,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct iris_buffer);
 	dst_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	dst_vq->dev = inst->core->dev;
+	dst_vq->dev = iris_get_cb_dev(inst, BUF_OUTPUT);
 	dst_vq->lock = &inst->ctx_q_lock;
 
 	return vb2_queue_init(dst_vq);

-- 
2.34.1

