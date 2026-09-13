Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE43F929C
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325461; cv=none; b=rsesVeo/z6X/NUqtjlr8oTDAQThlpfxSug4XGD10DGSCmpM2e1ThV8E8e9ZXqfGXGZxyf7nJH6wAtZrFRLjmv/wfCxPZWjrSnUSU9w75YYf5hfzCyWQV5lKCYUAaUpUh2J99AX7Sg2pe5Ng7R/DIjVX1mF5BiBBWL6/2oUunezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325461; c=relaxed/simple;
	bh=aMjd9aYFnA7xUvSYKyRihpubAtnTpKk18gq2dPNLq2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX6jAELI0AfDEIraRMaMQeu8c7RlHJG/33BgiaVurLeMuDDzEHXswFx6O0uw2ZFuhq35Lunixbiw1lhUWpI1pNC3+ZrZRL8Y+nDAnLqJ9B2RecldSvb615tyUhSvEpydUwLNaMP6kt/zmQshxXPW5Qx+Y42f6/C46KF7dSHvUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJNAYki3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5+q2pRv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJNAYki3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5+q2pRv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2aTj2395622
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V+x7UtvEzgjdSrT4tt1OzVc4/3CO9RvMlBltyh/a/30=; b=YJNAYki3njIkq+3+
	s+Hk5kP4GzGY9RxHHQ/vVFz7fa/f6eH+PMCeG7cme5Ys+4tOMXlRnbAzDyvtbH+P
	s1BExDqtq/ocY4wpnMYftO40rgVTVGq1PqQSJlB+rs0REo0vyfbe6GRpzc1bkeOn
	g8x7JoCyjEtdiCvlZUgidvyGPaHngQpBx4N1WTYiBIF1X7s4rEXulTduuXohy7z0
	Xx3TJ7UZMk4/kP2VnnZzFildFhqvZoMnu1LuRG1b5zFEScNzC5zDLA21h3oGXyZF
	ccX99/SMhWSQetrQHibf08e0PYQSwZA0NMT+TUNDDxNO1NJaV3/7SxrRBELt9LTe
	Mzwj4A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c3x88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc7337e2a7so30877115ad.0
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325457; x=1789930257; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+x7UtvEzgjdSrT4tt1OzVc4/3CO9RvMlBltyh/a/30=;
        b=I5+q2pRvHqsAGeMqfcn5fP6HRgd10/LY3FFShuU/XkcaSpEtonvCZMsIK1B16rZ9PI
         9ywTCxH++Op4Wlk9BL/0briEu98BnNd7VB2j/C1sHnOgtBzKWqj+0+Ow0+YS5SsGzIc4
         foRjOVXcAIemddOLTwdT4IiKo3HJnWdnjPdp0wDgT7EgPYnlCfYmt5Jkd16jW80Q2AMQ
         2bmoolzvcB0gT4DYVWBqOG6DdqUeip7ppP6XSSuLlpy7vYdRfyUBZgrXwfAv6uEVoSoa
         jpYAslWtVOMqOp30U3LLaa9A50tqQHhP2TiSOvyXGLAo2xGO54PjGLRV0EhX7WtIkraT
         WSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325457; x=1789930257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+x7UtvEzgjdSrT4tt1OzVc4/3CO9RvMlBltyh/a/30=;
        b=Z6/TaknDZxqvRXiLRyLLgmRMsFztVK0rfBCb0eSSMIixYG/42D6oaIqPI4DgxzSENz
         iPMCijBeIdGitlG3OE+R37t8dXsObNyAosFj3otLVG1N//7DDKJywp2CXZMfcv1+Fz6/
         A+sVSt8ACfcT0V50Tm9WlOHTXkAh17YhIlViigIvqykoj87cNugn/l4TN4Vij7R/avyM
         copcw6s2cRdKMync/30RXYyNGzM+PcmZCiq2JvtLt2F26s6AnQ730QVmaKj0EPXdxcBL
         7eIujtZ4hYQZkJWS0Tn1mrqhPQIRcFh6zOxxqis8LgUgoGBOkrrEwDXDFTLVHyBy9U62
         LyAA==
X-Forwarded-Encrypted: i=1; AKwUvBy+KpKO7mzMZfUCfGLAnQPWq27YWK+7QDk+0yA8jnRy1t1CdecvNTLlO0GYZVWMGzOD3fg0LA==@lists.linux.dev
X-Gm-Message-State: AFuF++nexqvFzjIjXWR13NDo9j/AXUwUhQ4YNnFcRVMLYijc/dghr2m6
	E8nExVH2SjZcMhCDSOvVFatI+gWYPboQGS37LzTlggPcCtvh4Jq1+IKCSZGE7PS2Bn2MkWe+3GF
	XmoWalHGQHjkmWmRMn25NaeUwJJvGFPWmSUs5BVP+G42iiPcVoJh/BfM9iw==
X-Gm-Gg: AYBFou2WsrXGuoqSqb5x4tYS8CRiJO70iFzTkuPIs3aD3/1pGq44/gcuMxO8TztQNXN
	P6GsR5Oq3OmxDHzQMrT+0j+fTzSGTez6ibW7ec6W30pNcE9GDCZ+g1tCJ03DGc/uFijJsWDEx4t
	29vPVlfj4BwiAGfMJzTyitC9DLH0wE0nvY6nF+RFqlLLDl26PdKQhxO2CDUbKguum2DlyEIKFEX
	fC7R/+9JgvWMuKbwUnCLfynsDiqs7f7nv3FVefvKtfhdT9VC2w6wKYp4BcJdEbZeHZlbpZlFuHx
	IzrK0nAIC1gCLKB3FNi+enlVstEr7S5kKLem4CEktO2HiG8jBM2KiPZd6Y7iSOdGZzgEZDXoxvC
	VjY1VSHt59aRTg+lRC9tVkGUkfP64EuntWCo=
X-Received: by 2002:a17:903:1b4f:b0:2dd:40cb:a054 with SMTP id d9443c01a7336-2dd40cba32bmr186298735ad.19.1789325457343;
        Sun, 13 Sep 2026 11:50:57 -0700 (PDT)
X-Received: by 2002:a17:903:1b4f:b0:2dd:40cb:a054 with SMTP id d9443c01a7336-2dd40cba32bmr186298245ad.19.1789325456919;
        Sun, 13 Sep 2026 11:50:56 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:50:56 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:26 +0530
Subject: [PATCH v4 09/13] arm64: dts: qcom: sm8550: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-9-9b9074a73c41@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=3295;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=aMjd9aYFnA7xUvSYKyRihpubAtnTpKk18gq2dPNLq2Q=;
 b=ZXgALxYrEDfJi1Rg2+EUjjxP35Zcnlz2ROOmWEgGpZSrc29xppYSwMvOKEmMNW7/uyfWNBC4y
 sVLprhTofZqCu2TryGSwv/LXcUAHmysw9hzNK/80x8Ok0LA9go2gFBV
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: kLV6hlS7RpwvWmTS_d4n_BAbqEi3HDga
X-Proofpoint-GUID: kLV6hlS7RpwvWmTS_d4n_BAbqEi3HDga
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa6f092 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX++6UOenhydl/
 ObZ8hrisWKEbV9wlH8UwVXdQBv0ZV88Bdbh7TUSY1xQdgqQNlnQEqCZB3XNbcmRYD+IxqbkPLvL
 r+J8KtVXx2HL/Gxck/kY2EUEGa8EWAv/Jkziw+ijP5mYbIl5skpCmMSJJUOCQlW3mM+XufaVLJx
 ZGaiYKpVJeWvhiuZ3qpf/EvI/222eNqorkomTdUiW0gYjrOu9klMi2gVa5x3pMc5eVDfDeAh0nT
 7PQ8+W040A6TZafphtvB9l4o+8eWm4MvAtO7yiln+BgL1HxkaCI8v+GXMrqZbYKUhIufoFk/MMW
 O0TbxCoENJGSyHLTXseXiBlHtj3g8On0qphVvnxgwKoM7qf7GPJbH5wFVUrY4R2lh0gUT8rWqaW
 0LqrDBJcCqDy3M/hjBz7zsip3xjjBcRTQynA7aqsWx4VFpzhKW0lf7PqgDxfCKeZQ/dymFgcEHz
 9Zt4AgqV7AFUROKY4CA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXw47geeA9Ffvs
 F4zecprDbi3MGRu3J+ywyXnzoHzQYuqyd4uXhQiYy9qQd0SPLtP68YWtGGVsgMKN9IjxXX8ysez
 CLhVwzfVuQvk7CE8TH796jgY+nMNc1A=
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
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 23604436add303348867f890890f2f7af4f831af..60164b853ae0764cdd79c4680490e66a548b0613 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3690,8 +3690,6 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 			dma-coherent;
 
 			/*
@@ -3701,6 +3699,19 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			 */
 			status = "disabled";
 
+			#address-cells = <1>;
+			#size-cells = <1>;
+			dma-ranges = <0x0 0x0 0x0 0xe0000000>;
+
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

