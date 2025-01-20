Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919A17E015;
	Mon, 20 Jan 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375367; cv=none; b=p+OlLOQL3q1vgJ8uyo6vBQtcaoeEP0KbZKrLL84DyrliG/XhK0pMeocjgtHigFaeggejXrL6LI4sCg5Yr1Eg+Scpttih74KxubLw0YUFSE+8bckvSimbpHBALDTdt7i1554gePZlsNg581cVPW+NrAaDOH2sfu+z6E86aLE6GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375367; c=relaxed/simple;
	bh=EpBs1BgJrhplP2ZfB2AxYKSSh0rSEh1r5MWowVaZsOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sSQXn3IX4oQHnJrU917iEYsEo3xP75D7b0gM271imr0qzZfEKB7+MgAlYrmwZJoue3Rg5wsOi24zguuVP6Z0IJ0J6RXB2asNcpiG/a+e2F4zngk9akEyKQIes/hMWuhaJ/7SS2Wp3ofFgInNz2Yymhftpuci4yLWAJWx46CJmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxM+1deq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxM+1deq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KA2aBp001739;
	Mon, 20 Jan 2025 12:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	125R/FMYNB+nYL0fSzqFcdX8TaRnA8/vG7LNSTuaImQ=; b=UxM+1deq+pS6aB6J
	+dH0yrd+1AsT++8VgFwEMOtwu5dmfetEyM3ekv8pH9vRxptgW/n1ci+XDU0rEMnb
	Zpoc9hEOvlDOc7RUlUntl8Wu0PpymIITYjg9Dw5HPOG0dhueBAmwP3RU39DPPeK4
	lDSmIk0HutIV6bjYbpTMMcm3GRz+s4tepTI20rMfb32RNCHV7aqlrBiPUwstIta2
	6JMHgGWsrbi6h8hEyPQRk4wVDX9Mrc+t0AVC5nFWIryHR8hrJEbWe3b2zsmW3CeJ
	/ZtUqXcszIm+wzHMmgYxXvQCNeWCwhSgoAF3KV0JqmvRuyqIhewprf31KLS2BmlH
	Zv5PIw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449mcwg9s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:15:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50KCFrGw025983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:15:54 GMT
Received: from [10.219.56.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 Jan
 2025 04:15:51 -0800
Message-ID: <d1838296-0131-47ac-8a2e-eec8935c5960@quicinc.com>
Date: Mon, 20 Jan 2025 17:45:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
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
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <0a0a576e-dd4d-402a-a0ea-43eede4e7cd8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ExGJJ1-aer7kJayiKSWAiShN0kA0p8TB
X-Proofpoint-ORIG-GUID: ExGJJ1-aer7kJayiKSWAiShN0kA0p8TB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200102

Hi Robin,

On 1/13/2025 10:55 PM, Robin Murphy wrote:
>> @Robin
>>
>> Agree that we don't have iommu_dma_ops but I can say that same race
>> still exists. Although dma_ops is not used, but the decision to call
>> into the iommu api's is determined by the 'dev->dma_iommu' flag, which
>> again, is set after domain is allocated for a device.
>>
>> In the same race mentioned above,
>> 1) S: Domain is not allocated but the dev->iommu_group.
>> 2) C: Just returns as dev->iommu_group is filled.
>> 3) C: Continues probing and succeeds.
>> 4) C: Calls dma_alloc/map/.... But, it won't enter into iommu_ api's
>> because the 'dev->dma_iommu' is still 'false'.
>> 5) S: Domain is allocated and sets the 'dev->dma_iommu' to 'true'.
>>
>> 4) above is the problematic step. Although issue exists but seems to me
>> that very narrow to get triggered. Please CMIW.
> 
> Hmm, yes, I guess there is a fundamental race where async client driver
> probe can observe a partially initialised group while the IOMMU driver
> itself is still running iommu_device_register()->bus_iommu_probe()...
> And in that case, this patch is wrong for two reasons: firstly, bodging
> the iommu_probe_device() call (which really should not exist at all)
> does not cover all cases; and secondly, forcibly creating the default
> domain in that path before we know bus_iommu_probe() has seen all other
> existing devices means iommu_get_default_domain_type() may miss their
> requirements and thus defeat the whole point of deferred allocation in
> the first place.
> 
Got it. Thanks.
> Having looked a bit closer, I think a more robust solution for now is
> probably as below.
> 
Just want to hear of other solutions you have in mind, when you say this
solution is for now....
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1af0547f553..8d90d196e38d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3120,6 +3120,11 @@ int iommu_device_use_default_domain(struct device
> *dev)
>          return 0;
>  
>      mutex_lock(&group->mutex);
> +    /* We may race against bus_iommu_probe() finalising groups here */
> +    if (!group->default_domain) {
> +        ret = -EPROBE_DEFER;
> +        goto unlock_out;
> +    }

Please lmk If I can submit this as V2 patch, with your name as Suggested-by?

>      if (group->owner_cnt) {
>          if (group->domain != group->default_domain || group->owner ||
>              !xa_empty(&group->pasid_array)) {

