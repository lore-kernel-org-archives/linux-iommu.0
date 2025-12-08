Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6922405E1
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161216; cv=none; b=p2za9I8RkS7+5uJmA8rIB04gmrJKpxhNpvJRA/wQZ/NzQQdVso3TMeguZBDePFCG5KenDbe2x7Vnpm89urjYvI1kjSVGFAm4XGc82lrl/hFK4mOjzJB0SkL4LwXHhV/cOWXTuOEuK5AVuTQL/SoZHhiNAzoPhI0HX00cf/MPgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161216; c=relaxed/simple;
	bh=8K5a+vUfFQtbR5nSX1mrUPGSaE+r8g7xENEkc8+QzRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRfhhdRIheMrh4+iOT1ceD0d0m7HfZ7ggG85+AYrFSpve6ZmpNjQeSBnVRCARYLnH8Gz5TqJ0t9kBhIu7LE9uuBJgYwevrrpShSLyZh8XZ/Q3JMiLwoJv26jr1ZTEWsYo5q7PkS6y8dHuYnCKo2F6ZhsKWir78wDn1myXqsZZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DkC8rsVl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DkC8rsVl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765161206; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/EX3r36Y3+GGh6sPJvDukpPQhyrwazsMSdsilDqqLyY=;
	b=DkC8rsVlc5xa+93kZ8TF+y6sG3pzIcj/EkkkRrL4NgtPjgWu/LZQW2883VOHhc9mX71QbOk9pssekUxgDdUEw1VPz31FHs/PS0v5NbRfRtV4q3aGalTIrW/dNq3/4K/slcy72q1PxgSqE2fZRb+yYJdqLtM+/sSTkhaXwoq7hK8=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuF439A_1765161203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 10:33:24 +0800
Message-ID: <b4d96532-09b5-4162-8d9e-c41ca2baba0b@linux.alibaba.com>
Date: Mon, 8 Dec 2025 10:33:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 2/4] iommu/arm-smmu-v3: Ignore STE MEV when
 computing the update sequence
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skolothumtho@nvidia.com, praan@google.com
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <08fd4d48e684732ad58064f690195f31a64979c4.1765140287.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <08fd4d48e684732ad58064f690195f31a64979c4.1765140287.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/8 04:49, Nicolin Chen 写道:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
> the hypervisor. Since MEV is in STE word 1 this causes a breaking update
> sequence that is not required and impacts real workloads.
> 
> For the purposes of STE updates the value of MEV doesn't matter, if it is
> set/cleared early or late it just results in a change to the fault reports
> that must be supported by the kernel anyhow. The spec says:
> 
>   Note: Software must expect, and be able to deal with, coalesced fault
>   records even when MEV == 0.
> 
> So ignore MEV when computing the update sequence to avoid creating a
> breaking update.
> 
> Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e22c0890041b..3e161d8298d9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1085,6 +1085,16 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
>   VISIBLE_IF_KUNIT
>   void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
>   {
> +	/*
> +	 * MEV does not meaningfully impact the operation of the HW, it only
> +	 * changes how many fault events are generated, thus we can ignore it
> +	 * when computing the ordering. The spec notes the device can act like
> +	 * MEV=1 anyhow:
> +	 *
> +	 *  Note: Software must expect, and be able to deal with, coalesced
> +	 *  fault records even when MEV == 0.
> +	 */
> +	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
>   


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
