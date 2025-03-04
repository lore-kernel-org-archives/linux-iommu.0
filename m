Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF81A260
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053559; cv=none; b=uWTGdNZAxny6ZiBa0vvOQlYv+gn6JZBepoHPxbSQEuhZ1eC06DFw/IjeH2b271+1yNUxn0/Pfz0lr0e2BCrTBbpnJPzsFEPsUukae2AK+hgCCOQeRgMOSR1k3PlDij4bUiZn98fTYrJNZcwSduSJ0pwQGezUSXDY8rP1kH1Wq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053559; c=relaxed/simple;
	bh=+eKW9YtFgqPdr8yCi7iqp1u4e74jYUkY3/atIlM+fck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UoeGBfvKGCjNfxie5pUvm2w0AV0jrwZ38Uxa/w2i7y1dsbQ73d4cUHAjvAAEjaSoJDKiS7jYNHerQ/Pq649r2M7eT0Hze5lGX/Xn4TkfF9iTauLQWC2JOBYX+6LQZLdZOK4oYdMKjbQSdJOGXwizCw7AsqXEjoAd9BMfkrhjsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qc/zYV5B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qc/zYV5B"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NXEna017316;
	Tue, 4 Mar 2025 01:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nNIHjfWsRbNt9JjstR0UJh4fwEbVP/kXISqApq2/zLo=; b=Qc/zYV5BF0oNrHey
	RDFFSJmR2u3gRBdO1xsniCstS/ND4oBiyZFWyHoo1vTYgZeDL7vND7qNF1RPg/kS
	Lg0B4ho/RQVxK0xtUZU5vvyTZ+nEyFJeS8YIA1e16/yFyXNmpOPFgmpUs9VX+dmv
	z/I4OnbS+JBcE1Zo+IMKObH1mon3uIudXo+7zQOaZE+Tdo8xvqFUyhgwzLZlQI4O
	l93hSGC9l8yeKXGYPAVVuwrOk9I8hhoVNqFgnxhFCnmBFYLtKy0pvL/EwIROql0u
	4gKGV+BHIovPcUcVxgGwe19WoyJqS9jHCb8FkMpWwCpGDef5QCdWiaaWcVTWrEBv
	/gPYPw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tg8vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 01:59:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5241xDke005908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 01:59:13 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 17:59:11 -0800
Message-ID: <83cec3f0-0c11-47bc-8a8d-517e2d0ead8c@quicinc.com>
Date: Tue, 4 Mar 2025 09:59:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: missing clear bdr in check_ram_in_range_map()?
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig
	<hch@lst.de>
CC: Robin Murphy <robin.murphy@arm.com>,
        linux-kernel
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
 <20241212071418.GA6638@lst.de>
 <CGME20241220032532eucas1p2fafa0cbfde87d8dae47caa42c45d7ae4@eucas1p2.samsung.com>
 <b84c1485-de8f-4888-bed6-3690ed108a46@quicinc.com>
 <8045065f-723a-4b1f-bd89-23a1ab98ec7a@samsung.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8045065f-723a-4b1f-bd89-23a1ab98ec7a@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c65e71 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=V9amP9qfx3iXDtfjYI0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CgvxSXCc-Vm78mo_N0ZBq14JihDr79wX
X-Proofpoint-GUID: CgvxSXCc-Vm78mo_N0ZBq14JihDr79wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040015



On 2/28/2025 9:22 PM, Marek Szyprowski wrote:
> Hi,
> 
> On 20.12.2024 04:25, Baochen Qiang wrote:
>> On 12/12/2024 3:14 PM, Christoph Hellwig wrote:
>>> On Mon, Dec 09, 2024 at 06:50:06PM +0800, Baochen Qiang wrote:
>>>> Hi,
>>>>
>>>> while checking check_ram_in_range_map() I am confused by the condition set/check on bdr.
>>>> If I am reading the code correctly, if bdr is set once, it would never get cleared, hence
>>>> that function will always returns 0.
>>>>
>>>> should we clear bdr before each new iteration?
>>> I think so.  Even better refactor the code so that the non-NULL bdr
>>> doesn't leak out:
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 5b4e6d3bf7bc..181e244f410a 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>>   	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>>>   }
>>>   
>>> +static const struct bus_dma_region *dma_find_range(struct device *dev,
>>> +		unsigned long start_pfn)
>>> +{
>>> +	const struct bus_dma_region *m;
>>> +
>>> +	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
>>> +		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
>>> +
>>> +		if (start_pfn >= cpu_start_pfn &&
>>> +		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
>>> +			return m;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>>   /*
>>>    * To check whether all ram resource ranges are covered by dma range map
>>>    * Returns 0 when further check is needed
>>> @@ -593,23 +609,14 @@ static int check_ram_in_range_map(unsigned long start_pfn,
>>>   				  unsigned long nr_pages, void *data)
>>>   {
>>>   	unsigned long end_pfn = start_pfn + nr_pages;
>>> -	const struct bus_dma_region *bdr = NULL;
>>> -	const struct bus_dma_region *m;
>>>   	struct device *dev = data;
>>>   
>>>   	while (start_pfn < end_pfn) {
>>> -		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
>>> -			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
>>> +		const struct bus_dma_region *bdr;
>>>   
>>> -			if (start_pfn >= cpu_start_pfn &&
>>> -			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
>>> -				bdr = m;
>>> -				break;
>>> -			}
>>> -		}
>>> +		bdr = dma_find_range(dev, start_pfn);
>>>   		if (!bdr)
>>>   			return 1;
>>> -
>>>   		start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
>>>   	}
>>>   
>> looks better. thanks for reply.
> 
> Could you send a formal patch with this fix, description and 
> 'Suggested-by: Christoph Hellwig' tag?

sure, will submit soon.

> 
> Best regards

