Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0E24E4C3
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142877; cv=none; b=lKCRaqTn5fSGG/Qn7Y56Pil8WDy1Cf7pJL581BEi4YOISohPRHVxk0rSXsAouphYzUxu9/foRw/nCI6L1PM+vrgvuusHCRP7NVMOTBst7d7MzNe9Y3LQOt/m4FjvBajazv93Lb342QU3Bu7ytv5GfWETJ4UJMQZKxhiB+FsoID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142877; c=relaxed/simple;
	bh=1/ovUC/jpZjjkR0Z5QdYPMJ2RWa75JptnhAdRldWsfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXlC0ItSKQH29aQYEwOE4Fv65cgwqVCaWCMVa0rLw2VtVH5J/4cOYcoKl5p06ct9Y3WBKSytyYhPm5OfbLJNbZOY9ZHAXcgFQUjIEu0gZfr0LeFaWJt4dcE4cxy1pScmmmKzGp9TagN2YfitbiHvzTj42tBnV0vuZnr13TRonLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AypX3FzX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqCmcpYA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AypX3FzX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqCmcpYA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLDCVF395324
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WvnuM6lEsyGS681md0Kapelq9j54YMHzp7QIrUMRP/Q=; b=AypX3FzXf/yoRhdD
	OJDWPtv3wqPe35wAyF0plC6mEpAJXER0i1+ova+LB0qwpYqo4rX+/aQAi5KcsV5T
	cvn15Wg0zCNUdJNhnyKDDWEuxX/IDUbhTBsG+8BgnBgb11McL4eWfA1aiW9MGZj/
	4asgEO4Arxzr4DLtdMjrVOOEjjHCGAkCOQFOqDojqccD3kV/njOZDnLLMP7Hhym0
	awimqO2To8jzedBq66wF3veyASeHykZXk62Tiuf5Ced1nKF+jTpnyR2leGyEsS/3
	SGYBBr6lQ8NPSnOo+VL8WUmc3OgMmQLUzw8reZw9yzVirI+TpzhCG4e2HICn2O40
	Y7corA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870s2kp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4654f9bb6so14736915ad.2
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142873; x=1776747673; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvnuM6lEsyGS681md0Kapelq9j54YMHzp7QIrUMRP/Q=;
        b=LqCmcpYAHgDuEJuGPtbnjZ/ppuflEOAIn7ZzfcpY2XWmrQ9+1m/jr90XtCFUJ1IQbK
         PYZNqbQy89vyYz2huL7vp8oXIqrNIyAgf5MLb4NWzZxwoTxcD5fnwZcMrW+xSlx09VYp
         y2xf01syT3bs//yLpyKT9ZNIjJdKTD1g3V8tjLStJFBYjomJlTVgya2S/n+cmu5nYS0d
         2qrWMkvQ9DdE5W1I5c9K0aA7msC2gNfG2OBEdqPBx+XdAzb9v/9yfcQlTIJEXKhcDN5/
         mocwr8RGoLrGzHnq0aHmWuvlq4/gsJmNWmlt6bjOidYs/+T81n80324Amwum6RNjDB5E
         93SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142873; x=1776747673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvnuM6lEsyGS681md0Kapelq9j54YMHzp7QIrUMRP/Q=;
        b=ga+vt1uGjePbodyVFbp4eJVEQEER8facg38r2Xa+iJvOn88E25ZomRKEstQMooIWrI
         y4uCjS6R/KIpLO11vIp0CIN5pFmr8f+KPu7QXnCBkpNjjpCL5gzQskz6kv0Mq77hYgsb
         jh993T8A5saFzPZpsoCOrHOoo6T6UKPbui0HLuRkzXeA/yie6XUvT2cK3PuEcTsGZBAB
         qSAhohHEh0j98iYUwpketvgzC2hCQKnw3fctLMMxyCQBBmwQJ8eP1vEyhYF3IrbvE7xu
         321crsMdsn60V9Dui+QDYt3BwsriTSiOMtpSvEaPJJpd0elojtF6gjiWCu+aknQ1GgGZ
         euzA==
X-Forwarded-Encrypted: i=1; AFNElJ8tpxjYOkdRS1fowast13va+IRN967fikMq//bfgPIoUEOCIChTd2mfHqBAnRHSyhANdpAmVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLalVd76mUL+ia7AbITU9YFUB/RwlncBJ1/H1ZE4krG99TgqfU
	A7aXc3l+Vpg9lpmGQ6okxvyPF3mAstFkRf4lNHIQUyRWgRNU6jo5iF6baSITCR5ZjR/SRfKXDbu
	ZKKJCO6Y9z3wgnU18KxwFxmKgf/JmxxkAOqhcQbUMEFPpvbrcsINnNgN5dg==
X-Gm-Gg: AeBDievhmqA1RlsWoErAAy9l+r/GskV7RaYrctiqU1wZrWVNHylu01FejoT04fJE5O6
	ijC48Dojzo3bGs7pPRIc4jrzMrcZbpYo3t+RNhdAwDdsKs3Xpo8cfpcmTRo0BVxETbZhSlmwyia
	2JQgdiqBlOTbhShW5ZH//7wV/TY7OpgSPFdrR6s8MnHVz1rF6jalEcOEO0uGA4DfwBQHBPSKCTN
	2vMaPsr5Jy8fsOQgxHFbbqQ+OIqlvyemUV+IGN3pyjP4HClDh/VquA3IDblUO6Ehkst6ipIqdvn
	CjFHF1te5YyedJUR4MOSU+22AiorVg55Q/WtUPX5D3upnxgb5xiLn5k2yD1lqyPeFMmXXsvT1+X
	f6V2XIxPHi+5IMGm1QtQ5zosp+FKIgJNKIUjLjJOPinXD8lxBX6WBA60=
X-Received: by 2002:a17:902:c950:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2d57e584cmr147553925ad.0.1776142872491;
        Mon, 13 Apr 2026 22:01:12 -0700 (PDT)
X-Received: by 2002:a17:902:c950:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2d57e584cmr147553525ad.0.1776142871908;
        Mon, 13 Apr 2026 22:01:11 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:01:11 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:03 +0530
Subject: [PATCH 07/11] media: iris: Rename clock and power domain macros to
 use vcodec prefix
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-7-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=17150;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=1/ovUC/jpZjjkR0Z5QdYPMJ2RWa75JptnhAdRldWsfE=;
 b=3/UqNP88kXRuaYDQsOq0a52JUAAuyCSfVAZYLuQv+3809TrfCGYJo6Ny4byeS7vqFozf+uBTR
 uPRPqOibMUkDl12IKu9gIJ6aBmGcIxTVufb8/LnKAapJbUxx7Mrq5C0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: tQdModRiwFFlqnLkRiLLiUH9soMnbvbC
X-Proofpoint-GUID: tQdModRiwFFlqnLkRiLLiUH9soMnbvbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfXw0Xv0rRkJT+I
 tN25yMg/MGW2/lmGZvmz/6BGgiJG76HK8DJgA2X/54p7ctLKCRtjpYD/D1gmdupEpT35hRiiZik
 zVUgGZEIWp54ukWfWdxsVUmR4vd8f3Ow362KCK3EVLl9o1UjAI46mVfZ+c0MoVwCRoTt68GuXeV
 fj1zt9NSuIC2ancXYg87Oj76VqGMJeeGpvtep8Ba9TUIlO5z2RpgLuG949qfnCFkjbDEw3/3+0T
 xi7GDRtx0Q+sMSU1M64R+UYbOGAaqR20TMwhOP8I2fLwaMXdKjwAyqlBCeo4MrZyN7R2rvTTmaB
 rFQqqsGeKHMk+JUScTLC64qP8OdWI/6B0P6ZwK2cPI+h4KngtYfag6Ftc0eBbda+Urc8amvJCuy
 SnOcXoj/TUnWYbwUsPwikfnbRxnpm23cmHAxAhb8QMRE8whH0hNY/t7kgTPjdbWg0hzs/Vv+3Sf
 C3l0orOzl5vqZqXL2ng==
X-Authority-Analysis: v=2.4 cv=MK9QXsZl c=1 sm=1 tr=0 ts=69ddca19 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kpNcZxiqwdVgWfiEekEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140045

The current clock and power domain enum names are too generic. Rename
them with a vcodec prefix to make the names more meaningful and to easily
accommodate vcodec1 enums for the secondary core in the following patches.

This patch only renames the macros and does not introduce any functional
changes.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      | 12 ++++----
 .../media/platform/qcom/iris/iris_platform_gen1.c  |  6 ++--
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  6 ++--
 .../platform/qcom/iris/iris_platform_sc7280.h      | 10 +++----
 .../platform/qcom/iris/iris_platform_sm8750.h      | 12 ++++----
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 25 ++++++++--------
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 30 ++++++++++---------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 35 +++++++++++-----------
 8 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 55ff6137d9a9..30e9d4d288c6 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -49,14 +49,14 @@ extern const struct iris_platform_data sm8650_data;
 extern const struct iris_platform_data sm8750_data;
 
 enum platform_clk_type {
-	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
+	IRIS_AXI_VCODEC_CLK,
 	IRIS_CTRL_CLK,
 	IRIS_AHB_CLK,
-	IRIS_HW_CLK,
-	IRIS_HW_AHB_CLK,
-	IRIS_AXI1_CLK,
+	IRIS_VCODEC_CLK,
+	IRIS_VCODEC_AHB_CLK,
+	IRIS_AXI_CTRL_CLK,
 	IRIS_CTRL_FREERUN_CLK,
-	IRIS_HW_FREERUN_CLK,
+	IRIS_VCODEC_FREERUN_CLK,
 	IRIS_BSE_HW_CLK,
 	IRIS_VPP0_HW_CLK,
 	IRIS_VPP1_HW_CLK,
@@ -206,7 +206,7 @@ struct icc_vote_data {
 
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
-	IRIS_HW_POWER_DOMAIN,
+	IRIS_VCODEC_POWER_DOMAIN,
 	IRIS_VPP0_HW_POWER_DOMAIN,
 	IRIS_VPP1_HW_POWER_DOMAIN,
 	IRIS_APV_HW_POWER_DOMAIN,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
index df8e6bf9430e..be6a631f8ede 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
@@ -284,9 +284,9 @@ static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
 static const char * const sm8250_opp_pd_table[] = { "mx" };
 
 static const struct platform_clk_data sm8250_clk_table[] = {
-	{IRIS_AXI_CLK,  "iface"        },
-	{IRIS_CTRL_CLK, "core"         },
-	{IRIS_HW_CLK,   "vcodec0_core" },
+	{IRIS_AXI_VCODEC_CLK,	"iface"		},
+	{IRIS_CTRL_CLK,		"core"		},
+	{IRIS_VCODEC_CLK,	"vcodec0_core"	},
 };
 
 static const char * const sm8250_opp_clk_table[] = {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 5da90d47f9c6..47c6b650f0b4 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -780,9 +780,9 @@ static const char * const sm8550_pmdomain_table[] = { "venus", "vcodec0" };
 static const char * const sm8550_opp_pd_table[] = { "mxc", "mmcx" };
 
 static const struct platform_clk_data sm8550_clk_table[] = {
-	{IRIS_AXI_CLK,  "iface"        },
-	{IRIS_CTRL_CLK, "core"         },
-	{IRIS_HW_CLK,   "vcodec0_core" },
+	{IRIS_AXI_VCODEC_CLK,	"iface"		},
+	{IRIS_CTRL_CLK,		"core"		},
+	{IRIS_VCODEC_CLK,	"vcodec0_core"	},
 };
 
 static const char * const sm8550_opp_clk_table[] = {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sc7280.h b/drivers/media/platform/qcom/iris/iris_platform_sc7280.h
index 0ec8f334df67..6b783e524b81 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sc7280.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_sc7280.h
@@ -16,11 +16,11 @@ static const struct bw_info sc7280_bw_table_dec[] = {
 static const char * const sc7280_opp_pd_table[] = { "cx" };
 
 static const struct platform_clk_data sc7280_clk_table[] = {
-	{IRIS_CTRL_CLK,    "core"         },
-	{IRIS_AXI_CLK,     "iface"        },
-	{IRIS_AHB_CLK,     "bus"          },
-	{IRIS_HW_CLK,      "vcodec_core"  },
-	{IRIS_HW_AHB_CLK,  "vcodec_bus"   },
+	{IRIS_CTRL_CLK,		"core"		},
+	{IRIS_AXI_VCODEC_CLK,	"iface"		},
+	{IRIS_AHB_CLK,		"bus"		},
+	{IRIS_VCODEC_CLK,	"vcodec_core"	},
+	{IRIS_VCODEC_AHB_CLK,	"vcodec_bus"	},
 };
 
 static const char * const sc7280_opp_clk_table[] = {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8750.h b/drivers/media/platform/qcom/iris/iris_platform_sm8750.h
index 719056656a5b..f843f13251c5 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8750.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8750.h
@@ -11,12 +11,12 @@ static const char * const sm8750_clk_reset_table[] = {
 };
 
 static const struct platform_clk_data sm8750_clk_table[] = {
-	{IRIS_AXI_CLK,		"iface"			},
-	{IRIS_CTRL_CLK,		"core"			},
-	{IRIS_HW_CLK,		"vcodec0_core"		},
-	{IRIS_AXI1_CLK,		"iface1"		},
-	{IRIS_CTRL_FREERUN_CLK,	"core_freerun"		},
-	{IRIS_HW_FREERUN_CLK,	"vcodec0_core_freerun"	},
+	{IRIS_AXI_VCODEC_CLK,		"iface"			},
+	{IRIS_CTRL_CLK,			"core"			},
+	{IRIS_VCODEC_CLK,		"vcodec0_core"		},
+	{IRIS_AXI_CTRL_CLK,		"iface1"		},
+	{IRIS_CTRL_FREERUN_CLK,		"core_freerun"		},
+	{IRIS_VCODEC_FREERUN_CLK,	"vcodec0_core_freerun"	},
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index fe4423b951b1..1f0a3a47d87f 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -209,7 +209,7 @@ static int iris_vpu33_power_off_controller(struct iris_core *core)
 
 disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 
 	return 0;
 }
@@ -218,36 +218,37 @@ static int iris_vpu35_power_on_hw(struct iris_core *core)
 {
 	int ret;
 
-	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC_CLK);
 	if (ret)
 		goto err_disable_power;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_FREERUN_CLK);
 	if (ret)
 		goto err_disable_axi_clk;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_CLK);
 	if (ret)
 		goto err_disable_hw_free_clk;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], true);
 	if (ret)
 		goto err_disable_hw_clk;
 
 	return 0;
 
 err_disable_hw_clk:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
 err_disable_hw_free_clk:
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
 err_disable_axi_clk:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 err_disable_power:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
@@ -256,8 +257,8 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 {
 	iris_vpu33_power_off_hardware(core);
 
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
 const struct vpu_ops iris_vpu3_ops = {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
index a8db02ce5c5e..4082d331d2f3 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -27,7 +27,8 @@ static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode, u32
 {
 	int ret;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], hw_mode);
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN],
+				      hw_mode);
 	if (ret)
 		return ret;
 
@@ -63,7 +64,7 @@ static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode, u32
 		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP0_HW_POWER_DOMAIN],
 					!hw_mode);
 restore_hw_domain_mode:
-	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], !hw_mode);
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], !hw_mode);
 
 	return ret;
 }
@@ -162,15 +163,15 @@ static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core, u32 efuse_v
 {
 	int ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC_CLK);
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_FREERUN_CLK);
 	if (ret)
 		goto disable_axi_clock;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_CLK);
 	if (ret)
 		goto disable_hw_free_run_clock;
 
@@ -198,11 +199,11 @@ static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core, u32 efuse_v
 disable_bse_hw_clock:
 	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
 disable_hw_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
 disable_hw_free_run_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
 disable_axi_clock:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 
 	return ret;
 }
@@ -216,9 +217,9 @@ static void iris_vpu4x_disable_hardware_clocks(struct iris_core *core, u32 efuse
 		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
 
 	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
 static int iris_vpu4x_power_on_hardware(struct iris_core *core)
@@ -226,7 +227,8 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
 	int ret;
 
-	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 	if (ret)
 		return ret;
 
@@ -278,7 +280,7 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
 						[IRIS_VPP0_HW_POWER_DOMAIN]);
 disable_hw_power_domain:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
@@ -356,7 +358,7 @@ static void iris_vpu4x_power_off_hardware(struct iris_core *core)
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
 					   [IRIS_VPP0_HW_POWER_DOMAIN]);
 
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 }
 
 const struct vpu_ops iris_vpu4x_ops = {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index bfd1e762c38e..006fd3ffc752 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -213,7 +213,7 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 disable_power:
 	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
 	return 0;
@@ -221,10 +221,10 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 
 void iris_vpu_power_off_hw(struct iris_core *core)
 {
-	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], false);
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
-	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], false);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_AHB_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
 }
 
 void iris_vpu_power_off(struct iris_core *core)
@@ -251,7 +251,7 @@ int iris_vpu_power_on_controller(struct iris_core *core)
 	if (ret)
 		goto err_disable_power;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC_CLK);
 	if (ret)
 		goto err_disable_power;
 
@@ -268,7 +268,7 @@ int iris_vpu_power_on_controller(struct iris_core *core)
 err_disable_ctrl_clock:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
 err_disable_axi_clock:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 err_disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
@@ -279,30 +279,31 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 {
 	int ret;
 
-	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_CLK);
 	if (ret)
 		goto err_disable_power;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_AHB_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_AHB_CLK);
 	if (ret && ret != -ENOENT)
 		goto err_disable_hw_clock;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], true);
 	if (ret)
 		goto err_disable_hw_ahb_clock;
 
 	return 0;
 
 err_disable_hw_ahb_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_AHB_CLK);
 err_disable_hw_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
 err_disable_power:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
@@ -362,7 +363,7 @@ int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
 disable_power:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
 	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CTRL_CLK);
 
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
@@ -379,7 +380,7 @@ int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core)
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI1_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_CTRL_CLK);
 	if (ret)
 		goto err_disable_power;
 
@@ -396,7 +397,7 @@ int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core)
 err_disable_ctrl_free_clk:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
 err_disable_axi1_clk:
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CTRL_CLK);
 err_disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 

-- 
2.34.1

