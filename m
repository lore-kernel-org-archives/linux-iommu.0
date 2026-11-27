Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787872;
	b=UwPQD7iQrPzRtuQMj/heCtQIcE6L3bxgaZtJcUGlMhscMJnUZc6Cro63MmX6Hl9f4/Pi
	 jTniLSEtRzLYLhGwmUBnX5zgUsMtB8lnlzyGSCUOjbAKwpEPLUq2dTtHxJwnQTtTCzTpN
	 PUBJvtKZEaTYu66cJ1LhN2iBR59TheH7XuoY4/K/AvXwSlDz000chzFAdWN1m/IoayMgG
	 LbVo3bMM9MOMygzPWUyVfz86uR2J4IRr4UIZEEgkIyjDNPfXoLf2lEkHGtmevPjKwzPrK
	 hSGm6o9F2hE3+q6UwPmaHP2K3/QenOcMpMBZhFvXQf076JqbhLckHvPGrux4T2dufWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787872;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/f2Rjil7PMsu5fgbkOYg0CtvxSG41oXOLBLAUWnSHOQ=;
	b=1tL5HWT2zqs6t/6kc8dhK2cA/qKD4XrhB65+2YQ4RkVN72tIbXGrwxrjnWlk4C4q9Mbc
	 nizKt+KyIlBnVY8vrvi5Poc5nGZPw2RSWlzt/OaZTc23Y5biXpNVfXC+/8i3bqFdBWDTM
	 3308yL6W90OtyYyC+0ROCiknpJ/NlMvMY7Vi5GbFUyhxNVzqyLf1ucqiqT5fIPE4gG4mY
	 hKbwZlXFEHogUCkgqccTgiV5GjqIBOXwfq+q3fq68+Kzz2AUd/84vkjCxc///zs3iaMEv
	 R+BWzSe2EJ4rJYPhEiXWx8ZJrRDSmhRaPW2igWTSrjcPOHvVbvrK7RaIJEMFsxBRjUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=sWaM3ZVA;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A494606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 13:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A494606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=sWaM3ZVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795787866; x=1796047066;
	bh=/f2Rjil7PMsu5fgbkOYg0CtvxSG41oXOLBLAUWnSHOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sWaM3ZVA1i6iPF81IiUvQjgOXb9J9GItQ6ZZlATtU4T4wjbQhAr3VVld7PN4u16rt
	 09G1VwzMokz12JZxoFkPnANe3b2c8OXxc0bRrEiMN25fRgLvZvVWXqDnMEDZN7TsjY
	 NW1Lk8CcqN0KPMncGYDIkr7MYRrLmAB5l+Ok24DT9V+cywn/RHtAlYf6+TO/wp78C7
	 fH1UWStUi9DVvlGCZgeh7El6G8XpkRNwlgplL7kXLVExAC6cVrrlsUNcc+QRgLCZXU
	 1acG5+EcKUyXeezi3QkXrbG1V0HNk/UjOPIdnpBRdw166ZCk6L4s0dxRk8v4FpBUZs
	 zpjm0Oy+3pF2g==
Date: Fri, 27 Nov 2026 13:57:40 +0000
To: Laurence Oberman <loberman@redhat.com>
From: 70sp <70sp@protonmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Thorsten Leemhuis <regressions@leemhuis.info>, Tobias Laas <tobias.laas@posteo.de>, Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, regressions@lists.linux.dev, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
Message-ID: <l7ImnFzOgVkMzGhZoxCBcI1dAbMnO2NlsstuK-4sh3CyOpWhWAC1RqFIr4CW82iTy3FZe2r1k4EFFtecv5PClmy_mvh10vI9W_W5Z5p-jlo=@protonmail.com>
In-Reply-To: <e_efhbm0Vxq0FxO3-QqPkyhGrjzTvBDYmUOsGgmebVSyd0qsXXxYFXwC9sSjRAP06gcpsttHunBLtc0Mmt0cIjEI_0sDXL61lnxHhmuaxWs=@protonmail.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de> <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info> <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info> <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org> <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com> <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com> <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org> <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com> <e_efhbm0Vxq0FxO3-QqPkyhGrjzTvBDYmUOsGgmebVSyd0qsXXxYFXwC9sSjRAP06gcpsttHunBLtc0Mmt0cIjEI_0sDXL61lnxHhmuaxWs=@protonmail.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: dfc8998b5cc479a8c6e040b1acb68bd2a7137075
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I have taken a look at the patches and the entire problem much more in dept=
h, and there probably isn't a significantly better variant to do this.

In the state before the regression, the kernel was assigning smaller page s=
izes for some cases, so it wasn't ideal as I thought. I also haven't found =
a better place for the quirk to belong as there are already exemptions for =
specific platforms in the code (I thought there weren't). This one is proba=
bly fine.

I am sorry to Bart and Laurence who had to handle this. I thought my patch =
was bad, so I thought the same about Barts, but it looks like it's the corr=
ect way to approach it.

I was told to repost my patch formally by Lu Baolu ( https://lore.kernel.or=
g/regressions/d931a389-c143-4a6a-931c-bc7025bcefb9@linux.intel.com/ ), prob=
ably because it fixes at least my case.

I think we should wait for confirmation from Tobias and if it's positive, w=
e can send out the final patch closing both cases.

Thank you for listening to me.

Best regards,
=C5=A0imon Posp=C3=ADchal
