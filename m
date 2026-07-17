Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14A3876A7
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320983; cv=none; b=bDEamsfPbC02enBN77sWqP0v484J5hTSJdnAqDhdPsUOa75BRg9m/+19aMGIuPJF1HQdbRBHWHPIZ15RWlLadbiVEFj52vWSXQ2TP5vtemsvYlHKpzi0yx2ndjL8KahA1gnkxbx3CEx2G79jyU4NLkLpovV+//OT3BxLurXrUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320983; c=relaxed/simple;
	bh=ji5iLrBg00KLDTJDEeIrkWdaqc6esAA0v7oRt6NInIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+UFJaThm/pTBHttw2dqPHATKwfzJQZx0pB7JtQ7QiBIWuPfWIly/zxnb++Zx62gKh4sNVzVd/ES4WMWZTp8VX7XFm6G5PgJbMg8aNqICEQXdyLA65qScWTgqf11ZWvYqWp/VgwBIIYsqzV0xlEJGvMUssPKWkdhesCks6sN2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpiX1zfS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRsB+OSo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpiX1zfS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRsB+OSo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtd9h2653094
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=; b=DpiX1zfSRa6lldwY
	U3+6wAwK7OaEjUxXNbS6Hpa/Jz9rdmUiuJruNGa7Ft7Pb87qNd5/8ado7rOywoji
	4g8r0n5RFV7qkO1xsONitbbpmd6wSIJCznkxWiA0eV4tMGotcuuqFG9WordV/heW
	63GJ6k2CtjkSArYE57hlftCsvm03e/Gye8q3E+q1/cQUKZwicwmULldy9+pxbP8S
	FISXmm7f99LpO+yvArlXiWZNavYDNvcCVNSE2ypq+uC19ybeV6JwC7YwVA1PNXMc
	msb1YG+ci7MF2ImSX7AqWz7uJYIdoiN1XUfk490TItw3eAD8W/N1yOczeHCe7mjk
	l0VYyw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pb8gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:43:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so252378a91.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320980; x=1784925780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=;
        b=IRsB+OSobxu59ej03bAJSZlXprPGSN+NOwXspWSfjd7D1WycOREjwDJlfWo3Bg8GAk
         lyM+bCYYtOMH9bfVWI0gPuXilPyMVHCq4jJtyXfE12+ceV7zplnCLN7+YkKbUzToogPp
         l/mTawK2SPTmyK9+luNpICTwjQUYYn/ZpR1fjF8H8eZHCLW/1gOpgBPWrNVKI2PwMKzy
         LSiKP/mNhm0N7ewU5S3k+6AAsq42AqVgeUnRifrWvciqnGZGE0YDNG5qp2SEHAQStSPG
         QkZlkYWNjURtvoe6CMTiQ159QjjZKoCPK4xnRQqSRgRMvLPWQtE1BeqmCCjHPRgo7XXs
         uKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320980; x=1784925780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2OnpQ0EmgRssH2L3CQIB8lRZrNWoIaLQHzlCrugCPk=;
        b=HHL3vblmG4b9bNyKNabINPn4R+tepQrJqJnJZtW3WJeOcHx4ToT0tcgEPyCh7D10K7
         oDK7zPlKvqjWz/91QDYrNTQsM/72C8Ub4h58N/mgx7pRN2FlTbTE9DV/wwkBjWV674b8
         eLcuI293+mWqSsfUzurS7noUYMidJn7rYoAY7pvh5vs4zX2+Olr1ELwhFnRSiZQQrGoG
         TsW0lElNrhW3tjWCnyGox8VJOUKa3l/rXjf04kPZIQo2h0MzjHl42SyPEjVFW7wx5FO5
         mr0u7XH0Bxo2Q9hG8nZTHXumeqb3PIEziH7J9w7lWpj/PxtK1eUesaRA8UGMa+0voufR
         cn/g==
X-Forwarded-Encrypted: i=1; AHgh+Rqyp/aaQsKYQDkLQ+HLabJnCi7Dgi2YEONvscX2+mRkKnfudK8HyP+ZG1RZGi0U/2uk5varjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxzTBxlC20TlNUJ3bD5Dl8PZos093KQVtTLZ9UsE9wvTZW4Msx
	4eiKpIamUcO7oKgS5ZhPMpa+a23eWZCFesiT7sH29snUOIgwF2DskoNX5k0ORebU8dWkOcMQaRN
	QaXxIrz+ucsJr452ef0/hzR56SedfJ9E/C70gBg73+GnVYcOh5np59goFfA==
X-Gm-Gg: AfdE7ckBDs5ejz3G8PVyjAFugROtsMfj3fQvkvaiZEZn8gV5c8B/CSxHL1hapKJEjzB
	vcVQeVwSRp52d7MQSDzPRFwhpfIRE/0icBDLXEI5UOwgodOXeETdX4jWttZ4YSck1Fttofo+uEt
	wRJyh+QYPwjKydGmPfmq2ZUeS6MfAC5mqqY+c1TKwZ2ifPy4e66BuB4tyqv7SC4IdMQETmNebm0
	XaAXNuFV4rceJkQCHOerQwdpJurnQ0ylcIDETdBMldsObqnPFuJPr5LWn1vqeW09zdXlCbbyw20
	mB+w+O++jrps25BzFFSdHh7wxH2w0ueu0Kr7lGWPzg7uZqroNV9uFKVWssNMZd6nb7w0G1NprMX
	q0YWVdFJa/MHQaiOnn9rME04q
X-Received: by 2002:a17:90a:d60f:b0:38d:c834:2106 with SMTP id 98e67ed59e1d1-38e4b51656bmr4228878a91.28.1784320979917;
        Fri, 17 Jul 2026 13:42:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d60f:b0:38d:c834:2106 with SMTP id 98e67ed59e1d1-38e4b51656bmr4228835a91.28.1784320979372;
        Fri, 17 Jul 2026 13:42:59 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:33 +0530
Subject: [PATCH v2 8/9] arm64: dts: qcom: eliza: Add GPU cooling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1862;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=I2qdHaXAWQ66skBdEcFBDJZY9iFXnEWZCtP8SvXbtEY=;
 b=Hr26za7eMf4CPEZuBeq1QpcGTa+cwNyDY7ry7ltZ24uYMQrlbbDQKhp1jH0P9FhBarogV3/ti
 yGBLL4sPirEAEkMVokLL3QmWaYWdYvOUfnk2qfLFmhYQ4OdQKTpPQry
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: OfVS0gy7UzudX4xalJkAPhWPPCfzlMz3
X-Proofpoint-ORIG-GUID: OfVS0gy7UzudX4xalJkAPhWPPCfzlMz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfXxF1kigYAqSw8
 ttRGCQIbkJu2kEpCb8IbfQclJG0YssL/1N1+dTlEy3VLDUk7XPObkH0Kvykyok0LJPwCzVoVqIk
 6ETqyFcwF2R7SRRvDqA7lHaWOtLF/PXwYqv85XnwPLBv3DQR7hi5rAarTwrYig5Rqtutxj4Zq+5
 lOEmDqcdWGfIt41yyZGF90m30lXM5Fd0Lf+34sKGEr+0QvQfJy2+B4koP8eh2B8nrLatTdb0xpx
 3ci8MSmXbVwBWGi84dbtDpW8tr4nb3ame18eZAMHjLqV+h0/ec36H4sTuzsRYOfQ0ATMVfRryG0
 td2FQV77Upnppci1zR6tHMJ5aAvQVllrabcG1d5YM9O+/YDaszE8YernPY9VcisgnMb5YQgZN2N
 NmkqTHP8JleECSnKVjtUxAzc+F7Onbl44E+z3FL+hX8De89Bnq9bz0qNVVgo+Kvj+s81F4ZLKX9
 gfZQfYiCyR9/YV7tPwg==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a93d5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wz9XmjxeAwFrORu178sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfXwDEiHsPNbCFN
 S3MFkidf19mRhGBBFGtz0RqRleC5a8E2IoUgCZmMWzS72SOYJIyi0JnPqHptdC5SkfoyjbBCQw/
 b+E63DRTT+EwNnHlEQSUArAWvyWF4OA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170213

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures. Set up GPU cooling by throttling the GPU speed
when it reaches 95°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index c24c5e9695d5..7a6095495b5a 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -22,6 +22,7 @@
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -4203,7 +4204,7 @@ gpuss0-thermal {
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
-				gpu-alert {
+				gpuss0_alert0: gpu-alert {
 					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
@@ -4221,6 +4222,13 @@ gpu-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss1-thermal {
@@ -4229,7 +4237,7 @@ gpuss1-thermal {
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
-				gpu-alert {
+				gpuss1_alert0: gpu-alert {
 					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
@@ -4247,6 +4255,13 @@ gpu-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		modem0-thermal {

-- 
2.54.0

