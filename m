Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B93246EF
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848655; cv=none; b=j88cCJb/LPAyhMBs6oQkcXYgcOKYb0Ut3fgrpvIO2aCQGvFUPeEtCH1QEPN1gDF8tCwb75zLKjSm2CX3Lpp2ux4owxvSMF4BCHidaTqfBW7/H5DTr2/6+oBT4LeT6h1J9hARIuDatqFVR2fmZjS05xzUT/1hXRjfa2k5iTm6Skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848655; c=relaxed/simple;
	bh=TyuMwHsGMQ61izjJT4N8Bomm5AkojJJNkeC/J++cLWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzMQxCnHBV5i+bP7sZnppWfy65GfD1MykLL5xfeNgc4mD9HxMcvztdWId+XJ/D/ABP+o4P7t2LGDUBlxlIq4X29T0eZMeFTI/njDd/Rgwur0tjLc5Gnov2SO8Nl0rTIeqr4tKGbCF/JC3LIQklMVKmHBzu2M+14fUFussCjXeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDEeVsTv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GSYKk2ZA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDEeVsTv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GSYKk2ZA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5UdS22123716
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ojiNe/sUH8AIzdn2yfm7m/6P4u6aT2i8yfd4xnqSSp4=; b=LDEeVsTvfv+iQxEM
	h7VOAtEmTX0tE+FyiWP+2I2Osj25myx/JBURa4lzBA/73W/Thl/1AqBqaxF1xgzp
	aAYzcaVbA0ZOXxMMFrrsFh017Mibgzh0ENT9eAR2thRi81uRfg7rKlVE3kROSTST
	aYoet+Jf69X+/VYobKEKe7RYFrBLf3AnOvSxfpq2Q6s4WaIevGXlY1iW1dc4ZLwj
	a5Aa+evdVVRXOltSpY9jWwFWJJuDjwHmimp6xLT1L7A2pyiYmnRnTJaUF+GHjmMC
	MMhiDAS1fcRAsDM/W32w2Gcib1kgbK6NK0BcVvCIfTvPZtClEYQJG12MEvuEPEoQ
	VD89nQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenftksp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:04:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d8e8c47a3so138306741cf.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776848653; x=1777453453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ojiNe/sUH8AIzdn2yfm7m/6P4u6aT2i8yfd4xnqSSp4=;
        b=GSYKk2ZAfVRUxOpFo3ebd32b73oMxfjTHyBI3bYq/8p6XGsU8gXT8fjLtEw83tYvBJ
         kq8pYKTeLBLlGYddZfbm6xfYlRXu4I/LI7HHpjLqaM60dVWOpiGJlhKwO6HaSkT1uoLY
         BaDiBg2lQrh56HzzY6GLeORA/NLQ4IjbVo2ieIlJbnlFZX/q8Bvy4rb6n1LAedsiCxxT
         WWIrNO037EPlEVuuKVuuhYz/ZvKmV8UnqOAJNU6MtRX9gyJb6RAqHMpAHgOM7R4aPF+b
         X6+OENJX8YdbsBoylJ/1EtXGvyajhwL+m4cUp8NG/sk1TtzAjpJTUPG1gEUpsDUa1OGN
         CSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848653; x=1777453453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojiNe/sUH8AIzdn2yfm7m/6P4u6aT2i8yfd4xnqSSp4=;
        b=TUUnm3jueZmm//wpHm3lmcWPzzuojGhyMDWmD/bx9CsUTsEvpRxobBZXisV6rOynSG
         yzbEWZrUZaaBr8x4P43Z03pn4bqJCglUyMrZGtrSlO6ujLikRt/dTgIiSJbc9ovjqtB1
         nle4aICrjEFXq+koRav4vbTEzdGaVT4JoumcuHV01jDi7aae3rWKMY1YQFYpPZ3PdIpt
         aHAPLj/PqOFmV1Mqgb0znQ8ExG7u1Q/yom3QSVKpodS3pw1tw5EmCjsJQGN74M9RPXu5
         H+j0nIW+ix8qz47d+gihto0YXJT+uBfvWkyk5yUzQNIClHkvnIY3YJdvvH1XaoDAa7IR
         18FQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qxpj33Ah34ZtfytHMYONQ5OrED5p/207zcf9JFS+LwaZO9OsuJYuvzQvjbDByd8ONA9vOgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFZ7N9MIUemMTDZvm5ZYPkmItozq2wSrC3EU947yZww08j3mdE
	I2/c4Nl5K+Bz/1GiCzZWEKWcKSC7Cl46u4sr7Oei37Uu7cbWsCAjwdfRZSI1U/cFM3vkgSG8Nf3
	adZNiFS4irpPvDKJwsIu9QGYxDRV3m2x4nbdK7qc1QYt1PRQ2WUOpIGqpbw==
X-Gm-Gg: AeBDiesjMYlihczpJP9PIZHjP7g1Qqa8xmeQqVpLCkmXDlkB1QUeHr6DklRC1bsD0uq
	40O1zO2nR99S8+0Wa12N4HHiCPtKD7b1LvUeoxJq7/wUXemYT2GE5zzqAqeTOuum5qD3yCuuKod
	uw/BrXf7+tOHKLnZN0w0325GHZuj6NPMnfKm4pU8hVqv0BAcpaDWqpGvZZtT6ebx55TDHPbOI1p
	rr0atYy96tmb7lo20yMmUyGGAFXu4HPIk3hj23VC85QckdbF59DVEnf0Ck+MAp6EBcxMHDDw+rs
	/Gg+scixptXpAfrlHpGalnh4GLYNVZKhJhi47wIboRBIJC2dD4oqZg7IuoGnA6ygSpz3QmP3E0g
	POF8QIuUa/h0YtoGJBuvsi5VAWFK30HrOHKH3JNYdCIT/u3gLi9jWRNy94zw=
X-Received: by 2002:a05:622a:a78a:b0:50e:5e6a:c7da with SMTP id d75a77b69052e-50e5e6ace5emr136272041cf.40.1776848652945;
        Wed, 22 Apr 2026 02:04:12 -0700 (PDT)
X-Received: by 2002:a05:622a:a78a:b0:50e:5e6a:c7da with SMTP id d75a77b69052e-50e5e6ace5emr136271691cf.40.1776848652516;
        Wed, 22 Apr 2026 02:04:12 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0b60sm127441835e9.17.2026.04.22.02.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 02:04:11 -0700 (PDT)
Message-ID: <d1d24380-06e8-4833-b893-631c063d77ff@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 11:04:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom:: Fix Hawi compatible
 placement
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Will Deacon
 <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e88f0d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aOUUj6KyvhU4KahQZmAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: M0y5hk6xlaFZAuRFLXgT5l7U78RY7CII
X-Proofpoint-GUID: M0y5hk6xlaFZAuRFLXgT5l7U78RY7CII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MyBTYWx0ZWRfX0MEa2ZxBpIU4
 J09j5rjIjddpf/1trTYmvn/xjk6RPIciEwyuXAMFmzWfUe0nQMZR0WVO40puM4QWlLzYuaFvov2
 NpbRGolnMjkAsmsM71N+CKt1BdvcroOWdJLlum5FWwyzrYmnGL78c1mdw7L2GFkiofLuwS2KJDv
 5EdwECJIwKfHy/hc53RwPEn6xsRffD9w8myETp8x3z3Rb/hxmJ3UnargjpVl14f4S/cHC1IzBk6
 DIDBkejMUV0yxJXCha5U3eiZ8oI4DmStyomRZM9e17QOc95HSbI3oGXMw1YhmVxCXEBZELxY2HU
 LmE+4xNyWQwGNcSKeoT+i+H2CPBkdFhTtuCSB1w6GxjRoQOkqmGWugfHZlgFXOvYtw5sye6xDRS
 KLisvOKwe9uswvroY39OdXnGAAxauwA6Z9IK68tC8MX2RxfoOvRYdPtbf1kW98VqFrkGwEWmGlK
 z4NBHVArNFR+uKZYnRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220083

On 22/04/2026 10:33, Mukesh Ojha wrote:
> qcom,hawi-smmu-500 was placed in the wrong enum block of GPU. Move it to
> the correct location alongside other Qualcomm SMMU-500 compatibles for
> CPU.

How could it pass dtbs_check?

> 
> Fixes: 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC")
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 06fb5c8e7547..ba9ad1f5a8ff 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -37,6 +37,7 @@ properties:
>            - enum:
>                - qcom,eliza-smmu-500
>                - qcom,glymur-smmu-500
> +              - qcom,hawi-smmu-500
>                - qcom,kaanapali-smmu-500
>                - qcom,milos-smmu-500
>                - qcom,qcm2290-smmu-500
> @@ -93,7 +94,6 @@ properties:
>          items:
>            - enum:
>                - qcom,glymur-smmu-500
> -              - qcom,hawi-smmu-500

No, why? That's for GPU. Why are you moving GPU compatible to non-GPU place?



Best regards,
Krzysztof
