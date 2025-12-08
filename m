Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAA23B609
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161194; cv=none; b=n3k4e8aXkUmiUJcpxQrgYgNoBhaAdprzVYA+ozpsYT0kYP3GytUN9mwYmQW/DUvdys+4Q10YKOkCvn2/SSNaMrIPNX4FBo6F+Dq+1dJCJCz53eCt4wuZ53vZ5r81+/kj1XPGCkFXqqRi/nDEGLt413jp/TpczcnUHZig33GH/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161194; c=relaxed/simple;
	bh=moKz4GVRNv207Zrvanx1wM3yetaz/fdkn5XTair9WKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJDF4qf5FqjbmJmp3jocp1xbSa/y/9pdhU19nFy0rP2JZT+cvUxoWx9tuQNLYnSkoaEaBy8Bfj4KacRtPbWaZlm0dijJEjrXEljlrf+rcXwPF8VET8pG5i7NIDQkZ5pq/R+AND/AjmrMQ/viai944JDdGQJbC5PoVaZsjiTK4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GnW/ymj+; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GnW/ymj+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765161183; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+m9wTg+ZYkNO109SezDDzdMKSU7d9+BVzHXwQxnLF5s=;
	b=GnW/ymj+lsmzQZNj7lLaJT7Syj11waeMUV7yqqruDLVbG7rqzAvhXazaKyo3qq+zrK8Roxe3ugR0fNttZT1PTGMebvGguwmbIZtRNAkUg1fyZbqYSSz+2zBycEpcl0socnEKZM4rUotLms+6lpX2QkSQ269xt4yACac/blrZ0/g=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuF431u_1765161182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 10:33:02 +0800
Message-ID: <60060fca-b1e7-43d9-b1de-27bc9ec2f43f@linux.alibaba.com>
Date: Mon, 8 Dec 2025 10:33:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skolothumtho@nvidia.com, praan@google.com
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <0db5caabdcdd8aa170f4c196e94d54664cc87fd3.1765140287.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <0db5caabdcdd8aa170f4c196e94d54664cc87fd3.1765140287.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/8 04:49, Nicolin Chen 写道:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
> an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
> different than the normal S1-bypass and S1DSS-bypass modes. As a result,
> fields like MEV and EATS in S2's used list marked the word1 as a critical
> word that requested a STE.V=0. This breaks a hitless update.
> 
> However, both MEV and EATS aren't critical in terms of STE update. One
> controls the merge of the events and the other controls the ATS that is
> managed by the driver at the same time via pci_enable_ats().
> 
> Add an arm_smmu_get_ste_ignored() to allow STE update algorithm to ignore
> those fields, avoiding the STE update breakages.
> 
> Note that this change is required by both MEV and EATS fields, which were
> introduced in different kernel versions. So add this get_ignored() first.
> The MEV and EATS will be added in arm_smmu_get_ste_ignored() separately.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

