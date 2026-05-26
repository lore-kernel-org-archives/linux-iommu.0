Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099B401484
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806548; cv=none; b=lmgX/5mPqkdOfIf6Qz4VI8o/6fiCJVDuG7niN3WhX8DU+m2a4jMkY7nv2g4qgfWfwRt/JjNG3TnPZKQB/I4Uz9wO7GFwsWFJY1/7wuvqVzLeEQWEn9e5QBC9GrwHjyB2mawkzlWmNRTF+Rie3Lf0IXKogF03krJ1DohOA0+n3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806548; c=relaxed/simple;
	bh=PUiL1di5z0y6rI3EPmKa71j71HOBjYrvAPS2lyn5wcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxuEf+ZyrXJS+oJbQpV2F4M0+SDpGcCJqoynfX9FSRSQ1hscvEp0wrFFObBEDxcqYq1wQt7MKtv4w3e7ybbp9tVfqdE0eqL2ODVp5PH6hSQQnJo2BEk8E7T5FQLjB2tAnlviSt92pV8eZOJ0Lwxjb39AfGJ1bZ9U/L9mHah3KMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ow2REcvV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QwfgBRWs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ow2REcvV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QwfgBRWs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsZP02496687
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8DT19M6pQKyGnQLXpjshESdaPdBCoE5uHW9FdeRhlQs=; b=Ow2REcvVjz6jJYV0
	+/mToHCztuG2rvHawhNLJKSbRd6Ky0UQiP9f9cau83gCW4ILJS3JERFThYAYxvdw
	+o+xs6UNuixwE7fyC4kGaIA7eFmKV+kLRCDdMJa245Hdifn5JaSHwZAK1E8gpPuy
	Jsv7QeI8XAhBLZ9FGY6EYttPm+7kw6UAOKsaERbbLSKp1senvUjDSpEfF5NFYJMm
	NKbIyxhbPB0U7pps9EQO5vE7uKLZE4wLKzJJPIZ5Jp0dsS4/szXX5KHjvTuRLF27
	4B/XkjOFDA1/qJgYH3zlz9gxUtD4i3uoigJ2dI++hTRvGfrh2B+T3Y2LQR9I7g8T
	1B6wPg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqmwd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-841d02525b5so221226b3a.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806545; x=1780411345; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DT19M6pQKyGnQLXpjshESdaPdBCoE5uHW9FdeRhlQs=;
        b=QwfgBRWsjkrB3F26rcxQAACA0lgNkau/U7KvEjviBy/Mwsqo444QNDYResORy1aJh1
         MTFsH+i1W6ShiWnzTgsY+7m2aAA/k5eTpo14KMztlnHyN37RHfHEZAp55Eiw1KXxSyAQ
         5m1TIvV5E7gGszFhZBQg6XxUhL/VMoK8Pro7OvS5bjVVD57Nksy+npSVzgM6v3u4hAh2
         M+0YPZuPlfUkKV9R+Ntuz6uuLPGrQQPQIJh2RU64rkUMLuxgIKWNj0tI3NUbvqprWYLN
         lHQJOpu2Bacg8Tn3B11dY+QDQOIcHHnAJUqUfZ14xHIazyplAt3b5z0DE6eK0QUWLOJa
         BA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806545; x=1780411345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DT19M6pQKyGnQLXpjshESdaPdBCoE5uHW9FdeRhlQs=;
        b=HZFNj5uQmQWL+Mdz5Kdu1GpMEfpHbf+KtHHRvdGsg5js0lAhgqzSbUhK3+cs4RY+3W
         +btnn7Su15MaArfmmI2bvEKuDu7Tel2tP0FuzGBprrgJ3eh7D8fBV4HkU98YFkTV4GWe
         UylF5sGG22cBFZxc7/QdupviPuoruzS/rBJbDT4Qgg1PaJLyZ08fH7HBAQA+u1A4RvyD
         yWhUAHjWHQBQUDG/qgPoreJYgGUHrep8FtkFNOvyFUs8QhNohvdKmzha28flS11iml/b
         8xjfHaz8lzv4YqLMG6xua1QGal9AWwkvaXVNZVR1XOdyBMCsR51j2DOXRcV0l5WlgszP
         cvGA==
X-Forwarded-Encrypted: i=1; AFNElJ/epwLjaI2uhX9UFqqmawYGVC2AqobEWFBCC6qXXEe0GPUHe/vDW5GDCIw3QRMJIRz9y/rX6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqqLSLl6bhnLN79vNMSpzzHZoYrcrVXYZR1lUpBtdD5sp1bjga
	J3+8riksQjAsKm/3lNb9um2DXizGYCE2bb2y3aCU3/93lDq/VZzY/YQEpwOwz2lTDRG4at0poMK
	hK6/F+71ZhdLSZLAX0hByAKhQEa/9PLkSJci6UWTuXbkkecAcwx6djBmerw==
X-Gm-Gg: Acq92OGL4U5aXUX60hcR8m0bpLXLcNzd9E+sptPoaH5oqep8zpD/Q0Sb6F3Djn0bq0c
	R/W1ncRjtq05urqCNP4377TJUtlLRzZ6OjK1jC0yUu7/OJfwbAPWgwSf2HxhqA6G1d4dHIbibj2
	H02I5MXZY22w7rT50v31YxFPcoCNs6kNBvAdK5tJVoW7EMfPZF5QWYzXGG79V4B4/h9eIkpbavy
	Pk1SUcZtmyLRpQoPGlvrkMtx3KnBMwpCZCzxukVxpZwHKamx58lG0GRwvbu3dtxLyxvRncdzDWD
	EIP238LHvFWTrWZmZwYv22sjH2N1fM+2dKCnBxYTlGsvfrI86ocMIR1ytWyzzvewne+X3polWTO
	0ueNyDDkq5el/aAPLDYCgL8WhRikedTwr3uGvSRxtbFybG6kzJGY3
X-Received: by 2002:a05:6a00:1f11:b0:841:58b0:82c7 with SMTP id d2e1a72fcca58-8415f0efd10mr18388717b3a.8.1779806545499;
        Tue, 26 May 2026 07:42:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f11:b0:841:58b0:82c7 with SMTP id d2e1a72fcca58-8415f0efd10mr18388677b3a.8.1779806544992;
        Tue, 26 May 2026 07:42:24 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:24 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:12:04 +0530
Subject: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806527; l=1054;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=PUiL1di5z0y6rI3EPmKa71j71HOBjYrvAPS2lyn5wcU=;
 b=qwyYNob3QeroNmM+O1jx6rx5POgtChtC5hM3Hm5uGPCBB2RsdsoypthoZmgjsMf2N3zHCsl/e
 Oftw2IUs38qBTANvoudZtqGM2uTv4xEXg5SKwkblpLX5wNzNwyE1z/g
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a15b152 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wmxX9RSyIuGEu2EnybwA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 3brYVgSO8URrJEtpFmNpLcT0Iu1Muugm
X-Proofpoint-ORIG-GUID: 3brYVgSO8URrJEtpFmNpLcT0Iu1Muugm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNiBTYWx0ZWRfX4vOgkAWBMsZF
 JkRCrk6C7dI+uBha+Q6PmvbV9e/GTUS/cIPz6rE7o5kCTEdkW+bEJ5gTJYryY3o7Nl7/CBemoUi
 0xdIhNe2wM+gwz5+VPjvEOZq1iRmss6YpNaI/1a1ILcrq610aHYmkJzQ6hduw7Xceh6fy/DU/Po
 A6P3ujo+SbbflD0KdB0+DNEqIa6FUmHmR78Yj1Ibho0P9W4HrnHTfzO9eiuH48MM/pQuuw/oqkz
 a3KyC4PY2iHQBdnaqhajUWvy9DD6WzUKvDo2CpUYrL84/lKKyw0GqdBK3TfmWbWblZoj8dbwSga
 cp2twAoP+i2a+8Z6w4uzcpNeNKSFlOOCI6QrX8rIVpsIDul/L4QpdmpKafpK544d+TAQZFjjvZy
 wPsHp2loc+OzUjGyZQT8mFhke2i39qgzJJv5P5jAvmfnC+fgy5cudZ30crFAA8ZtiOenP9sm41L
 H+5aFXAwIwHWJTITixg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260126

On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gfx_0_tbu: tbu@3dd9000 {

-- 
2.34.1

