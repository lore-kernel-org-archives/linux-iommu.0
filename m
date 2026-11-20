Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182196;
	b=XQDr1PfvyeoIdzwxYMI5kUVzgmTxF2UQEzsBhc8U1h+g+FxLrx8LwdT8NXunoKCc8p/a
	 ZrNsmPuOfA0eENEwk1RiHF3Z7yPhZqV3LI5t94WNN5tYBLdm8Z3HHP6FHZ5i9CpRguvav
	 UCfRor7qZW6t633Nmt7BGgG+JTUVGW+AFAyrxSEFpgYWM8UJuSIhsJgRAjF1kPaOgSACI
	 a9vKaMpXwF9aG+wq9XKLUv15amdg0k2gNU1QesEpqHJmSpEbyp5ye1O5cpHLgbmsb33cY
	 DDV2f+Rh5g4f0cryc1aigfqw+0wr/HRqlXkp5T04l/6SKmjWIXmfhFRN62ssbQjL0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182196;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
	b=FdPv7B1+xTQ+2xRMGHhPoVWoiAR4oFeIkIVPUWRYVwyMf5zr/Zmu685yCEeQuO0nebyY
	 /JoOywi3/plf6NbT3TY7z5eFY9Wzq7/r41lcgftGkzhL3Pw0jCrIAGr1PXsA+lwqcPMwH
	 0FuyyU35kUYoDFnjUb+UnEeiKPLjaYND2u1bSPzXwONeRV2KaC59MwlkJ8G83xol3J+sQ
	 NAs/QlJcbckmQxI1h5f7Pn5E/F3FViOMjg+/UKiu0lpuzBmLVnSMY/RhBe63MGAx6z6Ph
	 IN81HvrOIRUK2HBzAicccvsgKQjXrZwiMvsyES4u5UZKdQWZVcxaz4z8JqtgunwHJPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WFsZ1PCY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8t8Utuz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A9606A331
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61A9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WFsZ1PCY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8t8Utuz
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk1sV2433166
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=; b=WFsZ1PCYPHZwYXdX
	pxhYoFglf6/G/D2b3NNcvvzBLrRh5QxvC+BCLZMg9Vszi/5Eb7q7PEk58DZInPbC
	eyRUuDkYdMArQ38nEVLVcFLKZyItTbGKBvi5MuKF8gOn/OIYJAHGc4JiiRWkFHRS
	aM4gXpMCvmq/eny/ITWktSa/6eHTHwyzc6aAlps5g92HO8uLEzBXMcjdZJoXp+5K
	L6ngePj8ny/IdmwoenVRlrudlL2Pheq5IWqXBAWBChdmHg7E5TEhp1FX7fpFSZF6
	VbDiW8KGqt4PCeOoHRKCFFZdoLHWzMiRO51HZ5tQInjTu6x4wreHqZaUiHPwf8lD
	v9i7zQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjja1nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so1373166eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182194; x=1795786994; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
        b=j8t8UtuzpoQiAhpXW/D9RSuZt72KtDy86dp8hogjOwBzxjE4vobIi72Uo2MSNFVxRX
         cuGfzcvcLFsNFsp++aDMmqIXU/BsKyfXgocBfjNHvIcbPBUJGInqrrGtR5t9wua4e71K
         JftY/fSdYFyf4EguotEBPSpFZUmnVNKmNdWC203mU2t0vnWYKbjrNw9ll2DRNAFE44eX
         jTt9P1nXxWi281J7F79svfkF0RTOCHQX2NpfkAXnxDYkTLr7eC7tx/uE0WqbCm+4xHpO
         hzsX6Y/Ge4a2BQd6TIsr3gyyvCkqv1Xb3HutVAroawNKivww3v79NYOL+RNWwULxaLVm
         XU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182194; x=1795786994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN6UN+J+fpt8i2gGYSvl+iVIt/4RMXnGf/7L8R1bT+0=;
        b=uzCSor3swrLAPqhwJhTtggvYwCVJzh/+y+QWUM6qPErpa8K+hkFWOhpOSarBS9lNBg
         ALquSMIN1oNnQVtWI0iBxUPPCQWC254wNtFcCYmb6UG9p2fCkB8TfiHvRdxuLxyY9jnu
         gP8hvXdj33jZa0q+j4fYPlztcL1+UB8DuLNBU7aj9CFuOLS3ZeEFV7PjmxYVRlNJlBmN
         QBzYspJcFx8xeAMVZcm8Ni0iDjolghI6gH6CyaYkmqLKPLuX3xk3rE6yZ/Px1NDDUing
         iau+y/Tx5VofAU1rv0KwePxRhcI8owzj+zJassn9bl3U+9zEWYeg83jtYitrO+lDbHrF
         iArQ==
X-Forwarded-Encrypted: i=1; AL+hErGppl6QUPnB7BP1mQrEsEtrxNkfKgS6JZx/9TubwMTjeqt0aMaiJiXALn4tS/OPoujv6QKtEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z80o9/5pfzkHDOAT7FxeIjNPOmxohT9EGqz1cK/+pGq2P9N8WHq
	cy1zCKKynOQ5wPQNLFp7v2OqdW40huHxnoaXnTbLe0e2+UrF9riOg75WKTE/1q3imPuYURfuyr6
	kc//HvSFMNxi8dL6xVL64FBFh9yyQVEiR22uattEASSd3/9ap4ezCmdeNZQ==
X-Gm-Gg: AYBFou151IWeYTUGbTuixzMwjHo4/o8nxGY11x4xz2ipNts7k1B6Be468JT09meje6O
	RVvwsCR2fFaPVINrFHi/CMdD52ANdoJQ8eMrJ7cUBxhPeEeE4HSWuC/6QT9gAyrsjGOMuEJLJju
	RphI4M9bivWeJh4s5Bey5c+GKgvpbgjxQWLNYTtL6MGw24DG3sONoAAGSJwXiF9fc/74e6Rg6KY
	guhOPs+zTrR1KTpO9tsXmLZFiZpJulKcJzbTwOMUD5Pi1KEOkyVMZgIShhaE31mw65S6TDnhJL8
	YCS0KuWmnt3NC2t0SoalVrJ8nlPxyyG/4WK6S8Ie4pP9akmq13QRE5o1f4D4lqhtoWeOJrAV8FQ
	bRzLa0CLtWwT1LTXBTqVIhVRDNzRtmmADi3q4m06FM4Qa7E3E+KubwIiD+oMwYEdiougVAoW3aT
	pM4bU=
X-Received: by 2002:a05:693c:8955:10b0:36a:1008:5815 with SMTP id 5a478bee46e88-3856c6ab8e7mr2865614eec.5.1795182194218;
        Fri, 20 Nov 2026 05:43:14 -0800 (PST)
X-Received: by 2002:a05:693c:8955:10b0:36a:1008:5815 with SMTP id 5a478bee46e88-3856c6ab8e7mr2865573eec.5.1795182193563;
        Fri, 20 Nov 2026 05:43:13 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:13 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:40 +0530
Subject: [PATCH RESEND v4 09/20] arm64: dts: qcom: sm8350: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-9-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1040;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=ifRBUNcG4S75b7wOEESAYY95LUktSUoyNzDBhGxm1EA=;
 b=Q8yu6sFl8SVM8dspFiUmMN5ffOmdMre6HaKrkUdqERV8yylmH+IBEB/LBKQmZQ2KgivVAqmFt
 gDOq6Ul9ShaBwk+4cp4/63XlFWnZijGOl+HjjqAQOCN+ti5Cre8mnYq
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b004e73 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tc1TWAvYerzeY2VvnAsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXz+1mGuV9HZsb
 R9o+THGMyqInDr4nIlkiBbuVuY0maSOa5taRsMUmbXJkZUioW/sVtz6xsyiMfjJxjyeilWDBPo9
 yJtkWsZr9zBnna9jBMDYTO2Wz82+478=
X-Proofpoint-ORIG-GUID: IoFEqRUFVclJyIxd9H69EFjB9M2i17SD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX7f71gzZo62mA
 XHQdyW5KREGDHhqiOmaxl4odDuUifhlXfJINb0sZePun4aFiYWO5yl6g2L8Iy9x3kwlfCBBeTFW
 WwaAtfe5zy3qSybVAkEEOAfv1kROWqBD9eJZxsNBG22wmqucpHu2V/P807PNb3em2XqumkDCv0R
 2DT8cKd4R95BOtnFEvVspLszGwA2S6tfXbQOmM0sXeNsMenpBj0COSgmJa7DXHiaWLJEPR4iQhQ
 1SMIcEZ9fFH35h66z7/oi57lfA3QABOOLMh8xjF/71fCmv+jCf4Z55FRmDVH0t6dyIc/CfS26xJ
 2QG0GDEUVSyxuI1tmSQItzEzv/y5DNcIV539lPmaawFZ8PfSfw023aIzeHnlCbV3ggo5TgklBIM
 +HFpPiuepEsWq+Vx1B6dy9pwCYz5Ohh7jMVOI/1wXqt1dUh+JeFdbtPCOss82KdbkzkmBAU2UFF
 p+QEMJpdSr1Ku4Ajmaw==
X-Proofpoint-GUID: IoFEqRUFVclJyIxd9H69EFjB9M2i17SD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200054

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

