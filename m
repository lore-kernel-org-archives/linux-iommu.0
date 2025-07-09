Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A476221561;
	Wed,  9 Jul 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079826; cv=none; b=mFyGgJc2H+FNKEmen1YqJ7sVBV4nb2tm+ny4mpz9CveXV1bngqteyPkJEo/iE9Baxb2qmPWA21S+//v+Z5/imMUeM3LwEpZ+2N85Nw38UoqQPVhdBm5aOrNSzIfgwcndljToA65yMxetdzq3XiC4kR64us3Dm1eOd3ZbIa6LCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079826; c=relaxed/simple;
	bh=uRJFN3opCJvLvF48qFkgVQR/0J++gtK2TFf7HTvfRtk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fRJ+b2na91gPnHisC6e4+LtTSNMBcYragTV59D/qwgIQm833lTT1oG1PlZZdUsCC05JyHvmbveIoDMN7jRbQgbj3qjInAo48JT+Bi63TDdgatmcMlHBDwQnTUeyZvC6wQx/enQnHnbBHZpjXq3hCfoDlWpf46jzSV/RN5QMQkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g8KckKUK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/zmeQuW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g8KckKUK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/zmeQuW"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 59DA5EC04AE;
	Wed,  9 Jul 2025 12:50:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 12:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752079823;
	 x=1752166223; bh=OSou9g2X5rWgmUt4tUwPeOuoZGApzk5on7vAfVCoqt4=; b=
	g8KckKUK+E3EGzaT32qAetoK95drorB98Ai9XTm5CdOzyPoiGTWSKDay2fySj/qL
	iw05/8yb9MhwtM2BTGFQuI1J2NdQFNmuFzYsQjN6+oCRtYcgSqFvkRmYnYqNav76
	jLmcdX3YgBVaK+W/H9FKmkEQjWdEXYliUEc1xAyPDx5qKCelO+JSZ+pi8vOjcuIu
	9tZrj/AlYj6+s7L5a8rFzUHKx8NX8TnFde/kYTi2yX8bGjUeSBhPlEi7sfBp0Dpg
	yXd+IYFXKrVMw/Vb77LCl6yJ6XHwHJEakvyzpwRuZhnP+m4M6Hw9DLSAoykYnwYz
	2aoL2lLy/y7Uth6SI7O3Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752079823; x=
	1752166223; bh=OSou9g2X5rWgmUt4tUwPeOuoZGApzk5on7vAfVCoqt4=; b=C
	/zmeQuWQ+Eq6eVW+9bTnwbUTDIcO3GHU2PH1Sq6Rz+3MO/vhGA/b6AGum6FSWGxZ
	n/+soUMKyiF0BPRhZTAfuPuoNIBkqwFulKVoOKAcbeu8bAZ2TYpiPWVUSnAk6iss
	xsybAc60xeYmIISsZH29ktI1h4I+AQ60sHyrqv/0hwDNxbSamxcN2WCz+7LnXs5F
	EAeKdrtqS0P8Eg0/RbWouVzF8TZi9SMMUTBYKEazrjQuH1lNfSm0NUpr6/+/WTKB
	Yi+mZLPY/AN3L8/6jpqbL2w5II1e2d5pfaMUe1gCsaZVV+rfmhGRf293o1NyLl75
	77uz3jYaTPFur40tV/yIw==
X-ME-Sender: <xms:z51uaGy4tb6Hb7F5LoxqO0weSLvc5TaFBBEwljvv0t6ljhgkXzC4Xg>
    <xme:z51uaCSqlmrGy_twvOnEHK2aUzYSbdeteqbNvtczyjRJ9Hxc_l-wouBroON-nYS2R
    4HVTzi2QpRRkw3DFpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtg
    hpthhtohepsggvnhhjrghmihhnrdgtohhpvghlrghnugeslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpth
    htohepjhgvrghnqdhphhhilhhiphhpvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    nhgrrhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehlkh
    hfthdqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehi
    ohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhgvghhrvghssh
    hiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjghhgsehnvhhi
    ughirgdrtghomh
X-ME-Proxy: <xmx:z51uaDmTqrQGe_e81FeCuDZkameCpAfSKoml1R1nrm8uYHvwO66R3A>
    <xmx:z51uaO-2cH4MadZULdBHpeVI2wM1ldkcQD4At8DTVzQQJg8uBM-p8A>
    <xmx:z51uaJKrRcrXG_fXlLJVg7H-Pmvkrd8STuQjZAWNVdsa0dejIncjuQ>
    <xmx:z51uaLi30dCB5Gt_ungDY541tSxYr1EEe2U_6N60u69qsZfurNO1Fg>
    <xmx:z51uaONmOU1UIoKA3TgD3UTz1US-5jxNMVv0cNuvYw5Bfh1yetZyv2kl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06C5A700065; Wed,  9 Jul 2025 12:50:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: T1b753d88ee99eed7
Date: Wed, 09 Jul 2025 18:50:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Nicolin Chen" <nicolinc@nvidia.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Message-Id: <ee234cd8-63dd-41fc-9a5f-94ffca21e2a1@app.fastmail.com>
In-Reply-To: <20250709162609.GD1599700@nvidia.com>
References: 
 <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
 <20250709002521.GB1599700@nvidia.com>
 <CA+G9fYtOZLYe7yN7EdaEHLyJgVypgKFO2R6POoiEZv7PcLw+3A@mail.gmail.com>
 <20250709162609.GD1599700@nvidia.com>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at arm_lpae_map_pages
 qcom_iommu_map
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 18:26, Jason Gunthorpe wrote:
> On Wed, Jul 09, 2025 at 04:14:26PM +0530, Naresh Kamboju wrote:
>
> I believe the original text was a copy and pasto from an ARMv7s driver
> (ie the 32 bit ARM page table) which uses that unique combination of
> sizes. It is not a sane bitmap for HW with 64 bit page table support,
> there is never a 1M option for instance.
>
> So this removes 64k page support, which maybe didn't even work?

My guess would be that this bug is specific to this SoC running
in 32-bit mode. This is a rare exception and not really well
supported, as most 64-bit Arm chips require a 64-bit kernel, but
this one (along with Broadcom bcm283x) can do either.

When running a 32-bit kernel, there is definitely no support for
64KB pages in the CPU, unlike on arm64.

    Arnd
