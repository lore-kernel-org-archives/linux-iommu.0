Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763F2D97A5
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362754; cv=none; b=u4Pfxr0hjEsamVBhbh3ySNflJCCoQSZYuwjR//L96SbjxYkBIUkRPAo71d24p8OfkWlF9Sf2HhtAQzy1nFkOJrbNJbxt5Pm5QTdMnC9iK6gHoFuwkw8sDiFkvyXDtZN448VcY4ytQ5nXtIMAPpdN5txafcCVxQraYMz2KMsUP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362754; c=relaxed/simple;
	bh=fIAsJm88rdZT+4c/pwiqrmBcXCTPv4zP0IARgBg/i40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p+4PeV2Ay8kjHBS0I1NExFFrdNB8Q5piFe3HK+X4SrDhQAg/m0OHG1OvAnzuivJLMjEo6OaSG+Owsx9hMY5YVY5S0VQV9HkHz8R/nppXOyJu3flchChO0ui7wb4lYMl/Y+chdA2leElgiTY5xwHGfgxuWnIV4A68Oa63TcaM3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gp/t4rNJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCvFhKR/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gp/t4rNJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCvFhKR/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029Wc8T824910
	for <iommu@lists.linux.dev>; Fri, 2 Jan 2026 14:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zcdn/7Q48JsxusxJpdZxfM0eNzXVTYp1I4zI3xtwG7Y=; b=gp/t4rNJTeHYaLXS
	r/aON5l/KJXOfgVUHGel9MdiD77nu3z75PPbsamCbsTKqaYOKHcXsLjxo17ptTEO
	IsTZgkcmPuGgbvOYefHQNctgxKTogYy5wUZnSHm56XwfPiz/KPv2/ykCWQ65iF0C
	Y1JxlTqFreKr0qy4ioVzeOToPkVf0XwAZx/tCigtYgNm96kdI9G2IhcB1dk0kGo7
	CODVjPpFHC99wiClNOUDGGa/ij/PFvp9t2ve5dQW6KUOh+D95MxhtPtErbZNWcjV
	Mp8WTJSOn3l+99fuCBXnZIO5s5RtBABehHAog7yfHgjpxWwtKC3ix8K3WY1xl/o1
	BENKng==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd8533gd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 14:05:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88882c9b4d0so39467846d6.0
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767362752; x=1767967552; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zcdn/7Q48JsxusxJpdZxfM0eNzXVTYp1I4zI3xtwG7Y=;
        b=HCvFhKR/+UbAWaAF1KqFc+BVeH94thxAFbWfqnppOElXF2V5iayrswC8uAG5gp0YII
         gN9ylkjk8kGk6VHGTPGpG4EFCMp+Rre52DcRh0F/v0kCvfKnI8LVeFTpBPNIeq9bmYKj
         6IejsIRCba6yk2ZmbsULXEAuE6kC4zIhS7lMBM2U2+IpUg2j9P5x6vmftAnelDNLNsPy
         Ms8D4keEP2SHz2fWmdoCBxyzo/f4wypjvKZO0GQTROsFoj6vLiB+lpOq1Voc1WqAdknG
         X+9dWdk/IZiN23Z0PPxyTQ0F0XCmMik+LH0diVVww1RGdtbYe8FY6sJTfCrf5g7kSoAg
         /LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767362752; x=1767967552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zcdn/7Q48JsxusxJpdZxfM0eNzXVTYp1I4zI3xtwG7Y=;
        b=Xq++AOk/54m1dnz8igDauu0oFio2+vuMZjP6Hwh4HE5CrGT2vCAkkOn9ogZGpVXqMf
         flWiPgVOFh9H9M72+LUZUrq8x1k4yYQKvJY2zz2MTLQlyqBfJjFeHLmQwWNvWn3/IrmR
         C6IHqlZhnEMRhjB1eCobDBIC2uk4C/GPY7Ov3n1YodrQ23LymoMqTA3LxgGFgAKXVz5Y
         g8jAiRF2JkyXH9KzWGaABde8yegR4sa9qJqq6Bo0DwpG30/gcw7AIms8rLjgu2LXl5mk
         T8WORZzAn8D+ScjalVrgtLdJwHHdy7yteNHq/vdyXbY3llHGgdohz1Fe45wPa6pP3GUG
         9RLw==
X-Forwarded-Encrypted: i=1; AJvYcCU2+AB8/p0AkAYhvnxg1rKerqXRwNGMeAq5lqubpg05pJIzSmKt5+DJyKwO/wMypl/kMYeLog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLtKsBZD8npNgWLj09I5IN/iX59vRmUydPNRzMjl7SmofYGfGr
	y02aX64kjrYVAEqkWLaOyvxIs4bLXTGew77L+H5V4p37u/x2AUm/jw3aEo6dPOYd71U3hy3xeRT
	LrGdyF2YjwZeCbetF78xxiTcFs1LXSNJvMIZ60FlGdJnfybjVdq0qdmfPUQ==
X-Gm-Gg: AY/fxX6QluOV+7xzrudDhKivSOrHu+vR55BNVgB67behRblrUP4KPx/KR/TfqhmaZt2
	/EE6niXM0Vly+qsuioqUAL8bkroV2T9sX/v8+el1ddM/kU0NU2Ehroq9mPq7gTROVUk+FzS+I1+
	6uMyVkorPDgzbptncXE3hGfxJrUD/6IeHfhgZuNc9Wfx44GLfeUxF5co3UpnxfYUK9yhF3m2h1b
	mlBinWIRmpXPNew+9QJwJiM5hQirxEyAeCgdVaUcE8V1+a3N/TVGk61okFWbgeqNlNHSKIPJnGY
	7UBaicTakJkHi4iu7YHNTB5LsvZBAxzGz7DiIQlB7BYhfLr9Rfpk5//FvwtfX0Pmt3jyojlCftb
	oXeroR6rwACGU0gjIRDJRGh1RZo6Rz8Tktt65ECBK6KMFCL3K1z14Mx/QfI68N2uA3g==
X-Received: by 2002:a05:622a:28c:b0:4ee:1fbe:80dd with SMTP id d75a77b69052e-4f4d620461emr392952791cf.5.1767362751610;
        Fri, 02 Jan 2026 06:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvPcr+EyW78LnxZztu6gmFgyoAOWuar2cL8fl5R9dQjwJN8gd7F8C+4SSN+nYk+ChCz+Yvow==
X-Received: by 2002:a05:622a:28c:b0:4ee:1fbe:80dd with SMTP id d75a77b69052e-4f4d620461emr392952151cf.5.1767362751086;
        Fri, 02 Jan 2026 06:05:51 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm4429125666b.57.2026.01.02.06.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 06:05:50 -0800 (PST)
Message-ID: <237b8ced-7d93-4229-b1bf-f6993c25dd5c@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 15:05:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: arm-smmu: Simplify with scoped for each OF child
 loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260102125003.64962-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260102125003.64962-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xn9End79VG3tUAE5VOo-zDYTiDxY210S
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=6957d0c0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9ra_KJl88v3tURVkoeQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: xn9End79VG3tUAE5VOo-zDYTiDxY210S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEyNiBTYWx0ZWRfX0QIlsVPzsldI
 svH+GVQ0psQduqgIbiST6Y7T3KGqtx6LB6Y/MZmhcTzAl7kYBHjQZXpMow1Lh8KMEHfVJhj4IGp
 ecvaipXz/HlgJyG9JJGKHSXZLKZheZZX/cEhlvcP/N6vAllvWM37rdCCNxaIy6Fx3rhwX3R73Mp
 jqRE2LC5eXKhfJvv5yW3pzIkJxXGmO8z8oCBW8sGfA6eNWZAaWlqDnFCSWWK0k4+gO46jo8/U65
 mhc0w6UDwS+mTZjIOSYVsPF4sd+ozRIuaGnD0iOU3QTa9xUXMTAEKuqKFhBsKMG/vH7c/F0gPsQ
 YvYQr/D6JIvmL0lxZlJA5vmWIeoX072tfb8iMPKCMN4O6iaoIy9kV6CY2Ewm+Z160j0YkwDaTir
 q85Gh9DDQI3SCrxZ1L0bW2xlBFvJeBBZhD6T99pQCGWRnoyKpz/jpR/gMA6SylOycsAL/PfOsFu
 naE65P5UQBSRuxfKP+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020126

On 1/2/26 1:50 PM, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
