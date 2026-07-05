Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247F36A35A
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239338; cv=none; b=Ga1MOafjsk4m/ipZ8DR03XdfIV4GAIOkcNt3BTQ19PZfQfLySHf3HNbRa3uZoFfg3y0uBGgqFrBUYtnnohnTu+r8bLcijssWTaziWLAJOZvJCnw29Q8w4pW4e1ob3caphW+/idtCQ17HYHnhSY7OFBvgNJ52TIzAjbv4lFFTzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239338; c=relaxed/simple;
	bh=aslSU2Lpvqb8dwyaQ8YMkjZ9kUmX9fUts5FVIZUAkTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3yLluEXjy4XHjDB6cWxEFJagJu39ULy4yDj3GDg2W13524CqaZkEZzM//qdwrzDlpjiwZTkat0j+rmXS4XEqxBzSupghtgF6gO/ZASP+kBUUm2MZwHR+spekpwUzN5I/TDVK17Svut+MdtWarMvfRZYqlzwaYNkr0vUwPv3zvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IqjMzpkl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jE6VvsF6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqjMzpkl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jE6VvsF6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6652gocA519328
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=; b=IqjMzpklbdTVi2Sl
	eJU+QuXMihuCVjTL8+eQIS+B8Sng6SlLTXsHqA/PgfjaZwyo5X6kv9TGVKxPgD5e
	p5bra/LAAZAiQ8zip11R16R2Gdfjln6QhSJEEcdas5k1lPq0OKHOIW1UlXAiPeb9
	U9RnZC+tk0FMue+ypLLWgDKEAZv77mXZu4S1m6PImdnd5E4oQKGCniCNulUEX65p
	/gfgAZuSnuZIgmKTCBYRBwDvdci9K6wCIb1nUDUB9F91CCXT91DvgfGiZNNqd+uE
	WTUhOgcvs9c4CFEtkn2OKChWA0f9f4eZzzPdzENs5kt+4aoB7P86/UzN7pRWazSo
	35rQ7w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aarw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:15:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc8bde6318so3392995ad.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239335; x=1783844135; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=;
        b=jE6VvsF65KXFpWwqkvewMY36R/icaBYGS9AkwjkRO4NqntqHaNX7kDMGuBkagAjZfF
         yHHsGBM0ZLj3gdux8S0JXywn4bGJYFm7IS0yLPmZwfBVWqv4Mh+HCHRWIzZflqTVnXCY
         6jmafZdMK3Poi+N1dxqRXIUodqjkL7PGysJC583Qu1EynKcvd3DKavvBEhgPXF66a6yG
         vmab/sSEfF/2Ib1jZkHHIw1fMBUJLgeNfRat0/8WygH1vGs/YaQw6C7rHrGHD+rUsJH3
         vtiGjtWtZzK5+yWlPpaID1i2t366fvMiW0hPpJEqLVaKW9TCcsQFA4D++mBkOly+o5sA
         LxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239335; x=1783844135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=;
        b=GbHXhXDaYC2JEnf+vJnbuDCWzPlL7HrD8onray8HOl288F2pPnsyPls3DkaJNZGIlU
         NjhqYA9L7FC9Yt6AHTppXK3Ve4fSjkasuMXu4JSPoRyClEiI5vjVhruf9J1PX8kdVfcw
         06QGqwGbCiOZnTFz1wJ/1C7joHjmCbjsIMFPrAFg2AX3hdoqvFHIEEwgJ9DtNJnYjq0X
         od6qfLlu5zAk5X+0UCRP0N9Oi2UslMCcVSO+JsOS3lOumZ404hCBLkjYPPeSx02FwsZS
         6iskKgcqwHkNlwi0dpw2tSMKLPWSUtXiFy1/xPWQtSlJ55mio3x4jUtwZyNHkcGtqufW
         Q4yA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+mgp5SW6w1yfJ90lW/lot3KoNNnoOnoKj34U4AlbF90EPckNXwcE9ZXI+Prs8stW5jJZddg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZX/x3fepGH5LAL3QB+JXa5a87hgdgCrWOb1E1yYqctLAKoFzU
	Jk6DcBS57mwgf3z62MKn9IECXuRG56FBACkGJx0xMutfMoES7gBdAfk9/E8ygMI73MufvXUVmrK
	fv0CkTfu5GiJIA8gJxTt/GzLLVulJ9HJaj5pUKNrSJcMZJ4gySuWAB4XQdQ==
X-Gm-Gg: AfdE7cnoespSLe1RVx51A/LtWhEvSCG9Tgyh5P8sHn/cWriCtZnCvU6pZR8iAv4tTyQ
	b5NOBWjFsLKFnLocNgc/bhuGbYvVmogNCXUVbtV3Z4ltXhVIe9K7kxg6CuUs6m5Jp+P9mB217Nm
	tNl4yOahOTM8f8EbmI+KAjwgEgNhyc9VDNDEGGVJuOU+NWs+iaXmZvzI121rKqEaf5A97aZWEtd
	b4RMuh2SFchfl5WRfKiPwlzmqzrwZQ9B/s5oazU9RTsAt12ll9aWumLwzyTtZzV3q6g7Ze6+dEl
	LRcGTzbdKe2zxHkqXCE7Go7/cc+DfPw160I6kFyxVQgFHVI2RzvJ0vtUOdc5qyJSTRqVfD/heLw
	WkhFJzP3dc4xlLz6b+QBEbk0PstNqdcOqBlM=
X-Received: by 2002:a17:903:3c70:b0:2ca:c01e:8836 with SMTP id d9443c01a7336-2cbb201b5c1mr54322645ad.13.1783239335215;
        Sun, 05 Jul 2026 01:15:35 -0700 (PDT)
X-Received: by 2002:a17:903:3c70:b0:2ca:c01e:8836 with SMTP id d9443c01a7336-2cbb201b5c1mr54322345ad.13.1783239334746;
        Sun, 05 Jul 2026 01:15:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:15:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:22 +0530
Subject: [PATCH 7/8] arm64: dts: qcom: eliza: Add GPU nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=5380;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hj4XTXJRwVTJobJx71cynzfN1k4QxqJRtGjaWZFWW2E=;
 b=35fe4KBw3FTsKp/hdtdHgczUQWi7qZh48PQEJWcKngdSxoOThZmRYCaTgT42VxCbWOhn0KKp0
 UEUQorWapK4BW8DnOpoaHEFoo0f1BSJ+my4rJ9t3PMLzdO39S3p3+89
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX33yHlFrXjBb7
 0nOxSFE/tNfvpllrPRXOeqbEQ+HoRmk3KUscMNqFFQ5knwpOQ0gq+Z1T1buGY61JUXd5cQE1DIN
 gAMkb0MKetOg2HkNOfZToanqTHrjSEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX7v0u6DN1Vm2a
 Oq55rwdWG2daBHsqtb7HewwC9r7+odl06OW/S8+UZE1M85NpRzeCVCcnP/BWnjEHoOo3hpNpsiI
 02F4WWB5pSdCNC8zhkXx/xVHE+zrgsrQZQgQ1M1cv0kYkGrlP6UyftXVI8+G0szSnz9DZFCh63V
 MosE8RIWDsXZ6OJSgfiznOsTB+h+oQkKjj8sVVqZOZiJiE+bBKX6BH/tuFUAALRNzUjuoNQ32Wp
 iq/Q66zvyOi4uoG9Uqt2MDPkm2SuUEMCydPwLJO70w2S7GQIPBCEcUYSVvp57hHxhrO0m7Nt2Cl
 Y07CV1DiWXqFqv4JZC+6HaWbxDGz/3h8bajjYBH6Df2p+ZeLxGy330gYZL/3nh4CwqRcycn/o+g
 850qUUc2LQGKHUsTHMeTDCRT/2FY9A6NvTpqu62AxTbWVnqUCSfyR+pSHV5mE7qcBMoV5eq8SBn
 mTQRwS5WM/AHVWheUZA==
X-Proofpoint-GUID: Dv3uFhoppEbvWoSV1pjOqan_p34nhmaY
X-Proofpoint-ORIG-GUID: Dv3uFhoppEbvWoSV1pjOqan_p34nhmaY
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a12a7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=p8LQYYvwJZuHz2WWpfMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Add the necessary devicetree nodes to describe this GPU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 152 ++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index e5b8377e6c3a..c24c5e9695d5 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -3742,6 +3742,158 @@ nsp_noc: interconnect@320c0000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 			#interconnect-cells = <2>;
 		};
+
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-43020100", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0x0 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-259000000 {
+					opp-hz = /bits/ 64 <259000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <781250>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-345000000 {
+					opp-hz = /bits/ 64 <345000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <2136718>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-515000000 {
+					opp-hz = /bits/ 64 <515000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <5285156>;
+					qcom,opp-acd-level = <0xc02d5ffd>;
+				};
+
+				opp-645000000 {
+					opp-hz = /bits/ 64 <645000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0x882f5ffd>;
+				};
+
+				opp-724000000 {
+					opp-hz = /bits/ 64 <724000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <6671875>;
+					qcom,opp-acd-level = <0xa82d5ffd>;
+				};
+
+				opp-796000000 {
+					opp-hz = /bits/ 64 <796000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-900000000 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-975000000 {
+					opp-hz = /bits/ 64 <975000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882c5ffd>;
+				};
+
+				opp-1075000000 {
+					opp-hz = /bits/ 64 <1075000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
+				opp-1150000000 {
+					opp-hz = /bits/ 64 <1150000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-722.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x35000>,
+			      <0x0 0x03d50000 0x0 0x10000>,
+			      <0x0 0x0b290000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_DEMET_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "hub",
+				      "demet";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gpucc GPU_CC_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 0x5 0x0>;
+			qcom,qmp = <&aoss_qmp>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-220000000 {
+					opp-hz = /bits/ 64 <220000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-550000000 {
+					opp-hz = /bits/ 64 <550000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
 	};
 
 	thermal-zones {

-- 
2.54.0

