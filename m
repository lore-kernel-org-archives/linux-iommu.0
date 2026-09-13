Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8F400966
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325429; cv=none; b=nlYkIhy+vppSCvBfdZlI+gP+yJ9K2z5l8b+5xZ83Z7Uft9nNIZhl18BtAB3JsIVozIXqoDvUCjfDWtOrbNSHiFPKwxV0IThOR8odfyvxRj5TQDT5BDLshrZ7z6A5Vslmy2+l+gSzS8bXD4IiVOjq/yrIp+auWbfZfl7s/nFFhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325429; c=relaxed/simple;
	bh=foRnImGSZ75lU1r/edBBVgqmVHY1e0szEa/Z/AKAvQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r54SLCs+oVFz+0pTdyRhXP2oKAbCMcVaJAjrUMLn1R0eG0iNBpj3sH1XH8J7hbfp5G11wP/tK0bSQyMXYbpNjTgArfuJBnSyy6+Ohk+lFxKMdFrFlANXUTxGKgjEBxCX+x8fQV0BdWeFaDxAZIx+3q9OEyxP24/cS22N7kscjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGBdtJNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKnpIjmQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGBdtJNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKnpIjmQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2XNm3284316
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbz2UkA+ppLqVOobr/nxngPFs17FSqKR9v4iZOMb5x0=; b=MGBdtJNPFvOe1AtS
	12hXAUcOzZBXY4Qyc1T/pshHpIljnYwW7/AWZ2OF/9UEKWzLFzmkBQn4FILS9QiM
	SUc4QnkKc37RGyJKKIKtSPDmZlrHkaQlydodVi7pNt6+4L4D12ehiFV+2atxC1gb
	p9YqRZH29zyrNtDZKabbLy++r/S/obfxFBINh/QIoeSkdOx16/VEb43RibLzAzS4
	mH38pAdz9WuacmhcWXT4M6Nkmdv7unvBxXowcgWeaEGWP3TYvpTkQVAL7ft5JSVF
	eM8/P9KNb/N9MfuPudYSDh2d8r3fCfoH78+2CBhfz+JbCe+J8FwBFH7f7T/XK/GQ
	E6FqDA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cby66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4afc810bfso3507230a12.0
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325426; x=1789930226; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbz2UkA+ppLqVOobr/nxngPFs17FSqKR9v4iZOMb5x0=;
        b=dKnpIjmQwwiK513TqzVsWMTRfphxGPaR1/FBY5hoB0iTHyJulSU4nbm40FDbSfLUQB
         grdRRhG+X2Srgc+yq8QqU/Q4/tqWbcCOUtiS1QVYsccHvf9kMnWrvVzevK17Icy7poQh
         fvW5mdAN6ZNRP6CRe3nmPUDSLfYkojOOTJecc/PpwifdcRGy4YSJSqhrKAIbQs4rE0xp
         6Fg6N6xTbomsij0SooYzWnoAT+ThuccfON2fiRJXefC4ivq2zKSQKLqMa8t+x+/r1Fh8
         vAv9gbW1RnKlrd77oIX7Inxtqy/h+cUKhcdL7eEyNbHmm4DF/FDs3nOSk24al5pDDfer
         Hh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325426; x=1789930226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbz2UkA+ppLqVOobr/nxngPFs17FSqKR9v4iZOMb5x0=;
        b=T2/LWwLVspeAxL72pK/lOID10ojPncEF0gIGg2N3uqZJ8EfNWv5JDo4jF5/9Px6WPU
         0oJWsf0DsejRcLCUHWDhmyWTUZJr4rxYmhAeUj0GsGN+MAPT0/lWJIpfbZxuLPBo6/G7
         VujfjMcxwHOluwScAzCot5QhZbvwyzL54LqYnpEQe4esivP+75Yf+CEx+V8jHcumWj16
         XXTxd97qevIvB9q+h4VPiJGES5ZhL5G6j2mtkK7uUTECe5o4HWsu34dZt3XNv3PL9ZQk
         u5wzu7pZdKLQYNHuU64l7ja1EPikPOVI25+/uS8ZoXVtQmPfmdAs0fbIGMKhpJsQQmTm
         CjPA==
X-Forwarded-Encrypted: i=1; AKwUvBx5y8fDP8WbFhAXt3avOIic9s0AA2074TUjDTyIF9sygk697FI1hSHl1e7crPOJjExS/Svdkg==@lists.linux.dev
X-Gm-Message-State: AFuF++lANsyvYnBx7W2sOqt65ts6QLTpKio9i5yiQH6eAikdcvMHJ5Si
	+2Ra4UsStcVeBZXUDADVvn1AebLDY53DRDu3Ps5cYR0sCY3JNae3qLolHdRK3TFiVQdeJ59NjZQ
	nyYEXucigLDjbM7R2ING919eyNnEDrChiJ3fKq8/twX4QVlnH4ztZ/NDsEw==
X-Gm-Gg: AYBFou1IBtVwTSJOhJrjyqOhe3cZjxhW4G1JH8DFnJEo4kXzzQJVEQXIX1GoyiLybIk
	gvVXBBuci2EDN1QnhDBodf35fxiQz4iSU+vklA8l1dpWH8bhsF/EhNcXcC4Zo8R5cf1JpWqcwZY
	zmUyrF690j1eubC8wL8cfz1bBw5z4EsFM+G0TJvVZpzaRMov/hKJG7pzNS6abmP1flVg6AEXple
	7fTXFFm1Hcnns3t/8JrCG0aJBJnvtuHJqalrGi4hhEOu8+mHEPReKHkROxYVh6OUgDB1+dpml0o
	dMuxcnl0VqtL75IfD4oIcVWc02OCiK3HP8Zqo8AqluDKhYvsAYPdhJiyPWy+/Wo6s9AA3d/SO1w
	hcptMOVxd49mG0borJ+6p7A4/YMNowWHF254=
X-Received: by 2002:a05:6372:a703:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3db26e544f2mr3652636637.17.1789325425510;
        Sun, 13 Sep 2026 11:50:25 -0700 (PDT)
X-Received: by 2002:a05:6372:a703:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3db26e544f2mr3652619637.17.1789325425071;
        Sun, 13 Sep 2026 11:50:25 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:50:24 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:22 +0530
Subject: [PATCH v4 05/13] media: iris: Add non-pixel and pixel context bank
 devices
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-5-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=6003;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=foRnImGSZ75lU1r/edBBVgqmVHY1e0szEa/Z/AKAvQU=;
 b=7iP01YumWQ4RTSsHPLURYioMXAP6EhN2fZAqMRwVLVthIFnByJuGbB8kd6k8z/kAZ2LKZBP2D
 ir4fISCg+DDB251umHmR4xQxe0w8RSlJlZbbEg1YxtrQGe6VkofSTlw
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX/pdefoN1eetA
 3FPrCAYu72XrfZ7WVobTChpJ813BSbedGSzBesRBHEGstC/iV0mlMJUz1m2stbkk0cOb3BxLvqL
 7gfisTc8n+aOB6plxO3nPuOFs3SiHRo=
X-Proofpoint-GUID: f0b-_GHXxWyJsWvQV1lifyf-OXjyaIXa
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa6f072 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=UWePQM47DRlDhC0KtsoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: f0b-_GHXxWyJsWvQV1lifyf-OXjyaIXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXwmhyv3z5fJTR
 FOE9ao4oA6XUaWLFVTsHPMaaG9y7yzCiPv1goTbdK8yNMiJv/JRpufM07oDa+P45zUQEo9256VK
 njCv2NvrPm+6I7lTmqcgbcJgoo7C5E164sEW5KUFV22wfNJ8fi+DMRiMKTP0kAAc/3YqNKIEpGx
 UGUztGcXR3ERqSdD8ScGKt/44GmCUOLEG0DiKkvEJshjU6FxKg0A6dpaDMJPXbwC39hQaSplSyJ
 Aj+KYVpxth8/CBMYWoyqdu6ovyxkTJdI7NiDmj+Ii3+/3um5t1+IpqryZfYA7M5uCX4OBL8r6+h
 Q8WJI7MNzo4ENPHQXO0vD89k+tUqQIkE1VF40YBVDjr3U6SiMHBE1NHc7nyhI+gyufdQQ5XatZb
 yDcl9QK9de30lfsMd/j4O8B++6022eeHynyeGqcWAxg2q54d6U9jc177iiZ1jZPEFu4Drh7gXvq
 WbjVeeE7f1MKn/NHGbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Now the device tree describes "non-pixel" and "pixel" as separate
context bank subnodes, each carrying its own "iommus" stream IDs.

Add helper functions to create and clean up devices from these DT
subnodes, and call them from iris_probe() and iris_remove(). This
applies to the common probe path as it is required for all platforms.

Set the context banks before v4l2_device_register() so the DMA plumbing
is in place before any video device is visible to userspace, and tear
them down on the probe error path and in iris_remove().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  4 ++
 drivers/media/platform/qcom/iris/iris_probe.c | 71 ++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf24820af7947b85eb7208555ab7786..3c96f46cf567b2802148b2a7cedb8488b6b9468b 100644
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
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index e4acf4a74f944bcae83089ef5489f204d4b0078e..debd1f0e57038d7abf463e82fd80f887b67750e8 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -150,6 +150,67 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
+{
+	struct platform_device_info plat_dev_info = {};
+	struct device_node *child_of_node;
+	struct platform_device *pdev;
+
+	child_of_node = of_get_child_by_name(core->dev->of_node, name);
+	if (!child_of_node)
+		return NULL;
+
+	plat_dev_info.dma_mask = core->iris_platform_data->dma_mask;
+	plat_dev_info.fwnode = &child_of_node->fwnode;
+	plat_dev_info.name = child_of_node->name;
+	plat_dev_info.id = PLATFORM_DEVID_AUTO;
+	plat_dev_info.parent = core->dev;
+
+	pdev = platform_device_register_full(&plat_dev_info);
+	of_node_put(child_of_node);
+	if (IS_ERR(pdev))
+		return ERR_CAST(pdev);
+
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
+
+	return &pdev->dev;
+}
+
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "non-pixel");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	core->np_dev = dev;
+
+	dev = iris_create_cb_dev(core, "pixel");
+	if (IS_ERR(dev))
+		goto unreg_np_dev;
+
+	core->p_dev = dev;
+
+	return 0;
+
+unreg_np_dev:
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+	core->np_dev = NULL;
+
+	return PTR_ERR(dev);
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +268,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_deinit_cb_devs(core);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -269,10 +332,14 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	ret = iris_init_cb_devs(core);
 	if (ret)
 		return ret;
 
+	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	if (ret)
+		goto err_cb_deinit;
+
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
 		goto err_v4l2_unreg;
@@ -306,6 +373,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_cb_deinit:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

