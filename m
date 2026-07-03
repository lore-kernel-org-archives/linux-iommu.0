Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49332B9A8
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110974; cv=none; b=YTQjo2T8v9FYL4tWl9GLnPujBU4wXSV3pqWRwgEKFtLZVBwF4sa5FYJDnIE8AfQ0okiIO0x5Xg9TsJJkfcPABkDWrY8tckdLjOhWUtzz+Wg0UwdSjlM2P80EUsD8LPJoICTZ5bigsMSKRrwdSC8udyotV9U+0fJ6KVsCUNOn0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110974; c=relaxed/simple;
	bh=uAhue2+JbkAQvny1V8pzrzyN0/Ln5iCfI5DeJLdWexM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZM0eZT1m9B08DoHnFC2AvsMNO1eUjPVcOjJ+fm8zNtlc7oY1Upd9cphaB/77aWOuMKGA/3UyK1BYZZJdwz9ys15KkXvt9zHynsjH7rO7uEUp8DAO06NLMveiavOw+HG7vRA17WQQnP6+kc5D6eX9gHRjq13zxi8CB2c2ASt6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZxb6vtT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/VQr/9e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZxb6vtT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/VQr/9e"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPdE71005972
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=; b=SZxb6vtTWsuUX97G
	SzcIb6CGjrgSesGPlc/VNJiwcsqrxlLNsVGeFauhYH4fgRIVWmV25pfpcYn284Tv
	L+NcnawufYpSOTZOWtrx2/CfO1xWv9FPBNaN2FHzkDg7NZoqqzikRV261dd8c4Kb
	IG5lJokMeN8qBCKeXLXTEO8PnABy7osOcXKlQoKbyhwHU80MqpcpbjYogTf8lAM+
	XAerE8rByHdKnfMafJ0YvK/gwSzl98V1D0fvYZFpGL4OqGlh9nTIXstlBMJNqZOe
	IsyZMKeq3MLfXDSwwU4zKpAdMXLFqThg/rnCkZd+nnUpROlaDI2SOygyVXKoQo9I
	l/CR+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyckna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:36:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe2607511so1395100a12.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110971; x=1783715771; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=;
        b=W/VQr/9euxun16x12Xx5CIyKluccJ2Zp7CtYBkmnSha8/XLqtqpoQRbr0ARQuS/qoL
         e59yRuGqM32jcljSmjZ5FHOokDxo/tIL3MOHwELUFz8/4PBCqEvF+cS01TA0PISWBPqb
         4EI+WXJafX449QEn6vNoSM8Yk1+q3FHRLGmeOYdlqjaI/G8KJ8kcmHOtMq/bP8V9VTQr
         22d1calUboUDWKNE979/6KJa/8eQrg5q98bAPG/LSt2BxuWeCXMVMN8PiCSkTfUrfkOx
         0qL6Kfi83K5yXgO0ftKPP8Hwt02lMrN90a6CrSWMO/B1q3rZzIXomjwNBV/vZaaB+eH4
         E+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110971; x=1783715771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=;
        b=iRZYmkdQQV2Jv+Y+K1rGd2U+QCdj4NSGwd63cHOYS9hG/bCFJYV+6O28d3TkNBy31q
         SxkLZRke+MH2hpqY6WaFqGpYQxhap1efc7gi9J9PWciKGzxBr7PvT9Ex1EHzPg6Itle7
         w/kkvfeUzDq2g60VztaF57WWS9n6AJel5u9fs1G+83gHaCQAI0R+bIrzve4vf6tLc8oi
         xYfzODh2gQndOyaquC/cnIsCV7hUHSTQOXTo1UMCtV9y7HyX+jtVvuIR7U5QldjLjpXb
         HWcPNOXt+O6JLISBfnVIzS5tQHe64l9Egp1TwRMOh1T1/DR87LDjTSMk41b2m87BAB79
         4sUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iPvrFu2D+BttY3gzacx7eCY/mtBZEEOKNlY4LFZZatnwWRy4Qtg4nFDKxLJMGp2uH8VAE/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXqr7cbo8EWi+szINAb68nhUfDJmC00K6oMD8/r05XiSSs0fZb
	DIPFYs4BUS1CnaTxCteLTZ1pZZzAgOUIpbjnwNd73x7t87uy2Niv8k82qIBkAY5uPed4DR+C28+
	5MHA6diJ9WUrfGibG1iun3SoNiYaDYdOvfR5MQN7jAoyWcYNM3i+kSIfGSA==
X-Gm-Gg: AfdE7clABAlAy76BI5bvL5Mwy70GkfBHgHmiq9dQo8K2tpZk+EmlCWb9EarPmLtzf9S
	uuyd1vNRq9oe1LwOXx/202SJBQ9pJw3OvC0x8VZx3ySK5rkU7Vk7Qo9sQeaAxvMnXZMDOBIH3V4
	2TLWrYPEfQSPuFG57gv8gjXvdhxl720oEh09bCU+tOV+mSL9X27uvj4NP6/p7wqAICA5JZKD1/O
	ycnmHlhawqOXTYqtOfSkbfgoai3p0ovkSke3lhB/+mXGUd1wd9+XEksSyBDygp82HjhJSQAVcLQ
	OMTUDYWx+Bc3cPo+ed6fNhtzg5gvKZMkcVuqJXoWk1w/BpTLgZKd+HfV6ZsVNLU60wtcjuVbs/L
	Yixbe4t8kGBGsXSy+w1mXFLZkyZ/kkMTKkQs=
X-Received: by 2002:a05:6a20:2447:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3c03e4a33e7mr806109637.32.1783110970886;
        Fri, 03 Jul 2026 13:36:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:2447:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3c03e4a33e7mr806080637.32.1783110970442;
        Fri, 03 Jul 2026 13:36:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:36:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:32 +0530
Subject: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1335;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=74nTS/9j7but5S78vS03fz5EaK8dfgZpR5pvQr3ISuw=;
 b=fhhF8bApESeoCdnsnhF6TzHQXTVfkzqJcFK9FQLBZgaMco8/KlnHfQggBrdsaT5VC2tQRhWNy
 UjnSFkiDIsEAWy1Jg6evvcA5ibpUHPzGK0ZoBVjfcDENiYdb8fIeL9R
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXzni51EtQTg1L
 7cld7X9vUy/Pvk4yQA4Eh5hbr2VajHONXRz3A4aY8TAGN5Iiv2Hj0n+pL550BLIcjTfrqjS6d59
 wB/ANzVmwhNV9FH31nz2mFcwxz3Axwk2+Syl7D9ZCHh2uyWeqL8jw9QzBcxV9EJtcI0wTkF77lp
 EH1rFHSfxV4sKA8853i8QwACdZVJmNAqOPZ+8hXQl23h8LgTtk/zUVSiCwFuux9LL+zkKjP2SgO
 QWVdWKsOZl6PiRrh/YwyQxN3FWo9Mu3XBv0rSDjG9gpciaCCVMXuM3/+kjoT7/zW5mZUtcGW86J
 WxktFoT1ibMgjs4aeuPKBkqD0Bbod9lwfa98970MxtspLcAYPyH9CjaC9Hj5xeH2C5N3p9yAmWC
 +WidFXzA1jArxVCRBhgUwW30c/StbAP5WWxPh2kZQ5/QNNS9tLCEC3IM0wmgF6DyF0RjIju/tTO
 xrOQpIf5d/bxH4/dWiA==
X-Proofpoint-GUID: q-fd5UlwbYUYaE-lDbXPJMyB3x5IEpor
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXyFplB1/0WkUN
 9QRExn3uAa7J9J/hweeQ78mSqU+zNTBKNi8oiAWjoko9CirveafapBt6mWsbuwHv7pqm0VKg4Dc
 zb4Bu7iP+Yij/3ehC/mzS2U9HZKQpGg=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a481d3b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: q-fd5UlwbYUYaE-lDbXPJMyB3x5IEpor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 115°C.

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

