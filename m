Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A933C81AA
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444777; cv=none; b=RWbDO5faP3Epd+37ojrdcc/9ZL2ey5zBX85QJ6ngUaEpduIrtvoBOPkXrPN48UOgBPXd/GaL32VKik1n/bgFOENAHFMpXOo2QHZi3J51ihjLXZrJ56S+8fHaCzKjR55wGx5nSKPuwB//yYEPbpcarGuaYvzbGN7RWbqKuIdaSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444777; c=relaxed/simple;
	bh=GnY9q+Xc2Y+VqHrDqGOayOA+eKomJ1efauJwSslPH28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr/TXkJq0BwXr0sv/UoMPYpiyYTpa5l0lWFcolWZP93tWScMavO3uZPeZo6l9JGHldYbTKONFp6nx5ujuNfXUFcGKZK4DuU3jEFeqs4kPmzKZymTRfIJNo3I1DYfOAh3QB9da4gWTlyLTyVGTUXVGDXUCG3kejSLEUisHJk8AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZMJ1SOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOhyAvMr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZMJ1SOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOhyAvMr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9EFcp3005145
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=; b=SZMJ1SOidQow36VO
	OmfNAX/lI/DPOfz4E1kbWdZb+QV76/Qqi9IBNmAhbtB7Hk7BRGIN+kyAeN9T0sec
	Qft7KZdza78Kf+glrSj0oRC9UOCWmhIujnxfnimp550FN4Rj+iOSKFZGNRkpw54L
	Xu8A+eACHkIogqYmc9aeJ2nF/Qtlochx8Dcn/KL935vFcx1VJCdaiu6IJJKpD7vY
	FJDPItryyTHcNER2akP46kPAkRgOfWZPnWslxEQBwQAJBxJkuYnSJWUfpcawHvR1
	v/ZiWePBSyL9JvR8OYXUStgoZPJPW/Tca/RKDGv4EuMuXDJHKYohFwkwUNoqsoAw
	PzEcPQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt9ghh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c82c4772950so3596625a12.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444775; x=1780049575; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
        b=JOhyAvMrK7jQ6s/75UEfQ9byvXz67aQmpQmIZWhTeo6m2lrB4EpUIak/MYy1dL6iiL
         uu5JfVoSF6aU+J8lqskGMDu/S33oWjotVHZ0zr/BUoul/ILAg9i2ez5zDXQcBpV2P5zr
         UXD1BZdRaneA6f0jjEiIO0Zy/MBQrznDHVP0NEYsX+LegWD7iRKFk0TJaCzZyZkIlmrf
         mJGqFihCpjbXUVLjGQGY9a9DKmQ5uwlme5tMlLqANBbsLEy7sWiPA9NPGbyGaUQMqMb7
         yBb8j3lLQ+1TP9Z86FHFGofKes2PyyBijgyPcBYIZzPQ3CmneR7WVEiwO1OQ24K9PfKG
         RAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444775; x=1780049575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
        b=Y3Bg5hwfzFGWom5yDZVpHs6CezoetqcMm1kDIzV3/CwV9xtT6ov2JRuf5HDqNf6S98
         maBZVpQSWD7FnWg7EBaBLsLtcOs4OaCt5afUmGJKVfc3Ye6Mf5am+/nLg1UAPKHDAned
         TjveUQXc5vQaeDeWBp5A6cs9S3rnXmoOg5hmosAXI8gm1m6yJ190Z/GiL4VbVmjdkDPK
         IvhpdycC/WgbYVamal2MexJ6aCXCHdK6Bc5wMHs1IzRsP+xbjtIa6zYUNApg8xrjh129
         fwR87Buu2x2AO+CmeLen/uum7GG1sqr/zUoumkkGSGy4UtuOY3HYaaImqNrPDaHvhazK
         s1uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tOkq1Q6jTj4cITX1sWctrbkXbFRFOGr8sW+6q4tD7PWo7194FphHVthMCvB7uiguxFoXBGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5Zz0S1IjBH846vv87y6p8phEjxBdPBdTgHKyt6LlNxqf43FKx
	1UoY29arhNXLeYeduhoRQAtOM9bUApzU9wmZ/W2Dr5kXLr4KZgqP3QdRXpFTrDVv+or4h7xNrB7
	DeCBmZ4rYd7So5RsqJRdWTS7cZHGv2frGiL5a15u+YBz1TrtWbQmfgTFzfA==
X-Gm-Gg: Acq92OE/eCqYxSZaNdClmGHbVsjrXM9TJeT6HndxoKiYbRXfzQvRnL+sVgZzvXItvOn
	cQATOHeAcwpnbIZO1mmsGGFnwvKxtaHQ8UGiDwFLDqNqNsQcljPM/LXrCCUwRWppRhjMrfbUdMe
	1bw+0hU8ldCAHTRIdWx6M2HKANDAq75KhnFKXpAoQ3NWtYpGUleQvxqqLt0c4G4Jph6L2f523Bt
	qv1eCIqOEWv57YnbWZ44kz9bTM9BuWQuj0DcxlsmiRmTP07fYTuTu/hMDSfbEJZoFGDXBkazHi4
	HtOPjaMG6QZPCdFbjX+io7csr9DLI/4BRISVRMkbhM896Dj8cIk/XOnzgZtXsU9mjlisvTesFy7
	zkeE8L74n+rMtGk9c0YTTjAxIrWCNAj9JaEF5FQVfUCeiVQ==
X-Received: by 2002:a05:6a20:7283:b0:3a2:f05a:795e with SMTP id adf61e73a8af0-3b307bc9d78mr6490743637.3.1779444774653;
        Fri, 22 May 2026 03:12:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:7283:b0:3a2:f05a:795e with SMTP id adf61e73a8af0-3b307bc9d78mr6490689637.3.1779444774118;
        Fri, 22 May 2026 03:12:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:12:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:59 +0530
Subject: [PATCH v5 3/5] arm64: dts: qcom: glymur: Add GPU smmu node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-3-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=2464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFdQhBrAHggcU0GWES+ohMA4WsH2wnpDPMNFqXrANzE=;
 b=yNzqUhOCMXQvxrRtd7kxvs7YMFtzu8GiAVVxvYNsil7K96Pk0pY01/RxIvWewjoljNJUYvNeS
 3lRjHziweCfBb69K8ZhCLsCORtTB/RODIjYmlA7lEj942QbUt4Oh06+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a102c27 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX+8Ts+FSLq3UX
 HyVhFtF357LMr7UYdsd0M5bmhwMwu4LO99yn+GMBd9ZNCYeeYQHG8Td73QBOIJCf/5dmN4SlsbC
 duwrufeOv3ofZtrP2IiJLFyo/7MhYnd4MkvDDbZ/8D38Vhf7VlhswQoNZ8dmbE6yQkiI5jWE3jo
 zIqIWQEq4jfgWfql1gnOVdEsSviaqvTXhs/Tw1CZAml5TC0Psu1TWgXqQna8o5W38D62R+/aj0D
 2F7aunOojXzVb7Nkfm6r8/o73oaC9ZrQiP5rYmTFX3nxxRrpRvRar99rHhRGTaH/UzzWOnIeXsB
 rKTfo1SodC4EUfTHQgfP2EdbaTTMAF1LQGCmHAVyX6SBAMTqHXNNUQcNdkgfMQhiWww+ox8vVPh
 OuJAXjtstsROPyAcx2bE3SjH6IDXTRr47QskXCzOWOfTocDfj/iMSE3pMSpgTaUJ3whwTmiMO/O
 qaicegwhd1YQ7KeB+fQ==
X-Proofpoint-GUID: B0tVAbsLZ2_d5SqTCnm-SFz7ON4kaSLV
X-Proofpoint-ORIG-GUID: B0tVAbsLZ2_d5SqTCnm-SFz7ON4kaSLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220101

From: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU node.

Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index ed9aac42fcbf..5e76a0d53f01 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3729,6 +3729,44 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,glymur-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		ipcc: mailbox@3e04000 {
 			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
 			reg = <0x0 0x03e04000 0x0 0x1000>;

-- 
2.51.0

