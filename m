Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1A2ECD11;
	Wed,  3 Sep 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893215; cv=none; b=nHaSO1IIlWyYgo7hBuGiR8oklCNbKHTi6KIGotqOKdE9l3qquuyDEmhYBJX9ZW649xApAxOfEj+UFJy9Jd5HmdAnHlqZXy6QcW6M+S1AYl17JrFvFjitMG/qBIWVWw3D4sAwj59r7cjVbUwsJIkxWA9Pu6XJ87CqbvhUTw1la9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893215; c=relaxed/simple;
	bh=277RioR3basjGp9kALm3hs9oH+dbVhaHNkYk9uma6EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oou/AUIAQ4S1uynnClmz3oeFQXJBWkdH1djzutmArc0ED6fW+n6vibNkilm4xB+Vsb/dXFPi2b/y/5r/gyVFJiL2Ha0SYxzwAG83HlM0ELSvabfWWxLWOt9Z2YuofY2U4o7vIORzC4S9FEY5vSiAz0+9u4aXz+RxE34DU/Vpe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=pXoYO4uN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZpPJKSu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="pXoYO4uN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZpPJKSu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A797EC0336;
	Wed,  3 Sep 2025 05:53:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 05:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756893209; x=1756979609; bh=jNNb+nr/hF
	Kdcw+MyWg50Siwcv+G2MEA1WmLkk6R+24=; b=pXoYO4uNcVZuUx9Lb0lz/ceknJ
	VORA4T5rp/2utYlvIq/8FCigI1G2XxgMf2/f0gtvW20zmDflVKBUbuQwcjlkcLGk
	BCBXtv6OZjTs5CfVP9rBI8gloI+8kHsKA9iEfm5urKuWjK1c+XqnsFtzhGkYzac1
	pWC7Yb0rtiuvSSP5uBzlClipQA4dQOHtWxvF0MmcWEfXTvTPyulpJaKlcVDnKk69
	VExqh/IB8N0UeSYuyS36M33Vm3i/3xIheVXth8eCbUL4/WNPzcV9A8goig4tda9B
	fXwyxnIMZNQFS260aPWVPGC4abO/ls7C3t7XP52RQDLFd/OPdEgZA0wgpkxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756893209; x=1756979609; bh=jNNb+nr/hFKdcw+MyWg50Siwcv+G2MEA1Wm
	Lkk6R+24=; b=WZpPJKSuPdSVvsUz8WkC51Yhv7zyC3tkBUR6DeoxnRR3wM8R/mi
	3DDfpSWxr3nlfbv4g1zYSnehh4MZndgr4D/T6Phn3PuuYCDuujxHzDtPXGo08t9/
	YRY1yeyVra9XZAvf4FGa6FaFLh8GvPKz0mDJllwn9HF+dRT2rPPx4OpeRWbWsWFM
	aszLMJzSK/sL0BQ2ClWVNiDONcYJYTyHYu0VlEus2PoMhWJGsrxU1skSV1i9g+tl
	8X5FRWtFicWL4gI87JsUbgGh/s3PpjmN5mkhdLIAX1T31j1KdUD3NqEvrjyighzB
	mJiXM4iFrlJJDXrYnOnWJ8ElIL7ktYkMv8g==
X-ME-Sender: <xms:FxC4aG1qr09vvHwIJ4hRbt7dkIQxbA0fvsqT7xu7-Qa-EuI1Y0SAtg>
    <xme:FxC4aMkjjJBlZaG1qNx88mBDxwo_Xhu75G-jqvsAUqKkRP9XRf8eRjyuRp5rPUJ8r
    n4Wt8-hhISP1shtCe0>
X-ME-Received: <xmr:FxC4aHZ5L4UDCpYxS4iPuJ2jp77oF68P09_Bh3agX1CIy18Cb4gvlewcgjaINc4RmuJVrWjOvYwkXbvqBUJgZ6aLOCp95D_yeWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvdffve
    elgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
    gvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehhtghhsehlshhtrdguvgdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhofihinhgthhgvnhhmihesghhmrghilhdrtghomhdprhgtphhtthho
    pegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopehjrghsshhishhinhhghhgsrhgrrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdought
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FxC4aKpXGXfqNRJtXU3bKWXf82Z1HtC8gg6cm1QSI4juZ64CPJpJvA>
    <xmx:FxC4aNgClrkAVGxrPUSoA5iIA9dD-IuPEqmWHNN_kwc6d3MH4dldvg>
    <xmx:FxC4aMxWuRIbQ_rTseCZMo3e5lePw_bkoEo1iX_61QGtyH-FqaYTug>
    <xmx:FxC4aL8MmHW_zqynwVULmAhwl-4ii_YK6UIH_NVlSD4x8Q_GitvppA>
    <xmx:GRC4aNXiqaEM5KtsXta-J8fDubHw9ulAUXUwLhYT3ONsidDAlYyK2-Ol>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:53:27 -0400 (EDT)
Date: Wed, 3 Sep 2025 11:53:25 +0200
From: Janne Grunau <j@jannau.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Nick Chan <towinchenmi@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250903095325.GA89417@robin.jannau.net>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
 <89251134-9685-439e-b220-92717663f038@kernel.org>
 <20250902052646.GA11139@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902052646.GA11139@lst.de>

On Tue, Sep 02, 2025 at 07:26:46AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
> >> Do you want to merge this through the apple SOC tree?  If so:
> >>
> >> Acked-by: Christoph Hellwig <hch@lst.de>
> >>
> >>
> >
> > I don't think that's necessary since there are no build time dependencies 
> > but if you want to I can take it through there.
> 
> Merging it through nvme sounds fine as well, I just through up
> grabbing everything together would be easier.  I also noticed there's
> another Apple hw enablement series that touches nvme, so I guess both
> should go through the same tree?

yes, they should go through the same tree if they go in the same cycle.
They conflict in dt-bindings and possibly the driver. We should avoid
burden someone else with this conflict resolution.

Janne
