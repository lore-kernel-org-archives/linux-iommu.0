Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172911;
	b=1v5EORbsaa/OPLVc8iz3xZdDnJMs4zmYd9e2IbbVbGyszqBF8wQoo/oBBQSBteHQW+87
	 H4PBa/YxvO+k7XPBCwdv/Gg505byABtZtVYOkAWfQtqF4V96LdV+351fJgF0Os60xWbUs
	 zWF7CZeof8fwW9qR6uFpNMeSObJzmbiGbJkR6pl8f3Uyxtxt6hP4Lmp4uWVwWEv9JZLPt
	 d5mmPe6OxZ+Fc1/hZRH2I43ANuwklsFx+o/Tk2VzrDIKPsIB54VPODVi868+BIHgCk6Cd
	 6VM/4Jm9F9LvEgz8KEJFB97eO3gAdvnupywUfRy++o00a67yr4mV0m1g+C8jiCYDV6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172911;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
	b=ZryWELUs7jSUbLRhZaaupPg9pnwGXPNtDkaoFa3w/Zk2Yca2cEfDtwOX79SBCJMmkA0I
	 glX9XkdtOnq4Ei5j751yePb7IC89FJ1D/i3Q68hmjuha6n/I2u8PjcHeuHfOj1TH6dtKX
	 XSksb/8PRdm6cfVPgtLNEetprjPXbXf6bs/aXVfPbpBUc/v36p48hq/AvGG96NxL+Fu1z
	 GdBBz+LdXphMwKLd9xPjmiPFtuTZF5U27oSUBdwcMsbQna70OZOM/OmzIIJ8T6ZNPyxo3
	 ScY4LsEPxznOQLZJMR+iiVCE2qK92JlRdbUB9uUFfLu6f7VNiiRqG/WW4V0cazKQLCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PpGetJGQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W6Pr6Uvp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3802606AA08
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3802606AA08
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PpGetJGQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W6Pr6Uvp
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkBl81017043
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=; b=PpGetJGQ7pBoK2Dv
	V2W5Gw0cdxOoP1ZJ4IwxWGSC1dqg5+8NDZ2ba8egXMhLsthVoHZFC9RfMXQiuAF5
	gBR4XyAeyHp+ueZgRRzVj4kFHvK1/O77TW9MAiEq9fiOdF/LEdXyudnNQRpedwUu
	tsgyvP6Tn+vHlA3uH7pwnizO5Kfmlr36hZNohqvK7iMgaC6u8DPKNNjNvsoag+AV
	Z9aFk2pYt7bue2Wm3eRtj12Z8z+9DDCGSzr2CnkJ+U0UROzb3VMeu1cUFK9HoF6T
	4NHBraoGBIaWon0bwvQpjiAb1if90/U36LzxRg+VAGGjn2InlLHzM2Sky8Jqz5Zh
	avi0Qg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs7ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso2463422eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172909; x=1795777709; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
        b=W6Pr6UvpfbXeG8FiwTfQAThMgS8NjoHz2YpzJG1o51jToDlseJpBSvtqas7y8+CrW2
         Kgaw+4Qpqf0IGxF4hlhOjL9RiBPcDmaULuBRV4SzhD1iLh9TC3LgOOL8UwP0TOL2okUj
         SQSFflCB6UkQ1Z/G9xfawaTs08EoX9K4bxvZJ9q2Rqr5Djf8q2aJXyA/7w9iUpoVPNUL
         ZI6ExnU0n09qqUSlA4u4/J+lQm3iL/Wc47c2orF9fY33u5ZfDvUZJb55sXq1IYCqnjHc
         JvUUryp1TxV1q2Pni0dtLeGUREZcWCinDJoEk0CsDz+eDkzsPQhGwHldbSQlgRDPgnQF
         9s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172909; x=1795777709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
        b=ffUfeHJCu7xlIBVa863DmEZrgcq8Yh7kDjIZPsYKxluCO6VeZbRxnKZkMqr4wCPbIJ
         1C1qeaTb056ZplvfRwd5b7yoq8NyAUxRbINgrqYDk/6/32oyqXJiiu/n1NWu79fmsk6z
         7DUaZE0KSz1jQElizpXrkKccgs9f4flxjUMEE9502fDk4PEWutPYma2hRNTzbZZHMf/a
         ig11uZk3+LryLNX9ZimNSPVLb3aDusoO//8E/FVDT58MEapmEbkfduVCgZzYBhwIKYmf
         EpnYMUiM0KQ6dpF53nPNxnjwR5E5ufl0WafRz+c24bGgIQJG3ARA5YotueT4cKhdAAqR
         kCeQ==
X-Forwarded-Encrypted: i=1; AL+hErFZkwB9ugAcbTDzYlAEH2txcPM1VVN2bBNd4pPwPPMbHoCiyjzP/F49U4GZM7x7H0A1FpYUFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+HbfjN7Mc9KQ5QYpSJaQeoSIpLLV20V8CMZ1R5iYOjst23Q990
	IANEjOUeetpGgObw/WVEO57o07EKH/grvDqYQCL8dhZI0fi1nB8z0ZWzI/ZhybzzzD0fGPnsqjW
	GdQSXmibwwZAUrzJDw4AaozD14J4N2ItUYscayLUskLGTT7gSx/Y4muuXTQ==
X-Gm-Gg: AZFdTZf68ulHAMhni5KLD8kbP8TF/2zqZpb2ia4O1y1IwgzLGSwuzvFdL8+7VvCNlZ8
	TVsuBGALiX5Mp/zM7afdYGy7CPiDmTeB6IKvegg/OUQDhzTlh59U3dQWCM30HTLXFaJv62BdE8w
	5GBqeSES5rOgXro1DcUD6mJm+OdWx46mZ5YUxjyv1Fm3+S9NvT1c1evm/aLcbq3VToyAGRKica4
	B5Oxfg2QirK8E2th8w3b3iQnQfZZpxRbUiwwrEn3piz8SawE8HjwK7mnqsv+8iJjtzeuUIQjr8K
	gNLIcRPs9ZlYKgaDfhCHNR01GLdYZ2jjgfFP96KXfIRe0zEqLD5MAT6t3/4BCL2aKM8fY5eE9DL
	N1GOYUkJuc8vz6M5kSel4WzA679QHws2l7RMdFcZ6s05lCIx3CXBwntQpfKvLdLkhK9N6CraE2Z
	cLCAxd
X-Received: by 2002:a05:7301:9a82:b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-3856ef45385mr2548336eec.14.1795172908912;
        Fri, 20 Nov 2026 03:08:28 -0800 (PST)
X-Received: by 2002:a05:7301:9a82:b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-3856ef45385mr2548284eec.14.1795172908315;
        Fri, 20 Nov 2026 03:08:28 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:27 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:36:00 +0530
Subject: [PATCH v4 19/20] arm64: dts: qcom: hawi: Add GEM_NOC interconnect
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
Message-Id: <20261120-smmu_interconnect_addition-v4-19-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1056;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=aYGbyD3vlcsShV5PIBfgPkIOIPXgEFvWy/UpvGRwvdI=;
 b=PmL/7/OIAhKe6+7Ml8hww8O3m8ab/UwFs5/yUv6UukBwizaGo3hlxGIlCcYx3COfKyuE5mfYT
 POM6ORiOASJBu3Embpz97TTwUKRZxIR3vDX5gO3izhLjXm5xK1bvqGt
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX+n7rxxUSf1Zm
 YNnUJiOaL0WlIL96nHk2tSYqIVyU9Oh0cCTIVva4US/QUgEsZUEJDyZTybVBjiM+8q+l5Cv3aI3
 /yLodgH0JzOZSvDqilj1nJr8QbxUDqZ9TjEQmIiV9GwpdAkPapPgg7RYRDdx74BUtS0T1mcsPTR
 MzmEQ4+Hperx/4ZA5aFnF1yeUOhVQFjdatKZXhmlShxuPnDjRUFLTJ4wou6Kk1gxbiED5ob+iSB
 esiBYDJwjVVBKkF/IyVjDP3xSiAT8NqwLyswlZs9WK/Sno4z18dsdFFQN312os6V8O92WF+FM+f
 C9keL4VRGDWfcZ2tGiAxXjnonPT0+Q2qGMh9gWF+Wmom+5CpyjemSYFDodOfDkLswxplfxZX5CD
 2o55YHgwzs77v9nMcrs7zIt6GxNt2/wCd01drIO/fw1WcddGTnEmUmSoaAjyj+OIC9DF3nX1rOa
 XVekE/YzeOnc8d+soVA==
X-Proofpoint-GUID: KJV_NXApAzQsllUnSSG1Z-mVvw26gHMx
X-Proofpoint-ORIG-GUID: KJV_NXApAzQsllUnSSG1Z-mVvw26gHMx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX1Y4aVWcNQy15
 H/0OerPg5OCgYcn3PTq91coBUHA2puCeC7WjMqarRMVJWcVTwE/iXQbCfG5jIXM0kyYlqy0aljD
 lSA8iIpM6macBGnov8w56ytBGvrn4/8=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b002a2e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-u0lSa1b7RXV9CCC13MA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On Hawi the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 77d704fa6cf7..bb60ed9384c6 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -3685,6 +3685,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		remoteproc_mpss: remoteproc@4000000 {

-- 
2.34.1

