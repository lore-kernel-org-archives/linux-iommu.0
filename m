Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182175;
	b=S4oEUY4pBfPD+r1fUk+dDnSHBI7OwHmOxNJfpTTjm5FAHQ48P9S1p44a6EzVQ7OmcZLP
	 0mMsx8tnpN9DndaD21y8soFGAEv4+DrhIjI9jLSEbCIlM6j6gervZCOc3YSDu4xbNRyLt
	 zIZkVAYjfjoCDAQxowFoyJV/WxxrfnC/q4FKQlvJa432+k/YgJ/YT6QRevLSG6q6ZeQlr
	 KhPntgAXnI5HbM/c9zzdrwrCuXyICqvRVbJXcP/OE2+IX0x/S1Bi4G677At2ul6gSrYci
	 ARxqPPhEcpB85hYAWdBw2p+bpnOnY3o55HqG/mJH8Qq8KGVaso9PDU431TvO7W+s1eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
	b=kBIlhvqIe/fPsR8gSCfbpDoKSsvanB1D6yUam6JbWHr5KxqluX46zlXFlHsbx159XYPz
	 sJrxJr+mpLgIn8CwtbOseoJFb2mEJv/ljxfHKLg8jaXsWTkZ59ZdVqVhMdzlwvbWX4SUv
	 RHhVXvVSfzKAceI8RARqwj3Wnf/baP/GUbZyOpcxAcPEvJrql0ztR4dNx1Quk+Uw/JeBH
	 Tp/vwBmMcC3VLWvWEr5s2h43spz7FJALG2j9ZqfiwfekgwucfzGjPsAu5KlWrvytQrzaC
	 N88GirIWKr/vWeDyXfTzrkriiWr8++AiJcQOnA2skQwKrjbrZ94AihXSwPi60MMv/Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAUYNwmD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCQuCIsn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E97606A326
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E97606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAUYNwmD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCQuCIsn
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjwSp1528606
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=; b=CAUYNwmDCpzBPdlm
	MyKbSiLl1f2o1knTbSC9nBMYV4a/fq8yGsVUuE8CFNlQln/+pNv3bU7gXKPDK+l5
	E6mRJiiDzGU1kNTyQPytCjoIu0290cpZ61ztxLqHPzh+tMALv2OCB+PPNc7Sr1Oa
	iM7e5+6ppMAvc10SEt6O5IOI4RbiH0sq+BFw/j6DxNwYq6OcSnOm2Upv78dpccdk
	25IhQSyb41vRNA/SWWTM8V7xf2QZWeDBVWxKRPcvBm3iIVYkqcQkGH2OW2usdcXn
	aM64fYKUfxmFjbd18C9ZULu51nNA6GtFuzVniwrz3nL4hwkEDgT7DS+T2DUVt94Z
	CjK7iQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtt2js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so712910eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182173; x=1795786973; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
        b=aCQuCIsnA1gAK38T00bhViROV42PGtpSzxXv5Yz6k70NnL1L2iwibbAVeWNaLn/p6S
         rSuhfifTHvnDgn7kByLZZUJYB0KHIsA2rjdmXrqSGWyY041z05QVQXmPkM1wcB8iDrKv
         cPYLWSiBDFfDP4zTrGQGb77mF6ks57i+gFgR3D+YTTRWS+G/7ZAyXrilfNkQZawFhHu/
         /1EQWhm2Fzs5d14NhEG2Bduzztqtot7CSo59IiaVhSw369Cc8cg2cV6OF9aw4FKSYJB8
         6O013Irf6dKqcDZySTHGdlHKatL9YWlkb6G7PwaUdwpD3LYMXzu5lt9jpqhmCvUqarvp
         HGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182173; x=1795786973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
        b=BolbvCWJTb5Gr2n0m3ll7rgWGpCduybUdlZFKIVTdlFJtb0emWNZvaiovnS1+xJ1n+
         abEBHp3eGaftm24094tKlw2Rp7p4yieMi1J67Icd2FjR5uehwFDYxfSyLj57vGDOBaDW
         WP3I2xuG9l1XFDcfGbncnlESTAs8jV0e9aRedm8P9Qvs+/FYANceNntYMSRDvsAIEqLu
         BZrQ1k/FB+xiWTCbfRnya3PdxXiKK9hx4zJCNo84h50ysdP3FMqcL7w87ZFhzy7FLgkP
         bveo0tEI26Rs+XYgnADQDhdwed6buh0F73tKgpkTjfATQh5Swvha8qUDyFIxGhrqBgCG
         BXWQ==
X-Forwarded-Encrypted: i=1; AL+hErE1jTuBB90YLkO2aNlj2xTrbdmqRp3/Kubnr6pp13wZYF695chRK3/KPRirNIXo26YqwpczAA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1MR/qsHfVJr0PUrYmXMc8zA+5IVbVbMCywMVM7/+Jbbq1kuxE
	1hcqgwisBTQeb9uBK2WxFKLUeAziS+9uZ779+NYUXtZaLtb1B7naemMMYYcQdnfxRjIxvuLsDwB
	NujHL4XIvCcz58JvNEsg54V9/2YWI8bG3+zwa+Zr7Z8Tq+F99Tt2PisWHOQ==
X-Gm-Gg: AZFdTZdMMqnyT5l77dXLaUb1w2CFGuUP8+AdFbjPjdneBHhzLDSMdGtjd62AQwYQ2tg
	SJA1pczwnK6c6rT7ZHtTNw/vZCJTl6IubBiXtBJ5gggRycyhKRP+wVEwAMMtcLQnAu+wKdHpCuW
	FNtR6T1HutMTc57IrDQpdIi3ZzW/Dthp1RVSiRmqmdkZgFJQsQxa5Jg97e4qNY0XJcwiDuOfokf
	d2r4NcRo+Gw2lHPm2cNWWF/YZ1wLtXSIMwJoxN41cT7pAaW595k6COeKx1J6VH282/uxnJ7tkpA
	MzfdcW+RMozt64F6n9/j/CnZclBctEUec4/ubpcsiv8nre3GyWCzAW2GWrFC7AOReaGEBv7WpHq
	5h1DvxBJG2ecCd6U16F64eanshcITdwTVvr38QcZrWDTFogCwkzZYxOA3lpRcTNLDUeDWzngdXK
	368dk=
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id 5a478bee46e88-384b3986edamr4218393eec.7.1795182172837;
        Fri, 20 Nov 2026 05:42:52 -0800 (PST)
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id 5a478bee46e88-384b3986edamr4218365eec.7.1795182172191;
        Fri, 20 Nov 2026 05:42:52 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:51 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:36 +0530
Subject: [PATCH RESEND v4 05/20] arm64: dts: qcom: monaco: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-5-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1018;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=1lPh+lGGWLKglbX1purFejDWg8n5fwBJBYl3rhWzR6U=;
 b=oUfXjkp08+mArsrZiKnkDBUGoVmuJ2eZr5NDLzeoQIP9UyDpL2QqdSa5M5lOtFa9uE0FtdArq
 WMGUW2T+o9/CdUf/Y5BNFEnVKbWTupmAIgS5HZe+BEAMk4mE8b6FF/0
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: 8TIufKdL5yO3_2I79sMSLSqhkEwCXXlM
X-Proofpoint-GUID: 8TIufKdL5yO3_2I79sMSLSqhkEwCXXlM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX03/VMdgkLiE3
 pyDUuLueyqNiI98t2v5jQO/ec9IrAf3cs8eWN3tVKOEG4YAA1DtiofONHbUnFvFgB9NHYuneFln
 s9PGKCEdsBXqntlGQDSr4XaCtpxlHGTQ/O3xjM7WhXLGbJaxs+XBiHg6aXxIkJRpR88hJUHZice
 1IzcesMhmn2lgYPIzsC5NlYB9eoecgWs+SuKzZTxJchcb3Lo8uRTwibuKRuh/mSjpapmiJ+v9be
 FyMAgaDM6vLeKDZlIWIIqoPn5tJ/Kl9NXPr7iYD6wv6glbkbromysuxMPrDA1ieUpJ2uZ7JqRIn
 bpyU1yLZGmwYUftDcxRF8U6pg5bU/Dbg2X1sqlvs8sHTEWBqiVpb5Z7yKptFaJb+JrAzS7/KO69
 +gQRa7hSDpV7d20+ewc4cCiPv/W9erkr5RmfIz/trVi3BqZdWr3OCy8P32jankvHV+brqF6SJn/
 DP5OWWMcOLyrTa3CYSg==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b004e5e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Jjng17ChVe8r-G2aFk8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX5VCsRhND2QGV
 mTnU7Unjk7HScE6S0A5kcXCPI1U5dJUIM1AsHkH6k9612bjKZPCuPk4XKtf2IATKuX3bMznVig7
 RHSPqjdSCjZ3VEVgLFFUYODdRgptq9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Monaco platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 3541313a79bf..13214aa77279 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5113,6 +5113,8 @@ adreno_smmu: iommu@3da0000 {
 				      "gpu_cc_hub_aon_clk";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		pmu@9091000 {

-- 
2.34.1

