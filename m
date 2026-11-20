Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182186;
	b=miS8TCln0Pr+XLUEbaFCRw0i8XcVqz/gaWomUfXhICj+doay0mZDxOXC20/NPtQBUzcI
	 U2wDYe3uRI+cPnRVC/rlWG0sTqmhLFShIh+LW6EYlsb1k3VkxIZ2ye/1cqopagK/0ttUo
	 N4qdMGjA1PrtC9/J5+b9E/nTmiFkEfr5+SsfRMnEx48Jd3rlqkpliWhJMktIZVTvNBAqz
	 LuMa/oh6JfswRCp/JNcDNrtH/LTrwmlta7UkshFEkm44mR2LrW1HsEmWaMOhjlJjfGXaS
	 xWp3795i2HrTKMrzDzXN8LAQBJRA4YJo339X/OXuWK16tsUt1lFVYTesAx08Kfo9+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182186;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
	b=5sVKLY3V1FwsDwta03DrFBowWgi7n20G3dkmJCF6W3JbzpAy9yPutWRkoVEe45fk1jfN
	 Qp/W3q9UA3EVYRwbYy8q3CHouJq/+lQlv9nsXae9TtQWlExthC4GDR86hbAkoKSfb2Uep
	 94b2EXwqdAU1+jenBTLR3+zW2X2cFE1tqNu6+WY16mUA6Dtq1Afy7Rod1lEgUpDTNgNoU
	 xxW7PuCYec+R4lk9oDyHvcfh47nHhvF+k7p3pzhanAlH7AVvGJZwHfMKPt9bIJitbMYs/
	 8khme+nqM2Mvk74Q6R4FQtT8H7OpUtg2YdjdaunFimIgMCiaFaX+1BR/gfrwM85oeYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ghWQDbGm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fj1L3HiD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AD60A2629
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C99AD60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ghWQDbGm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fj1L3HiD
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjvPp1528593
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=; b=ghWQDbGm/RfEzbMb
	9mYr4PyVHHfjH6865baF+WOueDP8HHspGjuacGVEWATd5rru1puooKpX3QbLS1Py
	BzdFjH6XXUE6YeF/yXJvjP9ibnmLX9MRyNf9ZfJxLcDsIHHvcg4x5Xff26tzCgER
	N26d06GwT7Hav+H1/g/t2ycw/cPuBOb0nAtK0fMtOA9skk6tOzs2jj3sMBrAHrnM
	zaZvoKKqWHkZ2G636TI8Tah5pZxfpfLMhDa0VheZF/naDI7mwNEoqNk8u+3s9oE+
	7e4z25Sem+AJnOtVy6oUYbWgI5QIv9qb+ZWE7wBMf30ZQxPNi/axKKqEXu2s7XQc
	IJu0uw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtt2kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383ec96a7deso1014634eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182184; x=1795786984; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
        b=Fj1L3HiDwj2th2jxa184+/Mt6kR+Ts8qobVcEBNsOTEQMqrDKwbXA5qxHeXug8kLCT
         YnHUDbNIxM7pjNv2QgOuoGr6ae2lqJX2N4d22G5jcFyq7KtOVLMKsPVSTIUlGAvmjQM8
         PM8IYoDVmm/WQIjqXzXCwLRLpyr6yfZmk2NnQMbo4N84xmulK03f1XNYYRhHr15NDOv1
         S6pn3gXZhiYTWMGTx/Px6KFbwpST5diI0Sgla3xnAfe1tASymyTzfDw4u5WLePXqd3L6
         6lzwW/LfohUXZ7TwguJh1knWqnAfvcQEF+nRfUxmiTyp91nS37+LGaErpXZ3NAJVaJ/6
         XhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182184; x=1795786984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVidbSNiizNkNTzgOXhRluYV4j9L9EQKnRCU13pMpyM=;
        b=utwNp0+UW/ZGVnIVdZetvKJXEw0pIEnSvj6lOiyfhbs8wHG52ySLj/AaJYv4C5p90y
         YgvacKaqSfLbAwM4YalYwANcXtG/ztbo136HNm3qM6OZLIVfBQyzrSWzK/ElLdaYwP/x
         Tp4Q4YRerNVFmiGi1NzPSfIYfM2CQGW1V8I+d0V0H1plGIfWNcdh9eriMFpCvdW8nxvg
         Qha26CWo+f7Sz5W+uoW0j5+a/DUS0E8zWw2o+wgmUm/GnZFNbQ7TJL/VcH5uHVJF64lb
         /HT38viq9CvpJZFyPaL/JZOJ94itcBkDGoSAT6Y5eZ31mIgSJWcPddRKx9mykagtK2vz
         eaCg==
X-Forwarded-Encrypted: i=1; AL+hErH2Yjuej7lD7enu1DQouSfTS+sgglxmrzE6/YbKmqNe5u8QItyamL+ddIgfjYmLC/qqkzMr5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9KQIvyf15L54t5VKizeehBDpYvfzCnra5pZtbWu2wbk487aXku
	9S6t9XNu2BntCZyPgtDLz6i1h+MNL7fnXodw/UoXvx+GwNZcEVedAwBnegs5rQ25BfPWopQpjsk
	2b7VAG+KFfMBamZOqhVhjsoa2mtv4Z+A1n4AC0fIpsDC8Ug30Ew5BzplqdA==
X-Gm-Gg: AZFdTZf8gBa3aL4YrJXL0bmSEQAGVzdrnxzmSlwHuBua/RO7ovRSegf8PNzThhuhLQi
	8QCOmsmUmNdl/o5wDxzHN9p1JA1HRUxLIceR7K4CPukqXjtgtoOVaPw39WVHVvXagl/xuYdyNxl
	GxLlbFR89YPP4++URQSLMLAnQyj7rTZxbrUX/f/ZehHd7TD9LwIiDTfR1ayrchQsfUp6Daqh4Lj
	s6psDPGRO4a/U0gQaQW28ZJFfHIeNe30jwiCY5gCuBsrhGb0bUxU5s3hbU+Mz6gtL0KVnCzI+1+
	tLwkYHrMgP4JfoyNy7zIOz+K+hvO8U/ftYmsqaAOU8Daya8ChXqy4sF+c49bEZGZ33jGUUOAbX+
	TFvJeQenTArJUp9NnBNI6WOmRkJui+bSv51BBC0fyX6shgs0oAi+vPL+60mGrNFxPgvmMW8leqW
	Vb8CQ=
X-Received: by 2002:a05:7301:182c:b0:376:e950:873e with SMTP id 5a478bee46e88-3856f659994mr3192411eec.12.1795182183446;
        Fri, 20 Nov 2026 05:43:03 -0800 (PST)
X-Received: by 2002:a05:7301:182c:b0:376:e950:873e with SMTP id 5a478bee46e88-3856f659994mr3192369eec.12.1795182182790;
        Fri, 20 Nov 2026 05:43:02 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:02 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:38 +0530
Subject: [PATCH RESEND v4 07/20] arm64: dts: qcom: sm8150: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-7-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1053;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=9j6IWx76cjPCAQZYybv4iXqHVebU//kZAlxNICMxwEI=;
 b=Q5lXe6lJujeOj00C7B5u5JWgPIuSH3J9emwvnAUTAiwf7hbY2q8uNHI/0TWnEjU25aY5pCK8+
 qR0GG8stZHICFvs4wha1pqrJMlaprkX+Iyva1ZcsqdjrOm4ImQnvkfF
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: I9L7RvTwK7FNm2QG0QyVkcEC-6QK1Cdo
X-Proofpoint-GUID: I9L7RvTwK7FNm2QG0QyVkcEC-6QK1Cdo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwHPkepVZjw8z
 ZUf8GbZ9PyI6cCiPT7ie+DxhRBjVdZdIcsTrEahRghSwJw2fs+nPj6BemrElm6HnBWyW53uHaNQ
 x/UYybID8yv8KdHusuqDkVQjPxOJdPNMJq+SQKOhce8f0os0ugh003ynQbF7m9OcL9g4pfXv3Pz
 wkDLpZUE93fNiB6evxOM3NDbAaT7yFsFB4uKkHMqseYkx2XS2k4B5feHYHKy9ggsdcJHzWedjZD
 KrHc4L9Xmt8dofXUwXZHk4C3p4r28eYphCiBcxgy+UGyyDlZvxit7vVS/9xLfVqUbfagZZmZ/M9
 Yx1eCJqkIjeLKQLcG90Yy7QuXHu5G4shw41Cg0XTez+bkVt7I5YaVXoZASeeXiMWibG+Ol0RfPX
 RaWYO6B5StHhjt+UAzJ7v0UyK157Kh1AnfSqkj9YjgfjlT+gMFDcZPHJPfFsOTA7q5oFK/VFW8D
 +whNcZXNpgDBLhqWmGA==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b004e68 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2mEde68aHbpXMYUSS8oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX2XHhZAVZwwxO
 kVpCb9DHWgbkYp0uKG2c9gNZvOAwm9n+6p/QabaRotiXh9YuXYPODD6d4G0YEvbLwUFj6zuul9D
 NigrIUxVA9x4iiYRL0eXhWn7tnvigKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

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

