Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14976DCE1
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852079; cv=none; b=arl0zOr384l9mQjwDM+xb6CEccvDmYZMGpvfKK3PxGFgBolLImBsFeTSoDsMZZH64d1NgM1JZ4W42weK4uuNaPwmaWcipvpggOeLNr9BI+3CsDrkozNMZBAmoKVYEUZcbAYpffPi8HM7SZXuJgdihCIcZcWbnFm4DynGG/tHhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852079; c=relaxed/simple;
	bh=Knu8bUCMtcArQ12U1VZ1JTSL/k1AEL88cvEepH8L7+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDrXzFvEqtyZffr4ApEB7qncPnJK/wD3cz5nWD4MZ1Bzc411edDjopgPIEb1FVHOMe21KYQjRBlLtcURQn1TAzR0WiAiRwzPin72LGW3lUUfEdjELOlSzZRX2hEOlkS6TUCZDtPT9G2QmXjptZRUVYqK9mo+aEBLuGyniNhph/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GlOLUa6/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GlOLUa6/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774852054; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hx0KUQkz2fhW9W+oV1gZB96ZGHDs6RQDYrnZbLoEL6I=;
	b=GlOLUa6/OwDzZ4OKCdnI6lCkOpD+pRqKNyFmx9x34E+SKp6zsvwM32Fjf+lyROzh7+PPTSkOMKD7kYerNKIdP0ANzvFGwtRMzBFQXG+gsnaPzhSWL23ViJYLpcBvKIFl+mnoRqEoAN6DomNewJ2kfxnRb6y6QI4oncVAqEqFHEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.vDBIU_1774852052;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.vDBIU_1774852052 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 14:27:33 +0800
Message-ID: <9bd1cd45-df2d-45a3-ab9e-1668310e9ac4@linux.alibaba.com>
Date: Mon, 30 Mar 2026 14:27:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, stable@vger.kernel.org
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/26 11:07 AM, Zhenzhong Duan wrote:
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommufd/eventq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
> index f1e686b3a265..710eef0b6004 100644
> --- a/drivers/iommu/iommufd/eventq.c
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
>   
>   	mutex_lock(&fault->mutex);
>   	while (count > done) {
> -		rc = copy_from_user(&response, buf + done, response_size);
> -		if (rc)
> +		if (copy_from_user(&response, buf + done, response_size)) {
> +			rc = -EFAULT;
>   			break;
> +		}
>   
>   		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
>   			      (int)IOMMU_PAGE_RESP_SUCCESS);

Good catch.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
