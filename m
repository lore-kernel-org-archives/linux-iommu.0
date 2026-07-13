Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6523E170E;
	Mon, 13 Jul 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935488; cv=none; b=D3D1Ktn7AAZtHLJv5IjaGa6+0UvNg2iq3tT4eaajDBHJh6BYdeyFaSMUBZ2G7nn0ppYcYdfZ6/cHfZQiSU4h2XwFj/zEbo6PiIYoMmemVB3dbghc2fCQjiAIjfbw1EnJouxsdEU7DJnjzVeTQdjTuAEyzshM6NsgGCRsdUSTCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935488; c=relaxed/simple;
	bh=uEy8jK9LzWT2yY7Ceil1hXYxxDnp6zVs/Kyid6IyeUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwhmWySH3ReQOxhNtKGDS3gnWfKvTOQEo4YmuUGh+bShVneqi+AAMwBJeutGWFv8gYqTqHNXDfNwrFLDk/L8PwBMQJlASh4cb8PH9b8rWids1VbcA4rgRa2Ebcf2ACc+uYJUCRrrcyRzOf9W8MWt07rxg/+J/SrSsZbRNNaFRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFTKzXGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFTKzXGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9761F000E9;
	Mon, 13 Jul 2026 09:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935478;
	bh=8sJyH9AO5FLwOeclZoZv4e4b6cnyTNqgHa2cjYuzHlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFTKzXGNSW7oIqW19b0vkX61DzExw0MI/OsP2r78mlRs744pHbCKlW2/GOp+YHAON
	 DUkRwZshkZdYfIDFoAXo2/tDzeZv0KnXsVJ6obKQDtbI8UtPI73YzghhuDCeZECLpw
	 8Ht+LAwk1MrebN2r+jFmNHkcDndG9xFxmrPRxnrATDbofsOjlklN9b3GYwT51Man0f
	 XRF+D61Ap71QsrYoMxQmMruhwCBV4op8+IQipqnHumcIqTYm32hgEDvn4VMmvMrxUf
	 +qUulyj11+pA8lcioPpMLLJ4eOfaMastTQUR+kkXBeQ93q9y45W3CEP5exZR7Kex/0
	 lJxCc/xDVReFg==
Date: Mon, 13 Jul 2026 12:37:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH] dma-direct: Improve readability of the
 dma_direct_map_sg() for P2PDMA case
Message-ID: <20260713093752.GL33197@unreal>
References: <CGME20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24@eucas1p1.samsung.com>
 <20260713083022.1110993-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713083022.1110993-1-m.szyprowski@samsung.com>

On Mon, Jul 13, 2026 at 10:30:22AM +0200, Marek Szyprowski wrote:
> Improve readability of the sg_dma_len assignment in the P2PDMA cases by
> removing duplicated code, which was a direct result of the d0d08f4bd7f6
> ("dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings")
> fix. No functional change.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/all/20260604071856.GA245424@unreal/
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/direct.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
