Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312332D7DD5
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767784098; cv=none; b=CohQnzohsDyKccedwZ8W2FAZJOsbFz8y/whg1yFHLgvmoo8eajku76A+cXQC2ylM8CvQ4nh/+tR9h4eQsRKaVnXyo1KWFCARVjD9EefyB36hGi1K/nDnUQz3ZYCjyd8ubNWeqoNjwSat2gpqeFtdVyXNiuBLR4VOHP/E/Xvn3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767784098; c=relaxed/simple;
	bh=iVKmSVIlqJhLg/96JFbuRFrTkgycKVMD430SBMjnBlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsKH4wKl82s2okLP5LY+UUZWK1p0Ncgne27V3FQFDCsgdPd1vl0pPfRvYjZP/S5eNBec0AoWQDJIKUNxUGD8qe1Dxsu6Eq/71K4j8p+hUI/SNZlEOrHmYEQax5x4EMxUXD050pdQ/IPZEtmRAfJcmkhaMMyEw7q0Kk3v4gEWIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RXgcUjUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+KJ+lmB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RXgcUjUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+KJ+lmB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079CHNe2453884
	for <iommu@lists.linux.dev>; Wed, 7 Jan 2026 11:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L+opzUlGSXD3UzcHpbB74BmmUMnhmlD9pdcmRCk/Ck8=; b=RXgcUjUWVZ6zkz4O
	bSMmnh5Jl7xBuqNGECrg5L2CwrCvCI5EqSetxvsJzmsqDbL6/fEJlovj0omhAQNy
	CaSrmTPrK9Ac3h0FWUBZQieENlU3t4S2/OMEGtqt5sOuekl5Jpng1adLeXcYYvj3
	mbal9yLQF0boo+FoBskaryUk/pgwXtWBsQ6BdA2ub2uT6WanFCdqABYz6eT3ePlk
	deuQmC/wcDOspOyL2ao5S/SFgygTdAqV3l+ztbZ/eMvJY+UJDd8qXQXftzLHR5VQ
	AK4D7Y942vvXMdrYpU/PO/w70dhf8O6y2as+bX+c1L0gP9/vqlI4a87ZkU3fsgrZ
	xSysGg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhmnbgbnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 11:08:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aa5e7452bcso527512b3a.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767784095; x=1768388895; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+opzUlGSXD3UzcHpbB74BmmUMnhmlD9pdcmRCk/Ck8=;
        b=M+KJ+lmBlESkXu+Ic63PwMZsscf5NlV1kcnumxRCJ4P81PmzJCnEqLZk9mB67gvZFj
         eQ5Ko/WlGLDDlREQVhKXpgCwwvxmlPOvO57icmEiihec3PW8eBf9rAQ4lXMBseIE+KYs
         LyuHP9bAxNP/6U3G5q45i5cLKHKxOvwDut3M7EfGG2YSHkLKj+5HKFhTFjEVVA6fXSQi
         TaNjg+RUFa6+/NHszDlngsPj1RexUQWilAPKGheQMm0aOKrbfdeL5SMbqUS+OcOR3ldJ
         lscI5xbkyXT1wSgspq+ynl8M6ZGOOEA23l2kl5NKVll+MIi4jUpKd5JIWqJjtvdxMFjn
         hnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767784095; x=1768388895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+opzUlGSXD3UzcHpbB74BmmUMnhmlD9pdcmRCk/Ck8=;
        b=ktbZIQ9wjLQTYJp8BrEvlkWjWGyZ251NlFwM2xDz4VDGyIB0VVLZdCBIp80wAsb+RK
         qSu45SUYLqdt4FwwnCOonR4opLAwSYqoJWIEdnXM0y60queAUL26kxo31PSi7AU96RaM
         K/KpRmwdT19c0yATQpqfwIMSe5l6ZGuIIZdOb1eMH/wsX4vpMlCSvNQV8W4qzpGPA7LV
         ZBIdCiy1wHu1y6653cQhSivYmWf5t54tFcbIVytY0X0JpDPKH4D7vfQROUTHat2eyosE
         tjfYsbuU+BQGpv/xzsY0puNEbPjLOmfq8IBA1/ioNRdvm7MUXvq2ziVO3u+wQa7wfao7
         YdLQ==
X-Gm-Message-State: AOJu0YxKznS5gASIRXF/W3DLKbkYplVqT3XzqW/AwdbFCfPVgkMolNHt
	1liFNnjZaCbkZQUuoVxnvry6u31/LDIA6nNVUohJ8qnnA0Ej9gmihz8pw2l2Jk2tYg4s4u6i5li
	qtRX8PiRyVYYRXrg0w7Gxi0r72V4+Ku6AXxSTRDXSa/Cw7BY9IpSdPuETLRs66SdzzQ==
X-Gm-Gg: AY/fxX4lGTeLgQNeRO/MzQioDUlOPZTI+Rfkg2gAfsBzDz19E9WjGmuFbtl4MWNeS2E
	Ap+O8u42fi06Xcld9qeXtiScxgVsqgLhvWSyM/Qn2kNeiu34/NuVqA8HI0XGFLMigezYPKr5n0y
	/IGRV21k9nNqoUP5BPGBJVf3xc1mgBjkpQPHrfKeFxipDXey8qHGikaJVup+g0WdbpGYJUxhKIl
	fEWzKl4x4gQIHGnS2kwei1DylnB/3hwJMLW8V3wZABt+F9inHQKgRIVjsvYiYANba/h8+JXnXxe
	cAObbWf6tFAq6pKaHTuoLqzywZlFqGy1G4VJgdXQrhvmZDtGcztE0Zy8c6s9SkMEhU0ZInSqcJW
	84V1tGMbmCde/tP5yiwnlubG0VibEHlYjN2mqtHJ87oYKCfvEMEFvnt8gU5cYANTzouw=
X-Received: by 2002:a05:6a00:3e15:b0:7b0:3fe9:ff with SMTP id d2e1a72fcca58-81b80cba388mr1473681b3a.6.1767784095316;
        Wed, 07 Jan 2026 03:08:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwyphEbBnzatrOi1FkcXJkZhoDsihfa66ESQZFjVnysDdHMYl/GgxlvU1emeciPsYpJSWzPQ==
X-Received: by 2002:a05:622a:110c:b0:4f4:b372:db38 with SMTP id d75a77b69052e-4ffb49228d5mr19554121cf.5.1767783634652;
        Wed, 07 Jan 2026 03:00:34 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm482706766b.9.2026.01.07.03.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 03:00:34 -0800 (PST)
Message-ID: <ec91c169-ac9c-4f44-a3a7-b6fefbf2be96@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 12:00:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] of: Respect #{iommu,msi}-cells in maps
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com>
 <20251231114257.2382820-4-vijayanand.jitta@oss.qualcomm.com>
 <fde70548-61fe-41f3-9bdf-37ceda603e02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fde70548-61fe-41f3-9bdf-37ceda603e02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA5MCBTYWx0ZWRfX4Mb2lPSyY0CP
 8CHHinPYQv8e3F8On7S70jjh75S8R9ROo1Vc20/tIwwCVWC5HZNQREYb0tWe0SDMzzDoDIPA/dz
 N8/AnUWaIr35L8DRH1X/PSkbASYj/biEpCF4DeJnJV8V92mHY6TpFpNPhO72QhL9Q9BLcr1ciGq
 ALXD0q353WaW7q3alIA4Y27Yq8mgBpWmhYy8eQP5b2TPCKgXq6jirs2pbGDnXM9okFA3qdP/f06
 LNFrF0pGxJ5u5j3ynMarHwQ0Ffn6E+TNV+5+SVNO+O7P7mcsAe1XwVy6AdBQrxEbidPLnGJ2NgG
 aHeXHN0znfkOeX2l81UJ8AMvhimHFeRHgnQWt8XGTQ1KBUjUxGQUrar229/C10ZrAZ3KogF3Cap
 joICpYcmZq4grZ0KH9+uGj5ovlSBhxZW0hZB20tlFZezHMa0lmY9NkwvMcbAYYR6iVvBwo+EJRn
 WooAOdQz3n0WZm739rQ==
X-Proofpoint-GUID: 8hemJPa6Tfqd8K4WX1px83Cw4ipOWMql
X-Authority-Analysis: v=2.4 cv=eIkeTXp1 c=1 sm=1 tr=0 ts=695e3ea0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=zmrd7r8un3QtD10oEDQA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 8hemJPa6Tfqd8K4WX1px83Cw4ipOWMql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070090

On 1/7/26 6:31 AM, Vijayanand Jitta wrote:
> 
> 
> On 12/31/2025 5:12 PM, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properites has always blindly
>> asusmed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use in being able to map at least single
>> input IDs to multi-cell output specifiers (and properly support 0-cell
>> outputs as well), add support for properly parsing and using the target
>> nodes' #cells values, albeit with the unfortunate complication of still
>> having to work around expectations of the old behaviour too.
>>
>> Since there are multi-cell output specifiers, the callers of of_map_id()
>> may need to get the exact cell output value for further processing.
>> Added support for that part --charan
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---

[...]

> Rob, 
> 
> Gentle ping, could you please let me know if the latest patchset looks good enough
> to be considered for the next merge window?

You have an outstanding build warning:

<202601062128.BCmw1wNO-lkp@intel.com>

Konrad
