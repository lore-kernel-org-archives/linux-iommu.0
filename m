Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13E406269
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325491; cv=none; b=fPKUgbRLPTVuOTqOz9SFLcWYlYJ5QLrppIkKhWNtbh72K9JzZoZDURIJFw+X5ubOMbyXTppWOTnzajnjGfMveVMF5BjWZteczk6m0YoLWLf7s03V25uCsgcymOgrFTg5WvKxFmjrYYGYMg16XhEaRccRn8kpM8hqmHqcmDOtOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325491; c=relaxed/simple;
	bh=XZTtH+KJamke7BFQt4SKU9GHxEgBbysv5OHmqTqkLnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMqzm33dr5F4NOVWHeih5G44G9aYZOL/n3cgwQICsdbBGABm3gNCO9HqpRgvVH2GMa0Gd2j7AHVkxXfjgnChtqiw1uINzMUn9cd1cIpqXFyhuri5DAbxKcGnwdHDQEbq9JCkBY+r/CrGFlda6H7rx8UfSdQIAicPwe/wHxOW/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YnG1P6rN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c2ak0/de; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YnG1P6rN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c2ak0/de"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI3DrU3285712
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q2X//wdUyighhdjTu9aFC9mEc3Ky0vJevf2387nQX+A=; b=YnG1P6rNVYvQj7N1
	0JRSiheTe5dwHdZ1yYPoC8K73Y6fdz3lsSxvQzLGnLBFiaDjZqibnzkLuybNnZLj
	PWm+36kedWfqlFiL9ywbNllZxVDfhuyuwwl+A7Kgbv6bKtVU+QG1pGMDuseDZ8Gu
	O5w8up4NNpOXW8SJ14ubeCa05DvnMEWmCFYutHBDJZt3i31k0CKgEvtu0wOioXnV
	a9ckf+Fx5tyhjDeWWoNoA2+1dwc6b8Xrz1TgmdPpzPnBGTuivpglI4eDgiGAvyXx
	2A1JNrBcQ++35N9KlZeK4u78VUxZzxXbnphV2BU2pZ2XuRtHWItpu950tFtHI3Fw
	sNDYrw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cby8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:51:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso4619505a91.2
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325481; x=1789930281; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2X//wdUyighhdjTu9aFC9mEc3Ky0vJevf2387nQX+A=;
        b=c2ak0/dejvsKqw186lROoU9yoFmVtwHXa7f6iEggdrCyNrcGtLUdWAn/+sswh0MQ3H
         xqrmyo3wmU26QsEV7TJK2RcPxlplLqfYDkIyaLhl5W9BmstmVog8AuSzJ8ZW2jY/k1n/
         tqDW3Gyg8Q1zrP4H+X5V9lOQNGZMui69PCqDOknzBK/cNEKHSZJRfbJm2QXOEiEDeOCB
         GxiSmmd1sh/ccFRjXlvG2dppomg/7cMDJE8hhJZI/QiuZgeBgw4QKekzCvs3rV25R1+O
         bLYEDOKlvWiMR0qu8l1X+J7nXkj8npDzPm5TJj790NOdkmAD8QPqqqiG2u1oqiD1xrDS
         3nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325481; x=1789930281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2X//wdUyighhdjTu9aFC9mEc3Ky0vJevf2387nQX+A=;
        b=b/h6UgHvNzs2ZHJ1EBczm2Rmfi/E3Zs1k0GOlAJaNYSl/rIaUiCUkD2xbDr0ROpafC
         67++K/pAGLsk00/py4c1BXR/BifI/jRiIqRR448Dw/woehj2CbUdovAMk99nQctrYTTl
         aXw+DugzWRVJ6RIcvHqmkgASNA9tGWrM3tu29zXT8RogvBWg5oS3mILoQXS4in2sTfJ4
         K8RgJ70Swm7KoW6H87Qb/iLPeZASAfcIu2Yq7+zhFegHVvWJH/wE+saio+O3Z4Pnf9TR
         JOHUwAlrcPhxuwWVz8V/K63hYrSxThdohiwzkB9kEoSEu5+etP3RBIk8KyEUrTWs9RT3
         8+uw==
X-Forwarded-Encrypted: i=1; AKwUvBwH6hjz91xXEVtUgZ/qjTRhXx4FjWA08bTmEmun/hlP4y6V9bHDnyNCkBak/IgmZ6IAuiqfIA==@lists.linux.dev
X-Gm-Message-State: AFuF++nFDbmukCtWf0l0BeCoZKQBc0+utAEPsnXuWqgg1gCs6JUinvED
	BzGyyShWG9yAUbC3earwFdmSsOBPieN/UfDj+7MrkFpWdlmyrWKUqUv60OyoY+VmIk00IZLtmTU
	Z3xUPF5zkgwUreD4cuEeFkvACqRUGnekHmv/fac1n5YqqxPP9S+dAc5Uplw==
X-Gm-Gg: AYBFou0jIumcJTo2ApeD4SOy0KmyHsRLVO02ZugbQvUTWs5yiBX6o1CiQl2x9OefB9I
	ufuP/jUIP9l6ywExRurc4zC0aNrlEDU7M46gue7Q7lsRG4ueVouZlOO1ur7UbledoRkGHaAsLBT
	4qaN2Rl5AL1MW9EnMMbcOdMrZXV19XKgTWh8SsO6CtNug9o2w8t4RAx3kfC+J1cODH14DYpCyok
	B6/0WNvqUvn72a/IyGXZT9YS/ixMBlUBpV0/DAsg9pD6rAfGTRzDDvL5rG2A+z49nykUZJMmCX8
	vufQOfmsK/T3xRjfUD/vu5C+wyp7gMouNcoSV5Ej6JZSEIuInkv2iT+5domQ7JsREYvURQlFZ/V
	UGBjW4cH3fLDvPnAsZoLhAmfn0z1BJ0SePtA=
X-Received: by 2002:a17:90b:5283:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39dbc6f0818mr15864262a91.21.1789325481154;
        Sun, 13 Sep 2026 11:51:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5283:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39dbc6f0818mr15864196a91.21.1789325480726;
        Sun, 13 Sep 2026 11:51:20 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:51:20 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:29 +0530
Subject: [PATCH v4 12/13] arm64: dts: qcom: sm8650: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-12-9b9074a73c41@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=3374;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=XZTtH+KJamke7BFQt4SKU9GHxEgBbysv5OHmqTqkLnA=;
 b=3nR06g4I3fBs4o4T5XyN+m8O+pKFq55VzseEc6i5f+1knjv4ynnPHTfHqGTC4ufsLP9OOFxdo
 GmoP0kLA6X4DkjwqjCtu/xGJOLXc3FWdrQYymwfSkvKVr1uhi+5WF+h
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXzhdPN81nlNcp
 +e4qEP7kPSkj/FcqLiI0G1pmKsvs0hrZSi3ds4/HpMHijcTcIW2b+Penoe4F4vZUeWeURAbaeq0
 tRgnoMWlY/x9E/f667Ou2A3JwX5diFQ=
X-Proofpoint-GUID: mQBYSC33-Nunu-PdFpdwS-2LqC7FflJw
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa6f0a9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: mQBYSC33-Nunu-PdFpdwS-2LqC7FflJw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXzTfxr7j7TNnj
 hK/+mQgaOfc6+vVHIW+WFrOcQkrc9fXLx/fpFoXbEUgA0vQ6om+I9VycBU79Lsa1C6GCeiO5Pxs
 lIOgbS1eHqMcbYOEQpaeGu0CN6MDZECUG8U2oC0zWXJFmhAEXhFeX4HVklPFH+1mLIIAFD2uiOX
 jXVJiNw04U4y27MVIggNLakilgX6rZx667/pleiHSbiNHbsPupq1YSlY73Vh5s1evJq66KWhdqP
 HmGEjVwVGs+B4/uXmYYtE5azBzQASuFT/0S2J7RDWjB/ykx6mIxchR7QUVYI2EXvUW+QZfl655t
 9+/Yl847ktdTBnLE49PrUOlr/FKt1ahJH4SOxLYPM4LjuE7tppaT0qsL4Smz20+td1ONVZnMNog
 DujKxfSzGLFOqSSBqTk9EMnghl5Bj4NY82gL0hBrOKCSaKDpDudU5sxxRHGsBN7neCLlVEQik6B
 VNf8+7NgaPJk2Kx7MVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
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
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 99509305f9702addbbf3f4269e558e08d0bc1b25..88233c1f6107c5fbc0f0f68202fe6383abb10f3f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5274,11 +5274,12 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 				      "xo",
 				      "core";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
-
 			dma-coherent;
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable on boards where the proper signed firmware
@@ -5286,6 +5287,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

