Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7053ECBD9
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266903; cv=none; b=SQ1biR7p5tsUmfu7SZrI4Ar9ZQhmZFpj7syovNO56LQbFcYp5wjkTr2WFHW+RoZDRweOLTNJivBefhw1dk0QJt2HW3wCY1ax3wNRtmWU8A2hyxmyXNLUfArrhM8vB05mZ1fKlLmAod+hrjBIfEWDMo6CMNs6Socji2P14Ebv2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266903; c=relaxed/simple;
	bh=2FrychMIG3LHR9amZA9Bhyd149/t+cV8/TYXT9nsgoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyPDlhql++RvmU17C06SEVy0tsMXM1Z7gOriiyEaq3PNvo/IQdZt+fMou1VzBraSxt54TBZoV68TqPyiayunL5F7W0G4xYlIJNJwLhFghf+f+k1Md6yGlwYNd9MZjjY6IO7FHmftmuKjxjyrMt/OpV20mwcA3FxTfm7d6GzJXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+CjV61q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dtwo5gvX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+CjV61q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dtwo5gvX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CGmp3852141
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dn3CzzlpHtBN1CICIkLhbSzmIcgQM8PPO9ueTKjRmq4=; b=J+CjV61qhcCvq2DY
	nZd2eo9lQeK/2x/HQzhpBteFjbsmnCSj6r/z2ddHQXrCKtSg2CQ25bsH8ZskXc+2
	SLPCNB7ki11GN7K3g8Ul+ow9ZaaFbZw0JHIS9c2IUBZSGoPXIQb0yvDN6vARn4Wa
	9qkY6h0Q9wJEzy5+N3Kgkq7+7UXK//+s7znAdf/E7ZBQtJrxR6Vvbsfvz0ZaWWqj
	BsyyXLoCQQO5cHue7ovuf5D4UbfIjhI+R1/cEoD9ASQ+2Q8y5QRyWKRaTu2Rap6t
	CZrpvmbrTU2j5PfsioLBAVHWwXdzmeG/ni7aWc7zUW9B6PwK+4vMgODzmLWa258W
	rO1+aA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fpthk34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa860e71eso1331228b3a.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266899; x=1778871699; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn3CzzlpHtBN1CICIkLhbSzmIcgQM8PPO9ueTKjRmq4=;
        b=dtwo5gvXGupW6Hgh8Q7mVcPs+Ytob6uaFHjtI+pPeVBhttaX05vO5ZLRYucIe0Hdnj
         APOKY3+FRtT8GKNBLRKErx5hVwx82dylBhJ64fmqz07iWOk3XvLea3BBQP2dX6RXlqBM
         vHbocBpJtuwzK74qTpjt175wVge73vkWIhSHitxYZhvtFFVVE/7sC9trZEKwMxtDoj51
         mZuam7K7bB6MTWad6VORcr3PznxdM6uJoAY8tcboKNe5AaEVgJmNyNmv98NNoezauBAu
         jbavegOej/zw4NbVTcX1IEA47D1x5yEVbWmrLWnGgObfCN08MK56y7TZlAYP9LIcGegV
         zOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266899; x=1778871699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dn3CzzlpHtBN1CICIkLhbSzmIcgQM8PPO9ueTKjRmq4=;
        b=r8U6ZvNa8B5/tMgT9QtwoM3+Ft9rns/YsPEaxY3zZmH/aoTBBOVituANiLnJWZACOL
         BDRvk+JIvG/yGW/hMiNxXC4tazqay0ugKffuR6P0f6EUqcZxeKD/yx4OApCqC3UhTtiS
         eVwnxdDwjdq3pUqgFJGKMJAeisBx+lqNeEyRpOUO4GAKU1lj0UbqgGKhciFIFzqfAinf
         kHLfCsV5SHBOBEqs+fywCLcjXo7u+GmBJFI4s49lLOPYHGcC7ApsU8fK+xSeQMCYLQyC
         kS1QpzAIFL9nMHWUrj+YwGmge0yT0jWjtDIWTerz6Hhf9P+z8Wga22ardvMRHwrOOdXA
         cgqw==
X-Forwarded-Encrypted: i=1; AFNElJ+oAII5An2+8r82O0HePSNBcecT9yM4OQKslBcm/uIjracV1rQdHAJYoOCRwiCxv47redgEHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwkUFtC75FYfYnbiFK/KthIJhbs9oezCk7/8KXAXfFnIMT2hFq
	uZNwufO+Ipu/EELiFmrHKJj+AF5lMNhrXLEwT58sxyuBgyRd610dzypSJFdoRr3EgiM92e4G31P
	BhLsqj0tuxV0vXfNQ0BkU5BXD9BRgDKgYvsTczKrX94EIM0s5YhpRnq9219fWsUwnVQ==
X-Gm-Gg: Acq92OHymEpa6ghnR9OL7gUShdtNBPrsPWIzrc9mcN5N051jq7roEOEp+Hd5xCcRxd3
	77rYsHjgXUM8RgiZfRGJb+mh+rK4EF8ipzI59Gj9AkJo0VQst6Ij4OdM1MwDs+fNtFb9qqP7Ee0
	IEqaD5MAcJLquuFxWLn2OHSXK+ZUhLscZVU6QhiNd4WwndA7+rSmMYdj4yQMoTTPFvExBTvZgt6
	OVdoxNY9IwqqVJG7xs6WyNjeyTc/I9eosqkuFga7OPdZcYF2ablrFDEsX6mX+aF8n3hnvEDPs2r
	DKd2dBPeMqNM6jMKWdmU2Cjm8mAu+7wvUE+pubRag4rnL3sTvti/mBVLB+bYgfnEKLqnJQfUuFn
	+pntPVduyEE5oepThruGyf0D/a7Nbr0LMqCjTplT5eQ9w7D4ZJm+U0jo=
X-Received: by 2002:a05:6a00:2e90:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83a5d96f560mr14458724b3a.34.1778266899416;
        Fri, 08 May 2026 12:01:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e90:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83a5d96f560mr14458559b3a.34.1778266897986;
        Fri, 08 May 2026 12:01:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:55 +0530
Subject: [PATCH v5 06/14] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-6-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=3079;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=2FrychMIG3LHR9amZA9Bhyd149/t+cV8/TYXT9nsgoY=;
 b=7wLjzMkpFTKevjusI3lfqR/03jJoonRzKWGH2n3/qQquIs5JISQIbUxn1gQV/9+NlOhlNPlUM
 CoUC+yZXZRqAfcrViDbh13LB5NZx+epsQfEZJfy9HGOr6KrF+Gec1T+
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: d5Se2qpebO_V7zEwiboQZ0SS1oi_IyqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX2KmJVn7YgiCD
 0ty0tmIA1xPhQNUzUi+h2ZRQJbHysxGKaf2Ik9Z8EBpp8vW+5N4E7mzyzAZwXJu+9RGf3uM4QL5
 lQ7JlrKL8uJwsTfQHT7QKGXxY59jWPpGfCE6Qhkcjeynzo1vGZHlTvuk8ylKNPYSBGxqIbKDLWW
 KEcYf1E/44yS5y/Htjg6GiZBtfeakUa8kAmnJQfaTlsXgljX1yhR/LJbumtmbdUIy/hU8uEBGcn
 z7C84IvV7o9N9IJweAgzGcE33V/8c7Bwsi73iQ6Z8A9uj3FYJ9v2Dkf+2qiPGbOGYyF3sKM6KjS
 EY4gtEDaWrgiZhObMRMjLLdyUWlFQbBDwc/ZWOs6sJkg2nk3fhNCiNL1Pk3PR7d7DXf3wAPAC8f
 GC9NatOGZKOyviW4czsuxhPdk0wuHepGCm0mgaEcH0QnnKbhvTF1bOrjkexL77/Rs5FeHqWsCWN
 yOC36vt0CY7cyyW4kTA==
X-Proofpoint-GUID: d5Se2qpebO_V7zEwiboQZ0SS1oi_IyqL
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe3314 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

The Glymur platform requires a dedicated firmware context bank device
which is mapped to the firmware stream ID to load the firmware.

Add init and deinit hooks in the platform data for context bank setup.
These hooks allow platform specific code to initialize and tear down
context banks.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580e..55ff6137d9a9 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -219,6 +219,8 @@ struct iris_platform_data {
 	u32 (*get_vpu_buffer_size)(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 	const struct vpu_ops *vpu_ops;
 	void (*set_preset_registers)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 	const struct icc_info *icc_tbl;
 	unsigned int icc_tbl_size;
 	const struct bw_info *bw_tbl_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ec..34751912f871 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -142,6 +142,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->init_cb_devs)
+		return core->iris_platform_data->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->deinit_cb_devs)
+		core->iris_platform_data->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -193,6 +207,7 @@ static void iris_remove(struct platform_device *pdev)
 		return;
 
 	iris_core_deinit(core);
+	iris_deinit_cb_devs(core);
 
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
@@ -259,11 +274,15 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iris_init_cb_devs(core);
+	if (ret)
+		return ret;
+
 	iris_session_init_caps(core);
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_deinit_cb;
 
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
@@ -298,6 +317,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_deinit_cb:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

