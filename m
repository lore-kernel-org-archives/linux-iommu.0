Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993271E4BE
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045064; cv=none; b=eSYQYPX1EcbQQhIL9LXWucrNmIk3IO7GsMnOBZszrw8VKA0U0wdX1gfmoFgvXGqvFdKHAgd545SIMddaWg93AxkzbCHThcn/dypbTvwxJH38SCczi4zCgaHDCwS6fOjSok6c4d6UZwsf7eKYQGMrV3Tswtpm0O++CeK3iijPHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045064; c=relaxed/simple;
	bh=TWnfmPOlO+mOYgnlGCly8Bm2gHmg0/p2SiB17+MZEzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Udovbwdo4cydkGfWn+aQ9IzCsi5PYc2PZsuEcQWIWPMmCYeGkyzEPyYO523jFYSLjrCALqpb6RGs1ADNVAR51q27XkZSkxSTYPi3j46nshcY0dlxmSk7N3ngurzUpfyTMgaEuP8ZYqte+uNfBBRUTWbAXZFUr8GtQ5QYcgLvUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Thwu3wnY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtL2/gPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Thwu3wnY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtL2/gPv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5RwhU925633
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=; b=Thwu3wnYw2XFL/Jf
	gWYqUn8DSgnPD8Q15Uy28Cu6aIdFJ0v9dK2cPJwa1cW0eEMavd1eTmzJy9VLggxV
	tOHL0vQmZIsAI9m0ki49kXyjoYRnc3E1J0+3cQ7iuO+nZNJft+gatGFwxjFkyO/C
	L0oOTLn9WSUsXxExK3KJg4C9gxix4f4wXcuPvAmYc+JB6GxM1CtTgMHlcydINBnj
	FEDidPG6WXHFCDtrFjhrUIxcqfQRBWx3Zaa3nVoIG31dEd9B5M2oMWLI8ICKt5dC
	fzGdU79scguSmNImWKL2YgD0RA7ejp3KcX/CUy7g+WLcw4bHOMsXjNpO3t6SkyYx
	6+Eyyg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjuftjtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso3371621b3a.1
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045061; x=1785649861; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=;
        b=MtL2/gPvX8JHT4bwtY4j9BY43hA9+aOk9aM8lSaRlMnOF6UUVfG4m/rEFMuygmTpVR
         f98VzMHQYaPBLOaF/XhVjySHgfrMF/MijHN6EBY7NWIddqdvNSxa2YXVi9mOZghlmxfP
         koEXLLYigZ6dbJSpdfzCocUtxU9ZGCmdA7a33JJC7zcReSBzfFihM/BJgEAgpAGkNVPR
         Nc+vXiZ4qcx9DeO84zCB6wsC2pqRGhDpoZIfgyE7xa1p2jSb2UrlNA5ZSqxutcuevVsm
         LArisg3eF+ztACIi/BmMdq+htbHYXrCfDtpzk8vQICxF1jhoESIuFfoZ8YgwOHvqItBK
         cIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045061; x=1785649861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svIy/K6G5c/If16VRcQMxrUiCQCVENhFRu4Xsi5uR6g=;
        b=n7j5XeBcH1UnfpdLl+fqbHwMwqoU1PkguoXCwHuAvdM2IzRkKT6NEeH4GLaJ7bc4F7
         TbdoHqPdgp2LhzAFsaZUFiV/EKE5Piw6pcMa2X5Q7+RepoTv+AP/Sj9MSRQ/vBt5a9kF
         Oy05FESt8cTJYgV8lLr9sgJgY2X2ZvhE6xfZ2vF5uJbpzp3+eCtH7aY3OHsDUtvqZrp3
         Q4eQjAiBTmrSyc5krGxSnuVLTBdoZB/9NcDAbvZ4muUvC2LcDSCxux5hXoXzr0+N8ftX
         EMC7mkKVshuKxT8hk1hZ2VJGiQvJDO+++Dqgdp1dOxfEzqihO4hkQpUmFHhDHXoDWKGH
         WbqA==
X-Forwarded-Encrypted: i=1; AHgh+RqgGP2x2QtQXLT1T4DGyBbTolrqklGaL7nCE8ogoW5GiEr2t+sVM64hsb6Nv29V0k3Dek/ZWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXyAXI2xBa6Bi09TXU9cR+XP7IDGqnEk4LY+jE//XSVIvUxKer
	FeIzru0XdTxTFkswSy6wawhGfi2quer7SvHHr+fVftBr6pa3myiHIgfrpmfxnVclypp+aK5jguI
	ThZOXmCufi6JJOR21SeugKmN49AsI0QFnZpaY4xPGwl9GvYweKOU5tc4gYA==
X-Gm-Gg: AR+sD11v+Voylcbjeji1A6OXRbBCKtONUU1w2MMu5VDJMD8Jdnq7IxSohmk8wn+ULKv
	WByiCrG1H3Nan9Ulhg9gum9vSXecVrJmq3HAkCGyA5jwJfoltbxsVXfz7aK4vKcgNIPaRUvOkYw
	lXgtgm+M2FkD2lmaYLsVDI/wulJPGiyeaJGs5bq6i+GwrTX0yihw6CHcadGc/07mxPm5NlnbyQv
	QcF22TJZUvJJ1iEo5ZUSor02GLWUg65kR1mHtdvVV3D/Mhz3Zzn6Ot5NhNcvzhHU6YrGuYLtijp
	oPu5jTxgGj42DVqN3nIOcqDXHCT8MT8aRdCv4tpwiJ5IFG2ToFGDyR6j/MnzU5BXFzSJYd0YPKa
	pC9wJldAxLXdqCc4UQHkOrdS8JxOEVn6zMQ==
X-Received: by 2002:a05:6a21:6e92:b0:3c4:33cc:502 with SMTP id adf61e73a8af0-3c67f2444c7mr3496973637.30.1785045060897;
        Sat, 25 Jul 2026 22:51:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e92:b0:3c4:33cc:502 with SMTP id adf61e73a8af0-3c67f2444c7mr3496948637.30.1785045060439;
        Sat, 25 Jul 2026 22:51:00 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:59 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:34 +0530
Subject: [PATCH v10 04/14] media: iris: Add helper to select relevant
 context bank device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-4-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045023; l=9226;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Pr3Au1H6jFHDbntQ1fqrPLFjbIEO/fGUoiMyA/l0Va8=;
 b=5DwXAVc4RnK393nunPn1NnR9+bUw8SypVVVoIvFKWb7uKLcI0KhzLZ/rYhhEPnH4MJIWjgZy+
 u1DKfT2oNh2AnEVovscBpdiFHGDR/SxucnbJhLdPZXXdAhvHpgoqV31
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: bWGFgLar4GEhWWQyHp0Ga0GfTlQsTVGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfXw5xMj34hgVid
 sG46c/h61sbyOiql+GMUREYBhdjU1+tAqhvh6WViCDX8orD7hKEHd1QtanXe1KHYEDLrSiNLs0i
 js0CD6VQCgGtsZH5guXCb0f7rIciWWs=
X-Proofpoint-GUID: bWGFgLar4GEhWWQyHp0Ga0GfTlQsTVGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX3qQxNzNAfxI3
 +sxzYYeItdYTXUjD07ElLnSrbK/WTeHrvUP+DXWgPbC7HkTy89HGlZw5ZDwt+dCaGAln+qjMbjS
 DZTpklZgAkF4jXPnLdvGYR9xnBL1Wq+GfnLuqH+btR2KGB4lyrzta8jYyPrtOArgvHMSqeSE1rG
 aJrT2HWUDfnTwX8W7McWFCYio8bKwSYUwzrDDQcKIgk4O16lZz5V+dd1hIFnL8sXeegBQih6wWY
 q/1vZqQMVY0YRUmdIwj+JiaX9DHuh90bJShuxbHWxRvWEiduuQTzA5qI/PPKK0N6xrhr2A6muaz
 KH7KJFu4c9p2sjV7Mkh36eX9ILgqfeIeZBlV73HYohkMBSgi0xWcDey+kpv3x02CheDFJMUVFdP
 Ozs+Dn2tTnJ3x1/OmQ5N2503V+FUAZxvCZjD4K/ll94fyv3GCuLxUdllUwtZq8rMNdetYJSTd1f
 dd1UYtV6H1Shq0ZMA3Q==
X-Authority-Analysis: v=2.4 cv=F5ZnsKhN c=1 sm=1 tr=0 ts=6a65a045 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=1mAbuoZ9JynoZkEgmloA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260054

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

