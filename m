Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDD41E6CE
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205571; cv=none; b=i3Z+H2P0WSNYrQY/8cNiURQDQp1WWWA5iQVeF4rZaEbZ+Brgrss+dLPV5QAieTRPpcqBssvUySuXDJNIEN6MqYd2OCyD0Y1NvA4ssznnQjOPAOFTc0UaYQVIXxn1Or61KDdAGDGzmrKZ6dhZfzcfgsxLmtYpsdR0iFUdP7NNIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205571; c=relaxed/simple;
	bh=OcOYrEzqlNrC7GNKRsxJv5/lMDMH8VK8cgLFRc+M1Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLKes8b1gTBEBdtXvrwZXaMwIVwgLuaLpPX+bDrA2ySxuaLVdHvZM5kAYCJhBE5uOjB9/C1WQK//H3+kZMk6bInlEiDAEVMxCMTmOunkkFVCh7tQehXYK9lK5VW6BtMlXL2lJrVqFX8j0iITgqB7NW/wB4T/1/5kU/8bsows8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLwr7NJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLwr7NJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD91F00A3F;
	Thu, 16 Jul 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784205570;
	bh=ONEYSRbHrj5WrahlWna8PWRUDAAMMlM2zTr2tPRhXF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OLwr7NJCTL8jEBbqhvymHgq8wpgmgyUdoRuZHsCTERhWVgkZ8h+rD8VdGdP1/fMhL
	 NDqUxFf0NhpIzPyFoJAIxpZVNXiXHe1m3GzIo/JLuRGAuhIHuZIbm+xWkWrRTwC7K3
	 U2W8NpAN9oADMX6f5JG1e/tIQT3R0EsdWuEaaNNKHlUUdee18Zh9lmZ/WQ1tpbJtCr
	 RnNej4NGCZuECOVyPJBhkv1DlCHPYBIeJki2nqV7H4JvZiK9vwkw7WuShn6S40dY1k
	 zxDdUlP+UJBxeNQk5Kp350yVB374Hh57i4+dVDf86jB7JlI/nR9i+3WGugcU4E8KVe
	 UpafNwIY9Wpbg==
Date: Thu, 16 Jul 2026 14:39:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows
Message-ID: <aljQ6zuu8DQYbSgs@zenone.zhora.eu>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-3-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713095812.1014365-3-krzysztof.karas@intel.com>

Jason, Robin? Any comment here?

Thanks,
Andi

On Mon, Jul 13, 2026 at 09:58:09AM +0000, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for scatterlist
> length field.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Used check_add_overflow suggested by Jason.
> 
> I decided not to include previous r-bs due to the change in the
> core of this patch: overflows_type -> check_add_overflow and I
> obvserved some folks have heavy preference for one or the other.
> 
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..1a36fd9bf10b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,7 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_pad_len;
> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_pad_len)) {
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			}
> +
> +			prev->length = new_pad_len;
>  			iova_len += pad_len;
>  		}
>  
> -- 
> 2.34.1
> 
