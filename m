Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F527FB1C
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951065; cv=none; b=A61SuNzeMXJ3kfFqR7a2/8JzuTP0Knf5Z1YST7EDm6A5gc3VMJw/Y19BZDpskFINGof6Oa+TaDfpN70uxfnYz2zr1ctE7AHGdi/GEo9FrIpIZkll6Si4RpNL/wFucWfVxTtFxkxVqri88os1y3hrnx+I6KQMq3Ei1aYrH3tjRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951065; c=relaxed/simple;
	bh=m5k//9k2AZqLBLTijFuX7klJ8v4jofc5QHXrTy9WJIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThZtOyFy/UpYNprb4mWqO0wGgaCWX2SwHoHDFamf7ZwOmjW2JDQfU1zZma1r+VL53stYFr4ILuVZ8utnS9ilt6bigzRMwR37LsWziakCoodFJnYWSqzW4pTcxGyEBlnSJPVCSxuusaOnKtB9yZQb7D+q3PDl9QkCtFesA5W8jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhD3r7gE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDIQVCCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhD3r7gE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDIQVCCa"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8u1Oa366169
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BuwJDFwl9orRME+wdYyrWEnQLmpCChqNE71P1LyFhI=; b=HhD3r7gErjJUQMqA
	BRLbq7nzC7WIL8MiX9DGFMADFo8jio5/Got22XwKbyySKhXgbzESlysaOFfvJhSb
	GYUl8h+P52h7tGH3j/mTwDAnAHBzyG6k8/oSxtyVdpy2y0dhKFuY9NMVaifrS3FD
	cfc25llbPLangxF5Je87vN2MAtvQIOoGKFSGEdaH6VmMQLCA3A1amdls5HRyigjg
	4YMvyT7OxcQQrmemioBZVcIu/hNbfomSUyO5WPI1pQnNpPA+kEaiRx3gheVxQycq
	BFM3+7Dz070b0ILahCiSGCzWrkRzt4EY7BBlCs41YM2rJ19bKULxNFXdUBEagKz5
	fhWWKQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rbnhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adc527eaf5so53077855ad.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951061; x=1777555861; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BuwJDFwl9orRME+wdYyrWEnQLmpCChqNE71P1LyFhI=;
        b=gDIQVCCaV3shiaT0fu3Q2oIbWhwVrel2ZeOdRPYhyHC4NRslHwOq6EVmYKSH4NlSFP
         5tQEPi6YvGenykTUnseC9I0wu4F8Uk9+TE1putw4AZlj5jG9uY9X7+O+zmqZnpC9iozx
         7q8UqabP5L4x9SXbcXQEgUPdUdgyPYrjx3zgeqQOfgs/8R7xuynUciGFHzD3CRuMok5e
         XJwxzXKYiTN8eKCTq6VNY11EVWiWhJsQOWZ1AvFMpwu7HdzdetmxPaEtWVIW/hrN3HE9
         hBG7UOMmFPYvLKqRq4FQp5r1iV1xHAITDOXKvAqvhmxQnTp6sjtgyqjZ8TObC3JtIUFY
         AT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951061; x=1777555861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BuwJDFwl9orRME+wdYyrWEnQLmpCChqNE71P1LyFhI=;
        b=Y4Je83EcwBTTSJRHKt7PRod2BousJPQUv6hfs2IJZUn+213Qv6e9KVHzJhj4/CEGyp
         oNoerzl+pmfnRstMZtSXjz91pWHvzNLjB7dy+8BB9qQu22jituWUkjnJnVwFEr7hHzrM
         9dLo3RfjUdDF7JhSxL/inC1OUjvvVbUG18mc3QhRzYQ1bYnT1BIeewtuoCI4kJ1rzb1O
         2IePdnbFAFmc+jZHaMiS058SLi70VE3FFerrBLLrx1a8nLtCj+KUfckTYf4DQYZHsEKh
         pH3YN8A5nj9hiSRqP2Fvv+7pbf/jmrZ9uVEES1IvciuHRdrlRI6FArCso1WsAHa0ZE/Y
         y/5Q==
X-Forwarded-Encrypted: i=1; AFNElJ96L3Kq0XHw0dXiYPgAUAdbWVjjSpFF9OG7Z1XWuv/Cx0GSrY3340CeCHBLFeK8sg4xNF4kGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRsn59PvfyVUERxe114u+SZ+AYhxB3lH7FHFThUBtIW09u0R1x
	oMO7bcNIx7TCYAP3OUbFmxK14HecZtAnume9dO0VALy1iDswMfCG5KYY/dl0RLqcqxdmKWzFAjJ
	XirfXQPySn5IsxEPoRqVmjYCtIzQ1QN1IiLxeWdbD3QTxuSRu1w/UBESsiQ==
X-Gm-Gg: AeBDiestyZeFNbvR4zcUBMuQLDfaU7GyMughai2ytGX4LuyEy5sGXZ3/nMA6Y/QJ0yH
	lWKV2SLXOVdcAO0uZLq8UMR5Kc4PhcpKGxRfAdgbKNHCU9Omqc6XkLIp4LQ2fYZSvVTHdbXoVml
	wCtaOWVQD+c+8cTX+Nz8vuddRzuOt5aT7llbmuIt3RI+CelKu7SPa3rmY06/0Cp5NStMm89V7NH
	5+9jIJksthE2KG2a95p+A5a3FmwwvK7gvjE1wTDY552IlQMECRzTPQuLlA12CU1GVDTjPgQJmkp
	fGRdt/jTSoINuAJBQ6/o94KXVkBTaiyfOGEYqzAHIRPZdtHIjp4Y/y4gbXmH5RvQ+erhWJrLToJ
	F5eX/z4jRKsr0vW+OhogGZ+yUCSKY2onyXO5QEDUZgJHEW0ovvfAiA2SMfz501VwBWw==
X-Received: by 2002:a17:902:fb03:b0:2b4:5f19:1d46 with SMTP id d9443c01a7336-2b5f9f3c5efmr196507625ad.19.1776951060998;
        Thu, 23 Apr 2026 06:31:00 -0700 (PDT)
X-Received: by 2002:a17:902:fb03:b0:2b4:5f19:1d46 with SMTP id d9443c01a7336-2b5f9f3c5efmr196507005ad.19.1776951060191;
        Thu, 23 Apr 2026 06:31:00 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:30:59 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:36 +0530
Subject: [PATCH v2 07/13] media: iris: Rename clock and power domain macros
 to use vcodec prefix
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-7-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
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
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=17094;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=m5k//9k2AZqLBLTijFuX7klJ8v4jofc5QHXrTy9WJIk=;
 b=1Ygyh6Mhycy7NX/U8Ce0KIUOHTLFfBGTXVdgRPbkst+rOtOaW8mFgoRJ/0R8tsBXKiBpJKUH4
 5tEAYWHFTlTBFQBnShzPMGCGC54yssp+2PbCe5Jf73uu52/MVqWSF+b
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX4n22Nv7mo/qv
 UikMmhj3qDxp6sc52q3+3G+c22GmHr2bEMRsZTbbL6QK7G282Tf/tpuK+8/o1fhfuyJHmYiT11i
 wAZ14d3xQSxfc5P5Dzc4FcYxx8fYYs8Pqp7kyHmGCWO6SSEOCIY9z3HJkZPeNs6ZZXDpShYjd36
 a7OHFgrfpYPTpZzkiNVgYC0fk52M8OX+1Qj6OuFdbgyas0hzIOHtp9CqglHR6Ac+rfJZKVNav2a
 uDWI+VOwEHhhCWiHttNJ3A5iFv8ocvDevxqQ7XovIaXhdbI1Bu56TetWvZjTknBZqJ+huS9xV4p
 wK5JMTVbK9kOVrxXGJnTVSq7sAFGnI5uxHB9+MU2FMZFUhZa7Sf88KvVbuqmdUjEXd8vGNOw0k4
 hPyXdTVeiQBhZxjMqKfZvivOn+QqY/DT7DcBu4Y5GIUm4vge45ua95+txjx/KJU7/3bxPFs6At6
 oQMW0UTJRpEF9yJRLAQ==
X-Proofpoint-ORIG-GUID: 2Z9lYNLKLo-ThGbQcft8DBVmZyfcmBs8
X-Proofpoint-GUID: 2Z9lYNLKLo-ThGbQcft8DBVmZyfcmBs8
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69ea1f16 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kpNcZxiqwdVgWfiEekEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134

The current clock and power domain enum names are too generic. Rename
them with a vcodec prefix to make the names more meaningful and to easily
accommodate vcodec1 enums for the secondary core for glymur platform.

No functional changes intended.

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

