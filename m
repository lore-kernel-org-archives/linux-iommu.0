Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50765653;
	Wed, 22 Jan 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524395; cv=none; b=WEROQvyEda+u4LjDdZBwE5YATHKW4u6xDyzsfUfztWNuMWTnfVUTLOetNBeuPzPt9nsWrEJSFz/Jev/sBlr5PEzxhIsCadZJ+IeA71SC/5IkY91IPkGXDmTOUPI9T/0v7+3XnbDxBW4jYI4eynQmMYm4fVmsqxMoHOlN5uavpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524395; c=relaxed/simple;
	bh=Pupre4VlPYAF//vRlITqFkNTjAe8n6rwvL0jV3QyesI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=W+/5I0Cn1PJ4kQA6kcr9I+6AmJ0FUuSq3tgc/ppZt31V6p3h8lyfyh7Y7frJ5yMo4desFOT8MN2XUQt9haC7FTqFBkGTzHRhSJNplh9HfLcCJydtM/q2PgImPCmvhCi6b/cZ7wLXpfF8m5+c9k7Hi4Y2VS3U08utEi5MmCSta1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hnlH2dD2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hnlH2dD2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1gbK6017245;
	Wed, 22 Jan 2025 05:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pupre4VlPYAF//vRlITqFkNTjAe8n6rwvL0jV3QyesI=; b=hnlH2dD2/p/eQi30
	1TjWesO0OMNvho0dyGRsYRLcIhuEJ0O9o8m+b9L8uNEw1baR7dQOG21KnnD8sZaC
	kSoPl4N5ZYVftvaCqkAdd+bt8IrIQflJz6BEmIw3nDKvJ/f9XmBdW/yPM1tj9sOb
	42CXYjCL9NPew5vnCejJ7cEI2AE4xM0TChvJCimPk9A+w0QSP2w6wNaD/lBF8CiE
	+kwkVmYTl11Tmu0iO4tE79+ceAuKByRQu6gG65g4aJ9HtlBDN6Ewhdff4B2vRP0r
	Uk3zNMh+d0EULSKrTX/YQCk1nMHAzflumfEaKufvYmeQvxMKl1PX1kF6f0VulVhw
	TyVkFA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44aq8greft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 05:39:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M5diJG010421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 05:39:44 GMT
Received: from [10.219.56.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 21:39:42 -0800
Message-ID: <3caf4418-8ee2-4a61-b9ff-74b24155e436@quicinc.com>
Date: Wed, 22 Jan 2025 11:09:39 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: <joro@8bytes.org>, <jgg@ziepe.ca>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
 <20250107113126.GA6932@willie-the-truck>
 <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
 <acc57f57-6eb5-4d55-bc36-33624051eec9@quicinc.com>
 <0a0a576e-dd4d-402a-a0ea-43eede4e7cd8@arm.com>
 <d1838296-0131-47ac-8a2e-eec8935c5960@quicinc.com>
Content-Language: en-US
In-Reply-To: <d1838296-0131-47ac-8a2e-eec8935c5960@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o5rZ2e-zmjUI-9dZc19H_25Th6IoiUNp
X-Proofpoint-ORIG-GUID: o5rZ2e-zmjUI-9dZc19H_25Th6IoiUNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_02,2025-01-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=843 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220039



On 1/20/2025 5:45 PM, Charan Teja Kalla wrote:
>> ----->8-----
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d1af0547f553..8d90d196e38d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3120,6 +3120,11 @@ int iommu_device_use_default_domain(struct device
>> *dev)
>>          return 0;
>>  
>>      mutex_lock(&group->mutex);
>> +    /* We may race against bus_iommu_probe() finalising groups here */
>> +    if (!group->default_domain) {
>> +        ret = -EPROBE_DEFER;
>> +        goto unlock_out;
>> +    }
> Please lmk If I can submit this as V2 patch, with your name as Suggested-by?
I missed to mention that this patch is fixing the problem we are
seeing..Thanks.
