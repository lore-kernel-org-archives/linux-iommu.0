Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8083C1994
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918858; cv=none; b=ekJ4s0Mxh3tJQQKBrI9l3JtQ/lw9eY7h0UOAMlOD1fF3b/osPmhekaI4A5GdAU9gVooYg9GZypwa8ZJ5Uv7IA57ET89MGwmKeg4OsOzcKnf2Dn5s2gD6NNjSbDMls5l63LGYl04ESWb9l6Kuh9z+olrDQs2UV1HRQqPegcqKQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918858; c=relaxed/simple;
	bh=b1tM+V5dwKzsd7BnMNYgg6No/d9bOTd4ipJd+ZEuaIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg76rKS42Sk7S2Og8FMytDnR7f756gywWXjWA+VeBAvHCUzgKaYaGPQokOKPaq4Lm6e2rWeiTdk5TXa7rFARHOCRdQPabpcmiUTVopkCkuv5FDaudfctU1S3T+4vrEv65kGy/uHdhYeezxpG1dBQTF2Gj0JnG3Wo1A0LAIf365Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AshwTswT; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AshwTswT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773918851; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KziEQjzET2tmGaf79QP1vQNf62aUkhu64wFtz1OLZ7A=;
	b=AshwTswTh3iyjdLaGw/42Az5k6snL1ZbTegJoLa0JQKj+BRqWv3g235uPNETt3Ni368PzTQsfMs7FgEgugPEu/gmw6/wafdkALS8inufhRCUnv9WfgH4TM4Lohde+z5CkSpphW+eIiuNpgo3OktwELkV1WVpsbuDpMkba71/6DI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X.IN-cS_1773918850;
Received: from 30.246.163.250(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.IN-cS_1773918850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 19:14:11 +0800
Message-ID: <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
Date: Thu, 19 Mar 2026 19:14:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, kevin.tian@intel.com
Cc: will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260319043135.1153534-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/19/26 12:31 PM, Nicolin Chen wrote:
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
> 
> As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
> will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
> device reset.
> 
> On the other hand, removing the outer calls in the PCI callers is unsafe.
> As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
> execute custom firmware waits after their inner pcie_flr() completes. If
> the IOMMU protection relies solely on the inner reset, the IOMMU will be
> unblocked prematurely while the device is still resetting.
> 
> Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.
> 
> Introduce a 'reset_cnt' in struct iommu_group. Safely increment/decrement
> the reference counter in the nested calls, ensuring the IOMMU domains are
> only restored when the outermost reset finally completes.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
>   v2:
>   * Fix in the helpers by allowing re-entry
>   v1:
>   https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/
> 
>   drivers/iommu/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db51780954..16155097b27c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -68,6 +68,7 @@ struct iommu_group {
>   	struct iommu_domain *resetting_domain;
>   	struct iommu_domain *domain;
>   	struct list_head entry;
> +	unsigned int reset_cnt;


Nit: consider renaming reset_cnt to reset_depth or
reset_nesting to better convey that this tracks nesting level,
not a count of total resets.

>   	unsigned int owner_cnt;
>   	void *owner;
>   };
> @@ -3961,9 +3962,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   
>   	guard(mutex)(&group->mutex);
>   
> -	/* Re-entry is not allowed */
> -	if (WARN_ON(group->resetting_domain))
> -		return -EBUSY;
> +	if (group->resetting_domain) {
> +		group->reset_cnt++;
> +		return 0;
> +	}
>   
>   	ret = __iommu_group_alloc_blocking_domain(group);

pci_dev_reset_iommu_prepare/done() have NO singleton group check.
They operate on the specific pdev passed in, but use group-wide
state (resetting_domain, reset_cnt) to track the reset lifecycle.

Interestingly, the broken_worker in patch 3 of the ATC timeout
series DOES have an explicit singleton check:

   if (list_is_singular(&group->devices)) {
       /* Note: only support group with a single device */

This reveals an implicit assumption: the entire prepare/done
mechanism works correctly only for singleton groups. For
multi-device groups:

   - prepare() only detaches the specific pdev, leaving other
     devices in the group still attached to the original domain
   - The group-wide resetting_domain/reset_cnt state can be
     corrupted by concurrent resets on different devices (as
     discussed above)

If prepare/done is truly meant only for singleton groups, it
should enforce this explicitly:

   if (!list_is_singular(&group->devices))
       return -EOPNOTSUPP;

If it's meant to support multi-device groups, then the per-device
vs group-wide state mismatch needs to be resolved — either by
making the state per-device, or by detaching/restoring all
devices in the group together.


Thanks.
Shuai


