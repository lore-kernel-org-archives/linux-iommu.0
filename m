Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D20337B81
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912356; cv=none; b=r1KiA9IwYBSzSUSfUuLZmNXkvPxhZ8QqyoUr12WfD5Jr/UZSX8M9PvK1whXDBBFT+zkpAfnA2CHbwAKNmo3KZ/CZBFD3tDdwZyxUZ4AmGILyA+8e352TIZ+u1OsK24gwMytOn+Ge51L8ZJejzRsL3I/FRYkziREwA+tfUsrezbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912356; c=relaxed/simple;
	bh=vXFLc7V6vTbnZuIPg2XnR5XpGpGE27p+GqG/p8ZIcX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG0ENFVMKxAqV8aWmNBgW4thAcZyIXrJjWTJk+UoWdsZSyOg8e/IJT/7dCWyVTeXPhAggkya8SVJo59/EC2xt1ex6HlaLz0kYzPEi3SjTAAXRK03uZcyCJjEXN283x6UxWf6bSfwMWQzun1Oq0Nkse1FNnWo8unpG2of0Mls1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CtkAdHoJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QMFeMETd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CtkAdHoJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMFeMETd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65892Lqv2677815
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 09:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BZY/vylQEcnHZGwe2yyT0vpoLm07JbP2wAY1l5DhPu4=; b=CtkAdHoJs1PMSPAR
	n73pYZM4cgjvO6Fx6FIB+DKxM3jeaqX5spxHir3YcBzmWwWd2k912vHQsLFmDo2O
	FKitW6k/zsm7NF0ibJmLy0Ke2Fk8xxmO702cMGLdxycXy2TDk1YVQTsa3RgEkgIM
	1ZCGXx6LrGeNKSunZSUfhwvP8HLOOaUn23Ppq8dogUiiWDnbU9VO2/iA3ZR7C89Y
	4rvgewRUS4+itu6TCLYUfr38G1zCO1Lnv4zV8oKQkhSkkEzcA0V8dI6HvvN0xQEj
	3FqLwYquY13XauRDefn8SWxjP/alE7iDpiJhD0G8WaNlaG2ggAWdhzZwOOWfW7k3
	txoakQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkr7jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 09:52:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915a547f4b3so105489585a.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780912353; x=1781517153; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZY/vylQEcnHZGwe2yyT0vpoLm07JbP2wAY1l5DhPu4=;
        b=QMFeMETdQhST5QaAWOpmTTn29ntdirbUSDRaHWbJcN0iAw43VKZrUJ8qm++jZvprjV
         7MIC+T95OxCfl3pw8AKpFvhPQo1WStMS/eU+SRtzXb3d6F2Cnvzax//Wqnjd8gjwNc9y
         dtawVYhzUjutzxJsI4XxodNLKkeVavhxjlm05VoqJLQKC+AnSCBVHW+Yn99+gBCtFJrs
         858DHusYQ+Fb9q223ohYr+Il1bMonpGB3hhDhzsO1wLQk+ChIxj8G/qN0sRm0qz0dySN
         0DVmSACG4Gq2qyPHKswnpML85cl35GeRTn4tJ0PHQDjHdk+pAQ9FiZjmxZMh+tDEMQZL
         juXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780912353; x=1781517153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZY/vylQEcnHZGwe2yyT0vpoLm07JbP2wAY1l5DhPu4=;
        b=HqlSR6LgxITrgmJEKzHEGx1EmIx41jQxp69Lt36TBns5DIR4GOnGcsZFdsZFU3mUW2
         2MWoncwLVfKl5LB4RvJ/QvOkIm7kZq0L8t01pzWwtpGwEd0DynSAo6YENHKkX8Op0s9a
         Jy1LgK2q1oD9Yfu5eyfkWeUtqYEOxDJh9EhHmS4WXKfKDyM0T/c6EvuWU8PSgPj2i5Iw
         ieS4Q5Rj8b7kyejxnhmjIbxe1IbJbfNUGXh7owuUdBa71VmIjlKG+oerp88QAXMQ2Qmy
         YyxlrApzHoC83Ba1G8kneubKX77f+U3zKaIMTfRHfNLC8e0aUh35zMoIj1lCnFEjsZnS
         27EA==
X-Forwarded-Encrypted: i=1; AFNElJ8NY/7CmLZb8FO6IfcIawXHHpPa0dukTm4W6VOYqXmViXTZeF9hbwbuF+vvBGiXbLuuhBIW7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqWzPiI5EstNTES1Tsrp+dKVLmttV/54Nt2q0n+UyPb4EA3+eV
	u//7shg9VL5l04ES8tRlv+HIY0s1r2nCG92C3QAbcV7oaVWrd0zBZmSSOd7tu1DygPk25BuTqgN
	Ohh3fkov3GLl4GjtVLodScJ3TwNxMLeqpgmjyAS/li73zDNgfocFAwidl4A==
X-Gm-Gg: Acq92OHHPBXMaDseUfWbmrpZzT6F1gGlhiDxCaCrGzeiWX6YXUqQlf3xT5BZxwB3qNy
	WKWx71nuplpkvij6oehnzzr7u2dSqXBXostuaH26duyjM/LwkkQrajdf1c9C+vg3zT9Q0QT8GRM
	l4Sjt0F9pquGUqGxNJCoerIV8wtW/jJGpY13v8wUmCFKoGQzCEz4GO9DNNFoX9ATzE54wsjNs/B
	hGnIIzNCdlQdhH1L88z/RbDGIIZ4wttYSu9vU6Q84p88nKsc3JQNDbvDOd6Na6GjR8JgjodHaRH
	GNHs3ND0IFM/Ob8YUt9qOJh/kXqip5FsjDQs5JH3rUG2P391oovPc1kSRa6zV/RVP60oJG/YqoM
	KxKWDK1ZDH/8ph6P7/QM1HP5sEmB0uR/az/5IccZQUq+pL1/5vWodorBh
X-Received: by 2002:a05:620a:7113:b0:914:ea37:6f14 with SMTP id af79cd13be357-915a9c7736dmr1233793585a.1.1780912353537;
        Mon, 08 Jun 2026 02:52:33 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:914:ea37:6f14 with SMTP id af79cd13be357-915a9c7736dmr1233791485a.1.1780912353127;
        Mon, 08 Jun 2026 02:52:33 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054efd5dcsm852161266b.39.2026.06.08.02.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:52:32 -0700 (PDT)
Message-ID: <1b5ef5b8-c9f2-4eea-8040-22c1d704b529@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:52:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gwN8aN9sNLVfktCCGPaT8708sf3do5pR
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a2690e2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=thcKRG5PhHeBPCh_FOAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gwN8aN9sNLVfktCCGPaT8708sf3do5pR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MSBTYWx0ZWRfX6WGGU5/ZIBKV
 3BzUg3yrE//mUJ5Kt4F6sODzLRviGtWoHE3MpfwCQm/ksEbAAawm4inS3Zac+FeSZg+Y6404Cx4
 AlEeSwEgJGjRvnXTw5dt/6Aon16nnkgt5CYzN4dzv7U0XVwhg2tDKm440lHtm+93fvKHYQPX2sw
 Dk2RkAI67YI4Or5pxeKyc1O5aKQf2WFc4jAo8247g1gaEw6gKeztSjF33E5jWcTfB2yjWdPi2r5
 HJzJtdEVI/YZ/Lt0isbrJZIe0zUyN1IzbdPIwJXxxu1bw6PgSdZixFfAG/E1U8hSZHG0TgIHxrL
 k+0AptpXzsvVp6hEGOxHm/uZ6tUIdjvQuOLjNAdaQwctFTHsINy2Jxv5gd8h2FfXx79YC6Xcgti
 mzkbyJZg1fA7Cf3hjcaYSNuD2qYgJfSeGDZQ4wlrok2p+DDVLILhya5O5veYGq/jRqbvUNifUVg
 1laF/UxhkwpsPSMtZ0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080091

On 5/26/26 4:42 PM, Bibek Kumar Patro wrote:
> Some SoC implementations require a bandwidth vote on an interconnect
> path before the SMMU register space is accessible. Add the optional
> 'interconnects' property to the binding to allow platform DT nodes
> to describe this path.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -243,6 +243,13 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  interconnects:
> +    maxItems: 1
> +    description:
> +      Interconnect path to the SMMU register space. Required on SoCs
> +      where the SMMU registers are only accessible after a bandwidth
> +      vote has been placed on the interconnect fabric.
> +
>    nvidia,memory-controller:
>      description: |
>        A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
> @@ -602,6 +609,26 @@ allOf:
>          clock-names: false
>          clocks: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - enum:
> +                - qcom,qcs615-smmu-500
> +                - qcom,qcs8300-smmu-500
> +                - qcom,sa8775p-smmu-500
> +                - qcom,sc7280-smmu-500

This is a list of targets that happen to be supported by QLI.. but should
this list not contain _all_ Qualcomm SoCs, or at least a much broader range?

Perhaps

if: properties: compatible: contains: qcom,adreno-smmu

?

Konrad
