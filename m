Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA22302148
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009901; cv=none; b=pk8D21aPOfzDkYR6TY7z7OFKUv0hMhBXiGqXGhm6lVW3wN/Ys/xUvlXfIdfKjM077wMRekIdO3H/V2uDWcG3qgaqPm/EUoPryRfYEgrmLrL20ezmUgat3nhQAbt6v+m3FBvXxyVKVW+rTJ12SHPF611EKVXklIs62v5upx2vfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009901; c=relaxed/simple;
	bh=JXEQ94gC8AKcwEqd0xnmXVsYbCNVVJOdtzUbRtiW0OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYw23lH01m4o5bt5KHp3C+/zi8iWOzUrqiDMYFVkjCrZbvP2jG4b/trAywlkKp15fbhlZqtXzogKOGoQ83ZMUXdQbRvtR7K2tjrhWm5er9YRkO2R9U+aGiEOvE8MTKx6TsG5yx81F0hvB1ZvF1swI+XfGmvtvpLhChWaJFhZCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e67dzyug; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e67dzyug"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763009896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+MkJwqqWw91q4/ackBiFDAnwT9h6GJR0xtDRL8ERyWE=;
	b=e67dzyugKcrLE3EW6aN7XC0zAzFdeKwWW4qfhRvs3Zj3PjDArxPhjrIZvz4L/UnlUtgyATY1/N89ZZtLM6j5K+LYDllkO5UvBBSA1yuqJCh74QKEWDfuWSPceccrBEZ3Fimj3JAoCz9/MlSSJ0QaRyYU3pUuh+aZIqObhdpXzVw=
Received: from 30.246.165.27(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WsIBh2L_1763009894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 12:58:15 +0800
Message-ID: <f4a17ceb-06cc-4ef9-93cf-430b60cb7599@linux.alibaba.com>
Date: Thu, 13 Nov 2025 12:58:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, kevin.tian@intel.com,
 praan@google.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, skolothumtho@nvidia.com
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 01:27, Nicolin Chen 写道:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
> or bypass vSTE. Note that device on this attachment won't report vevents.
> 
> Update the uAPI doc accordingly.
> 
> Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

I've tested this patch and can confirm it resolves the GBPA hwpt
attachment issue.

Without this patch, IOMMUFD fails to attach bypass hwpt with the
following error:

   smmu_reset_exit
   qemu-system-aarch64: [iommufd=303] error attach 0008:01:00.0 (304) to id=6: No such file or directory
   Failed to attach GBPA hwpt id 6 for dev id 1

With this patch applied, the attachment succeeds:

   smmu_reset_exit
   iommufd_cdev_attach_ioas_hwpt  [iommufd=303] Successfully attached device 0008:01:00.0 (304) to id=6

Testing was performed on top of Shameer's vSMMU v5 series:

   https://patchew.org/QEMU/20251031105005.24618-1-skolothumtho@nvidia.com/

Tested-by: Shuai Xue  <xueshuai@linux.alibaba.com>

Thanks.
Shuai
