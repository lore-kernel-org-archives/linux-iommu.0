Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B243FB06D
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325469; cv=none; b=KTMjgylIv3x5jBVqfPuc+Bhto+s1pk1c5Cm8YJfYjgz+ACsBAJlz1JmfXszn5wgfAysKroAkKUx5y/aHelj5F2bxq5Ae9j5rjoq8WfgfrFC/lPTUmQblGfOBy3psxLYUN9xHfq1YB0lBV/wyzBlFyxNYb2Lve9OK22GqW6Pefkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325469; c=relaxed/simple;
	bh=hSjOhcc48OJghLc+5hynLFQU9EGrwxyIHApwVUWJDT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+HxZxtL88Bc9ULX/GiOnRv31TEy6JrVJxog4RJEatdKCB2he/HTzG4ohWetxbRKVqtPWpKV5c7PPrhyfv1H2pXgfY+LEfH+Hcj/86pxtWgxq7jjda+PekEgvkGpnGz2zIsy1vWGdhReJnRbpru6e1905mvpfNT3KCNakSmJpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6wEii+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z06U/PE6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6wEii+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z06U/PE6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2pSW2395803
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JAqVWluA7QrGCFj1n7kbIXyDpI8LEcOYb0AIJAcvUOA=; b=a6wEii+AcrYF/jNb
	fTL5eJGPrtG/DS06S8C9poMnseBMYrKS9DeKEvlJlGnPfayvDTZd5CqrIn7UXxqj
	96/JEs57jDJifjTh3Rf9mcs2c3AjbOksWMb+dUm0DOJCGe+YrDONdJHd5mGdfkGu
	mh14gfgHe4ZvLobuQE6r4Sg5JqesUqPji3epcdehdjsiwd6mVa70X2CW3KjYuTvr
	W9VRyizxRLBJLJBfMFM870UHvePPIVKetafsj9YNjdd+3R4SmVBc13vGtyPFAnI4
	HI2jzh6T0G0MYf7mWaGPT8x8Q0WuZnTm11T7celbJ9uTdGKGcPoOFFyfwvwBvxby
	U4DDgQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c3x8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc2229450b4so2180493a12.1
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325465; x=1789930265; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAqVWluA7QrGCFj1n7kbIXyDpI8LEcOYb0AIJAcvUOA=;
        b=Z06U/PE6NqGe7KRQLYoo8i2848RGykEUwlHLIuzkLZXVpgs3UtJsHhxGu7w/LKCE2V
         wAbItPd0vjkIhbD7escrvpCdQVen4dX75Yxkj02vvULFD2O/ipMkwPIlIAogKeqWsdSA
         2pSzYRUAtTyze+l515AioE+CDhvlxMjVTrQJwzatfryFCs45JhPO6GnmMXYGT1M8PZ14
         CbdUsWifwaBQBPK8aNbJyng4CbUQCFh1Hxh84TQy7a5AhwjpE0oZSOlv0cIDqobGiwYJ
         AS3ii32+65VjhDPu2tqaCNtJIUbSRl1xuxI8JInqt7xq5D1KuCYmKI98rNnKEHS8ZAYK
         1fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325465; x=1789930265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAqVWluA7QrGCFj1n7kbIXyDpI8LEcOYb0AIJAcvUOA=;
        b=oPdCILlXv4nPAgpwVKM4RXrQpgKdwbjH3w9/9UbuCs2Jm8lMUhjurQj3/u6xyWxNUj
         yE2neUFRCLiMm89hkaWBer7eh5ffmEwhgI4pT2thtNstuax35fZ9n6L2ePyCAf75g03x
         ACfNn5gp0g2LE/1UOsPHSNCkYyDxuKib7LcYw7up56prPMCg6yN7E5ST/2HPWTAWg4Mv
         XQpjZdobm8zbNj6dEqfgsUrpbDqDgTMgrUbrUES8+JzDXb20hZHvDUdCptV72BudXUvJ
         RP4OpnVefl6d/Nsql83Y8GFh6SaurMMQsGKjs6UYxIxiRAEiabq8kTFtCyHgGF/WIIWW
         JLSg==
X-Forwarded-Encrypted: i=1; AKwUvBwzFQhIO+hipcK6XO5DPWTlx9MXmSTQPB5UStY+GsMFLgyg2bP0sBB2VgiLmQxv+uuPw01XCw==@lists.linux.dev
X-Gm-Message-State: AFuF++lNoBu2lTLa9HJfHRqDNIWoG5EL+tDu8aQ7KctFG8NlLPhK6MNm
	sMqv7JzWfRLnWgLumPC5hXfKZriO38Nx425OIqeZd7A+R79lFeMQ2KnBHAXDKB6YLv2U5KEqC/M
	5Oq+mKgTJN1Kh13fJvRqDdHYYquME5bA3JduoOlWw8nHVVsXvCTp2VxN2gQ==
X-Gm-Gg: AYBFou0K1zd/BH45VQOKwgMqjn0/aUFHNILBNkwQN+ZHjIqZP/EKhsotDWz3IkOdfhP
	KbXg5HRmknBtEacIueycCSu8LDPm+yFyc5ng+fnitLrVjr0uV1CI9Tqe81XoZbXv6bXR0i5SH7i
	nnfvpxOWMzzX3n1AQndR4ilBQk11ctEyyn/88IxDQxulshEsa0btyU3fEPzOAuXFvPWgug3rBEy
	75tM5C0Gv4eIF495DGv4z9JrRayc++Wtr3Nqdott6bCeBgvd82fBkaL+iwi48lHC05zxBb9mMST
	NhMNAL+Hcw608KSk3pq0NOd3m8QTV5TUR1+cUdEoVUEe54zeaygLIrpJOzW4NjgfKZmPcec9Bts
	guVrPoAYYH7FA+93tUPJFybt24y95Ivq1L+8=
X-Received: by 2002:a05:6a20:3c8d:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3daed15360bmr29215138637.1.1789325465272;
        Sun, 13 Sep 2026 11:51:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c8d:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3daed15360bmr29215086637.1.1789325464863;
        Sun, 13 Sep 2026 11:51:04 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:51:04 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:27 +0530
Subject: [PATCH v4 10/13] arm64: dts: qcom: lemans: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-10-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=3217;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=hSjOhcc48OJghLc+5hynLFQU9EGrwxyIHApwVUWJDT4=;
 b=rNRYR2UL+6T+Y/48EKnbZEZhgN2E1kCdWuexvsvexUC1FXasDOTGl0dVgyL7S6L7yqUiwHPkQ
 AeWD3PV3JnSA9ir0zeujjgzPioZI1LuG1StoJZP0bpFuv0+1J5quea1
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: L-yXDMps8WJvATKtLqrsJMdX1jk3Fuzh
X-Proofpoint-GUID: L-yXDMps8WJvATKtLqrsJMdX1jk3Fuzh
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa6f09a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX1y4UxoVA9b2E
 vZDH1TirqJGZq2ALD41QVM2ELCg84Egb9nscVim8EBXGwA85jGn6V6tQWLFeBuevdbz6kUiUZmV
 QsiHAogEcH9vbkQxiI+tFSzW5/l59/nzMhttg0PEFCR/PqTMMpoXh+nil9KnE78n8691Q346Km8
 4RYubs8LBEIA4uai7YmTy9GpU+sl4RIe+Z8FtvKEzWF/kZdkz07olUdTP1AW4HW4bLcNwTyrcXJ
 JZ49RC6uQ9QKSfD6waqr2nPHhbg8j02RQPaDoQZJvYfC32/sRxU979XSNx52R9KNZkbax2bsLuW
 A7OZOTX+7g1FrdTPHVj+kmdCJfK1Kw94oaknqNiOnLW3FK1kp+5/4CNN3oq60rFkhPeRgTPZhZt
 L7Y4/Lbb5egDzYa7sH5Cgvf/Qr0gBILODFrzoIjUh1yOfCAveB0FcY5rIRZ29k64tkwe4ToSkcl
 tRBUZGh25WiCsVKhMew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX4k6C76WzwfBi
 q8bZwpgFs6RxcDAbNwJ3nA6+51Dm/vMElj0JZwYhR/RmM/mcDoy0xMJQn/TvuRaG5l5tVO5NN+K
 +exQokoo2BtnUIejGdPM+vl+luoMXl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

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

