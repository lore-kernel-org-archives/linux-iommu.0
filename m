Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172916;
	b=kDFrGH3biWMbzQEGemXDQhKnGymAd7poqtOBwP2ZsP60G2o6KmRr2DJdjGm0/HQUt8Z4
	 ltygpWmVuK+qvR0e5V3Gilwm7E9vqnfyi4HyBKnJRx0QdjhLDz4f02ixT0TdN1QqZoHGv
	 YrttLGv/nUBxWk7oNo/XBM1Y77M1NWDyYjHkdMakNW6R/7P0i1pI1K5thzIbHHdxwrtmP
	 LUlNMJNZg9edMYGWlCkdWr/aLzZn5dPs1YsK5u3/GsqFLEUDbTPGb5Y31h1VlLrchRB5J
	 Xis1zuLJBHzSasQXU20CSAj3gv/I51+y1KjHztXNR2W7D1Ym81IysCs3eEGqbKLvK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
	b=hJe2e4vAX9Dq7Lphh0Sjrol8xMCJa4CB2fA+5FSpBWnsUKxRyDERBe9rbp6Ze3LWE1oZ
	 UkzhWznKlvk7Xy5ASduIBf3PPYgJ/IH/puwHXOlHfKdECFsqTi/yUqf2FwNaCS+s2UJf9
	 Eyr56E6V+kcIjpv8+kJqi7i+p3h9Pro6CKfCCBflsDglPowzJPh58CkFJBfKO2liTjaMm
	 Ai+dV9uYzSTnDCL5Nr6/j1r2ImAkKoJnepoOtvVirTvvyQMo/bfk2tqHcLtWjfCHlWudc
	 M58Gg0NRAE4+i+0pK91XYA4Oz14y/bcABqlOl1d6qiK9UbCu1j+kSWAWCVXR0w8fF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jDRa1RoT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bi7kT4Su;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB153606A33B
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB153606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jDRa1RoT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bi7kT4Su
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkC9c1017053
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=; b=jDRa1RoTaVw+kV4J
	iIijYa9u00DawX4XZajLV97ka6+MLEQEBiV/fMXc2mMzpYlSptndOwbjGglq1A89
	OMH1BMildAfBYUFQtDQ29psB8zoo7r3mp2inArRf57qeL7fml9Ua/E/HD2Avgs08
	X6PGKImROaZV31P1FdjyXf9YtRv7ojUQ9V3nkpwY7JSGOuml2T/ahjm3dA+GD7ko
	ElBYa1MES5HNqGrZDoR0o+1gUktwWeKqOStxJokhQOfb3b28tASG+uO2EHMV8D1D
	cZxmO35EZY+KHxbrowW1rHgHg4uqUeydrPP4aMDQ268wzHiqoePtZ76ovX+3rQ0l
	plqC8w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs7px-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386177b0516so1029757eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172914; x=1795777714; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
        b=bi7kT4SuX1jiIhDQ2jShdKmNrBzkpFugWohzlu74167X/YiyD82AsP9uVGp+THHWpk
         tK80O/OgzdTn2sbfDUOGMvkKfPm97va5m6GuG/0W3ubbu8lFKo+/YIl7QniVEv/jXhc8
         2fhebQzXdRxTFBwsfBaoomGe73fKMMwi8tYUTiEhKfWbxEjAI57FkvWakeYTbWQJtQDr
         EulUuDrbMuzhaPR0WzjszbfTMShh5oGIClUvZpP7UDUZj9YOJjWYMQU6CuIH5Yr4elNi
         awaOk3irevSHX/7K67EYRsIgGCbemnXur9jnk52qI/OTjJkGUIDn/N6KzHrzOmoBzaVA
         F55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172914; x=1795777714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/W1FyUMmKaB6WaeuXYdnagaj02F5bspI2VHNpVO5YfQ=;
        b=c6HkJqRGHxWBLjGrFHa40+o7wMjItGCzOAunPgZzZOY6gF4dRM6shWpyLwzj46TkBW
         Y3YtgcxaUjimgEzrMnKFfWfD894Id6TrkZOkSowXiUVIfwFlUK92DKruPbOmbivt4a74
         d/GTcesfBKr8v9uOu+JAK0iSuai5TQKsKeR5acwIdIKdxZIMSBk5I5fw3N74dfPTGrbV
         5z+UzeEEXjN+bSb8N+DzA2gkOWbPGB8GyKY6tww65IwybSHt9KT8AFHJyOVVQdz884Ig
         UyauBYH/QZNUJrKtj91GKy/9ahXZgSMqY+JC0Xs/0K10aZ0q0Ut+nLhGTk4VUAnR1JR6
         T4QA==
X-Forwarded-Encrypted: i=1; AL+hErF5OX+e4yA4C3VLR1oUK+3gV/hEocqtravA2RY0RIqZgnNwCf6VUADVrl84vetrKa5u0qCXzw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Tk1vJxeEq1isqcw2VsiMcvuh+esC7PwCmoEbh07MktTfXgleF
	QgF0Ej7/Gfas1077sPZZpvk1kFYMuSZeBZMfcBEmvhhfKvDopwH2BiaEjrXCj7E8XVBWu4TZpek
	6H3NxAWDAMnqze/im4jBAmbQ7VOS9uH5f5nx32JR9CYG1T7yUZmojXQrhjDKMIKowgQ==
X-Gm-Gg: AZFdTZc41z2lWMoyIjfv06tV3et47vIBm/xt0zP2IPTDfbxCtTN5YhlrcTinN2OG+0x
	zUYd9vCGSTADt5yEsWg0W54nkyT7AFK0FpzBI2x9po5L0Hr/jNbMYpz5HFXwjoNaOO3ZYYfNvn7
	vUoPI4V1C2TLyKnZxwYmcpBYXlUYCawxGfgRsPMWYlLUXT0M/kCu5knOLqQH/4umuvg7SoqJDAG
	DBX4GgwkpECPnXOqdYBOifFWWL6pXAMrbliUYhStsxZ6iGLOCw/REM5GaADCWa4P7pVP+9edli+
	ww36DIwa34HA1Txr2W5CfPLTg/LGss1zYqNEZtYhgm2k4iz7I+4nbGKmAu3fR0yt1aXInJTPH62
	dZnNjWw3556VV835Ylv+5Q7bvjeE9o5+trOImHTDu80vWO3vpyJwiux3WCQMz80c3W9bvKcfwaN
	Hdfbkf
X-Received: by 2002:a05:7301:6407:b0:386:2300:db04 with SMTP id 5a478bee46e88-38623101ee2mr1056740eec.22.1795172914286;
        Fri, 20 Nov 2026 03:08:34 -0800 (PST)
X-Received: by 2002:a05:7301:6407:b0:386:2300:db04 with SMTP id 5a478bee46e88-38623101ee2mr1056700eec.22.1795172913510;
        Fri, 20 Nov 2026 03:08:33 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:33 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:36:01 +0530
Subject: [PATCH v4 20/20] arm64: dts: qcom: sar2130p: Add GEM_NOC
 interconnect for adreno SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-20-cab8ee8be0b3@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1058;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=jWnycFT0az2p/u5EzI2kuq2uyYSvSmt1HyCePSsKymg=;
 b=thxi+hGWX+1dy5BZtvJRpmYMDr9qfMtvkKDe2syJpJn9Hx1JY85585k9BWL5+9rHULVGt5OVu
 82NLnnek2Z5BqczmG6nsufHpIxgrHR4f3gkqXhQm+/IQ6mf3ViKyScb
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXwmOIUGX66Ln7
 AVZiMohNpM7/kdvfBIyIK1oZo/bRYdnNC/RdjRm8f2vZZSLShaAc+8UGy8XwOK+fAwr3+ytG4Cp
 mO4R4qpD0JwruOBoaCPw3PWOIM6brd1XX1N/ek0Fh8y8S2g37XZ2nUdcs4gX+HZpXZI7rOC+8Ya
 wrIxEdQ93I6aUDzpsI+Gde5jLZm1xAGP0vA9mDV/ebv2i6gz/xGgY0e2Rxak4AZwihr37UExXQa
 C7fxukWawBPJvlnvKAJsz734lRefmInF+s5iFgsCpBpgDmJ0nuoievNEpGTC/GQg/PclfIAHV1W
 MmDEqJlimVLLphfzZuzgEQKk1ebuZ949my+aNL/31k+wAAeHdR69oAd+ovguXM5IzNuupsIz+Ag
 PxGMhzM4Ay221JFlxEcux7aKkzeKNCbHKZAry2F6YYu+PsnvOUSy66Uhh2c61e/NxTDUyQTNAuG
 ZLuYVymVzf3a6F9LMZg==
X-Proofpoint-GUID: l-nU8iD9zPv6rJCQSj9xuywOgn-1He-i
X-Proofpoint-ORIG-GUID: l-nU8iD9zPv6rJCQSj9xuywOgn-1He-i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX755fhsuCLIF1
 0QQeydX25fIllOupXRSALSq/onZHEyOIfOQsndoHSPT9pO4WfR3507JQk9mLpT/PKD/oyewUwzY
 TF2KLnkmDjYh4vfER2n3sPWweJuoI54=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b002a33 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BzZyaU2VGnUrTJno3XcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On SAR2130P the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index cc4077005e66..950fb83f26db 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1857,6 +1857,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		usb_1_hsphy: phy@88e3000 {

-- 
2.34.1

