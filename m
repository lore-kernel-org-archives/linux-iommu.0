Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E473449991
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622585; cv=none; b=ZCidETKGJJnaAK/nn5UAvY6DWRn7KMX1p0bBYLwSrNwtCUYUf2+bDib1frCk47uYJ4eZKmajELqjjBWf9uD7zuafut+8zCEHPgomuj7FiECtXcvM9Cww5LaZb/zluEz6BbA9IaRRoXooVD+eJDmfZm9wp0hko6qBmVVbF4Z6Zz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622585; c=relaxed/simple;
	bh=yGsij9VKWI7rB/vT0J8nK7LauF77nPjz0MJTy7VKUkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIFFT9UEXRlU1ZYauaAnFjWEpaaLNsr1W5IDBG8wKhLCc+pZQgmIxZ7DGDzfXD4EbYDYlFchsH04r2jcprIU/o9wLeiieaqzpwsxu+abZDezbEG7ifUiD4Y8ujyzh+RKBgP7r0bObRl15Prf6mXQT9tiqXtvxEa8cV7rppBr9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nn93OOl8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6Ln0tYI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nn93OOl8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6Ln0tYI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HYDHQ2476568
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=Nn93OOl8OZNvmHgX
	gvJJp5QWD8pxMtDdHmWnsdrAZYMSIBorgL7VdW313o8cyeJEFCUe+Ns5n6Pj2G1Y
	dfOfGefQdFUOLAmNfMULNJ53GMT6g8U6vVNKvnHfl+CC9+0/XY/dCIgLEz2MS0cA
	OR3ZdUxt/zV2qH3Z1FCZtTtq5dlLlWdpFcWNReTWRvGmA73ZeH4LjvjRPD5Xon8G
	vxFnXP6Fn09KMDSrgj60yrNRaPl7kLL+K4VdnTU+hW7LpwfEMqRKj5xnPZ9qC9d5
	jawDxZjcAW6rl7rDnpyK1O3+hsvoslrNdcV+kd/mtbYCgm9gY4oO4oD+iLH6TbPi
	weFEEA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mrp8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:43:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381250979d5so236020a91.0
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622581; x=1784227381; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=H6Ln0tYIXXdmsWYWIghGCznM/7e763alh/Smhl0x+HokkaIGJUNX3GmHuFq2pz3QOH
         NYu5BZ773oF6F5v+kvfTJvRIJWycnRl4VUpnhKqHvx/d0AiBhKEVHItvB8vl8JVpMZA6
         53kXdM94Lm8/9AcHMJ62WyRBRVHRPbvUeot9GT6nNZZxBT1Y3QgCef0+ZnvYuegvG60s
         ZZxDwSydcNI1rHsYUKqqIhfWr86EAKuHKVnMm8Q64FM4iGtPffuRd8xLFD9AMaUay3an
         63PNGKNBHp86zUC52rAueK5Q5cGYUVphALzEtMpGLJpX9EGZEwM2kj0sylm6gOidAfZV
         EdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622581; x=1784227381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
        b=dktX5xmLGqEne8/gwMcSttVEoNOvDaZmK1E9flB1a3KLy1nDoH7Rznt9SsFhmrvl/z
         HA89L5gHYKRUcFZ6LKe1hGimMLEYkrjVNE5Q7otOarE4zZLJbBbyytMrv8h3zokdYvD3
         9Q91tStWHGSkVeO8vwwpbCBB9dL310Twa68YiHgNpLXHTfmIn9mGohoZh8DYTg0sfe4l
         3u9xl04+SSrH6aw4euLsH3OlO2uyeWCKviWwrAVXTl9b3MmyjcneeDMBEV07ZAWZSfRH
         pKqp/m3FWRjjqGQC3RpUOcagXyo5u6hnWuegoSYYNzy7uitB0Cb8EgGuf8agKoAFVb6N
         MleQ==
X-Forwarded-Encrypted: i=1; AHgh+Rox3dcb6Nze/8xMPzw3ZL02F8fLf3R5VXeh7mf4eSO747IzTApbobUzyaLuiq+j+alOq3duOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc+aCY35rSnpWYy+f9DM/MUIQ8fEVfpspRqlLgCqRAzsjc08Xr
	b5N5mQ4fPT81V0xTgT1nHVn8BmibF5yfknKC7GKT5JchgURlP1DAilAff4a+xvQalN1rD65YCxf
	1gt6d4Du1I5O1ksx76QCf81AW3CPTd65OxI3Uvv0md/SBEj2IaLI7SN7u3w==
X-Gm-Gg: AfdE7cnIIFJcJuH3cl2D/qz87TywE3jA1l0raUtP7FvN4hzri+VF6JGDlin+E43XTFj
	2rGSYiMRkBsrVR5vz+iH/p5FENEa8UBIBOptHwsT/oj/9dczjobvGsIjBcyYFfCDZ+oDjhi+spH
	hgh12r4ngzz3g+h78KBfNwlrncNk3WLkcpuz1JRm9Y68kcTdCJJFyHJgF0yZlQCiod4gMOJuIfw
	BDh0b7a7gPQUTd8OzmyEC3iIBMdA+qQm90y1BuJh4gadOnp8gCF/ZvLy2YzM+o9V61CtIo4/Uhr
	LJtTs+T43ntnw+Ly73kE9ROw/tI/WprYQW6A4Hg0x0MB3SALKMkGQcvaABdUK5N2XF5yMvlGq58
	rnYumW79XVUCzy49hWvuNwMt5Sb/EAm2NZMA=
X-Received: by 2002:a17:90b:3b8d:b0:37f:eeeb:646b with SMTP id 98e67ed59e1d1-3893f97ccf5mr7914180a91.3.1783622581508;
        Thu, 09 Jul 2026 11:43:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8d:b0:37f:eeeb:646b with SMTP id 98e67ed59e1d1-3893f97ccf5mr7914153a91.3.1783622580962;
        Thu, 09 Jul 2026 11:43:00 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:00 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:03 +0530
Subject: [PATCH v6 4/7] arm64: dts: qcom: shikra: Add Adreno SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-4-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=2hVttTTQRx5zMnrLWm1rAziEUo0KqAbW50W+2RE7kkRSP52+sN8ta7ltAR+qhxhPFdVtIsNQT
 21HAwNZOnqjA1MKkTJmHPKDYJ149gLd1W3/OoOL0yOSPJS/9mcqOXYo
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: jjsJdVIV5mTn6auJPadRrqXxjYsV3zO5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX+C0c+hJ1k1cW
 0DqxQOM9pf28d0ozv69BLy1+cDWb3N/9Pq2lDsQmwKvOVi2iU4aQtXwKtg6dJlhLLiJvBGzYyDv
 ZgxBBCaF6HX1yATppCFwMrImVYfsddc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX0fDkEOWCvCRn
 W5JM/zBvPybO51OQhCGmmdNsFqtxHjW8qa0aiXL0CL/qdzm4Lsnp6Qd2eMwpDZnxDvd/2LJ+SfH
 +hO9VE2xxYgM/tQTMZe0+I4vV7ht8G7+MywepX+dTdzDr6AUBupW59oU1tzzaxtyN4OiyZCT55I
 x44LNbhrNkg80SRnoe3EpVgadXRJVS9iYSWEEMVjgzRkASfKXY1q7oS6d3C1npaCFPAOQ+7eXdZ
 xTlHTElRDTTsl0/XL8fBvVf8RuSOIJz/p2wKIiCBL0qqpdnIAjLQxwv46q29LE34kelc0Pk+1QA
 4qFgNyEXZGw5/vgMwBLz9PZ8ICEtmAQSQaYlMQAripV787J0VYTAtO2fCDEx+yXH52V+MmPosM4
 v5qDPp9nk/lmAFv+RsDd/KdL3GODWEiemd/q4hEq5mCUqLmPk4Xg65F6fWmtbB+Vqx8rj+3tiU8
 U85oi2Yt8LLtEzuw5rA==
X-Proofpoint-GUID: jjsJdVIV5mTn6auJPadRrqXxjYsV3zO5
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a4febb6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index be443b362576..bb11e832d9a6 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2005,6 +2005,35 @@ gpucc: clock-controller@5990000 {
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
2.54.0

