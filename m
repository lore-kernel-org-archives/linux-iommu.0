Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235E1A0BE1;
	Tue, 13 May 2025 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102829; cv=none; b=TnVbsVxus5NecpKR4nfZ8ubt0gJ+L5lUTvD5uyLfTelLK4JIPVaYIDJOZcSZ+Mji/Uw/+IFtcFYp7ecvdetgt2gndcvdE7+J6K/xsZbpbeNBodWe4EkBnlvkrp3xG4gIMIHHCmoqC8sr2rrW9pw2af3X7dmV7iQkias1ew/HILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102829; c=relaxed/simple;
	bh=JAanfZMOtwsqXeD+6OrWTkCqDhu/Aon0zMRClqTvMsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShTxXgMzQ0/2yhCyeoNqanLKM9oSSQviJjph1bNHwNsy6xixuRSwe0ivhswbNg8FpSSHVuTQ+SO6YY1swXCqBOT4UqLrTgrHV30ES07XdffJoxPXU+mxZz3LfhTGdCcbHliSqa5LZ4Kt9OGeOgZF9Zr7QPdBVlG0pUO0PQ0V7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=T15SkYH+; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="T15SkYH+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VC8c/hCCyLIee4T1jsT8LH8tRvXKqOjAliJfp7OM6yw=; b=T15SkYH+mVJJiFAeghMWWlKYjw
	iVA2hk1kdKJm5g01GNwX9XxDFOXr7a7PWQn5TKf/FSvjMQfp6VGVWIaXGG1K8mvMNJDi00pwKQmvg
	szNigqTjbXJtGHKhbeZkdVc503kzl/KqpIo5JGDEbEdSH4o9E5AjSs50PynS97hOA4HRjqwWLD1Tl
	/y852HBVPrU2texaLPnnfWV5Rkc7BwCSyMZWACE6aDmmlk85xOXrkwJhXN+I/zwi9mNS9A8BU9JiF
	cWixxRdpSlyKxqnNIgw9IvaaOpIsy4R1TTEVdzItPcWMR550BcJuYTuuhXcyekV10/uK60dOdK7bX
	43dAyxvA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uEfFB-005dqV-1j;
	Tue, 13 May 2025 10:19:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 May 2025 10:19:45 +0800
Date: Tue, 13 May 2025 10:19:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
Message-ID: <aCKsQSob4TNDZb99@gondor.apana.org.au>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>

On Mon, May 12, 2025 at 12:53:26PM +0300, Abdiel Janulgue wrote:
>
> Some questions still need to be resolved, which mostly come from
> the DeviceSGTable::dma_map() function. Primarily, what if you call
> bindings::dma_map_sgtable() on an already mapped sg_table? From my
> experiments it doesn't seem to do anything and no indication is returned if
> the call succeeded or not. Should we save the "mapping info" to a list
> everytime we call DeviceSGTable::dma_map more than once?

You should cc Christoph Hellwig on the DMA mapping API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
