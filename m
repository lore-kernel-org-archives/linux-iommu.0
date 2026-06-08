Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93C3101B2
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902135; cv=none; b=svVbTKU2jzZh2/AbhXpn6J1pz08oJhbXbErOno2gKSrkcisB25urJeUcMPLZXXVVEBMUD0h/zv/hhvS/yRZBlUSmyySHm4LatnquVJB0aR8NxVcdLf8x547rHmyRxOB7Fx6JjKARc+paKlp1Ub+J0SXUDmd2uRWS210+Se/UMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902135; c=relaxed/simple;
	bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKjZfaIFqlKr6ORJviv1uQUwmKf1VE0TFB2O4l+OKcoxTOWABpkuqK5/dnYuvSJVydNj9z4jNlV+3eTG7hpCc69H9veh96uehV1fRQe07h/91k8byfsCWVqqJI7jkby7lSbP6gVdQJ65mG0WZO9IFw2FZEWSrkUple5O1P4EFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJ66Fx1B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxUkd61A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJ66Fx1B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxUkd61A"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586RWTD2833471
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 07:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=; b=DJ66Fx1BswjDUyEg
	+m9kBhO7qIXWhbLthFaXsPksqnt3w589fO8O6xJ1eWkLomEpC2nrTxxZ2t3o7ZhN
	DfpXFai3Q7Vby04dgnfSrdHzQcHaGS5O2SQ1stwlgogRAQ9hB7SSEWJBR+cGtYmM
	5MH5CWg23cSuXsBcLk31zDjKxgfCbYoOUllAbLTjgBHLyCbFEMyfFZguoxbnyFvH
	shA97w++ZxMmstGOOkcdxsjUTSaKsKsyTZRu9KCG9d+NwJqm6jY/E6Q4g4HGuscN
	faozQ7bHiIUUs1t/9pwf9mh9SPeVriOcvw5R9wXPDZqKpHIW73hSgapKMA/pzOMh
	asULJw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xpp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:02:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8581f7723aso2335017a12.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780902133; x=1781506933; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
        b=JxUkd61A4WuTMpOy5AMoDO4q3g/vKMH1+4kglCWxGsWmcM9POTegh0mfxCKJGuUQ8o
         aJj7P8xzdYRgDlN4HUVRSTLf8wWergiTXVofpxLp0IL7YUbvLGphPEPrxcIGkGVSocqh
         MwAqtij4vD6aaoxIhP82hLfnR/lF13SbtEny+tvNY70dBxx8uLiG3vqUGAs1ugAIskw/
         +ms9jQZdLgTC+aAIAbmR73J0HVwwfNcguefVPfGJn34iNDfh5V4NVKr/dZ3DMI/65qUT
         uWvXG2GRraOospF+DXxnEVUScPhghLUGeSEyu8dnXAsA1Auyg57ye4p6nIxTPZNwgY0G
         tJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780902133; x=1781506933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
        b=tLyIaMZt5PyNfrm6dwkNvkr1V4oYeENaNHDdwMGJ3CkDdhYJR5nqCyk0LZDxAzUauh
         z2DJg/a1zpdUzWgZyMFEMvihmJ4KuIXGEDUD/zqCwz2v8CCx6k0cMqV9iKyC/GtBSmQL
         rShGUzTSwBxV/4XqeEoDuNgruEjZGyy8g5trsPFtwtRLCoxdLVx8PtXbPv9KDlPgsKEl
         TKatFtB9BuqnfA9raD0oEIrj7VRc8CV7ycUVqlnXpWqyJoGLo59K2MczZS96IwA2pRJt
         n8lQK4J+AbtyYxKD3m6E0pS4HiupVz6XZy3ZydcQ9qc3Wr86QU1aRqfIoapILV94Ipzf
         ANRw==
X-Forwarded-Encrypted: i=1; AFNElJ/Wb4YOUFYH15RezQvmJTpwtWlBwQsLc2hxajtq11Diw/ZOwnVcNwEm2351DMF+t7cvDAY66g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ+Fx10yPoe5TOr8ofTj1/Si6IkJ1m9gRKzdJWpEbZaQ8f/0FL
	rdc3huqkqjZuklmDFWguzqlf0xdPwZcMPow9TXXjBPpBk2UJz3eRKXmgtnRgpIGchuTX5XsYwcY
	3CIzZcMJ6AwuwXJoif2pH2qnpSX6KErAPA6TQhBD8/GzlQA0hEugz0dI9wQ==
X-Gm-Gg: Acq92OGKG1DnqIBDe0WxhA4apxGMEVXRG//+VrBNe9MjFcfGn38tQK9rNFSSmTXLFXD
	lZVFS8E+/TE3PoUf9x677ldjEXf96oWB+DC2YgPirZfHJRzG5fPvU2jqzUtkAUCKl4RIG7Dzzp9
	ylHIYsuFlLoveMB0nAuZO8MR9qrvb8l8LMohziqXaGwiyQPhevIv5Wn5CG7CxxPVHNmu7lZ9ysW
	FySsXtrXkSzdmbPU/PAbfjMTHwfah8LxH8ACY4CziaVfFP7cgcK21/CISlk38uDrpiE0pJFZyfL
	rH99l6qTjpoxHCi4CDvD1tjFqiJ6S0Hm9uCt7Cl93GrjNy9Kw1UaneObgUmggrJKgo+nbyd/N5e
	ysK/Z9UKzJvJfnBb6nOyw7u2qSpiAK0iZlv7RzYVaJnnny9Dn+OOUqnWB1B0=
X-Received: by 2002:a05:6a20:3282:b0:3b4:6cae:4a51 with SMTP id adf61e73a8af0-3b4ccd60b95mr15783366637.11.1780902132661;
        Mon, 08 Jun 2026 00:02:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:3282:b0:3b4:6cae:4a51 with SMTP id adf61e73a8af0-3b4ccd60b95mr15783282637.11.1780902132028;
        Mon, 08 Jun 2026 00:02:12 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:02:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:31:43 +0530
Subject: [PATCH v4 2/2] soc: qcom: ubwc: Add Shikra UBWC config
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-display-v4-2-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
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
        Nabige Aala <nabige.aala@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=1072;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
 b=ny50TIyWUidyGAoanv9GgdCfanSDF9NUNBpKf2lLq5HsfD74oor5jsEU2fR/ek82X97Y7wl5a
 pQpTBxFfCAWD6I+WS5VaSGpScGu+HZgiinG9WqdVvLOmKN6/XspjrnE
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: t4mdd_m0R7yCCcV0arG3EomgJL6FrQ9a
X-Proofpoint-GUID: t4mdd_m0R7yCCcV0arG3EomgJL6FrQ9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX2cKaVLYzDH+P
 8jKcklfwuM/w3Bbvr69WWXCWjtKYvD+JpbpWKHoabtPoGPo8y+cFkndCSg3FKC9kSvfsBUcbRdU
 7xcdqzT1ylPmqrMBV9QstXALGDxATmIrfFUXlE46o0Zp3yp/ELngQF0IKGKqJj6IKrAUYJzir45
 2eXZTAGy2FROSOLgWh7ht0cFMz2jabKeS3YlEP22NiJXxHXg57c3e3Pe0mGSrvCHYUa0LAPohxO
 Oh1aRfy01h4taTj5LCowH7LOiUOHLDyXhXh4v85q5qYfQ8Sbf7zNTEJsOEgBSpD1x8AurLM4wyi
 R8kPlMCiKQjhud8ATGoKnh6gPMgCivUFV/lm/Z8k2ztY1l0Oas6L8ghiqDxR7FCtG2Sy4uv4ztV
 wo3fjpeL4o+WtJYUFCK+frE+js0I/eE6/zXff6fiaw3/RZtjG/4DHKVCJZR+u6KaErgcY/DLSi/
 ajVHe71I6tHekkXgOyA==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a2668f5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XuKMx7f3ltwE3Y0lsuMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

Add UBWC configuration for the Shikra platform. Shikra shares the
same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
UBWC settings

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1a2e54c6480d 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &qcm2290_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

