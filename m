Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F5394474
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408041; cv=none; b=W56WbuZMNhJhZjXQLJMR15haPWS7PtPMqDDsWBIn0yQp5Cf1ln1Ko7xvylpn5Z5bfPnIbzgdNTbWxvc7nbZ2ONaXlRe1wnXYDwtzybXO5ZjiMPgmLXEg/EmDNAKRwQNcDxWDyKZmVL7/j+Q6JskS+SXVap8sKk/gvujdNN+zHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408041; c=relaxed/simple;
	bh=OxEeucEk6xEbfwApx73QjPbvH1DJC0PQUFwitZIlIww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZfnpGxmIujpLf04gnAHUM5MiDzBselwU7RJ0znFpZBfritbE2oZSw+VHrVxtIJbMDS/PLj21Arm9pugeyayUl89E3AZh8ENz7cUo2KSXW1h2Ol9KK1kmrQgYgDV/HyrN7n+ZJ9qVXPbcWpfm+vUgKvbeq7wqrCUqXHisDgOlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Esd7kJFb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Se8QwkyB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Esd7kJFb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Se8QwkyB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC2OGV4140646
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vQ6529GjGImdh1dpkhQ1AlRFese4u9KeMQ697DAVkoY=; b=Esd7kJFbF/Qzw2kz
	eTtxdk6Q8kqGWMdK6Zsa82Hs9aFe9dRnBqVpmwaE99ARz5+lSmJrv5hxTijrnadn
	OXn0p5/fO3T66wc7dM0Qkz8vqKP1hQE04O2OMLLZMfIIX78ix4z/ao7stR/HD4I1
	YunILS7U5KnWkbdi9q+k+2SR5Vy9innQljjBUuXdtOUqzJtBE1y2xXTekwJ7x39k
	szKsLvVT/d0ZdWtF+OreFXOlVTiWi5fEaE7KE6sqeVTsVny3nLBsNdqZKjubxhgv
	NMapgowvx6lhS5TRHX4IEax2m15dT5qrC8FynVtl6m76S7xE0omlcuayHtI/6ljA
	HfFjEg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn29qu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7381a95fffso1331441a12.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773408038; x=1774012838; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQ6529GjGImdh1dpkhQ1AlRFese4u9KeMQ697DAVkoY=;
        b=Se8QwkyBU/Rr3/Vznd8fm4eEybPIXpTnQyAHPK2HQIWzAYxKyELPBJuoJFLr+UKe1T
         xM7r39JkYRyPG41FUQFPchG6y5QIV7htAsUI7ChSca9d6tpCRZuea9NDBBuTe7L6cWYU
         rhCExE0VsCzxruVjzvvXK6PFUTlavv+PbFYMDg61LbHLHwCVaVywhqBZb5qKARb+OFJM
         yPpfjX5ZpaM7QM6vHOUgNCslU2IjurzlATfBgweDYu1+iPuvgAb+YmXC+orrqjDmNLLY
         uISFDlNEQpU6cY2f31qmqkJ+3m1TNtTFxJgFHCFK9TH48KODkCkC1haDyDLN4e5+cT4l
         bIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408038; x=1774012838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vQ6529GjGImdh1dpkhQ1AlRFese4u9KeMQ697DAVkoY=;
        b=nCWKnE4oaidtZZ28RHN7liuzh3GUP5CRqxuBWPqm5jkK4JcueQpnuhFDKQ/H/CqZf6
         aoacVY/S+6tn8VEUxqQD2RX6YtQ+/FppV9O6Pxm5I1z6EOeSsaLhtsDYRR2SQCxWONMW
         kT3cLyl7ZpPcaXvPQLJ8YbSVJD41FmHLWVK0DNYvXxJD84jd5vI+frGk44o/j27abZku
         WaPbs9/vwwC4WDP5CjKZJvlk2akFlTzfTeGWTEcVkUAAe2goMYlrjrqfdeVxNcYzfi9k
         JSxIbNxRMDhuTfhyLpBUDgm03sh8U1cU/9pyx+bvrUd0DXvEcXd+pwv0/siuqUv9qspX
         iPcg==
X-Forwarded-Encrypted: i=1; AJvYcCVfIIDjNZIW+rb5d6BJ4toL8zONT3N/seIadI/rlgxrMGpeT5tu/0rYxa3JoEn6lIh+E06LJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJibZ0GLMIu7MetWfhlqDnRvaB7PcbQ9D3yoSBeZ3GQS9Zmrul
	bin3qlPsXmaY3+WEFYRWfukcViZNy0cZxjyv06Z5E+FTgGlmLXoUDB7Ev4ocb/VNFYH1UWFryzX
	F9tN+ART6VpAn/opIsvMZhZqvgO4pnpRvI09oca2rTZ4S6SmcwecxItneug==
X-Gm-Gg: ATEYQzwOVmRhs61iW/DmuZqLN4ah9nmz4O684Bhlfq/G9hgZ0meIZdHsVuafgbg2DCn
	HeLwCtGArF0EiqJwQQboIuewACTkbn1WvcOL+oN8eP6r+CxvasQ3iD1GEl6HdWZbOV/td35HLNZ
	xtC6zM4b8bX8sZYSUCap779gjhE7dDyTPnqJpj/WgE9gJ0oICr3O0DRRjQBPQys8RmPqZJdaIWY
	jMNX9ST1GeEVZSLhY8jpMnjefLwx42a4mgGu7+j9MG8b/EFgx76iV6M9VTsjSxsB3x+MtvQtEoZ
	+Hg8tvQSq75UcZZ03LYS51AkjNYd4UZnMr8zWW0c8AI7sMwxRKUx0f2yGNYPcDty2LDAVNdPKdX
	5VRzWeWrEtfKUPk+ZZ7OKnVbg4uZNalKUDKInc2E+opMT2QGCIw5X7Qru
X-Received: by 2002:a05:6a00:84c:b0:829:86a5:d30f with SMTP id d2e1a72fcca58-82a19703a46mr2918862b3a.11.1773408038356;
        Fri, 13 Mar 2026 06:20:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:84c:b0:829:86a5:d30f with SMTP id d2e1a72fcca58-82a19703a46mr2918826b3a.11.1773408037753;
        Fri, 13 Mar 2026 06:20:37 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm5775254b3a.8.2026.03.13.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:20:37 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:49:39 +0530
Subject: [PATCH v3 5/7] media: iris: add helper to select context bank
 device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-kaanapali-iris-v3-5-9c0d1a67af4b@oss.qualcomm.com>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
In-Reply-To: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773407994; l=8958;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=OxEeucEk6xEbfwApx73QjPbvH1DJC0PQUFwitZIlIww=;
 b=aZudF84kBeMD27WJMiI10AY/lSCL9tzRxbiloVXThVyiuattTDPQ0bT6RDtEUevKd0eM61lu7
 BCTzhsg+YNXCfi9MFBJNZ9zkbn3TTwlwr6CHzejeU/dWQrGXYW2jb3n
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: rwy3PrvuOCHUC0G1CcyF_85DzV-0rB-P
X-Proofpoint-GUID: rwy3PrvuOCHUC0G1CcyF_85DzV-0rB-P
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b40f27 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=oSQLiBfSod8WWzwNvhoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNiBTYWx0ZWRfX6GQpIB+9g7PJ
 QFs28zstAIIRR33uxm82lIiRCokrVqnHAE4nxNas5bu0rir5ZCnO6Kze9ToSJ4xNVV3q5oexcme
 uLR1pjlNNOme9QYgt9Ed/Rty3z9KgYXZ7JjeSJRpn4/dphs6OeytlcrZyw3nPpeRlXgBd41wHuK
 MNTOMmb6QINNQEg7sLEINKnepmR8YhFXthaeURsk1EE2No0kFyhSX3WsybemTVk4CpXN6JSUUXq
 RduNjomY1pn7vQ+OGz7I0skZYCptXGhZye68vYZMTg6USdF3BoLiHlGc06/WyPpAAtN4adBr0Ht
 2o7kfqoEI893ecV7nCm5TkmawAPe8LXo8TpSajja5pgjMdH3XEuy4FkdLi/T5ScjW/ELnz2rMW1
 RV6+EvA5KVOE2bA6DtcDEME2QNASITO3lMdJtmaatW5Zkm1cCJJ/VFxQI04fLJRUKyfauOAI10C
 YkUXKcuVa+ZM+mqYRVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130106

Depending on the buffer type (input, output, internal and interface
queues), associated context bank is selected, if available. Fallback to
parent device for backward compatibility.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c    |  7 ++--
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++++----
 drivers/media/platform/qcom/iris/iris_resources.c | 41 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  2 ++
 drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +--
 5 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index 9151f43bc6b9c2c34c803de4231d1e6de0bec6c4..a016eaa4e02fe78aeefd97cc3cff51aec25778ff 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -335,8 +335,8 @@ void iris_get_internal_buffers(struct iris_inst *inst, u32 plane)
 static int iris_create_internal_buffer(struct iris_inst *inst,
 				       enum iris_buffer_type buffer_type, u32 index)
 {
+	struct device *dev = iris_get_cb_dev(inst->core, iris_get_region(inst, buffer_type));
 	struct iris_buffers *buffers = &inst->buffers[buffer_type];
-	struct iris_core *core = inst->core;
 	struct iris_buffer *buffer;
 
 	if (!buffers->size)
@@ -352,7 +352,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 	buffer->buffer_size = buffers->size;
 	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
 
-	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
+	buffer->kvaddr = dma_alloc_attrs(dev, buffer->buffer_size,
 					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
 	if (!buffer->kvaddr) {
 		kfree(buffer);
@@ -490,9 +490,10 @@ int iris_queue_internal_buffers(struct iris_inst *inst, u32 plane)
 int iris_destroy_internal_buffer(struct iris_inst *inst, struct iris_buffer *buffer)
 {
 	struct iris_core *core = inst->core;
+	struct device *dev = iris_get_cb_dev(core, iris_get_region(inst, buffer->type));
 
 	list_del(&buffer->list);
-	dma_free_attrs(core->dev, buffer->buffer_size, buffer->kvaddr,
+	dma_free_attrs(dev, buffer->buffer_size, buffer->kvaddr,
 		       buffer->device_addr, buffer->dma_attrs);
 	kfree(buffer);
 
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index b3ed06297953b902d5ea6c452385a88d5431ac66..b8179b2c0ee9d13ff4294922d74767825069683b 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -245,25 +245,26 @@ static void iris_hfi_queue_deinit(struct iris_iface_q_info *iface_q)
 
 int iris_hfi_queues_init(struct iris_core *core)
 {
+	struct device *dev = iris_get_cb_dev(core, IRIS_NON_PIXEL_REGION);
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
-		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
+		dev_err(dev, "sfr alloc and map failed\n");
+		dma_free_attrs(dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
 			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
 		return -ENOMEM;
 	}
@@ -291,6 +292,7 @@ int iris_hfi_queues_init(struct iris_core *core)
 
 void iris_hfi_queues_deinit(struct iris_core *core)
 {
+	struct device *dev = iris_get_cb_dev(core, IRIS_NON_PIXEL_REGION);
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
index a2e648f4cdb8c63db89396d49f32bbc06d870ea5..9a896271c21187ecda25be86c1abd2e905e32d8a 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include "iris_core.h"
+#include "iris_instance.h"
 #include "iris_resources.h"
 
 #define BW_THRESHOLD 50000
@@ -187,3 +188,43 @@ int iris_create_child_device_and_map(struct iris_core *core, const struct iris_c
 
 	return 0;
 }
+
+enum iris_buffer_region iris_get_region(struct iris_inst *inst, enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		if (inst->domain == ENCODER)
+			return IRIS_PIXEL_REGION;
+		else
+			return IRIS_BITSTREAM_REGION;
+	case BUF_OUTPUT:
+		if (inst->domain == ENCODER)
+			return IRIS_BITSTREAM_REGION;
+		else
+			return IRIS_PIXEL_REGION;
+	case BUF_BIN:
+		return IRIS_BITSTREAM_REGION;
+	case BUF_DPB:
+	case BUF_PARTIAL:
+	case BUF_SCRATCH_2:
+	case BUF_VPSS:
+		return IRIS_PIXEL_REGION;
+	case BUF_ARP:
+	case BUF_COMV:
+	case BUF_LINE:
+	case BUF_NON_COMV:
+	case BUF_PERSIST:
+		return IRIS_NON_PIXEL_REGION;
+	default:
+		dev_err(inst->core->dev, "unknown buffer type: %d\n", buffer_type);
+		return IRIS_UNKNOWN_REGION;
+	}
+}
+
+struct device *iris_get_cb_dev(struct iris_core *core, enum iris_buffer_region region)
+{
+	if (core->cb_devs[region])
+		return core->cb_devs[region];
+
+	return core->dev;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index c573016535b87d4fd140cad967d926cc1de63382..2d0447309ca4e7833db2fa57ef8fc3758e9802a9 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -16,5 +16,7 @@ int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_create_child_device_and_map(struct iris_core *core, const struct iris_context_bank *cb);
+enum iris_buffer_region iris_get_region(struct iris_inst *inst, enum iris_buffer_type buffer_type);
+struct device *iris_get_cb_dev(struct iris_core *core, enum iris_buffer_region buffer_type);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index bd38d84c9cc79d15585ed5dd5f905a37521cb6dc..40744d487fbf1520c5e359d536cddb1c5ab0a706 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -107,7 +107,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct iris_buffer);
 	src_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	src_vq->dev = inst->core->dev;
+	src_vq->dev = iris_get_cb_dev(inst->core, iris_get_region(inst, BUF_INPUT));
 	src_vq->lock = &inst->ctx_q_lock;
 	ret = vb2_queue_init(src_vq);
 	if (ret)
@@ -121,7 +121,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct iris_buffer);
 	dst_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	dst_vq->dev = inst->core->dev;
+	dst_vq->dev = iris_get_cb_dev(inst->core, iris_get_region(inst, BUF_OUTPUT));
 	dst_vq->lock = &inst->ctx_q_lock;
 
 	return vb2_queue_init(dst_vq);

-- 
2.34.1

