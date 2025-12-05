Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F8249EB
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965329; cv=none; b=G//YRmnFb0iEauCSrW1Po/vS24m+0gh62EqH/cle0PfWEMDpmlO2EZonpnrhtZfq53HFjPehDQj8pcedIqt4Lba/VLwK8pQL0kWY/xIdRGFBiKIqUo/DXCtqdd2TuLVc2Bz6PJ3Ro0ftsZDRq29G6+LZGtuThx0gjRYcZ7Z4dyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965329; c=relaxed/simple;
	bh=RQNzSOVRu6ML3CKoH2Lg5TxGL+6CRBqOJcYs3PMXmys=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RGqUOePf3bteV2NhlkmvjT+cJo/gjp8FFIdDOvub/Jm76Xz+cSVHhDubLXLg+4MetLhT482uy/z0XUc8Ymr4PyrF4dFINUmNo7eHhMa2r89FbFcuEFwKmDFDzvxSRCljLjRZJE9Zx0jEtdrbFyr5hILh331pKrVVciVpCYdfdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NE+QsGij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETEEIwvq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NE+QsGij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETEEIwvq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A5D87A0062;
	Fri,  5 Dec 2025 15:08:47 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 15:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764965326;
	 x=1765051726; bh=laUVS7rSddKpXbclRv6xu9qa0cYH2M/rZ+av1JzmBw0=; b=
	NE+QsGijA7a9YI1+C4fzkYMZ1jWiIXWMktXb57h2VdSzJFCarCf4/UNrRA+X6Gmj
	uN3ZrHhhIHsTsIU/ZnyWGCkXTjjwY2d1/zvR/jgJ8xqLtGxs0QpqoIRe4i8zhe2y
	/boqxvHhu/aAoTBmbF5fKPXQqjXDgcYHQmbnvmnAFmIR2jgcIhhaMS4F7Eh9oSKr
	nYyxEV+7eTnHLGWOgWOoSMUaAI4k+JEeTZbRSFubGMiHw2vErzqvuaK70orXSvO1
	Dxf9ab3ExLGT9yYamGmv40U41GftxvKAHNRYfutmwUZ9SK+2NmKw2ekC3T2FzLPT
	orNfeCG9FyWc18MSgzQWiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764965326; x=
	1765051726; bh=laUVS7rSddKpXbclRv6xu9qa0cYH2M/rZ+av1JzmBw0=; b=E
	TEEIwvqAhryvmEV1/zYT0EAEc2ilMHSa88eEhMmxehpaZIOi4E7eUm6foCKi7BKw
	YroN9YU8Ohf6c4HGiie4QM1daoQi4D6QJmHbxd2SCWW3lQ0mGi+Q1OJaRj3s55N+
	pGqsPsb0BS8EL15uu5B9nHetE+PGVekGt3jbt09Foe/fdXE1VnD+H+BtxjtFtkMU
	5TpoUUXDzGS1PWtzMXr2gocZ4J45t2NJ3IIBEcxur+NDihesli730m4l6YDLeS8n
	UtJ0PLRHYLz1eL6Iky4srsHa0b8j9ySNPNqRi6CunFuZire57dluu/yM3RcSwRa1
	io4tXjfBYHA24cjGN7U3g==
X-ME-Sender: <xms:zjszaYYEOYSsU5Jxpo2fenKHF7kBaKvmYYnX1jmhVnl8Gh3g1ycGbQ>
    <xme:zjszaeMkbsGuGca3UFrvgaPpq0YjrMn558RMauNaBnba8WNjae1Ow1ur3g7kxONU_
    5BRMVyI0maRxMYVtQOgV_qwct_M5-ul5KrkO-LHuC4DjXB0xZzwgMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoheprhhosghinh
    drmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgt
    ohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehnihgtohhlihhntgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:zjszacDfP3KT5gJYhNDGQEbHCQ4D4NV7Bd-3y1ss3OROwmfQGrdUYA>
    <xmx:zjszaaUvaoqWh7-mqGDUG8Z140ZftppH9qUeiyc1UpuOG3-vsSmPlQ>
    <xmx:zjszaa_AcSBls_tQ5WqrPh841BBXOvdFObCj2qdKfwfs1gr9_ra5yA>
    <xmx:zjszacSBjpnu8sFitC5Em_r9-JDz4PuNaj7idDy_gt-vxK8WGj06Mw>
    <xmx:zjszaTVttfX0zCfK-l5PzNzLL1y4uQIdR97l2QTC6-MXsa_3KFVF3c6B>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16275C40054; Fri,  5 Dec 2025 15:08:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: ACXGss9Kb1kc
Date: Fri, 05 Dec 2025 21:08:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Kevin Tian" <kevin.tian@intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Nicolin Chen" <nicolinc@nvidia.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Baolu Lu" <baolu.lu@linux.intel.com>,
 "Alex Mastro" <amastro@fb.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <c131ee04-d047-47c8-8fa8-5d52763bfd5f@app.fastmail.com>
In-Reply-To: <20251205195009.GN812105@ziepe.ca>
References: <20251204100333.1034767-1-arnd@kernel.org>
 <20251205195009.GN812105@ziepe.ca>
Subject: Re: [PATCH] iommufd: fix building without dmabuf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 5, 2025, at 20:50, Jason Gunthorpe wrote:
>
> I picked this up anyhow since it looked like adding #ifdef stubs to
> dma_buf.h was going to be a bigger thing
>
>> +	if (IS_ENABLED(CONFIG_DMABUF_HEAPS))
>> +		dmabuf = dma_buf_get(fd);
>
> But this needs to be:
>
> 	if (IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> 		dmabuf = dma_buf_get(fd);
>
> I fixed it

Ok, thanks a lot!

      Arnd
