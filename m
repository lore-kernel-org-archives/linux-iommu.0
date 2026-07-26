Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8C328B7B
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045049; cv=none; b=htHPnQ6NYv/zJKaTDB4GplmKYp10KlgkJ5XRrXJebU5/Il57di5OgudvWzzhZawVoM6XwO51Ik9cxX/MXUAjARzOx5g3+5CNn678CCpMpG/xdcL+DZMZxZmsjOuwYppJbQlIyIlEvZXrwi349HrVNVTowwTNxtQmdivW4GLEt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045049; c=relaxed/simple;
	bh=tBM4xBzn/Xu0jRn9xB3qtH2PBSvLI/9VGMLOvNw3o5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv6CPW5aGVC6Hh0g0E1Rh4hszGQ9B3xGw+q3qB4w/FqfobUyQoeJmSGaLjarpPMkLepf7jST29SYLz6kWrx63c8UEvrqp3yhF+Q++xb3NmSCO5wJFwesNowyt1mmh8KwLQOGYk5BmPvi/Snc7ofU3/GTrWJqNBAu8C5Bc1P+/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N37zCBU8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B966ldL+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N37zCBU8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B966ldL+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5S7m4094454
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=; b=N37zCBU8zi/kdZS8
	xqMzHzAyjPkmopORF5sszGCBwCvwctFg9mGQHQIBCgPt5eqkdunlfCiDFDh4hvB0
	40CKhx9aQlAWJcDy9O369l8biS2Arr7VNW9WFXLwN5QMHpkTUArVUT2VNr46/5CF
	3HaIR225VwQ5rn8akkoBY6jckqN3qNoRh36xQhGw14ryVPQX/ZkORGD/yiEGh9F2
	HHqKdnbFq5Dqg00mBGasOccouiCSA5PUnTJK4tknduubts1ylYJyLcaTssImyKVo
	vm3Lobos6MiWpUEgPYf6fGgIer0O8EevzLgMAdGy5yEN308pNq39jpWS+J/2WSMG
	qtJ5eA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3saem4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so1938577a12.3
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045046; x=1785649846; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=;
        b=B966ldL+364/BzlCueBOD0we9DLTpSYnYR9yCcjsO/iJechhjWcLXupY+Bijzbll3c
         KA7MWbYaFKcW+DsQbEyhqSD90vuv1UFrcg9AdJ2iOQ67nYzByiI89O57xArSFwv5VNJL
         N/v+o4E2pzWXcVl6Heyt7Y6cigPMFW3/cIl0ZUYhWHjn5dnZi47telWGNcQzoqONxyxG
         sivwguJnA6/JVzc61QuVgrcpGmVhKRtqI6H+PKr9StKT7EEdfy9IVwmyPv5HSg1jJzo2
         kI/ipup2os3VJArknJ8yuwN8DFfDdo09Rq4AZSKYmo0wqhnr2OX8Z6gMmXcXdUi59TSD
         B1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045046; x=1785649846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mG+MV9RqZD61fcJc7fhHYvKrob3dAixJSqJ0wMGBFsQ=;
        b=LIHYLxqCHhCc94+1ue/1js1HLl0wjCFPLpL2XQVxTyjha53eaXbPbyD/5nozfYd0qS
         UswpYtMWVgj9WAXR1kpEypdbTFFXUyhN87k7psE5kkh5U+S4auUYuhoSNX9AEIQJYMwB
         MEQS4+N68buhf0hnhJb+N5A5T6g11KPpF47g9w2vdhCOE1TJz2JDKD+GyK9RFGeinISI
         SS2Ns352Zn0k/KNJic4jsG0txEYqcoaks+qquevQGUcVOsotDggtCZf/d1GXpCtSrFm1
         6EvdTyETXyWczPmdmrK/oNGFgEea1BvZes32AcXH4qIgWnrjXtlSK7R5rF4yZwt+qQsG
         42oA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6rnu7OKAII/Z1O5QBn+pQoMxuyI4AUi14JpsHsA9dkgGVts/7oTzL8gD2611zJvkzI6e1dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwhimkuKiNpLDH3UixXjz72RSwtUWcuK8YGpQHQ0eP+PFcqt3U
	l0D3b0wWSXj+ewbNX2PzBtxpJTc5108HRI1/VqaokAQ14gn7wzIL/AwikfGADTHCG1UvcUIS+as
	8ozF0C8vggpN5MHMvHwl0Rt5rWAvFD49Dmr7NniYDzn4Ohi6FM1LcxKHTnw==
X-Gm-Gg: AR+sD12jh3DDStQIBOe/2NkPi3/1tpetsbV9E0B/BAy0dwVMJ5YYmt+V7KVNzv2kPpB
	nN07DbrRpIM6M2+LmrZcl5dFA7pILnzc4/fwgi7lPaeDvmeN7aCy3jcHPshNheKk7ayWFU2Pm+M
	SQpbEbjYIy7uL5rut2zxzsIeNpN86cd1az7JQrbSCkUML6rwrNpBCYtXWzahdKg4xJZGCBlJ5Sn
	f3Ua62juSsBjWTtHebnxhwLUNOlXieJpq4jRoEUjBlfwCWZJAWo0yJjjwLNj2oSByxZgyN8xvZ7
	CJdDh3tBIGTYehbke5h40o1QsCOC+BHwbCNr3116h8RfUAUwbPlKGPyYAhZaf3gpCs/2o9DIMkL
	RLOMOvr8cxd9ylMivVK6bfWrkeVUKMyQPxw==
X-Received: by 2002:a05:6a21:6490:b0:3c0:fab7:bee0 with SMTP id adf61e73a8af0-3c67dfc9683mr4262728637.62.1785045046436;
        Sat, 25 Jul 2026 22:50:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:6490:b0:3c0:fab7:bee0 with SMTP id adf61e73a8af0-3c67dfc9683mr4262692637.62.1785045045897;
        Sat, 25 Jul 2026 22:50:45 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:45 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:32 +0530
Subject: [PATCH v10 02/14] media: iris: Add hooks to initialize and tear
 down context banks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-2-de451559e88b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045023; l=3226;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=vPJQbRQVpDgoYGPs3GH5JVsYjK3ZXwBn3AcrWWr9aTo=;
 b=XwBLiFhIVnHpxd4zWYMjWy4pc/AV406X63lpq8cOlyRGrExG1AxdzgP2lOhtlblIPjh0ZRx3h
 V/XvNHAJ3gEAdGggO/wK8bgsXKEcqrceUCN9yhm6Bm/L419fbzCFruk
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX7HoAHRS1cES3
 NJC+TNQdkwS3iVajIEDgW8l8hXNKV1gI0s4avgL+WfzfC0v3VAvnRvGgoebWNAR/eeaERr8ET3s
 fmXR1l0dlHKt8LWb//zUXLBtUEj7ShbRx1IsZXm/LzmxY5lf0HGbfD39YW8k1XzasKImyrbGeHG
 /cobT4le2lmBuLWpvWYR9HYdjKQ21Iyh0wgTEIs5MnnLtHIRyIYyHazHbk1VY84CtiT9gHyfjbh
 7Nh8fhoRewWwWTOEO6rWeMxZsDhLgQ8a1pYMSE3S7ScSyDFp7aDZ7O9EnJSBoGIjJZgIYMWqotQ
 c1wyAYB8o+4N4e8tH4oZO/Gqg0M+KgCu+ynZ6OMbZphaaHM2R1miwCNr4w9DOqLX53vDdEh9yl7
 nlRxdiT2oDkcKO73iqyVgR+K1EPJ8p54bL0AN6WFpzlgrHJUkp73LbXv5b+qtxmoQMyulW23ZQQ
 zCsaB92kKNP26in3VYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX/p3F5ZIKdNMG
 dSyRqvOovmU1QDD7xhhPQYOxXrlpNaWZr/EfEHPC3VzPGWbOLtCx11frAE3doqF62SaEeRB3SSq
 LjLs9wc8+AGoZiSH0f78n5fMmdlacaU=
X-Proofpoint-ORIG-GUID: VkLi0OMdE_h9bM5DBmrjBOOkaUgEdvM8
X-Proofpoint-GUID: VkLi0OMdE_h9bM5DBmrjBOOkaUgEdvM8
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a65a037 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=UiTy4FYwoVgUUf68WHMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260054

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add platform hooks to set up and tear down context bank devices.
Different iris platforms may require different context bank setup, so
let platform data provide the required operations via vpu_ops.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_probe.c      | 25 +++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index c2dcb50a2782..2594f5a67378 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -15,6 +15,7 @@
 #include "iris_core.h"
 #include "iris_ctrls.h"
 #include "iris_vidc.h"
+#include "iris_vpu_common.h"
 
 static int iris_init_icc(struct iris_core *core)
 {
@@ -150,6 +151,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->init_cb_devs)
+		return core->iris_platform_data->vpu_ops->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->deinit_cb_devs)
+		core->iris_platform_data->vpu_ops->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +222,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_deinit_cb_devs(core);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -273,10 +290,14 @@ static int iris_probe(struct platform_device *pdev)
 
 	iris_session_init_caps(core);
 
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
@@ -310,6 +331,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_cb_deinit:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 09799a375c14..a8df9af0d3da 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -22,6 +22,8 @@ struct vpu_ops {
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 	int (*set_hwmode)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);

-- 
2.34.1

