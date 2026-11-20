Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182223;
	b=1cUuk3cRb7bxMV7EiMoxg0QsNTyRqk73gucVwVFAwjdJyGAAIulJnY7Z7Kg++UblG6fY
	 m2Hq1KTza486EYJ5MMhLMQUrpTlhAmWlw2WotrXz6V5xxWBz4QM9rlO2X0INvBMuBUj4S
	 KJ+mgOU8oq+gLlQS55dMfPqECquYxOIfRjokzaHw88nzZrZjPdMiq18+PONXAvyo1TGbH
	 HNXhalaou7N489J9Vb9vVQ1NFu62/wg4N7ajcgcPGoRwSORgcwzON9X4ulzbwJKVqBfqy
	 LTU40uDbPzDZb7cntpAFBfLmxoJpZ2mHBq2iH7Q6EhPUkJm5kW9zavUyUmc1JGGfQDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182223;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NVsllVIT9IyOIqvBc0flk4QJ6UG5czr429XkAIGHQoo=;
	b=Jl6oOAmCsSciV1J4edEx4te9DRHAB82IhPdamDY9ao7njmbBlRaGJKuhgZxLzZ5Q99aj
	 tey/zs4r64UfGC109dTtHFoAwCSOgJ17erxI0aCbNd/RGYDsK0HpmQSwDxVHGF6YNp7Ow
	 Ser5lr7qgnjZAP9gROBX8ZnPk/0FwFbvlYxK9jMMQPqOSwpp72gpBwyKHrpfX4gmEdFhW
	 fBkyWqir6vYYzERCTjbKLqmf06pmgaX+wWf6iVOUceEMsAPaXFoEq4h2vovLyqaBJb8r7
	 BYV6ISTAzSqVVhVhIcqTHf/5QU/jK6oZq/SWqYjmikR/VFiQjI27iRLW+GSNPMZFZhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIFuxn7P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QBAOfMF2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F860A381C
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710F860A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIFuxn7P;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QBAOfMF2
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjwT51528606
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NVsllVIT9IyOIqvBc0flk4QJ6UG5czr429XkAIGHQoo=; b=lIFuxn7P2imN2pAV
	Tme6IE7vbrfEh4VBG3ZmY+gFc5Yo3Cts/tO2ovzN0nb5ltc8BSnEVUbt0ooxN1KW
	Uk27FMs72PkvC0YSga7SHh+D+HaiFk9EukiEL6x1A5RLgJk8JZJwmTrUrpNiqZBG
	l/WorKmayiG2h/Tqofq7KpKQJ5jPbFyk1mtFCTlyduL5ifSbwiJ8knGeHg9Uv5uc
	+8n4P+4rVHuLpTI9TGZcChMKyc2msPPAUsfB+2PMXX3fF5aY2WkmdYJyWyF6MDFv
	Z+voFFBeVxuq0upyW5i6ni/nZbVo8uSu/dR2CPb2nFcn2rkWbhFWV/lO3EDsdDdM
	EOKUXQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtt2pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38355b03cb8so856061eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182221; x=1795787021; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVsllVIT9IyOIqvBc0flk4QJ6UG5czr429XkAIGHQoo=;
        b=QBAOfMF2zvSDosBMbdaLMhjel4IX8t+8ob/a6uTjD5Q3ifmXhTkjYMQ1U+aGT2N9oW
         NTKI7cDS8O/MnkOhLLolB1bOs9XCo554DjuCiIjWu2n8+98SHFSnIVADHFprfnQgsjO1
         IYTaH4GbJxmXGND6a10LiyVvYYmJmMVZiFPwx3foR4eb6jQ4uYAVBsZGdSXKAmhdAx2z
         lwRjIf+WNwdFm9JjpPyjGXi2XNOFyI20/3z5qw7UeXZ2yaWsS/mKFQgChBUN2ouX8Ap5
         ojyT20kvkO6qbIY+k9NoL6FIEp2a3xVWYDWWQeA2ObgmHA7F6b8n6tcvaeEBM7Q5+qBG
         u3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182221; x=1795787021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVsllVIT9IyOIqvBc0flk4QJ6UG5czr429XkAIGHQoo=;
        b=tEGbNP/wDnC+7a/gWuUb8M9dZMSvTZczsKtUU3gOrlNGuEvHU8yd+FsPTSTexcr5q3
         3RufsoniUrJCDnh7zARM58RtBEOSWMfpPFlpwSufkSjja3URvTtR5Ury+xKR1p8qihAj
         hZ4w/4yLxj+IEjLjKTif3qZMk7gHoPiRKnYsurBonwI6ICc9bGOZNAK+hQsk6Ur2dht8
         bw+UIiNSZj/EbRsd7FVp9NARHxAUetbH+IDARvfu8oapkeiXegir1LpSIWMRcvy7uv59
         xYkuy/2bVFLIEx0HU5pl1y6CrruBUyJlL/w6HoqTa1M+gzaa9IvrsvnWoIWUqyGr3osz
         12/w==
X-Forwarded-Encrypted: i=1; AL+hErE5nrZSfosyhsYI0ArdUqzdnCFet1m83hvHDL2GPYPQjAHfSOeBIlhICRxMPhlbpHDh8dHKzg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SbtZef9rXRB7j4B3xk5aOS9Gf/yT4gnlGSLpoYhYQ5YoJpQeF
	YcIIZNjHAvzKIin6NdkxlVklooCxAQBx0cjO5ayE731tzZClokkuRj+lybJfyp41H93DtX52BVs
	7ZoRfdjpUjNY9ps0BhcT125cy0o5Z+TW/n3uCraOuwt4gz7On2rHkFCWrfcMl+ZjocQ==
X-Gm-Gg: AYBFou39kIdVSm7B+WZJkkPJn9v526ObaDbvTjB1COyTfWCNJhpRnkb46wxLb8KnKl9
	t50KktxTWkXt3p1YsC+vKBt0MAtKrrzA4QIiZ+Tvuj6+KplTSQWJ3jL/QuJU7bG+HT+kvlyrVDo
	vD9bzpLvUdPgAZ+GlWHY6W8t77bhGmzoytp5FKdd77pxGUYPK+/+1kZS4vWPJrsnMlbHDhNg/P+
	VuYkqpn/lE/VF5d8/mW39HAmKjISsQNBSDAYuDy4/ZMWF85D5LLHcKcGRRlS8LG6YhxMBpZVIZo
	xi1FktKRFxcYFHB5Lfpeya0VG5nktXOMDaWEyP0IQZaEK86LGNCoHvbzgZDeTSo9CH68wccmmCN
	VexKDRJarB2UK3mvypB2SLgeV9lhmQkSrZNqAbT2NQMRbMUijx28L4TrLlqCmV0lsU3xVe24HPA
	Ws+h0=
X-Received: by 2002:a05:693c:8955:10b0:36a:1008:5815 with SMTP id 5a478bee46e88-3856c6ab8e7mr2866825eec.5.1795182221016;
        Fri, 20 Nov 2026 05:43:41 -0800 (PST)
X-Received: by 2002:a05:693c:8955:10b0:36a:1008:5815 with SMTP id 5a478bee46e88-3856c6ab8e7mr2866785eec.5.1795182220304;
        Fri, 20 Nov 2026 05:43:40 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:40 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:45 +0530
Subject: [PATCH RESEND v4 14/20] arm64: dts: qcom: sm8650: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-14-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1038;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=QynpQTC+tS9ewt8cTvKXC0ob9aCwyQ1VtG/dFxw7GR0=;
 b=FZbDUQLy5/rKPk183XwUoaQlvO2xvFMjsoX/3ofTAfk1NBf2M06oyjxOPBXj87iMxDLttr+ro
 Ic+UGssZrIJCSIIiqPnXLE/1eFDIukT1LoV5Yoo2qcSPsdGc//rTOlV
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: FOKVCsWwRp9FaeQ77nEk6IxquqTIF-Lm
X-Proofpoint-GUID: FOKVCsWwRp9FaeQ77nEk6IxquqTIF-Lm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXxnAgwwV1FHUt
 8coesUAYykUgJdsuT9PrkeApBIjgW9KhUgwrufcQPOcWNV64w2Ohpf/Hug0UUw8/ZzszCcfn/Bg
 au3f3uBBlPNtc5eFOLt/bzUwtpXCoGZX0X6YwqI/WE8Mezt9xXUJp8cQVWXjvU3phF7e+UmQoz4
 abDQEZODdHUannRHD0jMN7GkCe115EKkqu8ZQSe0r8pkR3HnP9SQppqYrFN3M1z2TPWeaDdsO0U
 sQtRHnTeGscF62qbulZ5I4FqRetUnJnkryorILjk2MWyUdH49L6StH2Hwl1HYvzrN1XubKqo5vS
 s0M+kRAaHlTwGBpFyNb8PaJXGMEscIg4c5U+UWvjNw5YD3tSmu1spI4i9SiUZIrXR+J3Pb+SexL
 gPBLTbVw1iqqK6qFbnSsqORn5I95aJD6Lam3iyPKnYKn7Fv9MuAqVchElp6a0rKWaVgB2VrEmMj
 edgQruJXya5ZqeS+WVQ==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b004e8e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LWIT_UWqXYlThNCXQxwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX7AyJT5l/+P+b
 K6ZL9tMXYX4IYv4Zc69iAc6xEfUhBU3vvPyhV+PCLXMG4bcI8dkFej9rRuMXU3Yng5TcQCLZPiX
 yn518foZRvcB6RxrlsfYoTbgMdYO+K4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On SM8650 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 5a030f9646c8..ecd051ecd680 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4413,6 +4413,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

