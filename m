Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1213BAE2
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035750; cv=none; b=OcXxgj2TJXRzOThvRWFtHLzfos1qJk7zu9AUniOCrKZUnSwD0UGxvgVBjFPMh+7ED6uHL3+6DEqicwdGP2fVaqlsYBVWyljlpyJ7hTqYT7ENpxYna4cnJy6brBBZwL1GkWArHriOkdCAHXiR27HB3Hk7bpu1txyOkrLq2Jfk1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035750; c=relaxed/simple;
	bh=rgX8SAslmVIKpEMoWAeWNHrbuviZUn9GPTO/3yea1tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lXBVjMGALCR3ynWEHejoPbxgRI2e48SKCXseDcfPzo6lKzc9QRfdaUHiixdu/gQyDw0BvSmyI6XIVpLuCjoMEnqtw7AQcwt3HuhcVeD8N88qIp6HhRMgaYvzb0glkjFBHgB0D+lVeJkKxLmRVLO0OL8kD/rbnRyj/p0pK4MeA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i+md4WnA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i+md4WnA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UGHBPg028956;
	Fri, 30 Aug 2024 16:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+3jUVHCU8Z6xeBgVwpy69fXyaiHuZQoYJBZ0GepdZzw=; b=i+md4WnAbwS2YHOf
	7otXOJtq3A8XLxV05jC4Uf0dX+cN9G0iGJ7cZ9AY4py06mUjJBIT5lCaxUSDmAvP
	B6QnNT4qtNqwE9klx57IGUpJ6oTrepQ9lIGrnlrq7OjJZK2FvzYUZcjkTArLpO8O
	rvVjz+gKYU0pVT74xaw2lKpd6euPtJ/ndnKl7HVUblomKQWiSJghhHo8khUd3vQ6
	NWhsdgxb0a4mVHCgRuhGe365anQyL2aU16OFgKLCvqfRIUTvqNlNUATFmMMU15er
	cOWle63Rptl2J2dUPz9D8LDTupXrrhPESd5sKOHmuuRv90nGTtCTV5M8P9NDUNA3
	buySjg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41ax4mk8aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:35:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UGZcF5019043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:35:38 GMT
Received: from [10.110.11.12] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 09:35:35 -0700
Message-ID: <6408bb64-4ab7-4d46-9c15-d7eddc9d4e39@quicinc.com>
Date: Fri, 30 Aug 2024 09:35:29 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Dynamic Allocation of the reserved_mem array
To: Andy Shevchenko <andy@black.fi.intel.com>
CC: <robh@kernel.org>, <saravanak@google.com>, <klarasmodin@gmail.com>,
        <aisheng.dong@nxp.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <kernel@quicinc.com>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
 <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8OGfLwHxQzNOXyFcTrfSGvoGgJ59vzu8
X-Proofpoint-ORIG-GUID: 8OGfLwHxQzNOXyFcTrfSGvoGgJ59vzu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300127


On 8/19/2024 10:23 AM, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 11:48:12AM -0700, Oreoluwa Babatunde wrote:
>> The reserved_mem array is used to store data for the different
>> reserved memory regions defined in the DT of a device.  The array
>> stores information such as region name, node reference, start-address,
>> and size of the different reserved memory regions.
>>
>> The array is currently statically allocated with a size of
>> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
>> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
>> will not have enough space to store the information for all the regions.
>>
>> This can be fixed by making the reserved_mem array a dynamically sized
>> array which is allocated using memblock_alloc() based on the exact
>> number of reserved memory regions defined in the DT.
>>
>> On architectures such as arm64, memblock allocated memory is not
>> writable until after the page tables have been setup.
>> This is an issue because the current implementation initializes the
>> reserved memory regions and stores their information in the array before
>> the page tables are setup. Hence, dynamically allocating the
>> reserved_mem array and attempting to write information to it at this
>> point will fail.
>>
>> Therefore, the allocation of the reserved_mem array will need to be done
>> after the page tables have been setup, which means that the reserved
>> memory regions will also need to wait until after the page tables have
>> been setup to be stored in the array.
>>
>> When processing the reserved memory regions defined in the DT, these
>> regions are marked as reserved by calling memblock_reserve(base, size).
>> Where:  base = base address of the reserved region.
>> 	size = the size of the reserved memory region.
>>
>> Depending on if that region is defined using the "no-map" property,
>> memblock_mark_nomap(base, size) is also called.
>>
>> The "no-map" property is used to indicate to the operating system that a
>> mapping of the specified region must NOT be created. This also means
>> that no access (including speculative accesses) is allowed on this
>> region of memory except when it is coming from the device driver that
>> this region of memory is being reserved for.[1]
>>
>> Therefore, it is important to call memblock_reserve() and
>> memblock_mark_nomap() on all the reserved memory regions before the
>> system sets up the page tables so that the system does not unknowingly
>> include any of the no-map reserved memory regions in the memory map.
>>
>> There are two ways to define how/where a reserved memory region is
>> placed in memory:
>> i) Statically-placed reserved memory regions
>> i.e. regions defined with a set start address and size using the
>>      "reg" property in the DT.
>> ii) Dynamically-placed reserved memory regions.
>> i.e. regions defined by specifying a range of addresses where they can
>>      be placed in memory using the "alloc_ranges" and "size" properties
>>      in the DT.
>>
>> The dynamically-placed reserved memory regions get assigned a start
>> address only at runtime. And this needs to  be done before the page
>> tables are setup so that memblock_reserve() and memblock_mark_nomap()
>> can be called on the allocated region as explained above.
>> Since the dynamically allocated reserved_mem array can only be
>> available after the page tables have been setup, the information for
>> the dynamically-placed reserved memory regions needs to be stored
>> somewhere temporarily until the reserved_mem array is available.
>>
>> Therefore, this series makes use of a temporary static array to store
>> the information of the dynamically-placed reserved memory regions until
>> the reserved_mem array is allocated.
>> Once the reserved_mem array is available, the information is copied over
>> from the temporary array into the reserved_mem array, and the memory for
>> the temporary array is freed back to the system.
>>
>> The information for the statically-placed reserved memory regions does
>> not need to be stored in a temporary array because their starting
>> address is already stored in the devicetree.
>> Once the reserved_mem array is allocated, the information for the
>> statically-placed reserved memory regions is added to the array.
>>
>> Note:
>> Because of the use of a temporary array to store the information of the
>> dynamically-placed reserved memory regions, there still exists a
>> limitation of 64 for this particular kind of reserved memory regions.
>> >From my observation, these regions are typically small in number and
>> hence I expect this to not be an issue for now.
>
> This series (in particular the first patch) broke boot on Intel Meteor
> Lake-P. Taking Linux next of 20240819 with these being reverted makes
> things work again.
>
> Taking into account bisectability issue (that's how I noticed the issue
> in the first place) I think it would be nice to have no such patches at
> all in the respective subsystem tree. On my side I may help with testing
> whatever solution or next version provides.
Hi Andy,

I have re-uploaded another version of my patches.
Please can you help test it on your platform to confirm
that the issue is no longer present?
https://lore.kernel.org/all/20240830162857.2821502-1-quic_obabatun@quicinc.com/

Thank you!
Oreoluwa
