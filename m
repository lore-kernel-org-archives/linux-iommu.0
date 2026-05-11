Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55796383322
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538267; cv=none; b=OuacUEam6z3vTaUCp/GzXlg+EE7iLVsAhkq/2S2ajhvOQJqtbp4m7xM2PkcxPI6ysx4F+W1xMQk3b+IgRNTDL+NrgdZBlE7b7UAVIabt0yrK+b1wp9OvtMN5OeBn4oo0hyCjaM6NEOAkaQQx9cjhBVjtTwQx75ugmAXsudLjKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538267; c=relaxed/simple;
	bh=+uTlY75+A8jGzIB/N4/xiE+azL9XNqkhu9GBlCp8/ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+0tTDz8OACvuyjoqudYRYdyuFp1oCO887nXPV1+fqCl5i/bKETv4NqnKQhKKEMQoYCLiU4RKBsGo9aa3sySv6AdF9k4JKZ/zBXPSRUF4HpIUvTPRJXE3AuvGxD0fYLH2dxbysnKcpyU8fSa8iBSA9smFzIEl5X2Jv2LzG4zpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFX0tL1J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QlHxgHrq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFX0tL1J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QlHxgHrq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6aoi1184397
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=; b=iFX0tL1JwxTdVnpl
	FH2njcSk6DdK2fIRndW8l+GZvPaNPKNCDf9bhXCT3aJp0V3s+BjTkzfYvoSudep8
	s7T37BLi+w1GpiVu1bsR6L0bglurLgO25nwUBj9iQuAWppwEdOTQ2G81NEkB1EUk
	3iWEHaACG/ixFmip/w2m5F760FO6s6KqGtulq37Sd/f0T8r2o0rnWNHKNM9K3RoZ
	aJPWFvIerAUp+xD4/ngdjgpOn5qYkw4K3qN5hJ4Zu8ykTQF741lwvFZtX6y96RoD
	CxMTlB92XG8ESXNUzpEV8lZP+n3yE60mMRzBhJZlH92yyZHmEryoIzdiLtF6OxLo
	wwAZKw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy8fnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso2465156b3a.3
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538263; x=1779143063; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=;
        b=QlHxgHrqPi+4IXrCrrW3hat1d8LNKhQspOGKw90jQlG4YGhhRJvkoXZTGtnV3noUDu
         wMjP1KlXQlyzLmUI9xKwGpTmD9Mw7vwWllv7WeC+7+LaGsJFPOPsCcnfdnw+A8K4+cAQ
         fPjeMgyIhe+bApoIYM+HLWEcf3vA6GQPnr/L593RFdcU85/R7rSAWvTDU9opREXBguqF
         sq8gkyoIh7CnF5NVXxs1IVPnee5E0bcRkAGtwX4uuOFnj2mMj5q/GHCQ1uJ5N0DXr0Uf
         6Ou7mmFoIFofgyC+XFnQb/kdNzeuqZCMBYkj2k5Jsbl36kHNTTXyqiQjsMFVD/ObexPp
         Ns4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538263; x=1779143063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=;
        b=ZI0kncaFqnYJNipZcdQXvWtlQ7q5b7MJKmsD2mMSLVQwzjqur2r/HgcZrph6OCZcnw
         w1jqnBD3Z1uAH/2hkmgXR7NootxCxQUaeAKKMKpLZWLp2EoxFzB8Xmatw4Mh5blj3Tyy
         FgbvRhdQFwDURjCiVyQcwzrBCfSkC8VFNio0kG4cmPRWtCafoamEgXpg3OfeP4r5scKm
         265ZGOYzuOrZmmAWtpSs/uKs3gx97id8uhe/FC1JRGWdrxH8ENkbGv2KOGROGU4IuueF
         DE1J8yYVoQVYIc1nfAXYSE9NlDGmXHARA+6+SvgJ1YZxojA/QnOqLdAYaHlh9UY6eNI0
         eV5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+wx7DdKSJBwW7h5f3ZJruJhgYW3r6RCMadPPDILQNgVX05Q34sW1pM97teSB2e09DiI9J8bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+pDC/7lqjiC52YN2uUDcIzwhK3zhu+Zcj1DkRkPiq0TTmV/BI
	n1GiBNguL7ysDR2Amput934cjsq7IzxtU8FzmIYriaTX8bVq2TxE+oPkX58FWanKEhhG+yPY5P2
	YiZahH39eB50BUidSkVEosst6G9wp3c/tNOiJJV5b887OGRszo/mWfezCwQ==
X-Gm-Gg: Acq92OGNIUesBF0/BsMhFF5wJkYa95KTjZ3lAffJyO+w95upXTIVv/2O+zxq54vS/Sl
	FWhrQ2/9Bh6+XH564NJLZybLuqrlhO9je8w3CNcvE0zy/Q9A7hV7Rq/ap7XwY05E5FpIeapmLRW
	/xLpmUqkfZy/HHIOQ4tYIeYHH+J2Z+fBCDRWBDUbcFvdzGqOri+BfDc4HYw7GWWyzgV9JeTLECt
	XTBVSG5RVWNgF1m++g7UKH4eIO5coFInzFRZxp2rB1lSqpYfGSYZ03ysAb8ZVN3QR0hmoulBc39
	4v4GrVw+OClyKIMIFBAp7zbF7YQnxhFR+pLnRCi9fHSZ4E3GZppTQKvHJx3iI05e4En+jJJEKLq
	ZR/ZykavlTk0iz+bgahBj6zWZGuK2jVHs5nRX+rnmBST2rw==
X-Received: by 2002:a05:6a00:4b10:b0:837:80a:5ac7 with SMTP id d2e1a72fcca58-83eebf9e24dmr308841b3a.45.1778538262966;
        Mon, 11 May 2026 15:24:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b10:b0:837:80a:5ac7 with SMTP id d2e1a72fcca58-83eebf9e24dmr308788b3a.45.1778538262422;
        Mon, 11 May 2026 15:24:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:24:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:20 +0530
Subject: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=7515;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ag86/kr8s9/wNu8KURJAXOYQ6Bs1j+iLqYPusIeA6fI=;
 b=wM8Owlud/s2u1nqMO3HiUFxdka2NfMzsv82KKylH8Ys+RapuHT1nTFY+UvTkFBsMlWzoxSROh
 bY62uNfVaVvBZFPfMENypFO/HWOelmtCw6Rc+QImvshXpSSNFRR5WwK
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: uEh7lUp6_rl7zFAHY4R6Bh-saCugkrQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX6srZepV4dXOz
 7Pzbrcz9VLuJFwnRq0j9aLPvolyyVARduVBwWCEZxrx1zIwciBN95VEjytHAmHsGWo3ue+5T+4v
 MyoYvdu4IVvoCAygUE4b48O0BgmoIRqHyqR92aD4XMzCcaTvKOXV3/EySXns2art+CHSXTL/tEw
 WSi0uTV8UWkECGyrlA4VGM55b7xNL2h9Jfsf02eD2prpxg34e/NZY1HmdY4KXx1RvBuKzpWKNm9
 +uUzlTNU21E03vqPN6r3k5XVQQ02tKbtOCAFZd+r8R0kQbhVEhHuVHXECCNArFLzpO4bgFsKQyj
 GfAaT1q7beYsgbPqLK0BfPD+UV932nxB9b/hG7cftdCaPc+ZV0e9az8+tkPE2IzeNYlGTXVkpO9
 ajlygI5KNI7bTczx6ltAH9yqh6r6g2MBcD1T6cfahBloM+Nh5eep66e+027BxWEADMfHNUMYq2z
 79ZwALjRrTDhY9LKLAA==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a025717 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qhQHLv6gl62QQ5NPC2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: uEh7lUp6_rl7zFAHY4R6Bh-saCugkrQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index c57aea44218e..5089416ec32c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7045,13 +7046,15 @@ nsphmx-3-critical {
 		};
 
 		gpuss-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 0>;
 
 			trips {
-				gpuss-0-hot {
-					temperature = <120000>;
+				gpuss_0_alert0: gpuss-0-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-0-critical {
@@ -7060,16 +7063,25 @@ gpuss-0-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 1>;
 
 			trips {
-				gpuss-1-hot {
-					temperature = <120000>;
+				gpuss_1_alert0: gpuss-1-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-1-critical {
@@ -7078,16 +7090,25 @@ gpuss-1-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 2>;
 
 			trips {
-				gpuss-2-hot {
-					temperature = <120000>;
+				gpuss_2_alert0: gpuss-2-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-2-critical {
@@ -7096,16 +7117,25 @@ gpuss-2-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 3>;
 
 			trips {
-				gpuss-3-hot {
-					temperature = <120000>;
+				gpuss_3_alert0: gpuss-3-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-3-critical {
@@ -7114,16 +7144,25 @@ gpuss-3-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 4>;
 
 			trips {
-				gpuss-4-hot {
-					temperature = <120000>;
+				gpuss_4_alert0: gpuss-4-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-4-critical {
@@ -7132,16 +7171,25 @@ gpuss-4-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 5>;
 
 			trips {
-				gpuss-5-hot {
-					temperature = <120000>;
+				gpuss_5_alert0: gpuss-5-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-5-critical {
@@ -7150,16 +7198,25 @@ gpuss-5-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 6>;
 
 			trips {
-				gpuss-6-hot {
-					temperature = <120000>;
+				gpuss_6_alert0: gpuss-6-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-6-critical {
@@ -7168,16 +7225,25 @@ gpuss-6-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 7>;
 
 			trips {
-				gpuss-7-hot {
-					temperature = <120000>;
+				gpuss_7_alert0: gpuss-7-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-7-critical {
@@ -7186,16 +7252,25 @@ gpuss-7-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 8>;
 
 			trips {
-				gpuss-8-hot {
-					temperature = <120000>;
+				gpuss_8_alert0: gpuss-8-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-8-critical {
@@ -7204,16 +7279,25 @@ gpuss-8-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 9>;
 
 			trips {
-				gpuss-9-hot {
-					temperature = <120000>;
+				gpuss_9_alert0: gpuss-9-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-9-critical {
@@ -7222,12 +7306,26 @@ gpuss-9-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 10>;
 
 			trips {
+				gpuss_10_alert0: gpuss-10-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
 				gpuss-10-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7240,6 +7338,13 @@ gpuss-10-critical {
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
2.51.0

