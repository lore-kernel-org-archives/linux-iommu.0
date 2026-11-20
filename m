Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172859;
	b=wd/a3MpFNCFjfetdBPKf78FOc3RA+1nQs7YRsTnig2+rR39CdEGwTlGtW2/E0IhrGDUI
	 1sxyFMKVo3dmNNG/5L/gXrZHtIG9I7W3QXMnKigvlVuxEAgG0dk717//08qkXs51895iF
	 8qP1WfDuY9R/f67qzMhzNZczgQZJGVf3iljqc+WSZbv4mzQd3LDaPygnexrVYB/g6zmq3
	 FA1QTzgXWz7rCHJIkH1YojKsKpA5rRVZQL1hA8X8ffx0KNDBrJAO0RA7fLNkCBP4K8qt/
	 SHNvSn1Gt1DvlqzJ9yaG92JKZaC/GrPY5ZXG6VYwlk/l9HuBwQ0MVLZQbzD7NVn07bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
	b=bmIEXmkMbSglknU/UsPfWUbUrFqycsG+H35ihYU0hqt61yvRhbruaurtYWebeQRibywY
	 5w0ZfLG3hHTQCmJNwFLt7M7VcS8rBNr7vj87xlci/NiLFgJ78UUt1heBl5MkcS7Xp4WeR
	 gijWbdsT0AeD/B25wgiUQ8sVP+0QDXRGCc8TE+KNFnFodh21i54IA4Zi5zacXEeVcCEwX
	 M8A/08y6HTfuJaZeTfzQTZEBR3zYtpS54qXlj5Z+tNnanANEat2NczTMHr6PUgYRr0Vbj
	 /T/4O9uiinm/l3NC3GiX623vqbSAykZ54uiEZVKD8FFnapSKBH8WjagHfiDr16p4t4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="GTksC/Y0";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTyRQXpp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA460A262F
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BA460A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GTksC/Y0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTyRQXpp
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk03o556476
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=; b=GTksC/Y0bKEnnPw9
	KWJMW/0LYKMseO9DPrOptuVo0CoIc1uzdDo/pGQvMUvP1Rvp9itBe4lxfI3YMrct
	hNlUsrpyWDkLVM2AharxTeVzkRw2n9VB/DT4wadGuvHh9b+NKRCRxql7pH7v2UhZ
	mZqqLkNFSwVCnkJYQ6l8xhsR0o3nVGXsD3cWmPJPdqWEiU2pL/iofmYDa+RErjze
	zIL/ZkJld/6+cX3JmMILKva6+SUTpEUn37O/cx2tHijkn57y5K4Vh1GkIqNzw/gV
	9xhyY7hbI1jHiKlk+CMPcKlAgvmcpMCyomuwfUhrzj4E/euJmn6bzVJ0PBKLPI4y
	D6Il1A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbhe1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so1078696eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172857; x=1795777657; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
        b=hTyRQXpp+zDPB/WG06B4NNiQuMo7yfpN2RXVQwF+dms7RpacpfxcT9gzpbEoPmwL6B
         bIILJFXv3gj7HLvvJs/BO0D3xRpcjm/0wBxeRvYSynvC1U/tPkw5M8K12Lzlr742bBlj
         c6rKlT48eitbCn9/eD924c+8E5OIIFpCRKUWz4TGSpeGRCQ1VTe8jVuUwoWjYhFPAoiG
         VhRMz+2yLtt/PnJpfzGCPG4XrnJFNVlEYehALrqc9lE4AysnB8VNMJ/vk47YECp2OuT9
         G5mGZL1+kK+YPjJ5fCH5xn2dbQl3DND1co5ZqpjDEfDAruW07etTEGA828dFm0JuwYkJ
         YejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172857; x=1795777657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
        b=mv2sZ8IYIwm2dxqYLHstzBHwTX39x6GmzqRubJFq15zftuuVHvQ9/npvUvRJXP+wQ9
         YZcpSBhZysi6L+0bBr1x21n+3nJzoaIeGcXrMVeo0bZCOaqOiQRjWBXsX6EBdAnw1Dxs
         I5yC7B6fZdbNGN5vXe7TXEbiUQs2QSsVZsIY2UKTqfL/vQI8spko7hizW/LWnC+A+1ug
         7AyAfwpQlw4VHqQ9QKprsR0UwsksB04IRRd1y5Ee+/KBrmKYXR59NbVydoFNZXUxJEiy
         bidjXI0yYehZQ5AYrpGAvAcUxgDWVUV8e/AdHtkZpjpY5nnu5RICdTi7/D4MvdfHUZiQ
         Bnew==
X-Forwarded-Encrypted: i=1; AL+hErF28P9cJZw8IZG4qa7x3i10sfcMT0QRsa4QjhseDmPLPUQnpHZ64faoQCNwSDtIaCKJiQBHSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+znelTLszlNweXbkbOmiL/JUSCOW9yCj2f1SVOklo3EZXiuzV7
	4o9cRT4FlJkgW79HSOvJxAsvkHDJHYbikvKBsYf+t6c5J3iA1oy/FhJ7kAx5BB1DMi4N1OpuReH
	lFb3ZCHIbdB2JWquZ4OjllNnrtuxE94PACLvfgqImuTuFI96qzzl33SWlsw==
X-Gm-Gg: AZFdTZfVgUc1gYUNGE+iw0MPoGl6nbx9dxUvCIBvU684gJBnh8rtGsFdsqXh8pDZq5L
	UPXI9Zy/tT8K8TxvAnn5x7ZRVtyE4mp/ciCX9zYrfA1YMaP4iw3xmEeZC+Zhc7cU7kRUCC+EbHN
	SflYl5mM+lo9llsahDb+O3Uf/PKWORvHJSO6RWqPeV+JpolbOWw9hofbQSoeOCi+wbJAn09PYbN
	kJh/9S5FSdHv+t0bpi0uAcn3J0AipoS0wvXks2cvi0P9Z7dwQYbQGdfzEzqX7rRrlXHbMQzEMrV
	U2X8W8kL581sCQqlkUnsQc2FUdpuJ+dRivoo0nU2ETK6jSNCNRZZq4PrzB0NHTftzg+I3b7RGi0
	IAKjcPURbHjrIBJ7w7kx11kKzOqSAVUzCAn0sRndwB7/kCHJeKqX6ADDqghYYhmU7Uxr5nP4K7Q
	KbNHTG
X-Received: by 2002:a05:7301:18aa:b0:384:eec:aba0 with SMTP id 5a478bee46e88-3857073eebamr2356048eec.36.1795172856937;
        Fri, 20 Nov 2026 03:07:36 -0800 (PST)
X-Received: by 2002:a05:7301:18aa:b0:384:eec:aba0 with SMTP id 5a478bee46e88-3857073eebamr2356002eec.36.1795172856199;
        Fri, 20 Nov 2026 03:07:36 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:35 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:50 +0530
Subject: [PATCH v4 09/20] arm64: dts: qcom: sm8350: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-9-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1040;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=ifRBUNcG4S75b7wOEESAYY95LUktSUoyNzDBhGxm1EA=;
 b=KzrRMDQ38ir/SxKkvx+iCgru1CcWgzgR7RMiwJB8A/IB8fNZyYJbRgu2266qsmg84BVFLa9od
 DKvONyqaL8uDPLBnrRXftBGgOY2FyIAJWqfqhcL2OUH4V1i97q6YVJG
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX/FxKPFtysxRB
 1Ze9/AgrWXvs7IuUjGZl6VpAjP3Z3pqbhxRphxLAsX1dFKUDsftTDZSwJF7Zuq9mZPa/KMYLXrD
 5QhMdzFWyyOirahtUttQLhP8fYYXk7plHtQEx8wgdy0ySiPKK1v/2x+z9uDZ5puTJ3IpnjrZPCc
 7vJCWspGmJ845UXYH8LA0CS8LrImTNAPRkMUgC/yJerKbtsGknHUmu6TMTxybsmZJuqIjwt0DvG
 B35XhhtvuG/FRQTSWn82bSNqw/VNZ92CSKgqekXYvooPy9gOvi8MAQqvmNmzxsPynOHkkWJsZGn
 fQ5E3Gx+hmeazicoXbkPrIf+Li2LUMWAKN6Go78ttHapQgTOG+XpuMY6t92M0P25DbXVFKP855g
 sATqyeWrttEquEBMd7uFEPPW/J+BuMgu6itOg2kKae6+AZ3yujOatT/8v29wDZTPennJsXZliHX
 SWPyxXeJR+owRxOZupA==
X-Proofpoint-GUID: S4iyUOEWlLZ6qSbocQti6werauyu2xA4
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b0029f9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tc1TWAvYerzeY2VvnAsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: S4iyUOEWlLZ6qSbocQti6werauyu2xA4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX7HbkzXBAxG86
 Hvz22s+2QKU+onzxnwG30PA4DoLMyi/eHSIcAnTv6o6i9Ipfw48CGYiuvwXl1rh0hjnVdiE4bIF
 KUdGFMq27WvuFFEm37i0oUunJK5jJiA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On SM8350 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 7b9966e8fd4d..4edcb06dbae8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2566,6 +2566,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		lpass_ag_noc: interconnect@3c40000 {

-- 
2.34.1

