Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182191;
	b=d6e9od7GmPXzUJUWCB3kaQQ6cRaRp/zCQwbFUE2rzt5fnfjBoyURc4nArOkOKZSTJq8J
	 vUSk/EvOrWwJg4twAJsTFlCub1/5lgEdLyeA1D0LGbi601UqGm+YPV75L9h2aWGkKOPQu
	 Nj/umyuKIzol/uCu0ZQPgz3eH9rN9w69rU536gnqAk7J/5rIL9D4iAZq0ck1s/n5bWL+J
	 QgX1V+SCJunL5JaJqFDE8PhuXrMXCoWDGQotJSdm2/uRnOEBATokZch5oOzkjBDHeEcji
	 8qcpNebYMDWYbw5zb/kf1jMFdLRS9vCDbJcokVRItURrvy3Lq9bQxX1sHyqluwet4ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182191;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
	b=1TTrxNoNV09rfJx1LQzKFVx7o+eQu7a9nCBNXGsQY3q7DyRe5qi+ogF7dkKgDZ4x6Jdm
	 ZZA4KmN9VZlnCjsKWl/OOSjVH5P4JsbDKJRJZMv5GAcXceaRs2tyESDCAz9UD43GeuNJT
	 rXAzx61qQSikpE33aClTfdUO/rUVG0g/6VO1TgrUT/5QvNXNmKIDasxHUsKUJx5EE+zbb
	 jzNf8sRbfZfefRZ+AWHsIYqHCV41qzSsYN54CzNYPaWJ4OzkI9uSzFMqgRPCFVeQpfl76
	 zNYOBaoQbH4HXZk37hw7JnVATv7FhI5IBfCvZc/M7rEgqG9EC8HPCZq1w/d3PyUqGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lV2OMf+A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cKWsimDs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EDA60A2600
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5EDA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lV2OMf+A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cKWsimDs
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk0kk556468
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=; b=lV2OMf+AO/WIMczd
	5TY9H/Sm6NbzH9KrP/cYGNhJ81qogUKwQTc7Meeq+vgjWerGjMpfPO/MjrSjjpST
	jJ3NZSsDfUVYzUzbarDsHW8szqr+yN3H9aIugcOY1QYd4qRo1MmdzfnSx/uZMn9l
	rjhKsDiQuJJwhdRMuwEHQx3510yA5eQMeSZpIRzAqWxgadkbSAA4POKqFyYAD8Cx
	6hU1uHB+Xu99vJFaEOmYvmnLP3XxDdRnA9s0QprTp+J3CZxUMXj2vC/08UdO2Uhv
	Ubr4aRfxO5Xw4qipLuA/zBwfG20E9msp1kYB024jfyw7Xfum1fFBbSyaHsK7XsNi
	84Mngg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbj14n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so1373035eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182189; x=1795786989; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
        b=cKWsimDsTqeoJV+tYdAxydf0hcInuU0BjthzyBNXMg22JDythXheeLV2X8bzdFh19A
         a5qpeOhMKX+WGAGNN1qj5G+c01e/qSq+t2cjyfNzwTsWVQ1GmSkvwuiflmlc0PbTKYsy
         pou/PGWCs7wA54Gj35e3Qnx1001sowE4CqPlf0guKPgQZOKRmphUoUINZIbPOVwlw1eY
         XUO6xerDQvvgptRBzzoIHTtc81CjKNBTIvrGiTRCdEDIlXfaup1bYOoH1sKdqVrXU1aj
         oo0bvzo21a2Mi+cSNjvUJmSOUJf3UV7yrqD94JqKBnGFzwwN5Lvf5JBNmkY2xDDfqVdT
         hD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182189; x=1795786989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmZxYNnA0FlqXh17OoqgkAggLp3AAiOCxOAyC3Iq++0=;
        b=mUjcLFNkWiM5S0R+MPhNsZ5GKj37kXJv3j0HglWfibYmZcE0CairJCTNMREtOlwbJv
         ybiMRtj2iGBDLTdZoGZtG50wHZ5obFxGC2LWSMj0mNUEUhVqU3DvwZH6yHrRdeUDnGwu
         99jY+Ea7lUzHnhxkWD2+L1NEWGrYMzMqeB4U7h6oTXCgKJPw6GMUCKjN/n2lnGROBfr0
         mtuzXmezyOdt1g4iDiFaWuiTXCbC6hM53BMNKeN92LrC6JFl3zu9ho3M8Lwe5HNlTPLX
         zqECeziPI4njr05OrhJjUScQyD6GdcfDxhwy3wsI3Xb+yC2qy9RVHS8r2RJmMDG7OxGc
         9p6w==
X-Forwarded-Encrypted: i=1; AL+hErF51wK6DDRiagiNMNjFHDkV0ueItFJhkn0SFVjoDkQsWu9AyGXL6bE0wLO7Iw8Ii5+NTvVxCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8edXoFlCs8DGjF23Zo8NKbpc6iIv6V8Vuv4DZg5sAcWIjkToVW
	/XM51vD7R5pdMMGVMaYv2zb81aCEHJ6aQ1lv5qjPkBGxQQ+juOVJk8cEjJmBf3gGAbAoz7yxmsp
	ZAm9AqO51FqG7gvueo8iP5bLz7J4nsPCZYSn6+TCF/5BIijusejLgnhxsdQ==
X-Gm-Gg: AYBFou320w6LNezclXOo/PgmVT/UrFCe0omaX45TOBk5ydCQrH5L1e01dUsTFX/hj3E
	NtAVGd3DctCDn7+YmI8208esrpZWUeCeNw6gY75dXJlvIRMt1hb4vYoKz3t8fNUeIYhTHqXYJbT
	SDP3lUFe8UteOWZKAO3vUUCdHA6owyi7LWZLR3xczFj4BXkYzT6nOwDiiomd9p3IParoxiw+lI4
	Em6TFlhCgGhnnKoXUf4utFwanDowlTxH97pNePp2G4PEuDQ8l5/E3P4gnZ0ltyNEHxwAHhEI/+F
	VLGfE3d9I1fSI1zdSsRZkvqsGDYgrkyRwQDWY08B7i+hPRXKVs3rt6BIhKoYTQxWzd1ljz5bODF
	bX15+N+zl3mxdDY0EnUIINO/Ldx/Snazt4HHRxCOx4JN95c/QOlzALerwRPNIEnEDSU3ffGCDHE
	R1twM=
X-Received: by 2002:a05:7300:601e:b0:376:6aea:ab with SMTP id 5a478bee46e88-3856c5b58e2mr2940781eec.3.1795182188829;
        Fri, 20 Nov 2026 05:43:08 -0800 (PST)
X-Received: by 2002:a05:7300:601e:b0:376:6aea:ab with SMTP id 5a478bee46e88-3856c5b58e2mr2940732eec.3.1795182188122;
        Fri, 20 Nov 2026 05:43:08 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:07 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:39 +0530
Subject: [PATCH RESEND v4 08/20] arm64: dts: qcom: sm8250: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-8-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1033;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=W3R0vadqLaDaPerwJqu9PSx+OZnsGkbm84YuXP3uSZ0=;
 b=UXjvyPjVSFUzv8MWkI6PHpXR9uFIip+8s4FKDI3V7v5De6PmcMG77hWXmqGhPzGsaIAqRjl5e
 dXXkYAE7cPcDTXRoKoXj3qGk19IsmRItdN1AB2V6qAWzSjL23J+XvLO
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX52Lj7/L4Esrt
 Pc/4g4pW+Y6lbROWGEcn1gpOgT8VYZm9trij+nPLINpiX4mNTdtkZszmT7VBEVgtP+Ube9/X38K
 dUTkOdz0hDeCxaieWSFifGPNl0F6A4xez5wj2l0dsd1PTHwwFB4SJBXAyt9BPGsO6DtpBe5mfOd
 O1jxFSY7jITYIeLeeykjiRuAlYLZhKpgaK7e0KgL26SR+ZI3S+xZSNV45cjo9+y5e0LuGPZfVH0
 GV45bnszO7t9uBU8oQFrmBDLSP7gF2l0U33DI56JzWAlSuXB7idPcPhQBv++FnrqqMqGUxuZicT
 cHsS8zw8O7E59+Kdb9LdEkFpQY2KOQ84A835TKDtEpDAyy8UY5p08POtqz9VApv84JfIimOvwvS
 c8tpjjPj9jzMdYLSZMImWzkh5EBZz6N9gO+CzhX5tBX+omj1O9bFfiwrpssz8804PP0AwQNH41f
 3K+snel0WLwMJr3hruA==
X-Proofpoint-GUID: aclmKsMMD_pzFKqxRCo_wh4W4wNOIuJC
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b004e6e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IeQ55TmpMpvzCWFLjAoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: aclmKsMMD_pzFKqxRCo_wh4W4wNOIuJC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwXgSQcJr4/mi
 hpivgjL88uhaOPIZI6VDxXkvfS+1dKGWqWTjlZUSuBcejtx2BHn98Rq9B7QEDQ18DB/mefvImQK
 Hi6hgV9383cZQyCpUMtFTK8fce2pW+U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On SM8250 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 992284e64d38..3a368ef7c22a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3089,6 +3089,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		slpi: remoteproc@5c00000 {

-- 
2.34.1

