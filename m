Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172890;
	b=kyZk/AXNfwOh33ukIQEcirM2YsOTSIGOJiv57arqFwWGouxOA89nerZpewH99/Kuf1Cp
	 hRv7vinXlO2J3HnxREEuoT8H4lXi/5X8Y/oxCl1yA6d+jmKZjnMm3HAlfp1vYSuKjkCSZ
	 Of8SE27E0+MVLtN19EySIZuap6+VdRpCn1qdcAW/bgq8ffSRoZ8vXXdxgw6vBvdeMnGax
	 xVw6+bY58CIIB7NI8c6q1e5SdWcqN5DHbA7DzsdlwOXabMbQ5Ybn6CbhN3gu/gL/t4/0q
	 zrtVpHCgLNub5l6PFy2wQIm8TBmvEp/R6huM0Y2uN8iaZRkf3UaWagA2Ty7O8Tze4MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
	b=yiDkTn6U+OgMsuU/e8SVB/nISGj70In3nZebOidRVB0gGsoq6UuvM55fZJ/Bp+IH1mgn
	 4JIRUxxJiGqkJ6KTfN4PIuMcKuAzrCUCLL6emtnkLKodWIaDOn++orvcnVPKw7pojz6su
	 kEuX8tvhUu6Uxu/ZNSsjefyMnGj8z8chWsfxVfXKVdsVbz9DQGn9dClPjJtrZxICEdHXv
	 L+wNPoUhFPDfWID0ptMVY3Ne3rjkUoKnb5CxI99FFW4HYKkhAuLW9Pf4FHeheAYFttdUv
	 VZIlSNGvES52GTqdjddWxJ7KEWslN/NLEQ5zQE6jTALNXIja013/wFnCEUstTHjBamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a5z1jAs5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chGS8tkt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21060A2621
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A21060A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a5z1jAs5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chGS8tkt
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjt471528527
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=; b=a5z1jAs5MMdI0hy9
	/2sSylcgaFjGeMT5+JQIh628CxXAkjfvE755/fL9f0OsvxCeDWj5ivd/rlibN1n4
	Qa+fzaJNafeiNUnRu0LFOguj5A86icgccw440qy/gvvJTboiPZuvxSrGzh5F1Nr3
	sfbQq95BT8cJRKWJx4AU5t11Y9X4O6FBOlasoDB6Oq/76AZOAtQMJ2J6J+VKMMr/
	Coc4Bo/iNSUu7te1HH3XdtDKo2csilTZOCnD6x9l5QgQwT7ym0M2ldbfM6GFJLk8
	qyX7GLmnCSTA8B/6rqgXY/ZXu+2L1FfFYpdXIj7jsIFMZII/dvhT+QsCyUoIlUos
	S8ZhdA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtsgbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-382af5cfc58so2194887eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172888; x=1795777688; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
        b=chGS8tktOu/wReyGdYtfMOrPbWSUJYrWDVsckE6hMGSiKHC5UUrD4JGNkuOCpVDGtb
         X+SgJxIk2iOOstHAAPF2sLepIbXfrK73aXekLCMIz80zX3dCNv7c4/7u9DVBtY4u5rVs
         lPQLhOqj4ZsYfrZ+DeeJmTf8e+WnCcRGntSAd1cYvckhDz9onV2FESKJqQiFqEnRQ+qd
         wEIU6mpU2nvSlsv7+b2nFvtaHmw5aQEpGsI5L306f4VsLChlphVAuEYJuJp7TdBjD1VJ
         5pszV2uFu1aE6ftnoBOF4BvTw1nBPjzzpcYV3g8jYegpgBbwbpSIgNd8vE4C6iD7yNPU
         Rqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172888; x=1795777688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
        b=VAyCT02xFfkKiRjCuwhoRmC+4dGRv3sv4eHjai529B7/4AFk03Omq+u3bGqmYTiyqR
         1OqIEla6EhTDnDSyrf5OvyL3p6dYRbZqsHVR1/wMGc+XfRorUlfWzdIsu1QzuRo9Hy1+
         B6XDb0vOrOa8fCT4UMlTGXuw7j1Wo9ByUjTvVxu5ys8lyKDzMMR/InZd8ChCMTFAZQxm
         1V4nIXm9wmcBoLXh1SMDJYuE9jTeSOq2BnMlFLXXm2Qf3rVUfoykdXNAVI/5Q/uA5zMc
         QirUazc4Ws5hv5+1WIw4+Ij7aBGE7gd3wm28uvEtnwihXXiUye7FFfYORHG8OoFGvzvi
         vFrg==
X-Forwarded-Encrypted: i=1; AL+hErERVv+Y4zd8PQkcdi+B55JhKi4lyllqLbGWEFcaLWSIEpTEXAhj+5iQV3Y7JsdLJxP6PkSJOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nPcvPHu7y5Slu//01YlcXw2pUEPsnygijo9pYPGVOswfphczZ
	c2Z/ng4UuVFmQLRhmi1HG5N+VbAcVFNtxeWMhILmVweE6c39xtIayepJc9bTDCgX6lPa/V2Q1h2
	N6KbC+Snt7ZEHRHWLLKFz9uZQfa4PlpEWUD2+fBYcD5kryu3PAhUasWuSOw==
X-Gm-Gg: AZFdTZdglG66aYl2tpmNk2mxnOCfC4IW37w7/0MCUcpgNDYiy/8+UufC/qmNpNrhyis
	M2x3yQRymi+WwbF2KhABBDMCHNghAB4PB6c0ZSCl9wBnFOU3iMPdtjWTsOWYkU4F+C8yjuIMs0t
	w3nwrBrP43+p+jnL5IV71NvSpVBHzFOY51iCcBj1XSSllXRWhVZ/prr9c4MfkT2GF2seORT1dj2
	VpYGujT1yTJs848AjFz9J8GCE5DV++80DCXBQOFjCCYr3jP31T5U48m0P2OxqPzlXmUFzpvW79d
	snygWmtgZ7fTEYMg3/x3qR8ZmUGQeS6S+4DXkrPW1rnYdoDP5JmFqQ/z+qME0SVeU8ZCznhyXhI
	JXdesmGgQ4wdKvJHc38vxNYE60YWVnNdyfXK2D8tRg5CVSy1pFR571I9viEv4XLeqSf5YclGy0J
	ubUwDS
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr2199507eec.39.1795172888157;
        Fri, 20 Nov 2026 03:08:08 -0800 (PST)
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr2199453eec.39.1795172887470;
        Fri, 20 Nov 2026 03:08:07 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:07 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:56 +0530
Subject: [PATCH v4 15/20] arm64: dts: qcom: hamoa: Add GEM_NOC interconnect
 for adreno SMMU
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
Message-Id: <20261120-smmu_interconnect_addition-v4-15-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1049;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=o8a7Ojp0eNjNzQ0rCM2WmCZSQ5u7xFkQL6aYtQmrXTk=;
 b=d2eocCApPGXdnTgSfpyPl1IT3Npi+VGzlX8Texs24AYeMDJUpxzteo/necfGq9pPJ+rGkHPav
 w2QQPhTc/MEDRSCceJSSG8DMzmugQp/HbB/FtH22nfxMVhA/fxUyyUl
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: 12mf9IROcsgw05r9UWSF21aNFmeVgnM7
X-Proofpoint-GUID: 12mf9IROcsgw05r9UWSF21aNFmeVgnM7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXyUgjGeGKYypd
 c+hKOWIc6h/IsGLq9HpQLpkLOtz2xuxmx7CAKn2hJPqQM5BZ1VfKgZb0v2nJEb/GbabQ128lY+A
 hg0zmFFs0c8Q//Qi+UN/EnhyFFV8PbJsaUQA01+UnwiqNUIxDG0htnbTGIokA5MsN/OrgB4QUPW
 Q+wDrua7inMBcgiRo03GpWPx7FSVd/osgMeS63qAxwMwNvI6R2yUmbGc5EwdgxnJOCkUXfbImjP
 +xYRODqKfBSq7gBzscaOsuN0WkNDSeuSSBAagW+Ol4uTFA8lgwXrNGsoKLq/M4bcr+xofrh5+5O
 hOPpg5BJLy6lz7xz1FPzaZ9zQUcmrsAoArJXDgK1G3ph3+c0s5R6Loog07VmWyKUFHvhBEPU3BG
 yoMzTaFQGR0invwftEnpognw79z0cJW+CVySjamvyJMwiGo+XhF1iEilI+NET/SUCRJTdOmZQ1u
 zH5tQVvGdzSL+6/9Sng==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b002a19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WAcSZy-hVgrt5OVmuNwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX+YNJcXZAVyT4
 kpyIAaB0w2FSSvsPzAkKdDJBUndl8mvOTwHnUFHHMocsulItydbVVQGbf3u03wnCnuXpdt9T0td
 4svmO6+2HQ0G8rqbEST5g/fTg01NZJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On X1E80100 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 443c1a5c212d..f5b720d73a4e 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -4289,6 +4289,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gem_noc: interconnect@26400000 {

-- 
2.34.1

