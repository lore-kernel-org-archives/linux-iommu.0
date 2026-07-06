Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE33328FA
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371948; cv=none; b=bdnXkhtZzR0Ecn89bDEZ9rmMbc/i9TKVIUsh0MK4wGRerz/vlTu2R51otTiy7BLo+WYa4v9XgamreVIdHzhxglL6raJ5G8iOqNodpyke5hZWuGQgopA1zSEOICTIg72TU0UwxgSej3GOztbMXlqHUzvdi5Iiobd1kYmejsj0MkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371948; c=relaxed/simple;
	bh=BghuoPAEZNaeJMJPKdJFsDVu1LM7cTUOvUNAAtZ7DPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDuGL+t8w1DmRpuKzFrmL9ImEkgaPpyAOzp9NtJaAavondSX3oxht1dto54Uun9K5b3R1VdjNs74cdSM7I2Frg6FQo1Af7HwIA+yAgx93k3G1fdcXVB0TBbXwhnex+ytfyHTrPx0IzG2ftlHQGKX0Zs1mml+Ya6OR50JsNZNgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XemG46oy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NWwJDeSz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XemG46oy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWwJDeSz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE5n01428850
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=; b=XemG46oyty96A3vH
	JA1v1oCMxOQ3cCOvgMFdMKkWjuBqWU2a9oT2A2EVwVQZ9wJxfXR0K2XjmIpasOip
	aRUY8tMCzmEKH4WtgI2CK9hM3JGSrbiQg4TtbA49/fjZ41NLRUtyF+BMdjxIQm0p
	eI8xYNc+LjBep57d3DBufKXmyiOSn4qRGP45N28rk8jRoF49vFkIk//tW5092ztm
	z2mJ2xXjBfNpQoHICIKkPg7VVw0azqteM17fEKQNRHtICQgMzp1cBRg6vNanNgE6
	O7NE2cxwuZEXBYycSnnQ5zw7E2nWFojH79aF2Xybym/1W8NMsBxOe0/2xDkTW+M1
	1sYbzA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxuhds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7f385887bso50111205ad.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371945; x=1783976745; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
        b=NWwJDeSzzkzwSfjks5cvc6l0JOmRfP4rJUNMI/6vL671SvDpstB9ESyFVzTJCYRopx
         t4XL5mWOZFqpeALcEmOEqVAgA4JAWa2ErbBN8lQixBfGMOU0OdAj/af4vPQB01tqb/RX
         zCktsPULid178r1rIqPG/kKo329K2HKb7QuNw/A2EQrnJU3IZ1IgeE/GHBwZN7PFXgrH
         K2u0xjoi2v/Ofh4G5mcUs28Iz0a/LgfsoDMGeqZVvs1PCIuahi1wxX9It4AyCij2jNRO
         WrQAhT3UvVZGotU1y03KH53HAIb+vmeiSoG61FLtsoZOweMs6u8QucKjGVbLmgRtwkvp
         Syjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371945; x=1783976745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
        b=pfYNWhbvpQSQoG4j26JmF5ZFxKdrE4tM+X5DhS8xUgbIXaJW6w9w2vMcR5GMHcW3DP
         4tP2Apb8XBh4u64cGsQZzMUWoWixK3HvSN1v2rYB3IWezMJRrcU79cudGkNLWHGo/dwn
         BEKFqxH3VlpW7p+IRlaL9RcNx7MSM3qNc+1cGQKVAwcslaUy/vs9JXM5N/OPIpLfmcTN
         8TleucuLzqavIkoUMmrZXw11DhgylAv4ZJJyyFLmmnY3BkdlQrOyEF+/GKm6IRvg9qXA
         j1+XbAMjJyCXLi/lfCpj9YN57PsufCS+H6GkKaNv+kKSQr9TT1ScRGwFXueQeWPAYF3/
         E5vg==
X-Forwarded-Encrypted: i=1; AHgh+RrI3yfn9Et5ZldYT9EOQ0TjN6YRHhFdTOOV5dK1+evP50a1l2M1GR9FU67XC3Tnj9RuFKCI+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwLGVcEPuaODxcTSPLORit/5v0u3kLdI5ISio1/dm9V5AyQAap
	HOhiV7XPxd/JbRJs9NVABjSxkFqo1NYn62Hfk2PR/ar11KT0C/wNw+/OI2mhOmpF8DBvFYXcXLi
	OSfJRzl9wug5raTvYDayfeCMY5xk3W0xNNrufr2NJSlSwV6SVxE60EkqZAg==
X-Gm-Gg: AfdE7ck6L0KcCm3W/EKznSKEsQkV3hxCU6v33/ZUqAygpOMpXYR/wY4+GTdRaMw9zc4
	strLVf13lpeSsFt2oOH+EsndnsbP6e8aZZ7OpGowQwaId0cKR5QKx2l+5hjCw0eMy0wVjgva75k
	YH1ZipGpDWsXZ536AaxG30x+233UNx0KUW3BrfGQRYG4Reg5M7fg0oYJ4Uvxru+zVGDSWjv+CZe
	+sbm1may4QT/rtteALTHXk8rzviGoGJJ/mBgagsdF7/A5tf6VMZYPAayh5g7LLcVjzJkLm3eQ7m
	NzhTeSX5WKDUHK11UJgYKWp7K/oHhYMZlyLPjlyK0Wn42hjOfWiOxAihyvEzaULb+LKq9/g1raA
	yXXYiNOAZV+QqDdggyUmvGchBQKlcSu01Pao=
X-Received: by 2002:a17:903:19ec:b0:2cc:8ad3:423d with SMTP id d9443c01a7336-2ccbf041c8cmr26646105ad.29.1783371945164;
        Mon, 06 Jul 2026 14:05:45 -0700 (PDT)
X-Received: by 2002:a17:903:19ec:b0:2cc:8ad3:423d with SMTP id d9443c01a7336-2ccbf041c8cmr26645595ad.29.1783371944672;
        Mon, 06 Jul 2026 14:05:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:44 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:37 +0530
Subject: [PATCH v5 5/7] arm64: dts: qcom: shikra: Add A704 GPU support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-5-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=3495;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AFPL1mLXpKffrlVn7dhyAuVw3rCpzngGAE8+zg6xtsE=;
 b=Hg2Kf+dWXJ+whlWJjf8ja7E8O66IAXgviTZ41pNM+vxeAaoMmTklSyb87ZwbbzCvOrJtjZe4o
 VVlCMvVeNWWAZQO4FGDVlUVdpIrYZG85JDUmqOliICPcLii0AxUVNsV
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: c0WET84dxFGY6cZmIzFgY2qoi2lia4Oe
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c18a9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX4um9opGtJi/1
 M1FSahbBk4zE30Wbaa+9uObZ7Q9JgH70TauJcZvONArENpGjQOype5Zs84L/ySFCoW9wL+9Q9Qz
 mRYui7+8QNEFfp+DEj/6KSflPLdzAfo=
X-Proofpoint-GUID: c0WET84dxFGY6cZmIzFgY2qoi2lia4Oe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX00Ga9WERnqwy
 AbYqnIZJTbF9vHdUkrL2Vx7xLeYvFP8IOGplm5uUrSMhEM5Ahk21/hb64rghh8rrCluQ8L12v8I
 QJ5Zkxhl0Emku2oUzZrTXzyviN0sN26E0oFt/G2f3aUXgTVsnM3mPmYAyA7gfvmPB5HuXApNCds
 MRzLYwwMN57ZRWKIxuOrPj/QdjJzo/30ziq4HJ8Lcl3T1ssEV3P+DWUKsvSR78LEHM+d82vTh/g
 U0CDFTDcikZgUv6SiN+HfA1hltYGNuhn12HllzZ0mccKIVGAMQ+J4QelVWdZV4nw2uWB4PJ/tQj
 F+ywU/fQrcF0NwnYxD0eIMEh0ExnAOyGdJvuMpUVePeDx0ieNHK4FzqTUqMxwEZE3od9rm7nnKP
 a5CmWVSmWJ+8QyNbaUVc11PmSnFmR8HBvq2da7Vj0ub2H78VnAzLerYr1O26CZkUd11/BsI3pWZ
 /2mYUCp3Y9ZKyqxQJFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
interconnects, IOMMU, OPP table and the zap-shader region.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index bb11e832d9a6..34261221664b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1992,6 +1992,104 @@ glink-edge {
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-07000400", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>,
+			      <0x0 0x0599e000 0x0 0x1000>,
+			      <0x0 0x05961000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interconnects = <&mem_noc MASTER_GRAPHICS_3D RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0 1>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1142400000 {
+					opp-hz = /bits/ 64 <1142400000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-1017600000 {
+					opp-hz = /bits/ 64 <1017600000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-921600000 {
+					opp-hz = /bits/ 64 <921600000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-peak-kBps = <7046875>;
+				};
+
+				opp-844800000 {
+					opp-hz = /bits/ 64 <844800000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <6074218>;
+				};
+
+				opp-672000000 {
+					opp-hz = /bits/ 64 <672000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <5285156>;
+				};
+
+				opp-537600000 {
+					opp-hz = /bits/ 64 <537600000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <3972656>;
+				};
+
+				opp-355200000 {
+					opp-hz = /bits/ 64 <355200000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <2136718>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+		};
+
 		gpucc: clock-controller@5990000 {
 			compatible = "qcom,shikra-gpucc";
 			reg = <0x0 0x05990000 0x0 0x9000>;

-- 
2.54.0

