Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172827;
	b=fj6Dl70VMoSBjIRSezCEUS0mINvGb6ZOYRHwyXDE8Byp2qazWohO+AkJn0q5KuXuBG9A
	 p3rsHSBEWtCnm23zqMaOhxZeo2KKOnG9QdC9dAnAs37UiY5Ht4NrEPZZOU31jr8Qf5FcE
	 LKHwNTwA22qU0S9T8wENmTZfLsQu6dOgAN58ENVC4a62Is01bokpP2Ch1enW9o5Yb46+0
	 d59O339ybL4LDPuZFqWGryPVXDJ7eNuoWQGbiYaK11/xApgn+9MY/tIlM4+1xBA5yscl9
	 OiGwPA0xjulQpSUbRlXgDU0AHOKjp82eBdlBZrUQF+ioeFE6xWs+EgVsVOxi/IVqsrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172827;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
	b=r00Ssk461Bo3rLfMSXQ/PwRDAz0PBJm1Yj6i+auWcMUa58vDhA6Rgahi+SFiUzlLKekA
	 0QVl0J9wsYa8/T0QKNMwSII6oFAS7FKHnwqZRRbxz2buBAPjBnvcVy/NkmmoyO9muJ7xq
	 V8nyxhd/eGQ3BIcNxZLkMLYa04SxzJiw+RAp7M8Mi4JE2OVCcIYJvQxW3OxwmkMaQMddq
	 rT3Bh2ryLEifrwyL18Iu/QC8lUbJJeY+NUxG5dVhn72Q03Kql5ww2QiVEFDQOxnA/ydQ3
	 sV2LXO/Nv7XA/d0kTeSKridBKzIPEgtxTdqtVowtOETNUSUVwqi9VaoU9xi7NDHk+QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Blpj9S3j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IcRRTiWN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57485606A332
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57485606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Blpj9S3j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IcRRTiWN
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjxlU556465
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=; b=Blpj9S3jBEpimAqR
	kcnxRQbtKRqltk8V1M9qtQpYbyVMXPlKJNXCkEk4qw6pHhw3kOBmuiHQorn6HDfi
	stMDbLOtYugmbrzXfUN7ks5CaHgJFmia9ruy5rydRPVgKmZ/ujFWUwQXwOQ4vcBr
	MJ5F3/7/Jh/xiwAdKF8J1tcu7YfgggUB6om0hBMGWvXd+wQNWY1xYzY0by7QKZpE
	b/IXdF2sSKg7lSq5Kdo7G4qRGGgkYd4GiTGz+rm9u7NWo7/OkuGFbx+3+a7yTXwi
	uzv/bbd+qZK92CSrYPZ7TLYAW6EwtMuZwh19jFHDuvbZnbWuoVVsAZcmMkSWiaEa
	3Go6aw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbhdy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so822496eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172826; x=1795777626; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
        b=IcRRTiWNmsGAgpvgXQ9gjjDk+1yb43MtaNW4WdurYgShyZIOPe3byAsVx/zge5j6mM
         l32BgKpmGDPaXSReneoesUwhfK2HZd8+rLP7x/lWg+VfSkrq26wkiz/gaAmAmMhrUASL
         /Og8eq6hEj8HMKLuiootUzbvjwQ1vDfxROXdqQwfTCy4Ne4FqjixsKELn++we7mrFcvL
         Oi+5C+yLzNllAwo0L7Vu3Va3CrX1ZtfpbzU6qAJeNsihy6t/lRECWMXpo+hbkyd6VKx0
         gCyR78xV9gPYnbzKGT/b9ig2UEdX/gzUKA/G2yvSZLourIGXpAsIXgtA5xoqL8Jd/FOZ
         l6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172826; x=1795777626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
        b=lGvKgbfr++56YX/PMwqnB9rtQdVMQZXux2Rf4txz/OzVRnvFi4Yv0RzI6dS1VKbAIk
         cN9BiZfJTtIeqrBkZBnEPVEZAcAcaVB2va02W9GRxTJX4wOf1+FQZz9G4b+ISstQ9Igj
         BPRMd8QseGFRV9KZAgU4G5fIFRdAq8liCYMjlFe5/dIR0DggIr+ZxvKpDXWIS6k8cLr9
         Nqj+tFYOA9iBF8PUzFs8E9gk/JfD/caLl/LwQZnOD57RW9tn2JlzgI9+IlAq50YTSWXh
         97/2QvdGnAtJyKtwNqviO9gzUctPePqz3Y8T6/AMXOgAdazmTLf17usqWfKg6yUf4QZj
         nvog==
X-Forwarded-Encrypted: i=1; AL+hErHbE4PeSGf3q2Jlx0KnRCbV2irA3D0MYIT7MDchSEUPtnhqsQ/4Csu1B+rCFdAIDa/4tofMtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9pYmDyD65vDjuBZtbEYy4dDQWlyQ4vPsL5UcJG8xdCaRliX3sS
	lulo7QUieh0unY7vCIKLmFkhxWg0k21CrCjupX+wfEXMUufBRPFvCekBGzy2c9swj8bpMPAdPf8
	z+aHrIQv+y+daQGFTBHfeT/PGLNlOMX0PN/wcOjxWKwGcH7GOKm9tGI936A==
X-Gm-Gg: AZFdTZf8EOsnKs4MK63NcZ8p2xSIhxMOAvCZS8c6Hpg6DJS2uQZrCO4sHmJQWGoym81
	PKiTGvNA01gU7mfQ7F293O7z9h7tZr8KCkMg+BeY25puJk6D1aYKUphlvZYthVcLQ+iSYLSd+fL
	f+m3gKHvC77h5eHXWMBQ8HQMF/euClbzX7Gfv9h8ngunHPK9vrcgdioxh/7HutSYXUT9QHypgfW
	7+0ejZE2a1MsvUjgFWf6MbKtmWANq96xzL8nM6o9XvqUTNpjgdcN7nbEWPWIyi4Uf7nV7CanK2m
	U8+2zxoVSN4beNxYMdFNOxyvUwYMVqGXN+yQcuCY49juByGpfHli0ibi+LoiuarLDN6WDJiTKfE
	MelrUUlN47LBQ/wDXgITi+pPcpSwKk0i1AFgQnECSMl7JYkyZXSRB5qdKmdm9vDBDR0tilzdWT5
	HLb1IA
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id 5a478bee46e88-3856c6b00fdmr2845773eec.2.1795172825848;
        Fri, 20 Nov 2026 03:07:05 -0800 (PST)
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id 5a478bee46e88-3856c6b00fdmr2845713eec.2.1795172825017;
        Fri, 20 Nov 2026 03:07:05 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:04 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:44 +0530
Subject: [PATCH v4 03/20] arm64: dts: qcom: kodiak: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-3-cab8ee8be0b3@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1065;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=nfp8+SD9J7PQP1TIlHLZz6YXOr5xoEhGVTCZWtBdhd4=;
 b=9enQAwhrtiAROoFA0A0yXkaYWGcoYyy6fPoNMJULacdk9ULbL9BFKhSfPzmdlWfAc50CSpTuM
 BXgU2EZNUdlAiuErjAsMTVcYGtW9zxqDvZf9rLcNWXZVHqRoHeGmXEN
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX92QHUwMVuZ1J
 Z0Jw8t5gjO9kVAgPWB6d09C1RLhykYVzvb98eB8BNjVcqTfdTCDjVJ7OAfwBXvzketyorp1niGs
 fu/cIT1BZFHre2a/ig1hhChE8EqVdtT6r4aEfkR2BkSBM83FEd6MM+bzBd5W8NwZD/901lSsmT8
 3PZDLPdU1piM+A/LoRGfprhAc8eiepnE4/PX+FtZkq7Imo9/OhZ6G8LeJLFD5BC2G8eKag7ju+1
 JlkGbr5zQ8QRYaufDDBAHWGVhGOaZGS/9BMrLdb8ceA8PlsKyMZ5tAOvtKLmYu9VYkHy0EcQ8FA
 lTIBgH5199W5QnDJl1AnsJbasqbQP9G4bxMoTc7aWifzjmLa2Ni+SV3GV/JQ3Xh205dDoWuTG9s
 dMVHiI5rtwRF0JCPLP1zZohgxT7OKo/qJdq+SFB5BptCrs8wI5Xi2qOO1Ixho2nwdCmDRrACoT4
 uQVnUHTJLyOtX3m4yLw==
X-Proofpoint-GUID: YHBizi1CwTnFDW-WmF1nR6l2ptBLb-2j
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b0029da cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wmxX9RSyIuGEu2EnybwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: YHBizi1CwTnFDW-WmF1nR6l2ptBLb-2j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX5C1MmsVmCDyE
 DFV6HyKcTpz5KNaMWcshaSlmSiJg/CislNHtTf5yFrmKJWWDolOrSdzO0m0c6CDNdu0gEls17jV
 Fl69cvL6wUY0N+BNR1yla2LhZ7yk0T0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 10e9a5279ed6..c142c7cb509f 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -3413,6 +3413,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gfx_0_tbu: tbu@3dd9000 {

-- 
2.34.1

