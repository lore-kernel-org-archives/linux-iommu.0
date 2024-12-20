Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58B800
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665123; cv=none; b=bC1VB3u5N07I0TBL1b5Ddx+zUL652M2ZPzosrPGYFIPJGKJccP0OxN55utOl7ZrchV1RxunUWVWwo25TX712fsv2Os0rxiujaaa6pe5EeNgoQ1Y0l2Wb76cQvxE3r921xlxK9VwN/Z7bosi38Nfn6AuTPFYJJ1NVlvb+V8J7lsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665123; c=relaxed/simple;
	bh=mXqpACW0Is0siC0x76jS4ErttihxUNHGHthaosZ0BzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bk6xYYzwdJYnz2q1lBxpx0UNHXWHflzpZ2C8ezOsc8D8EOtN2eyC0zCMNQwTMAsxWip8p8d5H/Av5T9af2Fkn7Z88rjL13QO+9EmBQNLedK3R7DTnBf+8eyw89Cd0HELYkXcSxwRBFovbFAJKWWFjpcykLK72KrSragPuffIXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WvYLq43C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WvYLq43C"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGf3Jk004850;
	Fri, 20 Dec 2024 03:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t44tqeNZ4U0n2YMI++gJ2pQRniX4dtR6ON0GaJUwvcw=; b=WvYLq43ChB33lkCa
	JW5aGJw4CTDp9qx6Wz+L36PGRXsrq+Rvz6gFIneGBN+iQHoeeD9UGSHqlZRrrBYr
	BzmKC4pojtFcmbI6eMLMVxnHZFMhVVhHAs85UgKSeL/upspX/VJ+ZjNcv3j1Kzuq
	C3geeJU4/S8QrjEJPwuKJgWZvgdwwQ7oWqyCz80lBNHNVeXTOl6yq+aAheKYHvRJ
	6+FxYARSQtlLT5K9TtdMdxOxuHEfqkz6HTE1k7HkWYIMi4G80EUEaEFCpGGYfOL7
	0LugKglh1YF78hRggwol4ePhglVd3Toyukh6rMCnTButDzp2b3txqD0ZN52V5DOy
	LmH7kQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mq7fs9ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 03:25:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BK3PGDc032025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 03:25:16 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 19:25:14 -0800
Message-ID: <b84c1485-de8f-4888-bed6-3690ed108a46@quicinc.com>
Date: Fri, 20 Dec 2024 11:25:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: missing clear bdr in check_ram_in_range_map()?
To: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy
	<robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
 <20241212071418.GA6638@lst.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20241212071418.GA6638@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TQKRjCrGdv8R-mWoFIVOKcYW02YMPDbs
X-Proofpoint-ORIG-GUID: TQKRjCrGdv8R-mWoFIVOKcYW02YMPDbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200027



On 12/12/2024 3:14 PM, Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 06:50:06PM +0800, Baochen Qiang wrote:
>> Hi,
>>
>> while checking check_ram_in_range_map() I am confused by the condition set/check on bdr.
>> If I am reading the code correctly, if bdr is set once, it would never get cleared, hence
>> that function will always returns 0.
>>
>> should we clear bdr before each new iteration?
> 
> I think so.  Even better refactor the code so that the non-NULL bdr
> doesn't leak out:
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5b4e6d3bf7bc..181e244f410a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>  }
>  
> +static const struct bus_dma_region *dma_find_range(struct device *dev,
> +		unsigned long start_pfn)
> +{
> +	const struct bus_dma_region *m;
> +
> +	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> +		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +
> +		if (start_pfn >= cpu_start_pfn &&
> +		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
> +			return m;
> +	}
> +
> +	return NULL;
> +}
> +
>  /*
>   * To check whether all ram resource ranges are covered by dma range map
>   * Returns 0 when further check is needed
> @@ -593,23 +609,14 @@ static int check_ram_in_range_map(unsigned long start_pfn,
>  				  unsigned long nr_pages, void *data)
>  {
>  	unsigned long end_pfn = start_pfn + nr_pages;
> -	const struct bus_dma_region *bdr = NULL;
> -	const struct bus_dma_region *m;
>  	struct device *dev = data;
>  
>  	while (start_pfn < end_pfn) {
> -		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> -			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +		const struct bus_dma_region *bdr;
>  
> -			if (start_pfn >= cpu_start_pfn &&
> -			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
> -				bdr = m;
> -				break;
> -			}
> -		}
> +		bdr = dma_find_range(dev, start_pfn);
>  		if (!bdr)
>  			return 1;
> -
>  		start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
>  	}
>  

looks better. thanks for reply.

