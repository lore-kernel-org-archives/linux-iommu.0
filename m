Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF6BE4F;
	Sat,  8 Mar 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427693; cv=none; b=G18wZb6tf5aNH5G7xdcEKjiK7/NLXePbcICR66Vye545+WXJPxkf/cTaVFJUPeyggRxTP0FVNulh1ZUOWYXeGd6SLWo4Uwu/ELIchqAnOcWpyHvYpyjyxCZARXM/9QvOEWI/vKt0QtDbhnFzU1xHYFvfm2EIZZU8QGc9toJLZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427693; c=relaxed/simple;
	bh=hzhNcRtCfxWSACKC/UtPCa8G/XdJxqGyTmH3V+EynZw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WQ3Kn4g3867hbZOG5YGTtLQMZR3MkovTl/vpyn7GQrZdc7TSCDfK4I2p9nWUY2p4ZpPaqT6G8dwZlBmg8+1GzJ4tnpXZ+jbiYUy+79IarZzfMFGDsHe74cuEuPkD2lvgX9zAqhHbPd+GfKAP44HPo1h1r4pql2JkcAfLgO7nGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=GY34UcPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlmGl2AW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="GY34UcPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlmGl2AW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70CA811400E9;
	Sat,  8 Mar 2025 04:54:50 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Sat, 08 Mar 2025 04:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741427690; x=1741514090; bh=hzhNcRtCfxWSACKC/UtPCa8G/XdJxqGy
	TmH3V+EynZw=; b=GY34UcPab4q4u3ZgyuiiGOEBSe3ZPRyWzfdIxpiwvo5BS173
	ir5jRDTAaColjSQLgxNwYuDzg4xh7xq2AejMaJGYhIGfMxwvvALMmbKnUioFuMCo
	UY58TxowS1hLBvYL9wX320hQW18ab2OeyA2T2kqKUMXMIJ2lYiy8JTnxZBi83Tea
	mqD89GA6oSgLJmiCJtu4r0+CwAZTlw2xcmM0UCAhs504zZ7qn8YDkjEcXwdqEncQ
	r380D5nXlMHCWO6uVCyfjxaZvvqa31FHpDgWPAR3fbgXEicZDpUGKnygwEYRq2w9
	cdyI4HoaXrCFKhfvKfsSkYHqw9iKLrALwIe1CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741427690; x=
	1741514090; bh=hzhNcRtCfxWSACKC/UtPCa8G/XdJxqGyTmH3V+EynZw=; b=Q
	lmGl2AWfK3CdyaBWVbRyKwtEcE7mhb/dqOjAbSBGiWo0GOTspQwWM8YapI4UhapM
	82D9ac4aTO/vZMlVCScjxBKl+JjqN53LxovpTOo0Sn+lTicVIB/0yecHV/fnBHoA
	QYyi+pwOxA75THCqSb6iYeuPoNAmCVPxeku+v2F422SeK58NAh1kSrV94MW/jH29
	fugfc9GVfzCkn2EzIiuGDqM8aHyF03LWm2UyzE+EyOP8LEQ3MCMwq3qjJpXHDyJL
	8gN1MDM+lm6G6GmPeiEnoBbi1qKHvep4fkPNg3sxMcUwMU063tEvz5MzXvXRfu2x
	Eb0pO1Mq04PV34D0Ffr6A==
X-ME-Sender: <xms:6RPMZw4BfUqZC77eEAGwtL2yvomJMkDMYVLEeR4W0Bgo0akQtAqZxA>
    <xme:6RPMZx4jCmuQlxFJL0VGNNjhSPYiw5Ywrwkk5vPdRsWBu5xw3sR2vBvDn_8f48bVF
    Q_3OxldQym_QqFvXO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepueettdelieeugfejvdfgjeevffdtkeel
    ieeggfffhfehheekteelhefgteegtddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgv
    nhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthhtohepuddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthht
    oheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepfhhnkhhlrd
    hkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgv
    thdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hiohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrrhgtrghn
    sehmrghrtggrnhdrshht
X-ME-Proxy: <xmx:6RPMZ_c_5gmt1HFlshi0xWf9s2bh3HDRNENfG9l9jj5bZYh6rJ46kQ>
    <xmx:6RPMZ1KSGIOo2_lpOS4FDWX0eoKJHLOy1mR6QSO00BPjzTWBlra-7Q>
    <xmx:6RPMZ0K9xyDF6pFF2XHGO3psVn4SI4dXT2KT3C7UXEAqIvCyPF8U4g>
    <xmx:6RPMZ2x9057KKDUqC78QsVxDJA-UQcq4_qeyBEgdgUEd3Ki102EoYQ>
    <xmx:6hPMZxAkgPTxMSm3WFjAdmZdQYMZ4EnQjFSGZ7PO4cb6ZMV0S0tepZD4>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83546BA006F; Sat,  8 Mar 2025 04:54:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 10:54:26 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Hector Martin" <marcan@marcan.st>
Message-Id: <baaf111d-78ff-445a-bad0-277895b34144@app.fastmail.com>
In-Reply-To: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
References: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
Subject: Re: [PATCH v3 0/2] iommu: apple-dart: Support the ISP DART
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Fri, Mar 7, 2025, at 21:07, Sasha Finkelstein via B4 Relay wrote:
> The ISP block has 3 linked DARTs with mismatched bypass support.
> This series adds support for this setup.
>
> (The ISP driver itself is sent as a separate series
> https://lore.kernel.org/asahi/20250219-isp-v1-0-6d3e89b67c31@gmail.com/T/ )
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---

For the entire series:

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven
