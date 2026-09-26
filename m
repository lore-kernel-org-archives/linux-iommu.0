Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DA395AD1
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404539; cv=none; b=eSCm7c9AwgQtgBop2f/s/WM2ol6owEkpDP122jwCbkP1k9tG4C4UU7VoXScAj2zPf629Eu3rAzTVojbLXAI2ZdzxExt0liptz5awA9tfZrEn00cnxqUcbWSRsCpNx22kBwBzVWWK8SkqlYfDybR0ezB+RtSToOmCD32sByW6B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404539; c=relaxed/simple;
	bh=JeatBeEgQBpNQ+47fHavyvUBUmtN55Pep8qBWx831Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXCIlU7cWJj7Tm7LJ6r/1wABavHqb0uXbnleTLamYemu94/oqOy8MylywgeqwCp1pfsrkj944nUSI+aEPD4ZvnbC6HK6PtXUQye8AKwDxlmS+0trh6TRPCURRCJrovRZMqJk9YXh0uQYbrIM/2gC5zeIdoArnXn4m0KY2RgUIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2XRmC9v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwmN3Umw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2XRmC9v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwmN3Umw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6Oukp3447226
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4r2KBrsge8lNI/uWrq/Be2wfr2s4MkmN/KinCueTco0=; b=G2XRmC9vAp9Rp1LM
	fZUlXfAUV3v/5kBzIORosH4cXhy7xfGXCocPiPAJggWV8M+kZPA1n5j95jBijvgM
	PZR4Z8aTCh7jBHD5ycAvLgHKOaoqLaQZnNOIGd56SCun5GD+kgbwwi5kEtxgE/aq
	NSmZW27XLyDaqOp9Dfn9CX2P8nl7BEay4QKvqYqZOf2eNaeW6VxphTxt5bVa6xhF
	geqg9tc0DtDhqfeJsyMNlvGGbkQisFpJW6Bg3mtb3EzXLtyUnzcbzLR6vbSWMESh
	ph+cyUQ9nTeRP9eKVJy9R0mqgQogXQ4tOnZ8L1a1lrzxVeMO5ZvJYD3uYiOTxF8T
	ws0Oag==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6938a4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:31 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1431ba79941so849273c88.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790404531; x=1791009331; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4r2KBrsge8lNI/uWrq/Be2wfr2s4MkmN/KinCueTco0=;
        b=KwmN3UmwvWk06rhKJC6BzvXbFlQ51FWTP5Bu+MB+RkjLavGy2y+is0ze3XClb/3HZf
         C8BQEPvcmZ5rP+bBtDj97DTJX930z1QekRiw+hr3s2bhWUMbVR4O6KSZnBSKHgPulrdg
         pGVeGrmVkfClSrX62ySBlJQUa4bW8Lo99/AXKHMTi9W+MuDkhvf6ja5mWTWkGYl27ABt
         a40gf0ut5NTwD+UxCpBcZXQoNRgM5ePBp2VbFQepgEPAMuszPnxhHkWyF2jqCSKCuV5a
         trNEcJ49YF/HqpJCWPpeArmPhrqQoHyiFH51qvyDUYSzGJAl6jJzlKLXufuqTPUhJaTZ
         9spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404531; x=1791009331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4r2KBrsge8lNI/uWrq/Be2wfr2s4MkmN/KinCueTco0=;
        b=r+icVt2eiv8Bk32JblwOsBIZMCQnYG2Gd1M57zftn24xC3b9Xlj6N/9F37+/YZbb1Z
         86JVZ9rEojl9iJNA/YsEK7xU2hrs3v3VKhldQS8dMorL3otBOeJc04ktCDeL68afVFqq
         b5YY1Ubi6ZS1TXRjpJuAWm/9AqAoMt7aX0bwH6ZXLn50MCfIj8/ssheWAkuk1zpGPcpb
         jXPV0klWrohXqAeY/3E+lWXFWNIihZhR9km0whmzv21wayPmKoedB7HRSG64i2Iq9IfX
         0CN+posSZRvy5txKJEcdT33RiwBuOqbABmotaUJzee5tSlc5omKJnTzPO6gOAAuuvUlv
         veqA==
X-Forwarded-Encrypted: i=1; AKwUvBw431YowmrclTKU+S9WBAfEnFsgbxxgKbPU2xUOnow3ux4X4NJafCjQVu44bM2l00R9zBsosA==@lists.linux.dev
X-Gm-Message-State: AFuF++kBNxN1+hvz2zpRRY/VKBey1ss2vLR202GE+WLMfILkwxz7Fr4w
	POD9KbUvZyhzEgD1wFj7izgBFzkkM5vVajhvZgt6HtVRiv1yFGxAwZ94pi91bL3AJvcXcQK50is
	cGVnVpKXhmeRcgPImXLmz2cUDflNjXRyn4s2IviuujRv5+4+W1ri9mesnOw==
X-Gm-Gg: AYBFou2lZwAmEpX8yf5dcuvHHDhwGDV6XE6+W8p2eXa0roBMbkMDXYG/wI1fGeC19p5
	FEx6qHV/XrrvkkXim5Lhez4dEztnGLbRcvOrcDtxu534Kj+f+0ArXwpwolLl/Ufff2A059T5cP7
	737Q2InWr0Bfabe0ohgEVEi4vthVCValS0Pxl7ms0IyvHNNz77VDMgXkUmh8lhZjgIloStg32fu
	3r9K/voH8RQWe7D/pWWag/xkwIB7s+3/cDXcAUyonsAUPmGq+oQTb7nX58vg9aO72FwpzULi5bv
	nGsjTi4HUBwgJUnRVMhEiYfK8ZouPtHUToKICp1EiUsKwFPDYMGoDx3mPmtSgkQe9M/SaLXl7w5
	GuTkAfuUsV/0JUXfcKkEstQjOKNyo/ln2ig==
X-Received: by 2002:a05:701b:4314:b0:143:50a0:56d6 with SMTP id a92af1059eb24-146cdfbe26dmr1832546c88.7.1790404530978;
        Fri, 25 Sep 2026 23:35:30 -0700 (PDT)
X-Received: by 2002:a05:701b:4314:b0:143:50a0:56d6 with SMTP id a92af1059eb24-146cdfbe26dmr1832500c88.7.1790404530367;
        Fri, 25 Sep 2026 23:35:30 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm9700691c88.7.2026.09.25.23.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:35:30 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 12:04:07 +0530
Subject: [PATCH v5 08/13] arm64: dts: qcom: hamoa: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-vpu_iommu_iova_handling-v5-8-0322ca5dc10c@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790404457; l=3399;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=JeatBeEgQBpNQ+47fHavyvUBUmtN55Pep8qBWx831Mg=;
 b=PlmiyIHr0Ap/yAmfx6s+hLQS+XVKalhA9uvS+87mKdVJqnpjdLdwykaEvy7zPDLzwG78mXQgP
 mtTXg5qtAg7BADltUwHr5TxuMI4yj/nR5LZjh61z89f8/yHMcoNx1rq
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfXwDGz6CtnjL5m
 lV5EtcGehJwspnAv0iJGOLOGPDubjB6HUIGebzIkzpum02Ho3dssmerQFTd0cZfFt1l8uUqjusM
 3sv5Op8B+WY6DMyNnd4X+dIsutbTLcM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX2U7nlysbklen
 YhVJDiD/t71cVhVvGy/aqF9RdLAio9FYrY232ibfvTEJ0pyiHpBUwwv4sqwgekUxX3kq8j86xdY
 Ib4CiLjXZFVjuar0P6HwAvLl30V0/SLU1bedq2rWv23HWRjgeiUxwdxhyU+26Gphj8JyhLDILSQ
 Vvj04I8ZsC4WJA+50IW17Rov+JItceOfTQ4vjP15hHxBpQ7e1l0eYwbpbCaECRiQ2tS1uYnTaai
 hmS2lXYnr4nYv2i3PdVPQuh/5Fy91Pc0CxmPmujAyt0IVOPB+Ye2DLyR57X5Z3ZsNiCoZXHxAG3
 PeOZkszPQ6QEom+Jsmy6OSHV/P21Mhh+BoUJ1ByCcqdOXtzSOH1hTRHydOsF9+1TcQ4VjigLDa0
 +/G6I7qv6VohNIFrznaswIRLUOG7hNoZRGFwSjAvHX/HOM/ZprqX2klCmbseyiMCE6YeE92I6mB
 fX5b7DtL1Q/VfMh8idw==
X-Proofpoint-GUID: 9OBNqi9ChdNy5ktEZ80UXasAFla9CxvE
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab767b3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w7pRem5UOBajBC5HA0sA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: 9OBNqi9ChdNy5ktEZ80UXasAFla9CxvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260026

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
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 4e35254cdd11a87eb5e4817abd09a603522309e2..9819a1f5686ce92c2249cc1dd65a491665fcfb94 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5468,10 +5468,12 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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
@@ -5479,6 +5481,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

