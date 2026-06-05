Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FC3F7AAC
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654767; cv=none; b=Lxv1ZE8++es5XD/qSoUiZ2L9B/sKLtINJ+shTZ3ASQ4wGqx9pxkqWdS9gWam3ECcwzlUBk2GWcBlMl0erFianP4zd1r6p3KDmlEGS5Beu8y+p62P5BoDulgMjdyffXj/fsFPmHNSUwXKC2hjRWcGzsIOSD3EhKt2R0vrEQCidH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654767; c=relaxed/simple;
	bh=6h+vF01fqXjL8C+60pXT/uazqotTaaqSviArNOyHNG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJvVOCT5LUj71A/rgA9fgtgLJup5mvqqVIYC3Mf0bd+iNNj/EzdFulLYQA2dG/+kcPfRgkNu68b08pZvbgXEaugKhGSDTHkLL01gUWJLMlq9lGbkP3TCgBKmxkDvcI6j/rlBkRfJm8gNAgzYhQ70KLi2meh68gD2WAEWrXSOEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ehgZvF7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FqRLM276; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehgZvF7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FqRLM276"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6554jhwQ2668002
	for <iommu@lists.linux.dev>; Fri, 5 Jun 2026 10:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=; b=ehgZvF7AZ5WrNQrJ
	H0w9egfZbOBcsnIpjqYB187lusX001tRhHyQnVDSyqF2734nd4pISwKOrD+v+NAa
	1sJROJep8REdoAInQbMSUb0rPn9f19P0fG3LkTb+NkzkRWvy3NUwFnWvLIxkzKrz
	wCdX2PGrht6JcPhb4OSeMDNxYQLYAs579V3mgCcLEY6ZGMArBJvQnyWWX9dLWy4q
	J8JGpdLHfWji9n3RxEtdvmAM+K2tu8HXoYHbwVfJgC3ugnOeJgkc6mvUkY+9UrmG
	+AiM7u0q1dlJsGJP1RQG88fNDEAYWcG1dvbsw3Gat65jaLxDQSXj68Opg9b55jQ/
	dqc1Hg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekemyuf0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 10:19:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf1dece2ecso18215405ad.1
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780654764; x=1781259564; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=;
        b=FqRLM276skIdjfyJcfQlU1Vvs8EWP9GUvmMDitNV7OF44kzBv/6zYOSFRBjAHBevi/
         pPQ6YAZzDXjCwVtqCcLoPID6qC5zIgBCglrRO/ITUG0IXjrX2RD8oJULvMwfwrbIrKRM
         YQsBgPS3/nDJob/huflorp1Nja0vR0o0s0RQEOQ2nPz8Wrh6UTyaH0s6eBrNayZ1JeYL
         iOtB765QGo8Tc7W5CmXrwySctpkYVa/DQhtjIzg6kIsFIre6DX/V8Bpytk9CoPhIE0G4
         EzTjZmNXm1eDo+X3yTh2c77t3WYsIRmjb/ivXciUineBM6Q1jqY87c89/McZQS/ES5NS
         7vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654764; x=1781259564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=;
        b=fkauEfCpHFWo4w4P/mq/JER0AcmpUXAG3deTfWuopLh9a8Tzo9RX6v/GhL0v4kToF1
         HaP87WQ3WBf/imZTaIjcEDtKfqdUT7/Y0FwwHSNMcjOoAqQqOKQm7F9jp6WD2PPg47R3
         eZeVFgAlOZBEfmPHVbhnDh9+tjEVTSCZ8jZ9aWP8zH1/PCLutscu2LkOnYRcDIjRdeRc
         Axr619LaH/+RxrWdWjG+9tOIbO9cdxBURyjZe0YswctqB1TeXOUdgyRMldqzyt23zkN3
         a9qx+118rahVndRvFzmlM37T3Sz+Y6vAj3LjI8KjXFdVyieyb4CSb6en9dtAJ9X2Jn80
         m/Nw==
X-Forwarded-Encrypted: i=1; AFNElJ/ukvDIFFBACbsz1mEe7J4FyZljihbWuFecOI/uFG+DrcGT1NdjCltCjZQrQDsVBvwKQvNzPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhevqqZssoGmFtodXuAX8sVEWSQ53nCyXAQUEj8H5YVLQzrLSs
	RCu7kRoIqQRtukPbEPNb2Qbou6wSrBY6LPmGSj3uzkGAaeqsAKlTnX8KJJaftwWDlHipcgiKtg0
	s3FSQv1tH8Jdq15TEdjqS/OP29lRY7VAJ9ceNIBbgLKG5nbPdbIXlTs5NfQ==
X-Gm-Gg: Acq92OGZ9CWdDxyCEHZGB/meAYDYmyQi7iMzVeCboeaqcZr010rxG0f1Cv7dZYC9Rv4
	fKUYI9ufxQ3b6HUyAcF/bdvKen/KxZZLQsJ4vrZ+/XFk17ItIm6qv1OPodW5pW4JG6U3UALOZme
	bBMLc1hA+Cosq/A7l0/5kLV7KFQelRJQnpYci/R53v0pdhySILVYwVnzQPokX3tlFQFpDRt8ETf
	xCtoM8gaLpynD/pEiILEiCK/PpuLMJY4CsJhnyFsYu4etSVzCGxSR9LkTzekP8VU0tBpIbjgbkx
	ZgDT7iZ/Q3tAqSdHg2VJQIAYoS56Xh7wy46vDHpBcZEQSPlM2olFoamoYUBN3c/g8OzWfvZaQFy
	0cOqo88PsdUdOEsccsAOpv5T2V1cpCl4IHg/8ORA+u4SoE3oRe3E3VvpB3nk=
X-Received: by 2002:a17:903:4b46:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c1e8979bedmr28483655ad.37.1780654763777;
        Fri, 05 Jun 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c1e8979bedmr28483275ad.37.1780654763235;
        Fri, 05 Jun 2026 03:19:23 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:19:22 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:51 +0530
Subject: [PATCH v3 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=4024;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=6h+vF01fqXjL8C+60pXT/uazqotTaaqSviArNOyHNG8=;
 b=TFxRUXxc1AM66zgTu8vryy4ABMH/7M1dXZw8TcuBEziBAE4HeSrNwG9FLnM7EYBN44BuRN6Dy
 aKPmV311+bkDAsH91RkXrlVUjkWwslHad46kxpe84+RjOtbqpfUeZdZ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: -DxS2i5Vitmfdqu1BIbsmHZ0PmFbyt5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfXzgb+1IKj/d5s
 +azRrWnBSMCEh+QrSvWkX/dFfvQbNaF0XRRVsXcvuQDM8gkPQcQgBAKSahrEcm/F+kQhGRNkneK
 YO6cBRN5smGUwLMmJSiMvnn+3qAQX0fJfD/nMGZM+9MKcW0VJUNyeiB5xrl6feu0rod0IP3a/U/
 XCDzj1/au4C+RL50t7YDsuRyT5BU1lcEMQOBSHCYQ4WswsL55BxW1Qf+Cpfl/2Q4Eg1D0hHRl5p
 WRSOaGLmyEs9kXflIYiAvDuomtT7B4/kbEeLaY5JdaPxHwBmFw35DFdgut3s3xixwOPSJSoUzwS
 YE7d4MjFOkG4RyyscURQZoScIASHIaCpuF+8XbvHH4v88u1wffMDPCwJmE4SOh34Jg7Z+iBB7LG
 /OKjBfW8x4vbELk4XZBgAMBES5qJbP+hed4TTqATkjD3Veob0MiIT0O7tDD+Nfr7Zey9oqQXQOj
 C5lX6IYk28VcJrEN8nA==
X-Authority-Analysis: v=2.4 cv=K/wS2SWI c=1 sm=1 tr=0 ts=6a22a2ac cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OEkpyX7SRU1z48_sfK4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -DxS2i5Vitmfdqu1BIbsmHZ0PmFbyt5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050099

Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
the existing qcm2290 bindings to cover Shikra by adding fallback
compatible chains for MDSS, DPU and DSI controller nodes rather
than introducing a separate binding file.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..ab2cfd6d6e3e 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -57,6 +57,10 @@ properties:
           - const: qcom,eliza-dsi-ctrl
           - const: qcom,sm8750-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
+      - items:
+          - const: qcom,shikra-dsi-ctrl
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
           - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index be6cd8adb3b6..e166a73651df 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,8 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
-
+    oneOf:
+      - const: qcom,qcm2290-dpu
+      - items:
+          - const: qcom,shikra-dpu
+          - const: qcom,qcm2290-dpu
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..ef21b2c263f2 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
@@ -12,13 +12,18 @@ maintainers:
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    oneOf:
+      - const: qcom,qcm2290-mdss
+      - items:
+          - const: qcom,shikra-mdss
+          - const: qcom,qcm2290-mdss
 
   clocks:
     items:
@@ -52,7 +57,11 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        oneOf:
+          - const: qcom,qcm2290-dpu
+          - items:
+              - const: qcom,shikra-dpu
+              - const: qcom,qcm2290-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +69,8 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        contains:
+          const: qcom,qcm2290-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

