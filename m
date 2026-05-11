Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A40383303
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538241; cv=none; b=dzTPNSK4rOc7S3/bKx73rHCZb7FPdskwocLUOlOuqR3ocLY70yBwh77RKBeK0xPNCqr5IZ7Ysu7Vl1UOYtyiK9aKFmWdvlOI7tanipARUQy+HqYSPpNUQUckW8/UlQZisVm5KI7HmrXaevGAohOGyjnEQv3+DyljlRVwlIe7Xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538241; c=relaxed/simple;
	bh=E+1GLuDyRo5xJsPchj6gbw1ljk884w3Mcmg6k+BHHl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d31Y1J8/npjaibu3eyEQiGoyY0EXSMP92Q6vK2qzHkCGkcFhmR9eLSYufOWU24uEV4X6CfKPfovVbS2j9gFvxmTrXREQpa0iA4XOY4tGBixn1882JFRH18gUBHQ0bedQkzJJTRFDtJ5GxqGug3FaIFnFby3yUrK0mJqHKzk/gAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b3DMw+w+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d5AuNr9H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b3DMw+w+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d5AuNr9H"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6REE1183975
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=; b=b3DMw+w+N/9GxBUS
	1NB5SWDv4tBz7QN0HA/VcqtKp0QGd1l9LFbuooFJCjvq9aMt98zzNa5Abs68fRA+
	cLQZTb+XaFkeRQxPHcl4NdKM210kU8S0xUZ4iJEssut9MJQ628Gew+i4YvfoDjeM
	Y8EJdSoIkd30D5tJWHr183dw8Wvr6CqUWrvfcMHiK/E9uMHeiONFwi3QWlDh+Is7
	Eymm1a3jPTpHYJOJA29abjOuEOcrMjFA6lXrYeacIi7oDfzfsLnyNKItau6eynO5
	QtFHv8YxboWx1SDVOQCM3rhHqieAqBbbmf5sX+ooEkBXBvzprMos1nFXtRGcA+ig
	vL1a4g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy8fkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c827c0aac70so1215606a12.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538239; x=1779143039; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=;
        b=d5AuNr9Hu38kAHRW5jQIpUQ1UKwW0iWQJxoixN8N942indWAjI5bvDulvRAxr6bLqy
         y82XPeTN4BnJG3pkqLAUKcq10bFtsRDfCLd8zO1QWrs/ek7atTOjtaaaWa8V+lNEvZqJ
         cSDo6D6m9EN1RR1Unag5DRM6YSwir1wucvBTKfd+f1/6TBVHE2tBELvhG9braYcWAt2L
         1PoiCb+nnztReDhtw5HyrY6JNolA6dkqFkLTI+X5Le/Cv72YsffhOF61sFs6Uh6KQ2s3
         T+JwpBZv/55iIyzIB+WMO7x0RDGAMNDcQWwtZ73tddYNj3sCO5N9dtlAa298zGClVUtr
         bIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538239; x=1779143039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=;
        b=qlMX5jc38zYIFBtG2j901xMqG686rcuclPpErRqal9DRADV19E2MVvX4Dd5yHYzuAR
         t4jN9I0J444jasao40n+BTOmghXcWBDdjjfvusx72VgGViuqoKZe7Ro48xCLDoMwR5Yd
         vduN8V+OO00jR06LZJo/MoHLSoRIuPdGG4MFoQZjkJWiGlPhJG6CKMtawWC02G+5SNIZ
         0UGS7E66qJ20aZinYyeQzymvjnY4kPYQO3buYAfkRrSKfzUApHZ3anHZd5Yj6OKvskVf
         /m1p9Pc3a1nGzVrKEcqtoQiDLEC2A0k/9KF0BO9ruFuzK1zNPTJtRy7ugCs0h8Rjrv/E
         64NA==
X-Forwarded-Encrypted: i=1; AFNElJ9HImEGYhMV5QOceGy3DP06it4+NDwMje7C0VG8iM94qNb/BKQXfUV/ULPmsP0SzCvsQxRgqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr/8AFjWJs21hTDy8AX8pO6OLA8zOA6paVjQT3Tr5s0o/gwOGw
	4i15b5JJMbhGfHH81nW8CxtS8SNQlNFa6MnrqOU298EWMvI/zdPXkBBpgeDV7dd4S6PL0RmJspn
	d8M62V1a59Ja1qbU4C25/UrtlERGqoszMWPOP3sWgn7ipWpTkkVYeziHwug==
X-Gm-Gg: Acq92OHWoqD/SPaWZRBOBJzJ7d2Fy8QREHB7zlrRzf05zkUtVSwOifRZmbJyo5lc//U
	XznPnQ4eaxR6GHFrMz4RLqFZFy9CYxraD47HKB4FAz9OrXN5Pz9IqleGWxLKaNiEyT0odOTFp9f
	yU6F5koNPW8tHn7BAizH8KkDSe+NW2b/Xyjtvrd5KQrNwkqt7ax8X/sk+mzrBP4+2q8N+fv6KGa
	4GTXXUB+omtb6gskSas7iHK4rzar2hLwPLrRsSTwf/C+0RO9+QtjHLrdw//ff6sca3M+/qgQn/4
	vMq0GRhfUtt2D98GiQBXYWHicEXMLaRE1YAb8heISCchrNMsRMhl2JhOa3QNn9utnEc8OwVQUR2
	Ewt71W+r2QQ3TPaUulYccNXYFG3tOhwc4GuxXbp/a4jmkgw==
X-Received: by 2002:a05:6a20:9144:b0:39f:c93e:c7f7 with SMTP id adf61e73a8af0-3acc3538b93mr1274547637.0.1778538238645;
        Mon, 11 May 2026 15:23:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9144:b0:39f:c93e:c7f7 with SMTP id adf61e73a8af0-3acc3538b93mr1274515637.0.1778538238163;
        Mon, 11 May 2026 15:23:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:23:57 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:17 +0530
Subject: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
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
        Qingqing Zhou <quic_qqzhou@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=2262;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rscpl8C0bBlWpsGZRfQr8cfwna3yHTFswaa+FyKvunw=;
 b=coHh6zS2m9SCj16Gzyz7t9BkZ8HEBuHE4W4uPRbQpDal5KptphD8Sputqj9jokSZ2d48QX9E4
 JAbZtSW1QrVCU4M5AZnST+pgHSljyAF0noTa/1EOUAF/8SwP5RojBAi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: WvITVU68yHnF5Ujr-YKr2gB_5EMPR5wI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX5eAHhMHlij1B
 NYF9LzSBbE/C1LbZ6a+RH3zQoKi/8OQfIwNApvGQYO1LNLcAh0f9xmXytTB2fgJmruySIlIKHnq
 ZFWlSOXkwij/bV26rHszPA7B8WvQuipp7I1cQfvtSfgPBPS20orKXjUfAEokWJBTyNxjbhW0RRH
 sgAqOwMNO1bjR/GtHi7czeY+sv8OuOeNZf4wnfteWaRCUsgVqVPZzSXSjmkp46rclV3C+GlsdpC
 WUySJUNZpOQT+cm9FJieuCFkPIxK+PW4h5ASKWgLnxQX44zpZwYYndcPQ9CSkUIKSXimTBNSxiB
 qsn2vkOAgHafNYYCbKY5UFknyEk9R5eRw1iFpo5xhrbREoV5opPVosL5PZdA8bKDu0fZK4m+8Cv
 xpT8vaI/bhWBHTlliIO2nNKZsjqefIFkUuoEqacTc7g3ScXBN4fgSciwdaiAiQWA9Gp4UBq/vlg
 3TwZjN5rZHktQPuB2TA==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a0256ff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WvITVU68yHnF5Ujr-YKr2gB_5EMPR5wI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for kaanapali platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index bab654bbd6d0..26a4de9c8d45 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2597,6 +2597,47 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,kaanapali-smmu-500", "qcom,adreno-smmu",
+					"qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x3da0000 0x0 0x40000>;
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
+				<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.51.0

