Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9053624C3
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926516; cv=none; b=ornuYQYLUO0rxq4cwwOEqs1oPg9n9kSE5/3uyPZHLxUv2RdnGwBXa6aLG/KPv6mg6kexNb5ez5kyVE1Hj3NUITBR2IaG5/I3PM2Th02CC8QmTiAgeLoccLMpFhnI7TKRgjp/C/yH2R40YmESFploK+L1Z2hak9dReNOz/nJJAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926516; c=relaxed/simple;
	bh=PZ4B3OBIBssvfzWxhVQD2t650FvBAlhF+2EGFB6vkDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiMZlUG6e5U0PM/vak9NQaAyD+izFx3Kq+FbrDJAnfYTzCHhmqiaVF/5HDuca88ugZc/KbPkYbfr3kRy0waEDsiSLFPM+UEHgRVGKj0o3ePjrMwbXx31C5gbrzi03GqeRAvZTviazhLc38pF7SYy7Z6r4INb/PIRMb6YpDg9lEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TpUEp5hF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIWNTOAm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TpUEp5hF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIWNTOAm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRHYM3271864
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gZMjcfL56nfEqXpkbtHqbJ4I
	XYaeM4YQuE8a5EedgTw=; b=TpUEp5hF4OSr2snKAVhZ3CwqrUqUi1H+2q5h0/ku
	QUktKmkVWdMq5/iXyGRRgBAJbDKI0cKuY1MQ/ZKjdzpHcyvO6TFdbqhWhxI1/GxW
	qPbzg7uDMuPIHIcnN3o++rsPeS31eFrB+e3vk60HLVbIBeGzVI0or8tXmE90Vdn8
	U9sEOPXSrw4WZoqoRYZoSlcpif8sQeSyk2uLMQot82LMjulxribpFT3Wo1fjT9uE
	YdkmAyw0R6dwe1ZaHtaxvhNdv02A/0dxFwCIhTBsZDVTQ4KGuQrmfGgB1hz+Edng
	sUK/zzkBBdxKMIzLjwbYlzY56pQe1md3KZ6W+mMnCsHkmw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrks89y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:48:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c33d75153dso1698300137.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926513; x=1781531313; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZMjcfL56nfEqXpkbtHqbJ4IXYaeM4YQuE8a5EedgTw=;
        b=GIWNTOAmmb5bCXSlj0A2XWZ2q2QaJ553wy4dpe/aoecqOtvfzF8U21JidXFWLdRARp
         +o4RgsNQhf2PzRQy2IYeH7wix6tUmBniTH+Ok6+p6MIHzBsKK72i6j21NzJBaxaYfu26
         pBCQwJ1OVfSeasFYPPz2CIMawveze12hFmaO8kT9aJ9czmFQ0Lvyk/dypqivjVHNnmwx
         BOea9gBALX+qKuequu3VoIt1D+eKhmIwV72kI/N3M1NhR7efNwPZS4mqzMdcQLbCV8ik
         OEdPMFo530RfJbsl8k3Rfy1lzzUXisl7YXLjuW3dGN8uA4pD7Snrw4Tbklp8aN/nBC/d
         1jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926513; x=1781531313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZMjcfL56nfEqXpkbtHqbJ4IXYaeM4YQuE8a5EedgTw=;
        b=jAqYgHKgwNNfkGB66nq4xAwZ+toN+drxjX216v/wq8E73Jwh8Bk4QVvmJImJeqzrAH
         vbjTPgjPrEXkNf6QYYzz3u6aUtcaZN28sovVuwN9s1uKmsE6JtWv34sg9sRkJydoh7a5
         oUDtHSme26hGaDEMR6M476dipulxm8UmvOKaq5+sIKqLRdd3XUMqGAV59B+O1ietNxFI
         3KaRs+VVA0lB6qNrbRcFQZUS2wuXeNzwI/0O7jxgcqmb86Yppr8dFLknIjxZMNCpPIf4
         gNCOfGSIga+luSqqsB1CsuryEcTd3EgEdfMFqi5Y+I0XykOehWc23Jpm04O1axDKJVIM
         aeFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wwmZqr45EXvUmTANGkaX3EhQ1SL8PTzeiWPBk+157QMIdXqvyIahIZUgKxw7SK0z+WrgqbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6kipZqxzr6c0kNOnxVwdmE8/sjfwAADi7/HSDJFI1hhMnH38J
	urz/Io4RxWT2Wp92L9h3DbhYBl3pLCh5kpuadE/MP34yVgoipcmi639ohQNpauP3Ujb4CLg+dPY
	vBVcaREmniX8/lGYT8vfK+IENMbdmiIRw1ScxqfzBJrovgn44CgoxKf8Ilg==
X-Gm-Gg: Acq92OFQXyIEfsZwwT+fTT7vZ09rOFy9AnaMnALAJfFAfQXbYEpbPq5oG4Z1f6hco9x
	BdvzexkZ08xyoLYVp9iFqS1v0ut603wyn/ZSIwvOyzX/nZruZfiadV2jQRP8QR+L7VLNo8sVFFv
	tr//RBImnXEckWjG1Ka3fZ1dbiVXSmfYclDsHR/0H8ZuUpQPy1uSXIzYuCdS5n6zdzggVwCbMDY
	TJHGDlt2UBIAyf0VpgLTPi81bOxLYqBE8saVF66OUCR+dzVyhn2jDw3oQXaOmzt0Cdk9IZlORqq
	woD7IHDP2omX6663S39cLlRmbppHei1qBuJkfp/43++EiaNhjC/zpVE15Szu7y7c/6hXHOJyXY6
	TCRhRIEYAO+zswAL93948vWqg5Kgcs1GkNGPMs06vCBjA0njmncvErgG+AS3AHzRz1DK7PmBKJj
	o/sbtD5fZIiedNwgkSKeMlEo4Vv6bZAkXWoYVOQ8aU2rFZZQ==
X-Received: by 2002:a05:6102:808f:b0:636:46ee:2f0b with SMTP id ada2fe7eead31-6fef26cd8b4mr7121146137.12.1780926513417;
        Mon, 08 Jun 2026 06:48:33 -0700 (PDT)
X-Received: by 2002:a05:6102:808f:b0:636:46ee:2f0b with SMTP id ada2fe7eead31-6fef26cd8b4mr7121083137.12.1780926512933;
        Mon, 08 Jun 2026 06:48:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed77esm3885124e87.17.2026.06.08.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:48:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:48:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <naa4rebf2mpn2uybjgmaidtni5fckbc66t2fx3tv3cfklfsnb5@op3qmkovxz7o>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SmHnRHJXn7e8xKMLz7_qOYAnCIX7PP-8
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26c832 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3fmthTPW8Nr5gDDPHxsA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: SmHnRHJXn7e8xKMLz7_qOYAnCIX7PP-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMSBTYWx0ZWRfXz39+uEBmVLlI
 Z3KpG3FTIz782mr0CtjA4NsuzT/iXRJbrq1XaLtR8LLiK8zwrFm3qjgfacNfq4rCbgyRRyQmWdX
 PeYiyr41GY20CDUk1/UHMHX4rbJDPQ3jn6BIWRhQWzTVXNp/SZRqQdW0QfCvkWX1GOgCE+yvgZc
 H0VB6uwFsC25dF+jToJOP28+tV7DXcXPsSupBrHL8E6V23m/KMlWhO7B/5Z3d+CAzWP91xaENOe
 qIpcfQUOu2gpvQbwrblhgi40yccA51oLJwvJKAmo9nt5bSm9EyK6YyQ8sN1Fz+ukdKatk9FJpk7
 2ezlC0O88UtOOuEzh0ZdowEPmXQ6Y3uvShly6HlIIctGJfOhJt2t5zPDwAwQqBfUwqJciUKivoZ
 +zpWA2BDfxWAI9t49XMZVBp9XNn2xcqPOJBr0SSBeoxnMprHrHdeCctVjoPiiXA/kOjbq9IKKQX
 2uUVwygvjvVxbnHmRkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080131

On Tue, May 26, 2026 at 08:12:02PM +0530, Bibek Kumar Patro wrote:
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

Only these platforms have the interconnect which needs to be voted
upon?

> +            - const: qcom,adreno-smmu
> +            - const: qcom,smmu-500
> +            - const: arm,mmu-500
> +    then:
> +      properties:
> +        interconnects:
> +          maxItems: 1
> +    else:
> +      properties:
> +        interconnects: false
> +
>    - if:
>        properties:
>          compatible:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
