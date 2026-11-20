Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182206;
	b=GTl5SQP4xgExQid0x2HYlr9+CEIUwoAPHvDYyGWPl9sR6qJBGGVWwEuWH+NwpJ8qhYBk
	 jEWwgSxMTmYABdfxPwDrUcEJjYTPLxbEkxa2Qcqi6fZkL8zobpOIaFaVEteenY9qIfYox
	 J/tr9zoFKNucaQd5OWOx2uewS+qu1bvArWv5LGxNSlL6zchVZE7A7bHzhcb2ZNmWFp6L2
	 R0kRJFLoEZ8fhFk0CJlzeJu33BrhgUHLfkPB/bnV2uBmb6l2uxvUDWqcKjhAy8dcQtmdj
	 FWFaNxiPPhpauyYuMoXwsMZi9MtxLnDjX+Lsu1xM12Eo/+GGjEYIcco5BCohJNeDNcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182206;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=11q+vRagsURgN003dOUkw2FqOxmyzwDRHyxoyWI810Q=;
	b=qOSy+Ypg2wi8FB5rwKS/9XJtK8l2IUH8LGr4uZFl+UBN3Gjo8zsx4BGQ6K1PpkS8RgfA
	 BQ9vjX2cBrr0oL5MEdp8c6xhLOe9Ufaa8rDcve0KbwZQgbz+B9cX1ce9V+onVUhZuEMZQ
	 v/Q4/8s7Qg6Ab7fbdK/k8IL4bcNZOykVyKRcB/YHcvf7xFaAmvqUeuceBxG6NzhB52YnU
	 YH0tklAcVXb7/gVhAQwuoVr6hmlMUIYDrly2HQN9AnqakDCe4tMyt3qcZuJZS1ni8vY2k
	 Q5h3tEmr34VHv2cwB/o+Hv+O+XDmPeUakwVNOPwyEF8RxtYZjtrRi00vGm3j3XMRoYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhRk0EOS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hm5glYDV;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCE606A330
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDCE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhRk0EOS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hm5glYDV
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjo3K1462863
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11q+vRagsURgN003dOUkw2FqOxmyzwDRHyxoyWI810Q=; b=HhRk0EOSDMm6nvZ3
	BAGnmzSLIm528Q5Si1IhHj3Tzlzrp+JyHZoLm2JmVEjVYgGMtQ4KjuDIIoaZ6xZh
	qOTJ504wX/EzA6aFbHNQvvUXGH51sDUuVgyLOrNVtUS4hyWd/C3F2nof8FkoVa7V
	LP+zkjQAXP6XnfeztLRHG8RAf8MaB6HMzEud2eSlUEl/epm5ssRgU8sGfR9u37/H
	98C94Gaa3ngMRSZBDCedHTdMIkWlbLJz3WhoVE2mj/PEyRdnQ2vuthmurKJjCJiu
	eIxymer2Qr+UZ398MC8juFurjyKcoWC0Ose6iOP/fkR02mNbNWnLKeOhsD2/cMqZ
	g1naWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2guahrnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-383165e9b0fso1015767eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182205; x=1795787005; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11q+vRagsURgN003dOUkw2FqOxmyzwDRHyxoyWI810Q=;
        b=hm5glYDVuMAgFWHJG8e4Dvc8FP/Y8gMuXDBFcdhLsgS1qAxbPffguX7bbgztfOa8TA
         Zo6rkn5MEJaKFwmljFj8KbBze3K21vqpTwnYxaWWhvgr75zEtckEfy/2jOsTEV/KnqhV
         3qMTHMpjP9kN2kYZDgbPcyqX1S3yl9P+FzwptAM3FZ+PFfNRBcClTgesU84Cm+JY5NDq
         AxMHX8Z0jGw45in5CYqfUZm0L3Dcu33VL+7++omwycPT6B0fGrpeh2IJpR3w+p3pNI2I
         0dj6yX4E1ZpU4f3Z5d9MWciPNRLfs1XQBxMMq69vu3Me45KrTDCcv4D+wKTth3lSIU4S
         CaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182205; x=1795787005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11q+vRagsURgN003dOUkw2FqOxmyzwDRHyxoyWI810Q=;
        b=VIwb8Z9wSc+WQ7w+3rP6gpp+QDqdtQyayn4IvJMDXYwntl9TldZOzjR3PnXEONoxyS
         9lALcORmimDqm8/tv/a/5avH2rZKnHw2LmZDW6snrSLKWoYUkpkg/bG2Jt+qZM2VzwJm
         7Jt3P8iHf+4zMzcUlttCwSlt3CT+jGfRArLSZa9Fbw65LkWYXo78ob2q2rGLo0WHhaep
         5r9Qz1fDO+P3i0RT+YT01/Vpi03im7yrpQoDnYHV2TbBrJpsTjywB3afL3jfUxw75kJV
         saTzPjGyrwwsCGtfuNlH9XgXw0KCUzp3/TNpgvS96Fx5h6y+TvGUzohoJIDgfl6xu7ig
         7Mfw==
X-Forwarded-Encrypted: i=1; AL+hErE0LJPX2N4lLj0hZSX5GrTJEnnRKDm03KuKo5KCZPYTpR+sgHR7+b5EH2Iq2Bm3t5Fd3zLWRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vTPlVktwvD7t6zoQNHU20Ygddj1W6BLQllIZ1dsP0V+qXoQ8y
	NWb0P+pfN6PuDELokFLapJ0L3phosUEtsqtbl3fZfY553TaTd1KipsP7E3dWfmAJnMyGQl8yJRs
	q5gTmHYnpm9RARlNBD3Thhlbwi2m/cIraxBEhLu+PJ/egbR67a9Sp19YPQQ==
X-Gm-Gg: AZFdTZfn5h2B+cZ+UgLeGvKJpMcp9Th1qBIckYf5ue0+8TeuG68aPHrSVbkzAi0InUW
	icpShAbNKjCtUOza0PUoCPMZLmkpANuGU4Gent/npC48DeZENGQz2l+GzyFWISWuCetcENG3NxL
	MSsrG1O6oxmeLHu/GzAsPxqM9lq9fACKUeLjwAXjqStUMPUKOh0wmoQN5ztuXHY63lykvXAm4R+
	QHJ+AeF9Yg3srGy/C1MmxquM+j1ZmDd8Rcbmgtg0dY5XubrtUGpwbISjJBu/77X5DaFJtr1eNWN
	NxHSUd6j+mkeaxLk/nxc+NEHftHNPh005eTN6sw2scUiyp+qdGpF5LdvhRfnqz7KZn66So+IxjA
	al4WjpID9fDGWQszP3yQ5g84sN01x9x1CD+f5pjIGvg1O7k0p1wlTRwvTprubkfPuq3HLLPM9T9
	QewIQ=
X-Received: by 2002:a05:7301:78d:b0:385:bc4e:dbbf with SMTP id 5a478bee46e88-385bc4ee6c2mr2084221eec.37.1795182204959;
        Fri, 20 Nov 2026 05:43:24 -0800 (PST)
X-Received: by 2002:a05:7301:78d:b0:385:bc4e:dbbf with SMTP id 5a478bee46e88-385bc4ee6c2mr2084180eec.37.1795182204261;
        Fri, 20 Nov 2026 05:43:24 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:23 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:42 +0530
Subject: [PATCH RESEND v4 11/20] arm64: dts: qcom: sc8280xp: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-11-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1035;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=PpMW0q5rEXx+xuC5PzlM9sk9j9irWo68n5zPzl2ij1E=;
 b=Pkjaoy76t19TmVXyKiraf1je5qnYdJSqZ9wPp1wouYn2rcPq2jp+UCvggSvaMM9z1JceutZzn
 GG8Y7hYOgMVCfLpH6IlRbXGGvBGWghMLIBz9aEHYzIxRKnjldYDoHOB
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX/vw/KoffJgvw
 YwX4NDrmSP3pZKrZbjFtDEcdDBTgwnIr1b/KWGOsqYZMxKOTialvvB91WpHSzP/NwPUuXkDS1NN
 YqDwjgrbLEVP3rLEh8xZ4RZo6iDlZDePvHGPeXvr0iarWyHv3xiM+/JjwUdkjgVDBV/M68RQLpe
 Z/1q/VUuQBv9HRv11PBhzQlFHN9VwzjshiYfBMhuuorSSiXKWV3ODBCXaMre7WAAU5++48BOkl9
 +YifCaP+7epuwN59OX58B1C7+lc8NrZ4PxSty7P/Xi6xqGrJe2lfVeEwS3jmvBUQg9AsNnDZvR/
 FDO0N1Ww88xKFtdcogpS+QZtqvI2PSQFciK7PUvU5stgLZ8LcMGfxn5kxjMYn9b3U3P5/siufec
 1zwzKEFWvtKOY/DhWz3xgGCjxkuGqEJ5Mqr0twIBTwYLHycHHTf5wy4pXnWIgGZvbRpGlBaINmi
 fcYPfm+vUnD2YSi7+sQ==
X-Proofpoint-ORIG-GUID: SmRmrac4zI1fFB6QdZtUynoBK9kcsarn
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6b004e7d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gJkqCKp5Tu2al1pXNpwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: SmRmrac4zI1fFB6QdZtUynoBK9kcsarn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX+QVaVOie+CcH
 1jx1MmRqVdtnhLAI0qDrPAQva0DHIdV0PW6l8x2CwnjxTwz9WiB9xqb0issElKN4/dnCyLdPxNI
 Ew6noBsDkSLJ2+yvvWJK/8jgpoc/xBI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200054

On SC8280xp the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 703b4f4e2059..74c53e70f0ba 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3564,6 +3564,8 @@ gpu_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		sdc2: mmc@8804000 {

-- 
2.34.1

