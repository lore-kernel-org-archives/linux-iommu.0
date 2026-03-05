Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA83043C8
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746457; cv=none; b=M5Jp0chhMiYTwqJp9mZ0pRRL1fH4Dbc4BW4mVLE3HcN4jz3l5FdYJ6bq1G0PmJQb+K9ETtM/o2YbNcEkpm/2hN6WL38ibstvDOotDT8ypIAf2gzc3GteiSH8WEYqkVsIVkehMlwJDSPXVFRQ0RQRka0naQomu/DRZYChmUmVZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746457; c=relaxed/simple;
	bh=izspOewSD+rzK6gzcyMrJuU1hJl79nV883UHeDXXIu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sq9xRnkM98PCboxOGwy00WkacXVA0omz13BH3RD5diwbIAf6Iu/wVBvezTsm70902ZnyBmlrihbp9azjt9jlLX41WjOg2pwNovah/N2+rfYzELH6QVYX0Qe+csfStJNuNZWWKyWfdoAQuQipEeCPZmR/I3C+54WhUMpuhs5oX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfbPP1y8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rh1E20mX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfbPP1y8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rh1E20mX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KnYOT2889249
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 21:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EECIVVNEFVIqIvwb9AEZld4QkiX2dWpPAnCojaqO0e0=; b=JfbPP1y82YuVskY7
	pp4PT8DYH1AS9KqJt+pwkshqozU/qdRKJ/zFYcRLxsEUaAdhxCF3BpLwq7K5WMDt
	+JVvkm2i27In2Y//wWaI9LVTfi4HHuZSjw9GIJL2NE7ERCIVno+TsF/Wv7EyLjcI
	yqOK+NkL8xeg45+2UCG0k6UulQhhR5Xd1ony4qasoGNQhIJLf0rcGNZJsbl2rsx+
	lFNQ5+igJsIxQcrNb5/T9yIMt706f9H3cgACacsmVL1lAdqbt8hEbInWVxfhyENe
	YuWYkm2o9i15nvgHiD33ZDNx1RZAMjFUvJ3DesB4aCenqZA+8Vuw3n8ty58DXHhe
	fgbjgQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuptmhd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 21:34:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c737882b2easo1298630a12.0
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 13:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772746454; x=1773351254; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EECIVVNEFVIqIvwb9AEZld4QkiX2dWpPAnCojaqO0e0=;
        b=Rh1E20mXtzHbNIYEvIcWsDWS3+/ysKPXZ67JzrDaO/N4CcIP1PZ4VrTv8AMXdbUkw7
         p2TmJTp1nposcXHK/LTkzHpWlLUz/uqtiANfbzO2bcU8C/kXi3GjnXBj8lQndsEkv1k1
         PzbyRr5gGRhEd1qpdjs3RKLi3or8jMkHX5F83FO51qNDgYyQSl+swmexW0rf/PYqNXia
         jptIADY2sD+OFEtYy0oVwslYCcmVB2hGbuy2/N7/YZ7Ip/Ra3OHogDwH64SG8mRr4XeH
         gvTc9b6BOubyb/IB3DwpnWJrLQOd9hyOCWRxSlftH4tYu2DozAgH+AUonHjN+rEUJAi4
         dgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772746454; x=1773351254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EECIVVNEFVIqIvwb9AEZld4QkiX2dWpPAnCojaqO0e0=;
        b=AB2kqZUlYQxUY7BXBfx9af9OguxM+aV3AJ57x0ACZk7Yj/3nEqs7u9YtbO/Szah6Od
         OsMix9QMkgEn1m8onNAP/unZsGVOuLLU3OnGPa+/rvu8b6efP5B5rkVs5zofylQSEE7Z
         HBMuBKvgw0aQcQRvhlFAZMULybNLQPA6XSLsjs2ClcQ9I3QYoEwePMDRlKHrq4uG7GSC
         KvdTouQib9bpzijpFlbN2/4BfwstK70lyZwhvvLQJHvYhveA3m1KVNB3PI5cnklj+mQg
         05w3w37p9NovU3wy6DTr3D96eYl9d6q3guhpb9/k4KjALriD/y2uaOM5Egq10Ygu0BiE
         bYRA==
X-Forwarded-Encrypted: i=1; AJvYcCWOYgZCsERTZ65elq0g0/Vk/O8QK0RPUG3OEpNizj2iiq1FEGT0sI7L6z0ITuuBUD2DEa37uA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf8TyZtMjc4KOxq4ZMiTHj97qt4FV5aM4q52XtzuwoiHFxrisO
	0XgH4pAa3SgSwUiEIWZ+0A7xjLuOiCvRK3s3g8vj8Si4flwbWUwKPKT8cOZQbRFf5a9rtC1a3EE
	NBEaCc0rTRnqJ6HuwJ5fwRLaY2p7t04lzgQALUWE4Dffg6K13Xs2llH3T8w==
X-Gm-Gg: ATEYQzzeSxlB2q7oTbdNRd3vVdMEv2FxkAX2129VxdJXoFrM7JrYoGaoZeiNdu1kq20
	c9XJ+oD+y3ClhajanB3Pd2yJbVkNOvVu4dlafjGpH1qgmM0flFnJj/2998J6tMQH94+CxsOOwvX
	nZb0TlTc9crf2E6VpiZmIgMigaYXaImmHqpIw0L6H9ZneipBjc7UZCUc4qt0FVWk6z//bas373h
	UeMiaoIPY2PcNqYjLhcD3g4IP1MNNHsSsCt7WYqdxIiNB7+2PCN4kD43PQ7e6ro5ZlcHIV7g3f5
	m704Yc4S0KiPO9SGShI3x4KKR0JA6jeAG/HSpHjV22Uigdhkxu8VpQxXpzxBCNZASfcGm8L7pZe
	sQYtvC+idgz4LrHSpvYzpal3/yriZxD0MMc9xnlfDehXct/ZY92PUATc=
X-Received: by 2002:a05:6a00:ab8a:b0:824:ab8d:6f9e with SMTP id d2e1a72fcca58-8299aacabe1mr1054993b3a.29.1772746454147;
        Thu, 05 Mar 2026 13:34:14 -0800 (PST)
X-Received: by 2002:a05:6a00:ab8a:b0:824:ab8d:6f9e with SMTP id d2e1a72fcca58-8299aacabe1mr1054953b3a.29.1772746453621;
        Thu, 05 Mar 2026 13:34:13 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82976924148sm4978756b3a.2.2026.03.05.13.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 13:34:13 -0800 (PST)
Message-ID: <9d5aab4c-86be-46cb-8c2c-154f87e3eeba@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 03:04:04 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
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
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
 <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
 <vi5v5bczg2wx2adfpr6ppqcad76oecitoyc7zd2i4lahla4buw@mqnppboxcyrs>
 <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
 <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
 <1d2b55d9-42e3-4459-971b-e276a87fb843@oss.qualcomm.com>
 <7wvdcjajf7ro3c4y7jq6tmbxfg7kfvdpmyfzqm4vgjw5wly4zu@jcjqudf7vrgd>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <7wvdcjajf7ro3c4y7jq6tmbxfg7kfvdpmyfzqm4vgjw5wly4zu@jcjqudf7vrgd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4MyBTYWx0ZWRfX9R3G6fK6Mhbr
 Vm4voYAyr2i3fIDEodk4P0oQYU+IoVclORqeJ13BshFZWnBSxkJCp7AyXWXVl2DBly5zk3js+Q8
 HKiA0OU7/hw8uqNsdcBOI8R68BweV+3xA+mUFEZ9IBzdR0ektY96usD2qoHqIu6ZVasM4OszM+2
 5g+lzKsWJk8E2NQfupLQZ6ZNMBz4A41ywZZsd3sT4wnpbEeK2aaKMjZUc3tFnNWN7hMNy1toF0W
 MdzdGBPaDNIiW5CR5Jv51CCyHSxgOXrMe0CT9Bwa0MgyOrrSY/ZLR/adMGJ0yZ+LHf9DkYK6A04
 g+p2j5LsDcE6Y/Q4tscKHqvdLjBp0aBQ2h5mu73y7giTd44uveRxRSL+aPzXOtSi1BX681apv64
 08qFL6zNo3SFVudMNL7vlY7E5BwzrwdCmToGxn/p2Lnc8cRh6yHghsh0vwm9avt5Yy+QqAwBaqa
 bizQx9wWDDfXeJrJtUA==
X-Proofpoint-ORIG-GUID: UaZMpMTu7awX-IkKjm69i8MbYynL9P7C
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a9f6d6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=81ZJZswdUCIGFlR35D8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: UaZMpMTu7awX-IkKjm69i8MbYynL9P7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050183


On 3/6/2026 12:02 AM, Dmitry Baryshkov wrote:
> On Thu, Mar 05, 2026 at 10:56:40PM +0530, Vikash Garodia wrote:
>>
>> On 3/5/2026 7:51 PM, Dmitry Baryshkov wrote:
>>> On Thu, Mar 05, 2026 at 06:19:52PM +0530, Vikash Garodia wrote:
>>>>
>>>> On 3/4/2026 3:55 AM, Dmitry Baryshkov wrote:
>>>>> On Wed, Mar 04, 2026 at 12:16:50AM +0530, Vikash Garodia wrote:
>>>>>>
>>>>>> On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
>>>>>>> On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
>>>>>>>> Introduce different context banks(CB) and the associated buffer region.
>>>>>>>> Different stream IDs from VPU would be associated to one of these CB.
>>>>>>>> Multiple CBs are needed to increase the IOVA for the video usecases like
>>>>>>>> higher concurrent sessions.
>>>>>>>>
>>>>>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
>>>>>>>>      drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
>>>>>>>>      drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
>>>>>>>>      drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
>>>>>>>>      4 files changed, 111 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>>>> index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
>>>>>>>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>>>>>> @@ -204,6 +204,22 @@ struct icc_vote_data {
>>>>>>>>      	u32 fps;
>>>>>>>>      };
>>>>>>>> +enum iris_buffer_region {
>>>>>>>> +	IRIS_BITSTREAM_REGION		= BIT(0),
>>>>>>>> +	IRIS_NON_PIXEL_REGION		= BIT(1),
>>>>>>>> +	IRIS_PIXEL_REGION		= BIT(2),
>>>>>>>> +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
>>>>>>>> +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
>>>>>>>> +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
>>>>>>>
>>>>>>> Can a context bank belong to multiple regions at the same time?
>>>>>>
>>>>>> yes, they would.
>>>>>
>>>>> How? Each set of CBs is defined by a separate function in the DT. How
>>>>> can CB belong to multiple regions? Could you please provide an example?
>>>>
>>>> SM8550 would have same stream id for VPU hardwares (tensilica and vcodec)
>>>> accessing bitstream and non pixel regions. Thereby non_pixel and bitstream
>>>> regions would map to one CB.
>>>
>>> In my opinion it means only one thing: you will have two CBs (one for
>>> non_pixel and one for bitstream) having the same SIDs. An alternative
>>> would be to define fallback rules (if CB foo doesn't exist, use CB bar).
>>>
>>>> While kaanapali would have different stream id for tensilica accessing non
>>>> pixel region and vcodec accessing bitstream region, thereby having different
>>>> CB.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct iris_context_bank {
>>>>>>>> +	struct device *dev;
>>>>>>>
>>>>>>> Separate data and the actual device. Define a wrapper around struct
>>>>>>> device for the actual runtime usage.
>>>>>>
>>>>>> we still have to store the list of dynamically created device. Name can be
>>>>>> used to fetch the device from the list, i think the existing approach is
>>>>>> simpler ?
>>>>>
>>>>> You don't need a list. You have an array of the size, which is known and
>>>>> fixed. You have at most 9 functions, which means less than 9 devices.
>>>>>
>>>>
>>>> as mentioned above, its not the same for all platforms to have one to one
>>>> mapping between CBs and buffer region. Thereby indexing based on array would
>>>> be an issue here
>>>> It would end up something like this, considering [dev region] array,
>>>>
>>>> SM8550
>>>> non_pixel_device  non_pixel_region
>>>> non_pixel_device  bitstream_region
>>>> pixel_device      pixel_region
>>>>
>>>> kaanapali
>>>> non_pixel_device  non_pixel_region
>>>> bitstream_device  bitstream_region
>>>> pixel_device      pixel_region
>>>
>>> I'm sorry, I'm not sure I follow here. Could you please explain? Maybe
>>> by explititly mapping DT function values to iris_buffer_region values?
>>>
>>
>> Kaanapali
>> IRIS_BITSTREAM IRIS_BITSTREAM_REGION
>> IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION	
>> IRIS_PIXEL     IRIS_PIXEL_REGION
>>
>> SM8550
>> IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION | IRIS_BITSTREAM_REGION
>> IRIS_PIXEL     IRIS_PIXEL_REGION
> 
> So, why not:
> 
> Kaanapali:
> 
> iris_cb_dev_bs = iris_cb_dev_alloc(IRIS_BITSTREAM];
> iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
> iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];
> 
> core->cb_devs = {
> 	[IRIS_BITSTREAM_REGION] = iris_cb_dev_bs,
> 	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
> 	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
> };
> 
> SM8550:
> 
> iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
> iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];
> 
> core->cb_devs = {
> 	[IRIS_BITSTREAM_REGION] = iris_cb_dev_np,
> 	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
> 	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
> };
> 
> 
> Yes, it would require coding of those functions, however afterwards you
> can access necessary CB device simply by doing core->cb_devs[region].
> 
> I think current code is overcomplicated for the sake of having the
> platform flexibility expressed as data.
> 
>>
>>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>>> +	const char *name;
>>>>>>>> +	const u32 f_id;
>>>>>>>> +	const enum iris_buffer_region region;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>      enum platform_pm_domain_type {
>>>>>>>>      	IRIS_CTRL_POWER_DOMAIN,
>>>>>>>>      	IRIS_HW_POWER_DOMAIN,
>>>>>>>> @@ -246,6 +262,8 @@ struct iris_platform_data {
>>>>>>>>      	u32 inst_fw_caps_enc_size;
>>>>>>>>      	const struct tz_cp_config *tz_cp_config_data;
>>>>>>>>      	u32 tz_cp_config_data_size;
>>>>>>>> +	struct iris_context_bank *cb_data;
>>>>>>>> +	u32 cb_data_size;
>>>>>>>
>>>>>>> Do they differ from platform to platform?
>>>>>> Yes
>>>>>>
>>>>>>> Mark them as const, it should be data only.
>>>>>>
>>>>>> cb_data_size can be marked as const
>>>>>
>>>>> Why is cb_data non-const?
>>>>
>>>> dev is being updated once created dynamically.
>>>
>>> That's a bad idea. Please make the platform description constant.
>>>
>>
>> I can give it a try to move CBs in core struct out of platform data and have
>> a buffer region based lookup array to fetch the device.
> 
> It might be easier to express that as a callback, filling core->cb_devs
> with struct device pointers, as I wrote above.

IIUC, introduce an ops like below and fill ore->cb_devs[] in SOC 
specific data i.e sm8550_data ?

struct iris_platform_ops {
     int (*populate_cb_devs)(struct iris_core *core);
};
struct iris_platform_data {
     const struct iris_platform_ops *ops;
     /* ... other pdata fields ... */
};

At present lemans shares the platform data of sm8550, with the above ops 
approach, that commonality leverage would be lost ?

Please correct if your proposal is different than what i interpreted.

> 
>>
>> Regards,
>> Vikash
> 

