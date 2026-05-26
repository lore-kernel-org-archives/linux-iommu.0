Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2E3FFAA6
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806558; cv=none; b=p0CkVx9cypL5RcBu7lHOeDtgzfu8ybcMe+vKQZjyqTeYbxyq56XsJCtm1YglK2vhtBI68vmetpamhgcN7zJYFC3f/mkVornjJSgYC6jmGcmO/xp+Pp3giL+VK1FDdGO+24GDJLazSAXUESiQfEBNwIivlG5ouULa/NTnbSPISco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806558; c=relaxed/simple;
	bh=lWkUuj08lvraeSSyxOex2Hdt1a0/ULuWaFXQJiE4zls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AW0VX6T+VU7aOQo4MNej+AZhorCW6LzDTFN9IlipBSkxszUZZ9qKQfGI1ohT3Reaq7Em5VWxQUM5hzrGhGQm95by460nlf7iVCFtxW9SEFDUrUcChMpnN1eZuKZg+1794w9l5zUk1S5663LrurEdXzer2g4x59iC0m03Y8GYVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=id8xhIpr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bUCGT4/U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="id8xhIpr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bUCGT4/U"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsYD41430547
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJ/lc59p7BwOjZy3Mym2EBtQ9PV9HmJ7odtYIVkNmW0=; b=id8xhIpr0lPQukpV
	WJswVOwAOr5F9LTpVLcbIs0I/1dzkuDWfSlWtyO4/Qdk6kuqsfe0KTji01h6fRpX
	aE0Up+qe1i943O7cQUG3TOE1hegqhm+dUtdJxz9x4mkr5t2z2he8DkYMOgOJ4E4d
	TPpcbPfd6FYs66V4tgZEHUmefs3BbVZVVX5J+gapLPVCeR8DmX5MssCXuWlOSPF5
	G0kG5taBkXVUvbcuX8PryRckr3rqp2VzOnSNJ4X4i2DhaVRNERJJk1zpiQB+6mss
	MeKeuRaz36WEpm4qawT6ZMaqiuVf+eZsKp0/RQ4pyLWbEyop1TKDvsvVQrdUsv/I
	GFhkXw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv5jbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f9429f49cso14846835b3a.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806554; x=1780411354; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJ/lc59p7BwOjZy3Mym2EBtQ9PV9HmJ7odtYIVkNmW0=;
        b=bUCGT4/U1XHfJxJcA8nMqgKAl+8bgqdbIVrW2UInsMh7nzG97qCkc5QFtfS/stvO37
         QbXuMDk1AqGP4t6DPZvvqifJ9z1Mq0saQNO8dF46lBG///T6z44n07wWBq4hFVuI0Nut
         E6cQieq9bbeO6MZM4SwWCqtAm7XMnp+TnwNqMoLwYgnMaiNN1/GZnWdJDuinFExo/EQC
         tNlSl2HufSPgzdN6mHd5/o5qyKi1fs+sYkOtpZ5A+HjBQwuIQGtRsMQl9mhqgLv/cwkP
         OI70+Le8oQWFBG7E6A9G8TNxpN7Hzq6BA3I5NHG8euP6p8RMlqHMUa5K/kqYK5z4EujX
         DUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806554; x=1780411354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJ/lc59p7BwOjZy3Mym2EBtQ9PV9HmJ7odtYIVkNmW0=;
        b=RcTZ7xKSstdegwAE23eRlFiPc7lwbmHb2iI2AU/qpbHtfVrLF/xuqX9Kk3Utyqbt6j
         P6TIdsym9CQQJi7RFuZntqb1NG2uv4U8qBq5TBNNPPXFctXg9Xs40dfRLVecWL70m0wd
         uSp0h6RGlqlp8IH8qm92vlYGxZL2QRSLv3m9L12oAsDM2ypau2SyPsXus0Yjx5PIeD2n
         xUSGwKwibZbQXsArOSqVLYc9gnvnXnkr6nxRan5e9OpxQmZahqhSm2glqRJr9wFx1eHf
         duieS6IYWVmsJ0XohmXrwjY1zSDVqQ7A666Q2lb6WZmXiF+gAbKij5Qyp7PZ/JEsf4Jw
         ZYuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DLiAOZMYJhsA1qplgodiVDqr4lGBsharpqHWn+j3IOAvKuDN0khirH9G8Da1zV9IpRpeCLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRpsI9iU++WZ2G2k3VCugrPcvzswVsv5sUge47LERNtka9xw61
	XA097RsvN8RReCIRHW81omkxSy/Xy3MPvrWyew4XXS7iUYeehJLLoNdDyZmfnnXBdODs39mlw45
	WU3Ko66VxwYDX2NlSKXlu/x3RP+ZoYZqiechqN03zks//2h2RAhPa7rPhAg==
X-Gm-Gg: Acq92OH+6JiPLUEZCdjtFlVeXSWIxM1V2rHkWBvu4I4Lq4zN5TOdMM+lWvXOu8iqzFq
	rQe/TOjwqcYmzyTbdA0Z7mMPRUCYfJXTNoExVQipZuQmESshs4X6AD+hicWZSLUxuj4+X52Eu2g
	0plYiYxUWf135D1uiTayw4tLMyD8r5Bz7KbZPzcv0DrikKIUc51SjQ1RbeKFq6Ft2VQt/vZ4K5s
	zBC8GltYcBcKKcxETs4nl8YGAUeUY2OPuAx6W+9dK2WQX8QLeUVjMAixCRJLI9Fa9O7dihEZ1oZ
	rSppZIXqnTeP4fj1eKfWDx1HqcT1ykH6sN9coPlfKEXI91YOlZqln8Xv3v+fkG3l7xZIzzcGkAt
	RQ952Nli1ZMDEBSV80++xUt+dfv8goJvB2Yo3FRqFJPoYUjpkAHmD
X-Received: by 2002:a05:6a00:138b:b0:83f:9c6:9c with SMTP id d2e1a72fcca58-8415f11f645mr19443823b3a.10.1779806554407;
        Tue, 26 May 2026 07:42:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:138b:b0:83f:9c6:9c with SMTP id d2e1a72fcca58-8415f11f645mr19443777b3a.10.1779806553947;
        Tue, 26 May 2026 07:42:33 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:33 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:12:06 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: monaco: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-smmu_interconnect_addition-v2-5-2a6d8ca30d63@oss.qualcomm.com>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
In-Reply-To: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806527; l=1074;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=lWkUuj08lvraeSSyxOex2Hdt1a0/ULuWaFXQJiE4zls=;
 b=mIdUsT0ginPBt0NEy5rr52A+F4ILAPui5UJEns91Xrujoak/KyGU2jmd3zW303drZHEnRi6ae
 ReKZYHSyJHRBGAYXCc6RUDVjmkYlFt0lVyd7y87izB/po3f0Nt9KRjj
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNiBTYWx0ZWRfX47dA9Q6m5qxs
 ok0+7I1WgIKwSozJ2skBQjovmsKEKQMHJdS3a6E4cEzcONr8uNkWyraQOQjWXo0ywctm8eNyZeA
 kMpBhQMupf7ZvThAt+gF8KUGUXpoTWNOspwO809z0a3IwrXGRHeYl64Qek0473z2UvCD8qUGWrr
 IW/+zAD4eomoUC/nlcLtv9J33OC1yG/jfy06mhi3w3K6gcKN1W7DQQj84pja5i6XeXuG5uAFEzd
 yo/S+Aya0zuWYetJojJ4E5Oa4m2wEQEG0EFcdKj7kLJdJptQ71FjHM8GRFmb6wDIP/pM+cW/hy0
 CewsmROCAPNX8+y2HUi3gxxeCQQDhBz/Iwg7cgbPtO0FrAz9n1ciNYnXuVQpi+wFIKI1ux3CxJf
 5P2LQ+5EEg4lqf/vFq3BqHz8MmaRB97d8OA6AH8qmzkPS+xDtVQnJ1ekgNQ+GgvO97cEtjB3iXO
 N/s5mancpXneNNaOMbg==
X-Proofpoint-GUID: wZPcxkbecLz4mpkOiTgg35QqG7sxkFR6
X-Proofpoint-ORIG-GUID: wZPcxkbecLz4mpkOiTgg35QqG7sxkFR6
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a15b15b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EzTgQT2ADBj4VUy-sZYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260126

On Monaco platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 2660c161c3d74f4002aebff40634509e885fb3b3..00183ed67ebf0645e1da0c4674248354fa2af941 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5088,6 +5088,8 @@ adreno_smmu: iommu@3da0000 {
 				      "gpu_cc_hub_aon_clk";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		pmu@9091000 {

-- 
2.34.1

