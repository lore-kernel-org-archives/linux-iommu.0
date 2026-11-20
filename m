Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182239;
	b=E2eL1nEuu0pqChIi1q8QqIxK5ymKhThnnalLPWvbPE70xweh/nrX/871srlqh4492dgd
	 aQ0FVOTyQQk3WG0vegUaDer+xiy5b7N9CzzZZ1TLNl6qgK9zd9HyMvOUcv9DjH5MQZOQr
	 ukrOfJQvkjQkwdnQvq2uBZW5kQtEI2LHUbK7rUZ0IZP3n4bpZdmi9jIRZhRfx3ctn+jM8
	 cx2LpEogxLmkZWf6+W7b6UJA6bdR6AyUPslps35sJoUC/Nk6G1gANU3Elm6Qp++9kowYR
	 TwZwzw7fDLXZ2vM1d7vu8ZvXDPGNRY1svsa5jrY4tvFx7tjJ1ype+Lh8IG61DLBEfzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182239;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
	b=z8XnwXds7uFAq6/DOlNQD0FV2ErOmQzjIDPn1pLU8vCWetI0kcMSdw9sSGYwNLmZNb/h
	 rwU1byuT1nedlw7WFKDdQS3YhZXDngoCyhLvAroH5s4vG8ZreVuDVgWo0yZkUsI1prC9K
	 U218Cw8QUqR/X8RUvK2O7bBxi5GLewMYKJeGUb1IW/2WQxGI1M7b30IxaLxsjdsYevg8t
	 MXblS9//0eP58OdyV50oFku0LwW8wX2wjb5d6SBD9T3Yy+4Yg7q3wwfL1GkJTuzeHXAOb
	 mbkSTn+/8yLty8dY1UpRTHcV6pS8BY33fAWEfAQgoKKKiDSuanG4IQSN+N8783eDbZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0ALIrRl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CfMUVAVn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119D60A383F
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D119D60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0ALIrRl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CfMUVAVn
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjqui1681896
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=; b=P0ALIrRlHSIpYwnF
	G7zeIIX381YdjzO5Tn+y8+uGwytHLwvvvCMV8Zn2ATImWYIuHDBlSNPbYj4HM5+N
	UAd+jeYYktMpph0XVMCk2zzQNAIC5ef/NIkpXZG9yDo9rzcAIP4goyyp+hstjDNM
	sSVG7oPuh/zet9xK48cYU8F+nO9fsl1y3aybLmYvffbrHB0ys39289NYvRtnMH9T
	Wy1l+KX0SNJC2KwCnU+JA8Vbb+yybaoXYW6u4csA2nZtaKrJ5PQg6XTlQUsbesEw
	CYy28QCLcGB6KAX1uG+/ce+1+91bQ5Pf22clCUSxs+34b/uHEYpG9aN7/GD06wRH
	W271xg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1tqdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3854627c1c8so1303582eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182237; x=1795787037; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
        b=CfMUVAVnf57LK0cJ6lBDS6NLw8ZlpP2WMjgxIXmRuWzfjm5hkcIvhyj68DmyRSOR11
         J4YWrxQedaCBF9qmG+XtR5aUs6idm76ELyqBExUD6b03fDZ6D1KfT/PnzOl4d1W7usEy
         GhiNjy21Yhp2ToIGDW+Iw2nRroP8disMRaHiWf2I4vKhilbSSFF2zieRE3gVOaeeIVMO
         p37um+2wogsh5TDnQa5E43wmNyhO9TEQqQpjn0bo1lEfmjxCJUKR70B7XzvbR8FAO86y
         RcIKyN56t4DVzW6XRD8VTFqS2r+7YzEU3esEDbg6IP3oKHU1WmcWMETffftcPusnZRaY
         dDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182237; x=1795787037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
        b=yVkr20KnQzvLOJnFrj+2LBE1kxO+mk/RId/PvMgCWn66S246QuamRmPMdkM960rDF3
         KBjrEy/8DIUVursBNGdQaCSRmgJDDPzR6fDric5Y5zBZnlwluMo0ruZ4hLqf6mzgJQYx
         qkUrL9ycWklln53n/s27kbDT0D0wPO3ppOKa/9Kf59zXTeOGEM3NTlPmNZdJWOrRoWFb
         CUBfscjxrUae3UO29WexxKAGULz2xkoSeSiXTmVhErorkzBZ0p5wID+lwWlrmN4kWUaV
         EPSb9TVbknS87IDlhlN6Y39l54v3fmpraSnGvjVecxBQKyiusv/VjtdfZJXM3Xg3jIpb
         1GDQ==
X-Forwarded-Encrypted: i=1; AL+hErG/SKMM2E/tFTQ7cFdbvVUG/SeKj+ot22Xkc1+EL2TSSvTEhTTi+gzgn5M7c6X9irBfg0twNQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+HHI0SXR+H+62qUkEhdBvQeuvh1G0dyHzBUvwqP2dbO1XP31Uv
	N3PQ5r94yB12P7fuvUuFh6fSTxS95FJD4951Q28fn1R9CBYT4oFZ37xhklGIe1n6xlo8pk3+L6Z
	GPu1CjKY705yNXbn4bGq3nOk2L3y4DkPOXsKESSWi07ypTW/X1bMkzVl3kw==
X-Gm-Gg: AZFdTZfB53sR8k7OH9nhiteMPrFyznxO8otQpnffeocAmWaX8+5fJj7hxWa5Vm+CIoX
	nm82XZBNv7oZiKw5RBi1v78knN0PqFsRZ8SCnh+V1WY2T15E4g0T61VkuIIAn6v3qr0YdclV7Gu
	eO7/BioBlWVelUsvT8/8g7xIa/1kKZaWTbGXHE6SD/BTD0231l5kbyTcQJHM5P80c6FOhlrHkZD
	Qe35jmsr+2VYJVnQMllAoLCLDb6Zx+vJwTxHQpJnN068NGiUCpVqOx0oHjkGOZJLc/ki0Xwj8e8
	dReY82IviwGucprYPATG5FiyfvdCX+41srNfyH9obz0lgIfHErXXsKxzlfT6E58n1bAHOMda6TE
	7tGaY2yHyqTqBDIz9IxLnG/naDwHb1Wq/2lV3nGUQw8BejgKIDMw/sx33lSQ/0QtBoXdirhjhyX
	iOuJE=
X-Received: by 2002:a05:693c:88db:20b0:386:1920:ea0c with SMTP id 5a478bee46e88-3861920f023mr1270307eec.37.1795182236932;
        Fri, 20 Nov 2026 05:43:56 -0800 (PST)
X-Received: by 2002:a05:693c:88db:20b0:386:1920:ea0c with SMTP id 5a478bee46e88-3861920f023mr1270274eec.37.1795182236327;
        Fri, 20 Nov 2026 05:43:56 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:56 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:48 +0530
Subject: [PATCH RESEND v4 17/20] arm64: dts: qcom: glymur: Add HSC_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-17-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1054;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=kQCr9BRTX/wWuCiHnkZ4IEloHpuZO4nxnn6nFDJWtJA=;
 b=PirKNama1rX6T3O90xikO3zJbs4R1zjvKCN9rN+lImGmZfjb6w8J3IBREFB0LIbBUhDXscinh
 nJcYe4iqZY+AV+QgHvh2Wx4pbn05gQe7wcOegQFFyLLe3xuIl+tN0Pg
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b004e9e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=a6KFA2mGowSrcUvabvcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: _t_2hDnHfHEzxnxUpJ4W9lQbpU5g_MBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX3ApidSWEszY6
 /oYhjVOdWSvYrfOEmcysSqVOEJIBHJOv59+45lW3/kywQacWZzqqgiBsaASuaAQJ6EujF5Daq90
 wVCXWzdu9bSgIiHMDtrRsPMrbQm8fYT+qXtGxIrNZxi2KN3mGXpx7G+UyBTCSGdVgiPrvVD63p+
 7vQjJnNtQ/wfNvOzPmCGYxLjHbZ+vFa3gHAh3mqWZtT6iutnZQLYIZbwgj4RnohngUnIFjEXiI4
 SSzX3cOwCttUlJFSnsGZMFKMEECRdypoi+xyTMut2lGYWCZ5hRJb6F68wefTT1hU1mr+9db6aVs
 BwnjOLdbyNOFtCmLq3S8/HCGW5vlusEgaAfp2MM93akOqtey9mHzw1ylc2Smg+gtWfruglNiC6v
 J/D6+aE84f+I+DVGSry5JYQ3kZreAWPuWv4jLmoMp4JYvlytzkFaUxU77ICD7Bhf514nSzq0mX4
 RNGfG/sn1Dmhpnp80Aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwFOyftFm2jSp
 WQpLcCH/MR4wzvCPghdMJ2m5D5Kx830XOMR4Gr3JxsDLCj6teSrVm3TkSK177Ry/cndnPRJ0eFr
 raFLbNDSoeRRgMY8e7p1d3TrzIkfiJw=
X-Proofpoint-ORIG-GUID: _t_2hDnHfHEzxnxUpJ4W9lQbpU5g_MBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Glymur the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on HSC_NOC. Without an explicit
interconnect bandwidth vote, the HSC_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index cdaf842814fb..ae3cedcaf9d8 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4378,6 +4378,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&hsc_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipcc: mailbox@3e04000 {

-- 
2.34.1

