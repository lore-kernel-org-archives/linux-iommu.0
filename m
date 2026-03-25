Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB039A06E;
	Wed, 25 Mar 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428577; cv=none; b=uXopw/xEZ5PHZjrGiZPGAkHCoSoFAW2Uynu9+szj/MjhQrdmgma/HgXJswvJJb86PEynp3ePcMiNYVqbUz0GO7VQDkDidsIE25rTsv9HGUX/ulrUJ9WfQXe4K3xb6i4v6KRLj1fHDcDDl7N1/G8yWFGtPRi5IzQBTXBIM9thOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428577; c=relaxed/simple;
	bh=1KVhfSN1bf3tRoieUkBhrij9z5fN6auM7FgN0v+4jVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVqczJ1jiSZWsYVlmUp22Bvjie9oiAdlJE+nPXHacQcOFnXBn6q7IEPB0Mj/ZT0aggYxxQofTXpQ1v1cQdh2bz3TKuhNndhxyNUvcY1y0E/lZQe7dbfYKdcsh87kQ0xlYkt+MOhY4FBjhsLebEkipN5a/tpB3utPQI3t6+QqCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnahetI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnahetI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4AEC2BCB4;
	Wed, 25 Mar 2026 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774428577;
	bh=1KVhfSN1bf3tRoieUkBhrij9z5fN6auM7FgN0v+4jVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnahetI75n1IFWxy8cZyiSObnO+MtZgkXk+au0vF+NiUK1+AmM+k+ydbcOfaoIzUc
	 KkFbzn+BiqW/pvdGb+RWQNebPwfICQk+fRD9KYGs8NkddqQ5mLr/8a7MbuxOlVs/Nf
	 VezOs6KZQ6hDH8vndycT3qMNjs8knFSkhD2yDT+q9WE+mYnc8TNJnvKGUFOwLSZRLn
	 OZ1DgCKDgkgJsLIpV9xa6VNIaLBo1JzsVmHoQ3OtslRKH3kwAxG9J8D0LnE1EWUkZ6
	 oqGs8sABORXEXCh6zPVUCiIJRFjv6xLbKEYuXXookLFBUYmJA4vl2dHnVGCn1CqiVE
	 Zh/urlp+mSMvA==
Date: Wed, 25 Mar 2026 10:34:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: add missing `inline` for `dma_free_attrs`
Message-ID: <20260325083441.GO814676@unreal>
References: <20260325015548.70912-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325015548.70912-1-ojeda@kernel.org>

On Wed, Mar 25, 2026 at 02:55:48AM +0100, Miguel Ojeda wrote:
> Under an UML build for an upcoming series [1], I got `-Wstatic-in-inline`
> for `dma_free_attrs`:
> 
>       BINDGEN rust/bindings/bindings_generated.rs - due to target missing
>     In file included from rust/helpers/helpers.c:59:
>     rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
>        17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
>           |         ^
>     rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
>        12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
>           | ^
>           | static
> 
> The issue is that `dma_free_attrs` was not marked `inline` when it was
> introduced alongside the rest of the stubs.
> 
> Thus mark it.
> 
> Fixes: ed6ccf10f24b ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA")
> Closes: https://lore.kernel.org/rust-for-linux/20260322194616.89847-1-ojeda@kernel.org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Not sure if you would consider this a bug (I used "Fixes" and "Closes"
> because it was not originally intended) or whether you would want to
> backport it -- of course, feel free to edit the tags as you prefer!
> 
>  include/linux/dma-mapping.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
