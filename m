Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA67BA42;
	Sat, 29 Jun 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719629279; cv=none; b=IpiDIk8Bx8syGbssLSsuIB3JQWEF1NYH3oHKbYjPOebKBJqs4DYrczpfRV/ewxNhEO3iMhn3GNJrxc6bAoCexVTcAPwb9khdtMvuSqrcvSxkcJqrA24xVMOElfq7wCJom5EPg90aEjHHVpIT5993sn5akJjY9tPucOyGAGTkYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719629279; c=relaxed/simple;
	bh=G/rZRZuq+NDa8PPWRVFnaPLfugQlaUmG1poh96Mq6nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j2YD9e6/MyoGSbbbOGp6yioer7NknaSOL2z/kGqikbPhTQtcSE0ux3ojcVnfpRf0Ihw7AKxAVsiexwT7aQsD3O7KXw09fr6M/ecsPgj5FjGroBUHuUlimdOs+Gf+rXmQf4YyCKxUB6ooCIni3anbb7RnSSgbdjl8nuamLBTMcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JOvDMPU8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JOvDMPU8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SGXijw023204;
	Sat, 29 Jun 2024 02:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DU2WtQjlnpEMUUXtKMuqvJ/EFIzd9Ynf5BWesHJWz2Q=; b=JOvDMPU83f4gzV/z
	Uf9js+teKbn8PWFdE8rk627jAOI0cwKAdHKiBz03ZTr3KyRAJJRAn+V9XIucAdey
	tkjWZM1Yjg8h8lDZyEy/K/nrWb+Ib/PjU3fMCAtVfc6xqdN8qfZAKe0vlqxnjKhP
	zKfiyssaMH3ma/jzrY60Ash+uxb1e4lSn5qVJMhi0UsgvJZVx0Y7Zj3oR6r8r269
	o3i/oBSWqC66k4uV7sHmBkSZcSUBl8scGSZ36JnKIEtQuLP5buiyZ/ImgFvZu4wI
	YdCXRjQ6EYiyrQfa07pm7jFJcgKgnk1Me9rGqHj1ZSMe9D/OW+Q0avL204MUROAQ
	e13J5A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywpu1h9un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:47:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T2lkQs031776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:47:46 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 19:47:46 -0700
Message-ID: <be5368da-a1fd-40bb-bfc5-eb899d28c39c@quicinc.com>
Date: Fri, 28 Jun 2024 19:47:45 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
 <20240619163446.GM791043@ziepe.ca>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240619163446.GM791043@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2WSLV04BDE3qvvokSS39M6NpDTqcvlJg
X-Proofpoint-ORIG-GUID: 2WSLV04BDE3qvvokSS39M6NpDTqcvlJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=929 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290020

On 6/19/2024 9:34 AM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2024 at 12:44:17PM -0700, Jeff Johnson wrote:
>> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.o
> 
> Weird I never saw that..
> 
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Fixes: da55da5a42d4 ("iommu/arm-smmu-v3: Make the kunit into a module")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

