Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172881;
	b=F7cT9HGnhZwq0x6mr4+0Hbb8koggGlvG6TmwWOE0h5BYhAsaaCzis/vCic6q44925oTb
	 RwI+8zI1ugEDFebN/xFC1rGHxSubtnLLMnO0QCNEGhdT/bQiJJ80q6r2yd7VETpFp7m6U
	 Xzs+5t0aNsqG+hcGc69mPd2qA3WihQKxULcLyQcJ7o8Smfvk48bxCk+ZZtX7v+jo1JcPU
	 72fJnVAD/BHDjkFxwonHI6D+bzjxJlouyba3hMw2opO3mVw3W61E7IOIpUsFRor9Qgm7U
	 aSGviYx15LIGP7kMMtPqE5hcB+4rmUUAeAEBiwDppfj1na88cx+Xe6/HzUkDFMg0w6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172881;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SDP+V0k/153kXf8kggh4dD+QBvViaqb1sIHAp9EgEOA=;
	b=CrdhrUuY/2vHL40sWvC4iI9yTKZ3Mc0DCD39KcnABkYZwgsaiyIszEkTufgqxO/HXUZ6
	 WnxHCzG3uOGNn/awbaOt8dOqnDMkt/dJQaJ+HfU1i8Wh7rf16CSIXAtLa4w3X/ZQwnvbs
	 33Ggzf/iK9YthpDkLvupYpOWOGHFjO+tJqoRAtJUvlkfyWY1G7R3HimwK8RItaEYRrOem
	 mRgMXO2VJg0j1FWHpn6IKIlwp4rkK2x5fhdxr8b6ZNDaR9bZW8nCyZh1Bq4pMkUFzh9RV
	 phzFlUlVyf9MdGBZATeRemMVeVOJchg4q07PV6h+j9akv7CZ7Shbm25SJTcB7h7Wa7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eMz1aTBh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DVHOCnfl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30888606A330
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30888606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eMz1aTBh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DVHOCnfl
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk64K1528777
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SDP+V0k/153kXf8kggh4dD+QBvViaqb1sIHAp9EgEOA=; b=eMz1aTBho6i3pBSq
	Hi4uHg5OUvEpQoA3uxCsDvmA8GWfmflH+qkW8t+GZuMTZVPOUwNPHvbL7GF7+LgH
	idr0PtpVEoxoOFtKnrULAq9YderDyZ3IjY/qWcfHNsOHDA+ZfP98iKAd/oYrqMIB
	OY7pVwGF1jCW1myF7AxN4Fl64C3AmYzF9+tFvjqqQ3xAnZTsUSxz7n5yYs76n0ti
	DUYM9GR3p3ueUyf3lHkxn+CTymm51yWxx19hkX3ZGprikP9Ipg20PWukDGo1HM1v
	UpL5YNbZEqTXNgs/9qWTTvPE+ZtK8D5Q4lSfyQcGpf7aoo+IBXzGnr+f1vpSvXtw
	TvrNvA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtsgaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso964823eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172878; x=1795777678; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDP+V0k/153kXf8kggh4dD+QBvViaqb1sIHAp9EgEOA=;
        b=DVHOCnflgKZpKKqa+ILZTCHVllh9U2NgK7t4zLjHjdQL+25TjdIMtqhkqzszoNd0n0
         8SdrNKyRqdr+HJAQjq8Aduh+NH62JIEW9MlpiPsDV8o6peiSwZ4fm5RUw0q9bYzDDrnp
         0+d7qVb82lIXrndq26ddqqVVR56Bh301k5JMJrK6a1RJgzkGibBKz/tV9pz/m6osNnDi
         HK9C6ynw+X2F60sVsBOCNH1lF0DVLqw8awH5GMf/MfZG0bouNc6H1qZvXA1y8dj+RGNx
         1GcyASJzffmqsf5cvRC8bQ7I0/AE7TOpRVNZgx9S8X3BVbjBmk7dNwgE45gB7YWa4EpS
         Lfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172878; x=1795777678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDP+V0k/153kXf8kggh4dD+QBvViaqb1sIHAp9EgEOA=;
        b=JUSalmfONvIuGsAIMfVnBUujTa7go2fm4awlaju+xdlERJ65bMNooka1E8kjgIHO7J
         /nSaFI/NFd6b6uxqomlZb9mzEQ9pKH40WMOjKb+3rTl3Xd2q0B84F9BMens8kYaqSC3f
         /i3Vk8bJT81aMhFAs7caT9YaaHFs8kqUDGcpMviOJ0EbZh+tm5tsB6P2RCy9LjaPBmHH
         NjhnpWrLgPjW6RbdfxVvuulaPZWYv4ZABliFeQuvoNa3tXht3hyqEyGuFWShhPwRec4I
         kuvSVkB5BYXoVhOCHfRhRQ2wLnDelTRJRJyRtHMcqPYzTL+drAdlXn2WS94npBLfGFrQ
         oxYw==
X-Forwarded-Encrypted: i=1; AL+hErFAPB1IuXBuBnIl7PT4klu9OCuush3pXU8egZCWXcKXd6eDYZej0hE567xObfCLXcPse1slmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+lqd8vMUX0GGH/3byo8rgtjq/0YsEZ+LY4HHpNERd6M3mTazK+
	ILZ6ho0/DyQpCANOrHax1uH0n3FWfJJKHa+xIXMGW/YvjPQk/mkUMofFMH5AdELfi2LCQpIpd3e
	Q97UyzxHXc8Do7chUPSjB8JJvEpSpgTLKKeCgKrstjIMo2thm0bzjZx/iTA==
X-Gm-Gg: AZFdTZfhBuKEFSwg7AmZPm6Mvd5g5zHFAtFhnjxLGeudHMbLuM8Dn69yYJeuzIBxRun
	BqbfiqOq4sUKPc9H/brmWqRHx/lo6f3vLNDW2H9WQre1gTObyhZzMpqXPGkYxjWQsWw/sCRrfCZ
	rd0YCKHyS2uFsh1cu54eoiKjgW35balTo/f/mJTK+/cPgF6YozBzNtV9C3PdfgK9cM7ppRZM6vH
	CN+5+0+dbgEwRqcbne/o0qqNc++lyhFrk52ekEwAsv8YufGhk6772/3E9QKTi9ME7FSXCP84FGm
	Gqe48MZAcwFB005sODudQz0UpJKYg7DcYBilb55AwjgJIQRTzi9lRHQq6QLgoXtOlXFp3JILOYo
	4q++HKlbgjE3s4BPNU1+r2stUHHq8eiC1BFHyt2QTLerq1WQMZ2ZigVpBl27K7CK7S4tzbsSBTp
	Z6iqCR
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id 5a478bee46e88-3860bd88965mr1185194eec.29.1795172877767;
        Fri, 20 Nov 2026 03:07:57 -0800 (PST)
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id 5a478bee46e88-3860bd88965mr1185151eec.29.1795172877051;
        Fri, 20 Nov 2026 03:07:57 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:56 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:54 +0530
Subject: [PATCH v4 13/20] arm64: dts: qcom: sm8550: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-13-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1285;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=ldSuaHHBroDhtrYJz9kdhWBAKmQCNWPZ+kaSFsE2iJs=;
 b=1DhQPxDH5zxc63A6kUvXa+BgTYVKQcYTsBdn0VFledIHU8tPlkxAnaLMfB4c5tnQce7U5alow
 YYZNkpb7ofpBfaW7Umu0jWjraHGjx/Sm/DEEBpt/T4QaLy1jvaqnOWp
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: p7eDY4uq_16_4f_9fxab_ekctgoIBcdm
X-Proofpoint-GUID: p7eDY4uq_16_4f_9fxab_ekctgoIBcdm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX6UTh4TXsB+XB
 iTjhUOv42BTteXOFhE3Ym9sVL+k7HCIimKkY5mOsTL1RLobO3Nbx2qDLYMC9Eg6Qz0x+glClgcM
 bXT5owvMph1sgF/k+FZlUH3dxMaFkg0V5bFIsbcu1zy0/AIrUiynJZ9KF/jjX/1NajYc9FddLLQ
 S0PrVpHMR+8RV6z2eme81p4z+4cz9FOkzhpZRuw0HDorv1JMdxIAYAZVqj8VdK8Z7hRsWOMr/IS
 NUW13Q9StHzh4MezJsmCBLNXyMsahsLMxIMvJU8B5ocmi3lkASxjw7YJqBorcrZU0Ffw4TEVXt/
 LvJW5h7o/QeRScy7nBktxjSJPMQtMbvztMbrd5/tu6/Z3Gg3ljTLirQuwv8/u72qH0UO025p6Ch
 Sh1wGhI9dvbAkSqGJAyc5dT1Zajik9n03tLR0jdvO0JYLQqsC6EHdIQepoo3k19G3o0T8vXHp8E
 W2B0a2oo5i672/WHXgg==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b002a0e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UZQlob4mJqq41ALSq9YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX/GsFKmY68k4f
 Iz9pzhUtcMCFSIizAnsndjcTgOmjq7+502/Me33hKQ7f0dOypSL9PpCds5ge3JfNXMIbTvkdsJ7
 QADXAun7E7qpTB2irNXl1kBjST9EqJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On SM8550 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index cf7d67faef92..d11691a7ba36 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2898,7 +2898,6 @@ gpu: gpu@3d00000 {
 
 			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "gfx-mem";
 
 			status = "disabled";
 
@@ -3073,6 +3072,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

