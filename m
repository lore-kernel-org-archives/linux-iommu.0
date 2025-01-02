Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463E1991DD;
	Thu,  2 Jan 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814403; cv=none; b=uWWLojrzwvjMZ1k3bMoHMZhrqAhSlgSk4h+zqra0bqEtx1Uf0T8BEcXbStsnO/IsFMVBTh8sGlYBnRpZxRDBIbF53dDyaWqgD1w3EPHT4VybDr2n7HhLsG3xAf9paLpRHmIdtgQUxzYDzZ9iuMgwojGJjsSW95tkU+ElIkcM3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814403; c=relaxed/simple;
	bh=sFhpSocXBzuHfvdIdwZUjNa+fLLP39W1xozKavWKN7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L1YG9AvH23tqNn9H/7gR1+kyIUMUP9z65vZqjBBV+NOMnrKfGr5Dsh5/s+QEtFcBTpg33eZRqfXtGxT5kWwbCME3pdyDAH8x+7GgZZxkUfmpVPjRDl3MJEXdf5Rg2MQnic6573QmV/jU8cxUbTaA05pY0hRqGNj7xdaXDFhP2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M+RCemqK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M+RCemqK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Abf7L014673;
	Thu, 2 Jan 2025 10:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3hq5pPhoLWrZ9X7JvsBOciwezW02shNULfJ/tgcfJM=; b=M+RCemqKUXimv01Y
	ZnDtEChLTQuXxUe8HeYi8HKdIWkKChuxSNmvlgtnscJqmgfNEw7Gj4LgdtL0JlAr
	9qeZElMA9rN1ac/ibBWL3XBJfYZXsnfAIfMcQhp9HX8VYQZK1J3IIAfW895bj+Jx
	rW8nxAl8z9LNF5TxIFTLkWQWDW0Yfw9c3RUclWvOyKUkqlBcracUJhQie2VyaETU
	v2N0X87+YgyJszkuSVy/PDh13FOdYEiVhz8iIHtCkqRcxierDt/6Bw2Jq9rRe2Bi
	mk8Y1SQujavG6kjsTJW9WYwyxiV+yAREBc94/diDWhZ80plhPoXLikSKZd9UnZvV
	N+r+bw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ws7a803n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 10:39:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 502Adq9S012910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 10:39:52 GMT
Received: from [10.216.11.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 Jan 2025
 02:39:50 -0800
Message-ID: <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
Date: Thu, 2 Jan 2025 16:09:46 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20241213150415.653821-1-quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6z0ZUrSPuaCUksmZqwBA8FiOfZsr_W5Z
X-Proofpoint-GUID: 6z0ZUrSPuaCUksmZqwBA8FiOfZsr_W5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020092

Just a quick ask if you have any comments for the below. BTW, in
internal tests, when we revert the commit f188056352bc ("iommu: Avoid
locking/unlocking for iommu_probe_device()", it is helping.

I can share more details If the below is not sufficient.

Thanks in advance...

On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
> Race between smmu device probe and iommu device probe is resulting into
> wrong DMA ops used for the device.
> 
> bus_iommu_probe(P1)                  of_iommu_configure(P2)
> (from iommu_device_register)        (from insmod of a driver)
> --------------------------         --------------------------
> 1) probe_iommu_group()
> (Fills just dev->iommu_group
> under iommu_probe_device_lock)
> 				2) iommu_probe_device():
> 				  (acquires the iommu_probe_device_lock,
> 				   but since dev->iommu_group is already
> 				   set, it just returns without
> 				   allocating the domain.)
> 
> 				3) of_dma_configure_id()->
> 				   arch_setup_dma_ops() gets called for
> 				   this device, but returns with the
> 				   error message:
> 				   "Failed to set up IOMMU for device;
> 				    retaining platform DMA ops"
> 
> 				4) device probe is succeeded where it
> 				   can now setup iommu mappings using
> 				   wrong ->dma_ops
> 
> 5) domain will be allocated later
> and fills iommu_group->domain.
> 
> Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
> 
> This issue does exists on 6.6 because of commit f188056352bc ("iommu:
> Avoid locking/unlocking for iommu_probe_device()") without which 2)
> returns only after filling the domain under group->mutex, thus no issue.
> 
> With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
> ->iommu_dma_ops is removed altogether and iommu api are directly being
> called under "use_dma_iommu(): return dev->dma_iommu". Again,
> ->dma_iommu flag is set only after domain allocation. So, If
> there is a sufficient delay between steps 4) and 5), issue is still
> exists but that seems very narrow to me.
> 
> I am thinking, setup of the domain before returning from step2) is the
> way to fix this issue. Can you please help if you have any suggestions?
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3f1029c0825e..61fc8145f378 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -561,19 +561,43 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  int iommu_probe_device(struct device *dev)
>  {
>  	const struct iommu_ops *ops;
> +	struct iommu_group *group;
>  	int ret;
>  
>  	mutex_lock(&iommu_probe_device_lock);
>  	ret = __iommu_probe_device(dev, NULL);
>  	mutex_unlock(&iommu_probe_device_lock);
>  	if (ret)
> -		return ret;
> +		goto err_out;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {
> +		ret = -ENODEV;
> +		goto err_release;
> +	}
> +
> +	mutex_lock(&group->mutex);
> +	if (!group->default_domain) {
> +		ret = iommu_setup_default_domain(group, 0);
> +		if (ret)
> +			goto err_unlock;
> +	}
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
>  
>  	ops = dev_iommu_ops(dev);
>  	if (ops->probe_finalize)
>  		ops->probe_finalize(dev);
>  
>  	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +err_release:
> +	iommu_release_device(dev);
> +err_out:
> +	return ret;
>  }
>  
>  static void __iommu_group_free_device(struct iommu_group *group,

