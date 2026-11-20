Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172875;
	b=G3ZxJl1SmeCO6DWcU862zYLGEaaNrHRpZRzVoB6nRuaxFCYLw7OtIWZW10hEHhQYcZSA
	 kBTJWKUwZRfPTs4ooEyeBWM+jHFNdQLydmtf2JMmWUio7Y0LFbEM6OS26hnbQftmHMGaI
	 NvEF1MtdQrlJVMr2w5F9EAaMN0JERz2Jc+53NXQV8Qn0FdA+UztbUK+vb1G7e0JCW725R
	 r1khSdwc9lSeaQFrBqNFRk44X+PAaN8ITsZS3ycS00Zolj0RQNWvZ2vzoMs8PGFHhkPq4
	 WnUJgG/gQYOmHbDUNeeg7Yj9yUUNur/+yL0oSCwabd3eKgu7LWUlLxf0PixClROKVoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172875;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
	b=toDMScx7m+GwAxsX+hgutim2gZnL1cJBhu/u9Z+fGX1u1cLtsflTTkRjoUGNEt8Tsuci
	 TH0oIewOFRbpiCwO2avKaGiWA5I55NxyUcme7OlzYQlB1Ql3koC7JuPi/Wv0xN/H5qDnz
	 8TUKjqCCnsKcPPREk0sENGAMCVKyMq3it+03aUyY5ZETVbj2xkgHygl+MDg8mfz9afVdX
	 NuJv7x0+zt1P7HkydK9Td3BPv6K0IN9+/hLz3kWhp5B9PqKqTLQZtwQZjb7oR4o48UMZ0
	 V/heyqa/dlFY6KbLv7Ppd0V2u8EWyTaiDId1/rN5EICRdEKELUKFqwsaMLuVGhJdidg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=koskxqCn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kV+ehYDo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0E606D878
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D0E606D878
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=koskxqCn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kV+ehYDo
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjxaF1528618
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=; b=koskxqCnq8MhVs/C
	CKwbThD06UaTkkfRTXXCUuz1i+bZzwHF0FcDd8BbxC/exytm6F6k0wa6AzLt3+HZ
	NY/SiCJ7yITHOeZg2qfJtHrfWWIxBHvSlvFtVTCDmANaO1RLAkLotiYHc+Ox8v8e
	av/Zer2K1JHA+rrda/7zA/CcxMUIs7MfkJlgQar3IyarKxWueOMIROmjooMqjM0x
	bfLWuQLR/K0SR7itT8qW/XgKVL2zr8uqRJ6lNL365dpr2Mj6F188YXVfwFnN0La/
	a8uBfhYvu8BtYMnvk/1S8meK7CzASWp7L7lc2dp0g7o0Fu4hFChq/51TMErRxWr/
	8oOB9Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtsga4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383ec96a7deso848322eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172873; x=1795777673; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
        b=kV+ehYDofvM9dJiMLJB1C4NV9aWqjW1pSfD40IkZZzdn2/OvfLW5IBdXlpYtW6bKi9
         IWGCcz46PrFGWVdEJ9TskvqsMsFGg3gVp7uieYZXEqATlSan2Hd9dcHuCqIqRkRvBWxt
         gzqVcCXl9PgRBCmzcvKACSVQ7wdzLBaYbwO7lIL0nNbt3Z4glsgGXq6HqERVHKZJQFFd
         7b1cyMEvA+0D/rF2krHqf2B8/OJu0WqS3ACS/8YeyavEuvt3kSF+PyLRSTFLUFb9h+uR
         jwF4I9lBdyYJnR4rM1ExoAAwz0Q8Qx+uYw+l8OO9upcmkEk2tFU+osDzz+Oo6TLLHus9
         BHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172873; x=1795777673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
        b=h+9JMgduvXzGxekC43F4pezrpyefSyCWIIh6TWT7+3/uhFWpWYb97t77VioyhtSU9W
         Ru8jfF0Ur4H7YlDN/HS2NAX3CjQw56cTgj8LNWnzTgbfzmT2GoRn7JdPDEFWz+5qiRQg
         ZS77AfJb6Czsy7BsgSjdihxWdffJWjA8RQu7ctOSnKxgY+wtd4FxOPPLnbg+/6hXBw7H
         JETdpUkDnk9Y3iseotoHLCZWHBxNOVJfGYxvVzfaWWHez2hu0DEehZ1foqYyUK8JH6yI
         mhFY7lBJc6/7fy4Wh5zjzKXJvrwR165XOY0WUmi80J3v3LpCEbwhIS1cnoIQ6SNSesjf
         3QWg==
X-Forwarded-Encrypted: i=1; AL+hErF2DfoepHfH+gLxpS6OUZ8+lBnm5MxRmWxoS9AzcZzgyGTCMu2J1S2IGACPlVEMqyUsJDFvGg==@lists.linux.dev
X-Gm-Message-State: APuU4Z87/TkW+5MXXa1qgOR8kDXYnjAFbYfNq0ZdABcMdcdAJKQM4KrZ
	8rxD31FrllvEdjNfhVq9316dlTpzojI5TsFyQ4FXWrjn8FjcGRo9/PkHYteG4prCdp8/dW6bMim
	R5LaaSdXJAgqNsMhZB/V/04qH2XlcvF6GNd3v5o2EiWu6MH2jkGO1sOcOIA==
X-Gm-Gg: AZFdTZdnCX+8Cv90Hah/v4iibHzisv25jsHBdV4monv/e0/QcONVOcArmKgmqO2pUAD
	VjG08N+j7oDNrrs6TaKF08ZzNUQLax5sqY4E4Tct7h6YvkD11NF/FqbBl1d3selEn8/qm8xVldx
	Z2mZQbDSoA8DKGTwAyeylAIaLqo44ITjcheMvbWlPFX2FCA0UWeOOxVPgGAXp5nfVomwfFMr9sz
	KcTxDEO5a1vLDQFG6+ZgLoARtIHU1A7gH0OGiIMlcR15znSbSDo7RnEd5dNSY9Oy3Ie+Fq3Ezme
	u2XobyAmhovtOg+5OhrjhFLm9384hf9tdc6I4VVLrwE31DC3XvtfORxBhF6vXtG+731n9IeM2um
	7hIWiqa0Jh2kwBcIIZKSl5Ks7XDzvmu8J6ASl4X7FxI4w9CZr8hJ3FWgJs477iD1cNf/iUF1/0t
	SQGIjR
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id 5a478bee46e88-3856fb6a672mr2801656eec.14.1795172872576;
        Fri, 20 Nov 2026 03:07:52 -0800 (PST)
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id 5a478bee46e88-3856fb6a672mr2801610eec.14.1795172871888;
        Fri, 20 Nov 2026 03:07:51 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:51 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:53 +0530
Subject: [PATCH v4 12/20] arm64: dts: qcom: sm8450: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-12-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1046;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=XGSCDo+PAJtTWrK9Yli/KgTXld6tpUWo0Tp3e8IW/LM=;
 b=9gz/rvKKgvNjj6uwIais3rFdCGo4IChAppqwi1Llk7+aKXWKIB4Wq+mZFHmQafF1TTafELH8Y
 idSDNiNfrnNDmSgmeMAPynBcUSsHZD0PwkqIfI31IXZryVAff+gET7+
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: -JI_nmlf0-12SpTdgdgjjof9NTbC1MrX
X-Proofpoint-GUID: -JI_nmlf0-12SpTdgdgjjof9NTbC1MrX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXwUfSnH30e7R6
 Zoc0BERmvY/unR4R1pvsBGPwLxWnCp3nKk+EOPk9g7g2Qnn6zCs8lpqmXSmTCYLmjqHG+VL5DDI
 2A1Zo9TGAUH3azFPsZfeFckXSg6KYcKJM1RWWCAHyk+zMgvGfSWQF+atujk6UKhkl5QxTKBuH/0
 DtDfu/nxJzbJmMZi3EdBPVJl/Qrhp0LRXuRi7DyD1aa2qdS3moKB5byWYsO5ZMjC8MNdqCGqXJk
 2PdxgKStKVc/HgAyHd7jm7L0eeqY+j7vThf77UEmlI4jWnkLD+o7xCdSQ/xAolV0nfkIsPeqFmT
 0XJTeuowq5bqqVnQr7DhgFG3kv1zMvoHkxbgxp8tciGbAqSJXC0agWro8edwKMB/9YlJ2kOI2Ur
 bfmRBHW+z7hUbx4l6zev4mOrpCdX2Zu8sgMtJHCcNxOLzokoBABczClfGcYfVXZDj8ss+lI0PlJ
 HrqbWJGi2ADEqP9ywyg==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b002a09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fzENmhSgVi5qTvzIpAsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXwglYufHDJEnQ
 jQxgfDTDdSUOwyQoB+Wq8EeLk6QuyKPHcCaGLvi5Sa3nAYw9jgSASzZ/sSv8W80Fj2GQj3ac8pA
 XSxEG/EIvQ0NkRhFNyp49JY+Wby4O7Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On SM8450 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 8f84668169fd..f7dab346cc70 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2619,6 +2619,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		usb_1_hsphy: phy@88e3000 {

-- 
2.34.1

