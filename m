Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182245;
	b=xdqOgJSvcY4cYv6S64yZMlWBsVer9JfHijUXTXHxyl11BauP522d41mmCb+gz6PG3Q4h
	 W1I8y68n7Hkbnobd2GxhM5mfBHSMiFIulmVEs2WU6vQJFf55Vj/VcQJFFPD5Bw+PhvdCt
	 jRf5JHpP79OK51HJDfsur7UO+b2nm8gp6v5UpCZcCMrfNrpcnqI5QPI+e+6t/Kndkh9/5
	 ZCgHaAy97WGKaGXl2G2qvrRnR8+4+jsF+aY24Ot2RKAk5D+J8H8qltCnqQxiQowtOu/q+
	 F96zDtKrkekOBmd7nx9Q5aNvp438els5Kj/Rl+2tX694cBwPq3AM9dKbbFwSpTFQ3EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
	b=V9JrWrdOTkZ1pmLVcHh4rFYbfopdqSO2UwZyqjfraixG6mmYBfB6B/I4fuBaF1DRroIn
	 gNYNLSHKUhBkamH1xqOeoKZodhQDJtTAxAh/4qFxyq/ZEnKx3j9viL8xqXKaBITKV2b5w
	 TSSTyPZLs11aAPmgNGsW7tPUorJnq9rLVrgFGZRc27QiH+9dhQd1+uhcrvz4PzUcK9BD1
	 A6bIYfBKco06bIGrdmTLV19B6SGNU4NCVB98AAi2owf7CmlWz7gqJoaNv7SoQF6NDFP7+
	 TwxHJ5Jst8qW3nBDYph6ZMf869qpGKGxK4OZTs+dlR2Wb5RDYyt9Ns6ME5hyqrxquGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8lmYrck;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cy1X/N2D";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23760A2607
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE23760A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8lmYrck;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cy1X/N2D
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjqVB1681886
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=; b=h8lmYrckPdPOTE9c
	zBfMzDPhb09b77c+f7yC++L5R671ZuqDB4ARr8QmZkVWngg8rVQozVA5dAT3uwMv
	DeCalnH3oHpSn/4mMtGROnCaGRRte5JmgxEh9tBuWB3fpmh9OmhYJncenlOWJS5E
	nqh5ZTC+V9bv5AfI119C5acSzsYxl3n8GU+fZDBPKB4JMtNxusRxFnD1MxlrSC1Z
	VYJ9wu9fcadHw/OusG/AhSdbWLb/tdl7JFVZ3Yn5IanRMQ+MZqyxIqWwMK3bU7LZ
	m1+mSlPSPFfVi1VUwXXkwVx+E2Wm3BtbjC6MQnUEmULsvha24zyvKq0IEt+p4uAK
	yS/U6g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1tqe6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso2856995eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182242; x=1795787042; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
        b=cy1X/N2D2lM8tulKizks8FtNpgYEjHvO4acaLh0zqUbTeutgXEMjJvQICa/RQZerkf
         jvDo2VMtHOi+uKwjjAG8IbQgUB/z+Ti2/D0nfpf+TvSOawzCAZu34Qf1gzd2Twy0CySs
         +LdNVdhsIwGNVXt72K1y61XyP/edIPYuY7H019v49g391AwyjUGNbd9DMsVXljj0oODH
         vjmMbge0ZCixxT/VTYrxqfnA5UEvURIto6l2vvcHu1KMEJS36PntMNHgSuHZOhrESqcR
         aX9HEuZ4Dfn8t62aZ9dIHmTXIJT6tbEQrZNdzr+8+ZACitv09vJCkcGHDc3U1i724Ojy
         JkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182242; x=1795787042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWLejDBY6cxKAWalyM4UrAn1z5uDI+O1UHK3W8xEzBI=;
        b=tqtsCWiRyMvNEALP+kyYmlUunZ1c1r3VHYY6Mw857vVFEsMKglxlwjJMWxjmjZSsd/
         T0CxQrybDYI05v7crBO04MP8qrPkERXcuyGC1zQt75eTnKm13ZuLykMrIOl7SB/dfd61
         YJVAvC9gHharshaIMJaSPwRxtcwTiCTuERL34dKzw5WTE/Ye6XQFaPqEw2h61fcuZOtn
         A9dw23n0nbBsGL2zTT07LPntYAwcxIboN36+Lr2pQfCTmz09WwaYGfB0x7j9Fomz36XX
         c8HRyDwQwFGIlahqmIORa/4PSyMulTDRZabadibHFnYqyIbH1TbQAji6reW5XJFWQa+s
         XZYw==
X-Forwarded-Encrypted: i=1; AL+hErE9+JQY9KgSaM8/U+EDZnmADvyZ6mE+dB6J61Ozwj8KosP5QqLtRQDvEbMbAf0G8f1X7DnROA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sV2Z429Is0C85XPNibkecsPNlWQTUABGVQqeM5LUmmBMW+lus
	pAHVkl9xInHiE/EMaRrstOV+Jlboki04kSRWXNIJ9cHkzDusu/y1glP7NlC6TEyxErSDJxd2oWL
	4jhvHXTryvV8+Lbjrg/C06KpIloOxd/vXoHELRozuuqf4Pkok3o+kWg0w9AR91QD1Aw==
X-Gm-Gg: AZFdTZezGIcPCGLrpL4Cg8vUQ99fe2BXZ4iw88tqsbz9j93UH8VKxdP/74kwNWQAvyu
	NWT6Sofm+3IuoV610SRqDnMYN9TDPfobodEiHmEIgHJtGeQZxmz0L2NxZ2IySIzTMhMj3OMF/US
	uZnXmcr+pHryp612DbXeH5IXsIKl1aG6wdZNaeWsABfPdJteC2834yxkA80EnPcE2Q3AFmdhpbg
	vqKyu9Ba9fuD6IucV4OS1s8/4evVuwARtCS0D/+tInanLaaQy2cNRdOgs2iJt/0gFsizl3bbnL1
	dEotEtDA7c48vYU1NDz1UBi4EJwRWTfYcW2nUvvYCQCJ4+D+b4hByQOlAwxP5bOTf57IAm/gwPh
	7mMxZbEBYoVSvs7kdbH7OjP6dnQ9BaCKbPaME0j/INHkSfIbxnjUwwkcSCDZFE4DK0M94AxUJG5
	3qh+s=
X-Received: by 2002:a05:693c:87d3:20b0:382:8358:9e03 with SMTP id 5a478bee46e88-3856ef457c4mr3214240eec.17.1795182242322;
        Fri, 20 Nov 2026 05:44:02 -0800 (PST)
X-Received: by 2002:a05:693c:87d3:20b0:382:8358:9e03 with SMTP id 5a478bee46e88-3856ef457c4mr3214196eec.17.1795182241665;
        Fri, 20 Nov 2026 05:44:01 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:44:01 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:49 +0530
Subject: [PATCH RESEND v4 18/20] arm64: dts: qcom: milos: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-18-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1035;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=uW8nrRF4SJLtr5/e82lnBVVXICez3ZPhzw4syEcDxKA=;
 b=ruBw4Imxa59bxECtm9BfDnEQ/DhLV5sEaxl2SqHiR8757X6GkqgD6J2x9UuFHUZeWElYLwbS1
 eSMtXQ8gr56A+YS8LcG974uxZbhOFOHcVO3rJlm/kmCKVRbZFPz+WnV
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b004ea3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iSr-qRAn3DWi8jR0IaQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: MfuFzWACEMZ4QxfgSeKKOdkv1-AnJ93l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXwPo8D1lt74wi
 q8O4eMCvzcbSQx3SzJTnV47semfNM4YPDxSnZwCbq2iZl3JEqzWK7yQVWIt/xS2BUbAI8kOu7Hu
 BVuQVTBqwFBPajKYje8xTY3JPLKfvFJAGc80eDqW0g+6i4zyylBZT/0L7CVFwGTsXJ2bpGGt+xu
 Z34ED2cZf3wnBcojTN0p8/wl8GstoB64DMioqRz/fU05z9fFa7+kMe6TPDlj280OLBFNBZIuH+q
 D/5x5Msudsr2NXiZJc7/Wi/IWexZM79kFJ8P4K3o/R76BQ9u1BEftDJKJXWrKtaBz2+V+aAD2ao
 MtDkP7Qp1NVvj/WCYNFU2+Z9LdpsToLP+or+uRMGtihh6eD1eijx7IYKUfB2DxpQge2FGBf7SyY
 7/kMGali04fr0AJ6lgd9l2/nxevKUzm5LTsHO24M0o9jPiattUPqcKQ5o3ku0Fg1u8LB3zbY3RZ
 tg4rb19zb4qXgZ6HbTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX/d9gfBXrEDP4
 BjVSskpjQnI6D9Pw/mFhJXMacWDt0P3LoXQc9nCNc57+eQGu/LkZmYtbmADcws5RRqMzvua/OIO
 VyKMOtnhxzbIeQ2a1L9Mpjc8AJSfCfk=
X-Proofpoint-ORIG-GUID: MfuFzWACEMZ4QxfgSeKKOdkv1-AnJ93l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Milos the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 9cae93b6a610..49ea0a8759f3 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -1988,6 +1988,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

