Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8D325739
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583705; cv=none; b=GNiMIr/m23XC2rs8N/s8K8Fkmzgb5T9ZFyOu9yHwAXDqmSzNNBAVWs4WcN4J5orO8oaiHhvS0k5+CPIGhs2PO4u9d7Xz17+b7+Hj59QWP8pf3Ad89YWVY2ip9sHIpLQMXu99D23qylTi1VPP2Lf3N/aIum55bgGMUzz1VqDbX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583705; c=relaxed/simple;
	bh=0FXrPczUOrhee8jIFsw7hgSARUDQ79vgAPF0FggUhmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aacXb9J8/eykIE3KBjYnQRQvWb2EvJRn6kbw/x2UDukCmncb2/yRB3zoh926Qb+GhOMvBf9CQZPV72lQ13QlFUxodyTICCYdXb/7bnfsrYoT0gvw08AKbUnTWm4GTR9JEY0e2Cd/vcIMrBtnaRq59g/VBfLQ/zAF9/LAdHbwHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TwLaUg8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvfkkKhs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TwLaUg8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvfkkKhs"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DCEC4EC0018;
	Fri, 16 Jan 2026 12:15:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 12:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768583700;
	 x=1768670100; bh=0FXrPczUOrhee8jIFsw7hgSARUDQ79vgAPF0FggUhmk=; b=
	TwLaUg8WpaV8Xx2UVWstYKzCsNhLiFt7WODmu8D8FGJ9QspjsDqsOgcOU37le+X5
	nTkFGvVV+w4fM5Faru2k0lFah88bfWIJmA2UYQ69I7Uncm8HpOWKqZtzo3CoajK3
	3Jyfu9eX0cS+YVBc6WdvN6zd4+GPe+iqH86D4icK15iJ7G0eHqFGgh9HCQ9y62Ui
	0d4VBz8KyEQU0gbHpnXX8gkrvejolE97u2I1zKejzKzctjtQCPNvYmDf97RwuukA
	ZS3AO0ggII5IMoVTBtvwJLywjKtqZ8zbhIlhO3xyGtMy0qJcX/IwXGfWE4iNdn+L
	E8Fw1uM+bmPEmS/1YN/7lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768583700; x=
	1768670100; bh=0FXrPczUOrhee8jIFsw7hgSARUDQ79vgAPF0FggUhmk=; b=O
	vfkkKhs4p7bsagtj+8NEgkFsNkypQxA6spXs1UeTIsrKT1OjO7C6VlDOSpHhbUNe
	bQXb7vzXvYpAAlO6n3g/xISHO1SF1M1JZfdrN3MBfuY18pxyiuOAh+BXOdsL4AdG
	AWUgcdsYcYu7Tx6o6khV1cRMlNNzNH24moDlEBJiBsoRrGJ6tGTJup1lKZkDMAXE
	IHZi0sZh3TqYY3EX4JbL+DUdkV5RFbulC9MkBr2XUAUJRDGBVqCZBvAMb0K1keru
	V+eTtp5dkbq3uzDe13j8JjnQH5FuE1hYWonI4RvSz3Mqd6r/9EmCwW+7n2w//cDg
	y/p3HU3j0TNOvv8OCgIJA==
X-ME-Sender: <xms:E3JqaaPLBfxjLJIjo4E3cGPEdKFUdUOR8YlJWnoFBQHZLBMlZVSMIA>
    <xme:E3Jqad39gRRu3uVpFYTQ8EWmenuebstBG0WBi7ie5Z5IPSYy0iSVWFrwDZYNZMwoh
    QI9qg-EozZQdwMP8SjSCIe6PPF6sT7EVuy_CFLEa-ENTM_cWG52eQ>
X-ME-Received: <xmr:E3JqaZ3tdWY7A-Q-DrFDrvkUhhrOwA5omQqQ3UrZcutWqN89h9-Xu4t94qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeek
    ieehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    gvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhish
    htshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnrghrohdqmhhm
    qdhsihhgsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhu
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhmihhtrdhsvghmfigrlheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtoh
    hm
X-ME-Proxy: <xmx:E3Jqab-IcKIyRwYG7LaoEKmTVhok3LWerbw8ijEnhTy0lXBvUyTZlQ>
    <xmx:E3JqaVa67f-xQfuyTg1R5CA8HkGyu_7wSpqHIAuZ5MruxoLYBKpv5Q>
    <xmx:E3JqaayEXDzqrC8NKLM17-V3qsjiBbNwtSSFKDCyCIWX5M5B1sRHUQ>
    <xmx:E3JqaT--ksTvLwQFeleOE7oFSUUqGYeC6jTpSJIDDdBI0rksznVNcg>
    <xmx:FHJqaSjNj8Cwr1Zg7Cj_qZiHrxgO23kE7kre3zKH90J67yxMYhSSbuSq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:14:56 -0500 (EST)
Date: Fri, 16 Jan 2026 10:14:55 -0700
From: Alex Williamson <alex@shazbot.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Ankit
 Agrawal <ankita@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jens
 Axboe <axboe@kernel.dk>
Subject: Re: types: reuse common phys_vec type instead of DMABUF
 =?UTF-8?B?b3BlbuKAkWNvZGVk?= variant
Message-ID: <20260116101455.45e39650@shazbot.org>
In-Reply-To: <20260114121819.GB10680@unreal>
References: <20260107-convert-to-pvec-v1-1-6e3ab8079708@nvidia.com>
	<20260114121819.GB10680@unreal>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 14:18:19 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Jan 07, 2026 at 11:14:14AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > After commit fcf463b92a08 ("types: move phys_vec definition to common h=
eader"),
> > we can use the shared phys_vec type instead of the DMABUF=E2=80=91speci=
fic
> > dma_buf_phys_vec, which duplicated the same structure and semantics.
> >=20
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Alex,
> >=20
> > According to diffstat, VFIO is the subsystem with the largest set of ch=
anges,
> > so it would be great if you could take it through your tree.
> >=20
> > The series is based on the for-7.0/blk-pvec shared branch from Jens:
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=
=3Dfor-7.0/blk-pvec
> >=20
> > Thanks
> > --- =20
>=20
> Alex,
>=20
> Could you please move this patch forward? We have the RDMA series [1] that
> depends on this rename, and I would like to base it on the shared branch.
>=20
> [1] https://lore.kernel.org/all/20260108-dmabuf-export-v1-0-6d47d46580d3@=
nvidia.com/

I tried to ping Jens regarding why the branch with this code hasn't
been merged into their for-next branch, maybe you have more traction.
Thanks,

Alex
