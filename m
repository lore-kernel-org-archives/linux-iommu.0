Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D4304966;
	Wed, 27 Aug 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297533; cv=none; b=ofrjo+gbhd+zintCQOR6ZtjRpxedN2WAYwEMjiyvAA3lMzv0kxJNPakij4daF+pJA7j0io90K4RfYgLUJQ+HRdaFk/VZ5PXCLb0SgpeY0cV2ixbqVvbSIEIrpTrPACRm5hUGrvzaPU1z/u8L4F0iLLqk1qNru1AVRzfGMcp24bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297533; c=relaxed/simple;
	bh=aMQ8Ki9oIp1Hd6pVpoVRnqQJtbxH3JlLvfdyaVkIDSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXt05Y5JoWrwUKrsuDE3ocgZE4z679HiHqSOPylZPMSrsG9yo+ULsrzAkZNvyFGPEbmykM1gWWKcaDYn/4aYRdi9Al2HhOKk/jTRZ5CH7wVtdEt0i3nLe01s/GEzkKB/NZhqjaMJ/fChENrAZ22drahUH35JbmcubMw7203Iz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=fhO9QFKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/r1W69D; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="fhO9QFKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/r1W69D"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E8F31D001C1;
	Wed, 27 Aug 2025 08:25:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 27 Aug 2025 08:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756297529; x=1756383929; bh=Yonvyw6arw
	x9K/j0aRnK/gLYsQrk0m8h8Fj24bZWVVo=; b=fhO9QFKWc4uMzrvn11qgmZ9pQ5
	t+v/nSm9aTWz8JSA2QMoXs6HlOwgfJ/H42DS1nDk+3NosbHqCT4z9Y6V8JTuV1J2
	OGzmQJi56NtNBMeJ7MWHg2M/Np1Vzza2N+Pfv85oUgrFfnELvGAWp8sz61lN0518
	XUKVyJcZe6PjcYjF2isYM11kSWqK8u6ygfEXO6ehdnHkxAO9tTMgqmQUP43cQatX
	Wq9q3MVergWjDFkDaj2TbePjnlK/1WZmK7PENaQFVJ3+wnvVSyfvIm1rDp0wHuM/
	s9wMKYppkiuHJBXQ92DTO0o6SZ9U6A8LT0V8+20iQ3foEkQFZ+NH0uApoSUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756297529; x=1756383929; bh=Yonvyw6arwx9K/j0aRnK/gLYsQrk0m8h8Fj
	24bZWVVo=; b=I/r1W69D/Ua2bm5BXK2wBOajLrzMomNKdk8LBzp8EO49mcvjLCw
	s182ej2tJ8QcSWmGYUtMEzThRDwe0+tCYLCUvWdAxwaqe55JOg0hYvhsnv6SfBg6
	OExTKM7VwVL7Df7X1EIwIBamnUu5fATbP2XZHvLTra6IRx6qSU6qd4LtEB3ZR5rF
	ixMb4Uyzby4voDlGtFBdxDsIJBPHKOSlt+U+oRDZ9y52VYYMhZhTatFXTB0GGfjs
	UWoP9XaabWAb+nJr0uUsdb3mls7gT7S8bfbiBkV16UWdN+xbnkLAJAkJOTTJN9EQ
	8hCjx1dq4Dx9i4D/ksR2ZP+YUh3JsyySpoQ==
X-ME-Sender: <xms:OPmuaCJ6XwkoODGu_w3yn-wMk6IszXtLN1WGKJ8PAk-bWWUCHeGNoA>
    <xme:OPmuaLflAXWGINpS3XvOwaH7Gexj3422hbdyShh9F0zp8v1VTkNx90LzRG2t-tATt
    -w3756kC4_Fd5eM-n4>
X-ME-Received: <xmr:OPmuaFKAD8tGP81yPe2nBq6lMF0ydRlb0Tm1Kp79wc7napXJ3V2GkIEU8NVYyjPnKxpFXMYfPpiEZJP1oT8eCbbTz51h0hLFVAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhvvghnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohifihhntghhvghnmhhisehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghr
    rghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohhnohhrodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OPmuaNCOOBPZgV55nrQZK9IFTHxW0mIUN89N-HCnFUtdif5869khFA>
    <xmx:OPmuaGi__3hZHC3DXxgOf5RShzzmzFqlH-f30MMh9ef1fYIj2NNsiw>
    <xmx:OPmuaPNBhL3_-PK_M3Q2JR0PkUrBaLaEDGJGgUrgmAOIGMIa1heY6A>
    <xmx:OPmuaFZ43QmRQmAC2d5W9hQdpVeoDBFhFwoVqpaWkjN4GVSmgTCTJA>
    <xmx:OfmuaCZfFzYt2huFIkk5sW9q3xEFfN6W3-dEaSfzmdnPr45f3ZX2RxxE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 08:25:27 -0400 (EDT)
Date: Wed, 27 Aug 2025 14:25:25 +0200
From: Janne Grunau <j@jannau.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Nick Chan <towinchenmi@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250827122525.GA204299@robin.jannau.net>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
 <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
 <8279536d-c4f4-477a-9823-3e7b452c3c33@kernel.org>
 <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>

On Thu, Aug 21, 2025 at 03:09:42PM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2025 12:25, Sven Peter wrote:
> > 
> > 1) For situations like this one where the generic one just doesn't make 
> > any sense we deprecate "apple,nvme-ans2" in the binding and use
> > "apple,t8103-nvme-ans2" as the fallback instead, i.e. just
> > "apple,t8103-nvme-ans2" for M1, "apple,t6000-nvme-ans2", 
> > "apple,t8103-nvme-ans2" for M1 Pro, and just "apple,t8015-nvme-ans2" for 
> > A11.
> > 
> > We keep the generic one in the driver for now but also add
> > "apple,t8103-nvme-ans2". We then remove the generic one from all 
> > upstream DTS files but keep it inside the downstream files we ship to 
> > users for now to avoid pain with kernel upgrades/downgrades.
> > A year or two from now we can then delete the deprecated generic 
> > compatibles everywhere. This all has to be synced with OpenBSD and 
> > u-boot as well since both also use these bindings.
> > It's gonna be rather painful but this would clean up the entire mess.
> > 
> > 
> > 2) We keep using the ones that are already upstream and just accept that 
> > the situation is a mess and add comment above all the bindings that we 
> > messed up and that this should not be used as pattern.
> > In this case that means it'll just be "apple,t8015-nvme-ans2" for A11 
> > without any fallback and we keep everything else the way it is.
> > 
> > I prefer option (2) but if you really want to get rid of all this mess 
> 
> 
> I also prefer option (2). That's the least disruptive option for users
> and inconsistency in bindings naming is just inconsistency, no big deal.
> You just need to remember not to grow the old items/pattern with generic
> compatible.

This sounds to me like a mix of option 1) and 2).

All devices / SoCs already upstream will use the fixed current
compatibles and thus are following option 2)

New SoCs will have to use
    compatible = "apple,t6020-nvme-ans2", "apple,t8103-nvme-ans2";
using t6020 as example even though they will be using the same driver
code as "apple,nvme-ans2". Using t6020 as an example I planned to submit
today.
This will require adding the new fallback "apple,t8103-nvme-ans2"
compatible string to the driver.

Asking for clarification as I could image such driver changes will raise
questions from the driver maintainers.

Is there a way do document/annotate the generic compatibles as
deprecated / "do not use" for new devices?

Thanks
Janne
