Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462138C2AC
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325702; cv=none; b=QrBwhmW8+zg5aMDvvXXJKCWhfon4f6eotb92ItWT3zOBO10oqwl7kHYZ9ny6bFv8ozDKDExeL8A9p1odWm/Dk97zgis+CHX6mFjBrf8lvvqZluCLybzQ3VPINXSp+SShkPyQv811feNzfnzR8JW6uPGJlTDFSZXIZOfCEGe1CDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325702; c=relaxed/simple;
	bh=WDUhm823v6UZr2u+Kjd7iBHQaDkTdDUoRp3CTaZTfdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5uhqsspC6qUPd/1N39v7a5Lr6P/+GcQdWMkM/MDOPmlGMWKDzfWAa99VcmImloV0iOW3AlqwwhQfDjys3/f/J9kdq/3ThtL0bVMTQqqc5YrdHWRKlIzjIQSKfdlyaczGnG2onUKb6FEB//7YBP1PZKHgOLuisfxDCFBCU+/9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pnnyN8ph; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pnnyN8ph"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776325697; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R9cSF7x16gzL69hRqTCX7JLMOXplx7082hoPwKg2kJI=;
	b=pnnyN8phX4vOofWNLICRGr9PicO1BQHzqgUMeeVeAKqhL7mM/YkBdNWLKMyMn0zfT01XCD83ybm7f2LZBUb7spXP+MMj3CoFtRNwLLqoIHL1+gHaFMOAWBB07eOdiCTtbd2fIzS0PFQ1kG/bDk6vXdYfXc/o4nQjZHAbcgQ2+fU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X17dgK2_1776325696;
Received: from 30.221.148.96(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X17dgK2_1776325696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 15:48:17 +0800
Message-ID: <cbd5996b-5f72-4ad2-8766-ec70c3e07a67@linux.alibaba.com>
Date: Thu, 16 Apr 2026 15:48:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260407194644.171304-1-nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260407194644.171304-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/26 3:46 AM, Nicolin Chen wrote:
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
> Given the IOMMU core tracks the resetting state per iommu_group while the
> reset is per device, this has to track at the group_device level as well.
> 
> Introduce a 'reset_depth' and a 'blocked' flag to struct group_device, to
> handle the re-entries on the same device. This allows multi-device groups
> to isolate concurrent device resets independently.
> 
> Note that iommu_deferred_attach() and iommu_driver_get_domain_for_dev()
> both now check the per-device 'gdev->blocked' flag instead of a per-group
> flag like 'group->resetting_domain'. This is actually more precise. Also,
> this 'gdev->blocked' will be useful in the future work to flag the device
> blocked by an ongoing/failed reset or quarantine.
> 
> As the reset routine is per gdev, it cannot clear group->resetting_domain
> without iterating over the device list to ensure no other device is being
> reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
> in the struct iommu_group.
> 
> Since both helpers are now per gdev, call the per-device set_dev_pasid op
> to recover PASID domains. And add 'max_pasids > 0' checks in both helpers.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

LGTM. Feel free to add:

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
