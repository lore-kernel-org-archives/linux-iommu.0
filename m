Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81083376A10
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073028; cv=none; b=acrOiVagGyDDef1vXoG8lnbBUDH1grxE1rZTTi5s1qBE370Fapi2VDpGYCkZs7FEBKCAMmXD3dAIhhFR0CkqiVnTT1M3F8sD4t8mjb067LbMRMUji8wAx/gyL6bd55Q1fD1PCIBZzLFLUQw8cSu6o6j3jxuJB41cF3G2lM5UXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073028; c=relaxed/simple;
	bh=uXvxBqV29dnRWJEGEW3qlSEg81UU7hjiwTjaC3X/PPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+Ko+XeX2p1ma6hPMcFx0ABSoeiJ+3b+IyxBkSOOENYYxIGbhsa8NpI8oy9ca2Zm1zqmgbravTRCv5z1OWXwECBRICPxeBBpbcbLuVrprQKRuaeqFqOFuI41sjyaEyWykEkdwKf5tHK3jPs8f9Xf6rCSjJAFggXeUFORqRIOyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bn2ozLG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjCKOAmz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bn2ozLG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjCKOAmz"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2eq2n4061603
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=; b=bn2ozLG2Q0OZwFOS
	44BQQmAZoR/awXUtfuJvAFjE3ueINXC5wTUaWgQ7zsLhnBjVetZp1cjXe0PnGmmj
	BZnfGerdibrPKRfUvKrlzfGsqZhB9368UEIT7dOqDsbv2JW0GRYua9nu2iJEUB2K
	6wBZQkGgSnGaZjvVlHEUpRkugWmuOIwPrUNhMX1B5O+cD73b9BAbNpbi98CyrVRm
	Jbq2uWXyB9Da26vtDWV2PvyM6y5cItXVpu8Yv5qQuZjr2rjNYHZ3mcIuA5eP2P8a
	7QK0LO6neJHPghiSaoE6//VjUS5FqCJalWNEcmHrJX3LJ5VrT5DL2n+YgPnLEHZQ
	RNIPlg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnh135u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso4137162a12.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073023; x=1781677823; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=;
        b=UjCKOAmzXtobDYHXokazHpjQr3CvBi0Ne66orOHr+1u0NJjoHQin3SkIKpTmVxKYSF
         uSJRmI/HbhtMO1jrEIQ2rMBRe8knswsX0hKwDW+YYRYkqpovBn5vQGv72SCk9xIt7F9/
         UqH9xLo7lV3U21wEoPd3HpV1V4T+agb01sVluP65BtqppB3WG+yaiYF6bUmNF83rqXdZ
         bGVqF68PuEy4UH+stsffjxROiW3fxAyjE5T5TpRLcNjxHIO3Iii41jXSFbg/QfNLqkST
         JpH6lCqiOMLydbT5ThnCo/CY2LYQJOQbTn/4PiS9kg7MtOpqnXaJeOKtIy9cUi/8P85x
         tPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073023; x=1781677823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTAIALqBJRf66dVYSvKWnyN0r7BVNV/Albq1Zho5l84=;
        b=EyiV57I4CMjOnx1ctY1kJ4jwYwhq5MtoreCz5QffhY8QyxAjzyC0s6/QlPTj1PUx4r
         8E+7Kr3P2ISKIKr9b/Mbsd+QUdVjjYsBsv0tWbu/NcCdJ67BFcNlLwrE4gmV3P4ny++T
         GYHn1jogO11/jYrhcTBUPUpoogcYb2/mIIA52gAN33LBOr3oCTHWd3+9DYfHP2hp3N3a
         37oSUcN1Ox8iTTzE6ClRTAvc6xdwHCk0j1wDYgKYgFSfLhBF4Gffj8fwHLJtObb7Mdr7
         mIarZzkAh3hk2QZqpVA2FXmDR+hmFo5pOFhDSDRJiHfVyb/irYkxRPkSk3bK5ZRvDY8R
         Xb4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+aTCaTMrEG0aV47cBBOuyJrSzEVvl5kb+tzZ3N4QhuEiLgHcUSmzj+Oh8d3azOe91+SKLH5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMO3+Iw+VoLoIicj1k8pdbKMCyaOMXCMNa3Dfg5SfQhiFOR8LO
	YmlMFj3Wk9rHJlmYJcd8TkenUXPqKzeRLUSo7HRY100qWVmaq7nndvOZaZhYN6/Tg9k5VlQr8Mt
	OMQO9WQirg8AV7y7xBguTBEIqkurDWp9k8aCEvMIdGNyhKomD81YMIzt14A==
X-Gm-Gg: Acq92OH5GWcO3lRFuZ/AoQ7WBS8I7Zr9zjz7HLZ23ttP8I7eqqLOiWCDVn00G2tdXBs
	c22n3UJYa5BRi73l1SDHsEVrfLomB9FMCUdrAoKu/52vqDIMaJc0mBh3GhKwHeaB5Di4BJeeJx9
	AoRDmQOrFJwP/pzZ8li4WXpxSbl3OuXHYDcUUI3PRZwubFBgnKe2gRx0DfTcAyM23QuqkUei06R
	f/KZ3J/9ZIWtKjr4vZbTeSL4ykbH7eIENBga3UNk2YouUIbTRSm/G0f6eYKsitvdmo0tOyz8jgF
	EzvVsTSKqAHfMTZP1gPYCpAuqtL4uGoWlO9ia6UEYsEjv91Mtt/1jat4McCtk27AFV7A7MhUfUD
	dHKYcDgjjhH3mB2TkebaifAOC1MpIxpAK2NsQK8AePxkmWasjuRT8DlCpa8st+yzbjw==
X-Received: by 2002:a17:90b:390e:b0:368:1064:62f7 with SMTP id 98e67ed59e1d1-370ee33cfabmr25153425a91.6.1781073022543;
        Tue, 09 Jun 2026 23:30:22 -0700 (PDT)
X-Received: by 2002:a17:90b:390e:b0:368:1064:62f7 with SMTP id 98e67ed59e1d1-370ee33cfabmr25153401a91.6.1781073022095;
        Tue, 09 Jun 2026 23:30:22 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:21 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:38 +0530
Subject: [PATCH v8 02/12] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-2-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=1090;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=dJOak676jq9xOdkTjWpAc2d8f8wOtUNP7aR0VoiKGvo=;
 b=S9EKZEnlUVudfAeNMawwOgx3xZjxEe4Uly9qIotiCiFYLgCm2Xd0BitDRJblxarJ/scgDi4/b
 kltOGKh//x7B2Wl7ZpC/saFu4AKaXr0cCGtMJwTbOZRxNu8agdyHKIG
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX5oIXzEzYpX0p
 E4KqfymBNHpNDSOz8M3oxNQn2VcgvJ6Gm1PHvM2zxX+agrOHNZGB/kzgIeebiZeqabpTVLQRF7J
 R0lr7vCp1P3xnJwOy2ElJZ9PfUl+yrUbcmDe1t9ywCVY3bl9b7jVMi5g9gdJI2iJ26/KFsjBqfN
 pT47I0sPhzDZoI3m7iJh+Cq9pcTQNu0inGn7QmmowBsGRPhnu3q3s3A2KuuAe+6qgJpCVPT9uSy
 zNftiq9zMkr2m5MxqEPeLUxf7RhaSiCjMUIomnTOFV/myRT+KjQJQvEXBvnSMfBGkK+aAC0xz5g
 3OXMtySaI7szD7JOYO16lxBzPcn3U5IEe1euvBdpdZifUyOa0z8WTMLI6CuqNBAIGfvZdWtIh+G
 EA1/Hjt2V5EMmWMJR7EPluIaDti+hDKIYD1PT+cAirLXDLOQ9LYJryVy0z/4gXQmgiEFvM7h4bJ
 RTtJJXe/HC19IjP+Pkw==
X-Authority-Analysis: v=2.4 cv=Xce5Co55 c=1 sm=1 tr=0 ts=6a29047f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZGoT60Gb6PEvP4nDRaMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: MJgRkUHCNsqXxXlc0Jq0K-63GKptGHeP
X-Proofpoint-GUID: MJgRkUHCNsqXxXlc0Jq0K-63GKptGHeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

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

