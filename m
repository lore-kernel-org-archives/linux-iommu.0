Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700F358399
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238477; cv=none; b=LfoE/xKgpjQZg+A5LazqOgHVBYy9kKjX4sqBMQ0ZIkfkqK4qE4TdD74jVuGmVGvwe2SXUhLx/9ZwNpeZUGBKX2HTRvUhAlcuMKdOXbyA/AhtXOY+YGSydcXg10m54E4H1TLgjvBOhNqHJHOF5DrfC8Vq9nJdqVyG31C2bzvbwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238477; c=relaxed/simple;
	bh=OI1UXEhAa5SC5DZklOc1fijHPDyOfJ0YDvWOJSX5GAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SmHTsjVzES5qGiUUA1Mln9uk1y674qSYtc+vZOL70L7smFuKWb9zRTMWVYgIpvfjgOIXu7NqZNvOuujo6GIovODH8cnSuJrc6EuskfygRTAjpvLX0UfQYCnCJRDrfVhvQecXXndPe/XjPPPcMTTjkaNKTi/fvDK/vDPqOivzyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F8GfDW9B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbPX2yG6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8GfDW9B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbPX2yG6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6655t0iO904665
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=; b=F8GfDW9B4t3o2Ow7
	mSFrZM8hZj1xH486Ik8lcZU3sm2KfRxIrl+rQEv7RzYxBCgIxJ+n34qiA6D/rQvF
	xzEVZamXH8bwZ/zTSKtDygn++pp4JQy8svP6OwYl41aJ3nIZA7SS4qo9fazTtq2z
	N+wQZyf/FGtAOEDILB9L5Vv0njN3slMLQ19gkGitGsVq5Pb9aRLCA3PbSzxpuT9X
	88rrgTDM28pUD0QkGPwyq/7tS0ZkEuPVDx66hN0rf5QIPGWjUhxRU4PQBgcHlfgd
	YLO+NNb/WDMLXeU/dip7rvBAa5XDpIjaAOKSkMp5+b7esCZuR/VV+7Xm4eNAtbI0
	FpkaZw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-380fe2a3fc7so1523604a91.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238474; x=1783843274; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=;
        b=XbPX2yG61nfBbMNvb1YVAo2rj0pxa4BTNO3xPByk6xe5XOqUsegp9tSjMAcVvyfKOX
         8z7y/+FuO4DCFYM3KxGC2uI+xLWI3tZ2pcs9SGT/6PbhqzWBumyBi4NYFtgdaFG/jQ5A
         3D4wh/s1SB5lo0v3poJ4BTwbVvCKpHfKpd/iCjw/KQqDGef1F29WAiS30YvTM36kgr/2
         W1ZMiWYJfzHt/qrwC0JZ1EyShKT5kAMo9qC937Y9nH/bgfc+vsjpHW7qiQu7v+w1gdf0
         ikn5rJMofcG56MllTMIXAySJLlGaYq/D0Bv7gPsgkxx6SDvBTjJwML6R/s7ZzFFrT6x6
         RWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238474; x=1783843274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=;
        b=B3EHa4QkiLyfF48Wc6z1hW/zfInBkJZQuiz2KL6XRusIWmY2f3TNQgoTZqyxBcX8AS
         JS4SQl7eEaUvr0Z7YlAzE+RBc0T1WoHwQTNjN+0eMWFOyQZTHpHcW8+pw6+4YVXBK/xT
         mD922kNZMwZKAn52n9iE0MoEEso6pwPkrNgkDMCGLIxmIcHREPjNEEHqSDFXAS0SS7z7
         VJn6Rd0ckQs5jcC5JG2CQmCAFgmGCvQvp+jn4OIzXbTjNZSu2QKIhz6cbY5RloGZIR+H
         vM2Xm1XsXVsaj78CV082ZyMbQTtYucF2ZfP64AaXMo5EcWwi3UOdsP2z7irygXf45I36
         VHLA==
X-Forwarded-Encrypted: i=1; AHgh+Rqb+kdfx9n9dd6U5WuhtsRKej/oNFNVhT+KpkSAzeUNKBYloTth7CgMM3iMBfIy1VIe8Xc/Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/qtyied3+Ehp+7ubHMX+oAuE4D3Co+5Nr2sc5NTjXBkPHrgs8
	f+IveDkqP0BpB9oJSghOYdCZJqu7jo3LieCa6uIBIqv93UdxPhS832gj0WnVKBpqZMJSIV0li3/
	Xw4O4wnNpR3/895hSvBdVQgzkJqw/DldKyzN4yHfnMp68RNPzqqajE1VnkQ==
X-Gm-Gg: AfdE7cmkB4zjy9RxZF5Kh1Sr5EY2/Mznkhk7rifM2gcu23tE9vFNPGia2vMaKaxG4XA
	IilAqFNlxdfI8CfgYs3b+ITTpQSweDJ5a5HLEzncDZc+Tmt+3k47fER92ohRg2/8R6vGLs778c9
	ESs071ApKAuln9PVpReKZ5ABanu+zj0GCFzLHCDeGhN06foKPtJ3+7AVTCsN4kaLcXSfrKInUre
	0wPpbyDnWTgpL0nl5WEWktphajyYHg03BmOSBJle915kO3DbEkNP4OjDePDdSlhMd0L1fuG+7k4
	eDINwzI3p9AntCcEyD09upAZt2vf6uhZcD1oRzy/Vy43QnriJz6JFpn1+LxooCQr2+cVO5Ep7i4
	0AVwwW/WdFrNlZXszh+uyWJ9jVBS/lUoaKik=
X-Received: by 2002:a17:90b:4b06:b0:368:ed26:15b2 with SMTP id 98e67ed59e1d1-382807af3c4mr6120325a91.8.1783238473537;
        Sun, 05 Jul 2026 01:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4b06:b0:368:ed26:15b2 with SMTP id 98e67ed59e1d1-382807af3c4mr6120271a91.8.1783238472790;
        Sun, 05 Jul 2026 01:01:12 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:07 +0530
Subject: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
        Qingqing Zhou <quic_qqzhou@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=2414;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2J3wxVNsY4ppAiRVvLGUwPpm/Kmj8pqOhBbdF4kY2vw=;
 b=k578A5/54ikUDp8kLnqQMv2fOTlVQ7Xm5nrGCJ4mzGkT7xA6MAy/zLB9vcpg4v5kTvgvtBoGk
 96g1g8ZDfYUBT5FeUIfmS4ddkZABbHayBtPZcgQ7p3K7fwb6+/tGgcM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f4a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Fc0Gm5DqoGK23V8ocAS8Vfx3ZH65tuan
X-Proofpoint-GUID: Fc0Gm5DqoGK23V8ocAS8Vfx3ZH65tuan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX9jkEkxhoUMzl
 gR7Y5BRJLdK9QEgjuxyBxXtAh34dJuCRa7p84pTVGFlxQDi22Vsl6pcWp1tTBnDVnq64ispknjM
 UJE1coLu8BndgjigsoSJXbBr6hlVMF2QpOPABsqZ/ZBR/bGt7epxZ4HnJxoSihV1HWhXwuo5BRG
 V/rUhvnEBW3JGCc+9YNvsTH5klxlrLc+Tkl6/4Q1UQ0Iwy0CN0pEO+Q08OXVCIDp8XNscx5SxzJ
 0eI2ubQKeEv5dS4pKC8ALyGqT8fpsVqSmZiS/6V3R/Lxc12PgFxcq1n5VfGyvtDgz/NNVswLBTg
 2u0K81u4MsGxlG3JzITVI2ZBtlLWpD5JP6WYyDlMxpIaJtqmXLiFMlIv8XGhECu2Tgxzs3LzFHe
 lilol/W1tjMdby+gQ2s0TkdJFgW4iF3zR9J/6CafyOKxWtaW4IQ46LCDY6bFr/IvOZIsvb7Pb8X
 JSRxpMt16baLc1X7vjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX+QVLyhCd7kl4
 Q8VQ2UnF4IMmAZVZ+opFY6D11X2V4iZlWo8c/zOlsRsP8vDX8M9NOISyZxBivJDHXcS4rZ0n+jZ
 j3B8ZNxxBHOEE5JFZjdDIbc26tUlUg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for kaanapali platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7aa9653bd456..19eceecc2a19 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2601,6 +2601,49 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,kaanapali-smmu-500",
+				     "qcom,adreno-smmu",
+				     "qcom,smmu-500",
+				     "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			dma-coherent;
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+
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
+		};
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.54.0

