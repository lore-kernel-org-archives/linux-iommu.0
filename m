Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97E340286
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320965; cv=none; b=TWi6EgJj+DivlD6tZFYd2UZW6Dz8F0OMeRT1e299SDKYlLQ3zFmTOsGPsThZCT4nLt5NsB925EUghN/O0ZiIhWQM79m3kTukqWZBVxiLTSC4GB/hWDqFxCf3vOmKHUgM5/McZj0pcLxqBg2jVZ1or5jkODVdQTw1I+i9qwEyUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320965; c=relaxed/simple;
	bh=VxVfs90+RVyIFj8A0qDzTyazRfecJmozpZRL0X2Homw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBbyDcE+mYyTtZmjIT6P0gpy561sPWet92uOOuqPa6K/6TamdI1rfdZDajM8fPdXltSefddHXH5OIJdk3S3jA8mFBZjfwKwC4IFhHcE+/qxW4giBin7VqRjQVmGTF1Yr7Oa74Oj1Uxs0VuQ2/C474RP11NR1Qfrn94h+KWxD5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GD3fzSng; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e+QHd7jm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GD3fzSng";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+QHd7jm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtig82780733
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=; b=GD3fzSng4mzaN34w
	lyG3oR0LBYUx3m+Qt/0ZhEE4VliGMDFm6RGxkvWJGSIITjX0E0PIklvvwsPM6VH2
	kazsXfSDaTgjfy0QA0mp+cdKHIegZGn+dKWdOUtkksdJ6EESL7y1JO6MHn7zmnL7
	sn7zeT/ui3A60R2MOqcqLdahw0HdPzn5/q3ZGdaiUVQw0QxcaELNswEc1Keb8wWh
	PYvfue02YKfPd2zbto0SUbUBpe4RJRJGlWFhIHMatbYBdq1KMPdYE8RAqCeYtx9o
	J+kjitAFjiqDO1dexz7SHzgKYcnvP1DPAHd643M5Grm+4UrXs1o7CSOceq9ex3ha
	U5RzAg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu98h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso4947316a91.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320962; x=1784925762; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
        b=e+QHd7jmFFuLnDm/+kNTUnTNX0tZdiSKfXZ4JZZHMD24WHvJu3ENHVkzuK64fjpGt0
         x76r4LqhZIPSxwBRJC2dYZI4WmkyBHJC7uWR4i76h/LfWmTZfBp76ols8SX9Lm4ZDlUH
         DSwWQ7BCEwfsOy41NC1L6YyyolBbvH6fBi3dOvtLPG+hwy/E+1wwC7atB2kITpxCGieS
         T4g0O2FdU4Gxuu5n2K9nLmanzYrPcsUKhdZSgiw7+jmL8bwshJ6KktkPr7kOAzDQmXcV
         zvtBLBLo+K1xl0+6PkXVHJON9Rk4OaiquFzjB+HFRa17kQwjQNlIDNNBzXuOK5QVEwos
         8qrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320962; x=1784925762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
        b=gfF9GGNOci9llK3vZ+f0tcZbxv8Ty46IvAhRYTDuXYHGQRHEJ7K7Fiq4LXAMd1Td9N
         d5Rvg8oBB4Oq7oTdQ8U+ABcjVersmQFrUNU7fF7I+4vy4GEvCocYpSZgzLRKmVrOPvjf
         cojyURuKy/DKj1CMD6JH0A9nKIKekqop+hLE8zsUAMe+WBEq0D1MHMem3DPIX0C/Pu7L
         fnGJuKAVHivg3PIyodUtm939jS22YCGFBew0GdPAx2fQDggRXs1tqwoFbON3BHq6yn0i
         hewcPk+IgQvYNjE2wC95fBQqW3TwMS3mdtZbnWJBNtVbWxZffjVczV8YoMnS0RSZXZAe
         TOAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpo5hls2XZf7EtOYJghrdgpODs0SkwxYDdBxHcilsboL61EMDua5QqKDn8dfXyn6ABqKmLYig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4OS0cINdMfQ2QpjrGIvT7Ze3pDppvirU0MFLAcCDBcxE3ESPV
	bdLrp14MqoQPXoaG6M8gKfYAjxUhMR/Tbl9/cWkYclGzd+Nxn+IAx15jy9Fwvj4zDquTu2wCm5J
	CJedbSysMPEZaJUQy/YKaoRq4uuewdyUKRln6P9m8GYba3JHopABE7MsfaA==
X-Gm-Gg: AfdE7clSnks7hxzywNbWeTTm+CYjQFCs4OsiL0FqWDKvtvYcEmuaglkGrJqcNbN2Z7q
	V+KjZo37T1KzWQXd1yjaeS4xTarV2vNZq8CEhM1Nkmc/TzswETvWYwOBsXDKlQMQ1z62zqD7R55
	D7Rf9hr0S9i8+iY+sP/7eoXwXYaG0Se95aiVqL/E8xCLzboom+aiV/6ncjweM4MBOfRdEAZjzVZ
	zlUHJOpqiqjaCJEKQh6hpR516BowfePGUI1qj5hybgOPN+WZG7TwLMVhGpo5kl5k4JSZRKT0qvj
	Lr2KSl+6tL4jBXV/FpFtMVOgfzXw5udfCiU2X/sHs1vs2FS8OHK18ElHtwSTB8vjjwouQ5T06ym
	2NzXFQkT186GT3ns6jcgVXbRG
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr4149512a91.1.1784320962254;
        Fri, 17 Jul 2026 13:42:42 -0700 (PDT)
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr4149477a91.1.1784320961810;
        Fri, 17 Jul 2026 13:42:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:31 +0530
Subject: [PATCH v2 6/9] arm64: dts: qcom: eliza: Add GPU SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=2286;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=q+INaEIUNj0EXeDmcw5Jx9wg9/Og5BIcLTww5DoAVnA=;
 b=Xr36ABXncw9ToqIETUKiq9f7DTuutD8YoPX7Fr09ffFks3kKWGRv7D5+Z2AlU0qI/PcuMN7JI
 vyF+B9p/KGSBhQbdfWh2JQz3GCVlOhZthUh2mx0IpSvMqUeKCWSYaS+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX0GB958TzcS+/
 DaPj2f1xoCHMWq1c0oYBY7KMgMUHVmMKCac+pbKng9ENXgB0LtHihsDv5xbihROnhWD1J8VcyfM
 aWaEYisdduMqUnnutNdu3tH44qymYkA=
X-Proofpoint-ORIG-GUID: 2zuwiX_De18yzk2vhTh7W8-1g27BJIEN
X-Proofpoint-GUID: 2zuwiX_De18yzk2vhTh7W8-1g27BJIEN
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a93c3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IlPRAfYEAefbqxDJwzkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX+HeaPvno3d14
 yx/hxlqhk5V6nSx/Sq64Ri36EJ01dRU+abXLLI7UpbTMGMQzedvrETEaJSfzcPI+hieSGlaMvIa
 u2Be3kJ9ximYE13VVTOXtQL4aFSBHvwkEYydqCuDk2z7GF+Ce9R9lSikMZbuPElLKbjzbt9Hc9w
 bAC2yjxNyjcpmmb5iy+k968oOqCXAysfmdZ//kpkl9ac3sqjmVaaYm9Bsd9TbNaBXa/7vhdnBZ2
 WImdi4BgOm+h0VLpj+2Q5Lq9+yU+V0sQ9Vkz2K2efAQzT3apWu2d5N9kTCh10OHvascnDc4LnR6
 QeCPgQ0TUttpyLoyP6Qp+WHtbiXw6rZ/3oMW/vvkI2YCX8+PKSRP6vRSkmHwvdzu9ffgYftRT7t
 oqc3L4kuUwzLjkFxIv2wWfF30V1mLeAY/kxZ7ymR1rzncqPRUCDhVzxWlD1ZxT5wvizBNmh6LlA
 VZzuEEffguknq5PvQ6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170213

From: Abel Vesa <abel.vesa@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index c5635f22e2a7..e5b8377e6c3a 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
 			};
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,eliza-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.54.0

