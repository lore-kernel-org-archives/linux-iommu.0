Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE4376A0C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902118; cv=none; b=ukE1C6knMLAGMy8BMfrstZDOrpS9nv73rotMwcotsMPF4ASnTUS7PXyYbvA7JmnnIdZEMBARYu+sBchEYIM6iGijxbKfViF0uChmJ/cuKJIv8Q+MwUHbuVHnL2ktZXUFSxTKge5gMqD+4vIl1J8wabDr/epWnn7586iDLc2Lyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902118; c=relaxed/simple;
	bh=qoPjmohCj+qt+VnuKdYhqh4uHy1Ot3eveLLAi8iChK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qolWYYxtu4SHRo6s064Q2lr186FnNPvIP4m79zIPj9fQWB+lXCgsAUHi7tlppbq8mUUQXAjJVqMu2HUKX/IJnY061FOs0drgI5MPRA1AoRwTZoDBTA525+ACu9izctVFxowrJ8+8s5RqW9wlOPgV+Va72e5XDz9xx11AW861NAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dq1qXWvz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khUidTqi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dq1qXWvz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khUidTqi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586RWj92833464
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 07:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GQJ43BCxRXT3sj0FEby1LK
	Vsqp3NgRy9qYHkeoXHJ+Q=; b=dq1qXWvzVvalAJasL/vbP2x5I769P5VN64Yb6G
	R9SCxURObCDupJhqTu9kS1BN+F6oqm0jOtLrGAQ/edcecX6v0q3EYKsMZoMcwCcT
	o5w/ttOlT1hQq6RwUWTeGQrEGY+JtYnKFlpr8bw7GX8Mvs6a3jQtN08QxggxQbum
	qRG8C85BDtIKMEj/vh/mdTz6H27vgGuu5iHwLKT6JASWtbyVYDQThDw2ftgGazjm
	z/Xe5M7I6OgKbXzytR0zR1xY4HLawoqsEy1OI3kelQv0XOl4PIVWfrszgq9+E4Kb
	OW5Imw+NvANpY8vtugmqUGIer8iB64ABptv6gSh1MSi7LzqA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xpmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:01:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8592a62f32so2419788a12.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780902115; x=1781506915; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQJ43BCxRXT3sj0FEby1LKVsqp3NgRy9qYHkeoXHJ+Q=;
        b=khUidTqizxxGmS89K1EXhjR2+SM16gD59kV13DsnRpbTmezfPek3x8gZlSri/Pf5f4
         BARVdJMu/uhX4ET/h38kKKnR1WSWfk851UCh03K2pHhxU3/TrI/C+BFrC9p1De0A2Bj8
         P8rkMgcNoZTf+NVu1J/aTadldx7YmLhWJ3jkwuch3aInJftkzfEUsps++QSwe/4f38Ev
         BItDUlIO0UUfWm4TrEyonVT/t/9baizvi9Ea/A0BEnpZLpsNOsD+gh8CWb9WVjM4wFPi
         dAtOGvcN091NoVFNEow7L5dILIhsDWjezojplYEjj2ZWPs/twMJNBy0W0I/Zdwn52eE1
         KPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780902115; x=1781506915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQJ43BCxRXT3sj0FEby1LKVsqp3NgRy9qYHkeoXHJ+Q=;
        b=sZ7BuWe/vbZElEuM+fyf9LItJk+tm7bcO7NFPCtvTOL7TB6qDRdMbclWnsoxSbZca9
         2bpiVc1AUpzS5D+4AzrZCC2nvlO7IB5Wbi8VmAIaTq5ExwY+Ebt0bk6PCbS1PfBat73V
         EctL/9XZ7/jJ1nUV9P+MU1Zww3PQJoN7QX6MJ8qSj4WAAklTuEHLo7PhvC9JpoCHflMv
         dotzmOaO9nhPD2FgA8wbvy+rsLpcU3ZFZlGt8HFpSe87jg688RfFYrldTG7u7a5MqoMX
         J/2Esi8whsztN8LtheRrXPh5ESZLAU12T0LRIt1QH1B21TCh5T/D4Pc22u9uDe+8rGQI
         3GdA==
X-Forwarded-Encrypted: i=1; AFNElJ8GO3dTEgs/8yB20bf/HYYPKHyE6xASoKlAf3JEcHtGiict7TlyeCUpl1Amg+klZlH4OdoxvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGZtGG+a3hwr9C7BcV++EOaUCC+sd/m/avllurS9UHz7cY6lEX
	OJw33pZoOlhMP+xC9jjEteQPPygIEwbvhMtTw3RiCe6nxomDmL9SK1awRjfZ5mx97H/1w7xoYpc
	8+fgsXn3VxYHDrJJXRApk3ZGk32lrqMUNJEXWw0bhw5l1EOhqljkjkc4g6Q==
X-Gm-Gg: Acq92OFiE5SHzb+jt3zuFvffjgUYXrjXZi2vohq+pt1zJApVhTpu8H5kwN6uK2LCjVp
	iNL6uc6ciRP/s7MMPS/YhxMepTjXtd+Rl4XAyyCnl7xVSzL2kxtBvCONsuv5cgxHeIdekJLhoK+
	KqG8vfRoeei5KVjKo/p6+7b9QEgpDcWQd3JYJZ580wjFIYHH35JfZQREUNYA0tcA+ZorYragbBP
	wYIVuiptJTXgT/c9fx6bKq69nfDHDNyNtky6r4H//ZcWuOfJkuMOrXHVmDyJJ4iccWovnL9/uK7
	L7oFZFWwdLQx2szXaYoCHARZvi5xXdGiFz8fit4Eu4adjmct334YVviD4ekwbzSrl3flQROY17Q
	0j9C6B07FVhF/KANelwqZfLAx6NaEgxIKbJUwbzMAyHRfssMtPftCRV8R8DY=
X-Received: by 2002:a05:6a20:be86:b0:3b4:b24e:27a2 with SMTP id adf61e73a8af0-3b4ccf7fefamr15902109637.31.1780902115326;
        Mon, 08 Jun 2026 00:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:be86:b0:3b4:b24e:27a2 with SMTP id adf61e73a8af0-3b4ccf7fefamr15902049637.31.1780902114854;
        Mon, 08 Jun 2026 00:01:54 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:01:54 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add Shikra (QCM2390) display support
Date: Mon, 08 Jun 2026 12:31:41 +0530
Message-Id: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVoJmoC/3XNTQ6CMBAF4KuQrq0pLbTgynsYF9MySP1DO0Ikh
 rtbcEOibiZ5yZvvvRhh8Ehsk7xYwN6Tb68xZKuEuQauB+S+iplJIbXQQnFq/CkArzzdzjBwYYw
 2UhQ1lILFp1vA2j9ncLf/ZOrsEd1jUqZG4+nRhmFe7NOp9xfvUy44ILjUllkNYLYt0frewdm1l
 8s6HjZt9HKpZF+KjIpVEZFWG6zcH0UtlfxLUVEpi0xbyGvUKv+hjOP4BvJD/NZRAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=3551;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=qoPjmohCj+qt+VnuKdYhqh4uHy1Ot3eveLLAi8iChK8=;
 b=GggoWg0wf8qT155TttrTaciEjH77CjKueLHxsW41Jlb4McBcfrIRBKW+Rytru5kPA/RgJ83qb
 BUv/XSFcBNWDOtsjCayphHwV6JyhMvY5Cu1GGuaKEUk+Xkdannknxzg
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: 75t82EGDWVq7-wkBFBXl3f2orFuTsVaQ
X-Proofpoint-GUID: 75t82EGDWVq7-wkBFBXl3f2orFuTsVaQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX68kmQfur86Bv
 Bnc3ci+LpWac3F9g4RkaOjv7Xa9gZ2/RmnTaVexOZSqZityUCsR7mE4xwka+3jZ+4bPLRXEliS4
 vJQIpUsUEfeHiREMBIkukin3nle/dcpmRfbBQDYmW67/wttrw1VPKJ3zm7hShc9J2emfMjYBFPw
 BWa7wf6KRa1ve2MOB9ePeh2XpdmJ5ZGJsK2Jqke37fy+npBgGi9upXvrOazlOLbAHEqGEj1CwpC
 3HUQknAYyAa5GWQkSmE2y57XRpBcbcmiPhA7nPjyu9w33R1W89YIrW0Ptew0Lc7fFVuk11Va3pR
 rJAMm9pcBn2esYY1NR8dzL3e4dXEH7G/s42vySvtsMo6YYEEizu7VBC2xrDYF91Kk9mbYCc0a9y
 t1rQGsqyGtq2xuRQFfNgXL1/DLS2JOp1evu0ubVV0FMqP31r1Q+R1fywHXz/HnR9/ucaR4uwaB+
 sUvDDCBqvdPKFHUUF4w==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a2668e4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_X6I45OPZ5LLD3mXDKYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU and UBWC configuration mapping Shikra to
qcm2290_data.

Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
fallback compatible string — no separate drm/msm or IOMMU patches are
required.

Tested on Shikra CQM EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (2):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  soc: qcom: ubwc: Add Shikra UBWC config 

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml		|  4 ++++
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  6 +++++-
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 19 ++++++++++++-------
 drivers/soc/qcom/ubwc_config.c							|  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)
  ---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Changes in v4:
- Fix sort order of qcom,shikra-dsi-ctrl entry in
  dsi-controller-main.yaml
- Replace oneOf in qcm2290-mdss patternProperties DPU compatible with
  contains: qcom,qcm2290-dpu, consistent with DSI child node pattern
- Drop arm64: defconfig: Enable ILI7807S DSI panel driver from this
  series; will be sent separately alongside device tree changes
- Link to v3: https://patch.msgid.link/20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com

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
Nabige Aala (2):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      soc: qcom: ubwc: Add Shikra UBWC config

 .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
 drivers/soc/qcom/ubwc_config.c                        |  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

