Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D762C234E
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480287; cv=none; b=KuqCvL/YBhVePKFHbw0qGz5JPr4rnB2JYt5j9xDBwp2Sb6+sRQCwuBYJG5kP/n+aDzHLBayd5KCoUHHg+b8ZqpghrxTZ+TJHO6vfHOsuiGr/ZExmls1iXtQYMz59RmSXbGiL6vSw3/HrISveNFtgN5ilf/oUQ4Y2dnARB0njKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480287; c=relaxed/simple;
	bh=ppdyTKjjA3cfRlqTgnrJu7zvJnDNhei7XnqO43pq9BI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BDAmo1rUQxKTRfvOYwisydlrEHuyAJXm5C84jHDP6CGZDQIUK5qQgtem3teLbOjDKLmnqIe09ncx34jEAr7OKTccyjbZgk8Id68r1KzZqnFdMCAwwwr7uzewGS+0Qo7GcdZmm//WZrr7KiyGyEoFkwuYjjlpr+K1GySuPBT654c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uXFP2pLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0EVz+XT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uXFP2pLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0EVz+XT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C49641D000A9;
	Mon, 11 May 2026 02:18:04 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 02:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778480284;
	 x=1778566684; bh=KmPiNvYodwvAgla7BPtVHRd3nfpBWvtXV9w4ndZPxTU=; b=
	uXFP2pLlOevVE1Czc3D036PQ0TwM9Wt0eNP5yrnf/g+KYDGakLaBFEWzKs7NOUjE
	cwUbxwtd9UUBaG9821AFYXcYxYCez1Ai/p6YUzH6aAwQTjdWNiZ4tKran/ee2Y3v
	vJBoEcHzTz4LsgCw9YakjPT1xl9JrjjrbmFvqkVzHfcncnvTuScUmUKH743ZcEfM
	uRJecjNvpsBz5/4r84oy+hyHmBUhemp5sKAmEt8ef4X5DhxmMuQsfIOkfFMys9HC
	qbA1dyvD/tLQlGldg+ScPEXDql6qnQ8rPktSXPOhe9SaAlBW5vJBqRPyZ18z0yVL
	6tB5F5bzSUdnt3aM8GSUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778480284; x=
	1778566684; bh=KmPiNvYodwvAgla7BPtVHRd3nfpBWvtXV9w4ndZPxTU=; b=p
	0EVz+XTAVgky9EdPZ4Uu3d8hd6y+DXAquqzD7JANgHh58AntQEQIIvP4+ybRE3eQ
	4rrlOxxKVtOQFw6Oc0JkLzvaxsATBfIOeMcH78qtYMx6uAYoaFIIjo7i67oSeKOp
	yZWCiKnhZRzJ7I8Yk3KqGk4nizqhWmD3EjVWBEFkQn64rLTFB/0SZkK02y6UzknL
	THe1KQvca4HrVtIrDi00WlkgTdJAp02CShHp9/q+W9II2nYNKyv3veFL14SIrmYz
	JFc1NlGcTHYjTOkfFI1LetYzlbH53uol6W3ntKeBYEyBhvIPIwyzovlF190VJAxG
	yNiwGxPR4F13TAbaNrAWg==
X-ME-Sender: <xms:nHQBajkJI9f3dFR1oJiYqT-ZzkMGeUPsvgNoroB80xTlRTT_ct5dzg>
    <xme:nHQBahr3Tt6ftyHc-T1kU-ENcZr7XwHCdqluFL5Svump7JW23rNMpCcHmJSK0qFxo
    Ca5kO1mBzvzxaC87KGq--eQlmJThafDf5WiTCTfsjbB66ZBl8aTg-bI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoheprhhosg
    hinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhn
    uhhtrhhonhhigidruggvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsth
    hsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:nHQBagL1K4BV80vBidQsid_aebAhwZbGvNlvcWCTDYjveg0-ecHjlQ>
    <xmx:nHQBaoUuIW329Pxzwgr5P59YRnx3qR1LQzrPzMX6ODXKeuDUNnAI5Q>
    <xmx:nHQBasQOAwmo1FJmzo0k64Gw6J4H6oaHB8cU6tEWbSsEfMvPWuDREg>
    <xmx:nHQBaoDnuYxaLASb3LDsTe5WSyqVh0xWey4mnSWkkzm-VheQgnr31g>
    <xmx:nHQBao923uMwYMT2LW2tfgYZi_91azd-oDyBZH5S7QJrewX7cGnwZIjy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05C841060065; Mon, 11 May 2026 02:18:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AVHaR-kDAB-J
Date: Mon, 11 May 2026 08:17:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Message-Id: <d52dcd45-959a-4ff4-9e82-0bae133785f1@app.fastmail.com>
In-Reply-To: <874ikf9i34.ffs@tglx>
References: <20260203162406.2215716-1-arnd@kernel.org> <874ikf9i34.ffs@tglx>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, May 10, 2026, at 21:31, Thomas Gleixner wrote:
> On Tue, Feb 03 2026 at 17:23, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> gcc-16 has gained some more advanced inlining techniques that enable
>> it to inline the is_static_object() function pointer into a specialized
>> version of lookup_object_or_alloc:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)
>>
>> From what I can tell, the transformation is correct, as this
>> is only called when lookup_object_or_alloc() is called from
>> debug_objects_selftest(), which is also __init.
>
> So clearly the compiler is buggy. It creates an __init specific copy of
> lookup_object_or_alloc() and then fails to attribute it correctly.

I don't see what else the compiler is supposed to do, it has no idea what
__init means in the kernel, or what the rules are for calling between
that and normal functions. Putting a non-inlined lookup_object_or_alloc()
into a special section without an explicit attribute would clearly
be a bug.

>> I have not come up with a good workaround, so this simply marks
>> is_static_object() as not __init. Since there are currently only two
>> files where this happens, that may be an easy way out.
>
> That's a horrible hack and while it's only two files today, this sounds
> like the start of a whack a mole game.

After thousands of randconfig builds, I found exactly the two
instances from this series.

Since this only happens in a very specific case where a file
uses function pointers to local functions and gcc is able
to turn these into direct calls, I wouldn't expect this to
become a widespread problem. It's normal for new compiler
versions to run into some corner cases like this when inlining
decisions change.

>> If anyone has a better idea for how to deal with that, let me know!
>
> Mark the compiler broken and wait until GCC people get their act
> together.

I'll have to retest with the actual release compiler, maybe they
changed something again that makes it go away already, otherwise
there is probably a flag to tell gcc to skip that optimization pass.

       Arnd
