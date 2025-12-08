Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951951DFF0
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161230; cv=none; b=sHr+O94429Jhzbzgt2NK61TiNftYIsw1nWiO3ql017GWdayd48WGi6/T/Oml/jrNAXSAfFzABpDyJKQicJWnvUWrsbiGsoZH4HgWNvA+0chQGYz2Hk8z4Ib/C6cxxvnZ8VhUa1wKlyK1wfvrXzicJzf7gKYGxXJ6g0K2iiD5L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161230; c=relaxed/simple;
	bh=uz1TTnr9a8FadQhJh0Q1AbLD7MCZSWWBKUYWhWijGoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSTTnqkeQVNZ5Y2Qj23ZYU0WEhBSsX2lDHhruHAHlEkN7553M2qQKYKJ2Xa6NOgp6yo3YqrqpJ6TRASoUOXhG11xkyyuXxlTVgu5k/M/q2cm9BUm0oXAUbz9JRSEovs2JkPNKdzAKebYE1iSGrth9Ti96K8efglNrHhhZghEc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nZt/qeBn; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nZt/qeBn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765161221; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C6pv5CBH40UymlBR/yM1CaDwUY0ELjdp+6nVUu/1p40=;
	b=nZt/qeBnw0X5qHP/eVahDBdFvFJx30iqbrSAvRELfsEw0+vuo8/USmw/1NHSCbJwSv+msei/l3UkT1WfiQOhrI7GFlIQb61p4xrXRu8lbyU/KT+VV0SZXmAEiGkBgr4RtOR+aKS+NaXfJKgNjS8mEzC6EXNjxaNOq12nn7TGrt8=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuF2a0v_1765161220 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 10:33:41 +0800
Message-ID: <0b277ac2-e454-47b8-a592-d9f57936c3fb@linux.alibaba.com>
Date: Mon, 8 Dec 2025 10:33:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 3/4] iommu/arm-smmu-v3: Ignore STE EATS when
 computing the update sequence
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skolothumtho@nvidia.com, praan@google.com
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <b3586cb03317fb2362e936e4d303566851b506d4.1765140287.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <b3586cb03317fb2362e936e4d303566851b506d4.1765140287.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/8 04:49, Nicolin Chen 写道:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> If a VM wants to toggle EATS off at the same time as changing the CFG, the
> hypervisor will see EATS change to 0 and insert a V=0 breaking update into
> the STE even though the VM did not ask for that.
> 
> In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
> not cause a problem until we have nested where CFG is always a variation of
> S2 trans that does use EATS.
> 
> Relax the rules for EATS sequencing, we don't need it to be exact because
> the enclosing code will always disable ATS at the PCI device if we are
> changing EATS. This ensures there are no ATS transactions that can race
> with an EATS change so we don't need to carefully sequence these bits.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 3e161d8298d9..72ba41591fdb 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
>   	 *  fault records even when MEV == 0.
>   	 */
>   	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +
> +	/*
> +	 * EATS is used to reject and control the ATS behavior of the device. If
> +	 * we are changing it away from 0 then we already trust the device to
> +	 * use ATS properly and we have sequenced the device's ATS enable in PCI
> +	 * config space to prevent it from issuing ATS while we are changing
> +	 * EATS.
> +	 */
> +	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
>   


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
