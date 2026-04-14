Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615E232395
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142857; cv=none; b=cCsqEQctORtA2aSbMyqiRQEJdfn15jTjIkuW2h86qgIjyLVAu/XXcNUaUB7TXpQl6jdo/3IU4PFcMOCldlwV/aGA7G1n4Qg+lzP0bxpu9w02u9Z5WeylohQ3JKzJseKTVIwjcGJhgKw5nNGcJQjmEzOrngGaiV2TRJrQ0sJBFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142857; c=relaxed/simple;
	bh=19ZbFSBCrYzOoPAiGy4JxnUJmqAXRaE9OkXrzqWaqeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ly1+JmVRO68aPGDHtFoWNZMYXuIysGHH8xz2Gp0FXG5jjoXeghSbXvMm2gclg+phtja8C4VCm2WaSWl1dg5bE+lBcyoUumbeNQt6Tjc4DyQF6gsCdiUfVcW/Tv0OgxAw2oboxCbEa6y9M+vOxtcoAqnM337NfqhZkS8iL8ar/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLO97UAN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L5n8URuI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLO97UAN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5n8URuI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLDa7x3681487
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B83PPF7wFaLIu6P8FD8mebyOE2HBnaPVssabvl+NtcA=; b=jLO97UANvHvevt0V
	z9rEYqhZdFfOp8FDxjChbgfbWKgwqjyWRp2Dr2jSPUMAwTF2oThTTd24/De0r5Zj
	/4AYbHDFqeY7pvqp87iVvYk+lFqAqkISsgfH8b7l7IqSN1VuP807MwF8BxxlC1DY
	a6rQz0NYo5ciuPMKV1V1DSscETlPXRKYd9GcFkEyPMwguVTxLqJjhPhr7MJFbSFs
	VYnt6abzazI4ronkovnH9GcbYK1AUg9kCPJi6XDNU45xhlXt+ONbz46FLXeHHRe0
	XTTq/vL60McNdidRohoMwXZXSrcovLJZmjmW2cYmJvK5zXfqtMupMnAYdSF6b1qS
	jZmumA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d122q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b249541063so48143795ad.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142854; x=1776747654; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B83PPF7wFaLIu6P8FD8mebyOE2HBnaPVssabvl+NtcA=;
        b=L5n8URuIDxUWPZHCKCxLfHDLbtAkG4CKcdf6UlBHxxPBpHj7t9ZAiBhjBojfxZe+AD
         hels8c1g9vlVKQMqHH2sUpVmLrHe2tBSh8m6TOe9iTXBSqSDFC8If4vhkJRCvXbpNIGI
         SbgILHmJW1f9Q92Fu7cpn0hYKPKE41kf7n1nMZCRm7opD+5CULKeUCG36SQ/Dr+JaTp4
         0+lSMSzN/EiANJkmzVrMBkhSr9bYDMwBI8Sjsv4DEm4FwGVtvHFGBeqGXoqA4LXIvfnl
         0TZD8cOncfoJhw6VkzdVut2397wjr/nBbTn9VfNwO/Vf9VI2VR+Ixs6BJ6f+e+EjUJE4
         cZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142854; x=1776747654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B83PPF7wFaLIu6P8FD8mebyOE2HBnaPVssabvl+NtcA=;
        b=tQ/ClhGRjTGrWxLjrazcMfdupI1VAC+QcV1bs8OEl7pikR3GJV5cPFYl/qvTaA7oy+
         bqI/RQN3bcC8S0kUZzTF1lVKIcKlY3P+8IJQrvZ7t5oSeCGu48N4hvw0nPe1GWzZkXZs
         W2+G8JOR4LpuCEJRTvbNVqD4oX6yUqAcnLeCxN70rXJdbq9jYh1VKKasZYtKAMUHBUYc
         xFT6y/z0Zq07l2Kh9huvzWuj2sLjl2fdBDcfcgiQPwfn9wbXbmf0Ij2W5ximl/uIUopI
         p/6TB+CG8umf9xfgMU6r0toTDuK3Vc993jNZ83Gb9fY6dkRujBrURinbemePoJVotsZq
         Ah+A==
X-Forwarded-Encrypted: i=1; AFNElJ+Hm+/KKAyFV+goie6SehoMjUBF05bGTOcV8e/zZPi8YsNQleeENDNi3cMZJ3iWqPcBjF7aDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy72KqVBKuIT1JWNA0cX05/gXFWtI2ZVpej29t+uhIX7dkemdgd
	rZEFBhH38a1DdHt+Ubb/jm4yM4TnMR3iKXsG2LElS50IQKpbiv1JF6uhrnJDToVlNbBh7jilceD
	D9GSUHHuEIPaMLUcQ/RVsbbcUsrAKbaTosGT3sYdCT6GkHxv3SpypjUaiSw==
X-Gm-Gg: AeBDiet0XWU7wN17XWxsJ7CPoeifPtQ9qZGaGFWwjrZ2YT9vlCcCWKBHfwEqmMBjlSG
	E7ECMiepxXKt93iKF1FTgmhSUqxPKrvQZRpUEBjQNK37RRmb1Vyy6Qg3GfA9cw3QWruZun6AS37
	wLTMfNmEED9qRkyxf/cdx72Mg9dMpYGONUS7dwz+evKOIZIykwijQOBiPYVIqFFimV0O8lKY0Sr
	SQ7WyRkPfCIiLdArh1uurSIdwNu2K8HIbkr1Ta5VtpOB/y+yyeKSVq7H4RKlQV60+kFJml4DTsr
	DYRwwrDXywv29Vjf44gFXz5tzOgCt4/V9uwbVYACAIhSqXu843KCSzD35EQF5Pub0mcRscbz4aX
	wI8Md1qSC3l7GejLaBQuOg2gqlNx98SfbUKwddsmz+kvzcq4Db5IzS9s=
X-Received: by 2002:a17:903:3848:b0:2b4:678c:5f1f with SMTP id d9443c01a7336-2b4678c60a9mr31930265ad.0.1776142853565;
        Mon, 13 Apr 2026 22:00:53 -0700 (PDT)
X-Received: by 2002:a17:903:3848:b0:2b4:678c:5f1f with SMTP id d9443c01a7336-2b4678c60a9mr31929815ad.0.1776142853078;
        Mon, 13 Apr 2026 22:00:53 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:00:52 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:00 +0530
Subject: [PATCH 04/11] media: iris: Add helper to create a context bank
 device on iris vpu bus
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=2621;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=RTVvha8tR9bEWZ4zePSXsWhj5E2tt6V6KZzPhLuEtVE=;
 b=c+4W8E2T0rh0OB4HD2rAue10deepw7qHz+ZmyEpRFa2vnY/uZwGRfZieuCnpxWgESFhgVPjtn
 TQrqVO/eWF0D3kJzgO28CucNG+6nQbjbURMD9+4OE/ZsGfH5WP9nwx7
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfX6Wm5d3hyiU2F
 MLLu3qia3HcjOlLyrssc8TBb2RkuTN2gcSwpia53fZBCoMWl1ARwV+Fb8PcSCek1UjYdgR8o/qB
 mT2eWfyc+oSXycylS/aYoizuCd9DI0bJhSXI7qakyCLIS3dyLImzNekqZ8w3IfCKcU4GhahhJBM
 hbwlR0B0UhDRS/1rV5OtCL0LN9La9Yeql1pmms4UI6PAU0cuFxgrTso20MEHAmnVKVXxo6yBqZv
 upT4j5ul5St+v/8x0QOnif6Fw5CrEmjUDEa1i+H0ujJ+sC7WaB/EnN5X9W2i8qTj6Q402rCfKWh
 FMOa8JhmQHasu++3inrEfSkTG+wHqszsVCHvMb09MFY0i7e4dLz5SlotIYbdLJ6yN6iGv6KTuOV
 0p+TGquMhkr56Ij+rwhM9qX90Xmn6WjjmuGxr1yoQxtnpMe0w9Vj6QQgMqAYld++hADeD4mTfwA
 vQ2Y0QuFI0V/kts3tCg==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69ddca06 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=yC2GhcDpJLL-D5KBa1QA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: aUM5u1vTgmnvE4MZro1GlNCBev3mIHbY
X-Proofpoint-ORIG-GUID: aUM5u1vTgmnvE4MZro1GlNCBev3mIHbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140045

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add a helper function to allocate and register context bank (CB) device
on the iris vpu bus. The function ID associated with the CB is specified
from the platform data, allowing the bus dma_configure callback to apply
correct stream ID mapping when device is registered.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a..a25e0f2e9d26 100644
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
@@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+static void iris_release_cb_dev(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc_obj(*dev);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->release = iris_release_cb_dev;
+	dev->bus = &iris_vpu_bus_type;
+	dev->parent = core->dev;
+	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	dev_set_name(dev, "%s", name);
+	dev_set_drvdata(dev, (void *)f_id);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db0..4a494627ff23 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
 
 #endif

-- 
2.34.1

