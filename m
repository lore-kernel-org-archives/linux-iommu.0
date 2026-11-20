Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172848;
	b=ytg53T//7l9ozKxJ3Vzi5RmWRhnpSfWY0H07On5c8x6Wqbm8ZLIUkJRgaYicdeDEGb4C
	 S37dWFRaQUAi68wW5KMZ+eRuWunIv0RU0NJjf+lRVfkeiunZn7WhOHndj4aDQqTcmsp/C
	 c4qPO7jhQiHh30ymSerfyVPtWhjDOnvu35pcCs94hx3pfvAYdCMCFNsI1UT0rrnk64tX0
	 ZOvGr0KqkN39uDAp8WBZ8xHvYUxynB99qPUXL4CAOmKie40ePNL55CkjeQUCour9/533/
	 PVo/D7mEtNM/MsZB4kucEoUGgPaP6TxHVwnCY2JCvqgGrtivGC1uNK0W74GU8ipTkCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172848;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
	b=ouCNzB3oIcUiPmkVKRMVi7t18p0HWxilqlK2nfqw9rLHRod67WADIVawncdxyltxgwx8
	 7umxy60Wibdy3Xyr3BD7JLDp/EvQARWGCnYsTZjowyDqqFco7hyO2IMmxnHn7lJFciVUl
	 sszFhr3jYYs5PYyvHDuk6XAHnIp0P90lFC7SYnhsdqGEhZSF7fzOncWuFDVCzORkQJe08
	 +1QwoTBYlIej1ZOpNIiYab/W4W4Y3/TUuQqhzqrM0tuXyP7ZS5tKKCW1uAYjzLwGB9qro
	 q9O6w239hnITt3vLbNjlKSVXpIPDNFyolKL6uydToYLPfuosvCElIDIdDIlS78Z6+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nn7w0tce;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="T42pjy7/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62660A3807
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A62660A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nn7w0tce;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T42pjy7/
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk1nI2433131
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=; b=nn7w0tcezkDvJ+TY
	YjfSksKFS0SWd13TFzlra4358qzIdfzFHpyCV/vMizicEBW6nYs03wF5hYszYvEs
	5ZPhZLoXnfqhdEKfXn0yNdi6u0iG1qxcomJmCi89w3JOY41K/MmGGkKTQSuF8DK0
	n1aR8iZQB7C/WFHXw5NUgB3gFbm8JNTi0AnBWppd2QxS8oDk25qmUMcdVCxM15x2
	8KNTpfDLCGWsemvkJO6PVVtCreXtDZ6MxoJbi/ExBAPU/kF84EF0oJfcCDbDNdrX
	ZIInop1LiA9xtiWdFXANogVzEb07z+13yGvg+6bqd7YmbzGHy4afdu1kDHMYb3nO
	6g8Dng==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj9f0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so1147387eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172847; x=1795777647; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
        b=T42pjy7/yAa8sxDSj/LxJdJATuG5n7mBJ4tVrEWmrMHWu3MtRJAosBVbcNfMshfc2j
         T03G3BinwlShaY8OHg89KSA0xYT2qqmcNtq0a3xBOJhKeSvDll4iQLVwsRSXbu2UfjN9
         hzVoZqxb/vFETZKTShLHIZMx6ezin6dVHmfLm9Ov87EUnosduGPsO7uAbj8e3RzneZYr
         2CID1vqZUIRAE3UAQGBpra8PfoWF38CnDtqUJPc1VH6Hc0GqwmBVgGomYnmDMRYV1EZs
         dBCa2nknwRyU5bP4urP+mnLGNiB5NnCXH+83f+V7cZxRYcpcCslN5C5LQkHx/hS8Tv7e
         TTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172847; x=1795777647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
        b=t//t1gALPLPIGj0JBMx+owUnpMCbyEUoHKscXG/iO9zLusT0IUiH4layoMRtfbKbwt
         r3EY2TIJoKU9rPO821iV10OD2mFP19q8k2z+uJqGr922kRTcH+4gILBb3IcGQ5jV4MUp
         /o1baWABalaO9ANbYHnBoHauIG/V/pGE7zQVua5aTes33LLFckjVn9Ogs7vJuQYNYFMv
         VQoH2eCXXpi0TuRtkgLrjQn/3cYqLUsrBVoT4ROGCTP2svI/UJRCr1WIMTwD39seYBDq
         c1AI9lYNwjy9h0kFgvuURlpZO4+G4BuY8BvIolyRaXoyCnbrRoJ9hTLrKIlneXRMMv98
         o7Bw==
X-Forwarded-Encrypted: i=1; AL+hErG/tTNmeMRm43qNjWgtWzowa4OkV7Fr+8B8aTGqsj8KABjbDRjPNXX97Hmi3ivx1PzC7AACNg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vfGxd7camq4wrNtNxo08Jp3L99JcAsuZ0RpMd8Ubm0BBQQC5I
	rfujvLH6BcsvMDWIneJXq1slDPOBu/1C6GLbzU/etGPQxqDzj7IStcvPGPIHDnGDz+ziP9C0rlE
	FVHKC5ypYTr4fPth6xa6/+Vb+GW+YKliBMHfMF3W9Yjc4Vs/lOplzgq5npA==
X-Gm-Gg: AZFdTZeXfjcohFrYI8EO4WM+4XGss+yET96Rxc1wAST2vXth8QGgtxUBT5ni4Tr1aAg
	o+97grGK22DKutGEZVQgSv62CeMsQ8LE2DgUEeFowRDQr0QiThWgEUr7om+9oFP/7b0PgoLjiIE
	wpsJHS6xylRzOauUyG9rmxN5fnxOXN45jQ/1HAATvK47WITxEmbQkU9Kz292DBCBUimaPwAtqos
	eXb8NY48LDg533Yc4zDPpV/g4bfnDsNEN1N/nggPFULMQLuLXNdRiZW5lMSUzASVysMK9R2bObO
	KNoVfIkAKg6wNqeWDVUfOI65tXBOI9Vnh64YqSc9xC+1htF8p4Axs6AXcPC0+UOawEhYOgXbh5B
	Z+6W7729Ameoft3AeUr+EcDtgNox+54idzW1y0Kgkx+LlLUVLWeMogVbRhkgAmJTVbgB3fpMPaV
	0OXsbL
X-Received: by 2002:a05:693c:42d7:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3856f84fea7mr2428860eec.16.1795172846488;
        Fri, 20 Nov 2026 03:07:26 -0800 (PST)
X-Received: by 2002:a05:693c:42d7:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3856f84fea7mr2428825eec.16.1795172845799;
        Fri, 20 Nov 2026 03:07:25 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:25 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:48 +0530
Subject: [PATCH v4 07/20] arm64: dts: qcom: sm8150: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-7-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1053;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=9j6IWx76cjPCAQZYybv4iXqHVebU//kZAlxNICMxwEI=;
 b=Y/oksJyJN6vOeMPpNN+xuZE9wT6hWllCqRyWsZ3CEZE7TaASQPRSC4ChsqkoGOgosYBHuX5FY
 UxlVzoJUcvDBx0MHv4SU3wTUjNViJjEt0woasGqy7g2RY7FnPEEWu4j
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b0029ef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2mEde68aHbpXMYUSS8oA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX+sZvsCmqltdm
 IMMfTJmV1j+wIok6+zAZ1Fyuu4cvMJSapEP8N+s7VLoRKZ+ZOAwfVaMFoSvy3e56ZBst8QaVAUU
 wOo9gzvS3EwrE8/WvOBpbxwxbmbeqEk=
X-Proofpoint-ORIG-GUID: -KlyCc9i_kS1ccjAebKZspL_6YxcSmtO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX8opAFhlQA6r1
 fPaWFi/HRaJ5eHGjPgzHqc9RtpTXTKYsoBVh8Ap+rSq4XygtHAa2wr0oaGjgSwk8cDrLOy2TGks
 9CcRUDtgIC8pOHYjbL8KkeTo5/zUqQG8HaqwUOs0/BH9CIGi3KFGDt/MnGxah//46RrVw6C6e9T
 WdoRLFuVoP3b18jxEzZLDiJlBYX1jtQ/Hqm71mvsySS7aK61gF2biLTX4rOHMln2jeAkXUy1kDh
 ZecOFiVouElPyJrNKv78KjPCUzw/yVv3XhoaoeAe0rWe/sM/CDGZi+PCsx8O14L+AA9uH+gzEdl
 AhxpYDI1acHr//Z0+4EUwwjcDJ7mUibwu4xo69ipqV9+HA/5P3W0QGOzgr0tU+rk2kIfKkatfym
 NM+TygcW/0IHtdODLc9ltV8wgL8/w/rjl9jQcmub15upAnFuO3yI3dmf1o8awXR+AsY016fvuWk
 K7LitzWgxt+SNxSHf3w==
X-Proofpoint-GUID: -KlyCc9i_kS1ccjAebKZspL_6YxcSmtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On SM8150 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index b9846b424a93..4b2ff316db72 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2396,6 +2396,8 @@ adreno_smmu: iommu@2ca0000 {
 			clock-names = "ahb", "bus", "iface";
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		tlmm: pinctrl@3100000 {

-- 
2.34.1

