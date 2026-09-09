Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37C569F28
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965943; cv=none; b=OaeNofzHTgnOu7CZgubRlBPJptH8KixPGTxXpqP4twO/Wd29mtqXi4+bdWLzC4WZelC77ZFMbbN0w+M65XlSeIgQmWNOQEnuTK06ozGM/yyZVD2VOuANmE5KH3fFEZIJ3OtQ7WVOVX0IbC8gd4r/lb9vbsMrK53Kxx1KLLP4YAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965943; c=relaxed/simple;
	bh=/1teOhA20hCJgYxu+FMnrEPT3m7d/lo/ggYIye05njM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S72dSBn6ihLCnX6/bY/mvWM5TXIHSdiuWB/bgb0OGr0uxt4w1OnFOj09CtBenN7v5369K+rAysOCuglu1uQnxH70udBvHSrtOwWNPchEiDUBKlnJOjtqJ1mczF9RGIFfWwSqfflOs+2/5pn74OrFS0KL1wsKsCGJiDZEAciZDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RuyevDIl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgIMTlXJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RuyevDIl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgIMTlXJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU4bb1183699
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VAnppm8BS9dp5bk+vJP1d1kj3Ulc8PbpFSD7K9/Pqp0=; b=RuyevDIlRM+eJ8dh
	YxW2dKxgddor27dwwS3klgfe0TJvC0CbXeEcHhIcswyYoJPDtAhMUWLSBfzUNYNM
	aybiOHrvQq1VxBNqKjtiIRPIyio7YAqHv6PDoCDq98XzIC+NLW2nCVLdy9LpoPkO
	+VH17WFEtCPNp61FemktFwlXMv5aVg8oICJdmdwAhgnH7lUkSH5c8ARvWNeuRb7B
	juiEGEmTA/DpI9ZY9NyuSb+8QCn9XT4DQiK9VAIqFOUHjbEsAkaPiPx1MYfvdRDq
	Ay2tIZlwPYcIlIHpTjb8oXMVlm0S/cgEDu9OMyWwsgbsIxrrI9fi8hU/Xc5EQA78
	YS5Glw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559s8md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:59:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc92350888so17808355ad.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965939; x=1789570739; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAnppm8BS9dp5bk+vJP1d1kj3Ulc8PbpFSD7K9/Pqp0=;
        b=SgIMTlXJA3qpw4yUUzCGpH7nkt06UqBFeAb959UGyXLaRstmZLaKejuxSF3XLlf7BR
         0YqE3RaeKrvz295r9OStSTYP+AkH6aSVl1zgW3cdvl5Lor5tfaBHJIpd6UKq0apvpy5Q
         JEePvGdCiLH8FPbBpU/YeoODBY2WaIxt+AIP03bIeBuhAAftoY1ltFJoOUoBc9fyve8U
         jFD2YqwkEHYPtPfuRdAtvZh3sE1WBhmFd6wpRt0qsWzOjgaPTJAuJuCOesljEWPMHGu1
         ego+QIosz6mgzzyQFcAkBdZQ1URiViw/vXKEy8/OGjxBkKGUeb7SSHEyNgDOh6syU+7a
         qJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965939; x=1789570739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAnppm8BS9dp5bk+vJP1d1kj3Ulc8PbpFSD7K9/Pqp0=;
        b=qGnkLFttz1UzhmbETQwH+IixfYxF+zYhihizB7mIB7Za7rbzVvJQxBXBAJCojHP8SA
         VMDygjtyeEGpN53nXDe9oAZVixCDrXEbsqd8+tI8NMJPaeuCJJxgov0LNDVyMSutJEso
         Nam1y6jqzL2xC9WtSgirsUYrZiiPZurlekndt3gG3J7ku+hmY5kSMi62lXDq0DMRTORf
         zUp1DWTZ1R92jPvh5idGRv51Ap0avwzk/a/G6xiyarokLqkbx+pZYpv9lKdkZwxoaoRU
         qf5B2OZpbzGeCCCLhF28vUIQNWadvcYD2NVyzXQ9EZQE1a6bWRAL59VCy8ZIwwgXQB0K
         dcTQ==
X-Forwarded-Encrypted: i=1; AKwUvBybUcrA0757hwEA+OAUQU+nTteWDiIjVFzofSCL+dnxXvGChyZiRQSyWdmNPeTKUMH6QXIEvw==@lists.linux.dev
X-Gm-Message-State: AFuF++lehHAu1zCHENUs5w4HbHDmiTDM9IOTGDZyxGFYUuP0pSu/rRMW
	wFQA6SIuhI1HAlTSY3kogiGpOQVSQ4DxzlR6tl2nCDWgXa+oVCYUsvHHDtE6r2gZQyrFRPCyCFJ
	3KN1IpvP+K10ToQRtDdTzbO/xohg6oS4tU7RE/skMITIM2u9MComMXdOR5Q==
X-Gm-Gg: AYBFou1RIuwp1S9capqhYNScA3sEEof/rWpCFWUek/oQ9p+lgVMVLdWVMjGcfORwQ2c
	YMcruuH4mz9YEB6IC0bDIIr9m4UDS26Bxp25mwara6SZORcs6CzRKvfbeBS70RLg6baJngR5Uu/
	E3jcE9pJC+74LFm4J3jkcf/K+XgcOm8fpPEuvMf2eG7o9OMe2Pd8VhVAK18oc7KR8+biYs4t19x
	ISWPVuMvQEuCeSj6/FCrUMiZfxn0fUSon9ZvPXMN0LNeoqJ0+L8owcsAbETxOlqvgbtbbtF0E9n
	0IqCBGmK7WqLexn7ef1QhCJplF7+vuIVYaVZefnQ+aOYlmLoL3hGBlbMWooWPdu0MaVGXLGFHx1
	Xr6p1FRRwHXBZMU3dwoxRQzdBFLqIQprpqXs=
X-Received: by 2002:a17:903:acc:b0:2db:5c0a:f184 with SMTP id d9443c01a7336-2dd07a948f5mr23818505ad.17.1788965939253;
        Wed, 09 Sep 2026 07:58:59 -0700 (PDT)
X-Received: by 2002:a17:903:acc:b0:2db:5c0a:f184 with SMTP id d9443c01a7336-2dd07a948f5mr23817785ad.17.1788965938729;
        Wed, 09 Sep 2026 07:58:58 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:58 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:18 +0530
Subject: [PATCH v3 11/13] arm64: dts: qcom: monaco: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-11-2fe43ae45495@oss.qualcomm.com>
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
 bh=/1teOhA20hCJgYxu+FMnrEPT3m7d/lo/ggYIye05njM=;
 b=8Odt4O/LMqPtscLT30dGvcgksj3rw9xIE/GdNxCwiui0QqK2AycOstvYdYhEHh8K/Eh/oJHxA
 C7QqibYMiUyCRN7rfHtMMQzyfWNu+beMhX+5ynLGkkou5t69Ech3bcB
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa17434 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=w7pRem5UOBajBC5HA0sA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: L72rjuuQ6gWVGuHNO7bX7DWt_km9_TRj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX0cUvLK/hSp9p
 I96uI0lcnLEULX9L9q1d/PsynHCKVClVBCmbsdVdjeYiPS+R/YM7/aoXAzed7IHg14Zr2GKhTze
 o9oVND4wGrZ5dtz8a3Qldcd1GhHRjmw=
X-Proofpoint-GUID: L72rjuuQ6gWVGuHNO7bX7DWt_km9_TRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX4oA5N2imurvf
 gRc8i4f+WNytCQrPXeTYZqKlT6xFt1fomTtxr1mnxSuQlAbcCzlalJsmdIKhEwA3MxwQ7JhwjLS
 SgTLwMUxGcb6QzUGmwMgq3IQi3wEAy07nr8jPK7CYnb8LHrkVZkzgi91KJZW/v8TWxOq9YS5wsq
 Cf8PGPERdKB8sHMe4Ds7b4E0EiasOo8rJzT0GTjKsXQbx2b+JR1SY7ji+NYlgd8VHsVCts3FF8R
 CLYXFxHmeCjoFXWnEZw9J7TjQlbAgG0AclJkAyH2qYkZJN63f+g2/WlXwZ/uKH5FJ3+EKUmIiJQ
 1lvUjbDZevGCxd8O7ag/1ww1xRXB4B7M/U1GdvMs9zjaGAMT0kfLI4Nz3Wo8a8Vf9oOvHPclrTW
 b7KEqwc2JB6tzC7UiwLvsnspIESG9DFN4JyYiO7Z2reKEZPl4bvR0o/+jpV7IFWIZJi8bjTINc4
 zge8ZNHRqOzWfozRbSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
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
 arch/arm64/boot/dts/qcom/monaco.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224f6c9af0a1b15a84f2fefb90d53d5..e4ad5960c97850693064f5dccec9b27cb75f3987 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5404,12 +5404,23 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

