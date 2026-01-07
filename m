Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40973277CBF;
	Wed,  7 Jan 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821023; cv=none; b=c6DtczoYcvhrm8qT8M4aQ1wV5VWnuVOwL0JhRPHdO06e4B4ZrNiz2G/y2gD9dPSRplWiMClfGXTYIehPNDjqfvzicgUf2du7dlUwu6b/Xith6T4HH9+8kIf1irMOHtNRAoyDQnGtgw3EkBwTZ59FqfJGqbP7fb4UfmXiA/BbbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821023; c=relaxed/simple;
	bh=AnEgegXmP722NO+LZOGd51p9DTE89Pxwhfs1+6Jqhzs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mH7KIbukVsQgHb6WYdvNeTb41anu2S/tQxtAZvb6HyJakipKAIQc6MN4rjK3Fs/kA1G3vubT+YbQFKKmqEHP+RxHXvXT3KhaMSG2M3idQoO8mv33a7ORycsaC+ft3ll5F7lb8izxRYOs9MtCmDHqfSLidlzz3xzZv1nC0zUvI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaB6E9EA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaB6E9EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA1FC19421;
	Wed,  7 Jan 2026 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767821022;
	bh=AnEgegXmP722NO+LZOGd51p9DTE89Pxwhfs1+6Jqhzs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jaB6E9EAEHXXgCjnYNkee+3uuMpNKI9fQMbmLf2pfb92GuDz9fJ5MhBBKD4q+hSFU
	 bVMqfu+SHaekV1EgsFQEiwQ/X9dZvqp2KhX/CrNqiHbJbJE2REYDpOak1yXCqKbErh
	 Q567PVrivu8AyFqERtLxRhLQdv8utbwNxtkPaNWZeag1UB6xCyQCsdfffwN66JNxO9
	 3uwY8XbUd0MERHEVjymMnCzEX4IZmLLmvMFGLAnuGrowFeAlCO4Aw9PBLKv4EpwR/5
	 eAtl6l5KPuZutDL510pVgmHOH0/iYp+97y1+ToPSZfNEo3eWL35zzLJz2HPtX21oI1
	 09ovm+Xe6NT8w==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 797C2F40068;
	Wed,  7 Jan 2026 16:23:41 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 16:23:41 -0500
X-ME-Sender: <xms:3c5eaRoG4iztyBuo2Y7qlu4YpM6HNCK993bXcUJI-_UFcsmjQSqoRA>
    <xme:3c5eaefIPjXe-Xicp_iQvdZlytzq53K9kSmYpinA06oW5vH6GXaynb_19vWkLra_Y
    bJUClJ7EMTwUbhZ-GdXaS_lMinn0Mj3LkmJWfWC6IvfdVCLax_qsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehr
    ohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehsuhiiuhhkihdrph
    houhhlohhsvgesrghrmhdrtghomhdprhgtphhtthhopeguihhgvghtgiesghhmrghilhdr
    tghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htoheprghnvggvshhhrdhkuhhmrghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhhsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomhhmuheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehtrhgvughinhhgsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:3c5eaTOWPDYbPe21NQ2DwLHFAtfUZTwNqXDlQP1PBA8tPtiZAIOdcQ>
    <xmx:3c5eaZ2Ypi6IhojuyPpPE5GOlDC78LubiUSeI--6NI0HhfecUJfpQA>
    <xmx:3c5eafQjkzBsQkbnHYTASBraYOaB8JPh4xjz1mfA-vLwUmhtBaa_WQ>
    <xmx:3c5eacnxFFsfDsW1vgbfV7qVZWOpKbSPXSF9NttdlkoTyE4HdaD5yA>
    <xmx:3c5eaQPCwpQtNK0Cq_pvCBQx1rUhay5tjZa_p0CWiE5xfDVCw_ftZTIe>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 57D2E700065; Wed,  7 Jan 2026 16:23:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AdM-YOrL1Uys
Date: Wed, 07 Jan 2026 22:23:09 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Walleij" <linusw@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Dmitry Osipenko" <digetx@gmail.com>, "Thierry Reding" <treding@nvidia.com>
Message-Id: <bb62cb70-77ba-4867-b202-2947d383cf15@app.fastmail.com>
In-Reply-To: 
 <CAD++jL=fwYJ6onVsrM_=ffuqwR2zLJLJNSWWmDM+Ov02Gf-DyQ@mail.gmail.com>
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
 <20260105175323.GF125261@ziepe.ca>
 <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
 <0dccea36-0d79-42cc-a12f-5a890061ff59@app.fastmail.com>
 <CAD++jL=fwYJ6onVsrM_=ffuqwR2zLJLJNSWWmDM+Ov02Gf-DyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA allocations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 7, 2026, at 18:41, Linus Walleij wrote:
> I did a grep 'alloc-ranges' but now I'm a bit slow in the head
> so cannot really figure out if these will end up outside the
> linear map or not.

The way I see it, we have two ways of doing it:

1GB of RAM, CMA in the last 256MB:
arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts:
        memory@0 {
                reg = <0x00000000 0x40000000>;
        };
        reserved-memory {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;
                linux,cma@30000000 {
                        compatible = "shared-dma-pool";
                        alloc-ranges = <0x30000000 0x10000000>;
                        size = <0x10000000>; /* 256MiB */
                        linux,cma-default;
                        reusable;
                };
        };

2GB of RAM, CMA in the first 768MB:
arch/arm/boot/dts/nvidia/tegra30-asus-p1801-t.dts
        memory@80000000 {
                reg = <0x80000000 0x80000000>;
        };
        reserved-memory {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;
                linux,cma@80000000 {
                        compatible = "shared-dma-pool";
                        alloc-ranges = <0x80000000 0x30000000>;
                        size = <0x10000000>;            /* 256MiB */
                        linux,cma-default;
                        reusable;
                };
         };

With CONFIG_VMSPLIT_3G, the first example spans all of highmem,
i.e. 0x30000000-0x3fffffff, the second example spans all of
lowmem at 0x80000000-0xafffffff.

      Arnd
