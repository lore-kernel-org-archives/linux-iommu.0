Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825067;
	b=I4inutCARNCWxtATRm9dvdsdQ65sYgo7OSDvyhapwwnpN4uCNPbPLmEc0RmdTPpKUrWD
	 k0/BlAOpqEjoEKykgEH4LuAGdwkwlRxjymj4E3t0TVGZZV55/OkQVgdKzPwptPzfC0PGN
	 G+vfxSW1UUywYhcATh1XKckugf5nGouS7CNIiVgn8lG0ou4V/lKmWVM8FJhY/e6es+JjE
	 Diu5WnDfA7tyIToXcDtdsKsJV+mNtSp3yoRx4eahAf+qX7KR3shQ/3GzwORGNf8q9NMrx
	 p+JRy9T+HbT3asqgBEnEqZmwm7x9Ty5E6Ai9dBW78TRCqxcVX1/Ndp4YhbSrB9JmLwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825067;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=uNOpllo5XvmHxbQubQwPdNd+q8BidbrN9AGJD2HAR/8=;
	b=r7L2xqyLtCCkVw9u4q9x8dpabB21x0GYYb9MfeD2KteyggV5zDmF3MSS4PJfEpL3Bkzm
	 rHzP7dYEJ7CyoHxtRSZYAORbfiuVTSh6o89e3oSzahpquC7yiUUE53Ian7/3+Jje0GAIe
	 e+6jlZJ+SlkGEX6Zsjj9Ei0g5+AE3I2//DDTZH0W5/3b4KQjeJ6tHC3ek9daWKFPNHDJP
	 y8T9Z7wqIgI1UOLizwMjU+8a2Rh0ax97OAtwujIgPg8r0c9J2RrK/zvRVO+zOLsDoaYKh
	 L9NNpnD0MeYzzELLi4J6AnAqAuhhBctSvo1MnPImH6NbTKspJPKVLupjMoA/ZBPMirw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Ip0nbOh6;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296E606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5296E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Ip0nbOh6
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261116103103euoutp024598022f897f797ce661057ca3db7475~of_Lhuo572901829018euoutp02X
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261116103103euoutp024598022f897f797ce661057ca3db7475~of_Lhuo572901829018euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794825063;
	bh=uNOpllo5XvmHxbQubQwPdNd+q8BidbrN9AGJD2HAR/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Ip0nbOh6qvOR4lJQZzIsdjanHDzjL4Vl6XcdmOUfKlLA1M+ySnzuuQYQQ72ZxUZ/v
	 QW1Pyqfe+sRmogKKI6mDHERIHhAd+lHOoBSjcYTyg0eHs8duuzDebDuaYaNnt5rK5/
	 1IzoeOC4PP8Jhaiw5nhLAHhfaqSMe9+WmFHNyJKk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261116103103eucas1p1b1d1b73f614168f64fea898e558ec8d8~of_LXhMea0737407374eucas1p14;
	Mon, 16 Nov 2026 10:31:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261116103103eusmtip21cb3987701e28a22d7af3b6f18dba8ec~of_Kr3hBm2720627206eusmtip2b;
	Mon, 16 Nov 2026 10:31:02 +0000 (GMT)
Message-ID: <94d4ca0a-40d0-49ac-97dd-0cf88238667b@samsung.com>
Date: Mon, 16 Nov 2026 11:31:02 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-pool: decrypt pages before creating the shared
 remap
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes
	<rientjes@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K . V"
	<aneesh.kumar@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261109230830.1707975-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261116103103eucas1p1b1d1b73f614168f64fea898e558ec8d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7
X-EPHeader: CA
X-CMS-RootMailID: 20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7
References: <CGME20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7@eucas1p1.samsung.com>
	<20261109230830.1707975-1-m.szyprowski@samsung.com>

On 10.11.2026 00:08, Marek Szyprowski wrote:
> atomic_pool_expand() creates the pgprot_decrypted() remap of the pool
> pages before calling set_memory_decrypted() on them. The error path
> when gen_pool_add_virt() fails does the reverse: it re-encrypts the
> pages and only then tears down the decrypted remap. In both cases there
> is a window where a decrypted (shared) kernel mapping points at a page
> that is still private, i.e. encrypted, to the guest.
>
> dma_direct_alloc() gets this right: it converts the pages first, then
> creates the remap, and on error removes the remap before re-encrypting.
> Do the same in atomic_pool_expand(). The pages are now converted before
> arch_dma_prep_coherent() and the remap, and the error path unwinds in
> reverse order.
>
> If set_memory_decrypted() fails, the encryption state of the pages is
> unknown (the conversion may have partially succeeded), so they must not
> be returned to the page allocator or CMA and are intentionally leaked,
> as before. No remap exists at that point any more, so nothing else needs
> to be undone. Add a comment explaining this.
>
> Closes: https://sashiko.dev/#/bug/linux-9212d9b5-4a56-43e2-bc00-6e69b724078b
> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied to dma-mapping-fixes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

