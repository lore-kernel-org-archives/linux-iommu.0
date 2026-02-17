Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952329B8DB
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351807; cv=none; b=mTWht5xwh/20ZXhDSjAlAOfjlKjZKwvYRQtgSqiSsTdwfmlOl+ZM3IQfa+pHzMUmgDZJYmpYC2Xg7Prg3IHsBO40AFyq5OZ9ZMg3WL7mALQv4MDg/GS78Sm6iOtiGUaaujPTWXNvaZsk2J4lWCsx/HNvP2tJfFThZ8CpKwK8Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351807; c=relaxed/simple;
	bh=twduH7+XI/JCNr4DbEoc3oFf6uD4Fk68CE4dpH6GPwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ2NfKLMKvPM5hdYf/cL9eRzHfXRu/SMy37glxdNZF5X2kMUM2T0NvvjjfxxBRWF297mXFZB+A5W56Shy0r9FhNATRMhkvuIBFHYIq2Y0rCL62fOtGh9jnsFOcpLS/2RpLHWCwgx6cW59j2X8X7UlHmh30gWbK/zDwIJ8YAMUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rv97gS6v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KsOqazIG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rv97gS6v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KsOqazIG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAkMMn597031
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wk6kq7pf8sOUgb4FnoFQG0q0zp4jil34CrE6zW4xlH8=; b=Rv97gS6v3Wa8Xo/E
	S5DQsIuW6q4ozsMvpzh7WUmG20GECXnNIBujZhsSP8ObUWmutDdibJg12QZuwD8R
	LnyGZIdh1a6p+YF6d11IfcbzT7WFFLZ4PsNhENbxHBPrXp9ZyMOYooVcx1ZRgDdF
	o+9GpcHJlyZYalzyDsZww/4gB236v4USl5NaNIAGD1rFMnoSNKrdOiJYJXIDoDU0
	51tIzeMddkqmTB2dn9DBCKtWSkC7yfGjZeyfkPYXRuKpQh0fKNfyiAs5pIIvCmzY
	ar4PjK1pD7oLSQ6ezVD8/2Xg+nhj1NFqMExhlZOIYUprULSQgoj+/XSOeAGWIb7K
	k7/OBg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca362wnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:10:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aae3810558so50845695ad.0
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771351804; x=1771956604; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk6kq7pf8sOUgb4FnoFQG0q0zp4jil34CrE6zW4xlH8=;
        b=KsOqazIGLgP0Q517IX6VrtAeYwb/OfO0pC0PHiCRmj3anNW8quM/CDt9C0Z7Ozg8HJ
         o2ZkB+bFv3dsMs+XhRKwP8YXsJViTzgcyI9c7Rx/d2VWz3IUvrPGAeGW46QNtslJEw3W
         rR20DbM0LbYIEDRgGqEskL6QUMmRwh04KjWa7dYACSl2RUgLBK1anGh3SnfYl/a0sXId
         7g8xByMxuzPeBjHnYKFDU9Dbbs2Pr/oSz3I1WU6/IURArcRA3j9+SU75ld1E2uuqx+xv
         r3fKecwM2OuKyURJJ0o6cT+3zMzg/lcznyy71ls5WzPQWEZ4ZecGAZUyhEKciJh7ZpqH
         Fj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351804; x=1771956604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk6kq7pf8sOUgb4FnoFQG0q0zp4jil34CrE6zW4xlH8=;
        b=GvXBtqSbGDMIH0yH2uBrh9f6RsUi48NjnMbc50E9IxTRCfghBG14pbYjQ2/IHnh7a5
         2L/pRiK52l/b4fGFtQzF6lNQKA2N7wTjZPZM8vO053hRwTxRSLtPPduPHXeaWa1NKSb6
         4d1J9WfrJNX+fXbCi+dY7g+e2cigMjr17Ps1WscfNUWpGvKEnGE1ZGed/N82bt4BUmAm
         umjS/RuXlvhpInjy0/EnZ892Eurp0vAaGfk+hXwoTVINef8qhSSoLHe4UExGMLWzajH9
         9LQRwBfmW/RHKiIX7msHmJxMHDBsxaVTXF5Fp4HI5/lkOj6r0HSyNi6g9by+bKDsNW8G
         Dptg==
X-Forwarded-Encrypted: i=1; AJvYcCWmjzyHMysv34n39kLOZqqcTqhtKpip8OX7yscypa7jSRtlnKYwhyrTvddPZ6zAErXrXB4a3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzKicahkzZ06a/1QERdTbq02vk6KgAsmN46mq7eCTTeIrgJh2R
	TKlaGRjE9MOI1ZDdLoQgtmYw8ssErW3bpV16DgXrQ+OEW1C3uvCc3DoaZh227hXE+DHNP57dt+C
	MwSZTfIgffe7/57eFt0YmLrE+XLdpbAFTO8l3CEMH605tdMdjU9a7IH7hVA==
X-Gm-Gg: AZuq6aLhPkskGmLmfOUNQAWqdsiRhhbxK6bpe9zvsyPHE6+ZfKQIurq2ddrb8SNBaZ6
	tBTE0wMSrNvpziT4/5i3Kp1+u3VN+BAnzDxzg1Ekj7bhdqo4RJGZVMXc0ftS9zJQbBOGyiOoq4e
	V1okoetBLFTBYaG3QvTUyUFj5Dyse1N5KPScf9eb/4VhKecwIzP+eswlZX4jCXcGZtjYwgU3EEA
	oXXoJA6EEDugVRDls2j7e6XwuRAR0TozKxxqEZ/3gVyAzyxaFVGfr6C4zGtOO27ujbFh0mvejKd
	iMkS343hbx70CGfgvGLAhcB/XhYd+4ZHEXd53B5Yqc9lHsubfrNqQbrYDJlvhwnDQilq0+eq/B3
	cbp68FhICFDFLO+JacAvuO0NHDyZr0fSiKqgJkKkES+dxCYYZlYU47NxW
X-Received: by 2002:a05:6a20:6a10:b0:38d:efca:1be3 with SMTP id adf61e73a8af0-3946c8bfed4mr12901156637.37.1771351804134;
        Tue, 17 Feb 2026 10:10:04 -0800 (PST)
X-Received: by 2002:a05:6a20:6a10:b0:38d:efca:1be3 with SMTP id adf61e73a8af0-3946c8bfed4mr12901116637.37.1771351803400;
        Tue, 17 Feb 2026 10:10:03 -0800 (PST)
Received: from [192.168.0.172] ([49.205.251.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e79efc83asm4004434a12.5.2026.02.17.10.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:10:03 -0800 (PST)
Message-ID: <ff6c4a6e-9478-46fe-b17c-5b4221f04b52@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 23:39:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
 <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
 <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
 <5170c5df-e22e-46c0-9713-3c4e7bbdbf63@oss.qualcomm.com>
 <logrdwafmqpfjoxyk7aqs3ahb2qhgqrtcxjkvtclxopkxqvrbh@q5zq46wxyrsq>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <logrdwafmqpfjoxyk7aqs3ahb2qhgqrtcxjkvtclxopkxqvrbh@q5zq46wxyrsq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX/hvNOtZ9vtV1
 lzQhT3Qd2bjhsUU8wsHloGgnIsIoN1P/yJmnZxyuIFiK0gzcou/3db/Jb47qa/wcmag3GfuJleN
 n5icBWJuRlOj/vT74j/9OpE7xXIG5EAIAXHEioQykFwG0dDhIaqBy38vTb54mG+I/eZrDybMMEH
 rGkRK+jnmP2V3spFPIOdvR9ckscouJnxppiw7O7alkd10ICEZmH57PLcwD7TfRzC7qysW+r3YMx
 BKl2QXFqrQmOTFDkcSR8C2RtStld9HkkNiLHkHnkFgojq8NTlxqixORzQxbG/3NgY3esmdGEHwn
 Rqfml2byfXyc7c2Nf3C9V/NF1vwFHAs5moNx0nz7el0+GxE4atR68cI2vwic6Dgcci8198Mle/e
 XnBZpFtiPDvsi6NM9OEgrdiSbL5NNUTqYcOM7gZIEDlBaSRwByUkYXU6N4qOHbUsaJw1AOMfzqi
 /S4N0zs1roRqOYSF0Ow==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=6994aefc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ExRUKzOVRX24zF/T6h5B5A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=CVEAFZvZQY1BmYoe21sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: mSlJDp8HeVfGnFeYk86vLRvDeg5b_T96
X-Proofpoint-ORIG-GUID: mSlJDp8HeVfGnFeYk86vLRvDeg5b_T96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170148


On 2/17/2026 9:45 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 09:04:52PM +0530, Vikash Garodia wrote:
>>
>> On 2/17/2026 8:06 PM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 17, 2026 at 07:13:39PM +0530, Vikash Garodia wrote:
>>>>
>>>> On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
>>>>>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>>>>>> compared to previous generation, iris3x, it has,
>>>>>> - separate power domains for stream and pixel processing hardware blocks
>>>>>>      (bse and vpp).
>>>>>> - additional power domain for apv codec.
>>>>>> - power domains for individual pipes (VPPx).
>>>>>> - different clocks and reset lines.
>>>>>>
>>>>>> iommu-map include all the different stream-ids which can be possibly
>>>>>> generated by vpu4 hardware.
>>>>>
>>>>> It's not how it can be defined.
>>>>
>>>> Do you mean to elaborate the different entries within iommu-map or to
>>>> elaborate the different stream ids and how they are grouped into different
>>>> functions ?
>>>
>>> The comment was sent three weeks ago.
>>
>> yeah, if you could still recollect, you can comment.
> 
> I think it was more about 'stream IDs for pixel, secure, no-pixel,
> firmware, buffers, non-buffers and direct insight into the VPU memory'
> (pure example, as you can guess).
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
>>>>>>     1 file changed, 234 insertions(+)
>>>>>>
>>>>>> +
>>>>>> +  iommu-map: true
>>>>>
>>>>> This is totally underspecifified.
>>>>
>>>> oneof would be a better approach describing the possible stream-ids.
>>>
>>> oneOf of what? It is items with the definition of each item.
>>
>> something like below,
>>
>> properties:
>>    iommu-map:
>>      description: |
>>        List of IOMMU stream IDs corresponding to hardware function IDs.
>>        The number of entries depends on the SoC variant.
> 
> Do we again have a story of variable number of entries for the single
> Kaanapali platform?

its for firmware stream-ID, which can be managed by kernel or Gunyah. 
Handling for it now would ensure we do not have to change the binding 
later when there is a need.

> 
>>      type: array
>>      oneOf:
>>        - minItems: 8
>>          maxItems: 8
>>          items:
>>            type: integer
>>            description: IOMMU stream IDs
>>
>>        - minItems: 9
>>          maxItems: 9
>>          items:
>>            type: integer
>>            description: IOMMU stream IDs
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +  memory-region:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>
>>>>>> +
>>>>>> +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
>>>>>> +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
>>>>>> +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
>>>>>> +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
>>>>>> +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
>>>>>> +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
>>>>>> +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
>>>>>> +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
>>>>>> +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
>>>>>
>>>>> #define the functions in the ABI, provide them in the bindings.
>>>>
>>>> Ack. will introduce a new header at [1] and define these functions
>>>>
>>>> [1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media
>>>>
>>>> Regards,
>>>> Vikash
>>>>
>>>>>
>>>>>> +
>>>>>
>>>>
>>>
>>
> 

