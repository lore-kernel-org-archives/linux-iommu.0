Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673682FE059
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565642; cv=none; b=ZD0fTv+DsfOsKZkyxnMcj3yvNf69Ai2IIoY3G5Rvp+3Vy2kamFiCCzLichNckqBroF4z76D54GTscIDM8oqcRGvMYHm9OZWqzsYnwjkIF8A8pnNvoz6MSXsP/T6NeWLpWdR8NwZRzZG9EX9xtFuLTqu/0tqlmLGhS2QTPycZCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565642; c=relaxed/simple;
	bh=F9hQ1aXhK3lDTwlNe0UmsgkyS6BDOP0RXEkmxmRZoe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLugiDJcOSJUkHCsLDjnyposYogd5L+786XwC0DzzIbEAyALaJGXwoLHkCTONzZQameJ1/9La9scSj5/q+BL4aytFZief7o7y7Rv+EYJKQzdPgo7+GlDRq1S5OyVp4BBiafNxP/U5x/QRaw9e6oHF7iJHwycQ5bPUDrQNTy6mII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JnkdrF/g; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JnkdrF/g"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 28C4D59947;
	Mon, 27 Oct 2025 12:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761565639;
	bh=F9hQ1aXhK3lDTwlNe0UmsgkyS6BDOP0RXEkmxmRZoe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnkdrF/gLW0DfLLhNrdPqWMTXkUTxTIRnzpVDtAGJQXxPS3e49wP7rC4ROgNLcqJ6
	 4UxcsY+7x1yz0w9pUNSAKyhrNNcB1bmgIhugZN89xH+FJ3KG3IICqbMEadXQAI4KTL
	 QEbmRpFTqpVZg3Tr4MmASqV0k1bo8jMT+bQRbt03RnUSzZyBjT+Cdzcb7xN8SuEHHX
	 JuwV3sgcgmRUEjpmw5re1hAEyZ8DF8ngUL5cwz9pTKd28z6haKrvCC7AwVykVWe4Hj
	 uYkVjl0yO9UXV/oMcwBVmHVrg8qvOoh3F3smRDASFo40PphGqubj7lTpR4EBvecO7W
	 UU+0FTNwsp0eQ==
Date: Mon, 27 Oct 2025 12:47:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/pages: use folio_nr_pages() instead of shift
 operation
Message-ID: <qv6ewao263euzrq6w62ftjaunaxizlxbpunlgflga6uvsiwyek@hi3gjlwk77la>
References: <20251004032351.51150-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004032351.51150-1-pedrodemargomes@gmail.com>

On Sat, Oct 04, 2025 at 12:23:51AM -0300, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  drivers/iommu/iommu-pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
