Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D16395ADE
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371960; cv=none; b=AztsFJQ+QnAJfk1EFu7QcC55nsSQsm6vdId9/NYoHwHwKch4BizcObn4peklvdKHma2jSsu9vwf03CXRMx9T2BtZteukDdQbolYhhUKtwwpRw7WYPjWxOKrXF8vf/VqMTZAfWaRWJANwzjpvBbNhxw7TiaSICN7EEUREJtqOgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371960; c=relaxed/simple;
	bh=JkHc4jgN+fyBxFfZzdD2L1wN0DrB/XlMCgvF65LmpZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AC/tyeNn6UTDaW4TafdUxp3CO0EcSaY42+Err1q9P7Sb9sEiuewf7iF7/rFGKjkbcbJQ/YeyjVw0cgwCHwWRTEGSZSPnnBJR+mLxfy8GlpNXh8S8BcF/dKnpZAx4K5pdVTWDCcPTq94nFF4MIea/sszgjuO/ccKRZjYoDRZlBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J4DbrB+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RlCQRou1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4DbrB+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlCQRou1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEDQq1665496
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=; b=J4DbrB+jhOv5gxN9
	x5IJA/SUxXqaEzWIz+uaTGf9ENjmxrOqUsWX5e8hgxA8bI43ilfHl6PNDT0DG0vb
	WCzY6/oaAcbo1o2Wvhrk4DC/yMZwplNKpkhSHshUGp/lACDR51i2Q0X7Bdocpt2D
	NCco6LOMC78ojg3oIgwq7h5fMW7mprv12lwMWVliMGgduqbgfDtPwo3WRBXkAWZE
	BI77d7v2gE1knBq6320z2tUpFnbDdGEpQe9F7yhe++5G/zc/cBgpxR+JptWFiMkL
	UsGKziW43XCuCrV/T0d0QxLSyA8ngBux9b0bjlIV4Z8fHPm59XSMM4OEFWwpGWnJ
	3zJ6ZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtwn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so2550245ad.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371957; x=1783976757; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=;
        b=RlCQRou1NbK/l9+pNa0VlIIFcc7slMhjc785e2YGG81J8IUI5oRaNpk+UgABx3F9cI
         9K8EpiSTW5SyXPM1FLazuQbZkSDpRU/0BlW8uPf6BMFRry86Zc+SvOuvay02Rv1XgEyH
         RHNMZcb6YqhcBcx48PMJrullOTMHzMW6yy/vYSmatbEyIBTcTOZ255ySPIuNYmqnmo0a
         g1IUzepvX2zJE6IE0OUZ9G4M3ZJ2rPsVFwjqWLX9q4bWsCrSHb+crrgsfLL+ke7rVCab
         xq9exMjI8IrKasRyL/mxa2tmHW/oQH4SlWPrnl2W7q6iBM0w+ULVvxK+8Th9TkkQC1m1
         5uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371957; x=1783976757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=;
        b=BjAwUBah2A1a4DLTSvDcPNssSqFVkZphzLI0+BLSLd6helIR+/rb8CGB1O1uzlapYd
         VspRitft7BIXerceLv6/7CTlX3PEhQDUKH6CkxRb4H9GVPSDBzeUDwwIuR/B88S3KinP
         /tk9/3Wx9fVDZI1L2+Zx3AtWqsIe6H6eGTEa3xc1SY8u1GpVm2S0pNBO4gaL/PZbSoeO
         HR6onfb6JlxQ1bX/qsu60BeccCXOzlq6juqaUWnWfnSlnYj0wzrQmU8ZQJC/h/Rne2mE
         fkXt7nlSy15pN7NIIb24q0w7efBOUR2V1Npv25MULZpnDx8YYE71tOFzg1oGJcQqIP/p
         lsPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8HPeZZ6rOsDI2Hrhllq1rFMrPR8N6tUO9cUIuVuLTIkJNpk3WlG2y8s6Uzjjy3GiIWf5Mzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7URFfB2U+2flhqToNoPgWedc35lPsP29jq+nioONNVwtqXfA1
	vLQQ9+ofoBg9Sy6yaj7Z+iQtMtjJ1CTdbUnD1brFlCh9KZLwGlj0B4Y2l30Msf83aZIKljJgIli
	Uffpe/4vOAdG9ROpaPN8w5d/ITYVFPj91tNMRku5mGPd7ajkSWw2q+8iSuA==
X-Gm-Gg: AfdE7cnkXZ4pwy46lQJYpUi7GwAmSxnal5+E0d+nG2R3uWi09BJFkPdBHHsGadgJqJg
	LtjbPdXdxYhoPSAx4wNxLHY9AY/zQ8QBBUh0lH0okRUlQGyl3eCkJ1tZUQtTBJ5erVSJ7/O1na0
	GKZGJX3afdb1QWBfah4ZT6zdBBugnMkCPOReRnRLG46kbc1PcSSRexVtVgfyfXpRFMUldAlIbwC
	m3I7UNpfhZgn29ftl2rEMaLwQP3qd4B6a7/jPjlwWBGppFHasAtyX1QPk+aAQ802Vmqwdvpgl5Z
	eATteGjtJteBBxcgZ++VkuvNtKtEif3NfD1cwMTFx0S2ELetCKZgXGg6LCNKMhmN+IEb6gFCf0W
	yfmvjGfTJetNXKx7myO0Tnpjit3mpvr4c5iw=
X-Received: by 2002:a17:902:e751:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2cc92ae0e05mr59299705ad.24.1783371956886;
        Mon, 06 Jul 2026 14:05:56 -0700 (PDT)
X-Received: by 2002:a17:902:e751:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2cc92ae0e05mr59297795ad.24.1783371953336;
        Mon, 06 Jul 2026 14:05:53 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:52 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:38 +0530
Subject: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1469;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B9OVGtbnZYkfAOGV7e+idMmskau8zD6EYz9PXmb17Gg=;
 b=EocsNCEZuvcYsspXlMq++ZuX9obJ9DqG9XuT+DH7vkNuX9uG1zfPZU+oZXMB/dZF43gnqSmnT
 sPV/SafOjxCC6F8qTmUW9Uv/DOprP1rlIUxv5uQc60NlDPDMd8kGgWM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: CcZMdM6g1ulcCuJs5sm6J4E6gPplzwGz
X-Proofpoint-ORIG-GUID: CcZMdM6g1ulcCuJs5sm6J4E6gPplzwGz
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c18b6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QmmV89ZizECaiV4F4FsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXwpye9k2hLYVh
 5IrpiIPGiMDzs5YnY4wjzEcL7O+XQPyohH0eEL9AckOu4VPcatbYEjB2F66qM8hTP9wNdGHGRFP
 LwqnZgb8p6ZDjUrNGBAFmbae1yZxTz3zNQ7VSuoQOpSL8/BE7WnQg4hLEtRjX1iixW0Qhi529Ct
 PNW/GVB25j0SxbpQSJzzv3n7Pb+vIlrWw6Hk3Wo3iqmnUd87uiIl+O4eaD0xkU0qEFrZVkQOKFh
 AnPQaP7fVaGQCSG4C3WPrbT9Oz+2OTRhZJDL+GR4jf8VPVen4Znoi7dOG2xF0V85GW4pPr3jsSr
 l1cragv27vqSulZsO6mSP5RzsdS1Ym9Lb0OiiJsXuUHAUlu7mEytxgpk8cyP2G8YgZbmLrzvYMP
 3fc2r6wfPcgW8Tbycvf8h1IzHEYqIt5SiNd+ZVaoOhzsYLqTmjjtkxy+s9bU0WzYZuXviJfHjgJ
 KwMQS/Uy+QaCd21PAFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX1BbIjo23lTLh
 CkWa9CpRbcq7vWdK+vV2G4c/R1ozvJivuEPI768vs0uyh6Bi3qkFSeu5V8YEpvwLCQxScV4/YNf
 wkAVP4Ah4IMK7sUx8EbvB3RC42FPyHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
use a passive polling delay to ensure more than one "passive" thermal
point is considered when throttling the GPU thermal zones.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 34261221664b..eeeaa369d3a7 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2510,6 +2510,7 @@ cpuss0-critical {
 		};
 
 		gpuss-thermal {
+			polling-delay-passive = <10>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2519,12 +2520,25 @@ trip-point0 {
 					type = "hot";
 				};
 
-				gpuss-critical {
+				gpuss_alert0: gpuss-alert0 {
 					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				gpuss-critical {
+					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-thermal {

-- 
2.54.0

