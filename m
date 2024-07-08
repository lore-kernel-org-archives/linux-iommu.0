Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9E15278A
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480347; cv=none; b=C2fZpN//1SBL79Lkw0zew9cF9OOmNCM8YV4MnshTeZMWypOC0lJy++JLggvXLH/Js3yNjdk9LlxBaVc9eYRjrO3RQh/DE0gamdSbOuAhZJ6JihWRHx1LsdE4f55rFvZRTHb59OoUhl77LylL6b/5Ah9ZCcuPz/cKXZX0ppqza/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480347; c=relaxed/simple;
	bh=BISu561XaqaS73lLlr/pnn5/D8DLdwmzLuPcDAU7xQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I/zcR8q3mXGi51G0URUKgOLsIFvn480b00ovgWt6LsyQwW90sUtyhm1vtdCIJK0TAa7Vmg4mj7+Ao3fKJ2kXBqnnU1UsIeml5+GAvdP6j0hY2qqZ4c1o83aaBMDEDIBgmPMLfinJzD8h2EhJSfVwD5TTGnTBoOeLgjLzBy3GO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WoiyTUgC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WoiyTUgC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468CIbt9001981;
	Mon, 8 Jul 2024 23:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BISu561XaqaS73lLlr/pnn5/D8DLdwmzLuPcDAU7xQI=; b=WoiyTUgCe4pgtBBx
	wwI5FlW+OviF3p28AkQYGuaEqio6MXvU04VvoLrOrkuAZ+DHLo7ciDOKHbai9F49
	jKbgivRmikW15PB0afq4jBsQI1SwcdprErd/ZIHqwFesRca+d0Z4YGal8HKtlpvT
	kiCJbYtTbrvOO//dS6rg0CaOeYG7xEmS/huAa0kP9iHj0ex9++bL0Kkc2JNEACuk
	FdvuCLwc0UbB9/GWvjrEPI8930iLehQOe+t+h6AgExavNSvtzvIVbKbLOB2NFcMN
	nDEAHHEDtuyRdADLNeAqys6+ZGgEsBcWizSC0HD9g0jpOj1Q4PmqiBYmAKEBXTTr
	zaUAXw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8vt9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:12:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468NCHC6002711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:12:17 GMT
Received: from [10.71.109.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:12:14 -0700
Message-ID: <1684910a-54e2-4df5-a076-de9c2de4277b@quicinc.com>
Date: Mon, 8 Jul 2024 16:12:14 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] of: reserved_mem: Use unflatten_devicetree APIs to
 scan reserved memory nodes
To: Klara Modin <klarasmodin@gmail.com>, <robh@kernel.org>,
        <saravanak@google.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-4-quic_obabatun@quicinc.com>
 <986361f4-f000-4129-8214-39f2fb4a90da@gmail.com>
 <4905e651-4c37-4fb4-bbc1-af9633013134@gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <4905e651-4c37-4fb4-bbc1-af9633013134@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sVObgekRJKzxlI1ommYcx36POJ6qF7wy
X-Proofpoint-GUID: sVObgekRJKzxlI1ommYcx36POJ6qF7wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407080172


On 7/5/2024 8:38 AM, Klara Modin wrote:
> On 2024-07-05 15:05, Klara Modin wrote:
>> Hi,
>>
>> On 2024-05-29 00:36, Oreoluwa Babatunde wrote:
>>> The unflatten_devicetree APIs have been setup and are available to be
>>> used by the time the fdt_init_reserved_mem() function is called.
>>> Since the unflatten_devicetree APIs are a more efficient way of scanning
>>> through the DT nodes, switch to using these APIs to facilitate the rest
>>> of the reserved memory processing.
>>
>> With this patch series, I've observed significantly less memory available to userspace on my Raspberry Pi 1 and 3.
>>
>> I see this message on the kernel console:
>> Jul  4 23:13:49 bonnet kernel: OF: reserved mem: 0x1b000000..0x1effffff (65536 KiB) map non-reusable linux
>>
>> where it was previously marked as reusable:
>> Jul  4 22:23:22 bonnet kernel: OF: reserved mem: 0x1b000000..0x1effffff (65536 KiB) map reusable linux,cma
>>
>> If I look at bcm283x.dtsi, it definitely has the reusable property.
>>
>> I've below pointed out the snippet I think could be suspicous.
>>
>>>
>>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>>> ---
>>>   drivers/of/of_reserved_mem.c    | 93 ++++++++++++++++++++-------------
>>>   include/linux/of_reserved_mem.h |  2 +-
>>>   kernel/dma/coherent.c           | 10 ++--
>>>   kernel/dma/contiguous.c         |  8 +--
>>>   kernel/dma/swiotlb.c            | 10 ++--
>>>   5 files changed, 72 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>>> index 113d593ea031..05283cd24c3b 100644
>>> --- a/drivers/of/of_reserved_mem.c
>>> +++ b/drivers/of/of_reserved_mem.c
>
>>> @@ -447,7 +476,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>>                  uname, (unsigned long)(size / SZ_1M));
>>>           return -ENOMEM;
>>>       }
>>
>>
>>> -    fdt_reserved_mem_save_node(node, uname, base, size);
>>> +    fdt_reserved_mem_save_node(NULL, uname, base, size);
>>
>> This could perhaps be suspicious?
>>
>> The above message seems to come from of_init_reserved_mem_node when
>> called from of_reserved_mem_save_node when called from here. This would mean that the node is not actually saved to rmem and thus not marked reusable?
>>
>>
>>>       return 0;
>>>   }
>
>>
>> Regards,
>> Klara Modin
>
> Attaching kernel logs of old and new behavior, and my config for reference.
Hi Klara,

Thanks for pointing this out. I have uploaded a fix here:
https://lore.kernel.org/all/20240708230613.448846-1-quic_obabatun@quicinc.com/

Please test and see if this fixes the issue.

Thank you!
Oreoluwa
