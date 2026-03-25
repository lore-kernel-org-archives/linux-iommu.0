Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DE30DED1
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422188; cv=none; b=SceYnDdKxpodjyKMA6cfBsAHNv4Wd9NpcRnPc1Um2yi7iwCetjJREoAr5Q6ksh1Vq1Aa0UHjRUg32oUuO9OC75MJTztm+0OE7dOnET9FgyLvTcuyI1+t6sOIsZNcY9057ep05Qj+kUtdKxQFYVSESL+IaWLjP8sOB54RXwPzPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422188; c=relaxed/simple;
	bh=DNxMf1gwmx3ozKq+wqncXuOB2ElxRgLEYJV5+z5N5jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CK+J896T/WXMB62Pw/Ern1od12Q2gm70/WETIMcNn+MIDid0VOlggIGI8QdP1o6LhptwJkUlHlS1vCwwld7qUxQvBPN9dDgI2mKpbK9CWbLFrF2fTYMNA7h6Z7WX6YvUtNDxdih/fAQKiSLWfgcMPXVAUerlTpDbewBYeKmwQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MITTfRIb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MITTfRIb"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260325070257euoutp02217c6f69f8ceb83b851158d4d20ba567~gA5HDCTpD2721127211euoutp02F
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 07:02:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260325070257euoutp02217c6f69f8ceb83b851158d4d20ba567~gA5HDCTpD2721127211euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774422177;
	bh=AhY9vIZqDeGQ2Ft+p6mHMJYtwAvxB7evB11UlNYnCSM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MITTfRIbuX5/KieDQpTjjB4cfSVBj1F7ZtC0sS2nb4jHYemtjzAQcOz4PrbpG2lxI
	 v4ywrK0lSP9nvDFD9r1G3DmzbtM482Gz0vZ/z8xcXuykQr3SJDb3sCbylYWw0pcW2c
	 vSyPrQnm4UQRHvazI5cIrYVhqE0VLQf+TwjotpJg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260325070257eucas1p193a2ef79889a6508aa36b7cf0e32d4ca~gA5GquWr_1750617506eucas1p1X;
	Wed, 25 Mar 2026 07:02:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260325070256eusmtip2d04cb886d1a1b11e0b89be3800dafc72~gA5FgBOrH0352103521eusmtip2E;
	Wed, 25 Mar 2026 07:02:55 +0000 (GMT)
Message-ID: <4c146aff-ec4d-44f2-a102-b99adde00422@samsung.com>
Date: Wed, 25 Mar 2026 08:02:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: add missing `inline` for `dma_free_attrs`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, rust-for-linux@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260325015548.70912-1-ojeda@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260325070257eucas1p193a2ef79889a6508aa36b7cf0e32d4ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325015610eucas1p29097fe4c456890db026adb691da60c12
X-EPHeader: CA
X-CMS-RootMailID: 20260325015610eucas1p29097fe4c456890db026adb691da60c12
References: <CGME20260325015610eucas1p29097fe4c456890db026adb691da60c12@eucas1p2.samsung.com>
	<20260325015548.70912-1-ojeda@kernel.org>

On 25.03.2026 02:55, Miguel Ojeda wrote:
> Under an UML build for an upcoming series [1], I got `-Wstatic-in-inline`
> for `dma_free_attrs`:
>
>        BINDGEN rust/bindings/bindings_generated.rs - due to target missing
>      In file included from rust/helpers/helpers.c:59:
>      rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
>         17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
>            |         ^
>      rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
>         12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
>            | ^
>            | static
>
> The issue is that `dma_free_attrs` was not marked `inline` when it was
> introduced alongside the rest of the stubs.
>
> Thus mark it.
>
> Fixes: ed6ccf10f24b ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA")
> Closes: https://lore.kernel.org/rust-for-linux/20260322194616.89847-1-ojeda@kernel.org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to dma-mapping-fixes, thanks!

> ---
> Not sure if you would consider this a bug (I used "Fixes" and "Closes"
> because it was not originally intended) or whether you would want to
> backport it -- of course, feel free to edit the tags as you prefer!
>
>   include/linux/dma-mapping.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 29973baa0581..f46a0848cb24 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -248,8 +248,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>   {
>   	return NULL;
>   }
> -static void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> -		dma_addr_t dma_handle, unsigned long attrs)
> +static inline void dma_free_attrs(struct device *dev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
>   {
>   }
>   static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
>
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> --
> 2.53.0
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

