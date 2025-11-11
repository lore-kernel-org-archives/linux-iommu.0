Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077229BDAC
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886734; cv=none; b=KNZ8lrBRHRlC7B71viJmZ04f75UV6p9sgNc2tpWK6D3CpUB6CskqdsUMYqu5nXk9HqW8ekEYrxMJJjFvyZuDeQD6TReD1KczmleEplwgrCmlm/zoka5qOYXXGGKsnvf+RLEYYsVn71zoJdoW8jHBW+O0lujMEUjnwmmXddljmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886734; c=relaxed/simple;
	bh=m8HjbcXk11mq43CaUrlq93qQaoVQl7sLhwGwxLXplWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TV/ynq7C1ekT6+MmA6Fm0HDwy3Cwq2HE7zH5Pm59tUBnPHpJe+knE2f0bBW6tsPkXjdzp0DuLv60NnbwjpUfcgZqbS2JbSmjP3vEagvF0/9TJh5oxcUsEjkEGDjDrl360U4jIgCgSoQWpvJuArqOWV794NhI4gMMrgzW5N2deNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLbP5CED; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ft4aSuKA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLbP5CED";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ft4aSuKA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGPSv2027695
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 18:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=; b=cLbP5CEDVgM+zFrH
	cmt5HM3VJ2rL7/LLIMTq16a7sd1+NDO+WMSp0Ny7AODJ/zbQcQWGfHSGH0LC45mM
	yQbYI8RCOQK85wMazVwoVdiu0otFp15A9CNsnzoZG1x9tGJldkuM3VV02LWnpBuH
	knjKUhIjkmNkisGGjBpBFhpzK2Sr195QN5PhHplp9J76T04uNdfvzsGW9AXBh6AH
	8i8h1++HnijD/2HTCFE+xY/FFsd/i2tEa5I5RkPNNCjm7xPNDBGtIAoEt2aYxC54
	f0oYuP2B9PAzOp9zwBWB1rO2uUKHFG2tkRk6iJfUxnaH3Plkv+DKgbNaaCtITbE7
	sZMwEA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxqw2bnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 18:45:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295915934bfso433475ad.0
        for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762886731; x=1763491531; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=;
        b=ft4aSuKARTqCoaBaHApPTo51Lu+8Z9hwGSVVQO0Eoao+jfI1IThNWsLChnNYGACTa6
         mqi7oZ9bHdhSdbAGXZkABXDdTOocl4xqzoCC5ecjY3j8c2CsV9K2AHifgGDjXrH0muTy
         pttAefEh+CsqjMesvEUXg/0a0PHu31n4it/HDZmuvvFBuxMW07umu3w/sUVLgUxDVJ6a
         htUpablQv+Qm+qcWn2vep6GELEErk1qJ6aFO719QuN4fJHixOmkDUKr+Jj2YVyaCnwqj
         uiuNuCtv00F9TSsoxbPHmwclBznD2ITqhlCLgto9z9jD+Axe9xQQCE6VylKTWnK2Slhd
         62qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886731; x=1763491531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=;
        b=kEcGKj+FdUEvATnBAa2L1LXBq+nL7DyLk5JiLyhVUicwCuahKnbe1Cy45HkUd1kRhX
         LUgAPSIjdmcaditnuvfKd9CNwtyU2PEHE6wyz7lAsOkUYiMGy9K3RjnYBpSMoymQGXi6
         zM1tzK61A9uVTP/e5/6nE9rQDZY7pbMeuTOGaCwtnTkOptCf9/aSU8P50fgsT4p9jbNQ
         FBozjah6i2heDXDh+c8k77UG/IV3GNHrGvDzBcRIHW3Z/n+/d7QUutPHcqSxaJ+NCRRD
         hEZMdBEUL9Do+kmraIxqcALPgp+/rUKyUvC31aYWuRLn5BZ2726WliSgqArQGxGEUqV/
         2CnA==
X-Forwarded-Encrypted: i=1; AJvYcCVjEive7OxEMdgEqLpNfe5mWDJb5CYvr2YWJyWQ2iECDh4BILVSjUcwAoUUdosgPKGsk6kjeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9V7Frrw5C2/eFrBFHW/se/QmQYBhakGfNWdY9YJte1AE4GLEX
	b1977BoKNYILUC9bGltXmkaPpwobSO5eItWyhRx9F9dCbyObp89x4NDxBfX9etNPkrv4An5AKFM
	RLPXL5MdyM1LY4XmDC2bnwx1ufkBsj2Ss6rro/oU7nWMw6BPyb/+P6ilZFA==
X-Gm-Gg: ASbGncsZta5Tc7fRG+utqy7fQkFNXlEAjcehLWq7hT1HOLBCUGobVYfEyO1dKQ6auQR
	HHcw+x1tqLR2tw8OK6p9e70TuueiuA7WxoVZgziWOYjvkRIzfu1KdLzT/hplmzMttFL8WAzS8N3
	gcvzSvDYEuwfTrLI5LT0pAGAxBsGxJ8pjyvCr2BAOb+MtO8aRnTgq7gGAcT7usf/pIJztemFbMK
	ijwgacVwyU2bCMxQuRTTsv2imWHY3wamkVS/y4p5Wb35aSjQ7r0iUhP+uGhbtRCnTI1qMA//NcR
	oH9sP9vlgdrHgZzI/qQIv/xfaAt4es1C5o2FyTPb0tjMntegnDRtturH3et+yuCSni2S6Dnhfww
	lBbvmGiMFwWX1XNbj9bBxMi91vyaK
X-Received: by 2002:a17:903:1aed:b0:295:f1f:65f with SMTP id d9443c01a7336-2984edc8cd8mr3418755ad.31.1762886731095;
        Tue, 11 Nov 2025 10:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHudt8EBpHs0AgGwqz9g1pHc97ezO6MMeauxnKj3D0cw/mrZhoZc8rx6PO+N69y8wHTbVSW5A==
X-Received: by 2002:a17:903:1aed:b0:295:f1f:65f with SMTP id d9443c01a7336-2984edc8cd8mr3418365ad.31.1762886730501;
        Tue, 11 Nov 2025 10:45:30 -0800 (PST)
Received: from [192.168.1.5] ([106.212.255.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0ea1sm4232965ad.55.2025.11.11.10.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:45:30 -0800 (PST)
Message-ID: <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 00:15:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <20251107-active-uber-impala-8d9118@kuoka>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <20251107-active-uber-impala-8d9118@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MSBTYWx0ZWRfX1r3YhieHOQ4N
 7uzrdeBQscDCho1w8Xb54NVbYyBTNpiZhPFeaArW8nhMmfGyZDw2gKUNr2vddT+e0DzVTI3Je4S
 SDNmB84aZTDJ2zT/i10YNXgbeGR4p03O5F5ZGBSZi3h4SxiIrO/DTI7q4c5TakBjOHSfayPJZBb
 tU47Fq/NWd/NFectsA764uU5WtZhTZGG86BGrX94eVVZeAxmXnwXIMJuR/6aZa6HfEA3cJp3v3S
 zQ1ZGvQjNGYcd8NnJJBbcm5D4US1mwHCppfFre1RHOZFjYdfX+m7RFhgtE30Ijb4VmZQB4Jx1Vj
 GWjC8dlrwBq8WKODb0Y608MtDUhwSBTBFg3iNlHzzyG2AiRzD9mRBlJbu/8R/ZFy9A+eQKFhKbS
 iDry94hFx3rnQKComHL5EztulRoN6Q==
X-Proofpoint-GUID: gRoOEtTuj1EwwEYLOCDVQ0dnAiI0sdpH
X-Proofpoint-ORIG-GUID: gRoOEtTuj1EwwEYLOCDVQ0dnAiI0sdpH
X-Authority-Analysis: v=2.4 cv=CeIFJbrl c=1 sm=1 tr=0 ts=6913844b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=pJoDNl42m32kJ7anCML+mQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=dasm5qW_s5I0UYHIXAEA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110151



On 11/7/2025 1:37 PM, Krzysztof Kozlowski wrote:
> On Tue, Nov 04, 2025 at 02:20:59PM +0530, Charan Teja Kalla wrote:
>> The iommu-map property has been defined for the PCIe usecase and has
>> been hardcoded to assume single cell for IOMMU specification, ignoring
>> the #iommu-cells completely. Since the initial definition the iommu-maps
>> property has been reused for other usecases and we can no longer assume
>> that the single IOMMU cell properly describes the necessary IOMMU
>> streams. Expand the iommu-map to take #iommu-cells into account, while
>> keeping the compatibility with the existing DTs, which assume single
>> argument. 
>>
>> Unlike single iommu-cell, it is complex to establish a linear relation
>> between input 'id' and output specifier for multi iommu-cells. To handle
>> such cases, rely on arch-specific drivers called through
>> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
>> passed is always 1. In the of_iommu layer, the below relation is
>> established before calling into vendor specific driver: 
>>
>> a) For platform devices, 'rid' defined in the iommu-map tuple indicates
>> a function, through a bit position, which is compared against passed
>> input 'id' that represents a bitmap of functions represented by the
>> device.
>>
>> b) For others, 'rid' is compared against the input 'id' as an integer
>> value.
>>
>> Thus the final representation when #iommu-cells=n is going to be,
>> iommu-map = <rid/functionid IOMMU_phandle cell0 .. celln len>;, where
>> len = 1.
>>
>> The RFC for this patch set is found at [2].
> So that's a v2 or v3? Then number your patchsets correctly.

Is there any kernel guidelines that patchset should start at V2 after an
RFC? I do see many patches are follwed by V1 after RFC. Eg: [1] is an
RFC followed by [2] as V1 -- Or it is the maintainers preference and
expectations?

> 
> Try yourself -  b4 diff cover.1762235099.git.charan.kalla@oss.qualcomm.com
> 
> Works? No.
> 
> Where is the changelog?My bad. Will update the changelog from RFC in my next patchset posting
as V2.


[1]
https://lore.kernel.org/all/20250815191031.3769540-1-Liam.Howlett@oracle.com/
[2]
https://lore.kernel.org/all/20250909190945.1030905-1-Liam.Howlett@oracle.com/#t
