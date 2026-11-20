Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182213;
	b=rwjeg/+M/7aKA36V5Xv3Ugg6ff6Qkdmbzf5LBIni87wgujnlLZSq6detHSIi+2NB7QKh
	 pjXHdYP6I0y1QCqWiaNIpiyVRaRXbsc6ALgsdMZkiJu7tkX9F3pDpHt5vTQ7MLMObDaNZ
	 faPJty4PwY6rD1mT6qKQPTyp+Zc7vtF/kScmJjsESZ5K3uZxC82UFqOTg6xSNiFTJLS0p
	 yyUjEPLKjBrVeHrMNyB6lsahIVSNZT3qXpmrlC5Dk4Q2CZSl22Gjy11rX2bM6lBvr4JKK
	 e7u+9suLSq9C2Xr9zr5eOGOTApolDX6E1vsAht2aazH1Enk9CWl+vQW2div9ranH3Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
	b=h0s/G8LV5U6CoVP9RRoslflwKotq2yRM2kg0qzSVjJElPrmWllLNH5dBZDwpkgXlt7WJ
	 Ew4vSgs8H7sr1OMU/QG6ZAgabCy60IzJYgEm22HB7NLigkTogmA032orartfjlocgAptB
	 m/r2A3nNXH/lTF/LvftCobGLZqsYMx4GhY7UaSTuD3wd8PtwFLkbp70TGWBrwLG+ZPl8e
	 EPqXZ8UDeD5WHbveTOS3R+nKR9fj3dvSEfmbrYuEuN1zAF7+oZ3CrZqFpzPkmvBwZUoIW
	 bdAPGrvz4Yhexw8NuLpeM+Ru5oo3vARjaqGNmBMXkabhC9Py3gIkGLkQVw27KDce+ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iDX0SQ+C;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h56qg7nE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D760A263C
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50D760A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iDX0SQ+C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h56qg7nE
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkLNR1170033
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=; b=iDX0SQ+Cr1ar4w2/
	/00qhlTElkSDRnEmUQlPi+xNC0A/bMK5ZEluq4xFreDF08sHnD7XlIDatmHuEbXL
	Cl14V2IIgHrxwOOZ5ftiGmRyt7AvupSMONsCgdNX7rhQa0QBAazPYgsx3GgenvxQ
	KotBHRuAbiL7u3y3L0QFuc5vEOhTDTmyskYlAScrl39mlucL+B+41vVCA0vJJ/0C
	LrrQEmZQjEsJT/gr3TJgVR6a3maErIxRiuiK6dZptPpxLSNgTv9rnS0vmIgWmNjA
	CQp6zALCNzC691rLA8UD6khSdDEYpBzfTkwCMAkswx/abSzJ/rtWR4w8qcLMUbh6
	gKvcTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5uy8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386177b0516so1468266eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182211; x=1795787011; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
        b=h56qg7nEwSJqSiP+TPWyc6rYrQ4R9YKC6dkVHdPPCQ2J2UGaAYM5DXBJwrq5mhQBiq
         6+nDVdcwX8Dosh1JL48+p1Ptj3G1Y/HYhBBzM2CrUlK7xFOD4FKRpxKTH46NlcK41jy9
         wDnzzUuxOdOAn+zBbQh8+VNoRN2NoPh1j0B0JgC78/0MSFynwrw5gXSfFDAodTUSbuFd
         88DEWYZUtD6fB4QpkmhauEt+XS4GQsvyICPg6VnHCG9gxNM2n2o6IgHktbhDofUpBbkG
         b67OnglTNNA0oHWQyc5kK0zERIYalUjteXdJBAMqZKujyhfJ5g+Ib4CyNDKlh701TvbG
         jQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182211; x=1795787011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsgAVR1Jug2GNmU8u/c7byKbreoEO8JhUT+pe3+6U4o=;
        b=E99cDUc0n5q8C0s+BWqooYYvcRI2dW0fmOvSzGUeTI4aaRtTLkFE98cBCqdrUAfwbY
         Cef+2rXFMdozHLneAvaV7XQqQ4BAe0cYbTm7reNNw+xuvt+nb2f9qePV702UQ1iu8DF2
         aSI6LxXbVX0YuU59us2Pi9zX7CqWGfpU+hYwT+qScM0dOqo9UrNaMX1GwBx/VFE/lwsT
         sBuJ/e3XqshqnuOxioOPvkXV9KgT05VikgPwX8kEe0ychBqvRZJpxFQuUw0X7aXCS1+N
         rDp9CRLnCfdp812cJTZeFDJkUNamdXwmZvXru7t8AdxylhgY4JJWABL4OS0zONqOn44e
         +Y5Q==
X-Forwarded-Encrypted: i=1; AL+hErHfifMEDCjDJpxMmJzow5EtV/yqeJSQGDQc0B068GnyV3ToWLyjlzCGl9MH/MBaT2xI2Kh3qw==@lists.linux.dev
X-Gm-Message-State: APuU4Z844fPfx+qaau3uRBUb0Rm0mB9M7og98I14f1004wOvOLJJXZGa
	U5ITRaY3dm02i+8KGEwy3B9PtAUmJxxJd0EYrOOf+oGQbX8m17/1WsjX1pVITikxEb6iQV+v35J
	T/n7a+I6xRA6YRYuggJTCwVcoU2O3Tjp9JLv2SgceMCe9Unj+eUf75e2Y3w==
X-Gm-Gg: AZFdTZfDJtV7/px7/dYf6wu/PM8lwnMPJ3KlfK+1xBaaMvDB9PHJPAdFNU7NO1Sy5v5
	ZzS0yMXLibcTKAX5JAV93j2pOjhqTdw52WEHPVpYVBqsm6rcu/7rTMP/5rN/UiWIWl442rUiwEM
	JykOjizrMv92dG0WKzf50yTcoKK7enPr98q28unL9mi8FwCsPj3uoSfqKmVSqf2xtRwFjiRls4N
	Q5veUzI4Vw1OHl9oDxyLSKAqXN7NTzc9yiSKJoTfVcRL+Ae2+4cqZ/MhQTkc/UvjKG3q8C6NqkR
	CMuXPM33Xk23gl+happPCpDqeDvteDUxx4/1779hzUi058kGx9d27ZoxJb3RF6Rl7rNbSBs+Pwr
	2h5HgBW03GM7msXKDdRkn7p6WWmQ6xiv6HHhnejTF5NvbfiHX6pLs9lVnROC0QIZ6Yigy5A2ZFX
	xaf0Y=
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr2985143eec.6.1795182210335;
        Fri, 20 Nov 2026 05:43:30 -0800 (PST)
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr2985097eec.6.1795182209587;
        Fri, 20 Nov 2026 05:43:29 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:29 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:43 +0530
Subject: [PATCH RESEND v4 12/20] arm64: dts: qcom: sm8450: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-12-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1046;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=XGSCDo+PAJtTWrK9Yli/KgTXld6tpUWo0Tp3e8IW/LM=;
 b=pw8cWvyKwent69F39bfc+dvHudt8wpagQHoCzw0hmqpwl4FfInvFtYZNwSN1sydn3qGmcjJ/b
 vgngXSRqSFgDW6kPfAk8Dm4svPRauiLxmUoEh69/6Or/Laf/oJ2Tzp4
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX7z41TkgCGV6m
 8YcihZVTILjXpTJOufPIyut+p87nbjUTt9r8DOWAt6eZkqP+I+d8cDbcM3wmMkJ6WaIe8mP+7Ci
 5y+KNFVLKyagnEJ3Vbvk6PFKSAcAxa0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX7sj6DGCXzGaD
 r9ewyPHK0Dg6C+14wTsoRNtsdC1ytuPikFeZu14N9yIzm8b80+fcK9ttfwl7LEZkcuZYmwzfaL3
 oRcxHOv7YNSiCXQ3VX3zjgYVDPUok7a9fgvMgDtGN6doAklFZtz5jd0VFPovJrEkVyAm0I11Bd7
 HCRbUvlnulbkCuERYDCg4oJZbi3V/QjYjxJ+HCIsmMxPjjiiqBbu3X4MU1Gj8kDinYiKy4k7nMQ
 GaauleMnTYQ/KokoroWdJOgC3WYSedb8os5DeeoehDAzKJTdXsvHDRqW7Wi6yMOhq2QQVYKcezn
 XENezITsfwCmc1UJt5mUyppIx505U4VpXT+MbFuwOE4IKqqp9h0oJftPoahmTJUIJHehJm+9Xkk
 GIbjvxNb+S6hXZd3z6/fcYdAV/kFQaKfNSex8daaH0OrvJdrqOFBtADALIlXmrGEckpzq9oa7mp
 onp4N4muY/RoRPLkIrQ==
X-Proofpoint-GUID: VhegxsYPfILML7wW-I3zGc-9XP2JnH4y
X-Proofpoint-ORIG-GUID: VhegxsYPfILML7wW-I3zGc-9XP2JnH4y
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b004e83 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fzENmhSgVi5qTvzIpAsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

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

