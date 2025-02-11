Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A5264609;
	Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301720; cv=none; b=gSjfn592Ye/Prmq5qz5pUqNn9d/KI4d73CwFfHj2Huc9voFxpBq7Wbqa3kLIkI994ifczMN5xha9vT8VrLWlxdaITcf2dtrg6fhKhQZoWJcp+xlz5XXDcRCzISnHwJmJPmZp1GY25OkuXdH+cD5uyM4r0fst3v9lrDiQ/at1dBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301720; c=relaxed/simple;
	bh=i0rjrv5Hw6uQyXJ5j8UYn+6uNdJPs4y5WflA+/CxlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBNYYNficY1x1JfbgovZLV8QGi6QJ2tH7LPvj7WQJE7rgqw+uGyLsz5fx79SIGKurrPkRUm5g8h8elroCustfH24/X0qbiuxb8cIHVSAfpRU9I7O0FbIaDTmboobAB/9NBuKnrCMWlXLjh7SJzZx3IqqztFBAXjWMYDt+GbRDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=p6Lng5ZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M95Iwyi6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="p6Lng5ZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M95Iwyi6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 082C92540113;
	Tue, 11 Feb 2025 14:21:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 11 Feb 2025 14:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739301715; x=1739388115; bh=4CMMII7gg+
	S8ZOua/g5opUsXHaf674ZZLjjOpdOjwqM=; b=p6Lng5ZCX20mDzQNjqo+bbgI9M
	npPT8FklqciXwLGjqcT8Au3W5BJI/lfFBHCsx3UZ41Fkp6M5gU2f9WIZIOO4IfLz
	eHNEABYblCeOEjtnbpydn8zc0VTyiRzm9iQ4qofAp9wVD8UAk3agXPiOwekZJrXz
	MvT6b8fJXFN5kyiXff4fO4L/oHCGySvOGR/gddZU1pOPYxzRRSNvKtrgjJmac6Td
	ciFEHYYJojcv/0BNV1Lzde7dicQ6r/SYjMTRI0BGvYeZ77lwA535KlomsZaNVfc2
	TA/wK7WxQlNtSm2jKC9nklyzpSeG4seTsb7N858T0Got3o/pU/SijgS9TWmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739301715; x=1739388115; bh=4CMMII7gg+S8ZOua/g5opUsXHaf674ZZLjj
	OpdOjwqM=; b=M95Iwyi6FtMUh7KPJgK56Wce/ol4WOjqun99tTLR3eZjBJ1KvCG
	/iqKQsfU7sGOuerb6/qDJg6j88pFxwSRG+GHAQ8B0iaFyA9pxM0mq8yMgdak5C4k
	SpQsVAx4GQ3yXT918CeeU4ozH4WjhUOoEM/1XYz/mh8sdKhF+Ns6Tibrko24g9Gj
	KEw/7ugiEuAacIkqxI+UOgkgrRKKjYH4bWSK4bgeZpc1B+xEjxe8Bkx91gXHV/cj
	5KVs76A9L37pziRP7TOmg0QTKfvBn/GcvxifPVkChPosFMPl4jfFYcYokxxjfn5f
	lBvsAdaZ4DIXEs6yAo63CXTjpgXYorJnSPQ==
X-ME-Sender: <xms:U6OrZ59UBYN-cFuUVAg1HUTC2A-KvdIGR5abqEbWIcEDnO70U8Vunw>
    <xme:U6OrZ9v91b_sCtxu66wg1qC57Prxo9R2ELtqAbe8Si0fkcxSNUQCSBoZ_sTWfQJnV
    mya6vod980qYXA-xkE>
X-ME-Received: <xmr:U6OrZ3AwdNfjAI-szRwK1zvGJ4MkQaoMkDJ_lRNg9DR2R34TVispYQ0gqlJsbN0_mVmRGJylH5NuUtAxgDH8338W6syNm-8Y5hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepudefhfehudetjeeutdfhvefhtdeltdfgheefkeefleegveev
    tedtveelfffhiedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
    thdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    hosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoheprghlhihsshgrsehr
    ohhsvghniiifvghighdrihhopdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopeif
    ihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U6OrZ9erICxeLKtv6LRcbSWf_u5GLNZ9i4lTMgfqxre8ndwsGs8jTQ>
    <xmx:U6OrZ-MYxDweROPJ9p79fDIf7AD8irrFJGtIkDHdI8ztD3q1iIzbiA>
    <xmx:U6OrZ_kmBVpDMbmoe4CARgdr7aXORa4zf45F6JPMOeAw3CuYclXYqA>
    <xmx:U6OrZ4vfXkODZch2zGpMRRxixhJGTtKwlqSfNW8UflKv_hk17rYx3g>
    <xmx:U6OrZ1pwJBCZX0WeuuCRjO1xQVKskjEe_pnW_ebS2OFBRQqfVc4qhonm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 14:21:54 -0500 (EST)
Date: Tue, 11 Feb 2025 20:21:52 +0100
From: Janne Grunau <j@jannau.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/dart: Assert !locked when configuring
Message-ID: <20250211192152.GA810942@robin.jannau.net>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
 <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>

On Tue, Feb 11, 2025 at 06:41:00PM +0000, Robin Murphy wrote:
> On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
> > Configuration is only possible and needed for non-locked DARTs and will
> > fail for locked DARTs. We cannot try -- assert that we do not.
> 
> Except now we absolutely will - if a locked DART and its client device 
> are advertised to Linux, instead of gracefully refusing to touch it, 
> we'll now attach the client to a DMA domain, firing a barrage of 
> multiple WARNs in the process, and give it DMA ops which still cannot 
> work. I'm not really convinced this series on its own leaves us in a 
> better position than we're already in now... :/
> 
> How hideous is the rest of what's required to actually make this usable?

The TTBR can not be changed but the preset first level table can
modified at will. The driver keeps a shadow first label table and syncs
that to the preset 1st level table on flush_tbl().
It gets more complicated by the fact that the iommu for the display
coprocessor is locked and mappings for its firmware and boot framebuffer
are preinstalled and have to be maintained or restored on
initialization.
This is handled via reserved memory with translation.

Downstream change to handle this is in
https://github.com/AsahiLinux/linux/commit/d90cc3590ea460e1c574b4b7c47fdafb2794af6a
not including the change to parse / handle reserved memory with
translation in iommu core.

Janne
