Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA32F50A
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ACL1gHnD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARAxs1k022888;
	Mon, 27 Nov 2023 13:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eaYDENFudgkNQ4NfcB5K66/PQg1e93ahVRYS/UHpGyY=;
 b=ACL1gHnDQj3KBNGmQt24cyCoSj/bzGr5xQgEK/1YzTw8qOr0Yf15CDRnPEJ3ZeCC2kpo
 Kdrwk2k/1ujuXTokLy87k7fRe2xDgM1Ii5trikrpy41HlKSV4CUdbE3ymYMq8OLlIpcu
 Bm/dO+RLduh2ydWDyNwBO7+0h0/RPPQNUIlG906e9trV6IV8PEQwT6Wqj/PKh4b8c4ZZ
 bElIzACqrN5Vs+LswJLvwOY1o8Wia+fvD7nLBpiBkr4wG0QWVTO7tmmNl2CF26CuHvD5
 sUF4jE480PXqEDy264hTvhnYkEjZz3wgLMt5qAbfYoQ0FA33wfhbbupGIYIfJjB7qhv4 uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umqxh0jcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 13:36:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARDaI5Z016356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 13:36:18 GMT
Received: from [10.216.27.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 05:36:14 -0800
Message-ID: <89623ca4-4b49-1b3f-5bb0-f4b398e69b9f@quicinc.com>
Date: Mon, 27 Nov 2023 19:05:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
To: Joerg Roedel <joro@8bytes.org>,
        Boris Brezillon
	<boris.brezillon@collabora.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Clark
	<robdclark@gmail.com>, Steven Price <steven.price@arm.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, <kernel@collabora.com>
References: <20231124142434.1577550-1-boris.brezillon@collabora.com>
 <ZWRrLhxEHxzNz41r@8bytes.org>
Content-Language: en-US
From: Gaurav Kohli <quic_gkohli@quicinc.com>
In-Reply-To: <ZWRrLhxEHxzNz41r@8bytes.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vGf19Miy2vFe7qG8dFCSi6ewfMRTRyjZ
X-Proofpoint-ORIG-GUID: vGf19Miy2vFe7qG8dFCSi6ewfMRTRyjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_11,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=385 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270093



On 11/27/2023 3:40 PM, Joerg Roedel wrote:
> On Fri, Nov 24, 2023 at 03:24:32PM +0100, Boris Brezillon wrote:
>> Boris Brezillon (2):
>>    iommu: Allow passing custom allocators to pgtable drivers
>>    iommu: Extend LPAE page table format to support custom allocators
>>
>>   drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
>>   drivers/iommu/io-pgtable.c     | 23 ++++++++++++++
>>   include/linux/io-pgtable.h     | 34 +++++++++++++++++++++
>>   3 files changed, 96 insertions(+), 16 deletions(-)
> 
> Applied, thanks.

Tested patch v3 also and reviewed also, both looks good , please feel 
free to add in case of merging:

Reviewed-by: Gaurav Kohli <quic_gkohli@quicinc.com>
Tested-by: Gaurav Kohli <quic_gkohli@quicinc.com>
