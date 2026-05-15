Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFA3B2FE4
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851845; cv=none; b=d9mj4VGuKoNFaKKgrOEwEvX4m+mR6nYrt2hOU/QHdkly/1+rwF/60qf/8kpYX/KItlSX6AbX5FH1e6N7sqVcEjCu3i1yWCyj/hmAXyV9E1vpDcMZu4dk4OWFcoRA7Kq+pf5bs+jqGhVqaY+PF3rkhcsiEqCECk2jOx/LFohpK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851845; c=relaxed/simple;
	bh=E3Fh8rz3WYe2ohpm+DHKECMRr4K1QHvJv/ifilJtXGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxkXUWW3XYZsZAK70qAMtZpfvp3OtGk4HUGrZbRuZZNspJ7bq70FUIXaXJMv/wmAmdOzL3eStjqSws8fvCVzjl1x2iRzNorsaHaz0oosBnESkHH9wKeOwOsb0C67TJ+q9I5ohrbgMDRdTqwsU5B2UuD6vZAFip9pepA3V6bK7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ooi9Fdk4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZKZsYiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ooi9Fdk4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZKZsYiL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAsBvC3671196
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bNBPjawQmJSnV08ZoyTHF4GbC57zg7+EEAvYbW1jGOA=; b=ooi9Fdk4FtLbsM4X
	cKhHYk3K18NMUCkkpPFmubAdUK2LhChC8Roo+7ztd4me2ZUswHCenloPVM/Nu6pm
	cv9HTdq023eJiZggnPF0UVJvzL5DntK6DjmzGWtLb1JGEAV6wVkkYZS+ZttyGDqe
	dljQ708hOUjAyf9CIH0i7QSRbKy4QdMLtBs1oATVM0z01x4ioyD9wADN85jMhAlw
	sTI8cV7TFFJWLOccQy4xSqrVXbczdPw3YJ+pu/UWDh8E0MEd0VmMliplqy5l9qZ6
	DyYRswoq7Uaigj5gMCNwmMBrl0EzKObIESEQyXRecjGFY/hoXeKnnB5TdhWWMYp5
	c0x8Mg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3fmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:30:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so11095225ad.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778851842; x=1779456642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNBPjawQmJSnV08ZoyTHF4GbC57zg7+EEAvYbW1jGOA=;
        b=aZKZsYiLMc6tAeVT9CUnylEk2EFr4o/kZucXnyzGZaxnsJVFLAv+ZDmUfmhqXlYQXj
         66QyHmBtGRL8CJP6mNJieI7GmaoRiA3c0R1cuJ5talhEP93h5ClmX5jlICeG4WtSAg4M
         c+13jnQLvGTo6w12fVuV0WxwtusmwtrnCrbwHpMmDX6+M3/ww+JEQFM1WyDVNEFog8j4
         faPmbs51cnYowqig4TzOmGhO+Zt7FwH95AYv3W+/VQJGbi6JdVGwqaF0qjXAlYHUw62P
         Y34F5CQOEfjDD1vN+C0ajwku5/KnJkUpoaUGtmr403sawWVwOcf/+7P7VC8Y1TFEdn4P
         7bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851842; x=1779456642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNBPjawQmJSnV08ZoyTHF4GbC57zg7+EEAvYbW1jGOA=;
        b=fYu2xpt4YFrd3CUZrn3UIKhtKkfPv1ziBx617odLr6SbHtCY6W6D2NkoNf4n8oEtAn
         dgJjn6w6521IxHqUwb7/l+/ajdsTkdwOKdw9Qk44KXokLOqubsilWmJUr3p3qp+Tm2ZT
         HjMrgEfRbI90dTzET06TD0Lsc8Kuo8mTxMVRcJFoZ5huTT4tN4swSgJcznfT/mG2Q/ma
         owie4f6iiKXOAWwQmPOynEUEpxHG6GKBd2tRjQhFaJ8vGJ71Bhl+LhU6xvPciLpADj69
         fWJZX7IYoZvux2O9GBQ/TSDdhwosqku9KbSlivafsakjSILfdNyHBDj3kmpteJITRSWe
         Cb/A==
X-Forwarded-Encrypted: i=1; AFNElJ9D6y77/Z3dARDKoRdpElQkaL1CVLVtr9yR+9FP6hojzYu964Lx1NICYxtVfrVtrhsGzzDp+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YylcxlQe+AKXYfInVtLYJxrZTXji1Qxg7dEpyBIKurpzYJz9+kq
	PCFMAqhaVyNB5LVSFpzZ08V71BOdW20kMSrcgfklfYIPSuZLGCo2CF2DDGzO7F7ZbUVUdr2qke6
	S8LykqtMwra1ydU4WmK3TfOI+guVN4uWGCbSzSgqDyMs7OwF/Jw7VudGSOg==
X-Gm-Gg: Acq92OGEJ/5w3QydnzrLhah+l3T5qiG65NC5EOCT1lAAnSPpCIfoTs1iNU3NyiXgaz2
	sVqKSlnMcmTAO0YAaKIYIrsE0qEhfTYo9Xl9BTJXNyZUT7L2hBbkvrhtm/atOEK3VlDVz3zMVtd
	DBnAql5KHj3e3U9kalSvM/8FfEVwe8DXcH52Vpsf+KQDPVkNt2a6EYzrxo5/O+9ObJWCXhijeC3
	xE4F4F5hrfxVv52wFMklvHO8XMkzCkr3YaPO1f4CZmQuLX0VP+5AZd09geS5mBwjfnEEb9uAOX2
	okAzxTmh3J6CP9JGgUX0u9e7XrfOOrJyGLC55/XMJutFCdJiyWUTHwjMrfNgZSVuwOs6lKlT6+n
	deFE2tRip0T/nEP0u3Q4J0wbSRJM8xU9GmL79PPNLk6dvb2ySABk4EPilk/omRtwBA3pm8Gfokh
	RDKA==
X-Received: by 2002:a17:902:f78a:b0:2bc:cf06:221c with SMTP id d9443c01a7336-2bd527d773dmr69792285ad.21.1778851841896;
        Fri, 15 May 2026 06:30:41 -0700 (PDT)
X-Received: by 2002:a17:902:f78a:b0:2bc:cf06:221c with SMTP id d9443c01a7336-2bd527d773dmr69791705ad.21.1778851841358;
        Fri, 15 May 2026 06:30:41 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.84.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm63057275ad.46.2026.05.15.06.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:30:40 -0700 (PDT)
Message-ID: <b8f02a31-b175-4dc2-9b2a-5765774b4d88@oss.qualcomm.com>
Date: Fri, 15 May 2026 19:00:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for IPQ9650
 SoC
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNiBTYWx0ZWRfXx/K8bz+89PUk
 XobmVHCILGe96DyolL++uUWdX4p1MZBvM2oIyImpusB9zoMUmVCWK/hpfQXhAWGwvQa82gDh+a5
 9qT62k5kevIN0a3x1OxXCqdQ77H1UWpgcMUqxTT4zdjV/BkKs664IaL7XbWWkQD93YM2HgXLJQb
 fTwoXVfkuazfb34s4/Lh+IAr+D0FDSp2nVf1dVNpZq9n6UfRcEj+cP46wdTMh85jU2vHCI1149L
 QRNPqMyG/+jwDPnL0XcoixFXh9avRcUpzfDoaRk3tQ7KV5dXoXtLLWH8zVKoyhl0IzxxYZ6WThL
 i3tmyf5heo2S0XJxsQJU3fj2TaG6MqpLmi5reSYfeRB42eM8evw64DVFkGW9wJ4sdAEvRDJEayf
 pMAHPgr8Kh7FhlDhYvpoebWtM+Zmi9gAGlR7kYk1oajFSewFcWNZ2xuJKr1ZEAz0JIbKgjEdG9l
 JxRtIDi0pg1/1J1I90g==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a072002 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pcck7Iv2+kD8UxzcD71x3w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dvW0RAlsEONp_D_cdWEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: SEC4DPZF-AtsfKTRHL7zU98Nq3S9gLm_
X-Proofpoint-ORIG-GUID: SEC4DPZF-AtsfKTRHL7zU98Nq3S9gLm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150136


On 5/12/2026 12:17 PM, Kathiravan Thirumoorthy wrote:
> Qualcomm IPQ9650 SoC include APPS SMMU that implements arm,mmu-500.
> Document the compatible for the same.

Kindly ignore this patch. I will repost along with DTSI changes once it 
is validated again!

>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 06fb5c8e7547..226f16711d67 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -37,6 +37,7 @@ properties:
>             - enum:
>                 - qcom,eliza-smmu-500
>                 - qcom,glymur-smmu-500
> +              - qcom,ipq9650-smmu-500
>                 - qcom,kaanapali-smmu-500
>                 - qcom,milos-smmu-500
>                 - qcom,qcm2290-smmu-500
>
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260512-ipq9650_smmu_binding-36dc05d39860
>
> Best regards,
> --
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>
