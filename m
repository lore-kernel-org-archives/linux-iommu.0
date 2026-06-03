Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509439768C
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498799; cv=none; b=ZdueSqHk1Hw0LzICZDOXzaap4R8qMJLC0Z7fRRRSECMZLCbQ86MSTREky4syanH9BCaFQu0W7ZjDSm0Emzc8xfISvT7dwJZgmJwDqcH29d6lO8yTy0GwUCqXAxxV3paxGMhGx1/Oifmi5LMdGhhrIly0rd+TiX6l/OK2sbFUtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498799; c=relaxed/simple;
	bh=lXWNmEJrXxHXoCAHvxq7qK8w3dDJ4/31/UMC2TNJybs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ID2tCt9lDnik8SJPQyE7oAUkR5NT1Z+zS/DmGSYXf5BktOP64SaDdEylC+tP9Fo3ifD3b6fivcY67sU5L7XZuuB+I9ZlOJth9NwihAvp3Uezl1jWc7rSZQBIKqKKR9m9zCxJX+Aza1NjLSesntarcxP8J878nvhEVYqoEy/UQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/kZaWzy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ke18vonR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/kZaWzy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ke18vonR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CmG0Y1755407
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=; b=n/kZaWzy+7rupsEH
	dKKhdpNDX2gmHMsQQmIxtQv+1JBkx6YQPTiAAjIkTarEXS9IgJg2mmVh4+VKlrR/
	STUal+Qga1WrbTzBqtFqkU2k/IW5An8fdgdmATThKdmbTRH/fpmVev/zTUViv/Ak
	l2f32rfJWzB/6PdIZLeTIQMNIsL2MP5fCfLJ01S/MCVz178wv+imrML+N01qAFIu
	pGs1GFz3c2+7cWPMV+LPZKEMpkHpseKcDNoplbHjDYpL62GI+3qQLNjqqCtQYJkt
	YLSJ0q6DGL4uIqXuJpIAPwQCdmlfUqafOS82oVgDoVuSn6lH8tx6zSWE/NjNDKha
	Jk3dcQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff01x87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:59:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2872919b3a.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498796; x=1781103596; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=;
        b=Ke18vonRJp4RvnNbZ26K1sqbhj7LYG7SEdqH1vbxQbMaEMxV/rgeVav1gNp4/+3Atn
         litUmf1VzJnTLK/LlKnbdvMk9ODL2e7NUrqa56EVEDNXEsxbX2x5bm1Va6ccMd9+9Ix7
         3x3lytra3Yy6TfcSmHJZb44QRAR2dOG/DfEzMDFg++26cL2P3jZPOmP+MaXvdW3t6hAf
         nEOGKAx2NISDrwNLyYvdjbpkU0w9CS/YfkNZ4jxoIB1GtAOpnqguo2VjxjSCqodpqv6w
         ztGmvJoEi6Y6CBUrhaj9qfKG6DLMK3FA/qYR9EC8Ce+vBdWPbXK9mIB0UqOYlxZHSh2v
         tvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498796; x=1781103596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=;
        b=lH2nC6YUoqYhxRJrsB0edPoIXxJTo542uy8i/IvLqG67rlPjmML457tSfaB+jERY+d
         6SlDYsa9Y+FRmInLVjKD9VJbFeBT6Ia9jfgjHkw4s3wWRMMeMGFYoU4MGXMIXOODmxd5
         xJDz8XyfdvnTdQVnwARNgZvN4GCnz27MHE/t53Sdtoxqb1mij7n1oyKYJCNbINeXuyYX
         h6St7zETI42tLXAmZb4KyxYgAdAV40asKDiRp9rDWq4KZBSbKxOKLanqySY7he23UVZ0
         pipJ+ARdt8SORX6DCSgv9xIz+RyTDnJqa5FJlAhESQC3U9L0JPjUEDzpxwoKLdpPjXqg
         6YJA==
X-Forwarded-Encrypted: i=1; AFNElJ+KPSApl4PRMIvTxaL7G9u49ebwVfM2PpuPAHG9C/WoJBQNdANSNqiXJy/lD1bNqSI6/Qp0ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKn41AkAwagQc5ylrmOa377lhqDRlghTIr7QTuC0jtipZSgMO7
	t1LhKYvuytFss9JwJOXs53KFfWXHtVyCzj9IvDDVHlus+CdbmK/1MnBFAp8awad6YX251wV0os9
	C5qBOjw6zAYGQlvVpeNjPzanf37KhQ7T7+zBSxsBAVrPVdMy7lqb0FUQwSA==
X-Gm-Gg: Acq92OHWt2Na0cDUrJng8gZs185kUR/pF6ydfTmbyafsYmiZG777hP09kQjT5uOLXbR
	Uz1oERdW3xVjDEQIwJ3c3X/uyLPsuuPY5LV0zakZsmCv0m3igsHw2EwK1pze/Xm2anFTtHwDJIY
	ljkFBZj5kLTExFt4nWofUZredB6AR/T9xdsE4Mh2O0ho7RYRVNfJblTbKb6RRHX+JHC8VKBj7OE
	zeVDpS5IyCuHYXqOK/IbUbrh11rXhD8hz9LdoNEerlYd2m1YRC5uJP0NEMuBZ3GOAQLalY1L2dI
	VzOoa3iN0bOQW+TQbxO0K0nUkUbkmrqv2ZKCPFE5vIlAbc86YWkW/rK7dBEAQPLfNNo0DcbaCux
	lM6OlYpgi3gvEJF299+CK9hsvL8YLGKq9nkJZyXsORVqWHSDjkkW2Nt2kyxQ=
X-Received: by 2002:a05:6a00:4c8c:b0:842:329e:7635 with SMTP id d2e1a72fcca58-84284f8946amr3803891b3a.45.1780498795939;
        Wed, 03 Jun 2026 07:59:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c8c:b0:842:329e:7635 with SMTP id d2e1a72fcca58-84284f8946amr3803860b3a.45.1780498795425;
        Wed, 03 Jun 2026 07:59:55 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:59:54 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:27 +0530
Subject: [PATCH 2/5] drm/msm/mdss: Add Shikra support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=1977;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=lXWNmEJrXxHXoCAHvxq7qK8w3dDJ4/31/UMC2TNJybs=;
 b=fl8GxWFvvAxL6W8VYehdEukb+WWSYKOdLhDUGdXMeoIWzjnTFGm7XxYarDgwo+rK7e26ilCar
 sbsCIpXoMwLClv7E5wQZVUjKe9/oSpcQ1BsITrMiorkZUzsAClU3cYN
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: iMrQHCAtzJFHwfX5Jl5h8XbzmNlZJLrK
X-Proofpoint-ORIG-GUID: iMrQHCAtzJFHwfX5Jl5h8XbzmNlZJLrK
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a20416d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IH1-U3DoIKz-FfJ46FIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX3mBQd8VFQgRi
 AQTekVeNRvIJAAkpCyRY9MuqbyxG6fv4DPdlrtkX8KF3l/WmU62IhTXjIuzDioi36BqUxy/NfHv
 QVek744g2YUj1JplF9jsk0SXWH00+KgCc9yW5WDSgB64Aly+imSKTFMKL6cnNU6aXuHiz7OZ7cx
 WFQArGDs/T93yYq6IrpD+E6bpPzVfTI/DecpFP+fHJQVke0mT0/s35o6ZI45qzNXCbAQy3qKZ7M
 Q919srY3KtZwmb4H5vZIVBiCmP+DCtg/KXvoXWKRxuKQcorFZqM2V3VMeWI5929hWqwgt58dA2z
 Mat03a0YQ0XfG6pqHnmu6VaWgpBmwhjj7WDn0MzJcMV28b76MMRxAkqK8BSQdUrXXMFXY/wl6gA
 WfBG3GuzCHwHa1YXwyH+C47+KB6Hzwx4ytV7kCC8aFiRXbN3DiGcmmu/5khb8QcuaengMjTJYo+
 Yv5VizCzeHQAMI4EsKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144

Add Mobile Display Subsystem (MDSS) support for the Shikra platform.
Shikra uses the same MDSS and DPU 6.5 hardware as QCM2290, so it
reuses the same AHB clock rate configuration (data_76k8) and DPU
catalog. Register qcom,shikra-dpu in the DPU KMS match table pointing
to dpu_qcm2290_cfg.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
 drivers/gpu/drm/msm/msm_mdss.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..8abe8ef6fa9a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1496,6 +1496,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg, },
 	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg, },
 	{ .compatible = "qcom,sdm845-dpu", .data = &dpu_sdm845_cfg, },
+	{ .compatible = "qcom,shikra-dpu", .data = &dpu_qcm2290_cfg, },
 	{ .compatible = "qcom,sc7180-dpu", .data = &dpu_sc7180_cfg, },
 	{ .compatible = "qcom,sc7280-dpu", .data = &dpu_sc7280_cfg, },
 	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..03f27e6b0ae7 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -537,6 +537,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sar2130p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sdm670-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sdm845-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,shikra-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sc7180-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sc7280-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sc8180x-mdss", .data = &data_76k8 },

-- 
2.34.1

