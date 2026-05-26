Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC9405C22
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806562; cv=none; b=Qd8rGCfKKpypj50NSCL0P9bkw1PccnTMDP5mIsDJS85Z/xQSzXATTl6tcLdc2bC1Otk8uFk66iLDxyCn4UBh4AKoTWKI+NtqqZGsREZCabwKATKglT9iRaZcnSLv1cR4aDO1j90pG93EOX/fO0nPz5aIZDL3J2l3rK9TETC/rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806562; c=relaxed/simple;
	bh=b9Rdi+IfVGJGVd0iCHEmLl2F9yeoA7YYGwM/7TZc/sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRe+sbIHcgPYwPxf8TtssI75KOxg4AJamlNgXq5lHmKz3RwAtnNzwZhlEPOSg49YqvXuQDGU8d1156IbI31leI4uWmQqfFMvi8bK9OCfm0yaO9cZONaFY6hGy+zgh+urfGip03UV1QxSnpXa1wjZOetSvKy0tRg/iwdvt4gh/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qayyh9Sn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ja4lrt9T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qayyh9Sn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ja4lrt9T"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QDhrqW2528461
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QU6H474a0YDo59Ajjy8caYGbQkw3XHZEy73rL2NPd8U=; b=Qayyh9SnNbcVlqD4
	48hf350bK8RsqsDr4NQ0GNVo/s7hSkJZalrF35arJTah0tBe2W7pLXHpZkfQ2875
	LBBhAwETUVZ3b7bAcKC4mRRDSJx6jJ1LTEaFQtxzA+XUll8FglUHiQGONllLVYSm
	gG+j+NhEuqa7KdeQdz+sQx/CuURgX+nSWSFnrnqi3wi9kH/Rg+XE8fWBGr3B1Uyc
	TfRCGam9YacO9G+/kbwHIJPt3hSmnhLIOYQISqbiT6NcHeAQSd4X1oLDWBVVoyQT
	5PzYpYw/uJjSejAYzDgFH4lOtZjLanZpFq5WD6Zrto6n5wkI4maKSW2d5iZZ4Ni9
	eJp8Gg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edcnnr8p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8279604464so13460277a12.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806559; x=1780411359; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU6H474a0YDo59Ajjy8caYGbQkw3XHZEy73rL2NPd8U=;
        b=ja4lrt9TmZUDcXBAcpTEWZjZPpn1N5f3Vb8ge14llC5iYJ47EBRgweBuJHVtaNdHp3
         euQVX8tUYylr79m3inj9RJc/oF2iiGVpooiv9q3C4lw+eYM+1drK07vfwM16VLpOrSOX
         rrcfZTv5SXlk/4eqYXKFEbOxS8OVZw5/sqeSZRUK9lB3mPsFO8OjFriaJAJdgyTmG6Ef
         gvhGssrg2Cpe/+On4bs7pBsEPmxBLJp0/7fYU9LbD05ou6xP9cXqQhseuf3CE1pMrdAJ
         oP7ZXugChSsg2H8fJhk8iAT2v8WXqXtbXipCZpe65GUPboTzJLpjTcJoENoulCsVhd8r
         ABRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806559; x=1780411359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QU6H474a0YDo59Ajjy8caYGbQkw3XHZEy73rL2NPd8U=;
        b=rwCtfiiTKDn/Kcw7nw1RtcpsSn/41Rg50HAGEyXY95CwLuxGugEhl5+NdxjuMHiW5p
         SkB1/d34KqY5PvU/E+EaQK0IIGItG05kNRJNExRrwg1RzyTLyimhl4FypQk1G/Xki/5E
         yWZokQwMx2msDeeYsYwzZeEnt1Aqzsp8AxkhI2KpzpNtTQK7pYe3rAJ8cP0YWcYxnuQ6
         bQKwfOYtrCr9Y7Eqbr3hF6BhhBVFO2OyIkBqBXtIZMIydCPwh+3l9ATSvvmbibum/L7D
         J3VZyecr+GBPhqwEalYM3zXE9CbXCRVRyd+McoAGzjVSYRvs/3/s5G5r7/1Hp89r2NaK
         xEIw==
X-Forwarded-Encrypted: i=1; AFNElJ8UIKr9gSg1ink0tqpyfMUwthQ4e5CraWsTTH4yD/IRHaZ6iTNdQiWpK6wUq729tfewtjryCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvyfJdX0DH9a3VoOGgYXpyT8Agx66YoyBh1JgHZUnRrHEjEPbP
	10ctv53Ce2yc4RRjRnz2NEnphZGGABtCcugbCDqMLrK6POU4DCyxtf+PoY7YlBzJKZWgnGZizdN
	L/V7xYSE93Fk6V3rW7BWh2cpBy61q4W+YAcPXz8OcW6AgkRlCBosn+uEghQ==
X-Gm-Gg: Acq92OGe7J6K8+P5SXhszEpv7kE6ab0UPhDAiyfOaNOQJUOL0SGxCAzQhFl09p9EExF
	gW0QdWp5ZdgJCYPmvqn7qk79lvlX+5Wp8sq4YzGKFgakixKAmzK+aKvOr6tgs4yf7A9NQSiZiic
	LOEnd+7VlCHSuO10qr+sJ7mgnfLUC5R30UKqUrIESEfqTfymyjqdd0UewTzU1rsrfD0jd1qfm47
	DfbYImaMWgZ8tKUoOkg3t5Ij8CesZZwBrm9sngjggagLZFsvFz9eX2jro3+RkUrvpEtw0P6ekVd
	EAB826MzGJWQEhnExbMSeHAosRAW6Uw0t5KIUIvNapapX7hq8ywO5+PcxM//pKzh9AmWF8VrjaL
	3GTtlNydjCql5VaycfZaP5cS9hAXO59u31pRzlW6N0le6BJKW8Q6Z
X-Received: by 2002:aa7:9a85:0:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-8415f301995mr17730389b3a.32.1779806559087;
        Tue, 26 May 2026 07:42:39 -0700 (PDT)
X-Received: by 2002:aa7:9a85:0:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-8415f301995mr17730340b3a.32.1779806558448;
        Tue, 26 May 2026 07:42:38 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:38 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:12:07 +0530
Subject: [PATCH v2 6/6] arm64: dts: qcom: talos: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-smmu_interconnect_addition-v2-6-2a6d8ca30d63@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806527; l=1048;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=b9Rdi+IfVGJGVd0iCHEmLl2F9yeoA7YYGwM/7TZc/sc=;
 b=fsVa27Uyywz9GSHvUf8xB88UX1ed1IqGjTVwOaAancFT19+AlIGoYxRrcONbOk+rVEKKqPWBt
 6fOQgHbCzBjBJxlRuYKC/eAdYk7fc38gv1W36Pb5JsyTAc5NJjajy43
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-GUID: 9lMWatLlrvkCoJlL3PbzNecy8rs8Fxl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNiBTYWx0ZWRfX1Y48X6iczxpM
 h36wAPZZ5FVXzW9SWZuXC4kG3Xs9CDwHBJaE/pp0tDXhMd7g6kudiVzlPiaiaFxrP2I3QnT8eiW
 ZLu3UyZofT+SMuEMQKKmLPnK+zOFhGhgAmO+UzyUYPwCLRW7aPFzXFseVccrkYwdTzlpW+vzV7I
 pomTZj7cT4ou8G0HuG4mNJ8xoguevB0UtXmVsK/hsHY/jgKdQf4smL15FBtmYSh+lPFnvxY5ezh
 Dk2iyB3TvrG0JySocWwy221zOx9wETrkgYzIWKQpNfq1LRny5yUfGhAbgLT5TUh1LMjDp/nxJlw
 oCp0e/ySqqbt+5FW97i1LgmaGjaS2YQ8+/cgobHkQOYPraqISgzGj3bsRmd5zvcHAsRjA5+bC8/
 +xxvUGH3OmKjnXlqE787IFVBAPD41m6o3DEcCADIKEgFjuej05SLqavHrJUILjjrtit2Q8usW0l
 UFk+rQ4lm40jgvn1iwg==
X-Authority-Analysis: v=2.4 cv=VPHtWdPX c=1 sm=1 tr=0 ts=6a15b160 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=55tFDwK73Rs-p4iooc0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 9lMWatLlrvkCoJlL3PbzNecy8rs8Fxl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260126

On Talos platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index fb1bbc51bb8a45832568da26847312e00cae722a..74322507f4e8c796bf9529a9f0adcafbd725ac73 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -2090,6 +2090,8 @@ adreno_smmu: iommu@50a0000 {
 				      "iface";
 			power-domains = <&gpucc CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		stm@6002000 {

-- 
2.34.1

