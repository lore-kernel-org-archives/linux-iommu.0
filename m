Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96E47DF8F
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374088; cv=none; b=i2KWfn65DnbLsmBboRi0uba41byWA+L9QALRHEFNwTX5QUo48+CEGOzHKATBAl17H2qKJU9n/Kv/wY29iOZ9OFfgiHNis3bxGU8OJeXy3RnPsHOqv2RXdR61gxOXHHnJjua7tlZAUDhXhpqVggfGPwvhbT6kwhnXbCyr4N0Jxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374088; c=relaxed/simple;
	bh=SVqkbnuVkvWM2bjS/owUid2P0T2KJfUcSYVpq7Ga13Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhhbnZPJoWjFsT05Al1I7abbR7bQTNejgdnsFRNFJ12+O0DoeGDbaBVivqrGNm5X+moo1b5XxTAR6An1+gAX+L0AQEc1xidJKdZiF/cWaXfi1OsfxaGeqFtuiWqEsawiT9DjHlx9gPxkdrOU90Fezx349FtmaoiP+oHXBkoB5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpDozFu2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aq6DyQwW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpDozFu2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aq6DyQwW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEMtZ1613914
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=; b=XpDozFu2LWxD0NRF
	QZAwx0qOAUTH6lndolSEVkfRt/n595rpztqrLrOuI6nsRg9//N6De1vFyrM1T4LO
	b7WRRmMzebi0hZmRsyHdfoMHK7W56FgClPjLXDyPlbP9V+LgptESY5iJgxJs3XeM
	smV2LG49t4ZteKBBOiNOrOuI/7Nl93I7ME/lJ7kk7rPdbdUow0DbkLUAY1O5ATxy
	wasw3XWaXBKMA3YBuvzd1B0EfKPhp6ptaBAagivk9zdlk4IvszFVLB4Kmu6RWybd
	Lx4VnLep/XuW+/3PYc3y1MPFtjD0vkg+sU6XzQE/eLa1kaM617t8pQF6joPn71Hn
	Jfx3bQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53de3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:41:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847e78d656bso6742868b3a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374085; x=1783978885; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=;
        b=aq6DyQwWnzEz9j/TVpGofF1GEFWWFAwAoedhtaIdNAxHMVVE71kZH0KwFn6JClTSOG
         tBJ0BX48svX7qGsswsVtV2xlNgYp1WKB1ti7eXXUa7Wc5UKT2jXhnErR3cig9TTwIGfD
         RB4ixR6sTioUzmHVH4TLlb28JBHd7Eq7R+nHS8EsVaC54glPA4z5F1obaQEhYbFeTp+V
         F9FTEvFYTbbOvPbzhL1Lc3iY16M/Pk4TTiOcXysbP0KCUIGJWWeRnsBEeEW3oDVDRNep
         n8jgOtys9lexvLV0MvEkAwfQWeuXfD2gGAKOo8q10+NsibdnAXs775lsYeMe5TV3KZDD
         y30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374085; x=1783978885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=;
        b=Ti4UJ0lIyNdhdsrMpPEwbBefIXZPG7b4eU5Zwf0OVVVns9MWKGKlOytBhyhVPmiSWe
         B4tsKcd/TfcWAgVl8EE0NQXeknre/+N+xceqYm44PmWyLY2X3K95EhMQfhSzVjKmcaxW
         MPLLRKbCeQVwvQywuqq636KzjGFROXPzzsCuK+btNQmNc6nIeikUL3mHmMeHutUPghQa
         iA649+P/DCJTAGgtQfUm1LE5N+53+isr2ST8RoCKcF+uZXdIIEX/rjE7If8TI/7WlDkh
         YrKSKs4WtZ7vlQ6Nd9RhQ8wh7JqdeyEvDMWN8SXlNNwLCm7rPaeh0tmeEXdfFVo7x3Et
         1X/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrXuMAC9Xy153rG/Tjpk85Q+DqHjysH9ld8gJSs51q6jchd1OrNNiqu2oK6GkRWJc1E1rcGDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzERPcREEGLgjtUA2uDcXf7jS743OKfwexX6jXoLKZsiYdHxf0S
	JlPOrSXaGLi0Rj/8e0tSRJbz6CkCc7+kOLPLmlTGO7IQ9SSjCRLA/VSobMwYEPn2XASryhCnBHi
	IG2h5RkzWdue+crni5ICToKy132RmFIYiBjwDJXhVxHjDXhZzrTF02YTI0g==
X-Gm-Gg: AfdE7clL8PR2qeuZaMaqgzAF6CFaolU/3Hi5RW1n+VFogyz/IRmi3rqcA4vAgw5Ef4j
	GSKF36Dg3PhU+FfRVOxWrnAEfmi4yOXpU1sWFmWGvLw8tPD3RJLivsLwuMk05FayFofLN5zWHPU
	X4Scck2yWhEpbFSroPXpONf7q2ZOXcBdbsLnPUWHM1m+yBTuIOMbu28h52AiY7Uw1vDYSQVDy8d
	dsqZNWLIa08wEfvZ0f3zG0uzSM1ix1rlpJcvQqoHxrqrTJ75hb1tMscpLAlAYz9/H7k68+KpzO+
	Jndg6VtgDExQmRMaRXWlnvHlCFS39G0wD/h8ChDjc9Sp+qQJadDMOPieIO5pqVG2tv/z9iRDIzG
	Q522BkqgyhIea54DLMb6nCuZwtnGy01BdRw4=
X-Received: by 2002:a05:6a21:3d84:b0:3bf:aff8:f572 with SMTP id adf61e73a8af0-3c08ee92e86mr2157331637.32.1783374084982;
        Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:3d84:b0:3bf:aff8:f572 with SMTP id adf61e73a8af0-3c08ee92e86mr2157288637.32.1783374084451;
        Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:23 +0530
Subject: [PATCH v3 5/7] arm64: dts: qcom: kaanapali: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-kaana-gpu-dt-v3-5-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=7506;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Paj+Uxrzy46nVOxI8FJpxB45y1EA6N7DR+yUmwEsd28=;
 b=/9SEus1VLj49Qfme1/2sFJTqMKJoEjB2c+6dOgkvo1lNSZmEe+k4v216hrME+T4zoLSMe+JWm
 XpEGGms5RCgCKOFHbgu5qiERzejMXQJWm4xUY047q7Ntp9Fzd/QWmBR
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: VZ6BkYEqAt0PIVAh2L_-KEcy5lm-wxbx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX2KNbrMpDdsif
 v5smhuRPoLa2Nw7iu3BlGV45jf1lHAMJPRpA+DPnKMK4aQXdRjeAmtYAuxEQuj/HKFMO67irvo6
 9epQ8WkRviXyzxLB0WxGm39DSpAAV6k=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2106 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FGf9z4Ax-beoPfFoyYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX9ZiM2P7CholX
 wtfN3IbA2jsHZqd2+ZzfShnbp/lZ11rRwM1qHQeR8WRfGboPQHAjNovehaUH88Nguz+bmAug6mI
 q2ir7TfVoGp4IW2iI4TRhllP6HFzSuWT5MHLYIF8WCT/iajl+I3hl8aegA25X5xFbK11WQUhDVf
 1sYkZ93VE7wPYHCJVylvHAzEQiMPpoGpcgVm0O8Wt+Q/uDdcg7CRAJ9bdCPfNQpp+pSWQIExDTs
 oX+XT0kKshFx5o9qtRemftVA96WW9V3TZuMqapRPt+c9Bpmlt4G8SosxTfCuhlra7LUHIBHOeDv
 GI/DKmR6BskxPNBKARwn1kZCMkQo4/MZoGhBJUXpb+Xm0rkLAyEOYA21uHj1s0brgB+7kdsRqHK
 JISURLMy9v1Sr+RP+7ee1L7igXJ0ZXHaIvq5sf/XS9Yym4Sblgj+n1rZAAPDVBIW1MJuONDe1gs
 axq6aGY95X3m3/SRm3A==
X-Proofpoint-ORIG-GUID: VZ6BkYEqAt0PIVAh2L_-KEcy5lm-wxbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when
it reaches high temperatures. Set up GPU cooling by throttling the GPU
speed when reaching 105°C.

Introduce a passive polling delay to ensure more than one "passive"
thermal point is considered when throttling the GPU thermal zones.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 166 ++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index cce2e0a3f971..79bf32a9df83 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7056,9 +7057,17 @@ nsphmx-3-critical {
 		};
 
 		gpuss-0-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 0>;
 
 			trips {
+				gpuss_0_alert0: gpuss-0-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-0-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7071,12 +7080,27 @@ gpuss-0-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 1>;
 
 			trips {
+				gpuss_1_alert0: gpuss-1-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-1-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7089,12 +7113,27 @@ gpuss-1-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 2>;
 
 			trips {
+				gpuss_2_alert0: gpuss-2-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-2-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7107,12 +7146,27 @@ gpuss-2-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-3-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 3>;
 
 			trips {
+				gpuss_3_alert0: gpuss-3-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-3-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7125,12 +7179,27 @@ gpuss-3-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-4-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 4>;
 
 			trips {
+				gpuss_4_alert0: gpuss-4-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-4-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7143,12 +7212,27 @@ gpuss-4-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-5-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 5>;
 
 			trips {
+				gpuss_5_alert0: gpuss-5-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-5-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7161,12 +7245,27 @@ gpuss-5-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-6-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 6>;
 
 			trips {
+				gpuss_6_alert0: gpuss-6-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-6-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7179,12 +7278,27 @@ gpuss-6-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-7-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 7>;
 
 			trips {
+				gpuss_7_alert0: gpuss-7-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-7-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7197,12 +7311,27 @@ gpuss-7-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-8-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 8>;
 
 			trips {
+				gpuss_8_alert0: gpuss-8-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-8-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7215,12 +7344,27 @@ gpuss-8-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_8_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-9-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 9>;
 
 			trips {
+				gpuss_9_alert0: gpuss-9-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-9-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7233,12 +7377,27 @@ gpuss-9-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_9_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-10-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 10>;
 
 			trips {
+				gpuss_10_alert0: gpuss-10-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-10-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7251,6 +7410,13 @@ gpuss-10-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_10_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddr-thermal {

-- 
2.54.0

