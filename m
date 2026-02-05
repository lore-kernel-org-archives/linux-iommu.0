Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123E35A95B
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279005; cv=none; b=j2IeoCOypq2+1I/+rlBiQQjV+PdYjYSUdL+FDhpMTqHEw2oNFMH/7QFE+5qzHIbXIqZU2w0vh7xpzq3yx67UFGlpviDNT3yh5ziCVp5gBc2uKkLLNM2BV4NlO2I2ibb17v9o2p5v39fQBsgZyjZPqNjZ7PYnbHu8CGef6m3Hh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279005; c=relaxed/simple;
	bh=31BKYP0Nlhr52tfXs2A8uGkTeifCfvGi22PcYSAYp/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLwrO8+Od+yCnyUDSD8Fyoo/c16Y9OCVh/3qMG2zijrOexs75STNp/FprWzIVxEfp9cGErYfsAr6Qcc2/+4rAshYtRAvkiNxqmU/au1RUvJgZehuVMfw9VCQad7UhYBD/H8nnW3EDxfiYqUhDgjgDMsNLXqdGA9BIl4XlH90yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iEUiPBrO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oxj7OE+q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEUiPBrO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oxj7OE+q"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153dlxX3031034
	for <iommu@lists.linux.dev>; Thu, 5 Feb 2026 08:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a8rDuGUPyagZOfVWM+f/BrTixnTf4NeRHC5TK7Tyqkw=; b=iEUiPBrO91RmrhUa
	NgQ2fl6CgspcdHcFktP7O8JSlhyMfMc11W4F/N03QNnaHvC20g3Zl2YdhuVGkPBj
	7o0YC8drrm7VbWw9gWSeQUrK7SkC16k5FEeo34GPlpMfOcts4CSgvlbqp2tbCfRf
	FLQCG8wnorn6YwH5CWUl6ZQGdZs98X48tAE0vqWbtsz2Jo0AT4Gv10yldJLolAUT
	jCUNOO7Ke2AIwOCiioRA2Yaq3HAs8JEiUzp/LS3qsIro7WB9i94i7uPVtWjX8See
	OdZiqA41kskQnR352Apb1tX6f/cBtrPiloUCJYZTd2N0QLiA84ozIY0XI0rajO5a
	Tu+Vpg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4a7tjc6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 08:10:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35301003062so1693208a91.2
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770279003; x=1770883803; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8rDuGUPyagZOfVWM+f/BrTixnTf4NeRHC5TK7Tyqkw=;
        b=Oxj7OE+q1YqFNl1eQOyBUp4ze60hQAVpUREnWISHOpKcW20m/JHEZFv3kP4AeLwbT/
         nH49iQs2tYuLRDEMSwZFtCj5ljezGmPbEUG5BEJSPnUxW28xGAztC8mYl6B8eyYWwV2C
         SUYFsJ8P0ze8WY6HiKCbxyfHeCktmg0fszpshKW6U4G5ehcPOVsR82z3PK1jeBKrNQQJ
         LzsrM7MQHl6BjztUM2NyOJGRMd62h2gZtZc+jJjlDPz1Jw0dzXYy3Kcpm2vHLrBy6ycW
         iE7O6j7kCdC518cFaF8NhCSmM7ogeHNghS8XLLthrSZwjaBuoSVg2D2x87DnXo5MUVu7
         XjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279003; x=1770883803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8rDuGUPyagZOfVWM+f/BrTixnTf4NeRHC5TK7Tyqkw=;
        b=iWUvARcehc4ib2e4v8FLaG8TEjOqiwI8tM6JqzWo3E4T0vikjv5XKAoDl1xMU0TLQF
         mFaqI0QRTVd9CnoOW7ysYvEDcueCv28kH7/4JacvkwkRxlQVVI4D4zI4TW8kJv4MfXgJ
         kPBwXSHkWR36rIKRCNpl6aElj81xXURbX25VafiPf55ZmRDTj1BdDD7lvlhl6Z4KhfLK
         uCAvaTNczTGTIVjWFDq62si+S17s0fHtgnw98LdIGNYh917lluqlgrV9/TwQtwg3+WnZ
         Sxmqp9vb/MM6HZ+mac7FlMrmi32cEbjWj9HnZoMxJksROoEMn1sw/5llajq1g5yiQXLk
         qKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlgUfKRgY0RAEubtglGFY51CcbP+CRTd3Qhr4Tf5CEW7H+l05WZIqKKEs0paf3NN7uT2Axzw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2QcDC1sA8XQqkjz9w7DZ5+c3EvGcLE1+JStwfHUpAxGSpCTrI
	A6AoBaNal8pkXzxgEPiKk6d9Pyj3QNv6k3XrshUQA9Yq76MH13Sqqeu8A1E/pBhJADy9tW7wohR
	Z41W2pzul9XiN5XiiiKrT4EtREQwOs7DKlM9Wgu5iEkYDzgyTqQ/L5QkDAQ==
X-Gm-Gg: AZuq6aIOLNRmjKSdb3MetgRIs3gP1f9KlzOfdIYj1kecrs3Wb4dz6xxWWq325/lVcjW
	uYoD+hTZuPpb2dYVO72CRg9KY81nngi7deDjQjHK/hDt9BYhTMOZ+uRFRR3ulMzhME12e05oImp
	pO/YidHVe+4SxIBgFy+V4I2eKzf6hgO1ws0WO1TDrqYWIOuj0z2wnlHlyPmjAHpczKAOuz7+wVT
	MQCdzYE/My3XwXaeJLXwZcTY0JMwWInKe+DgXaSiyS7DkepJD4CMf7Acssty/eSgAlcf4eZftXk
	MY7TNJ7RAwbN06ArSkjaA9y8P1anDz25YZKAKuXK2IAQzi/Z5K+mtR2r7yXWZvYB4I0E1sxCL1l
	SBcXAKBM/sQ7slGSnbOTV4ddZa6FrIWF68GPxemEu0Svx
X-Received: by 2002:a17:90b:1643:b0:345:badf:f1b7 with SMTP id 98e67ed59e1d1-354871db4e8mr4514481a91.28.1770279003364;
        Thu, 05 Feb 2026 00:10:03 -0800 (PST)
X-Received: by 2002:a17:90b:1643:b0:345:badf:f1b7 with SMTP id 98e67ed59e1d1-354871db4e8mr4514452a91.28.1770279002912;
        Thu, 05 Feb 2026 00:10:02 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09adffsm1642267a91.4.2026.02.05.00.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 00:10:02 -0800 (PST)
Message-ID: <4835d0b0-06c2-42d1-aa33-34daa0e7a8e7@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 13:39:54 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] of: factor out of_map_id() code
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
 <47fbba15-6375-40fc-bd2c-8ebf2788837e@linaro.org>
 <7d1b5897-8f17-4213-b893-d99d96afef94@oss.qualcomm.com>
 <j6euiso3pcg7nvewscsfjkqyfl55ajxxybf2pib3622uontj2y@aqj4satyf7b7>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <j6euiso3pcg7nvewscsfjkqyfl55ajxxybf2pib3622uontj2y@aqj4satyf7b7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZgPb6mjmbFhLvsNh1OrguLM7jI1td_1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA1NyBTYWx0ZWRfXwMsNS9I8akUZ
 o/DuHIWhPRfebJWYdGON/HzAbCzcsI+itHgmRBR+qk6bYKgL5688tzbcZDjq4Qitd8c1p0sN0Jt
 BO0gm4wQvQcRvhekH/mXnqhlaHadPa2hc+tNLoOdn8UMIFiJ1wRknx1qZ/BD1bYWLz7F44AAYw0
 wbtBrydGYuGwBK+LC8oA/AqUjvftO62y3NIhcpwZPl0BuVv69SUIZ5WfIDn1MV4AOXyLSYtW7Aq
 lC5W41yjVZrzZvj7SVsgSr2qyGe0/ICFRMzmYZLogWjLqxhpBJfxG7fWcmFcTLp7eWccwOPoD9e
 ru2eG1QvQPJKwJZoEZLhBGMxjjROFm8aYjuV77Dwfhtk5c9TAJhB70rc0VUywZ1HunLYeoNxT9P
 xMKtQtlNkXOTdM8g2FMVYzn2/RYw0op8jwRvyfN4j0DOiVIqTpg2sbXqIy2ciGQ/x2H/9WSo15W
 FXxGZEj69eELfNlPZxQ==
X-Proofpoint-GUID: ZgPb6mjmbFhLvsNh1OrguLM7jI1td_1j
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=6984505c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SBgkrO22ZELSIJHh4VIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050057



On 2/4/2026 6:41 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 03, 2026 at 03:43:58PM +0530, Vijayanand Jitta wrote:
>>
>>
>> On 2/2/2026 8:22 PM, Bryan O'Donoghue wrote:
>>> On 26/01/2026 12:25, Vikash Garodia wrote:
>>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>
>>> This commit message is confusing and inaccurate.
>>>
>>> First up, you're not factoring _out_ of_map_id() - factor out of_map_id() means to remove of_map_id() - you are refactoring of_map_id().
>>>
>>> Your patch title should be something like "refactor of_map_id() to prepare for mapping of multiple IDs to a single device"
>>>
>>
>> Sure, will update the commit.
>>
>>>> Linux interprets multiple mappings for the same input ID as a set of
>>>> equivalent choices to pick one. There exists usecases where these set
>>>> must be maintained in parallel, ex: on ARM, a dynamically created child
>>>> device(s) is referencing multiple input id's in parent iommu-map.
>>>>
>>>> Factor out the code where multiple mappings needs to be maintained in
>>>> parallel can be achieved through callback from this factored out code.
>>>
>>> Which callback ? There is no ->function(pointer, here...); ?!
>>>
>>> Just make some plain and straightforward statements about what you are doing and why. There's no need to resort to dissertation-speak.
>>>
>>
>> The callback in introduced in patch 2 of this series. will update the commit descripition as suggested.
> 
> I think, the callback was NAKed already.
> 
> 

I'll remove the callback and update change such that all entries of iommu-map are always scanned.
This would handle the video usecase ( i.e; same input id's mapping to different SIDs ) and in other
cases it would result in few additional scans in iommu-map compared to existing implementation (where
it just returns after first input id match) , does this look fine ?

Thanks,
Vijay

