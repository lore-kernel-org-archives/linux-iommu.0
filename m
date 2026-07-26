Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE69340A6A
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045057; cv=none; b=bQ7j5pptYtPEgm+LD7VcQSQ9VMbRJxgCWhW3/YwcMSFwgQVLeat44KzH0Hcd2P+Bfo3c63k1n2PFNyiuaMT2UdC9ZXcmJJ5RMPt51C7nN0Flsu/RYgigAsdU/xTIz9BErJ0bwjMJkDFRTHVAu4P5+/Tkxz6QOehN/GyUlu2nz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045057; c=relaxed/simple;
	bh=Z7a+KeKlfsd6hODeCUGUk5GwLjPusVx49RSzZ6ytvIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxUzplGmYcXRfMBGBzPVYGrF2jTxEQ6h4XZJbTdLWaGllNy1FpcglOGR03aII0n0aY3vSkYM1yez2lt/++MnSesVdjFmDrc/JgbRAhdT+LeZX8Yv1PxZzivYyaPXHC72smhRpxhkd1183eGMFVy7T4Vcw9onO4a+QmQXLHTe2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcajeMbL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FaMYd37l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcajeMbL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaMYd37l"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5SmZL4181774
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=; b=mcajeMbLXptZM7Y6
	Eik9TsmaAXR4NxoKtPL70Yd/+mz49v9Nm4XdLqOpY4QnWlgKDBZtjfym/D9n6rn7
	nDA14Tnj+p56QojG2qM3c7TB3/mH4MocrhSrIiBD/Bz1JHww0syvicOy3cW6Asyy
	tV90RhxBbffKK7KrVqVL3eEwUZXzinaYalo8MyRnHPN8j4DUyS+vspwne+3EhAtz
	v/bOCKJZpDIYk9FgnpDjvExXFMlgCguAvr+9kmPbvsCORFFMXsxSnRsQWtbXOGhm
	TvfmjGZqqSZCqGD6MQckGs2o0WMFRxiLThSIiXgNy2t9jr4UnUOf/880DMTAB7xQ
	VK9yvQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm572fx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2242378a12.0
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045053; x=1785649853; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=;
        b=FaMYd37l8mfBuGD58U3wan10f+oF9LvaNSlh2W/UDp/OeT2moAtEc/sgNlJhH61QPy
         SfU3Z9PSPwcQ4r6Z3kf/aNyOJA4wlM+uUy1EtyDIACYPbCdPLjD3R1tOcKXBV4Jb/t11
         vqQWNBwdHfkoGxd6ZX5VxqssLaoWzRCpGMHAEzNIbEa4LT8TlMIXIu/s7URzvwruNSz9
         7hNNnB/p1zdjKwqfk5J1wafng2rTddH05DwZVq5IkJhCMlzRHoY15eprrsQ07YdExr4n
         YkWlTbzCSaE54ZSUwThgDvCd6rXqfmtRdlhQIlVFs2cpZPLR9CneeCvLrRbubs1eiijg
         fz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045053; x=1785649853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=;
        b=T7W4JtwLdk6YhRqcnFx5gKiEx3vuv736BnrMB0zvDOxJGxQrv3IOgBbKPrftlYLXIg
         QqfWg5nHYKsxamTbBjDobJSdvYzY7Xd92g0xCuM0prxxJnqaxFVur/UprQyMrlPW7X7n
         rKxzT0RD5PNt4M1ytAaaiyZxeYWXi/wf+ZnJ8qhVxtxk/svSBLHwdqFweNwPtgIF7Jpb
         ED5itE3Ew5tj2wZe5IxQceK1YmkuGSg61FK3/wuG5EQEC/wufAN3A+OCu+gauZwIW5Eq
         2v9SW0Fw+cVenK2/c/ftKWCBrt7HxSQcEmTEwV7z1KkNQinEE23Fo3QEZlYu7bih6ulu
         beUA==
X-Forwarded-Encrypted: i=1; AHgh+RoCo1GLBQ/IywSsZpvNYG2RAISxsUnGdcUZQ2RSwp8/aIbGZDz2FC4w6VXxBnKAii8B4FdvaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6f1aeFMopPCVQ9xLFakwaXx9AjuyrH+nX3bs7/dNdNivoPCqM
	AHNP1IDhAhNSUizNTxmX6YF08MxffrMoOroeSiprFIJzn9FN/BAuc4aAcv9wmXYo0qYlmJg6Enm
	OiATjh18dlHFNpWIkAGnY0sgqu8cd8s2XGf7UbuK45pdbCng7PgqEVzQoLg==
X-Gm-Gg: AR+sD11D87OTmV3zYJAQ8U7nhAkGH8Cq43QOd4959cenBFi2RHAXo6c5opNVniFMJsB
	oF1F94CD6SEmrnp3jz+6PJXDTB5Kmfq4WGeUpS2SST43nAIzKPCQiBvHkW4xJTY+vhzcyThMgeq
	/17pU4yLQqDinW1A9tDKjWSNbkTAr/zGhG4MICuTKAPQXTcyba4NKHptPgoMmuHutrh83ar8OQb
	Bh8w0RVaqIHLo7pLXc4CVvdPvCgIZG4nIbhdX/z9hRFh7Tsg4TuZWun27xQLmnZhoIptO4s2DrW
	wpz5W5kEvZOZGnTZsrHp0dgF9mwcJYV8fC5m+a9v43hm9QP+ynEgTus3KTmf5Yq0puI6sbnYyvK
	jugfVhQ53hSyYSb4sDvztIPMcGoERJCwDYg==
X-Received: by 2002:a05:6a21:1b85:b0:3c0:b943:f984 with SMTP id adf61e73a8af0-3c67d9b3996mr4129011637.3.1785045053568;
        Sat, 25 Jul 2026 22:50:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:1b85:b0:3c0:b943:f984 with SMTP id adf61e73a8af0-3c67d9b3996mr4128987637.3.1785045053125;
        Sat, 25 Jul 2026 22:50:53 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:52 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:33 +0530
Subject: [PATCH v10 03/14] media: iris: Add helper to create a context bank
 device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-3-de451559e88b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045023; l=2769;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=YR+PjYPX5zksaKJC/NvxWsdFNoGva+12VxA4G3rAknc=;
 b=1WKoEGXdpkaOLMFx2u8nhiqOuD2Ea0z9ysfgEhptyWVHCZPgU9u03S4S0ZfRDKDxT4d41X68h
 W4mMKZnyk1sAvkMEZSt0Kf+ZZidcB3Zl0v90e++Ng+36MVTxbRS6iC1
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfXwRFgJsuuKTlg
 QOkwJIEZqYMjb2LFYUe0KAO2D6BFlO9e8zeB1ogrGQcZuDUVyLWc949I6BN6eRz3VcdV5a2VMIK
 TYBn0PfYCnPpwxevMhd3KEg7KLUMv7w=
X-Proofpoint-GUID: DqcOv9ySfLvunmFds5rlcrIdvrUfMv1f
X-Authority-Analysis: v=2.4 cv=FOErAeos c=1 sm=1 tr=0 ts=6a65a03e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=11-_c5lL_m6SPrwGrosA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: DqcOv9ySfLvunmFds5rlcrIdvrUfMv1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX0uhlPGOS7gPc
 SrFNvKkz658+L/kgrcmCGpsB+Sx2mTdOWc7cYfFY4fgLrP15hQR7ScjUJ++70+05CQ9hrXl4hc0
 wcj4T4m4F+Exg1gNUuZz+f6mS0I8wFQr1ZHbFepqA0Gm+DcRqP1K3kx9FxTeH1ATVsVk5zp+9rX
 xeLaeAnfzKt3Dek3nVHHkLin67F3h+UEd+M5n6Nr/8tpBw/aoNDGkJyW4nQTuD/SMZKLFbx/ppq
 Tc8odEVIMHVz3AMn6/S1CGOK/gjLQnBg7WUvqZdwbdSRYNBiOC2N1XFcqm5HcijqEzHosi7tuL0
 VUOW7wYrMc50GRRaMtHAblcHnDbgu0VJsNyNrN597mf36DYfHsjl+ZXNGbiGuliBvgFRh2XKCTT
 /g/7Ipn1nKc7ohh+rluZ+cLBgVPXj0avmKck02XzheD+L3NNGK3z9hDR+rjjO5C3u3cFGHmKSfm
 c6xFGKfYpMxBsSCtmOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260054

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

The subnode in the device tree is registered as a separate device so
that it gets its own IOMMU context. Pixel/non-pixel buffers are mapped
into these iommu domain, to ensure they are within the addressable range.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 28 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a..a685915a19e9 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
+#include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -141,3 +142,30 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
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
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db0..ca53c01f60ae 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name);
 
 #endif

-- 
2.34.1

