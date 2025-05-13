Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7811712
	for <iommu@lists.linux.dev>; Tue, 13 May 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121914; cv=none; b=A5qXdJGaTa9X/4wmi8EV7u+NJPL94YKicPUvL5d0BHoW2ac48UvG49ADHUjM9p88FQl5bUfmEDZWUoFQ57Fa578b4OR/YLTturMJOfSLmRv0Iar0nEFEcAnZzknL4rViOucXWSmrYBHg62YnvFqPelo7ZpXopTwo3c6JPzgGeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121914; c=relaxed/simple;
	bh=vCUUs/wgIUL18F25aLyau9K4HGFSB7fzoH0c+V6krq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rewyR01ayh2BHbGcn4Sf0TuM0J/UM603LpU98xEsLC2yxTtlF7BK+UMH31EjknsgzfGlYGsCIpb6b2hb3ULTimaAI/dJEhqFokc7jCYmuneKcwnZJJu+4y8Dr5iv41Lq/5PsKgaWtXkw2PXFugzpkthYwcfHGRohiTTMOxvOVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hgrlPGgR; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hgrlPGgR"
Received: from mordecai (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 78C74223E20;
	Tue, 13 May 2025 09:38:28 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1747121908; bh=nWyqrjvABvf/Aot02RBbZkj3rjM/TY+hnwm8vexdR4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgrlPGgRyQ1L7y1kP0h6rq0XyghJWdtwOnOxjnjXa/lAiEMsczNvrSDm3/716T1M9
	 DOZGJp1+zvmHS6J/4sucnCfWRME0er0/MtOvP6cKzVYaVdz39sAs1glNExiiD88Syd
	 SjyaYwc/jq8hZrPsWY+gIYsT9+9zf1IQRn1/kZ3lLw7P10/tq9vIsL6IdgYvEAlBBR
	 /UvngDDYL21lv4nJZtPkEJ+7AZX2FffxfazbIHPdkugHubZfaqtNfNoVNqhkuE87PY
	 f8sr33+1DhBvhkGJolqlSLg82T5sYBUUocRRwHEpzbhN4Ven51hNDrB0fphLhKDGS4
	 7c7kjwtj1a7Nw==
Date: Tue, 13 May 2025 09:38:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Abdiel Janulgue
 <abdiel.janulgue@gmail.com>, dakr@kernel.org, lyude@redhat.com, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Valentin
 Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, airlied@redhat.com, rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Sui Jingfeng <sui.jingfeng@linux.dev>, Randy
 Dunlap <rdunlap@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
Message-ID: <20250513093824.65ab7c85@mordecai>
In-Reply-To: <aCLdpXp6RzvPuSET@infradead.org>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
	<aCKsQSob4TNDZb99@gondor.apana.org.au>
	<aCLdpXp6RzvPuSET@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 22:50:29 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, May 13, 2025 at 10:19:45AM +0800, Herbert Xu wrote:
> > You should cc Christoph Hellwig on the DMA mapping API.  
> 
> I'm not going to use my scare time to let this cancer creep further.

No, please do not scare us with cancer again. We do respect your
position on the Rust acceptance scale (where this end is in fact named
after you).

It's fine; you don't have to do anything here.

Petr T
