Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FD36897E
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238501; cv=none; b=stk0UI5H9JXISjEcx3/q90TLnobL8+MsVo8jSJyIWFdorMgVITw1gDGyFDP242n+BM0RKPkBjFZza9vn9ElNzUlFZ5beFwaBpNV+LAc8yMMjZ9PQACLOfjEMUMZt3aEvduuhA9OqryuK4pVuxwVBISMqecNuk77W7wQUCMSgI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238501; c=relaxed/simple;
	bh=hwll4aDaWfKrzYnFIye0/xRxnOtc64Q2aFLTphTnOGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfYjGAKrcTsnBCy5OnbXvmCblpv3MzCxGevLP9W/ibhdv/+4xC+nCzS61RUvbvMMdCoOniiqMTa6Zoz+UoRQAxAtkJK77kkZlAPUSTvuqlHNEI04VukI3JvGFM8OPeZyvX8ZKHuYV/oxVUtvz/T8JYN7jTbyPF4wpLzgORPyfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qx5yspbd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tv/GAruh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qx5yspbd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tv/GAruh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6653Z8MU622852
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=; b=Qx5yspbdlfUNL9ii
	fiFxRKEg9URPnF5RyoeNJjfADJQCSK3qyC5AfD6sEW2OE6/AoozW1EnPe5KkSxBq
	gKPJVcQw0bwKU24LhvZ+s9DJopAQI3recdlIKkAcBoi5fyS+V3JFCglRUiq+cuN8
	U7C6j+tdGmA28tmNlaOKCEbAv+8QH1ufWtpPj9VCrOGhNK+G+uXNMyUUzuEoxPml
	UCLHq+EuPap757k7hRNrEMa2aFQTZrgMUA4MU5oEmoXUGteUKnwplgCdL3mjmIJa
	n/itGay7c8Sjh1L4PLaGBmojl2oYXWy3Ks10LI0j/OepYOjWDwN+AKG0iwhPL2+u
	ncSDLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-380fe2a3fc7so1524018a91.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238498; x=1783843298; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=;
        b=Tv/GAruhFjDFXYGuY37LTd7SaLZSgLdLumhq69ygrmG9l/GrwfRrvLSa7Jc0UDLlOv
         yRIiOeUK1iMhUn5tw58brLiyG7oZg10lgoyhlz+55saPiY8Iem5mSE5WxRwGcLcOv8C8
         lviljKa3+UivaRoGPPqB5OH2oDmNIrFQF0WktztI19PJI1kDYsCOCMCgpn1wNC50/tub
         HBLs7uemxDKjK2xUNr68M/W4FJwPuuS3WmpvOkc9bt0rItm/EiIDaGS817nFTod62V0C
         d4TLC9+Rl3EJukJNu2LEw7ybjq3wh/lTrJXPgswB4cANsRhGb96fv+eR/O7oxMGhtb7N
         EVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238498; x=1783843298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=;
        b=OiXxYxnIc7LupFSVwISLYsI+HJRYIFurhAr3EGQ13hb+dgma7/hE89ZyHdIo3Duw0F
         10TbJXcocGwmvGx49RpGmYtCr287oOStIF9t8GEu8tOpAMuzCAhAEOBhRxhyKUeuAmNO
         cY7f8yTa/Zyl8AXL1+ncJ317fCufsy36wD5Ha3Zs+PG1Kbmc4ag7Zu2F360KszK4wb1c
         8SIcJMFopAeAI9sN9UaEc8N1TsQF8gi0f0ZnPw+GcIIsvLijEPVfktnLKxZym9iqyy1T
         t66cmoxPZXV63ieWuSqBrxO95s4ISn/rANHHFPZpNXWNYX8MR5AHn3xJvg9ZjumZpFtx
         Ym5A==
X-Forwarded-Encrypted: i=1; AHgh+RqsOQfZ+SQhRh7W8+ZdssqdA29Bqwvw7CkaEtIHDKoqChIT2QT/9Bh+IRx+UT7Bb+F134h46A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4+b+5Gai2SjRHEKESENPjs+z4sU3I3MuHgP0iqHc2YchV0CqT
	osV2HN0xMTKSAd2GxzMDI6u6dvAn82ta1enIqkk1YiAg4G8z9jH8G367vJqPlkqgb1Zoi02kSmx
	vqlGXzud2QGE5parp1NQ+MdllsRwnppEm8rxqOGrMgWe9dmpxA2CMlcW6Eg==
X-Gm-Gg: AfdE7ckO9uHapnLHVGfZUYwczbqdVGsOLeFWutzqqjllKhSBqcp3aGJ9mJJcz4vpLup
	uQ7qP/ULiy93rWKW5lgp0dMdn+CyeYxaKWyFhpHdQEyWjcsJifkQXm4qaVUWPj1pJXEzG2gZEC7
	ihNYghCzKozNmB6xo0ylVHRHg4plMPLXVHTgUJ+V98KrJNR96H4Ij0K9waV92wsUtwKpqLhftmm
	eJ1c8IhbzK9k5Z6CrSSP9eMjm+Z9y/jh7oNzZ54ZUElvgH0CNCgKQDiNNS10ddLb+akV3c1rvZ8
	mIawjEcCyqIRqQRXCJSEwnK18Uv1wPtMM+6RVytah3CkgIGHhHY65yJ5aUqpLJiaixe994+3P94
	yIUsJcZwSocxZbXkbyjKz4UOQNoMpxzRmxt4=
X-Received: by 2002:a17:90b:51:b0:37e:1ff4:44c0 with SMTP id 98e67ed59e1d1-38280b9bcfcmr5425899a91.12.1783238498230;
        Sun, 05 Jul 2026 01:01:38 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37e:1ff4:44c0 with SMTP id 98e67ed59e1d1-38280b9bcfcmr5425826a91.12.1783238497430;
        Sun, 05 Jul 2026 01:01:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:10 +0530
Subject: [PATCH v2 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=7387;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=833JfZNihmD8RpBWS3GutFMgkG/8R8DJendD6ZgxV4k=;
 b=46vkw/SaKx8RPOpF2uonJXYMzaFLsyvH53JVEeoX2mQ6/NxyaRlwNAFQLaDS88MJT6fF1y6L6
 oV9ZsxiWnmZDhI1TDNu9FpObgoDGJ+U3IOcGvSq28OkNynzmTyXBVp5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FGf9z4Ax-beoPfFoyYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: saCdtv6MDQ2NR0lPKZ1_30kKcR4yXfZR
X-Proofpoint-GUID: saCdtv6MDQ2NR0lPKZ1_30kKcR4yXfZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX5yH3WGLxvSiO
 HvEpLz2gXS0ulrzqMEIaID+Vr4DYUQJFUWeGnVi2DcN/e7XViHfxISd+q8d60zGH6U0X9qVNrpN
 oZjt9YkpWjq7lCN0/LJwqqaeYuRYw754cw+BTph677ddx8cQK/GCnLHgKgrZJzgNjU/VPLyDgDK
 SQ4Rel5AonmqBbf7dDBJI88ix384M6ylAhEtP9PEJ6Hnqw8a8eNf4tO8EvYKCK12mwDh0aEbavM
 U2XWnb0F5XrweOt7GJWFmmrO7Nelki95o9wJ6kZdvhz55BvvtRoG0BpMLb0xsEZeaPheCYZtiCW
 ddcSAcF3IY0ikD8IRNvIUrkXhwiDuPGU1LFSENm4Gm54jR0+KLL0BtMUrZQ/GN9nibD0rClJ/Qo
 HlsdLijWdccvD36UC7vhVDu4QjdNwdFXheL5rYB5ze17LcacxlABRIAxOgzljhQg1668445fFp/
 2/Rx0mHCq8LoqbGjbeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX9SQ9jfbwXQhm
 XNSBjM1LsDJQmIoVrHwRinl5wlLh/YocJ6UWSvg2IwwADQkecRwQGQwql4vp0A5hXtw4v20crsd
 A2eMRuT+iojWJrMOkv4uloL7HHg6Cq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when
it reaches high temperatures. Set up GPU cooling by throttling the GPU
speed when reaching 105°C.

Introduce a passive polling delay to ensure more than one "passive"
thermal point is considered when throttling the GPU thermal zones.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 166 ++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 009f0ae1ee16..b8acd9665575 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7059,9 +7060,17 @@ nsphmx-3-critical {
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
@@ -7074,12 +7083,27 @@ gpuss-0-critical {
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
@@ -7092,12 +7116,27 @@ gpuss-1-critical {
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
@@ -7110,12 +7149,27 @@ gpuss-2-critical {
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
@@ -7128,12 +7182,27 @@ gpuss-3-critical {
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
@@ -7146,12 +7215,27 @@ gpuss-4-critical {
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
@@ -7164,12 +7248,27 @@ gpuss-5-critical {
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
@@ -7182,12 +7281,27 @@ gpuss-6-critical {
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
@@ -7200,12 +7314,27 @@ gpuss-7-critical {
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
@@ -7218,12 +7347,27 @@ gpuss-8-critical {
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
@@ -7236,12 +7380,27 @@ gpuss-9-critical {
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
@@ -7254,6 +7413,13 @@ gpuss-10-critical {
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

