Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF32BE057;
	Thu, 30 Oct 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850055; cv=none; b=Jeh/r3TjxDFZ0TeVYZDwyvNIq7YwcMp2iytfp7zHwc3cVQYrmVEUZlLD8ncAVk88EdD/LAvYuxcEY71vCaJQsRIu9MOdz8Z9c38AXWbHEUDb2Jq75OZrzRp3J+5TWVaxUS3AyrjzcvrmW1GlSfDVVOXwLyQHvD1eton7LKh3p6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850055; c=relaxed/simple;
	bh=+lPIhU9oLRT2DNBRbSaWQZLvInycZwA/F5Yg+RVlfek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idrA1XjWBjcLl9irmxsNtBGK0wII4bgHFEmsxSISSG6OLsAKTgroY3c6RrFvTJ556rUBnhXkPx7VHFaQa92KDF+y1YXh77nSd0v8a+ppUd0FDTKysLA/DRNADkG06DoxiS1WL753H5rFgHPcvbCUmLiTiY3RJ7bPbzLyMJkwegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKRx00lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKRx00lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88641C4CEF8;
	Thu, 30 Oct 2025 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761850054;
	bh=+lPIhU9oLRT2DNBRbSaWQZLvInycZwA/F5Yg+RVlfek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKRx00luoUuis2jNcgqMkgqu4iUMUK4H+lbqxh8k6PwxOYKkrl7PmaS/Duks/uzB0
	 1bYMPRHr0icbs3OssV0FeI/IbDXAsVhMqPIjeNGRGxdey4LGCtmKI9h7hb44nXwEFr
	 GXY8KuZdpWN81Gf3lB7TD76+plyYNR4Ly5xHs80l/fJR4j5XljNVD1S5LE/PN/LQFU
	 Vt6QnlMGZypWkR+/8NLlFVVnIjMTE4tZJj28vQF2H1973TxxLdAXwkj4DGDTFa2m5+
	 tM+fv5cw+maM9WF16DEgghvNjGkZRiH5w/8+Y39KtARusISggaqHH92LrNS7BBjjtm
	 +bvOkycw45IFw==
Date: Thu, 30 Oct 2025 11:47:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Guodong Xu <guodong@riscstar.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Allow use of DMA_BIT_MASK(64) in global
 scope
Message-ID: <20251030184728.GA694763@ax162>
References: <20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>

On Thu, Oct 30, 2025 at 02:05:27PM +0000, James Clark wrote:
> Clang doesn't like that (1ULL<<(64)) overflows when initializing a
> global scope variable, even if that part of the ternary isn't used when
> n = 64. The same initialization can be done without warnings in function
> scopes, and GCC doesn't mind either way.
> 
> The build failure that highlighted this was already fixed in a different
> way [1], which also has detailed links to the Clang issues. However it's
> not going to be long before the same thing happens again, so it's better
> to fix the root cause.

Yeah, it already has since the instance you bring up below:

https://git.kernel.org/gregkh/usb/c/93741bd104ce07a790519ecee3a331ee7cf61ae3

> Fix it by using GENMASK_ULL() which does exactly the same thing, is much
> more readable anyway, and doesn't have a shift that overflows.
> 
> [1]: https://lore.kernel.org/all/20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com/
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks, this should hopefully be fixed in clang relatively soon [1] but
you are right that there is nothing to stop this from occuring again,
especially since older clang versions will still be impacted by this
behavior. My basic testing shows that this should be equivalent so:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/llvm/llvm-project/pull/163885

> ---
>  include/linux/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 8248ff9363ee..2ceda49c609f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -90,7 +90,7 @@
>   */
>  #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
>  
> -#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
>  
>  struct dma_iova_state {
>  	dma_addr_t addr;
> 
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-james-fix-dma_bit_mask-624dbeb89afa
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
