Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018A32AABE
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201536; cv=none; b=io9+zDgiSma9a7XPF2NwzYDBumTB9trCCS0UH0FxWJw65ZbfKmgb/E2wxGA1Txwy0utcQvE2Bw2OZBU89QhwcR1a8nQ8LC+BiS4tOFbEKqJZlp8/5LeCrTqrzKmzEXRlaJJnZpzCIU912oyHJa04wSkhRZaFjA0W49XCEJyc7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201536; c=relaxed/simple;
	bh=SeveySSfI/qJorH6pYdXtXF7iQfXTBV5dmrq8yjh76o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0pfkuMC3Wkyi32yD4aZrnG9eYRaUlP5A6yqtEzW3cctajNqF2CvHdEAq/X3rfuGQqxB/FnG9UGUeE/b3a5BagGsMSHS+jC2Tg8vUqBxnw2tfv3WVKscUJYZKYfEnbYS6jf4cS9t8A/0SKm2K6gZCOnmtLd/LXBYPVc3/VfiwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IvX+qADz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZYSSwpV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IvX+qADz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZYSSwpV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RA0nbY235868
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xTovwQOOvPdRglwYCLwleqlkL/0m7llVvmKdds1FO8Y=; b=IvX+qADzYFf2INaV
	DWVINda9E9lBVzJBD1RXFtfYG/TuvXRK/wrxgQx8T3zpqRv4sXEq+HY3ORgVEHML
	ni8aMC4dn/w5eOSetHdKqSsKcNhCLylNR3Hbs7wZRDQgXGH2alk9vz45ZdSEawTW
	BDeacLy3ZrjO87jM2GNvtGqBdd4TMVK5+2RhWpul3OLNEXDfbSX4Iom8TZF/nTFY
	KMRb3AXDx2ckxM2kver8EmfzR7bahpsevICgdQ+Bnfqnvn/C2DxGqy+1oR8h0Viv
	wZ3xRqq9NHlINX0irGM6xSDGdaP9/Gdcr2SSJB4Gh1EZN9NqfdCmWXs6YSd68kA1
	jDaOKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xttx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a90510a6d1so15914985ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201534; x=1772806334; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTovwQOOvPdRglwYCLwleqlkL/0m7llVvmKdds1FO8Y=;
        b=cZYSSwpVLOhpd5ysWCdY4P8ZYTz1EACjLekQPARogY4uyOFCu2aOW4fAaufCtySJFh
         UeIncmS422cXkvB36uaetD24xhmDaFzot4ESvngTANL4NRLsXQnZ0s38KeqmmmQiuiNw
         mpLd8ccVgTAkO2/OifBoXT49HX3ejXZM0Qgngo2qzmVBykT2anZybmE6qnFDzHB2dESV
         rPgIdU8MMFxDJnCzfJmuXHx7G0z8cSbJKQEtNCvxgsxb2Wt97Jj7qnNYtWrVkLH0EWnx
         XiCmoXmsQUTTfh697fZ7DPg3oha4TFaaBE0rkMPLyMRMZ6wRsFFgQbZ8Clp+QUv5JYxp
         tFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201534; x=1772806334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTovwQOOvPdRglwYCLwleqlkL/0m7llVvmKdds1FO8Y=;
        b=evOs9TRYEdDmp7RQmZtstnubpTGd6PPTwKMozTRbFrTF1TZ1ZNTRzeg3Wcr9P9tpFb
         8SGyh0aggZhOwyc0iXDVqOddGmitO65Z5xNp9eIPJ3/xqzBWMZqmK32rYYmdsxj0kItG
         7tXM9u2Xn4UrukZELMpe7VAAFTNKeNIi0oGNfeqKvXmSGIywvpCoJFPQ+JcLSEmsSAjq
         YoYmKs6hhCsVU0qzZqDv13qSjHX6ZQecjxRAFPZ7L41QMaFrjiFE6yHJGwvR3f7qmXkH
         4TYenPnt+ezzaG9kTNT3z157oDeI9HS+TObXhHH3Wb9TzEyQWNQZOmFCSRz1LcShyz5U
         FCrg==
X-Forwarded-Encrypted: i=1; AJvYcCWBC3z7blo6oZ3m/oXEf2ExiQKSaDeFcsOLBb9JXR2SvLsCVWHGpmmu8qTij1eD2/nOzTCohA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2hPjBSCDUH7Y/O4QOPd5dZKkq6fjB3wKJVWCKFBWEHnC86QzJ
	4VyfzaSiI9Acvysta/v2AMXUTYy6QNei+w/5KIpPgvD+AacSpxEyAdtWiHslH1UMT9ER+zkHE6S
	mHAN3zGR/hRUhqZcUVZLOld8S4nhplm2B5Oa3yOo8tr27Jr6GLDKRy/qVog==
X-Gm-Gg: ATEYQzwC/iAlaz0BuK8q+gYVbJ6nNHz3yFGg2D1gf/HZTBqUi3WPPa8L0UqieO3GWfV
	tNcA1hCmQ0NV1h0CooCyJ6mS+HFcd+AfUhhp8G5beGldHsRKGqUcgIkUSc0MWqEIdJW2DON1veW
	CE1xFeOU2xZ8NAD3FUmePyxp3LVhnunYy0AgLWeF5Jn0Tm2ZOP6HGr/xTt80yMUnDuTH9rx/Zsl
	fir/d7pI2ItIDefsDVsDh0o2Qfub0ip6vvuT2LVtslRNGoUuLY+sOXjqQjKvaB/lOzkea8dW3T+
	44whOo8Aazxje756W2e50R3dnDBc8mcfGStwBWgxNTkPu8yrqMFbUvuAgyCF2Pp/AikPZPL9b+Q
	tr2GBk7m14bMhllC4vlWbQaVaJHVgxOuhnGJcsJ8BbxcGIFpWBvCk04bO
X-Received: by 2002:a17:903:1b2f:b0:2ad:b213:feba with SMTP id d9443c01a7336-2ae2b630f38mr34326905ad.5.1772201533619;
        Fri, 27 Feb 2026 06:12:13 -0800 (PST)
X-Received: by 2002:a17:903:1b2f:b0:2ad:b213:feba with SMTP id d9443c01a7336-2ae2b630f38mr34326455ad.5.1772201532997;
        Fri, 27 Feb 2026 06:12:12 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm60960865ad.24.2026.02.27.06.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:12:12 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 19:41:20 +0530
Subject: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
In-Reply-To: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772201499; l=6900;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=SeveySSfI/qJorH6pYdXtXF7iQfXTBV5dmrq8yjh76o=;
 b=C/mKyfUHTEmJWqu1Vc2ZyZAu9AfVzIgQbZRGzwzS0g1aB/iKCHUUMAB81CuIqpQosJNf7M1sM
 PS8x8RradwnDiDGaDhL4s2V0NEqaPNWeuUVGvYjeIrerRAWQnKOcBuU
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: 1MDIYZW9S0UbhS9DCj4jxtVksxkroGZy
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a1a63e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=a9SONYdpYu3_EFigF_wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX8vCK74shmOak
 YZe6TFeNJxQixs4wIA/k6zBInpL4AncGf/8bmS6xDH3OuXD2k5BHFCskNhiO4lRKVXDJgCMx1z8
 xFGDpQkLzVIL6VGmHUut+gcPNj7CJpOJLVbOlSijeATBXBQQ1XBFCjnUz/hlkvWy8fjC0dzLa1R
 9srXi3xXNdqJZoFDJwURxOriXez8tqbR9MQqM2O66K97UPsLxBdJapoPSbiXfeLgknmdeFkZE+Z
 WH3ivRdsBPv4euqihmRabqqh0/TzT3F8+7vre+wS84yymlRfYGQglAepOSLubRuO3/GsBw7mNjq
 XTMwni4m619vNfFFlmFRejkEc5/zpLZOPkdQsm2bMuCu0wGt2sEFwmzJVuCVqgIerxE+yhZz7k/
 kI4NhA+js2E70oszSzM4wq4XYFBFYMt4kxEj3a1SPXtPa1SB/arBTidOuO4KTAd1eJ24drDFRAT
 u5143+FMFU4YLT+5pZQ==
X-Proofpoint-GUID: 1MDIYZW9S0UbhS9DCj4jxtVksxkroGZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Introduce different context banks(CB) and the associated buffer region.
Different stream IDs from VPU would be associated to one of these CB.
Multiple CBs are needed to increase the IOVA for the video usecases like
higher concurrent sessions.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
 drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
 drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -204,6 +204,22 @@ struct icc_vote_data {
 	u32 fps;
 };
 
+enum iris_buffer_region {
+	IRIS_BITSTREAM_REGION		= BIT(0),
+	IRIS_NON_PIXEL_REGION		= BIT(1),
+	IRIS_PIXEL_REGION		= BIT(2),
+	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
+	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
+	IRIS_SECURE_PIXEL_REGION	= BIT(5),
+};
+
+struct iris_context_bank {
+	struct device *dev;
+	const char *name;
+	const u32 f_id;
+	const enum iris_buffer_region region;
+};
+
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_HW_POWER_DOMAIN,
@@ -246,6 +262,8 @@ struct iris_platform_data {
 	u32 inst_fw_caps_enc_size;
 	const struct tz_cp_config *tz_cp_config_data;
 	u32 tz_cp_config_data_size;
+	struct iris_context_bank *cb_data;
+	u32 cb_data_size;
 	u32 core_arch;
 	u32 hw_response_timeout;
 	struct ubwc_config_data *ubwc_config;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ecb9990af0dd0640196223fbcc2cab..557adb038328a75510591d91569819abc0b7b1c9 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -123,6 +123,49 @@ static int iris_init_resets(struct iris_core *core)
 				     core->iris_platform_data->controller_rst_tbl_size);
 }
 
+static void iris_destroy_child_device(struct iris_context_bank *cb)
+{
+	struct device *dev = cb->dev;
+
+	if (dev)
+		device_unregister(dev);
+
+	cb->dev = NULL;
+}
+
+static void iris_deinit_context_bank_devices(struct iris_core *core)
+{
+	struct iris_context_bank *cb;
+	int i;
+
+	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
+		cb = &core->iris_platform_data->cb_data[i];
+		iris_destroy_child_device(cb);
+	}
+}
+
+static int iris_init_context_bank_devices(struct iris_core *core)
+{
+	struct iris_context_bank *cb;
+	int ret, i;
+
+	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
+		cb = &core->iris_platform_data->cb_data[i];
+
+		ret = iris_create_child_device_and_map(core, cb);
+		if (ret)
+			goto err_deinit_cb;
+	}
+
+	return 0;
+
+err_deinit_cb:
+	while (i-- > 0)
+		iris_destroy_child_device(&core->iris_platform_data->cb_data[i]);
+
+	return ret;
+}
+
 static int iris_init_resources(struct iris_core *core)
 {
 	int ret;
@@ -193,6 +236,7 @@ static void iris_remove(struct platform_device *pdev)
 		return;
 
 	iris_core_deinit(core);
+	iris_deinit_context_bank_devices(core);
 
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
@@ -275,12 +319,18 @@ static int iris_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
-	dma_mask = core->iris_platform_data->dma_mask;
-
-	ret = dma_set_mask_and_coherent(dev, dma_mask);
+	ret = iris_init_context_bank_devices(core);
 	if (ret)
 		goto err_vdev_unreg_enc;
 
+	dma_mask = core->iris_platform_data->dma_mask;
+
+	if (device_iommu_mapped(core->dev)) {
+		ret = dma_set_mask_and_coherent(core->dev, dma_mask);
+		if (ret)
+			goto err_deinit_cb;
+	}
+
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
 
@@ -288,10 +338,12 @@ static int iris_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(core->dev);
 	ret = devm_pm_runtime_enable(core->dev);
 	if (ret)
-		goto err_vdev_unreg_enc;
+		goto err_deinit_cb;
 
 	return 0;
 
+err_deinit_cb:
+	iris_deinit_context_bank_devices(core);
 err_vdev_unreg_enc:
 	video_unregister_device(core->vdev_enc);
 err_vdev_unreg_dec:
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a257b8ae7332242544266cbbd61a9..be58e8620086d0f82c2c2bda29247483f5c56d79 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/interconnect.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -141,3 +142,38 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+static void iris_device_release(struct device *dev)
+{
+	dev_set_drvdata(dev, NULL);
+	kfree(dev);
+}
+
+int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc_obj(*dev);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->release = iris_device_release;
+	dev->bus = &iris_vpu_bus_type;
+	dev->parent = core->dev;
+	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	dev_set_name(dev, "%s", cb->name);
+	dev_set_drvdata(dev, cb);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ret;
+	}
+
+	cb->dev = dev;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db095ec05e53c894e048285f82446c6..b7efe15facb203eea9ae13d5f0abdcc2ea718b4d 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb);
 
 #endif

-- 
2.34.1

