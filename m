Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6E569F3C
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965928; cv=none; b=Ei6Ucd+noo3ZasQ/UeRV2+nQEOmTHUha1DNpwlIP84iZFb9KUJCXx5zesztwaB/n2nPKU8f6sSp/gBbkQp7DxIpzPeM/LgINNvGbvkO5PcSyrGowX1bglw6uxWPOa0u8KSAnQkljqbH15tr0eZ+ECQ5gyLI1EIZ9NN6lwgckfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965928; c=relaxed/simple;
	bh=K4XNWtbzRvEKvAJ18ki+8idGw4qkk9tCrpK/rO+5fUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJ5ySWimyL61lt1ZWgaT/H7KQmx+3bXsQ6Rtzu4awyALXy5a5fAnBi8Kvpjpttgxzk3VlVorRapd7ojjUwa/cwSPzKYNT0tae4eZ9jYj2/nJ2w3vgYmyPNsy5nOnqBPV5y7/+JF0qeiddFkh924yMEaQ7m75izrVFHHid0LOULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zbk5YLXI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AIIywiHe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zbk5YLXI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AIIywiHe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUAR91183763
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6TkjXMbTRYfhy2Z+xX5QJ7eGMI4OkrgGqEbV8HW2cNY=; b=Zbk5YLXIY3bV6oYt
	kaWfLkmu/QALr0Sv8Y1SjUAgTEuQvCc9tlIro329B2xlZNC2GxYyNxJEuVzXqi+w
	/Drli0AtWthIiVlaH4XyVkbCIUpc8Y7M5swSBfi9xOsA5dxJCRj4FmHQ3Be893mH
	yh4Fxy3NIUocmE/M148rzzaC1GdfFtgJqcKDn1rNbdEDh8A5hJkikVWTk8Cx8Mmd
	AJPFUmvnbj428OoQDAtYFNJYH1oDUXynB8+/pkT7+2QM96C0oQ9zFz3WUL0ILeA9
	f9GI+XYDjGyE7ryRv2v/TxxCDZbAr1VPLA1GWMSvKQIhVonpZcAnE8zzdxX7cPL0
	PV51tw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559s8k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc487bd6bfbso3288194a12.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965924; x=1789570724; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TkjXMbTRYfhy2Z+xX5QJ7eGMI4OkrgGqEbV8HW2cNY=;
        b=AIIywiHeENzy0/TxFUJdx1SAakGyFRhgXhzRrfxD1pEcCWhpvFsYRfFXOnjvpq3cKi
         GvGVatYIXnRQPdCAuqPexGZAEKn2YO1t9E3GQzDPwRXBMEWGDR7hKNmDaLtmdgyf2ePx
         dxSYJANS3D8+jH4k1t3k8R3GWQQF4Ytsr1URxj5EvmpBsIgLUlVDw5B47y4h7knoY2X5
         PtN3CDi2NBu//pD2aFWnE978fNDgwzXtHqHYDfEbkzBROP7pAFcpg9SL1jk4H+y8nRoe
         2IDVzSlye/3Gau2dPdw2QhsHIaPPrLVTgo+T5UXfIh1Ef61di+Mwqt5JfOqgEYBGBg85
         ncSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965924; x=1789570724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TkjXMbTRYfhy2Z+xX5QJ7eGMI4OkrgGqEbV8HW2cNY=;
        b=XpF7q9RVlzkKXQ2hr7YsSQIT8/5dVzUHp1VEn/w9a81ZNFv7kBdzdYV1azxBdoDDv5
         yIhqh9Z3DE9RtiL6PpDc+aNRPN897JxXon8Yybmt0NsfmsfJnnpMSTXUnMSVnmIeCSbP
         3CXQ2e6ZTnLxz4nwWih+oZ0euzeYE1m3Lra7aBy/pGIySPeagaNY9hueMLKdCQsmZneB
         z2JXdYnom3GWjZnsT2mMJFd9Rc+gG26ISqrNoDqmZa3xUdyDNwL9oul7vp5Q4pg6o68I
         +2MuIgUPcl+OdETVX4624KR63pzi71c9tGEL7ZjQLMMYGwDDPub3Otta9s5tfkgL1bCX
         iQEg==
X-Forwarded-Encrypted: i=1; AKwUvBwmJglKKA7NbNzFPRyPDkc/7vBrqulhK0J+VRHoVV2I2yEgI6u3kGSgkIY/uiPtdwUCRw4FQw==@lists.linux.dev
X-Gm-Message-State: AFuF++kAFE3T2cdSNkGAl26e5f5wx1TYzS3SFVtlNOo8sLfpm0b0QETX
	osJeBqx72+ISZDHbN2cC3jgR8eXxtT+aPJItkAKsS41K0XXJ7J7vWXorjDw9ATW5Kvj3eW3KnHI
	NmjBTAILP42dy3cVZmiuEWDxy+P4sCS+K3uO/7rGfB/rZUl0Y6tRDkyoitg==
X-Gm-Gg: AYBFou0EoAc0CvUO8pfaWLwWZCSvGaSNEEUJXgOjTVu8uJ8ehNJja2VmTrV87TF42AX
	0TO6VX/YXREw+E3p7u/60R98LBmc0QEkYZt2ARtqecm3esizUSoM2wJ66Bkt5BWVLuLeOkdxkVn
	LCul7ERNvxb6zRrBMODdfkUWRHDQ1ZUVp+ev4h3n5YwtcQdDXeTiMZb21wP0oJmvpoDhN1Rj6hz
	O0S8kSVi9h56CSeWRXb5azJZ0QbSLRAIOiFAJ2xpNI7DXCanljzPRppjMCpd/YdMZvb9GY+sEjy
	yiUuedE2uCvcd6eHKsZIzNy+rxZZKM0vdVaTxEyu3Zfpf0Kxi/F26T/Jf2Fm2+Ro9iyoTag420H
	g2Q6OBlxtQYdmJKQaxdirUAvEVz7u/E7SoPg=
X-Received: by 2002:a05:6a20:a108:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3da39ff4c0amr48206678637.13.1788965923754;
        Wed, 09 Sep 2026 07:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:a108:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3da39ff4c0amr48206592637.13.1788965923112;
        Wed, 09 Sep 2026 07:58:43 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:42 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:16 +0530
Subject: [PATCH v3 09/13] arm64: dts: qcom: sm8550: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-9-2fe43ae45495@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965841; l=3343;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=K4XNWtbzRvEKvAJ18ki+8idGw4qkk9tCrpK/rO+5fUI=;
 b=qNy70wYTnF2gPu1+iaM60CrEXqDMznNg4WSU8fzYZXb1jK9El7jaBv1JT8eTO1tHFebFdX6dR
 jsmQduocHsiBJDX76zp/jRycc+OovnyiFPYMh50if94HrM/aOZJUbHo
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa17424 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=w7pRem5UOBajBC5HA0sA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: 4kpsAwXmRKY0tQXP6JY49fewBhPgpDjK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX/v8mKNDSfhNP
 0ksjaWJMKTNg4B9M5ZAvrYYpgeP+aUpYJOSfSc5NYIhdIyJnvn/SQq3f4gKiGOt8/Rlz1bo/88Q
 tvy/Az+Gx2yHfaC6GZJ3TNH4VgTLyUE=
X-Proofpoint-GUID: 4kpsAwXmRKY0tQXP6JY49fewBhPgpDjK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX2i1tJO8CWXhQ
 Ciia4HQqdk4vbyBTsBxA32J+0LTL1lxYbSyohq1fVESMgy+VPer5cNSjmOJCenp9XL3QyKqMG2b
 wXEXUPoNfCduh+v50TNTkUZLObEjpf0F4IMGSo1/6totzBoY+fG1PWh4GoClGU56LLhH3zm3D3i
 84iiCyCWxGSZK/4aPZEC3usImOz3Wovj80zNCYYIvSYf7DkU4Qb7erpupT2dNZnr3bXtERsxv9X
 Kx9kfgAHhmkdS//JJccfRcYe82TxeufgYcP2C7nSVTouRlMX+YKtzMGk4C+BtYlolr00Jud84XL
 xjFu12V86hDTG5UmDF80ZHPTpqElx/KDEYHnjW6+w10gwUI0akip8rOTxiSP8fN8FkEvMonTEpm
 c4iMA2sjKpOR/mfBkxNc8YZV6YqCTFq3O8o+D3SFcvzyLOsbg3P63bCOei7owD9Qt8RJTfMZf3y
 FgRGBuu5JFmfmFEEEzg==
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
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 0e701e709235c6e0a5efd7f8447dfa6ef6f6e21f..38bc5b483007ad797daaf37527b4759bc8924a2f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3691,8 +3691,6 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 			dma-coherent;
 
 			/*
@@ -3702,6 +3700,19 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

