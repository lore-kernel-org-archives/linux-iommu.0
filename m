Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348C368D5E
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124642; cv=none; b=t1zGi6YSCZmKPgtDjT79Sxkw0azJHMQN9cPFe98MFvXcEd9zs2twBZza2QmbPgSUsljEIQLsRWtczneUuMj+hChgqvOWjZ+HKJTZioDfR3Rl/ARrDFzh2/AvkcMNc8f9LfhGZJml/bwV5BMlSD4bonqtM8yGABhg9X2TaI4Yy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124642; c=relaxed/simple;
	bh=TWnfmPOlO+mOYgnlGCly8Bm2gHmg0/p2SiB17+MZEzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTjYFv9yRfT4VEvXyS0u0Hl5XxiEZGGoN/uu4NL1WM+5EwEuU7HnupilHR4iKKJaJn+z5Q1daVu3jj/0vHstqxgKBTUNoxu7gmaYVwzg+L2WRx4iBk7FtcZfjYxVKB6PWcalHRtp81VnxPxNkPl+WokRGCL87KDVf7sapblI/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0s+oMht; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRB4KOuP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0s+oMht";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRB4KOuP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3OtV3957701
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=; b=l0s+oMhtoSahTOwJ
	XdpaYIVc30LOSud0UZMQJm/Xa+hvCvcUyFGN4e9lRBErJZRjDCqbnmyfrzoWuXTQ
	PxgeXNRum3ZIO6vmA19JQfHnwYwewDHu35xur1G776G6fqqaqZdzUJe0dwrKXRUd
	9bRY29Qk39MDZySZCLtfKJjFT60IXzZDph8TiTuG5R1fNvLwmc2BgZwNB4rJdKKO
	pafen+bJIsGhdWDFEN0llBrajc4M2WRHappTTbG18wX/9rQ+R6S6SvfIeKIWw1fi
	zbw/aVbE6QqLs0tPaXtkzy6eijSw9gfxQVE4GYtTjjf3LIKG6ZbuDH13AQEsR++U
	T73w8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfg7an-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so81094075ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124638; x=1784729438; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=;
        b=DRB4KOuP0dE6bubgd+MzKlW/losSdyk0KCS6S/Az+GsmYpHv9si2kXmB2yJVcbCZnv
         xuMdA2oDNRROXwaFEDDqvd6IOoIvqf8FmWmlfZEqOb5+U4jEIdMrfCgXOhhNe3nkTV3H
         PLwF8suZYyZLSzszq21FDGpaTtYBKhrKzdRwZrbi7urRbLgOnT19MS70J/HvYcimjQbh
         GdP+NauESk2Wtahl8x1NJ9PcAoxMxFwIt7eYsqVhfsTzBI/+h2LfXsLwsURn91jm36KD
         xBvbx9NckdlM+V5OAc2ldfWD7LpltU5ahAVHoe6fiUzgEQD9Hm45Kwne/9WdR21b3KII
         OsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124638; x=1784729438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=;
        b=hieReTjHx2jFLAh1qr3ry1alNh7GQLzSlODVIF4TRXqf4UooaPXwGCb03owD9Ie8GM
         MGrlvOgk7+YaEkxUwUw2CHYjMoid5jPDWeK3ebyplMsp3SRcGRtHEhgLeoABFF7HbUEZ
         nJh7zOtGh7sftKnGt5SDSbZeigAFqvluSgfb49XxnamlxyPPrj3V0Skfpv/odnjmsUpb
         OVcYHhMkEBFtTg7vfF8Kfuxp/9b5pJi/r28/KajQZxlhVxiZyM/UXjl/oJiq44AMXd+C
         zTDHBePVS85THB5zr3IxosbWbuSAA9b67FVkHOPP1GY/zyKGIhGHdidyb50rJe9XqVzU
         OktQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXq+vfWMDm8IClnbLM7RMT4Soii2wwbCt1mwVk7H98pBAu7MJRjcFU0/PAMLqR3K+TCgz94w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1zfIvRYbwmJWdWmDvOjlOd0pCCFIeXGC+w1FY3XvNFxnkqOHB
	F6zVeWGpUVu1mXn2vwLvWGqPnCuim1wydQA+PyE6kegHClCYM+7RvDY6dJlOAga9Qu9mAZvsJHH
	L8OHFoBI3OMOfMhWsBpg4pC3iQAl4+9xduyg3fOPoSfdLPnByGZpJpNcqXrUzxMXesw==
X-Gm-Gg: AfdE7cm5Hg1D9EFgWWqrptnRSiC29j4oMyjxJOou9s75ldsTD3gE6yHaI6u9gKbN6fu
	5TPASjd2J79v8E0j5YroT9J0kDCbRYhHKUJ8I+pkObkYbaK0dj9dWKo/Eq5dqR2uZOcCEM558b1
	HApoDl1iMtbiQSPwdDoeOmQTOupsbwicP4bBna7Qr1CIPFv/oywpp5hUjk7EArvWRIEFPmt5pv7
	wplk7YL6/b/O6Ic8DEsx3+Jc9jNULjUNvb9UMuDLDQgjNe48zm+DmuakMUf0i9eHrdGZPHhF4nh
	9/XDIHtbtrfCzWIQNbwtQEb5rhZky2E/UYW6/6+XKxX1Bl6Pz52XLeyQIrxek6Xdm8s13vlLZwx
	1wFzBhAv48rYiR/AiNIVZn7kr12WY/SFhiVEVemllTRvd
X-Received: by 2002:a17:903:288:b0:2c9:c6f3:457a with SMTP id d9443c01a7336-2cf03d71fd4mr26990365ad.31.1784124637896;
        Wed, 15 Jul 2026 07:10:37 -0700 (PDT)
X-Received: by 2002:a17:903:288:b0:2c9:c6f3:457a with SMTP id d9443c01a7336-2cf03d71fd4mr26989925ad.31.1784124637405;
        Wed, 15 Jul 2026 07:10:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:10:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:39:58 +0530
Subject: [PATCH v9 04/14] media: iris: Add helper to select relevant
 context bank device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-4-8cf2cbe12a07@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=9226;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Pr3Au1H6jFHDbntQ1fqrPLFjbIEO/fGUoiMyA/l0Va8=;
 b=Knxt7iTd/66d1CzrRCKjq0i9jeIIFtmrZPtFqpov2XPdpDpfwvraXiYAg4RkLQoF11mQYKeOu
 2HW4tO+rb0ZBGLjdOeViBft6RdlNkQOj/xo5Bemdt1x//VDqOAxl/kD
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: Zrr8qfp8NNdTqluwVNX_mxAO8rjuPiIA
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a5794de cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=1mAbuoZ9JynoZkEgmloA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX9+3jeAuaIuBy
 TeZMFwou44pmG0Y6IfcYUfql7Ib6g0tHur7HaOC442rkF8897XnIGVhcjv/OJ29hlv/7XbJ6VmL
 Vu5PsM/0PFToBUIT6Zy+pEWCOpXqrUjJDmoUljR638EYNB0w5rMfml/SiHvlIW5YVufL5ctt2NO
 zYuMwYpPnZKycovtGijhc7ds8RAzIIEjLkEYPvwGylivlItUb1eaJVRdPN0tVDhyxrD0XCdg+97
 Xy43aFdNlzWHuaC033d27HYRagx2GOKWqxszIki/0YOL71nRrXn93h2CyKGsGGSDCB5Yjc2gMHD
 wNKKtzHM7ByGN2v6ryd50lvfqaViWO+t8g0VsJ7+KTzHwfm6Cz6HNIbgEMQkNip4NLD+IGpQPp6
 0pzHkkGtw+eRmh2BLMZUdRtr3btAGcb0qbLo7jXB6cecmiLoZO+cAtJypvZwFKC6kZrdQ/m/xfg
 oLhZJ7KN2ltleOssRow==
X-Proofpoint-ORIG-GUID: Zrr8qfp8NNdTqluwVNX_mxAO8rjuPiIA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX2TAX0fXTcbS2
 x5RcJr3UWKc5ohLXwlMCb7LUdOAokFYW72+KVrwaH7OfMo14EIcxVFGscB7fgQ63PVXq/jJ7z1a
 xx4kgXbUthxvc3NLTq+H4iW7f4dfevE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Associate the context bank device with the respective buffers. Fall back
to core->dev when the platform still describes the IOMMU on the parent
iris node instead of using subnodes. Those platforms would be migrated
gradually.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_buffer.c    |  8 ++---
 drivers/media/platform/qcom/iris/iris_core.h      |  4 +++
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++++----
 drivers/media/platform/qcom/iris/iris_resources.c | 41 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +--
 6 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index 246ad0abbac3..249c9f1d0d5d 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -529,7 +529,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 				       enum iris_buffer_type buffer_type, u32 index)
 {
 	struct iris_buffers *buffers = &inst->buffers[buffer_type];
-	struct iris_core *core = inst->core;
+	struct device *dev = iris_get_cb_dev(inst, buffer_type);
 	struct iris_buffer *buffer;
 
 	if (!buffers->size)
@@ -545,7 +545,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 	buffer->buffer_size = buffers->size;
 	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
 
-	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
+	buffer->kvaddr = dma_alloc_attrs(dev, buffer->buffer_size,
 					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
 	if (!buffer->kvaddr) {
 		kfree(buffer);
@@ -682,10 +682,10 @@ int iris_queue_internal_buffers(struct iris_inst *inst, u32 plane)
 
 int iris_destroy_internal_buffer(struct iris_inst *inst, struct iris_buffer *buffer)
 {
-	struct iris_core *core = inst->core;
+	struct device *dev = iris_get_cb_dev(inst, buffer->type);
 
 	list_del(&buffer->list);
-	dma_free_attrs(core->dev, buffer->buffer_size, buffer->kvaddr,
+	dma_free_attrs(dev, buffer->buffer_size, buffer->kvaddr,
 		       buffer->device_addr, buffer->dma_attrs);
 	kfree(buffer);
 
diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..3c96f46cf567 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -36,6 +36,8 @@ struct qcom_ubwc_cfg_data;
  * struct iris_core - holds core parameters valid for all instances
  *
  * @dev: reference to device structure
+ * @np_dev: reference to non-pixel device structure
+ * @p_dev: reference to pixel device structure
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -81,6 +83,8 @@ struct qcom_ubwc_cfg_data;
 
 struct iris_core {
 	struct device				*dev;
+	struct device				*np_dev;
+	struct device				*p_dev;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index bf6db23b53e2..ce6a682b0f9a 100644
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
index a685915a19e9..309a593d755b 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include "iris_core.h"
+#include "iris_instance.h"
 #include "iris_resources.h"
 
 #define BW_THRESHOLD 50000
@@ -169,3 +170,43 @@ struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
 
 	return &pdev->dev;
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
index ca53c01f60ae..2eef0676a146 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -16,5 +16,6 @@ int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
 struct device *iris_create_cb_dev(struct iris_core *core, const char *name);
+struct device *iris_get_cb_dev(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index 14d63dc76c9b..26df872fb4fa 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -107,7 +107,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct iris_buffer);
 	src_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	src_vq->dev = inst->core->dev;
+	src_vq->dev = iris_get_cb_dev(inst, BUF_INPUT);
 	src_vq->lock = &inst->ctx_q_lock;
 	ret = vb2_queue_init(src_vq);
 	if (ret)
@@ -121,7 +121,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct iris_buffer);
 	dst_vq->min_reqbufs_allocation = MIN_BUFFERS;
-	dst_vq->dev = inst->core->dev;
+	dst_vq->dev = iris_get_cb_dev(inst, BUF_OUTPUT);
 	dst_vq->lock = &inst->ctx_q_lock;
 
 	return vb2_queue_init(dst_vq);

-- 
2.34.1

