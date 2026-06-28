Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59A2FC037
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671100; cv=none; b=R/DxM+UbvF2KWyku06uDXH2DPmhbFj+hFrOblblAPEpgxSpFcASx3bhzl7xs+Nwj/6N+QjdhhVEymS9NMV36hJcPZdxHXjD0EsVZ/CAMptXL7+OIC5oyAXmXxafQpQNy5l9s8fkl4qOaL9WCJs0kspcEnlRnsL5S1meGaOpEDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671100; c=relaxed/simple;
	bh=1o26QioJ+NgDK7fmYrSsNAyclYExqimllpZCk7ntDfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEoEFtM9zjpDxebsQGDgLK9HEJxm+BBHmgHHAQqH4DfReUeOgEcDZeg02IhRE9CWBJ4Um2W0l785Yhmy7UCSuNykM1PKQzxP2L1RTD2lMP6BABSc3yFht0G+G40hRxfV3xS3VvCyBQcBdAL7HOPdH1apHRnAjwretQRx+a9+934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zg8G6Q8u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfZpR/wM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zg8G6Q8u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfZpR/wM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHjH4t445064
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=; b=Zg8G6Q8uUhjfLb0o
	vSZ9rn1P2sClR3oBYHSJinWJLHh2+8T/RztbOSNnC2SP9lPyxeLZ4MNt4qxvvEjL
	EP7+gwI5auQ8Pb9RIebe5+pxKFrIfaN7s1PR62XM4DW5MPuBQy/MGkCvRtHEHbpv
	4WBY0SXRDlgDMzdIHUctpX2Cophcr/VSKzTihjpfb7/OFZ/RtXTEK6/0BKnEPWGb
	FKi4xsVDVy0pVXtlgrgMHKhh1EQ12Gp7XH3In3b+6X51t5k5pIxpCRd3TvUK4U0B
	p2qeg+y6Frqsevq7Voxl2i6UQVUsHU5+jjbbTxSItKbCJdN8g/yOr7R4pZPRzQOT
	BZbSjg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27083crq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c95b0e22aso9664102eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671097; x=1783275897; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=;
        b=EfZpR/wMa7YSTJpimsy5RPynE2HZud3TvrRaFVtAbrRC28ACwKJ7h9BbkMBZTPfQTf
         75wBtffmkGiw1XhSAsBH6WLd3rMtbQh/O4UxiBZXfYDc8TY+zOuGHLJS1MRCkEnNBRg4
         r0NWDkyhwGuzygTasBH+KdtODvprGUa12CU4QfTadNmmSVeRSgk31sGNm+huSBE7zGZS
         SjJnr19K/VXgDuQM0cmgUIUWy89/86uzoXcTxjN6R9NcxYGwedE9qckwO+eGXlCqmQtG
         ijVYXhRW6BFJbUF4z0F7oqu544Gyhr3JPt9Ad9Yj9tKdDblKpSleC4w3E41PIJXkp8wY
         nalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671097; x=1783275897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=;
        b=I/+TViAagUTVVk+xOV4quBx2+LRz8otREmd7UoYKWo1a6HoIUH031EerjbBwp3WmIU
         diFnGOjjSMaEVGAZ3XXjFqHIBmHXKJruVTrXLsQ3bBZ4iOZUM+Wb8aheFt854SzXtK0s
         yzzxrN+95xFoKXbuXRSfB4BeciAl+Cuoci2yFRX5DgGxSuIn4SYldisY73aClzBL4GsM
         k4W65SCMxG5tdv5zc4hbn1tprSnUOO2pnlr/cqH4HLX6cwgOjaSG1/hYPJSBBAy0pON+
         t71np6fRFRO4wY17DnFT0F9rxkt9PKebKjNqQUYkqKsdF5tFcolEA5Iji+isjv9yBqbp
         tc6g==
X-Forwarded-Encrypted: i=1; AHgh+RpZv/m3qbHfbFBnT6WnGUVvnOwrjPmPg7cnsQOJVCqhegcpVoJzJlyqOI5Blna4HPpQpJeNyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YytlaxOKutiffnL+eqKHbYg0Vi8KLkJjLQmxIWRKY7kJCPniaD3
	Qtc6wzHaDNYo1X0jdGwoosGuJiBa/79h8g+5Yj9sweLff/S3/fuhRj1+B7zmM8V05WM5mgAy9eS
	1XmkhH1QPz8hLlPGN2fK3hHaHkCtmD/LzsrtMTzbBCcxDbBDRoQuA2HQDlA==
X-Gm-Gg: AfdE7ckZnDyMUWZbEExompo8k+0WVacy99Ea8Sb4mF/JLdX4Zi0p3+9sQcApwdRVYKO
	mFd00h5zwJYraAb6vAdTA1xloPpqV0Nh/KVHxfJJKD6JnmXtP09cJG5IAjZr5T0Z4WTy46PrUA6
	NX8oj8zdiuULGpmRo3mTRaVzEqopmjnuug+sjFxFlf/CvBbAC98ENNf+/l7oFTPuFyCCPep4DjE
	+SzGms0a6WK9FGmQJSowxwr+nBkbJFREOmy0vaVIDj/lFcQNImEu/RqxlO07t8Dg93f9/lPKOjS
	Myfj+xKLQ3GjalQ100yk1zXGwXZuJtvOjXogK2EPrlERdlfHCT/vePQtJVQEDp2Si47F7x3ExMD
	/UXiFlC9gf0J6M5cEuzo6FV3rSO9wg13Og0Y=
X-Received: by 2002:a05:7300:5bac:b0:30c:1b22:646b with SMTP id 5a478bee46e88-30c84dad33fmr14207340eec.19.1782671097427;
        Sun, 28 Jun 2026 11:24:57 -0700 (PDT)
X-Received: by 2002:a05:7300:5bac:b0:30c:1b22:646b with SMTP id 5a478bee46e88-30c84dad33fmr14207304eec.19.1782671096877;
        Sun, 28 Jun 2026 11:24:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:24:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:57 +0530
Subject: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=1886;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=G5KnzOKbF9FC9XZVD3H/X6wimGnOXvf0oUqbBl4LZbE=;
 b=tUNf9WGYMJjAdYic1WiMT87XqmIviOCldRCxeamUi7NGV4ape07i3r+B/0zrufi/pAMBdRgfw
 9nDbsKCIYIfCh5m3IYARovqRiiL0W/Bm4G8HRkLexLCQvUv65gCf+n/
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a4166fa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXxFIBvnVurwkY
 Nz4EwU0lTzuJtd6SIv9xTj9tskRylalxehljyNuZxjftgv8KVK/MYfLM1A0lf/K3IuoqoSYqRRx
 q2DxO65k1v21YFnVeeKkvyvS3YdMZWrnQJg5m79+QhxSCidTfUqneAcBD0GvdB0AgucVgdx01kL
 maizVTEXavVcARyS3SCLXsO+ppzNarYrshKtN6qpDPYy91vU7RwW/k8kINQTTBw6Xtg5aiVAqty
 aH6APMsuJtQ0PBUcPyo2Xv7/vscJuVicCY7DqEaZh2B5aTmvQ901+KDy2//AH+tApqNbAPjcA2T
 4eaejMlXBbm5EwuS6PErAl3Bir/MCVs474KRO0OjjBDYZRli4cbgZd8Qx2pQDeKNAGzVsINhaFg
 Xg+3ZvTCmitZ1OR8mS0tfyH86mLkGpBDk8XvW14VVKR9auHslpqRX4+pundItkqtZQXp6oGiRX8
 cZFJrSJCRFxvQfUeJfg==
X-Proofpoint-ORIG-GUID: Z8GvbPYFkwCkAnyDhgVmbwbGst0IduBT
X-Proofpoint-GUID: Z8GvbPYFkwCkAnyDhgVmbwbGst0IduBT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX4+dGa8jXvRpA
 q/fb0iZCdpXl8r0CcvIWqBSGYX0UBQVKsIu30OjH4hvYfWYXwEg5WXpGTlTGiI9hF1Am8qwBdZh
 6PSD7GLdW/IttZ4zoicqobmGWd0jZwo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280165

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 1ccb0f1419aa..398cb1a4dc86 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -655,6 +655,35 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.51.0

