Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA503D9030
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785208; cv=none; b=LCEH3tWJTzNyfabQDnXfwiI3u8R2qp/3nPClomZvXH7sNcVowOWaFIWhovQFWUT4YAAepd1+DtE+WFYd1s9U6EeXL6a6q2PYM8aMX5tYDdvwFXTcDwb12wtfdKu7mhxkVUa1q1MOMk4kU6lQmbqPwtw4/x1nDKCkpnkZQ14zF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785208; c=relaxed/simple;
	bh=w3GsHD5BJ+Jbn6VdZQFnRDPvTckSfOnqGtiOVW0QHqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2AuQJn60oUDM1kf/1FNxAB8kaetDoAzmkSeQ2k5bA9DA9ubxqw2p5aHQaUyJqsYK0OZf8JLg9syeHHTCYpX5uQmxYqbMEk+xwWwBxYx7psg6XS+Q+xuk3vIfyb+McQj0rMi+WjeEH46njCXriirHqJBY19QYmqqq7bJ0GHJYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlydgGTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlydgGTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5569AC2BCB3;
	Tue, 21 Apr 2026 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785207;
	bh=w3GsHD5BJ+Jbn6VdZQFnRDPvTckSfOnqGtiOVW0QHqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlydgGTrM+kflkQWRzj/IYRsO0NfvhdryoyQD+E3ABAeB0Qeo9Q+xNyhU2EdzO4hR
	 v4J/6YTXO97SjlGBdKasA7nINKxfPWsh9ff3yXqKvo2PkWJHX/HnvY3avKf/cRTJmW
	 kj++F+huXGqh47wZf+uokGMVzbmmWhWGUSlgwaWd5FLHi9ZfdWMSTP/hYQ4ANUJJLC
	 tTxk5kCN1ib0TGx6TRTusnFyf+ob99+cwFKgp2KepS95SzKx2M2drbAUQTWQ1iUqwC
	 +anM7DxI6LGDryxBkL0nVPzLLE11BTViN0vTEaj2FCLoR4S/tjCNJ65STus/91D+96
	 1+HeJAIU6K69A==
Date: Tue, 21 Apr 2026 16:26:42 +0100
From: Will Deacon <will@kernel.org>
To: leo.jiang1224@foxmail.com
Cc: robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
Message-ID: <aeeXMrCvOIwvvWy-@willie-the-truck>
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>

On Sat, Apr 18, 2026 at 01:31:43PM +0800, leo.jiang1224@foxmail.com wrote:
> From: LoserJL <leo.jiang1224@foxmail.com>
> 
> In arm_smmu_init_one_queue(), the loop reduces max_n_shift if
> dmam_alloc_coherent() fails. However, since dmam_alloc_coherent()
> allocates at least PAGE_SIZE, retrying with a smaller size after
> a PAGE_SIZE failure is logically redundant.
> 
> Moreover, if a sub-page retry were to succeed due to concurrent memory
> release, the hardware would be configured with a smaller queue depth
> despite a full page being allocated. This leads to inefficient memory
> usage and unnecessary hardware performance limitation.
> 
> Terminate the loop once qsz reaches PAGE_SIZE to ensure logical
> consistency and optimal hardware configuration.
> 
> Signed-off-by: LoserJL <leo.jiang1224@foxmail.com>

No pseudonyms, please.

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f0..e0ec118ff560 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4418,7 +4418,14 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
>  		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
>  					      GFP_KERNEL);
> -		if (q->base || qsz < PAGE_SIZE)
> +		/*
> +		 * If allocation succeeds, we're done. If it fails, only retry
> +		 * if the requested size is still larger than a page. Since
> +		 * dmam_alloc_coherent() allocates at least PAGE_SIZE, retrying
> +		 * with a sub-page size is logically redundant and could lead
> +		 * to sub-optimal hardware configuration.

What do you mean by "sub-optimal hardware configuration"? I think you can
probably just drop this comment.

> +		 */
> +		if (q->base || qsz <= PAGE_SIZE)
>  			break;

I think this part is fine.

Will
