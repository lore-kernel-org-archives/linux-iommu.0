Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68739A045
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496433; cv=none; b=i2C8io4p1NoxeC2LiM4fQ4HnDLjWGOm0LAT6vjverTfrcQ4C7pyRhyYNdp3n/R/D9RznU7B9Rcg5+kdBDbMlnofETPOHKkfkQq8Aqwvy56yznS8DZdE1UN4rE/mG57e22R/x8s0Nhh6CIqOu1QVmUrme3NMpPIv7XDkmS4OBHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496433; c=relaxed/simple;
	bh=uXvxBqV29dnRWJEGEW3qlSEg81UU7hjiwTjaC3X/PPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hn3nnosMbAjCxLjzDlufR/KDseaHb3Y7uQNcxWGyaFAkaQpTbn8jsv50kbsNzrKHGLwCyqaFLblVywuVt7/qM9QgM295nNDdZ4u6r+Z7DAWZsrtQHuMsZyk08+lcvek4CyPIqEd22KE7qBXhtkE3t7w1ueLFK6EuxuHjJCerKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3P9REkT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZpxa8Sn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3P9REkT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZpxa8Sn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CJ9Ow1200538
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=; b=k3P9REkT5TdTSfQN
	7IrHvxQQcMaCfNnB7NUoR/bkVk1X48zsAZM0olykjHIT6CwBk4+ORQvcAxCIS0Ht
	pUTSnOgz9T0NcHot/icmMPceiDQ1UjNqPFAU7G17jERzze556d46h0giaEvvPZFe
	9z7GrQP5uE3jZfLI83Rbe6Yf8oScWxKTOQRIsmGwRvc4I6Av8BfWr4t1Kz1DZEqr
	JxRg2jWYR+N//RC3tUny3tzT1EqSORm9OQFYXZx1/EHfTFPBepyla5uBZpqVDprl
	zn1+uVgsJDMPJv5GtfEUKEAfmbayAethRw5aDBoQ1Qcqe0H8LepfgAQLZKvZ331C
	n94OVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw2dsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:20:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf160f7191so31767205ad.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496430; x=1781101230; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=;
        b=eZpxa8SnsL5TSsPx29Hx+cMx4qkcI/CELPctd3njDBKr5iXNpD4X1ziuZ8w13Yexv9
         8AjlTy1upxdfDsulf7Xtasz1ihNZdvPUSwxpx+pBdinza0m88t6/ifjyncx83JhiuQ+2
         roPH8PUaiiNI1DxJZIPwUxzwHN7awbq75mAnWTDLndlY5pasjN72TRuOE2n4EkNQi6QM
         KhemNXmOVueCxNVOxkiM0mnK+2D54kX8I4jcmzh9wnlUcIfCbndrZCptPxiVd4U39XY/
         AT+0okK4H8oz1Wgg4RVCtUEfDdfeVukQR5eTh4Jc240nG5g8U1jt6k2Fl26TbM3kLji/
         z58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496430; x=1781101230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=;
        b=X47Ajb5DO+7qJBeAVKJtHtbXI6G3Cie4+/oTfluRmbEJkogmgE7cHm5E90MVyS58uY
         mglv9jM5DF6HG7MrjfB96j5hW5wF0LgDmFQUO2rLNa8JP5lmW/38Y+6V6hAc7/zmJvpt
         UX89H8+89GDb1jaOhSu4tCdlaCTr1NTs4gWexnGjS85gmeJJ4CtaNaTL9dMzpv7d54/t
         X2rDflBPsZid0ff5pLiimq+0ITttCh7B1JNJlNveavTsUwQ68hfNntgcUgb6jb28/jrO
         /fGKzMdjqvjJgmdpX/M7fUwusE+A3rzTBH7CGJFtvS2nYmsUJp53Uk8r3h+gpwbbUWlq
         zz7g==
X-Forwarded-Encrypted: i=1; AFNElJ8ugaJAx7PpNfmyF3L8fCYL3Oms+gGKrfDvsil0GHlo8kj7yu8O666qDxnIY+GUBejoh31hiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyttXxu5VWtP17quT4LgG7IYuvmSdbVGvluNUK3HjfnoLz0fq/B
	FMMM8cpZQRCwq31DiXpwrS5M9bF/r41lR1YhWdlgEX/31RgsI/Y8j54LphwfVI5HUiECxpnRcGK
	RQrDbBSluUQrfwNVtTwO53Af4i/+yLmXiRiEXblFcf1y6xeAtHNAvTLCiNA==
X-Gm-Gg: Acq92OFFxy67ukwWwCG0DfUd0cDsQKUZIzT7vxU6vGCHCiOybGI4AOyGhpwNIIlpgD2
	46kwIS9fivito33QHUVRJEUBw7HNKu8wUfskTs4tQtKM8PQ2zHJ0r+P2IhFwSo7WNWcORerwSVp
	LkWU+qh8Kt0HK9GN+68NTMlrZT8f6LiE+mfkSb4zEfYY5A9554n6u2MqOFWx8jQwkX7BtonbnTL
	tzuJS0OEQaoCGY0X0wd4GTkQ1vspWEKQ0BCKUHEI/8+sOXtrczwClRZ7xpGZRJ3CeOgXx9/Qy1P
	H/HOgd1kvgUFVxCW66eOT2opAvZaGGug/GRGegXI+IvcejFgCtd8EO+/SQKSsF9U8pGGyqdAv5F
	tuwsQ4D4lCH6ZqgNVfVguCiih/4cO2IsVz7lT2USlw9DS0aknA+7V5w31Z0Uei4EpKA==
X-Received: by 2002:a17:903:2904:b0:2bc:db02:d1e6 with SMTP id d9443c01a7336-2c1644aae27mr26600585ad.38.1780496430443;
        Wed, 03 Jun 2026 07:20:30 -0700 (PDT)
X-Received: by 2002:a17:903:2904:b0:2bc:db02:d1e6 with SMTP id d9443c01a7336-2c1644aae27mr26600175ad.38.1780496429889;
        Wed, 03 Jun 2026 07:20:29 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:20:29 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:40 +0530
Subject: [PATCH v7 02/12] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-2-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=1090;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=dJOak676jq9xOdkTjWpAc2d8f8wOtUNP7aR0VoiKGvo=;
 b=WOak3EvlYvqbKF6T2lN6EhIkDnf/uHBTEyz38sitDdIOdCEAnsIybqDkj/uRlostDJJ78PqAj
 ADfcNs1g7JZD7SmFqCWV6+7FZcaiKw4i0T0Q8XsPrE2PHfTqssaBHjL
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: AukI3LA63PcRykETVdPpKhFthH-ycMSa
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a20382f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ZGoT60Gb6PEvP4nDRaMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfX2XdW3Jtx8EU3
 FNTRj/rs8855Ve4xOYauGss8+buYBG+O4LH/TV1F/W0XCHZmN2+ELbDYsYHzcnuWjrJT7XemXKE
 js2dIgdfKSLexBArr7014TevnTNLn5ZMSx8QIDNTghwWmrCUZSqWW/oQjzwqCwjv3vuYUmVGjqM
 6d5KC6unUHvkjtXuzRnZ2pW+SRUeBq5Tb0yEx+2PIfsZRJzcB/9SztfbZzmxYYEXPcGt+A9C6kL
 gI2rjVoHrEL71ZkLUM6AWyJR8ydm9stK60W8HvRZx5rCEsGVxVixbjyRjQ07bPUaOSqVPnT7u2c
 TlF5FovSxORt5CSDF6DTZDH6GDePuf2dZClKH1Pue6MoWYqeTo2eUHG2mUKzC0FWlttQJdgcpGf
 WAyovzI4vW0Scsc7Al02KO8P3mw6w+vdFRdLYsVGlG3FkEQS9rwZo86to8V9lQ7S0hJ1JTatHdt
 cER6QDmj1BSAnTJuXhA==
X-Proofpoint-GUID: AukI3LA63PcRykETVdPpKhFthH-ycMSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add iris_vpu_bus_type to the iommu_buses array in the core IOMMU
subsystem so that the bus notifier callbacks are registered for
device addition and removal events.

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..fe51600953ce 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -200,6 +201,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_QCOM_IRIS_VPU_BUS
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

