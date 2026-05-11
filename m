Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12138330A
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538249; cv=none; b=YJ476HNCsEihF2FqGzj01vqzl3UFvjohZEaYFJC/SPvDw7pSqPnH0xnZ7Iqet865KVYYe0o19P+5+pfihCCHN9PaklT/3mY+nLt2C4oAWbQvZo6y5y3dEvNpP97Fc/ky825CmfyKZnKYch/Eat3SKx0uqu7cUfdAPKUnkTMVf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538249; c=relaxed/simple;
	bh=97HQIGbf+tNFlTRiyh8gUJ2fs1SWaMmQ0EPBudtudRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxRwxYjKn/04JquGY4fMqHWXwe9PpljDulwkv2iqGZTtjGWfiJheFdLzoiX0NVuaB48dDNukp9QChRwQGZuJAl+X5biQdZ5GzcY01+senIZGtbKjLhKB63TxBCbk2WLXCxHO5yVmYPsXJ/pDDaXIkElE9Fdn5kp5eyC2MtZdnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CG8l9Pkv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmQLsZix; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CG8l9Pkv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmQLsZix"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6jNE2187626
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=; b=CG8l9Pkvro36Dld4
	N/0dSJ66oyZTv3rClHs/r32KRRKZuk1OnZV5ZHWIsV2e/b3h6q7lxjL6QFcSb2qm
	JLNjdXW9dnssebTUeCvUdRH0M1FRxbFNFoE7FuHhfXMlszdbDO4ezcNvt68vJO5u
	bsml0ZEI7vZYmfsumcc7SPdF1h3RmaLR3AXRCNPi6SR4XfaMT7US/n7uyjMTFGOD
	2UgkFS67Xq2iRPlLmZ7rK+5Mcgf6StSyqBMTS2PMfdAOITQjGencCsLYvgcIcPAk
	/b8WyR+gkEmASOkZQkQH7KOlJScJ3NVm5Lpkyj/B3AvwbKMWqG+gcCln5Sq9peEL
	i8fgog==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0rf6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso3074441b3a.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538247; x=1779143047; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=;
        b=dmQLsZixRRdK8P705yxxyeXhwlQ9uVSTErU4dujWTtwp55M/1RerXQHfg53B1XYUP0
         UPKre1cfsJLKs8BQZh+jimVbHzq++Wui+jtk3ciw5p0OOeY6sXkBuERauny5RqJCsEyS
         MX3SIbP9CK1YDFDY1HO90fk6mecspBAHQo9GUccoXCwEq1NTc4PkmQzJDIaKjgBk8nrZ
         XdzWJafnHOnPHazg4/8yFGGu4M8P5NJhTDUOVmKv+mioONqPmEN2HBU52Xrab7LSz0Qz
         +I+2734R1lb1cyefRH737Xg/yzGtaZfax9f1OX0Btu7H7FTsZu22atldACj4CevRvkiY
         O3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538247; x=1779143047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NUPp2c9rAOL29gHVGIJXyIeP9TpBMN1OdAXgD2H+ohc=;
        b=Ry490Xt28RY12kQHCGvjISMv1MaRRNH71cRiH7NMXN6awQdIgc49sZ2ARF2wkna1mA
         sSZK9W5m1+k86uGLVxEj2jGvK8khBzTR6BPbAGZqyAgwxy/7sNVjR7Y/4SI+tfOFI3Ru
         BGON2Q1bI7ZjxVj+V0El5BDOCAaKLzzuEZxODPwcsJICwX3rdHU/lst/Vo+WBFAUUvPp
         r5ylvb8WENPxpqZctXX4UovHc/bjzADTrM9mKrxHGr+rmO7wEmOd2xoetzqzSJsQ60Qc
         tkf6spYJbgz160eyaIuCdkP9k8T6+b5TKqZ41RXtQYnKtTGwMdfrX18MyNUxCAr9gN9/
         +WQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bdvYtJ6iwN4C5MoHPyBleLmj7igTtToXzjJm7o+bHxwcnlJNd+m/Fih5xNZj9d/DXqFdSNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWUBG8xnKGBZEqc9bM2hcuTiUdnLytG1j23lAQB1Jk6NBBoio0
	0c4DKcD8brFV/BHCPVvY62HWHXk8E1tosAN925dBLwgrFVFaEiqQ+de5bFdRLUJI2qhU446fXo1
	2rnblQ+XeQH3odZvA8tWqXb0C2pLSY8Afzcu3r1+ZhLEnsjcGT4MkvUu89A==
X-Gm-Gg: Acq92OEUIWFW4UYrJFTse0NuuzyOizrwHrrNYjWAqBYlsgsl3AffMi8jlWAoxrvhYzg
	tfUrLyCGZiHqgaU3ImHHrp0Kx1/rz8U8gE5bd/EwZJUXydhJxsBs2JJzkv+bJppb7wPG0ZzWhiF
	EqqlQKyl22r46lTYF8NZrJH3PNfio38Xn/ChWT9g0rM/K4V9W1ntqUNziZcxCT2J96L6LIFVan7
	wp4X4GTaEAniPGeP9+yYFect/D5hF2CE3hl462gaO3/XbpCsmxRz+nmIAHpuic9LGZHag8+3Whu
	wCY25vZecrx9v8FSgrTPrTA+si1S/XUNU4zjsi4gIjj4Gf84A/7nv8lQC6Y+p+/QdJ5I86SC7FN
	VKf4A5rr0GpN5uFPisbd1+6Vyq6ydzGB73KOYOmskAMUA8g==
X-Received: by 2002:a05:6a00:a90f:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-83cf4f760e7mr18257637b3a.2.1778538246803;
        Mon, 11 May 2026 15:24:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:a90f:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-83cf4f760e7mr18257605b3a.2.1778538246344;
        Mon, 11 May 2026 15:24:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:24:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:18 +0530
Subject: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=1012;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qA59djGG78P3MNRfB1Y8EMktq/ELkcaIx0EmOPVu47I=;
 b=9OvPBcF1MZb4Ksy60cJdP9QxS6+kk6zi2B0H2ygRxmneK9+uTtViTgI5ljZCjPD/i/sq+fEEV
 0s0G6D2JEOpDKJB6PzrAU5NDlmvdjlzdEQD3pg3eLjw+GXlyZfoTeaD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX2C+gKFUIZumQ
 Lz9N/98GVLv8E1sU5aFGHrw0Waj7QOWwsZ5ZUSUX3/W6Df/uwqGUj20NDA1JPU6xKhgqBFLae79
 u9rux9MC9OUkP4QAshyVVULANY9YP5Jey0AovqVA1xRSUJ52wbAAeVyCrYY607NW9Zk1rbSwIcV
 q32YnBbsqVK3GpWa9AgTB6OygUD555maqWmhd/VrkQUiTkZQTxWPElB3TdR8XC/n9Q27cxe0TyO
 bpp3CwNtEI8XJi0yAbkNjQYv8ATMlf604OPBRXqKqPhzKeyeM915dU1ccs2FUIc9KIIhQNAm2yQ
 29MuLkQ80IALQmGpGuhs5HWJWhS7ahD8XnjVXwsR2CTkuWLpV+XVjcFEv7E+C6U+Pa7ZvJ3N591
 RRs26GhZCtrfkJb+BTcs9LQXRUDhhf/E62kb5xpaUTNfMO6urGJZtvInxeLZViq7zt3AAiurwOg
 qX/GlTfD5OGmvAmjseQ==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a025707 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: YHpswZ5fDlUCBIVQuACU_BVlhVmC6jir
X-Proofpoint-ORIG-GUID: YHpswZ5fDlUCBIVQuACU_BVlhVmC6jir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the qfprom node and gpu related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 26a4de9c8d45..0211fc9f8c88 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5868,6 +5868,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.51.0

