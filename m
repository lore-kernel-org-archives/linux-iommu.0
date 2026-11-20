Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172896;
	b=B9n28iX4eNsQJhPKDVkthIaOK1F4rw7wxDp/tc9Eo3NT0wuh/b66aIWwILdtLdfWDoPz
	 1PxExCw5ashgvx//+BO7FcN4F9aatp29tyBRoVbN6PfnPvTfvKwPXc9xjPplxTTTq48Xt
	 oQm8d4X92DgUHWwKDSevxx9aqxtJWz0iarAOvv1WP/TE1zOxLkXuULNe7abSKQzZL3kL+
	 IW6FlhRlwdAs3UnOqXcDP7xMeaibSav5vVGZV9bUyKQOybPA5kMK2LAnQM20n5rdvqrlS
	 o6ukDsCeXkifHOWDEx6LQNvhq0Uz9hOL0Qm+6dj/Yk+qHXY9aq/ZCDU708fQ/yaehZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
	b=lsFvM3LNMKVNFc5SpBDR9bOph4vx0nYxA0gMxUDdcTuLqVdQ0DvDLnwWCX84CFcpYu+b
	 w3uJfeMuvGiclhB2EQSe2zYSgqD5TwIQhALmYZCOJOpfilcHyBHp1p5NSERrVmzXg+uws
	 7RLVQewQSxfVs0yH49q9y5XuW0jxVTckWDUGnCSm1JQC5sbOjk5O7eExlfyWl7W0kl9Ev
	 KYWThLlibLl92I/M9GqT1juZRqLRHzA2ApY38Q0tPVRITZI7HdVSJNvhazcg1H34Tt/03
	 71SeFfpcXINVEtQJzMCEWWbRdy2wfYI/xcFh9K4pWaedqbzzQBl4nhN8htgeOAqGVJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Znk8sWI/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aTyW55Kt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3860A261B
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E3860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Znk8sWI/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aTyW55Kt
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk75p3731829
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=; b=Znk8sWI/Dw/wTngZ
	niNrsQsD7OA3RaAn7WIYdaEwsJv+qgi60YoGMTHMJnAAJyDcSIn7L1oquNF5ObtO
	DXt8BKUE7MRQKhVukiMOxKocV3dYhEaRFMhpfPl23d8JQ2eRe+Eaf6bDTfL/v2HT
	4c7hrHGbH9WXAm2r3urJ7wrhnYJYOOrfpLEfVdr02H+09ebcROjlGBxLI2DCMjVi
	4cFcZINqIMLLC1I1DDILX9K6LsrsoDsY50Qsmcf+MILF0lgUuIa12lkW8Ojd1mbD
	19243BK777MlIdjNJzLRWqL7u+/muGXsVa36TNudyE32aGu/K9hTlykz/PiLicZs
	RTzLPA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4g3xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3724667bc16so592335eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172894; x=1795777694; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
        b=aTyW55KtN7qU0mRukCvcGxuP06eo0e/DGgI4owoKR4IOACR5/UqFW4afx0F4huS7j9
         MF1juNBGXMTqmoANOiQumPdAuKxSq2GsDlvHRSVp0JYNGxfce2EaP0DptrQvn1po5aS5
         ymWltGjH3iE/qAwpPJWudJSMWQWniTSTRAhlQR6V/PqASWDwZzH/x5jbTV/7r8U4FRMJ
         FkAaMXLJJF9sPNEDzpf4EwaAJjoJqDUhbLq9Xb6hubCep1MCel/N5/Kcgkjk2dKGHELV
         0eE/8jXX03LOXqO1jmCegbhZcTgB9eFfB63CGHXXednnZHUrUyfwzx+aKBkVec2ZdRNu
         0fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172894; x=1795777694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1n8AvJWAPVamnEVhs0wyLEjCYaGptaUkE4x1OLf2QZA=;
        b=VkPX6AdNjWoN9aJE/gKxAiQvFl7hAGCI6aRz3heY2lAITqABlXnMAgvVwOpFdELPtZ
         74tfO+H2gS+saIfFGxJMBBCyol6/jkL2JMaC7LygrioU/fV9qfVIjk0xfbxjfz9J9gNY
         8t0v3nsqwdBi4ZIuPhX/uqFUxuv8l5QDr5S8RKvpvcxBTto8b314ufyD6yMEMPJNF2mG
         RtZc1V+e6rFb7RiOdSLltEWJTA50+Kt3qdIkiMLCFHgCA/InmrTPTIWNCnCSNWQpTLrK
         TO0GauHEv9qa1nOOoBAzl67jJ6a0CILiyv/j7WR5yOwRQRxC2X8DI4kWig5xsxV0FwYc
         niig==
X-Forwarded-Encrypted: i=1; AL+hErHQF+dCv0Sh07oyXf5iibswC8hUQzanLXeNxqOlszhgPjTL/KPkHPbKZbTJzsIZPmpebgsqIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8aQ+/4ixhYmU7W0ShNAu0yCHRoxj2s728GZAh0nefqEMsYLYv
	iTx9eV1Q3r8Kj4F5kV7GDHzrFBiFoseZPS4f5f/SylUJc6/v0iBL8KVGUNxil7KSd3Cdp4pE86B
	VWc5Ls/UssLTFk4b8sY0Jb+D+cNL+SlW/oAKchBjDujhn52W3hn8bnWp6lZqAih1Xqg==
X-Gm-Gg: AZFdTZfW9FRo8QVuySjPKcsxjvpULH8vwgWypDqJ+1UUYqh69BXpRRCXmxlwl4SlXFd
	/ZE2Fd5a0XGr8mHfnHVodQ10YyNngSVrVheI5gmFMdrGT4zjls+Q3U5MiQ0EnsBBFLAG6SNhWaL
	evCfrCtug9O6F6dejNoCgF4ExppsFVVXGqlh7XzSWN08zr4izkrnKfPHWfZvmbO4M/e60hpsX02
	3IBM4R9AW04IRBMXnmLsuZ3aKaSdz12KV39bDDTqfx4FG1beGsjK6p0nL7fSDc+ZKEtQ3txdxjX
	QleVrFk/lTPbktc1zhHXIRHPIfrumJ1Fi4KlPOEjKOsAAqi8DzOvQstcE4fZu338xzIWikkxwdS
	9aYlLPHQY97/H9Y4cecv3ihlMThoKBOtU7iCmTZ1bJ3G6Br35U0sdeGmSGw5uX/lfkQmHw3yNd1
	mqKHIs
X-Received: by 2002:a05:693c:20ce:10b0:385:ab26:f3ad with SMTP id 5a478bee46e88-385ab26f492mr1852854eec.0.1795172893400;
        Fri, 20 Nov 2026 03:08:13 -0800 (PST)
X-Received: by 2002:a05:693c:20ce:10b0:385:ab26:f3ad with SMTP id 5a478bee46e88-385ab26f492mr1852806eec.0.1795172892688;
        Fri, 20 Nov 2026 03:08:12 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:12 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:57 +0530
Subject: [PATCH v4 16/20] arm64: dts: qcom: kaanapali: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-16-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1086;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=VBW+lAkn36GDWfLSpCvNbA+g18nHUbQQFlmvho8wcKk=;
 b=3u5aWyWWqvX72lbjGg4IOeHiJFq52q50gfyaLIyAg+4JVQf3SFaLJL0WxkzSJ3PimsuLOiRnL
 cT0t8ho6a2oCiyszc8in30bpVfEtvHfZ6d2fNZiaDAJIgqRMW0zW3a3
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: zTkzr21ZA4_Fa6-s1s6u0vIEAN9b9u5m
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b002a1e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=iVAGZxyPhfMzDMBdamgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXxtjD6zFPlmr4
 9Iei9EBmNppq7bxK3pMPai3nK2HTeWLpdgiINevl3nv0CCm/ilTDXKfu7GRoD0EcDaNoxN9BG0x
 nOLUTXTVMLJT8UFsXMh33qLKRf8EaJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX8zKJwiOBU8BG
 2WRFmRXbEDStc5fRi5MXvUxiy8ENpZCWVPuBH/RT+2V5Ke6x7jD/nGmPuiTy9pXMHDJc/B+Hi5o
 uoEjG4pjmmXEzKXwxA4jj+bGEb7Vgd5E0bz/hFYvL3XN1jZ2zzI8TAg7erKTGGbA7DWJUSp6kew
 O6ZNMaD/skZVM1ySOatO4COdsRDarIMlpxPj+ia4iMXAz38PM301Pt8DNTIDMTyJH4EFmqImxZs
 1/ux0lp4pquxRpgJePOgbPVNRynUAcsFYnzfZrceJ8k2qQfVPGNE0lW7RRu6UgxT6PbGZ5HliQQ
 jPPvV8Zdgmfch3mxWkHidY0qTJ0NgGmpJKYg2nuIY777+aNJsdoGwYTNYSt72wQWYTK+GXm+87a
 vVyiRkW1M+Gux4GnjfJhAFsUbee+aWhrPWd/sMwyELoLm3iR9eUPm6UYoHPpZixy0NvooPU8HAO
 YFEYR4m3J2eAr+9wzbA==
X-Proofpoint-GUID: zTkzr21ZA4_Fa6-s1s6u0vIEAN9b9u5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Kaanapali the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 9f04a5ad75f2..eccd5451e875 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2997,6 +2997,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		remoteproc_adsp: remoteproc@6800000 {

-- 
2.34.1

