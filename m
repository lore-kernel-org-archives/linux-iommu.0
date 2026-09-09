Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3756C643
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965935; cv=none; b=LdRng+9lNCyQJ6aNp7IN9CVn6MpuiClCcFL5lrSC+4wZ+ica0Qc8MDKBlfQfUsjZ4DIq5Ho7hhGyz0EVn6V2wg4TRskBooUeLMXLTtIgzKKXn96r4fcbbo/eBG+R5/0TP0igRul2qCBqZ4/pp+rbwwuAd8JWNtEdPtnLZQZGPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965935; c=relaxed/simple;
	bh=nYlHwC6PKpfUPCQFPEdwMq/Ct3VZxMxSmtdDkckeGT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpR0DbmafFvTXGsU8e2dc1KNWkhwVbmGPyoqlGyYYjp5q2hyfZbcI0xtMAAiaW2RGios0u/XabatABHWE6rvCH8BBsmvmKzpx5e+1ecInS+oZBGWDFjDC/xLrExydzQjl9zgjs08BHJWqueWRaQVdk9uT30Z8hZo8aKgSMOUPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqpS/Z1z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZcG2G0nY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqpS/Z1z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZcG2G0nY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUBAE1723429
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P1NS02MIUiZWRkHxOc0gR/eQgS1BhxaJu4QXKOfECR4=; b=VqpS/Z1z8WzRIEx8
	TzAM0QfQkHJ2p0D16mQgfW3fsApDBvZLRr+DCahCxyEkpFq2Fh4EFJ5HrIroDBXC
	23q9mJqSEeDfHg5qmOa2SqMz5EuMEuhgVRs7fGzswNB0jkJAvPzJBB6XB6hylxQL
	GJXDSygRwxwy1NpE5uucNJiVeOdea2XcSYbJljmF6oVpV4Dm9yKawpvCab5l2++P
	agNz3MU0SxZm0tZa2O7+28XOQUTtE3hBqYHWX+EEA+Ip3ljCIVnbUmPSasPe726Z
	naFEKThmcz8iHv51YdBBZQlNDM+vFhhPxGjl2YnfH0V3GsPzc9gx8qz4w2hs8xoq
	rvvsQw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cns735-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso10677143a12.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965931; x=1789570731; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1NS02MIUiZWRkHxOc0gR/eQgS1BhxaJu4QXKOfECR4=;
        b=ZcG2G0nYXGU0zxSyZ4mDb5zLF3KoFRxAZko+H2HyuGm83bA4XVg76MU7odXPZm7hUf
         n9MY7mbaTCbEbCNBEzPtXJp30thJe//+CaZCRAXFBQLag1H/8vbk0ZgCaX/N/TGvyzN/
         t7ZB3kkAysvZK62sOuR73BlRFKGBaumrWeSgpTcCDCbBwxDK1irySrd/nWvB03G/KDKA
         ZCDvxKEXT2WIvMVdQqmngpG8zY75VNcV+Bc4o4hW9geWb+AKSN/DiUKJ31D3F4m6N/fZ
         AgFBBgYUk9z46MX4QvbEVyQ1FrQm83VxcZXjBaHHpBJ3xxIYc6ROJX+bA7oHXH8m6e4V
         rlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965931; x=1789570731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1NS02MIUiZWRkHxOc0gR/eQgS1BhxaJu4QXKOfECR4=;
        b=omIm00/fIYBxOC7VfISJSF9P+IYCdMD+YLCj5euFiw3rXGhUoNxqwxBgAzi+Ue5lVb
         CBgwMAwikRyG/5r9I0hnT/x3HPs4PpFh6smwL+D4raIGloYhVBOkmKpoqB4ZZTJi+GbU
         srQc/o5RXyAw5N5903XL/k824/xh2bKj7M7TyMkHRFguDr0FGGZRhUKw3SZwv6zoK7QF
         dDsmE0evn1EVNJWeRtV3d1r4ukZxA5OyI2zVBMsfAOcxlpO109D5UL1fFsK3o24jP+a/
         J1030ygZ3qqVnn6PpN/vnUIGblhuUSwN/QVLtv+0B+lp2MZA0Ahn//iPa0A8+LjECH/R
         I6Jg==
X-Forwarded-Encrypted: i=1; AKwUvBzEY6E4uottKYuSsZ4oflZNRSIZEaUusGhxokTzGGcfHVvJ/OixJh56YB/R4ROs3XNERodABA==@lists.linux.dev
X-Gm-Message-State: AFuF++n2FrTjSscGe/cZZvUbKZpFXdxuWpwM+TpHUqFzyxdhX9HVess4
	NpMLRaULN9uPERUXZhsV2jGNkJyUipq1XEOdj8EvBny9VK8qCBVX+wkA/Zi37wJ8ckfjYT0kVnr
	71VRUOO/iH1TXJeXR2nK5SFJXvlTc6R2RlHP46uFJsTwWZEeXIgoUgk/SoQ==
X-Gm-Gg: AYBFou0/RwMdC5wli9i7tDArr4VxIYVBwJAPKOXPyFYcY5BEMIjhK8fhn5rx4XVrI42
	qgG7f3hdZsNJGVaRUESAW69nZXdz7eT9z00pe1Uh0Rgcflf7GN/pN4tWXZLrk8xryltTWmst8T4
	l0p6GFjzcamm21ZbpbgTGQLTYPF5om0lDGmqNuR/WcEmwBuqbTS6nP+ejzsV9+VmZ726j/Llv0Z
	fHhAi3/kwz+zim+MpYLvkF8Z7MDOhPDgiU8zQuMoGmGSvxLlBfmLaTu2LSyZw+DzalXiPrQvl7Q
	v473p00mzR3l8DvpLydvFV3m5vmc8RjsXHNtYH0TWS9WJ/FxkNQB01nGiDtaUz/EW46K7pozv6h
	yx22CmBwFBYLZLt1r32whL4YFQUCuUkZPk6g=
X-Received: by 2002:a05:6a21:32a2:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3da39d18cd8mr53688414637.1.1788965931391;
        Wed, 09 Sep 2026 07:58:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a2:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3da39d18cd8mr53688366637.1.1788965930967;
        Wed, 09 Sep 2026 07:58:50 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:50 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:17 +0530
Subject: [PATCH v3 10/13] arm64: dts: qcom: lemans: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-10-2fe43ae45495@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965841; l=3265;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=nYlHwC6PKpfUPCQFPEdwMq/Ct3VZxMxSmtdDkckeGT8=;
 b=TJg9jPW+LtEtoQPVLGk7bkpFtL3R6/FJZVqPXa5SHK6hi1G3HPDBiRrVpSEykLC2USjw2SuR0
 7usvYl/9ejuCaFydP4EkjJpaliOsB3TSM0itCPBuuWLWfJEF62LJLBu
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: 8AMUo3EYXZeviJEBoLU4C2yT14HdN9W5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX4Pl6VgbnZWTH
 aVw4xkbodYS7R/6t9/qRPuDrWBaNF/5rLmcBN28tKyTmatsmsNRLBw3k3cbHMuTi4gnjumRqpUl
 2lF7aZk9aIWc8z1p6P0aXujBiQM/vU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfXxjRg2NaDbmhW
 5vnmXyB34o0NUtalujj7vu7vvVlTHDEf/CmYf7xNbAHdTw98uuconu46wGQIEaDA23FogjqkLsG
 ZYLahtB1UGKGlsOd/JDPBE8F/IRiJbjP1UoM0oH0+gM76RYDx6BR8HYpHT6aikdJFeuIWqDbPlG
 qgr0gytCWkajCP6elTjzSkfelLceea7HpTze9hnnPWUJkDz+T7WOe9cA2juuqUFJRNuqVHj7CP1
 ppW85+sXxUj8g3EwLPbZd8KXMUeQqmaRarwe/7InP3rxq8bBY1pmGz/F0t7O1eDS37xPt+u/iAM
 2AnnWHjZ7DThOqR4ALQxSk3MdTQ3rl5/UxNuRzEQ7SpE8gHKbCpG0diSnK2yZZDr0Rg2Kb2xRjF
 jHu2Q4gw7YU+u+4XgNsp1j74Ao+gEXOGYBfWs2xu3Ak5dxjE53or53a+F/G4eGTelp0vZ6y5TUy
 2Dw8ralrY2yywBRp2gA==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa1742c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=w7pRem5UOBajBC5HA0sA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: 8AMUo3EYXZeviJEBoLU4C2yT14HdN9W5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

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
 arch/arm64/boot/dts/qcom/lemans.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 695eae1b7256911e656ab1ecdd92aca135d92f39..afed5e43b4fcda8b8400e815d24c5094834677f3 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4962,12 +4962,23 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x0880 0x0400>,
-				 <&apps_smmu 0x0887 0x0400>;
 			dma-coherent;
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			status = "disabled";
 
+			non-pixel {
+				iommus = <&apps_smmu 0x0880 0x0400>;
+				iommu-ranges = <0x25800000 0xba800000>;
+			};
+
+			pixel {
+				iommus = <&apps_smmu 0x0887 0x0400>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

