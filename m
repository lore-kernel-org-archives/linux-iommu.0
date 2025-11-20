Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10366337117
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642015; cv=none; b=rpor8XS1vDgPCPYUSKaI/aKL7HNV18rsyOHp5b6cvlPIRvQiSYUYHikTvu1eVzhnRbw96hpiv0BoekNS/3MRtCXpBVf+OZzno0qp7Xuinq50lf/MLgpNMCWGc50wSPhkHnlSn4wbKIFL+as+S6gd8ZUMt63W6a8OrnbX6p5NXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642015; c=relaxed/simple;
	bh=BA/Uh+Sk1e5czT6KkkxKbFqn2JkSgr8Ze+EOjUDAQPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBpfxN0H34mYqQAajkiws0aIAaXP6mglCN6L8H9Sz5Y0Tr6Xz812F+Ak4ndZSLstnxU7n4PLCTKDKzmpj3pwHkT+w/dEpxdXJCBRPrYNJfkWsAzet0YnHHZMTwIqgnOeZXGL1PAGOf/dDdPAGhpshrSzU6b+ZPBk4gUg525mkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kj2q3rI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b0awIuCf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kj2q3rI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b0awIuCf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKCBjbv3720064
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7hJNYrGiiTjlqMPWTxw+6seK+qE1J1erEAaW4L/7Ijk=; b=kj2q3rI2u7XF/Mwt
	3leJFZCxjh7CA0q/0B52pC2W3yeHY5sohSl5w3kKbwX5e673UhWuJGwYzIwHkdne
	2g/29H5cNWtbpRtPGiB2w8mwy6OUBbHw2Bt8MjFwLE65x7Mk8Uk9c2MdmymBk50t
	bF45le5cHEZY3Bf+IlskJTl+AsQKoZRFn4HpQvnZoo8OAerrIhqMbiIBkt6xrwaB
	iEtm5N3RKZwVr22o2I69N0DO6gdES6tUPH9v1ZhBFH3KIjogOPVqt6AvBX6Jy9W0
	pAfGDS8FQqzgoR96XEIlzFpNS0pvKYGheO8egcO1bZekm1o+U/i/5g4ilFRcRaKN
	k9DNlA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahqb0j8y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:33:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b196719e0fso26531685a.2
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 04:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763642012; x=1764246812; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hJNYrGiiTjlqMPWTxw+6seK+qE1J1erEAaW4L/7Ijk=;
        b=b0awIuCfn6y2BVvegbjYqAZoGbMePcj8olDA64eGd/SBfnVmF6p8A9TAnzdn5poODd
         awVu338YOda34oAjlUroYWdSbrxor1UhUsYA3aNXgRdWqdYcqF7ynYf6zL+v2vULVpSY
         UqdtjGeTJ5XSXgA4qAbEpfpWo3jAueXA9cLdkOsANKJk4D7YnqgjXB5fDszrF/J35dci
         wsz+BOX/6nrHTebqSrYMeudzLD7ZTSjp9sIWbh7ZjTKEeTDO9RJglNucqBEAlpG+9Yl6
         KLy0j9ug2OtU9yylHHKF+jwbyva1yH/Hj3swOl5zEXSpLObZcZPMaQ76RGwpY5PjTXwX
         kmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642012; x=1764246812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hJNYrGiiTjlqMPWTxw+6seK+qE1J1erEAaW4L/7Ijk=;
        b=rg9Cs7yfo9sZU8V1keVWb/S2QKK+/OUSVlccNvgpZ4nivA4+00DZHzLte3NKni2xDx
         haWMG0w6UXJWfRnWkgVJveivDPYfdUs6rlkW8YWReD8/EXdwb8/1qh/ln3503ixOttOF
         90rnKHkPaH9N5opBmmdqY2kDf9ZBRnqzfA+yAVxAzw7BZ0QY/3qXGOOqMhpQthJ7Y0cC
         3Yw+kbAtK4DkLvoOKbwqelHOE/Y4gT7pxrMsIfwrlt/2C/quhpINW+HG0VJOC283MOVP
         ceBWNdTIZ9diqsxB1IupEJ5PnL9TEnQs7vkSpR3ZQws+cwe4LRME51BWrNWqlrFgAz4d
         fUUA==
X-Forwarded-Encrypted: i=1; AJvYcCVavJPIqxycQJiPFRaSeMKq1HNO5bWLnh7c2/gt0DyHxLyURZTrFV3TklDpdIziuH4grjkVXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQkmvui7F4TfAS1i7VEG0YxJchh2SQ+5lBqYHnUXVBppY+MtSG
	QN0Um7QNsEEgiCihai+4DKUKJFLkpWhw/zm8LRA8Ejx/9pSKQnAf5Vi+OIyPh44re6yKAorCWK1
	1LgIKQ+Z8WCCy3c7Hxrs2gdmThD5F5huHdnrBF3YhsjAydkK1Lai8qZ+HUg==
X-Gm-Gg: ASbGncvWPlcRlGhTwEcCARyXpumv40K7Yj+auysDebRX4LYRahiI3E7tWc1oqwThYwI
	6Z/MtdYtqtQ4R/bJP2uq1Ak9yWRY01+U49jRtfjUiUOgGQjsyhe2k6kTv1RfjDZlLKBpk1lM0/T
	LIYdOhvI9nLdXwBFYdPVOk61jgZ82aONuruAzZUhv7ewcGesRFG3OcGlUhjEXLg03oYkSwhiy2f
	6NTmdZ9Q9xwkzppuw9W5Py24lHmZvZYgerD0ErYvjOlzQCCIncHg59yoy+zV0cSKcZl7ROOYBFg
	cOAn1BbfQfuwXbxsOcEBu5y6d3hpUeT3O3FuZhNPcU9GhfWzjgZeBY8z5tjhwh0ox1vywhPgvYp
	ing5O4lD3u53++0pMgYtYkHbansUTUfdtGyKa7TzwKpZZk9Mc4wgsk4DfZ3nfHNSO2Yc=
X-Received: by 2002:a05:620a:179f:b0:8b2:9aba:e884 with SMTP id af79cd13be357-8b32f384876mr126004685a.6.1763642012196;
        Thu, 20 Nov 2025 04:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH8PKV1YzPz57vibeVrtCc9zDlA5YXlsyN2nZn8xrRbGWLU4MA677i03AksflHjajS1E7evw==
X-Received: by 2002:a05:620a:179f:b0:8b2:9aba:e884 with SMTP id af79cd13be357-8b32f384876mr125998985a.6.1763642011516;
        Thu, 20 Nov 2025 04:33:31 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765503a990sm194688166b.63.2025.11.20.04.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:33:31 -0800 (PST)
Message-ID: <09b933ab-eba4-47c2-a667-370dbeda2749@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 13:33:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/arm-smmu: add actlr settings for mdss on sa8775p
 platform
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251118171822.3539062-1-charan.kalla@oss.qualcomm.com>
 <himyof7napywkc44vre5ncqsatkkaxqnqbhjht6hjt53lakper@4wlwsvxkkamc>
 <50bd3be1-63dd-4bf5-915a-02d923fb0376@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <50bd3be1-63dd-4bf5-915a-02d923fb0376@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yoouevCeLx9fHRQ7P6meaSIGTVuu5wrB
X-Proofpoint-ORIG-GUID: yoouevCeLx9fHRQ7P6meaSIGTVuu5wrB
X-Authority-Analysis: v=2.4 cv=DMqCIiNb c=1 sm=1 tr=0 ts=691f0a9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Cn4BvpCIsXtoq-7YWPcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA3OSBTYWx0ZWRfXyO518ZmhqQhY
 9SqsrNWd2hUy/IZGpYgTs75tE7fRtSbLnK5HiXtgob72INiyqPn/5+TPrtcRGEcO6aNexseOzKf
 6JgwJ4gaQdYrxDfKlI0OTDbgNvDEXIdcxQXX9QRduSV5l9GOv3Dc/cfLsN06j6wsUQiqGhRBDY9
 eVabCpOCVuWnbm8VXO0K+5dQtzsLk0DpE5w/HRlpGa13Zd9Gk1E85GJjPb2eGYxpaucEUVR2Iuo
 2dHB8tKv/u7cBsLdjpXt58TfCRZw/T7PTaOvWHt8vKxe+UticZomCPbPdg2QixuGHsmgUbAgZp/
 7zMdPiTYt7sIEsRPwCkzzpkKKd3LgiDClfOBkiivuO0vV6lhNfV/DCb4qk+4+WPEYOR/ckuJqL/
 IPUkpHogSSBmVLdP9AcikQMH3HkikQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200079

On 11/19/25 7:06 PM, Charan Teja Kalla wrote:
> 
> 
> On 11/18/2025 11:33 PM, Dmitry Baryshkov wrote:
>>> Add ACTLR settings for the mdss device on Qualcomm SA8775P platform.
>>> This is achieved by adding compatibility string for mdss in the actlr
>>> client of match table.
>>>
>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>> ---
>>>
>>> Changed from V1:
>>>   1) Added actlr setting only for MDSS and dropped for fastrpc. -- konrad
>>>   2) ACTLR table is updated per alphanumeric order -- konrad 
>>>   https://lore.kernel.org/all/20251105075307.1658329-1-
>>> charan.kalla@oss.qualcomm.com/
>>>
>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> index 62874b18f645..0b400e22cb00 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> @@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>>  	{ .compatible = "qcom,fastrpc",
>>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>> +	{ .compatible = "qcom,sa8775p-mdss",
>>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> What's the difference from SC7280? Why don't we need to set CPRE?
> 
> Sorry, I'm really not sure If your question imply to talk about the IP
> level difference compared to SC7280 for mdss?

"SC7280 has MDSS, SA8775P also has (a slightly different) MDSS, is there
a reason these two have different settings"

> Regarding why don't we need CPRE -- these are QoS settings that does
> control how well hw behaves i.e., related to performance settings not
> the functional ones.  I guess, these settings are derived from factors
> like how many masters are sharing a TBU, how crucial are masters using
> that TBU(like important ones may be allowed to +7 or +15 and may be
> others upto only +1 prefetch).

And this is a good answer

Perhaps you could reword it a little and put in the commit message to
make it clear in case anyone has the same question in a year or so

Konrad
