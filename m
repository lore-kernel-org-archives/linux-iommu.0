Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5A40A951
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357031; cv=none; b=EV4Wi2SkXTqVYOCwWZHYVaRE5LIwxUqxHtYqI4HJlWjWm0lXsWtYGwO7bFjmqMahNLdmNR3RJbHN6etVhCV82v9QYmS4hV2tB+91/wLA7+T8Hc3efQhmL9AwFMiyoA05Q3EjHddjHgsXMTor8XceoVYdm2iAkwHdS16n7WGBcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357031; c=relaxed/simple;
	bh=p/ZYI2oyj2fs74BmC7SPx8h3Tno06dXdJ6gC53S2YGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr62bM5HZw7v/Z4DxdOgTfEJZzWjh9WSdT+XLJ8u+Hqsukp3y7Gscaru539xpNMStJniCmxKzwQ5fRBEivQQuCdIRAau7hNBl1RnZWrAdfeBptBbgkZVx2cHnybEuFy8ewwpZrqynn4eB7m4PDApRoHLIbnYdVQVlkPgJlI3dvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FeXA6KSF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HHU2uosd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FeXA6KSF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HHU2uosd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6AH947319
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jaba91hSwH71CM66VVDdMF22IKaDQ+KdMje88NtsjZI=; b=FeXA6KSFxxCKlWPN
	zfB4pOD36X4FMU81gH9U7n2TsmhEv11aZ8Of/mtdTTHjcIjKXYgG/kKieTmxPJWi
	9s+yOFk9B8a73ftMjX+rNbDmmjK/62OrWuFZg1gF8zmgxv6qcIraW062mcnyL2nV
	XoGSgYfIJhfDdqlh8w/k+LF7IQOKkIpsHbTw9eQdy10fR/badamJnFFPaJKhdCn2
	1QjAomJdNYKFtLF+xKnh5ZY5FuvUxOsGXgLO8HA5u4+COwDMs9qWmkp+l5temi2i
	NTptCNejQfMwlK7JKFJgFA5vS11aWPc1vM51rHSuQ4NBNauHTaYeBJbgCg8CT2yK
	4AB4WQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h52d4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:57:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c892143db7fso2683523a12.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357024; x=1783961824; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jaba91hSwH71CM66VVDdMF22IKaDQ+KdMje88NtsjZI=;
        b=HHU2uosdLtU+qz0ZbUVeYKVc4c+Wq18xlDBb6dknuLH7Q9aJXAbT0+ohI5/RjHYh6T
         ONpRr5HJ6HMfZ2RiVylUAL21BLRT/hD1HXaT9BMbPkcSafG7e6a93r7zyWCRSijtrOau
         zx2fzuRqoGqhZPrE1KqLdPStDhhPelbkOSBbtP5ugvszChHOyOyi3F/e7NQAYsur8j8X
         VB00HsKx4gcZyMHWruXxd87WTXRl0+6r1ljg0umOTIFVEY9c9bR3v0TSVPi0y6FSdwgM
         y+1vXQPZgUHT48KmE4mpXU2/bq7PIRcpVK8aVifmNzTET3Rg3mU0iqk4+6sDJJDcWLeO
         Dnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357024; x=1783961824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaba91hSwH71CM66VVDdMF22IKaDQ+KdMje88NtsjZI=;
        b=HdcMp3Cz3Kr7RjoPrfmqj8VXcagv+Yh9Aki795vXsUqAEGJb6eF4FaseOclWk77Gio
         +rMB5IUxsOaLpEQ7ozFvq5E/hTeXZf+7q78DffxXdGHTyNokMonQzKt48meif9jwD2oQ
         7vre6HKsZuYEdwpO6SRvjX8PlzutX/yeq+Q5FiE+fYLBfZCGoxlqYrzoJS7RxfAhECed
         AGjL/UaEnL8cjePi1422G1OtCei49hbQ6Sb/12byviqS3hqGo1PWQmwvn/eZ8F70sOgs
         QAjyvLW9UluGTDUldGBJO9xNNt3fSiOP3d9cxPz+SuOgu8Yhrx3MC/44wSz7mW56M8zb
         wo6w==
X-Forwarded-Encrypted: i=1; AHgh+RrjadA9Q7/Ops3NCDGDsi7zy6/1Tyc2HcPma7v3dA9dpGp3DplVs1aCL/suqU2v0Z9lSRh6gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymxRel+eGF2wEtfxrIdREOxQVsWPwMFEeV8Uq7owjtAgQaShyZ
	970CpkycREU1u0JtL8rWwqiUrkOoV8bioRM3Cn4Rsn42KGFyRse5P1YTJbdG0w67v+VlQorhL+C
	Xj3q+GPv+y57VmSh6K4OcuH29qNQ86gP9Tnf1yS0ACE0fFZMubnxlkhutgVUoR0y43Q==
X-Gm-Gg: AfdE7cnneEGV+nep1jh/RXAW7cS/XZRNxZRzN3PBh0sOe/rOyERe6Hdvr3rBoy6jPTI
	RLni9hrHtiOix7m3o2af0F6czZyjKwIyGDgYKlDJrhy5iJQQpLJJeeCAIE+s4NaAD5UfvJBBHzr
	uzBFld2Af7PEC47BDuSXpwLYx2jDoyFd68iDYcJfK7rZZAAjCptnGVSEz3GrUjG4Vi+T2snk3M3
	foxlDap/qE6WAROWG3aJe4sPROU9cWLxB91Rw1qnQ5x1S2YmPKmPjdD0HxrZXheY9wccbcxTeim
	2cJBLyw/OinYBQuvAMbAKmsJ7zuTMZZA66zmA4M3HZaChj2FwAtfyNUxD444VhNLIQLgEgLRgO/
	pqUSVU4GG8GJetU91kWp+xD9/M/FvWfd+sgf28DhPFw==
X-Received: by 2002:a05:6a20:c786:b0:3bf:7bf7:7903 with SMTP id adf61e73a8af0-3c08ecc4d61mr1761481637.15.1783357023714;
        Mon, 06 Jul 2026 09:57:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:c786:b0:3bf:7bf7:7903 with SMTP id adf61e73a8af0-3c08ecc4d61mr1761441637.15.1783357023259;
        Mon, 06 Jul 2026 09:57:03 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:57:02 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:36 +0530
Subject: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=998;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=p/ZYI2oyj2fs74BmC7SPx8h3Tno06dXdJ6gC53S2YGw=;
 b=In/dpfQ0xnfFS+WOyQM3+imZpa80Tr/uA6h882KzG/ER312er3VHUUqUAf3DCUI2XXwGHJYct
 kmZUcNUIAtVDcoKEsJ1BEuLuR8xQBkY1E84nx6fVeqE5mDpvMzLTqj8
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-GUID: XNuZeR3LzoEzFok4d7Px-ItnGS3uUzNh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXz1CKnA1zlnyJ
 dDCtZ1R+bJvGnxWdQDQiXKyWoDx/qyHymkLdcz3Rmxdss4t3uYtMs+oHigELM5KkGvDbyBPiN7L
 Bcg+i9txR173dSSSwgffhFt5KB7xxEg=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4bde60 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_R9ktDxRehPmGBbURfwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX2Bi2Sl1xovxb
 A9ATeMhvZxG/1X5BcCtDmRJCPMGJPdHmXQyvQar7DNtdLbjPU5mxgVdBqPZFF8IUK7OlkfB9lpt
 F8b5acMeAQeVOmmaOdQi6dOB/ADDQ4NjyrAmiAy2yK6exoPtG6LAYG+SbNsLo9/e+qTyAsyK3mm
 I5li7NFdFsKPvxe4sH2HOJ8AVDRT4gmisxF6R2rr357/3psnopdZGVxCtQbpHlPE5DTu+6fWgtB
 dQgGEVFY6EwzLaTXoVPmnVxUijwmD4CZ1qzDuNLJXpGqLpQvr69wbfSxHhrSVL0pGtjU6edcRo6
 3T7DMvemellLV/qWODppmVSgQvikLmqxduam3WLMekgiJZuG9s95BbTe1sByJNmbsxGMPIx9bI6
 v6Zhc6rt95p9wGD5UCaEy+MnawOKzFrP9QYPKC+64GtMrrc5HLXPiDPbUPXenL6fE+2AVLo3eE1
 xNcePUiRV5Cphz1HNqQ==
X-Proofpoint-ORIG-GUID: XNuZeR3LzoEzFok4d7Px-ItnGS3uUzNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170

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
index 90e50c245c0c..721526f023dd 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gfx_0_tbu: tbu@3dd9000 {

-- 
2.34.1

