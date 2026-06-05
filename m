Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E573F7AAD
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654760; cv=none; b=VGhja+xEhdkFRU848o1yf0LMavOq4k0MelwgGLsNdZKXs56+yhFgsjDcP//sbcb97SfWyx8nvM2PY4kKWluKmeMfuPdjpcldbGfvODj7ejrWydJtD/J7sqEfpv7v80J58dZQI76DNDJpLaG+GbwofVR8OW+NB88T5sN0VXfstHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654760; c=relaxed/simple;
	bh=UjONg0NYj4XKMunIFJbINoDK3VSOgIFWYIBOvuNak5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mBA2qwyNEkFKxFcb605uuNlVCLz0vHy/lBJp51bWLdmta0m4+9KXIo+M063y3FuJt4vnAX3hY2ZNQG/8SKlqdxIh25Xdchw5UaUbDpSmHeMnpgbmO3pxyqYsIOqlIiMLokQRonFctTYWYRsOdwyhWkKqI7Hhshdm5FvJCV4vdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CoTPCZNX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MdavSj2d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CoTPCZNX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdavSj2d"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6558ICZP1957479
	for <iommu@lists.linux.dev>; Fri, 5 Jun 2026 10:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YdRn4DRbFufW0fmv7Xxdna
	0Xs07PVl1QBs1/OWzN90w=; b=CoTPCZNXVLY22xU7IlGWff9+nkN8NSABuqQK7T
	yhjH5HRfRUAC2nU5amDTJOTJ8/X0cepcrQnVE6naN3qswU2gy/9MW/sYS6sFkSNb
	k+mEyavpP9eznk+hA/3jVTMMVFf4IBPR4rqLBxNSPDXMVNqPVwN8RCWZP6U2KrBQ
	DWzeRwu8FgdX+upf4gWBXo4U4zcUj3+6MlD+oA+ZYF4aODv3rf4HV1ljjnVPMLDf
	danFRBdDSE19VvaI3aKe/oX/+Dfr0AiFbR82LXwJVcC8N4X5AMj3I8m5Yrfwgjhz
	Ejehl2Yxz9mHIaMac+1UCzRDut8xVTBdP2BbEidMeb4R3x2A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckpv4xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 10:19:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0b35fa876so20541655ad.1
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780654756; x=1781259556; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdRn4DRbFufW0fmv7Xxdna0Xs07PVl1QBs1/OWzN90w=;
        b=MdavSj2dQBnTvySkSuaOEUw5+ARtYqHZuDKmujfYV2qsIfo9Q6FNUqZbJNLCFhohQj
         ahF8r73wIDmi0fTB/45IcNXHbwjmiIzchzZBk3oMBY/QrGdEgSkBGPrSVqieO3TL7Fpa
         4ZcjPV436nVzyRufXAqWUAG16SqPlMpzcroaZBH8hmdFuOqbWs3RpX1or2ecmeSTUtm2
         P7kGn+yRFRdCK1WTqGF36N2Iz7eKMY6/yVGmNmMw5CBMU1v1wyAX9/ukAP4/fCLOpRZw
         SXSF0jXfcxWDmazhD3xLlxx+Flb4di7K27GmYeSeg2A6RxmVu3nqBorZxFYTWzcI7EMT
         FmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654756; x=1781259556;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdRn4DRbFufW0fmv7Xxdna0Xs07PVl1QBs1/OWzN90w=;
        b=eVsZYHESeLMaxE3/hPyoAhh2dFxJY3rOhpB+UrFcTxslUq+qZBrmtUWRQTSwysRO9H
         uBettMX6P6Ch2TxBBzTYrsxlKeGZ2fPC7f+kE6M9Xl+t0Ixj7mvo0lH0XPSItY4fhMUt
         QD9u2423SCU12R3SOF7XJH/jZ2BJFWk1FhTd3uxqb4aRI0voQzb5J7NpaSplaGOJF6oA
         McLOUSr1n3dj/i+m14PrUmjddp7nbfbaetIWywr6uohuLL7uSN/IPcXfI08SpGVQtlXX
         zlmKKEnS7vZ0Ok7+GK00muimejm2HsOld94CMYx24I5u3lGHnMGhPwy1aCNOu5khG40u
         kS1w==
X-Forwarded-Encrypted: i=1; AFNElJ+30KOm1Lq2TMxaxh73K9i5nP2ZnvlcnQuQ3aF9IK7nvJX4odSe1QsS8/2ANO0y9mWFXyJnqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ+uGErhMRjFxXuCtJM6iT3Ap6Mp0bCknx5l+NXi60ksKUkErJ
	LsHD0LBBBLoxvYr0pp5uyyyOnInWsjq+Tbow5Ojfse8k1rDnSCAz8KigfQRo1LX6qvRzBOoJRtc
	mXAyoFOaye4+1R5lyWTchcuglbdXT1dY1Goge5IabfrZMhEXu2nf4MwIpLQ==
X-Gm-Gg: Acq92OG0DFBvTFyswzvkPSc/6U3TDgKjDi5xHQgx1EpUrT52c6B1FegB4TkJa9ZfGzh
	+aobFUjivF7q6xD3Ki9a2VNFYd42i9V59dZZf4mU4+ZRt0dIwJUizHeJB910JUlMp6bIVNsi63H
	0rQkXSdOgmmhGkk3lnN0DTzT30zBOYfvS6bS5W5bpSs7DJtcbPerMoQFJPwcmna2CN9SFFLxYrt
	3Y/2M9fYinDx2l2UWY2XGx5eUWXJxS2mBOpXLAjDfPXt85UzxQpPYZUPcN6ZQx2SLTJ9mG+/ZTb
	vTfNV+c7C/XIjxqI/kh6cRocLmCKOfHwT06CMnX8Rwd6BETPKwV2IW/PVxJVnS/5c42S14tYw5Q
	WQ3yaZqM3oKKHfjUK2guvPVyIWkrXtJteORBmDyNAWA1s8nZ/p2mOOBEQENE=
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id d9443c01a7336-2c1e7e44e91mr31358805ad.16.1780654755825;
        Fri, 05 Jun 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id d9443c01a7336-2c1e7e44e91mr31358275ad.16.1780654755335;
        Fri, 05 Jun 2026 03:19:15 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:19:14 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Add Shikra (QCM2390) display support
Date: Fri, 05 Jun 2026 15:48:50 +0530
Message-Id: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqiImoC/3XNQQ6CMBAF0KuQri0phVBx5T2Mi2kpUkWKHWgkh
 Lvb4sZE3Uzykz/vLwS1MxrJIVmI096gsX0I+S4hqoX+oqmpQyac8ZKVLKfYmpsDWhscOpgpE6I
 UnO0bqBgJT4PTjXlu4On8zjjJq1ZjVGKjNThaN2+LPou9v7jPKKOgQWWyKhoAcbSI6WOCTtn7P
 Q2HxA3PP5XiS+FBkXlAuCyFrtUPZV3XF6jbTxkLAQAA
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
        Nabige Aala <nabige.aala@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=3346;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=UjONg0NYj4XKMunIFJbINoDK3VSOgIFWYIBOvuNak5g=;
 b=NYZsTfhD6L1pZkrKqjY12HiGTIOPAad7elMOIEmgc5l650WfUBoPQwTaiYI4OYgsjDKjhuKBL
 jCLt2KM/JUJAy+tdw3EdLXgPUp6qTh8OMonqEGpoxLFIK4lrDHSxFSQ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: HX9mrLhMl2jcBRaWHGaLq_nLXizHwrgZ
X-Proofpoint-ORIG-GUID: HX9mrLhMl2jcBRaWHGaLq_nLXizHwrgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfX0tTkzQHACNk1
 tBTFLrTKRpFA1q3aE3UMZQ2mlZzutApoboPRrz9P7LMN15X85e6br6DSk8gaSHs/qJDRzzlLWmw
 KvBqEVGhrZqfp2hqO2JsiVzQK41MhohyMtyVfH+vvNrCdHcTFW6GGuQBmLm6mYC+iJ+F69koj4T
 5uwRKXSSFk7cO5NI5nh+yuyvXsWQf5CekgqMegjmOZmfmViskUZILYUg/1nIJJQ8xtNh6qZ7Ueh
 8soH5IxZDW5QwW7JIfF98JshkP5hxUHUKE1tFJjmBSnt13fzfOvXj3R5+qVZJSL8a+6yOMXKHpv
 EIq6JnleVfHoGmBM1ZxriMsWbMZS6uVNZAxlwiz7dhuL3SSxLCsGG/nSfgFCPvcA8fZT4vqstH/
 w8Ind5AXCagZazI2lCA/I226JG0xyuUEn95+cauT4HQyGulw2HGhyE9BTtnRSjUvGgaTmuhYh/S
 cE4Rn603Xy2+tnlt5ww==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a22a2a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_or6NCU1o4AAqT2-bvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050099

Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU, arm64 defconfig enablement for the ILI7807S DSI
panel, and UBWC configuration mapping Shikra to qcm2290_data.

Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
fallback compatible string — no separate drm/msm or IOMMU patches are
required.

Tested on Shikra CQM EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (3):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  arm64: defconfig: Enable ILI7807S DSI panel driver
  soc: qcom: ubwc: Add Shikra UBWC config 

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml 	| 4 ++++
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  7 +++++--
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 22 +++++++++++++++-------
 arch/arm64/configs/defconfig							|  1 +
 drivers/soc/qcom/ubwc_config.c							|  1 +
 5 files changed, 26 insertions(+), 9 deletions(-)
 ---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Changes in v3:
- Use a fallback compatible chain for qcom,shikra-dsi-ctrl
  in dsi-controller-main.yaml instead of a standalone enum entry, with
  qcom,qcm2290-dsi-ctrl and qcom,mdss-dsi-ctrl as fallbacks
- Replace oneOf in qcm2290-mdss patternProperties DSI compatible with
  contains: qcom,qcm2290-dsi-ctrl to avoid duplicating full chain
  validation already handled by dsi-controller-main.yaml
- Drop unnecessary select: block from qcom,qcm2290-mdss.yaml; default
  dt-validate compatible matching is sufficient
- Remove self from qcom,qcm2290-mdss.yaml maintainers list
- Link to v2: https://patch.msgid.link/20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com

Changes in v2:
- Drop drm/msm/mdss: Shikra support patch; driver reuse is handled via
  the qcom,qcm2290-mdss fallback compatible string (per Dmitry's review)
- Drop iommu/arm-smmu: Shikra SMMU client table patch; not required with
  fallback compatible approach
- Fix UBWC config to map qcom,shikra to qcm2290_data instead of
  no_ubwc_data; Shikra shares UBWC support with QCM2290
- Refactor series from 5 patches to 3 patches
- Link to v1: https://patch.msgid.link/20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com

---
Nabige Aala (3):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      arm64: defconfig: Enable ILI7807S DSI panel driver
      soc: qcom: ubwc: Add Shikra UBWC config

 .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
 arch/arm64/configs/defconfig                       |  1 +
 drivers/soc/qcom/ubwc_config.c                     |  1 +
 5 files changed, 26 insertions(+), 9 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

