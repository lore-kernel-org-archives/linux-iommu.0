Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BE31C567
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498782; cv=none; b=dTsceaceKCtGpak3UpZ0i+jyrEx+0XsCDGe5Vb9KGYB5iXXwOCFbybKPi6WA7ROiqHgNQ3/37j9IIKkpZ3r2dZvACfUawEZA9QXrvCHFjWjyQviyTnAX0cgtneyg/lrPK3kxLQ7WQreXIEg5Uy9ZJobbNluunLbp8oTiPLDcBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498782; c=relaxed/simple;
	bh=tlczd3hbO7jRStxmbXwY/7Pvez+jwqK8qrOvD2gZiqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n2ZyiLtfbOeJmUHsnJPgnNgHjutlK9EIFpNXGMVhi+WPQVt0dw4X9EQ7rSb32ixm1ITAJoOFAwrKIbCeVmQ2UgJ6KauhI2U0H74Z72pnl1XsUp0OssQIdu9GQR4THlvV75HAwPCSgQkPkPb9mNQF7G/Hn4NRQb/jGc9VYXzHsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGP0dkdD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=glt3jjkV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGP0dkdD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="glt3jjkV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653C4sqa2076419
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OHsKV+ltiKXXlmj8cUFWo9
	IbTkRATlv2GK6UqkbO9h4=; b=LGP0dkdDB/zIX1VP4TSAhzZdDunN+X8a21fjfc
	kWdA25gpjcSUH4hBGFoMDe15TSA5J62MDzzfPpR33WVdWY5QlZ++2ocwmD8DT0im
	/CSnTGyUec9kqbVoNIzXvCLbZ8wHhm/fdT8tjf8lY5rs/G3h0wUxJWQGUg7JqnT9
	tbuLiIZTgtxwggkRGdUQshxJsIEP8se1b4FYjiD4OHnlhAKYXP3p4k4qBszLFiS+
	89EVsCwGN9DfKnutMcAfcVKnQrhO3cxak98I09t18A514ss5hzrWZIPhKJD8GTdA
	JrkY9YAEbCBdbioM3v58dOE13HczH2Ce4JRf5CnK/KXN9Hbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1a4sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:59:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso4538110b3a.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498779; x=1781103579; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHsKV+ltiKXXlmj8cUFWo9IbTkRATlv2GK6UqkbO9h4=;
        b=glt3jjkVb51LgzZbrLA2KASEL7OcMoEPLjfhfxGfcg3go22Y8ki2eqvaMmveCkbRza
         eXAWOB7T2EEEX/bqCjbLmSM9yoBuK3dq8ELPXawIw0ony/puT3AV6woR4QWo4w8DuWy4
         kKyXHT/Hj98J6FDcB8iE1oo6xKX51LTCIBmUIKpbfassWJWfEH+u1HPvw+0AIaD4D3kk
         /o2cXK3jQUbO8EZalu7Az4lVczfpo1VZtvga3tltoXXKpmWCTev+yB/fb+B2lx05zyLW
         1/JR+f8Hf18ZpFEV6xGXKBKHjGYGrZTZ9Nw37oZ11AQ7PdVV1/yf5Hrk+Z1SVWwgR4Q7
         ERzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498779; x=1781103579;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHsKV+ltiKXXlmj8cUFWo9IbTkRATlv2GK6UqkbO9h4=;
        b=P1bL3k2y5R9glwLk10VKHyz8Nn8XhsQQXJBbxTS1z8ykz7MNso6CrKU823nPS/WFMb
         LPIBwGo/8qxhILF7eWgpoLptcRBhPltVv5cZb+acGKrGifeZM2Y3Y3ugBk7GXHG/qtBT
         FrFWOzmutReFkNtPefMgWwbsc01RUXh+WSSEaVoMHkWlcydhTNcoGmQi89fdRJe2H0AW
         qsOyhtzDLr3jp510sViQIoC3j9zCYVjqXOyoo7kLvq2llcINF+K7yTXGfe060XkLXgnQ
         iQAZi9mI3MflkFrMZxggVSkm4CGf44TvacwAx3FGrJdGsSjwBbhmtrhjalN95ddrCA/e
         d4xw==
X-Forwarded-Encrypted: i=1; AFNElJ/e4x+YCsTcnbGl7BJ5t3fWRx5Rpu5REoKJL12g+y/ULWK3mc4a67BQr9LkMVKqDbZ5+d5C/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YydMMUGlb2a4WzVPBn/MqhrBbmXP6OZKIC5/4RNrKxPBThNID7d
	Jlhw5P3dLqq3XpZRPXLiF7846IxlmO4kuKwSSpYzX1/rKOCGPBQUDmcFnHODxRbhQGO+BN1Qc6d
	lmg6xyRMX5CyYkPu0roDq4TO6PNJU06aXFAMjNGswBq7eZ5EPRSw9zl4B3Q==
X-Gm-Gg: Acq92OGCfFLiYvBsuUgnjba+0PjWAPpDliD+J2cM1Jrur/EJYa1Z9mhRJHMEUIC/Rr0
	Z3UROtIMTfMeABRJ7Zv0gIQBCX+cqPgGgMRIZKoKQfaPUiMMj34lIuuYKuT54iBJOysNH64d38g
	0138G/gg57Y2BdDTAAhE03qJUThviDWiHzm9jBHN+g9MzUklyv+ISAhlDEK0K+oaYoOz/mt37H1
	swyG2CGiAivI/cRkn2l1zVZwNrexOZjW/se5AzH0O2ouHrNwCpkqzfQpGWpKWToBmGGNvxENtEu
	q2Z94xCi9PlQlW7aMyNKBdZb2uEJbzzrvenl+SDCz3pvJH+7db25yn8I6Nd5hIYRHET9Dk/wE34
	q+Ei7VVv9zE9a9scUGJYdT/Ks783NaAanfc5R4my58dEHEmNtQOxnLlDT6ng=
X-Received: by 2002:a05:6a00:4085:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-84284ef2c4cmr4096582b3a.29.1780498779041;
        Wed, 03 Jun 2026 07:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4085:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-84284ef2c4cmr4096526b3a.29.1780498778597;
        Wed, 03 Jun 2026 07:59:38 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:59:38 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH 0/5] Subject: [PATCH 0/5] Add Shikra (QCM2290) display
 support
Date: Wed, 03 Jun 2026 20:29:25 +0530
Message-Id: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1BIGoC/yXMQQ6CMBBA0auQWTvJUJMWuQpxUdsBRg2QDhAN4
 e4UXb7F/xsoJ2GFutgg8Soq45BRXgoIvR86RonZYMhYsnRF7eWVPEbR6e2/SM5ZZ6hq/Y0gR1P
 iVj6/YXP/W5fHk8N8XmDfD+zSrYlyAAAA
X-Change-ID: 20260603-shikra-display-07767208fa90
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=2627;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=tlczd3hbO7jRStxmbXwY/7Pvez+jwqK8qrOvD2gZiqc=;
 b=NuBmKboJ2e9mtFWMrrsLSiNUZwFZCNOuWYAD9ECbT/obdMO75IR3X0zKzn8SsFhx1YCJYfXpd
 t5w8rKtPPLWAIxXudncUKr9Kq4VWoutNylTrUaf1UuMDOP8r2sgYGcu
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: xNUA4o2lRld0bvk11DKd-R-4Uk0FsELb
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a20415c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=sFAlhcv5WihPgsyf0pgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: xNUA4o2lRld0bvk11DKd-R-4Uk0FsELb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfXwMfsb8ULJYSD
 NrSxeiEemeXz61uvXDEEuE4dMS1/vmZnxVFd1L6cluPlzaS5M6fcs765hIFqJpYcd12Xw9Azuw4
 yeUS0C+9yFJ++osAcXmxO8WCL67HBwfxof7LtXGktGI87WA2sAxn5hOd8Bspw8q0XkRAzondtdE
 Mk9bdQNVcysD1jQeS7KfD8XwqvlKJp2cXb/rGZq9fnH4mzxJgk2i1R3wdUwXYf1r3Hn5rsWRqMC
 6sTQO34OUY9N6s2GFC7ehzb5cw0E/U1YPw5xCYXvxaldZUMLbbm6LztwBFhq3lsfeITVvlYNHPP
 nRr/UFIyNSesl8FO71FKE3JxAwZnr4rz/f8k1iJ1RvDaeQflwCJFchdzc239zWGHTd/D6sAJoel
 ZxQ5U1Nx8WcjT71G7Fg3lEjTo0povlQiHBZkg1S+SBcwXVK6eV8HIfex5K3lcpURvYkVwMXtb3c
 5qvCTeEhoqaGQKP1VSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030144

Shikra (QCM2290) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU, drm/msm driver entries reusing the QCM2290
AHB clock and DPU catalog, UBWC configuration (no_ubwc_data), arm64
defconfig enablement for the ILI7807S DSI panel, and explicit SMMU
client table entries for qcom,shikra-mdss.

Tested on Shikra EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (5):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  drm/msm/mdss: Add Shikra support
  arm64: defconfig: Enable ILI7807S DSI panel driver
  soc: qcom: ubwc: Add Shikra UBWC config
  iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU client tables

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml		|  1 +
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  4 +++-
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 34 +++++++++++++++++++++++++++-------
 arch/arm64/configs/defconfig							|  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c					|  1 +
 drivers/gpu/drm/msm/msm_mdss.c							|  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c					|  3 +++
 drivers/soc/qcom/ubwc_config.c							|  1 +
 8 files changed, 38 insertions(+), 8 deletions(-)
---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Nabige Aala (5):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      drm/msm/mdss: Add Shikra support
      arm64: defconfig: Enable ILI7807S DSI panel driver
      soc: qcom: ubwc: Add Shikra UBWC config
      iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU client tables

 .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
 arch/arm64/configs/defconfig                       |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  3 ++
 drivers/soc/qcom/ubwc_config.c                     |  1 +
 8 files changed, 38 insertions(+), 8 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

