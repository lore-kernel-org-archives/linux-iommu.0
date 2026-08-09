Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1C3DC878
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306581; cv=none; b=Miw9ZwaCwP8glHNELlNrlrXqfExs/uWEMSLwtRN296lvXdcduxR9s8AJTFKEYMsYb5AFsvj3O+5HjoU5jc7TtzR3p/A3NAEJ0NzJXok7xk1z/lO4eECXlO3vxgscbabL9K7OT9YJqOe6opPg0tdv4jBrvdmlfiHydmexcbrLAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306581; c=relaxed/simple;
	bh=d3z1RpIIztzftotib4BZlQb2dA86jL5CK9UV2NYGIsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhruJswtSSeE40FZ7gnt1MrXNluO72VFb/gnmJ+MnTjqbpsZT+5NZirqCqE+4PsN/bt5QUGLWJME5u3PbTuVj8qiCWfNu+bTgS2I+/hYZSWNP6AiW2m19pdzMMarJmbzY/J7L/MCb68u+sEpOrlKZ/zxQ0ludeuTpTvfDbCFuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2BhA7Bo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OQxPb20H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2BhA7Bo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OQxPb20H"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679IA2MG391069
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lndsmwfidtx9uHQGQyzAm/dtqIU5v3GB+9Tzq4qCPV8=; b=b2BhA7BojyLDIJVN
	px3ZmNZCSEx9YftCCpYfJyzG4utXmHC5dZQh5AX/vu+0ho02lrDQL+MlIQgOyCeG
	9qTWaWcH5IjPbDTf3dtb2RcYmqEBxEnfjxZLUrQiqHI8wu6kKLMdsqViRp051bS2
	G2koxmSY2zj4UqbQxySKKOxElVEAmvM3UYGZiFsaUorfuhrLrES4dtlHkjjvepaF
	0Kh6sBwW8LpkQphBRp7NUJG9GISBtvzvdKVHzP5zZ9aO0QXm60WRcONMDwDlEyJ/
	9cnZwyn6wM3LABsN6dR4Sn4JMyMiNSMNuww3xCLv+uSG9x8BRkUb907LEC8UaQ2j
	fgc6NA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwt5gkpq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so9348751cf.1
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306578; x=1786911378; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lndsmwfidtx9uHQGQyzAm/dtqIU5v3GB+9Tzq4qCPV8=;
        b=OQxPb20HLlgMluKDoz66gnQnn77Z7NvZgpCsvqY4SaischyqhFTkZfqw6WO79UarZx
         tf7YzciFYsuejRUbg3+GWsn+fZ6/1lD4isih8TWPpdp5quiSM74BFb9WupqcFhenmAD1
         WQk/R2bmGHTpyS5JqChdsWxmX/9BwPR7WsVfOWVYpWP8xjYDrzNJewbwDZ+gCq/Nv0vx
         AK1JHsQfN7nW799XQFnPn4nOvHgxEBQ/+UaY4eZszL28HblC+23OzSHRwdCv6Ve5lcRf
         x43XbpGj7o1lFXGy0R3McCtv89Kp/Y8kqEay9FVwPTGLNp38navLSK7WF/UdJFGZhMVl
         TLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306578; x=1786911378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lndsmwfidtx9uHQGQyzAm/dtqIU5v3GB+9Tzq4qCPV8=;
        b=Wjbwuzi7yE/ExCpr2Dh5yJFm++nbBxhy1S1llg3cZSUhrYAZdfC4eo46LkXX0EvTFm
         xQQbHO/QLUer4Uux+bn60V3xNAQk7o2hkzoqMar1k8jGG9q/JK4CUCc7vE38wDq+bjK5
         2nWxU6LMqYkVSYrJLhUKHwb3hofhA+MugWnV44M+BTDgnv2RIT91nmrdh3u3OrkIKoHd
         DuCzugWyYwsbnSBVTsLq4moOZj8n55GWktxZhQXsZrncjrGaSz+w/eL5hZqmCXKyECwB
         TlYXDzDppO46w5cyYO2hmQIABQaE+MVPJIQzfN+urNh3+OtnzUZfK/fzWKg8lLKFWuGU
         JzZw==
X-Forwarded-Encrypted: i=1; AHgh+RphvQ0RC/ClhUEFaFRoWNuq0w9P7i3tId2N9XPqktAMXpy3qjE7ukW4/Lx37j80wR0swSWQXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQclDzmw8fUEw/Ob9T2u9ivgBHlZOp7H7VFtZ1O82T8McUvxGM
	x16k1iAMI0f7gnvKcIkcfUYeCG+lpS71aIDmhu3bABx3XwJVobNn4Mxp+D6xP+BfImbSrr5mX2O
	60Hqd7LpXExty9gMjvVO8pNsPWAA1RqGs/QHp+8AJ5VZs3NnkXIhdw5p8mA==
X-Gm-Gg: AR+sD10JvEZZyorsMkrQq9E04r8h0wuxYOW3zxCyheBXodWu42AllBurIYMj8QzcrWv
	i7jO4NWYp3mjnqg+bx7ZQ7vW2JtKCgiSGQW5GJn1k0Qqd38gCcURXK8gfkLklHmQ+le2YSBrSRw
	KER/y5hwt43TuvSk4NM8sjuudxYOQIGeJlIjiE2PDcs7GWC9HiNXIsxAbaxVjY47K92UO6HEuXs
	7dc0rYM1ajDDCi1I1n/nxctNClUsCR9mNtA5EqlChKTje/ZRXoRpK83AKfS2RKQltxDLpLjUuM9
	lKr7EZ3zF6Z7eixZ63n8yZhSAr/Uq6XSvuhf0pY1HgregPMRVVxty6Ixr+Y72vAYquQMzqirdyb
	ZX8+ZBby7j6q1wRQefPYwqmXb9KOn7YdMbitU+xuEj8Ef7yLX7Ic26+g3lfFpl3vXgsmFrCkTqw
	dmmg3uXGkhGrkTYA==
X-Received: by 2002:a05:622a:5889:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52ce5faa390mr418012311cf.11.1786306578145;
        Sun, 09 Aug 2026 13:16:18 -0700 (PDT)
X-Received: by 2002:a05:622a:5889:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52ce5faa390mr418011841cf.11.1786306577703;
        Sun, 09 Aug 2026 13:16:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:51 +0300
Subject: [PATCH 12/12] ARM: dts: qcom: msm8974: add the IOMMUs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-12-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3876;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=d3z1RpIIztzftotib4BZlQb2dA86jL5CK9UV2NYGIsA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/vddgoDzEMAW43xRxwUMrvR2gEnXk7MPZLF
 iM00Re+zKKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7wAKCRCLPIo+Aiko
 1Vh8B/9UwFNa5oRKlBFbtHGLftufbQjd3wp6vkR9tLBIAyaiOSwB1uccTgLwitwP+qgVzM8mK1s
 K+HBJFly4IR07lUBgq3pKbSaOsC7RyF5Xi91+irfPW+V6FyWC1EESUL4ri7Ew4KOwgCa1B3sqRu
 OSpGvhxS7wdd6g/0dyG1ARtH4lba4OIFoOMnBw2avRmzJiW7Lt4MxcMkYmKKtEp8oE/dcGNieAS
 OwAyTfIJTa2y66WDwkBUgPhzL/YdutUu4+5RcpbGwHxmTESoXdewk58pmJGo4PU8eo3wF062ffR
 sjctDaTHEwBONx4SZutIkpYkYK670J62/U58OeXDiKoYlinR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=c6Cbhx9l c=1 sm=1 tr=0 ts=6a78e013 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=TYXsMWFz8_iR-PVXkd8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfX/nDX7BrhH7g4
 ljb/uTDC6sUH5GRxKOWZ7eZqCJfQwMnG/OkbZ6HEzrALO93xWOZE7effRbVhhBG98HptxUZQMOw
 tdyA4P71QyksmE10uZrE9EV+mk5E5ho=
X-Proofpoint-ORIG-GUID: l9vOJgqt-aLuP9MACxOyjLUCwz_ExePx
X-Proofpoint-GUID: l9vOJgqt-aLuP9MACxOyjLUCwz_ExePx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfXwKfJh1neYBJL
 WY+vj4wgyHk7qJcSQg5T8HUEtCzZFtd5qmkRF+Ppo1KMBAxJ5dxXSCb15W9zeJA0sOZcySQOgIn
 1qQhJcwAWFH7dWCC27wK4vJuduStlqNsZ4w9V3khvqH1Dv5aVI3wBQoxT5d3wUKlDDByQRs7nK6
 sasWqRmD5zN5hZqhxYDEj4E5N0Ojjpf4if76ENl+L2yKjdb8FLHJ7Wed8eBGOHCpDJjR5S5NFPF
 pvHOJaJtvYe3Xvn8UwxTQ0bLmYNTcQEkrwqIZPb+qePImlz+XWipeNtwvUlaX5Gox5Gtjk9j0qB
 ZkXClzpcZ1Oz8j35ilEbl4ePGmOzc8deRuShcm1Jhr6jtTsfatKuehwXvG65BkmVmcG3aGkmWcg
 blWBi7GVM6DdQ/1j47LWZ1A+uHumF6e9WHnEHNWwoI7ER4rz6FqF2MNvrXctKXquW5EgNYctKFj
 A2LJX7vYDXWaIl4gWWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090184

Since the switch to DRM_GPUVM the drm/msm driver can't work without the
IOMMU, breaking display and GPU support on MSM8974 (and MSM8226).

Describe the IOMMU instances and point the GPU and the MDP at theirs.
The nodes follow the MSM8916 convention: ranges points at the context
bank array (base + 0x8000) so that context node offsets equal the
context bank indices.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 85 +++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 06c0af0aa317..ac3058995d49 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1958,6 +1958,8 @@ mdp: display-controller@fd900000 {
 				interconnects = <&mmssnoc MNOC_MAS_MDP_PORT0 &bimc BIMC_SLV_EBI_CH0>;
 				interconnect-names = "mdp0-mem";
 
+				iommus = <&mdp_iommu 0>;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -2125,6 +2127,28 @@ mdss_dsi1_phy: phy@fd923000 {
 			};
 		};
 
+		mdp_iommu: iommu@fd928000 {
+			compatible = "qcom,msm8974-mdp-iommu";
+			reg = <0xfd928000 0x2600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			ranges = <0 0xfd930000 0x1000>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>;
+			clock-names = "iface", "bus";
+			power-domains = <&mmcc MDSS_GDSC>;
+			qcom,iommu-secure-id = <1>;
+
+			/* MDP_0 */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		cci: cci@fda0c000 {
 			compatible = "qcom,msm8974-cci";
 			#address-cells = <1>;
@@ -2180,7 +2204,7 @@ gpu: gpu@fdb00000 {
 					<&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
 			interconnect-names = "gfx-mem", "ocmem";
 
-			// iommus = <&gpu_iommu 0>;
+			iommus = <&gpu_iommu 0>;
 
 			status = "disabled";
 
@@ -2201,6 +2225,65 @@ opp-27000000 {
 			};
 		};
 
+		gpu_iommu: iommu@fdb10000 {
+			compatible = "qcom,msm8974-gpu-iommu";
+			reg = <0xfdb10000 0x2600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			ranges = <0 0xfdb18000 0x2000>;
+
+			clocks = <&mmcc OXILICX_AHB_CLK>,
+				 <&mmcc OXILICX_AXI_CLK>,
+				 <&mmcc OXILI_GFX3D_CLK>;
+			clock-names = "iface", "bus", "tbu";
+			power-domains = <&mmcc OXILICX_GDSC>;
+
+			/* GFX3D_USER */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* GFX3D_PRIV */
+			iommu-ctx@1000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x1000 0x1000>;
+				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		venus_iommu: iommu@fdc84000 {
+			compatible = "qcom,msm8974-venus-iommu";
+			reg = <0xfdc84000 0x2600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			ranges = <0 0xfdc8c000 0x3000>;
+
+			clocks = <&mmcc VENUS0_AHB_CLK>,
+				 <&mmcc VENUS0_AXI_CLK>,
+				 <&mmcc VENUS0_VCODEC0_CLK>;
+			clock-names = "iface", "bus", "tbu";
+			power-domains = <&mmcc VENUS0_GDSC>;
+			qcom,iommu-secure-id = <0>;
+
+			/* VENUS_NS */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x0 0x1000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* VENUS_FW */
+			iommu-ctx@2000 {
+				compatible = "qcom,msm-iommu-v1-sec";
+				reg = <0x2000 0x1000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		sram@fdd00000 {
 			compatible = "qcom,msm8974-ocmem";
 			reg = <0xfdd00000 0x2000>,

-- 
2.47.3

