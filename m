Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C4801;
	Fri, 24 Jan 2025 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678782; cv=none; b=FRID3LlMDLr/xD20Hof9TyLg3ZqdbdpDwusY7oYuiuYbJ/uG5xcCh5ejvtgi34W+s+KudEjHja7mj5ngXsPOMV5A4gvB78SoFQXQAYpl0tyzxeZUyX7tXNrhY4nNlYnFmfmjdfMKCc6DHxmKy1LnQrMcp5TdUW435RlP3LOvmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678782; c=relaxed/simple;
	bh=EGz+aYJMxLcqmxXeqpUSdikSyIHNG4e41cJqocuCyy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PyUPD+4awq6vwm1JF7QVsTWxoqm39BAyWMdfwHW4zOEyjOYA9Tmt5vkIHt+ggHINNgt5/6P4si3TajyYeuiCBsu0+B6Wb/eS4Hfnm9ExPATeWaDkhg3TwVmUpRTk/hRbeqkXVocnKJyOmpenO/yttgf38FQY94mylwltfAb+Bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YLCS6WYd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YLCS6WYd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NMm9jq004439;
	Fri, 24 Jan 2025 00:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRnB4ivRQI0AMDG9uwnS72kj13b7fA8UOFLBYlZCxGA=; b=YLCS6WYdmSGB8ChK
	E3vG+qBzk5o/Pm2k4CAW2QaY3fQWNXx26NcfH50RPvZjsFQADFae8UJCqzczdbx5
	HBOewKW5gIHWuPztpa8bahqyzyw+Pxmt61tcxlUx+icWszzzmwVaQw7qkSOiNjPs
	gMl/pvTK36tJ8aJFrkQO0Skztahs7XUMtSZTZP2xtC6KP/yGzT7kTUAbdn2HO1Av
	/ZiB3rmMZ2MjqDO5UGGOJhWMuP0dGnBx+YDz7JZmbTHxCN7QcK/HurARbPxpFif7
	aJsz2h2AIFFPEG23RdeLdEs8z1mGhSVg2ShCYSEVsh2/6ZfWFofDiyQlbMgspfl3
	7o2sfg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bxvpg4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 00:32:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O0Wp9s009618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 00:32:51 GMT
Received: from [10.216.47.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 16:32:48 -0800
Message-ID: <49b6c324-eece-4755-b3a2-2005b6246384@quicinc.com>
Date: Fri, 24 Jan 2025 06:02:45 +0530
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
 <d1838296-0131-47ac-8a2e-eec8935c5960@quicinc.com>
 <3caf4418-8ee2-4a61-b9ff-74b24155e436@quicinc.com>
 <deb6f541-a09d-457f-a5e3-8302e57cc332@arm.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <deb6f541-a09d-457f-a5e3-8302e57cc332@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lhrWuPK0nwAs5ScNgE5mgddmo8xgSZzD
X-Proofpoint-GUID: lhrWuPK0nwAs5ScNgE5mgddmo8xgSZzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240002



On 1/22/2025 8:13 PM, Robin Murphy wrote:
>>> Please lmk If I can submit this as V2 patch, with your name as
>>> Suggested-by?
>> I missed to mention that this patch is fixing the problem we are
>> seeing..Thanks.
> 
> Ah, that's good. I did spend most of an afternoon digging through git
> history to write up this patch the other day, and was planning to send
> it properly soon (probably after the merge window now) - as noted, it
> also turns out not to be quite right for 6.6LTS as-is, so I figured I'd
> save worrying about backports until it lands.

Thanks a lot Robin for sending this patch with much more details!!

> 
> Thanks,
> Robin.
> 
> ----->8-----
> Subject: [PATCH] iommu: Handle race with default domain setup
> 
> It turns out that deferred default domain creation leaves a subtle
> race window during iommu_device_register() wherein a client driver may
> asynchronously probe in parallel and get as far as performing DMA API
> operations with dma-direct, only to be switched to iommu-dma underfoot
> once the default domain attachment finally happens, with obviously
> disastrous consequences. Even the wonky of_iommu_configure() path is at
> risk, since iommu_fwspec_init() will no longer defer client probe as the
> instance ops are (necessarily) already registered, and the "replay"
> iommu_probe_device() call can see dev->iommu_group already set and so
> think there's nothing to do either.
> 
> Fortunately we already have the right tool in the right place in the
> form of iommu_device_use_default_domain(), which just needs to ensure
> that said default domain is actually ready to *be* used. Deferring the
> client probe shouldn't have too much impact, given that this only
> happens while the IOMMU driver is probing, and thus due to kick the
> deferred probe list again once it finishes.
> 
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu
> drivers")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Do you think If the below tag can be added?
Closes:
https://lore.kernel.org/all/20241213150415.653821-1-quic_charante@quicinc.com/
> 
> ---
> 
> Note this fixes tag is rather nuanced - historically there was a more
> general issue before deac0b3bed26 ("iommu: Split off default domain
> allocation from group assignment") set the basis for the current
> conditions; 1ea2a07a532b ("iommu: Add DMA ownership management
> interfaces") is then the point at which it becomes logical to fix the
> current race this way; however only from 98ac73f99bc4 can we rely on all
> drivers supporting default domains and so avoid false negatives, thus
> even though this might apply to older kernels without conflict it would
> not be functionally correct. Furthermore given the other locking and API
> flow changes which also happened over that time, it's not clear how long
> this race has actually been exposed. LTS fixes are going to be fiddly...

Thanks again for sharing such a detailed history.

My understanding is that the commit f188056352bc ("iommu: Avoid
locking/unlocking for iommu_probe_device()"), also sets the basis for
the current race conditions. Without this, I think, iommu_probe_device()
would always returns with default domain and later iommu_setup_dma_ops()
fills the 'dev->dma_iommu' flag. Please CMIW..

And, as the commit f188056352bc ("iommu: Avoid locking/unlocking for
iommu_probe_device()") is present from 6.6 LTS, I am not sure if we
really need to look before 6.6 LTS kernels to fix this race.

> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 851fd5aeccf5..9969531ad4ed 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3097,6 +3097,11 @@ int iommu_device_use_default_domain(struct device
> *dev)
>          return 0;
>  
>      mutex_lock(&group->mutex);
> +    /* We may race against bus_iommu_probe() finalising groups here */
> +    if (!group->default_domain) {
> +        ret = -EPROBE_DEFER;
> +        goto unlock_out;
> +    }
>      if (group->owner_cnt) {
>          if (group->domain != group->default_domain || group->owner ||
>              !xa_empty(&group->pasid_array)) {

