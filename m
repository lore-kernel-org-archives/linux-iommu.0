Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DB19D092;
	Mon,  9 Dec 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788690; cv=none; b=KDh9Bn/zCQxIAJsSsycYTUZ9CUraODach4uKZYRuJ8/Pucv9pZ37axkjUiqHzbPbJ8b0HM9NzEo5rkU1xloSWCNm4qzERRUXzBRHEeMzjpk3+S10nIRV1D2QbmiWXFqgIxL0OwiP2PAGmIFgL3yxB8aQpJB4otj3Yiz8diV30FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788690; c=relaxed/simple;
	bh=PNBJ7bGJrJaQBHaIWZFvWw8CJ1fG1cKVlwr8kkw2luc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7E7xQes9IA649H0Z8ME6h5CvUe9emfEtlokiezTX1ywQ691TS98CKpNf2riEXgu28ltOo7Ira3BH6L6gBClZ+q52Cmjop70SxILL/aEDSHPMAYVl50XhdazOtzsYT6Py2HlwtD8r0+GkZZChdXAK3GMZoEgkMXMQh/ie5ZdFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd67anHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd67anHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48ECC4CED1;
	Mon,  9 Dec 2024 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733788689;
	bh=PNBJ7bGJrJaQBHaIWZFvWw8CJ1fG1cKVlwr8kkw2luc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sd67anHUFKDXOnpMU2dHVFW1iDKUgEISLcQZ2ZxgyEnEZuQjG2mFQUk/I6JXupDWm
	 ie6z7VrS+ezcDHyrqtj10GBt8X6cl7sJe0QkyGRxfi5UTFlucJWCOlMaOTIFeZJbwa
	 EC//o/yZjqWjbZ0tvYNbfQMz4Y+mZS+s3V3K4SI8LFBBvjzTl+DbE/ndW03b7GNhWG
	 F3blFf5ctZUfBbTeUTl8/I0OcEw53Q4c6oRKSjw+nrJwpSvfw0x6cs8jO2O76oWehV
	 ZoGKVcqgqLM/kC5pkvkL2lyUi+wbqRu/3n64ihGHENh/xsD8mjL1H2dAspgiip1rgE
	 dlwtSzJrvdlIA==
Date: Mon, 9 Dec 2024 23:58:05 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
	joro@8bytes.org
Subject: Re: [PATCH v2 1/2] iommu/io-pgtable-arm: Fix stage-2 concatenation
 with 16K
Message-ID: <20241209235804.GA14069@willie-the-truck>
References: <20241202140604.422235-1-smostafa@google.com>
 <20241202140604.422235-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202140604.422235-2-smostafa@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Dec 02, 2024 at 02:06:03PM +0000, Mostafa Saleh wrote:
> At the moment, io-pgtable-arm uses concatenation only if it is
> possible at level 0, which misses a case where concatenation is
> mandatory at level 1 according to R_SRKBC in Arm spec DDI0487 K.a.
> 
> Also, that means concatenation can be used when not mandated,
> contradicting the comment on the code. However, these cases can only
> happen if the SMMUv3 driver is changed to use ias != oas for stage-2.
> 
> This patch re-writes the code to use concatenation only if mandatory,
> fixing the missing case for level-1 and granule 16K with PA = 40 bits.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 45 +++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 6b9bb58a414f..0055876b3527 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -223,6 +223,33 @@ static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
>  	return ptes_per_table - (i & (ptes_per_table - 1));
>  }
>  
> +/*
> + * Check if concatenated PGDs are mandatory according to Arm DDI0487 (K.a)
> + * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of 0.
> + * 2) R_SRKBC: After de-ciphering the table for PA size and valid initial lookup
> + *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tables for ias = oas)
> + *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
> + *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
> + *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
> + */
> +static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtable *data)
> +{
> +	unsigned int ias = data->iop.cfg.ias;
> +	unsigned int oas = data->iop.cfg.oas;
> +
> +	/* Covers 1  and 2.d */
> +	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
> +		return (oas == 48) || (ias = 48);

I'm guessing the second disjunct here should be:

	(ias == 48);

I'll make that change when applying...

Will
