Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7B480343
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844262; cv=none; b=o0dGpsDsXEkPigShflIdZCp2cJ73cvusJz5Q6l2mUJUFRH9oNNqI+fv/SGQVIGLNyMUNIPVAhLJF4FyUPlexDLTqNpdcjYtfsWY1JxRRbnlOq5PBwNie+qj+gdlMdPwhR+x0MvKFfUbL3+zlxTt4oqIjPiDqTTBqezJHXFtZn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844262; c=relaxed/simple;
	bh=aTQbaEHitwodG8/WnIVNbJ4TgWhVw1hWuHNb2TIgYl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmK5tOqx1lJrOumYm4MaTSapfylSgKyW/F5buvRZ5CZbnZNpp2LdqFM+3g5DWPXhmkfZqPCXtnlaxHzWbStJqQc4jaPsHYATO9zR9nUtxe6cuIZ2qK1kM8v4ExaQsajxLRdtfaGDPddLNBHx4dNmfrA88dL2gFhYxzvp2mq9ZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfS9zuvX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLZ+NVob; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfS9zuvX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLZ+NVob"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5V0BM3670428
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ympg+n10l1TuEZfcmMymVIoujDY3jyMoN+lzl2X8Rg=; b=OfS9zuvXLZOSAcCS
	0fKiZ2/7agEcVWtQBRRq0k4CLkUbqN4ajwlVU/Yc/3jISFbqC4cwxM06R7oVpFuX
	0SbxqT7aF1g81QkZWi3agBA90Euahfc4z9a6wkgWlwk/1ZG2jLGYRj9ozk/b92r7
	V1tZuXZoaDnq9V0f6ICkJ1aWZNCcobh397tJke9UYBwrRm+QRQRp5MuygNNazatO
	kNbN/jQEoNn6k+HQHM6zw3XumE88ZsOZ3IV3phgK5gKptW8f3GyliYfV96kNDwLc
	wKcCfoIPCaRUbFAbebmr7iaZFPNL2Ro7w3+6KPh4jR/zB2Sn9etkzteOffxR43AQ
	86edFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3355-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-368b68a33adso5884999a91.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844258; x=1779449058; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ympg+n10l1TuEZfcmMymVIoujDY3jyMoN+lzl2X8Rg=;
        b=NLZ+NVobgWo/ZqVck3FRiao9AK1usn/6yVhgeJzZDytapVEw44WMp1OczZOjFnjS+L
         QalJw67yunPtqzIN3F/bqqx/dcP3kENESUMGjWtt9Yhp4WXSTEBDByiOq0vVlh+LjzDS
         pavxHy4S09MM+3RoMkSl6HktiikEPty/DrRFBKH6LRKnFzctkE/ih25KtMC52dKkal3E
         W3b7GJe0gK/ZZ1DjEqU5WWNgAqH8hg6eujlZDsIZTRQXkVrUAKuwBs5YeT89m9FeeslL
         c1hiGdIAFDy46tuKvuCjbLbBurwnFpLkJZZpMKU1h2gMAGZ6zOqhmN73m8UONOJLzRUl
         w1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844258; x=1779449058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ympg+n10l1TuEZfcmMymVIoujDY3jyMoN+lzl2X8Rg=;
        b=Nd+edaxs892vmAuAqrqB1AQTo9kc3O8HKTxqFvvcSRc8Jxe/Mwzon4pG/8nTTAsqKe
         W5dac2JxiuUMcRTjQn/qWu0h7H113DF11BSlKAB1DF2J6i8Tw12JnfHDRpjbzWqyhVJB
         vMEAyTa+keDqopUpPfJdb+cawwfSTcS67K4ybiGgVNNL2L7jc5BzG9W6tPoBZmego1tp
         QoQrJqSxJLiJiik8nvqkdIpaNaDitnloY93ddYxK8HC0nxn0JO+90dre0G4MckI/ua7i
         CkEEL9h7lxmjKh3hcRrC/jG34YFHQfCPHXnHACX3k6+fqBmvi85WrnoF3Kg12EsYPFXN
         RORQ==
X-Forwarded-Encrypted: i=1; AFNElJ82TyfrVIjBfADkA7826ua9vfEw1ONhPEnt8MoFpERwUF/4ahQxwFo88nLaAM2EeUhHDCtwkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4asuoceQvHkBm50kbTkY7h183MZXZht63SKovawkgH4m2vQwn
	a99iMF6DWPFVKOCV7CO9SKhfPezUEZNWa5dShF6kHZyhnqh7OIk8Gahc8e2ZGh9J/0izNcfWBH5
	WC6J2fF17F77wO1PW+kDMoPcCP2HkkMNQFQK9t55edFc/CNKu3gfP6/fnXA==
X-Gm-Gg: Acq92OHuPZSEBltGSUIpBiIJJJLyKMM48bkuQqss7K964Q7TYCjTF+JLag8zNr/tyet
	Kr5CKB0RLdMbTNJZTTW70z8TxG4UMAZe9XCZoeygF9jb7mM2hW89oss+16iuIRwFMBmdPJExH8i
	Ds2fi3bxnk1Gf2x7d+MHkIeEP5XL3g0EjOzua0f5I2UNz94Axzxu6WhDtiENHOvnMXe+/l6Qja4
	GNI5aT+8FWqfnLVGvShl/GVrtiBXsZgkaNqz1FQ5inkioa32/xzcEhmdtvNUfLpB5Q5rs5/aOM5
	q71/IWCqv6tZFgpNlyA0FUK5gbeSNAcvQYAaYOMJLDHXKjxbzS0TD5vefLeC/B5KN9xWNahVKq+
	dhbUNr3ViUUrsXsXqLGWF5t271S/nUxDCyZbGU3Z2kKYxQpMf7Qd1xqY=
X-Received: by 2002:a17:90b:4c51:b0:368:2074:b7a with SMTP id 98e67ed59e1d1-369519af671mr3598027a91.5.1778844258028;
        Fri, 15 May 2026 04:24:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4c51:b0:368:2074:b7a with SMTP id 98e67ed59e1d1-369519af671mr3597981a91.5.1778844257438;
        Fri, 15 May 2026 04:24:17 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:24:17 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:23 +0530
Subject: [PATCH v6 08/14] media: iris: Rename clock and power domain macros
 to use vcodec suffix
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-8-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=21442;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=aTQbaEHitwodG8/WnIVNbJ4TgWhVw1hWuHNb2TIgYl0=;
 b=Z2Od8MA5MXklHXediksxBpxs+ncWMuTtPDbwucTZ+0AceK5jj0QUgMl8z3lANBHIw0uuWFpxn
 mnWOmYp9IMTBt1gV6rj1EMt23FMcXGbF5hKRgFTYEWY/UGEGqJ24m/o
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfXyhE5t4LMMooq
 NoeXcv6wi0Rxycg6z41KR0RJ7VQOdgz5tjMVkGFVsySr/wIvixAogZDYRGcWjFtEtivolUPURSU
 XZXEGFPyJ3Tr6c17dCLhrB8ys2tkzeORJXqUVt8146KZcbUT+JhSy7LcwhWkH3ciislLaijFNxA
 A4DzcYi+eIlsdpW6ETOUqoZVtz8oAOBAdHKfd8LH9WoPWeVeN407bOzOkMpAthc3LdGNKNzV3AJ
 FtP158Iv2HK5iRAz4gTws2mg+G7tQLn2kub4KCWmpJjOfbnWhpAfwaVVHMziHJ+9ieJ9EqVio4m
 4fJ6LJNUPqelF62io/TRS7t4T92ZT+STbhz2QLgcOljErQ9RXExIzl1fqW02B8T+3eCXqd7/tXF
 4AW4cyoTmJhyeusfRGosv1nqGCV14JFbqMMG5UFamPlOeGc0H6MHOEsSQNvDcz43WMWamMI6srz
 BcFXxl4ofrE0vlPmuqw==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a070262 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hIW5SXrrtB23OXZlDtoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 1YdLm9hxTGo8DpSbUuSVm9NqxD2tzH4H
X-Proofpoint-ORIG-GUID: 1YdLm9hxTGo8DpSbUuSVm9NqxD2tzH4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150115

The current clock and power domain enum names are too generic. Rename
them with a vcodec prefix to make the names more meaningful.

Glymur platform has three AXI clocks: axi_vcodec0, axi_ctrl, and
axi_vcodec1. Positional names like AXI0, AXI1, AXI2 do not tell what each
clock is for. Descriptive names like AXI_VCODEC_CLK and AXI_CTRL_CLK make
the purpose clear and also make it easy to add secondary core (vcodec1)
enums for the glymur platform.

No functional changes.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      | 22 +++---
 .../platform/qcom/iris/iris_platform_sc7280.h      | 10 +--
 .../platform/qcom/iris/iris_platform_sm8250.h      |  6 +-
 .../platform/qcom/iris/iris_platform_sm8550.h      |  6 +-
 .../platform/qcom/iris/iris_platform_sm8750.h      | 12 +--
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 25 +++---
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 90 +++++++++++-----------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 45 +++++------
 8 files changed, 110 insertions(+), 106 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 84fc68128c70..07cc0ce25b84 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -51,17 +51,17 @@ extern const struct iris_platform_data sm8650_data;
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
-	IRIS_BSE_HW_CLK,
-	IRIS_VPP0_HW_CLK,
-	IRIS_VPP1_HW_CLK,
+	IRIS_VCODEC_FREERUN_CLK,
+	IRIS_VCODEC_BSE_CLK,
+	IRIS_VCODEC_VPP0_CLK,
+	IRIS_VCODEC_VPP1_CLK,
 	IRIS_APV_HW_CLK,
 };
 
@@ -198,9 +198,9 @@ struct icc_vote_data {
 
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
-	IRIS_HW_POWER_DOMAIN,
-	IRIS_VPP0_HW_POWER_DOMAIN,
-	IRIS_VPP1_HW_POWER_DOMAIN,
+	IRIS_VCODEC_POWER_DOMAIN,
+	IRIS_VCODEC_VPP0_POWER_DOMAIN,
+	IRIS_VCODEC_VPP1_POWER_DOMAIN,
 	IRIS_APV_HW_POWER_DOMAIN,
 };
 
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
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.h b/drivers/media/platform/qcom/iris/iris_platform_sm8250.h
index 50306043eb8e..964e1cd92086 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.h
@@ -16,9 +16,9 @@ static const struct bw_info sm8250_bw_table_dec[] = {
 static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
 
 static const struct platform_clk_data sm8250_clk_table[] = {
-	{IRIS_AXI_CLK,  "iface"        },
-	{IRIS_CTRL_CLK, "core"         },
-	{IRIS_HW_CLK,   "vcodec0_core" },
+	{IRIS_AXI_VCODEC_CLK,	"iface"		},
+	{IRIS_CTRL_CLK,		"core"		},
+	{IRIS_VCODEC_CLK,	"vcodec0_core"	},
 };
 
 static const char * const sm8250_opp_clk_table[] = {
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8550.h b/drivers/media/platform/qcom/iris/iris_platform_sm8550.h
index a9d9709c2e35..3b3f17b18707 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8550.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8550.h
@@ -9,9 +9,9 @@
 static const char * const sm8550_clk_reset_table[] = { "bus" };
 
 static const struct platform_clk_data sm8550_clk_table[] = {
-	{IRIS_AXI_CLK,  "iface"        },
-	{IRIS_CTRL_CLK, "core"         },
-	{IRIS_HW_CLK,   "vcodec0_core" },
+	{IRIS_AXI_VCODEC_CLK,	"iface"		},
+	{IRIS_CTRL_CLK,		"core"		},
+	{IRIS_VCODEC_CLK,	"vcodec0_core"	},
 };
 
 static struct platform_inst_caps platform_inst_cap_sm8550 = {
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
index 3dad47be78b5..c1355ff74a64 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -209,7 +209,7 @@ static int iris_vpu33_power_off_controller(struct iris_core *core)
 
 disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 
 	return 0;
 }
@@ -218,30 +218,31 @@ static int iris_vpu35_power_on_hw(struct iris_core *core)
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
-		goto err_disable_axi_clk;
+		goto err_disable_axi_vcodec_clk;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_CLK);
 	if (ret)
 		goto err_disable_hw_free_clk;
 
 	return 0;
 
 err_disable_hw_free_clk:
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-err_disable_axi_clk:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+err_disable_axi_vcodec_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 err_disable_power:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
@@ -250,8 +251,8 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 {
 	iris_vpu33_power_off_hardware(core);
 
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
 const struct vpu_ops iris_vpu3_ops = {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
index 02e100a4045f..5abd19a3d2f8 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -27,20 +27,21 @@ static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode, u32
 {
 	int ret;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], hw_mode);
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN],
+				      hw_mode);
 	if (ret)
 		return ret;
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
 		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
-					      [IRIS_VPP0_HW_POWER_DOMAIN], hw_mode);
+					      [IRIS_VCODEC_VPP0_POWER_DOMAIN], hw_mode);
 		if (ret)
 			goto restore_hw_domain_mode;
 	}
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
 		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
-					      [IRIS_VPP1_HW_POWER_DOMAIN], hw_mode);
+					      [IRIS_VCODEC_VPP1_POWER_DOMAIN], hw_mode);
 		if (ret)
 			goto restore_vpp0_domain_mode;
 	}
@@ -56,14 +57,14 @@ static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode, u32
 
 restore_vpp1_domain_mode:
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
-		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP1_HW_POWER_DOMAIN],
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_VPP1_POWER_DOMAIN],
 					!hw_mode);
 restore_vpp0_domain_mode:
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
-		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP0_HW_POWER_DOMAIN],
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_VPP0_POWER_DOMAIN],
 					!hw_mode);
 restore_hw_domain_mode:
-	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], !hw_mode);
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], !hw_mode);
 
 	return ret;
 }
@@ -162,47 +163,47 @@ static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core, u32 efuse_v
 {
 	int ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC_CLK);
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_FREERUN_CLK);
 	if (ret)
-		goto disable_axi_clock;
+		goto disable_axi_vcodec_clock;
 
-	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_CLK);
 	if (ret)
-		goto disable_hw_free_run_clock;
+		goto disable_vcodec_free_run_clock;
 
-	ret = iris_prepare_enable_clock(core, IRIS_BSE_HW_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC_BSE_CLK);
 	if (ret)
-		goto disable_hw_clock;
+		goto disable_vcodec_clock;
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
-		ret = iris_prepare_enable_clock(core, IRIS_VPP0_HW_CLK);
+		ret = iris_prepare_enable_clock(core, IRIS_VCODEC_VPP0_CLK);
 		if (ret)
-			goto disable_bse_hw_clock;
+			goto disable_vcodec_bse_clock;
 	}
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
-		ret = iris_prepare_enable_clock(core, IRIS_VPP1_HW_CLK);
+		ret = iris_prepare_enable_clock(core, IRIS_VCODEC_VPP1_CLK);
 		if (ret)
-			goto disable_vpp0_hw_clock;
+			goto disable_vcodec_vpp0_clock;
 	}
 
 	return 0;
 
-disable_vpp0_hw_clock:
+disable_vcodec_vpp0_clock:
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
-		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
-disable_bse_hw_clock:
-	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
-disable_hw_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
-disable_hw_free_run_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-disable_axi_clock:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+		iris_disable_unprepare_clock(core, IRIS_VCODEC_VPP0_CLK);
+disable_vcodec_bse_clock:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_BSE_CLK);
+disable_vcodec_clock:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
+disable_vcodec_free_run_clock:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+disable_axi_vcodec_clock:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 
 	return ret;
 }
@@ -210,15 +211,15 @@ static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core, u32 efuse_v
 static void iris_vpu4x_disable_hardware_clocks(struct iris_core *core, u32 efuse_value)
 {
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
-		iris_disable_unprepare_clock(core, IRIS_VPP1_HW_CLK);
+		iris_disable_unprepare_clock(core, IRIS_VCODEC_VPP1_CLK);
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
-		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
+		iris_disable_unprepare_clock(core, IRIS_VCODEC_VPP0_CLK);
 
-	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
-	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_BSE_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
 static int iris_vpu4x_power_on_hardware(struct iris_core *core)
@@ -226,20 +227,21 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
 	int ret;
 
-	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 	if (ret)
 		return ret;
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
 		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
-						[IRIS_VPP0_HW_POWER_DOMAIN]);
+						[IRIS_VCODEC_VPP0_POWER_DOMAIN]);
 		if (ret)
-			goto disable_hw_power_domain;
+			goto disable_vcodec_power_domain;
 	}
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
 		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
-						[IRIS_VPP1_HW_POWER_DOMAIN]);
+						[IRIS_VCODEC_VPP1_POWER_DOMAIN]);
 		if (ret)
 			goto disable_vpp0_power_domain;
 	}
@@ -261,13 +263,13 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 disable_vpp1_power_domain:
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
-						[IRIS_VPP1_HW_POWER_DOMAIN]);
+						[IRIS_VCODEC_VPP1_POWER_DOMAIN]);
 disable_vpp0_power_domain:
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
-						[IRIS_VPP0_HW_POWER_DOMAIN]);
-disable_hw_power_domain:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+						[IRIS_VCODEC_VPP0_POWER_DOMAIN]);
+disable_vcodec_power_domain:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
@@ -339,13 +341,13 @@ static void iris_vpu4x_power_off_hardware(struct iris_core *core)
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
-					   [IRIS_VPP1_HW_POWER_DOMAIN]);
+					   [IRIS_VCODEC_VPP1_POWER_DOMAIN]);
 
 	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
 		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
-					   [IRIS_VPP0_HW_POWER_DOMAIN]);
+					   [IRIS_VCODEC_VPP0_POWER_DOMAIN]);
 
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 }
 
 static int iris_vpu4x_set_hwmode(struct iris_core *core)
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index df76530be809..8b06bd346b83 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -212,7 +212,7 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 disable_power:
 	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
 	return 0;
@@ -220,10 +220,10 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 
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
@@ -250,13 +250,13 @@ int iris_vpu_power_on_controller(struct iris_core *core)
 	if (ret)
 		goto err_disable_power;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC_CLK);
 	if (ret)
 		goto err_disable_power;
 
 	ret = iris_prepare_enable_clock(core, IRIS_CTRL_CLK);
 	if (ret)
-		goto err_disable_axi_clock;
+		goto err_disable_axi_vcodec_clock;
 
 	ret = iris_prepare_enable_clock(core, IRIS_AHB_CLK);
 	if (ret && ret != -ENOENT)
@@ -266,8 +266,8 @@ int iris_vpu_power_on_controller(struct iris_core *core)
 
 err_disable_ctrl_clock:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
-err_disable_axi_clock:
-	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+err_disable_axi_vcodec_clock:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 err_disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
@@ -278,31 +278,32 @@ int iris_vpu_power_on_hw(struct iris_core *core)
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
-		goto err_disable_hw_clock;
+		goto err_disable_vcodec_clock;
 
 	return 0;
 
-err_disable_hw_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+err_disable_vcodec_clock:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC_CLK);
 err_disable_power:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN]);
 
 	return ret;
 }
 
 int iris_vpu_set_hwmode(struct iris_core *core)
 {
-	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
+	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC_POWER_DOMAIN], true);
 }
 
 int iris_vpu_switch_to_hwmode(struct iris_core *core)
@@ -365,7 +366,7 @@ int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
 disable_power:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
 	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CTRL_CLK);
 
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 
@@ -382,13 +383,13 @@ int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core)
 	if (ret)
 		return ret;
 
-	ret = iris_prepare_enable_clock(core, IRIS_AXI1_CLK);
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_CTRL_CLK);
 	if (ret)
 		goto err_disable_power;
 
 	ret = iris_prepare_enable_clock(core, IRIS_CTRL_FREERUN_CLK);
 	if (ret)
-		goto err_disable_axi1_clk;
+		goto err_disable_axi_ctrl_clk;
 
 	ret = iris_prepare_enable_clock(core, IRIS_CTRL_CLK);
 	if (ret)
@@ -398,8 +399,8 @@ int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core)
 
 err_disable_ctrl_free_clk:
 	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
-err_disable_axi1_clk:
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+err_disable_axi_ctrl_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI_CTRL_CLK);
 err_disable_power:
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 

-- 
2.34.1

