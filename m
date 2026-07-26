Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9331ACED5;
	Sun, 26 Jul 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070665; cv=none; b=sS32WTISnTPZThxiBJl64mGIyEig9BLpzO067bTkpscPbAYZTXZ0J6V/0fxCumbRF516L7FNtuiLLlqXi2S6A1HZv2JZ65urpOnF0XVQO2+ox+Hb14YIjNkr0p6DDLmlqXh5jWWaQ7devGQSKPPeaS3rbhKMmWxsvGL9osGVaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070665; c=relaxed/simple;
	bh=C7aGpTOyHimPD+gv3/hs6eZmeTVZVj5nGCfe3SrfbSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2YYTxAjESm7wYo8VUS913/Re1prkZl6Y7uLi682Eg4GOx4Cfs/Sr6ePJ38OFV+O8PUxoeRu006XHiM5k1wOULNIgJR9RbosO2RFe8wNu3T6rBGneiRXZvxHI8ofISGqDWdzhUnAX/6I0LunPZS/KRxhA+pCpKCzC+SThCaf5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkOvWz1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkOvWz1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F111F000E9;
	Sun, 26 Jul 2026 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785070664;
	bh=TaLiMtvY0m9e9or7P0HE6bTdSoChv2t1ZP3SmHJfHYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkOvWz1dNFkbQBJJDi5AgASXRmeBvtAHtBSNTQanG/hsstvCS7p4NTpeWSKq3O2SK
	 /107V2BRROkrNMu58bBG6f+tHcQNlyGSYxOOk0i+gG2MlAtdewK8lTDU+ETDh/zhuv
	 p4BUtIJHryrQwAOjZiogmP3tRrGJOO8PCOgCiySJU14b+kh7xXTV/na0ZBEji46myf
	 zaNCo5crj6/nQracdJbws4jSFbhHBemZeTzrl9h7RlJNwhqIWsTiHvHpNsgY2KyPGI
	 dDAH96UMleqWWKKzVA0Qq5iRKvRv2v+k3E13K0+Wk+cgSOxFxBRGY40Z93dQyAZshP
	 JtKSOgE4MBVKg==
Date: Sun, 26 Jul 2026 13:57:38 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] iommu/tegra241-cmdqv: Warn on a VCMDQ base
 above the 48-bit hardware limit
Message-ID: <amYEQt7Y5MC48kRD@willie-the-truck>
References: <cover.1784059577.git.nicolinc@nvidia.com>
 <4e638ec1bbff46a358b4129e264fef66b4f37703.1784059577.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e638ec1bbff46a358b4129e264fef66b4f37703.1784059577.git.nicolinc@nvidia.com>

On Tue, Jul 14, 2026 at 01:55:07PM -0700, Nicolin Chen wrote:
> tegra241_vcmdq_alloc_smmu_cmdq() allocates the VCMDQ buffer via the common
> arm_smmu_init_one_queue(), which uses smmu->dev and its coherent DMA mask
> of DMA_BIT_MASK(smmu->oas). The architectural Q_BASE_ADDR_MASK is 52 bits,
> but the Tegra241 VCMDQ_BASE holds only 48 (VCMDQ_ADDR), so the masked write
> "q_base = base_dma & VCMDQ_ADDR" silently drops bits 48 and up.
> 
> A real Tegra241 never reports a 52-bit OAS alongside the 48-bit VCMDQ, so
> this cannot happen on correct hardware, but a buggy or hostile hypervisor
> could still advertise such an OAS to a guest. The user-VCMDQ path already
> rejects a base_addr_pa with bits set outside VCMDQ_ADDR; add the same guard
> to the kernel-allocated path, failing the queue init rather than silently
> truncating the base. Use dev_warn_once() rather than WARN_ON(): the OAS is
> hypervisor-controlled, and a WARN_ON() would let it panic a guest that is
> booted with panic_on_warn.

So here you talk about "a buggy or hostile hypervisor". Is that really
part of the threat model? Presumably such a thing could cause havoc in
a million other ways?

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index f93e59b7bd2db..d27ee215032f7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -674,6 +674,19 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * The q->base_dma is bounded by DMA_BIT_MASK of SMMU's IDR5.OAS. On a
> +	 * real hardware, VCMDQ_ADDR mask and IDR5.OAS are always aligned. But
> +	 * a buggy VM might set a mismatched IDR5.OAS for SMMU. Spit a warning
> +	 * instead of a silent truncation.
> +	 */

But then here you talk about "a buggy VM might set a mismatched IDR5.OAS".
How can a VM write to that?

/confused

Will
