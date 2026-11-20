Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182254;
	b=K7OxqLf/7m7u1yhkWh5Ei+ZeHMCPXPTOQXWxTiuoI6YaZHydwltwSJd1epBZWeYEsuWP
	 gRnDdwBnieCkZbB9tTnNI1LYcfOj9s3KUIO4bFmm/aKFUG3vA+6Ym14inrX4LlI+LgP0/
	 N1VshuRg5iSLBSs2TRNx8yueiXg7jL22c6ujbHyyTupxjN4pROj6a4AxoFxJlx8kOf8Kf
	 Pj7nXqjOjeUsWo2ZO3LdoUH+XIPlxitMH/CspjAcGlgSPT9vlv718Ofhf58dHL5mO8GmQ
	 QfeDswwvd0d4fEAzbnSiT+LXu2RH7hP0bipXA7gkNzDoznkyR2EXVqrwR/1Kf3LBbUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
	b=wyoobCWSvnuzPdq0gFSbeHBeExsghFTFVdQizu0CdKcppnK2sq2rmH49szPNIKsT3oJt
	 HNXV8Hkkyf+WJuFpzUpVYI0aDoa16wFPuqMaJ0Qplhq6KYWtHSZC2DERyFo6gjOs8Jrwr
	 NBzTc2GpgkDrzccsjUVFAVH03o2YpDLytj2LvvaMtM35ub7tTYhteoAxrV9YYen4fz74B
	 9XFyjQCj3Cb8D0+ZvGaHNVzNF6SCJ39yGhWD6Jnhuv7lWMsH6ixNKHtL6/0BQys+SzYAb
	 x4WFdeEh5dNf+5hiqHHRonx0wShXcZaw1dxuv5q8yYLwPqodjnpcncxH3MXwlIUS/Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="I///JBMg";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EsT7ATJg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377360A261D
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8377360A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I///JBMg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EsT7ATJg
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjss01681938
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=; b=I///JBMg66s+Ajzu
	47ybV+1oKz2uCczswJ2PLec6ejaV8ECbm7IfuYzpICw11jUAWMVRIzg+OsYe4ap/
	+Mtw8Rbx9r4eUs+2WCUN0vwcJj7F3LE/ywIgGOqi5wSvPw/szZMa6E1/Kb9TZ0vX
	5j1hh+1g/A89ebO+E4ZIMxEJgQoJmT2r3dh0TI1MaeubSi5v8KrieU/DNnyrKsR9
	wU6r/VIKXVMxw4H1Wq3hrw+DP4hTux8BPHdAE86pgVQ4DGEo7lLAhSsibmhhAJ6H
	olphCQt6frVIoaQZ+zG31UD0VzOYKY2Oh2RdOWvOGZzr8nZwJn6PiNtmLHgbOJ8Z
	M1vJpQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1tqf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so713936eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182253; x=1795787053; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
        b=EsT7ATJgliOp6KMk+9ohfd1G4P185TXbTcg7NAGYGWXAzY6CP4ew60qys3nEHu+4L8
         wke805LMZBuDEqNSB51b5+RlcWtresN+DGZnn6pHiqoU19Cj1FplwNweW2CRZKgFNhBo
         UsDkNDTQKr1HYfyYqVX/sEYMTvZWadDaQyqOuNLHtC4h8eMiYZGU8TkcDD8FjlOqIyxe
         2DdxW6T5Z3aW76pQfXNFPRI6hWgjFBHDNWIkkmet8yXI8W0EqFINdXz9t52TACQgcTix
         Nrf9ES4Vuc5T2j0bl6znDuvJjCm/MRyihGK1Uu1XMo7eDLURx2jyCcSKSisZYf0LmCh4
         t2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182253; x=1795787053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
        b=JqUD8PY0J2C+Du/aro7sMq8RRmsVaACuGn7rQPotiI6jAJiTNXyHIur6Mvh4vbM5K+
         FDvLrO/E+1gPZf2Lj2WNOIb0/W23zf+lpFPoLKxy7bfxoJ+dHjD6fIbGfILd59M2Kr5n
         smnm0tmQxDexzE8xfVkFWYbHRUj7343p7UWXNApBxDcey4b1wv1P/Z2kDC1+O/NG9Gp7
         sduGQdHGjyqOgHHzuELsuPFMNkTpwz+J3Qpr4oHFbYCMWDU56kvsuEpNWf3MG95QB1yH
         TM8oUCaGmL1dc1TiBU6HTLXBV0nnj27uU1Psl74WRr2SN1aR2WBzDnO/V4uevodVCVnn
         P46g==
X-Forwarded-Encrypted: i=1; AL+hErEOWra1PeN9EKj9hVNmrNBwe2GqtjtBREul8j4rh3D2txxVndrVbfr46Qk3H0iBzwYQzM42Ew==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nC9JL6YhGCavvuBDj9okHCpOlMxsjpQv1J07dfiAAQR70Hxtq
	xni1E0ZXv/yb3ays+34lJ/RbuGtDlPkCDxUu+X4GZ+KdM3BhlTescPVX0j3gHZbxpSrBXS2Gf+J
	VwcpkO4Bjh0jBYkOjHfooiiFzTupQ1Ly1TCyHXp4hNsjUTHT1ERAtk7M/O54ghpKg+A==
X-Gm-Gg: AZFdTZeCY/KnUyTlqx+HejjBiA3Z4JhX01z9oaFR1eCjPN+GI2lKrB76gLFjOwJ4utz
	cB00nZwXhBEy0eKYd5L15EUbMVlsG7DR8+gBPXynDrahvx7bM7jI3sOPjSftuNoVvGMo9DaQ+Vl
	D5Ni4bVJIc6gCflEqFQvoRjMyvhEknWfNTbcULzG4wrWIra//JrD+xL72I2P5Wc6NLgtkRoDbOX
	uqdma6QOueaQCSv+zpt0RowYnohq5LapEMAYw5oGK/F/05slVoKtrqR225+UMIlp6fjrTvEBFP4
	PRwZVknDSvS7FcxIxOrCBBncE0gMc1QQOY7BxN1qhlFX9K0z3oWaSS+53M8g+iblSP3GUeygez2
	35KA+AA5oAcYKbBwIJp75t4uEfwIimVcjlKSUxpotBgPffXvDJUWAEGAu2Oh9ng5jA44QFqJSM7
	ihlQ8=
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id 5a478bee46e88-384b3986edamr4222091eec.7.1795182253046;
        Fri, 20 Nov 2026 05:44:13 -0800 (PST)
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id 5a478bee46e88-384b3986edamr4222061eec.7.1795182252290;
        Fri, 20 Nov 2026 05:44:12 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:44:12 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:51 +0530
Subject: [PATCH RESEND v4 20/20] arm64: dts: qcom: sar2130p: Add GEM_NOC
 interconnect for adreno SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-20-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1058;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=jWnycFT0az2p/u5EzI2kuq2uyYSvSmt1HyCePSsKymg=;
 b=ZflA6r7UtGdDB/8yQ07sE7yzSHaKi/dsLit6bYC44nb5Pebakn6aH+wZQKxLjgIoCtcFXVcpe
 bgFuB6VkQYvAFuouqHVo9+JC5mPuCRTT9JJdyxC+SQjThL3oBPuBpig
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b004ead cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BzZyaU2VGnUrTJno3XcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: zBvuLzOLeTRfoiomE_PbvOqoE8a8Xtm3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX591iQ9jYO5L+
 W+vRMSj0Dkz6M7u1Xr7l6dysUOopYz3I7XtYITe7v86mRvpPL57F1z9V5m056TZdjxUx0ZUBcIa
 xFcYb1yJkFD+4AKBooSdOnFFbwX7jqgnjAeTWLIM4WW8Hh5pkp/QtV4iHUhrj9jv82F5IQi8X8G
 i5WB9bD2G9MimW98iWjZSSE3D7uDOX+ufpYZ1LG+vZPcK4vK6k/8sgv7WTWmM3pE0loBMJG7Jdd
 ehhWOzyRRAQuOjIXbIEy8hcvUwqgiyC8bVAQ7PbVA5k5IRx2XNwugwOv47ByEJElrpMQJyWk+bw
 2/nNk6Ed2eF6rZLh0iz5kfT13FlgqyEZpMYXSG2d6WbTbq6C+Y1xlrZnZe8tMsfX+yKatWNLbbQ
 JXKe4C/113amFGkIITkE0yukys/YKK9PA4uesmQ8feWGvaiTTAaWyFD+XVUbmBQwEv2sjLnsPlg
 2HsYX88FUjmXa6VcwqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXzpE3WCHqay/2
 wb4drwX+/nm+7CgURccb4snT/O5iJb0q30nOVnow7GqUn32rS3NTrj79EOCvaeF8S1SdMxuQAwK
 TwmBQ6ecNzYHTSor+tr6vdI1/2MsGH4=
X-Proofpoint-ORIG-GUID: zBvuLzOLeTRfoiomE_PbvOqoE8a8Xtm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On SAR2130P the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index cc4077005e66..950fb83f26db 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1857,6 +1857,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		usb_1_hsphy: phy@88e3000 {

-- 
2.34.1

