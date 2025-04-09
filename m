Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3899255E54
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210324; cv=none; b=WIfJZwgQTsX5JsS5kxh0uUTIW9d3OBuq5daMk7gyO4phi16M8BrVuiPMNtRA6+jlZiTiJGl+mXsFKOvPzGz4d41hOD1yeQxYeq18vBHtp4HyQKfvqIwY5Bl5KzQnLsQIY0HQrwUdMP8n70wh/t3xjS029lAmWvneeCiZXljOa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210324; c=relaxed/simple;
	bh=llgPJEXjCJy6+OUBquEX9KlfCwayZHNIKLx7BNesWG8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n6tR0mYMCx++agnaVAnY3XQBzYf2lVi3yMfRiNd4JAovQkauFyxq9awfhNU0GZZFuyPaVW/b/n5BANOjaXbqIpnKL4sCBm40qEVX+KC11E6Jt2RPR1VKDE+NhhRnC72/nQP91w2dVc6jTT8+dpVvHZA5oIsJjzDfTRUHO3Hd4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l94rsPaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEwoMKJz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l94rsPaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEwoMKJz"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E72AC1140133;
	Wed,  9 Apr 2025 10:52:01 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 10:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744210321;
	 x=1744296721; bh=UqUyvWXf42+ShfCStTQPwTm+Gc+NVPPqoJJBRXTGY6Q=; b=
	l94rsPaMZ2AIzwAmPVkpk1ySlIyY27Cf0nrywFMqS+Smy6lUHPumfQXJtUjUG9QI
	s4RfCf3/pyybFllENoNX+CaOd8SarzlCpXvd3+Cb1LDRYwtaPqeGCVR3aOU3kYka
	ZFI5QUoDnRWXbnEv7cwzTsvdNnuzkMnn/O2OnHpi7NxXbgpReANl4lJOMFzI7bBh
	AjSErXjP+1o+YmRElNiNdmJX5cJNw6EMmRD6nN2PAisNUbYGpKB8VGE9VawIw2HP
	OiV49WKMUeoqPuHvtlBOlirnu9jjtcliPVmQD22UBx+QFv9bTUoR62oF6Ifg+RTF
	5STkTIEl4M+3XMDsbVuUIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744210321; x=
	1744296721; bh=UqUyvWXf42+ShfCStTQPwTm+Gc+NVPPqoJJBRXTGY6Q=; b=N
	EwoMKJz7ETYWrNLi/AnnHwvwGlK5wPAsZel54zY8PZN2uagaqHkHjjJAAhvZojjD
	v/81Dk5aq8Bgo7sjE8N5QYK6atXb/NbMjGvIQrvgKKiOizn/pO0RR5HpqkCI3ADM
	XjeCSYE8wwDKZsYcB/DFLN5fo2gPr4Ma2G+ciVZNbjlAJ5zpo9GcrMWFpebT4uML
	JzC4eglezDAy4LB/6VgrVQPZlD7lDN6HH/+qdLKdE8+ySmptwZAm6YQuk3ifxgJz
	sPFwwOOAZJzK8Y2Lql/9q1BNvTjCGfqusT+wQX9X5eM4dRlpwpT10RgvCPI/dUnx
	/yYTvvclIShoyty2NQh5Q==
X-ME-Sender: <xms:kIn2Z_jmVAsC8ajcYggXrY04szHM-ezk7W_Rme9AOr_kJrImM3xxaA>
    <xme:kIn2Z8BDP1_WyILQNJNleVnUoR86S6txFFugkm-ygEmWi9Zp6BOicBte_9BKHK3kp
    kO70ON2m52gzS9O1pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihse
    grrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprh
    gtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghl
    rdgtohhmpdhrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopehmihhnrgekieesmhhinhgrkeeirdgtohhmpdhrtghpthhtohepkhihuhhn
    ghhmihhnrdhprghrkhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehmrdhsiiihph
    hrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kIn2Z_GwLlGnou0aAPMMHcqHmg6naU49QTiNB-d9wmFN-CuoOWb-Mw>
    <xmx:kIn2Z8RI6eR0QYmQTfuc59LK8HPxFNdhev5Yk4lCg7q-zkpqDqMYEQ>
    <xmx:kIn2Z8zXp1fu2xoNHvQvkExkXOAdqGFZMXO4NQHiOegc9_7NH_SLzw>
    <xmx:kIn2Zy7GTndunjsAd2d74KO-03kJD1iXSKVipE6N39Q6RpfIAFDtqg>
    <xmx:kYn2Z_7NjnrIy8kiB_HGXP46R8ZQkCFSQEwqr2bQx-fT4QwdMAvnp_TI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B068F2220075; Wed,  9 Apr 2025 10:52:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Tf610c2eb90ac91dc
Date: Wed, 09 Apr 2025 16:51:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Michal Nazarewicz" <mina86@mina86.com>,
 "Kyungmin Park" <kyungmin.park@samsung.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <3f3ed85e-187b-4b06-812b-fe34e23511d9@app.fastmail.com>
In-Reply-To: <Z_aHdH7Ei_cffeIL@smile.fi.intel.com>
References: <20250409122131.2766719-1-arnd@kernel.org>
 <CGME20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a@eucas1p2.samsung.com>
 <20250409122441.2875424-1-arnd@kernel.org>
 <59af67fa-ca0d-48f6-8b78-b1c694af9dfd@samsung.com>
 <Z_aHdH7Ei_cffeIL@smile.fi.intel.com>
Subject: Re: [PATCH 10/10] [RESEND 3] dma/contiguous: avoid warning about unused
 size_bytes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 9, 2025, at 16:43, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:35:57PM +0200, Marek Szyprowski wrote:
>> On 09.04.2025 14:24, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > When building with W=1, this variable is unused for configs with
>> > CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:
>> >
>> > kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]
>> >
>> > Change this to a macro to avoid the warning.
>
>> > -static const phys_addr_t size_bytes __initconst =
>> > -	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>> > +#define size_bytes (CMA_SIZE_MBYTES * SZ_1M)
>
> This had phys_addr_t type before, do we still have the platforms when it can be
> bigger than 32-bit integer?

It can certainly be larger on 64-bit systems, I think I messed it
up. Marek, can you fix this to put back the cast, or should I
send a patch on top?

      Arnd
