Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C3569F3A
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965921; cv=none; b=Id3A8ZVVaRyGjDD3nWEwkkXER65tySENZEp4fTn45MWhWQhtDvvUVv2oIDpLTaY1Sj/2czAqOnKZo8xSVCTGO5aHRPOl9wrUk0mPw5tbLRkyEjduFHRV3exLzsFY40pYYWiCMSpMItmIFX9cDSI2HnPT+wRwKp9dy5eRQQmR2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965921; c=relaxed/simple;
	bh=XwODhyna4DectUOuJ15Yl0Y+2tOgaMf/Hivzbu9xLq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdYFEkl2yIPOsuh1zvXUyqGU3jaeULd5MiMaLlSV26opSp7cb7si6hr23Q6Uz09DTx70dUSDs176K/sD9TxbUo2D8NeMMRZzZRXo7A0ZtgA/AFnJUBMuF+kOq8ciRyRv1C9G2ZlfGtx5hwNdzpr+ItLwI7t6hGoNPNeJFsIVxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvupkXFT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkWBjcB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvupkXFT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkWBjcB8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUQ0o2376525
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uEUvJuRe81ULO0YbJNC5/wtMseuRglyE5RYVVpjuvu8=; b=PvupkXFT9qCn+/i8
	eLU929ByApQPZuJV3MNCr8m9fPQ3rLqM1grC8ZIoCBv6zuLDHIC1Pxa/v6XcBo8o
	xcLXfFR2DNq9vfU0MOm2dD++KMoLKacP9zelACFeuIE16WwWOHxv/vEllSjMIX0D
	jysB7WK0ZdH8GYi6v5/K0/lIytcQ0ZDLDt42LQ8zmerr/8emQqqnvncFJZJgGvww
	2Fja6f9q3l6XRjB/FE0muNMwU8gV1n4VSM2cAoAfXRmoF6fPHRCzHO0TRsx8surr
	pGzaahyu8xd5UF4C+XcCS5G7LY8T25B/ipur+riYua/MDyVRIlmsrzt4F2iITLWu
	sB6Mhg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru139u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088203so6509847a12.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965916; x=1789570716; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEUvJuRe81ULO0YbJNC5/wtMseuRglyE5RYVVpjuvu8=;
        b=GkWBjcB8TLqjfAR6dgQlV3MiNSZ14IeCylJ60YfWdOy0hx2diveyURSsoMFILY6Cwn
         pitWMcKvKcbfiWbgbmUwshK0UhwnmZKC5B57FQtrYoyZ0pF1DU2g01vwnCvu4E3866i8
         ZnkTvgO7w7+nrehow+NX5Pq68wW/9+f0NkLKM1xDoZhcOydY15aLapXDRI7tJA8HTs/L
         eSuqrj/+PPDFlRgjJCc+7Vi/pabTYD9PThz8zy1tGtgNUtvHHENH0nOhXN8ksui3Y0D0
         lcBGy8KWi0cbSIQ11Y5/ZNvUpd09TAZXOdby+en600WVdQuAXfqNMQcYQYRz9B3FrMSS
         O0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965916; x=1789570716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEUvJuRe81ULO0YbJNC5/wtMseuRglyE5RYVVpjuvu8=;
        b=TV9SyZvUjmA287o2CSJ5H1W31AgxFU7GCThtYXEsu8jZHa25fD05WmD3Et5M8S2ZMH
         MuoIR1fjAWDuNtMsrikyB5Wt3Ot4+PocEZmfLLfqMkndI9Z2jxWktXMNBKkwovOfhjAw
         8TD3GMe4L7kkll1jqnrBwbHCgtlgWjwfc7GOcRrfin7dLzfuIz3JF+V6QZnr/8BWn6kx
         msjR4Tkm72aNtztb8HA75dEjeRn8QAhZ07O10AKd3y9X79Syd9NI6n7fHFbrYtaZtvQM
         KFywfBhMXYCasCkkPXPM2NQKIFDpMCDSFTqCwuSvzjZIhd85thp9Z7DRAtmQdlSUjrzf
         +r/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw27ONp35nb4aykTwahk4+cphGGR5RP33EN3X6lWAXxtMYHx3kvsPi2PI5DKIOY8cQMIpc9pg==@lists.linux.dev
X-Gm-Message-State: AFuF++n+4QehdTXjaXucKnk9E46anaRvt4Eso9vc5tEELuo5u7Ujr4Dt
	HQDO0j/OmdfduYQfwislhJwCZeMHe5CKB1y4CfcM3x+MnLLHkyqkwHFpVHm/Xs8NwzZS6agVXxh
	MxpO3OSFEq0vMMlFPWvdHDJGcrkcCIUbc2ruNDZZ6ylg7xXuibXtkbhM03w==
X-Gm-Gg: AYBFou2jWnX2dVkBS5Xm63If3xcqa5mV1tqHGGlgAxc28xCWQo7NZowyuywBnyJ6GAO
	VpfVN+VQlZDNN9eaXv80LTfREt89PS+//BMw/tGq0SD5Nq3XLtVNyRc2wqkJTVWfjhNwnStOngz
	lEWyGVtE5cPqlHmNeBVsMZl5vMSqGQW6XEKDMoHU2KppsORWRd8pepofokQR6hojkpG6tBvc6Xi
	JoXlJPJ5PtihShqfrQnZuu5WLQqjKc+DrYrZlA6y7C37YvKWMLPWaLg2yet/xvQ0X8FhwG/OkSL
	R6uqXzaQfmhFg0gEaMvhEi2n0vivdkKxWQ9DKQgbZrKseYze25GMo4bDuBC/pkiHrlIJWbSRDGd
	fVEMCvi2ofS04CtaOVSZ3azNqVVa+35tEp7U=
X-Received: by 2002:a05:6a21:3a4a:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3da3a1ae36fmr67066774637.21.1788965915629;
        Wed, 09 Sep 2026 07:58:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a4a:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3da3a1ae36fmr67066676637.21.1788965914958;
        Wed, 09 Sep 2026 07:58:34 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:34 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:15 +0530
Subject: [PATCH v3 08/13] arm64: dts: qcom: hamoa: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-8-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965841; l=3447;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=XwODhyna4DectUOuJ15Yl0Y+2tOgaMf/Hivzbu9xLq4=;
 b=+Mgk1YVXnAfOHtB6WnDI292rxl/A8NZEBjs0G0DsoxAHeSyrWsf/bNAxQ9J6IpJ2vjnsZNV+a
 WkiW01zRpEkB1NO5CKEwut2LCHFRXgvaJSgOLrkWPzOjCDlHYXwYm9a
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa1741c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=w7pRem5UOBajBC5HA0sA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: hFBcQ4b3hnn2nk-ciyJbvodHIjSrk-dp
X-Proofpoint-ORIG-GUID: hFBcQ4b3hnn2nk-ciyJbvodHIjSrk-dp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX5Vp5R+t1adt7
 EVJSTGJalsr3tsdB3sYzPdk/Z9/OF5nTybLhodU2Mmf3YPnviV6dTsVMaw/FIwkvQ8qPhGtHq4f
 ZCK0rY2xn2G3JotSpx/7boc6VPvmJdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX2LpCjvzBMHHq
 mixZMZuV6hd8lVzhbwmE0anK6cKRBsu7OfFPVYnu3mmdpVHcuQV4/E4DZ57+rXf6+zIGyz3SRYn
 NipGhSE5NKR8rvXWaD4UuUHceABqmL+ufATLNa0AnGIgMNfLaeytVz0Cd5aJ8wtSaxCRZETLinD
 sqxfML4fY6jPWA1FQytcf9YWc4bEwtyWBnVzCHriMW6KLJ4rfuIZR3fCiKNTdyoADAnqV1p4P7x
 kRiwQVZ3ZZzveSMoaQQYbGEkTkj9TLRonm5aBkt/83k04gmXP8YwywHZdFiVfQD5TJcXKKdA6MT
 0I15g+TMXpafjo8pzrWVtTEOn1RDo6uQ2tIe4dNk/61c2G5PNsgcWDe65G8Aw6ReEqiFnjEKHfY
 wjoiGIjcreF37bFxRz7NU2qjZuc5uuGKc76acl47NBYLwZfnqzLgmDaiBsyBAhO431yQJoUxuF9
 eQNfiCXpA5xzYFYcPNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Given that the address range restriction is for specific VPU stream, it
should be ideally be moved to that stream. To achieve the same, a subset
of streams is now represented as subnodes, so that each can be
associated with its respective addressable range. The design was discussed
and agreed by mainatiners here
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org

In the past, this limitation was addressed with an iommu-map approach,
with the iris driver dynamically creating the devices. That approach
was later concluded to be a hack to avoid having subnodes, and was NAKed
by the iommu maintainers. It was discussed in detail here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

The video-codec node includes address-cells, size-cells and dma-ranges
to declare 1:1 mapping for DMA translation to the parent.

Tested-by: Daniel J Blueman <daniel@quora.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 5e92645c5c3cd7f2491e8d76f51f583fdb34c98a..e1e0b7d91870f383bb5213033a34e1dc29595368 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5463,10 +5463,12 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 			dma-coherent;
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable on boards where the proper signed firmware
@@ -5474,6 +5476,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			 */
 			status = "disabled";
 
+			non-pixel {
+				iommus = <&apps_smmu 0x1940 0x0>;
+				iommu-ranges = <0x25800000 0xba800000>;
+			};
+
+			pixel {
+				iommus = <&apps_smmu 0x1947 0x0>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

