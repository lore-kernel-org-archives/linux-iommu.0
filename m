Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5F3115AE
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575602; cv=none; b=buKVxRlwYuaRee12xi8fu+0U4tpb/85Dij5rtQGSJLQCgazdGZFk3z/RKtNBOGhIToyQM7yOIX0O75MuEi2ijMOS5XzX/0/VchtEM1UOtxOkpLGlQCiocmldTVar1Ilb72zkMPb9rj9H99pa2xvsi9SjRdntRE4b6MjLYDK/fdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575602; c=relaxed/simple;
	bh=00Et7I9cT4nNJksJnG8NwiEkQjpoIYN1zwHw+vnBqj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io0RI9M6MlQEYoJVCMFqKO06T2IxunO5SWIeKAdLcDueawKtC/evcemFNDRpynb+dQaKvaXiMiMwThkyw/13Wk/V7hbsNAkOAVoFgK6p2+5zftK9ARDyFEck1bhHu4wI2HNLbtZe6VJQJmQ534lGdB6VeBBlvY1V8opMRSd2uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cb1BRReV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrVZkgb5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cb1BRReV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrVZkgb5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJFkEi81769150
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 18:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o862kOcvuwQRyFxMDCkRLuG/QYO1ql4833x+8E42oT4=; b=Cb1BRReVWlnM5GsS
	+5X7GO65K6sKpwVSFvRRyu4WkBToHqHwaL1Ltr3SuddK4YG9gA4fIWjlht7RrNh0
	At0k1LPjXoCyaaKTs1wiTiMUl39oAwv7oWuruYBnOoscKHZsnwN3Acb/atjfqty7
	XPbPRt+MpNsXGA0pTTiwRo0dxsmlYfwE40ZkYH96zaOxSEBGugC1y20rxfZMNH7d
	aicyvxRCHCPt6crqd7DrZnkAeD+N1QUv/klHNikWo9vH5MTBAa9iBwZWczz+Mtrc
	fKyjNGCYaahQpBGxrS0Zixp6VB18WE3PY0SQeKgzJ/Jko4Foxnk/WzdQxFQgVYJ0
	c6uU/A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9n0svut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 18:06:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b993eb2701bso6815820a12.0
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763575591; x=1764180391; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o862kOcvuwQRyFxMDCkRLuG/QYO1ql4833x+8E42oT4=;
        b=jrVZkgb56hVcBbgxSrOAO7NKCRARQc5GVxhU0iL/QUDmeprK11NEWaqfZpikC12MX/
         4uP94TC7bvTSi8bh4aPjh95JfuckImWW6KECjfUz4mhbPVtm7sij+vplq2GZk8VleO3R
         tnRVtyjL8Gwmy2YFBDiiEAJ279o7f9YxBwjbU1f2N2fOWsEra1+PrXBgkNRjfRfVah2D
         RmniLmM5SDUxdFKLZz+HMtIluKoe0cwIdzhKHid3dBfCAUVSjaWj6hmrjt1U3lF7PC20
         GoNE2rHrYCczksMyuaDhbHsSPbSUICWW81q7f7ZUQ2jE9goFkn/9uHvNflQznH5O1PCh
         95cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575591; x=1764180391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o862kOcvuwQRyFxMDCkRLuG/QYO1ql4833x+8E42oT4=;
        b=RqClOqEvj3HjwBHdd8uHXJJHX1Thg/dNz9sYCsHX1LPNraxEsOozSXq4vCGb0ZOSQm
         D0z5KEvybYZXTzXklzeGxCPsbfPMZ+yYzM/bV0wpIOZLuq9Ya6E/gwCOji8d6Yfwk9fV
         ek8DJBM1PiEMaB/1QWV0+jrtaId9dT3JXVI0Bv3e5LQpzlKA0rWDwDOx97JmHU51Ye+H
         nipGA0IVhF29h5DYLxwi7Gy0oxASvlOa8EXrOsik7//zHRi2QI5AgPLnz/utIccyCtt1
         VexGIj21AcLI+9SdO/K/Wg9/tbbQzpmBUOssdkk0V0/Mhk04KEja2/3P/wKl/DBGSyeH
         sZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXoAUm1/VWmPnHN1n7JqKQdAv/vUZvnzRN9Aqz8haefVPJ8qgOCYZPTD7Ocyez3Szi0rty/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5NTQdd/NaxzXT/Oh5Kxy9ZTdekxosnDWX8ZG5sYFdfiyBaTSU
	aZYaxgg4ukemK6kj6odzM5yQc+nB/dQ0Ub3MMLZIQFMMwSIxw8q3jx0PdS0r49RowEbl4rAaltG
	Aw3bxBW2ZECk44iOXyFPc9e3scsG38OfvsjvWSjKuPC8/wMfaSdBCnUUOng==
X-Gm-Gg: ASbGncvJQ+FvJiF41hECHSLCURqTh+0FjDSb2mRttLrW8SdxHdmg4NRJNDIAUcEwQZR
	K9GP4CStxHtmhzJ5vfzw5KpmqWin8I0IH212pJS2xF/TBcEU8LvyPvVVtrXP/NSTuo9sm2/42mA
	9CsgfXNt/2FRtIsoXvEnQoBWjWHEDOTr053OlMGLi+S+XcghvimhCXfEeFqh9ubra6rVYClFzCG
	ZGgHglwLy3zkrT97yu22UvhakLscOnCuptnN2kukv3CAtQDM6uZJRULWp2hyCsMQZLsmPF/aKjE
	6wbsEarpaLTbfw9tgwtHRoAX5nPgOzzr27YIXEKtNyI/Fv09tXjTaMDt1Fkv9nYj8UwwrFN5X1Q
	zsLzBc3lzW9tjCIFr3wBZ5WTeUCMwuqKFcRIDaAs=
X-Received: by 2002:a05:6a20:a123:b0:2d5:264c:e4a1 with SMTP id adf61e73a8af0-3613b4c07f9mr489051637.8.1763575590694;
        Wed, 19 Nov 2025 10:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVhNY72sMTY4z3Z3kCjEqMsjFsvgckuWXFjMVFg++QoqncF79iRA6QYWRJYHUkt7ly3k5jfQ==
X-Received: by 2002:a05:6a20:a123:b0:2d5:264c:e4a1 with SMTP id adf61e73a8af0-3613b4c07f9mr489014637.8.1763575590165;
        Wed, 19 Nov 2025 10:06:30 -0800 (PST)
Received: from [192.168.1.4] ([122.164.69.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6346sm116417a12.4.2025.11.19.10.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:06:29 -0800 (PST)
Message-ID: <50bd3be1-63dd-4bf5-915a-02d923fb0376@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 23:36:24 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/arm-smmu: add actlr settings for mdss on sa8775p
 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251118171822.3539062-1-charan.kalla@oss.qualcomm.com>
 <himyof7napywkc44vre5ncqsatkkaxqnqbhjht6hjt53lakper@4wlwsvxkkamc>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <himyof7napywkc44vre5ncqsatkkaxqnqbhjht6hjt53lakper@4wlwsvxkkamc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE0NCBTYWx0ZWRfX/jiZ73k7KzXa
 w5pjWB+2qKaScaYrcSLelQ0Puycgk8WiJV90i2ViB48De4wIiAcZrlqHb9OpFyC9QFnd2/WM3/t
 A9slfMl2yLHZEwNZxPseqDPCgMI2dl8N/ceQH2e27RPOFu3NwUUEyjwTrU+dJLBPjhRYSgRQFxZ
 LnNQ28qnyia8HUGfnlnlDfLqRTdcHMfxWI4sEMnoXN0BBjpx37uYOqAhTtn9O2wFkbqmiWiQxta
 3yZwmFZ5kLasoIYHJGnIRiwio/2Lt51IwfvBbj75CtuBmLxfiawwG5v29GXEtUjGyMBPbBklZGz
 wo3opRqPCwz7V6lRnVkNgWzS0/f6azkU+E5DbG+d/e9MkAdpjZ6WPGoQ98UPAmrfYmUxRx8lnvQ
 KgDdzgX0RgOhkVhz8nSuK4hy048d+Q==
X-Proofpoint-GUID: ljM6urfWVzi-xGXnuC26CJAwyGLKsFsb
X-Authority-Analysis: v=2.4 cv=QZlrf8bv c=1 sm=1 tr=0 ts=691e0727 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=zTkTFZhCv8P113Yyz2MVww==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=antjIYhOioNipfN5IzYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ljM6urfWVzi-xGXnuC26CJAwyGLKsFsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190144



On 11/18/2025 11:33 PM, Dmitry Baryshkov wrote:
>> Add ACTLR settings for the mdss device on Qualcomm SA8775P platform.
>> This is achieved by adding compatibility string for mdss in the actlr
>> client of match table.
>>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> ---
>>
>> Changed from V1:
>>   1) Added actlr setting only for MDSS and dropped for fastrpc. -- konrad
>>   2) ACTLR table is updated per alphanumeric order -- konrad 
>>   https://lore.kernel.org/all/20251105075307.1658329-1-
>> charan.kalla@oss.qualcomm.com/
>>
>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 62874b18f645..0b400e22cb00 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,fastrpc",
>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sa8775p-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> What's the difference from SC7280? Why don't we need to set CPRE?

Sorry, I'm really not sure If your question imply to talk about the IP
level difference compared to SC7280 for mdss?

Regarding why don't we need CPRE -- these are QoS settings that does
control how well hw behaves i.e., related to performance settings not
the functional ones.  I guess, these settings are derived from factors
like how many masters are sharing a TBU, how crucial are masters using
that TBU(like important ones may be allowed to +7 or +15 and may be
others upto only +1 prefetch).

Thanks,
Charan

