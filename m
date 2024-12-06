Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5F1925AE
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472892; cv=none; b=oF/7Sr84qnag5lwD6VKpvStol9a21AcaCHaSn1Q9QdhZ3UuXZp7FavdUzONh+aEPzJxzEwh8wY9DVspwjXiNc+/bxaDjkRy7nQIcxkJGNL+qwKR49Uxg+VE3K05N0m3jloDswuh2wDo8y2xCkr2UACIhKijsBkS1lAeNJnQq0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472892; c=relaxed/simple;
	bh=IAqIYw7gnawDzqJ7lK5JCZMKOi2tYNbQHSMiKtCtJwE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SS7/mp0dgdTsBpGFi0VF4LZdAvE9PGc6WyngAmgRPiMK+0DkVKQmEBUbcveCGgA63CEC5buPgfpaFJqfQEkUm0tmJlsq5efHGq74q0vJp7YnoC6K6694KKRHCdcMUMSDqQb9IDdRL5d9ctb087FL5DtBTD4rjqH9rGLt5p0aEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pXckWW2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sHeGb7qE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pXckWW2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHeGb7qE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B62125401A4;
	Fri,  6 Dec 2024 03:14:49 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 03:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733472889;
	 x=1733559289; bh=+CiivsHw0GsDv+l7OLvRGatcFJi5S1S1fcW7OKv42mQ=; b=
	pXckWW2sFQ19Sq6hj4ppyWPyksFTQbWWkIRoM1f3diJjY8Bwi6yTOwUG8SblLFkn
	mwlo6E2/91KSycR8HxkfbyUOeOknD6JSf0u7824fKWwZq+swDXEVQ8DJC2YSXK74
	U26WAikvXsViGfhRx8kqHdZWPSeWRU2ix5QmaTS9/ied1BijNAp1ubYpeYWu30kl
	iMNdfrTlPq2LRDs3Z+/ntwBoOc7DlJntFBnKWpAgt9jNQotposa0+qu4zNAHyJBN
	lg5rXfJyugiCVF5PapkhkAz5zXapfQGuEru0FPhNrejID2/cKYL9kLmXGu7yuC9W
	Swu/I9WmYRdjCfpNRLQZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733472889; x=
	1733559289; bh=+CiivsHw0GsDv+l7OLvRGatcFJi5S1S1fcW7OKv42mQ=; b=s
	HeGb7qE+mYbLrKhAyu0eYOOPXNyuaD/ERydhaCaBOSD7kKrkvOoM/xxoFu8uZ4EO
	8gpPWdCVnNdYZSi/EdGSIjdRpgcpXBnaccUTddH0QtOvSH2Q7RNaqqQebOkW3DHA
	ZghBNcXffg4JU+swnVIjQy9ca9AegicrWmkQczQRZzKOxA/Gcy3bgrexZ60nM4Dn
	6a/K+CUQTOMAoAxZZbSDU80qW1Nwq/+pGhhaXaTjZ67yoqVafxErByJfBA8r1N7V
	0AX1lIfLMw9HdLyRDvfqb5uo9NIwOnM9Zvp1hXUfk7JrW1J0Cp5bTW9UjcNa+phX
	1DZ2fq7Xw0PHwmqgUbS7w==
X-ME-Sender: <xms:eLJSZ8oEBU9sosKyjwR7pKq3xbj7uonUkEZezol8JTAejBhi3JYvxA>
    <xme:eLJSZyqingUbGotVfmXEmfiTf0cIt2SkcloadGaZLNtPdixxbrlQz3qGiEuHE47el
    tZqIcS7Fc19RAwybKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrg
    hrmhdrtghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhm
    rdgtohhmpdhrtghpthhtohepkhgvvghstghoohhksegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopegrnhgurhgvhihknhhvlhesghhmrghilhdrtghomhdprhgtphhtthhopehr
    higrsghinhhinhdrrgdrrgesghhmrghilhdrtghomhdprhgtphhtthhopeguvhihuhhkoh
    hvsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvlhhvvghrsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehglhhiuggvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkh
    grshgrnhdquggvvhesghhoohhglhgvghhrohhuphhsrdgtohhm
X-ME-Proxy: <xmx:eLJSZxMgVcxqz0Gs_wLqlipfmPu89jkBAV5-3b9JsHLX5Z7oX9D3-A>
    <xmx:eLJSZz4md8s0pf6otWcUcQ3Zjjbvm1JqurlGVtsbXCpinoCsQ39Ofw>
    <xmx:eLJSZ77Agu_PYpt_x9IpyvpJJ2urUw7oP-amPVz50j94u1lNRlWHfA>
    <xmx:eLJSZzhh5WctICoMy7-ZNMxQwOGMpmgZIrJmWIDaLwzhe3IG1BoeWw>
    <xmx:ebJSZ6R-G1r3_buE5ycNdcbYxfZcFyDuAOEJFck1nIxbxD4kvV9nr-st>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12DBB2220072; Fri,  6 Dec 2024 03:14:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 09:14:27 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ahmad Fatoum" <a.fatoum@pengutronix.de>, kasan-dev@googlegroups.com,
 iommu@lists.linux.dev
Cc: "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Dmitry Vyukov" <dvyukov@google.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Christoph Hellwig" <hch@lst.de>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Marco Elver" <elver@google.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>
Message-Id: <360e2ec9-556e-4507-a539-f86f7619fe29@app.fastmail.com>
In-Reply-To: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de>
References: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de>
Subject: Re: Using KASAN to catch streaming DMA API violations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 5, 2024, at 15:54, Ahmad Fatoum wrote:

> That way accessing a device mapped buffer before sync'ing it to the CPU is
> detected like KASAN would detect a use-after-free.  When the ownership is moved
> back to the CPU, the memory is unpoisoned and such an access would be allowed
> again.

Right. I would go even further and say that transferring ownership
to the device poisons an area that is aligned to ARCH_DMA_MINALIGN,
making it possibly bigger on both ends of the area. Transferring
ownership back to the CPU only unpoisons the exact area that was
specified, leaving the unaligned bytes around it as uninitialized.

That may need to be controlled by an additional Kconfig option on
top of poisoning the data initially.

ARCH_DMA_MINALIGN is between 4 and 128 bytes depending on the
architecture.

> The aforementioned barebox functionality goes a step further and also used
> the shadow memory information to detect repeated syncs without an ownership
> change. While this is not a bug, my impression is that this is unnecessary
> overhead and a diagnostic could help correct a developer's misunderstanding
> of the API.

Agreed, there is clearly something wrong if a driver does it, but
I can see them still work correctly without any risk of data corruption,
so it's a different class of bug.

     Arnd
