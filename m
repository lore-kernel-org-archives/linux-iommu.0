Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9234E76E
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788599; cv=none; b=SnzTNtTn6yXXqxAw//e5K6D1BI7RSAxlDr4eVVaq986ZCFihW2gk4NXnbd9vUksfQc5GJis6DgezMMMdhR8bfb/RBURxj97MrzdonZpsPpIY/6V+WaLpNP4U/oH9x3w8l5of30nKsvmfPPiBsG8hGRs/NXPyTUlUd9+XHguA9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788599; c=relaxed/simple;
	bh=toYSo3OobrugapftHePbdROlxuAVnQF6XcZup3CnDTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meTs7z0+leR+386MFnNGf9H6UUZn2VU2bAY27Ylu5K8AOzYJJggDjx5QMmr9GXYTXkgWAy2ESI1pdOGK/Y9yq9p1TIqguG3Fu1yqbrhgoOtBVMtjf5E+Znofkcev6UIH4NVmo+88ndoYuytwvAMe9knPcLL1+hXIP18NwQJ37IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNtG3Srq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrXXfNKX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNtG3Srq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrXXfNKX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B2JPEf4127429
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dfqXLcfgV6a9lK6a9WVNtmA67ZK8MlXpAND6ETLw3Mc=; b=UNtG3SrqjuIuFAaw
	c9vYK1aH5USgoDwQzdmzxWQOTrLMQcxozfyB6nJDpzX8+Jm3CUQU+YUkL7fZw7BL
	+PyWsPDPDUD5Bu0GIGJi3XlkdKDc1xyLlphtm++Mk/N+aAQXB7sAt9w/ikZPTprV
	Kg+PZHPoKt60sfZc/yHqxvcANNaIoijnS5gEbFvcjl6YqAWdV6KnB6Juun23Z8y+
	DHNL6jM6QFB9zMv0SYqIt+P7SL424duScgEHxQk74S5zNtkk+dFJmdo+OaIK1+35
	ETQgF2ATW4dgvKT/ZG89d7OubNyKcYtlxT+bc7Uj8ow/SK9czJvI5Tr6PuiVZa5S
	Tet27Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8gvm0fgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:43:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c67e92aad79so1034318a12.0
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 21:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770788597; x=1771393397; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfqXLcfgV6a9lK6a9WVNtmA67ZK8MlXpAND6ETLw3Mc=;
        b=FrXXfNKXxlNihQLKCE7RW2GEuKGve8/nKWItY2uXrTlbuICHtV6DHhnNJZRtH43Y9i
         q4BTW8sI5OllHmRpd6tRjrHvHzSJZqhnalUkMXPG60PxbQI+wmMlWb12ptVSQk85NgrR
         c6hJo3Xb13rB/RtNSJkAho8JctjT+NhCxw63RwRE+FYL5Y8kH9Mlvbi2cNWr8Il6/z0B
         c8bs2IcnyP02DUFEuov+G2LAzX0B7UHe3/ey6o2SGH2m7KZxrKOGld5jx6EjLjcMn9yJ
         /Wo/DaOjIN7aqNBKJEzWpm+iDbRVe8p76eo6KTJi7Lq2/sMJkF7fhgfEmjRHSjjqXWXZ
         VW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788597; x=1771393397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfqXLcfgV6a9lK6a9WVNtmA67ZK8MlXpAND6ETLw3Mc=;
        b=TR54KDQRbLq58xLfdP04SynrDl+GD1Acsi5yPmxA7u2Gf7RWy3kkP/oIQbQ1NjFTob
         /WkxUy42QPRL5ECXRGJc3+YoodxhDdaI0NB+7gAICS2rkYNkjsHxMUVxZHS+DthRw3IW
         gQF++T/laIqWwTX7eJUkdtWOWdfvxhO+39/m54G9fxEdxMc3JK1ZaIxIDQuFz+in6Vlm
         D58wXS4hSKXn9UFQLDjl2EXGaD5o2eCRTjSPaXJgYnC8oGGGy6pJOoBDvVB5zhTOAMwI
         9o9ZPpQbyv+tq+JkbVJ1N++ovE7hlCc5p17r7M/PUkyHfoIriKbw/nwY1kqMJ2TXx9JS
         otTA==
X-Forwarded-Encrypted: i=1; AJvYcCWfsdxPIK23WrusbVLrVfc7gHJCLoaknInO69LXPBBCAfnn72vKrcX3y1QuSVHZ4fwZvcb2bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5GAm5qM8dIymHECvXq/JAhCfGKRx1G79rNKXxGHQzjdNuGI5Y
	YmPH7BzD5OxddPjNB2huNVFCwaCBk7I2nfNq66OsB1UG6wpEMVxD53BLPjjhp2wmeh2+Jv0mtJO
	gSm8Pf14VZyLAABXWWrABqBdqEMHc+ouc5vZPZ9akE3z2oKodipbuTvDT2A==
X-Gm-Gg: AZuq6aJINeOfUEULJUNQFSe/obGVSqHdZc3KefTgolYgWCGo/a+qW+e4+dC/J/pPxh0
	SYRD9qTtdsEp4J0imHFAP0F9v+bXytR3++yVwbASQgvbbx+p75SGEwxXb1l9NlDopXsLfpTwgnF
	cbUHLEsTggaupd6D2aDOw06x7/yrYxCpJ1gMVKjqDVBL8mbiI83vlpSHDFZ6N91jPXRGN30j1Q4
	L85qbLD8Upw7d3oIdHmc6TcpVIg1W3zIcujx5d6YBl5hYQq85zMo749cnFx20zIbCWZOAqceM/g
	4vCh74shyWEXrMrC3Q9jXi1Zv+mn0efID2TCoTf/PsnTMcho7A0Xext5lpMK3cynjQcZ8P3cgYX
	h4v2gfzCGLk98xy0O75vpfNnIkLuvuLr3CcofSr6BSSBFJz0u1hlHYjsl
X-Received: by 2002:a05:6a00:7581:b0:823:30a1:d5ba with SMTP id d2e1a72fcca58-8244174c514mr13870069b3a.51.1770788597235;
        Tue, 10 Feb 2026 21:43:17 -0800 (PST)
X-Received: by 2002:a05:6a00:7581:b0:823:30a1:d5ba with SMTP id d2e1a72fcca58-8244174c514mr13870043b3a.51.1770788596773;
        Tue, 10 Feb 2026 21:43:16 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e8528f6sm722418b3a.61.2026.02.10.21.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 21:43:16 -0800 (PST)
Message-ID: <88a5bbd5-8bcf-495b-be68-65cc06a68f1b@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 11:13:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
 <20260210101157.2145113-3-vijayanand.jitta@oss.qualcomm.com>
 <CAO9ioeVwPhbW=mkGUZQdCJH+C=KVf1bm=SDkoDinrj+nD94s3g@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAO9ioeVwPhbW=mkGUZQdCJH+C=KVf1bm=SDkoDinrj+nD94s3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ctiWUl4i c=1 sm=1 tr=0 ts=698c16f5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=oAmyuOoVcDRkA2_ul38A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NCBTYWx0ZWRfXzGrn92nt0AFg
 iwOePeBfAd56UQGJNV+BP5OXpegDGwO8JuP2tvi8t139gIIcx9Rh8+AS6Y5yKDXjWp0eFfmZIef
 M6+qEMYVq+WFWwfJRhHY9dpl1VxifsGKLSgC8SF5gVqpLK0ltJwdgxjB1GqPJUsDVYOstQYLy05
 ppz+zcm00OFDoJHXVHkVU7xXqLhI6mQ6fVpE5Rn+jaQoaUZ3Opfr4ZEIQoz17bTTnEuU1JXLTL4
 +m9ZLSqPcWsj6UtzDcZFlMvackCBIs0a+uM034vYFPq7rM07MGTXTrjyZ2Rdf5mc0uAcQVERNDv
 5cXoqnbQqLfMeNjTZIaN4hm6RwRW/1k1g/xMFYwz5yY6GhsC8awodnrW6QKQ6NKbUe9wYtSHZUP
 4UQf4RMuAAyAuXqfdsWrFR1ZOAR4QM+sAWW3rAHeqUzUN/f2UZTX+oML8lY36xBjUBUc1zJw5tX
 4FormsKVNt/v45nR53A==
X-Proofpoint-GUID: Xm28hRUwSCORLihoBZGAn8AccBoP-C0i
X-Proofpoint-ORIG-GUID: Xm28hRUwSCORLihoBZGAn8AccBoP-C0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110044



On 2/10/2026 5:30 PM, Dmitry Baryshkov wrote:
> On Tue, 10 Feb 2026 at 12:12, Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Introduce a new struct type where the optional arguments passed to
>> of_map_id() are Currently embedded as of_phandle_args struct.
>> Subsequent patches add additional arguments to the struct that the
>> caller expects to be filled of_map_id().
> 
> You updated the patch, dropping of_map_args, but didn't update commit message.
> 

Thanks for pointing out, I missed to update commit message after removing of_map_args.
Fixed it in v8.

Thanks,
Vijay
>>
>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> 
> 

