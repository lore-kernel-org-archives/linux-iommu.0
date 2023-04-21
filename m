Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28315670
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 15:09:39 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6014B15EEDB;
	Fri, 21 Apr 2023 17:09:36 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1682089776; bh=BWdF8z+Q4fHskCMdX9OlN7iuNNB0swY4xAF8ICY1DyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=4WKHAoTZ1XkQpR4HDx+niy1Xp297GkNpDbpU02kcMSoqrBRoCq8rG/OISPpMuJxuy
	 q5RKezTTYGpdkIEKkgR39K8Aq9G16B+P5b1+S7+TpVNnArPkjEewCEUwVyeb0ohWOi
	 lzdp8loaooCtfN67mU3OiWoi8hHTiKKxBtAyNQgF+4iVLFZn23l6ZkQ6/3IUd0dFk2
	 hiHlki0XcnRaCFkxbRqGKOGuxlMQsLKZEejcd4m3zxFAx2MsGROJVLRSxFGE8HQeST
	 TbISxT3HqlwcMMqxXnkRQSX7jUCZ/RRdUGcuKSw0zbbtmX+Ua12CM95aRbes3PgYMi
	 nLjBQpYggDqJA==
Date: Fri, 21 Apr 2023 17:09:34 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Borislav Petkov <bp@suse.de>, "Paul
 E. McKenney" <paulmck@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Damien
 Le Moal <damien.lemoal@opensource.wdc.com>, Kim Phillips
 <kim.phillips@amd.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>,
 Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230421170934.185a03a0@meshulam.tesarici.cz>
In-Reply-To: <4bd8ce51-5874-0aa3-bc82-fec0cee9b8f1@arm.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
	<0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
	<20230328040724.GB25506@lst.de>
	<4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
	<8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
	<20230407055704.GD6803@lst.de>
	<20230407121555.4290a011@meshulam.tesarici.cz>
	<20230421150349.35966e0b@meshulam.tesarici.cz>
	<4bd8ce51-5874-0aa3-bc82-fec0cee9b8f1@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Fri, 21 Apr 2023 15:58:18 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2023-04-21 14:03, Petr Tesa=C5=99=C3=ADk wrote:
>[...]
> > Here my question: What did you want for DMA fields?
> >=20
> > A. Only grouping those fields in their own struct?
> > B. Or move the definition to another include file (cf. MAINTAINERS)?
> > C. Or store a pointer in struct device? =20
>=20
> dev->dma_parms is already this, and IIRC still has some very old=20
> comments somewhere about consolidating the other DMA-related fields in=20
> there.

Thank you for the hint! I have actually seen dma_parms, but since it
can be NULL and was initialized from various drivers, it did not occur
to me that NULL simply means not DMA-capable.

This is really helpful.

Petr T

> > Since you mentioned "allocated", it sounds like you want to achieve C,
> > but:
> >=20
> > 1. Is it worth the extra dereference for every use?
> > 2. How should the struct be allocated? Presumably not with kmalloc() in
> >     device_initialize(), because I don't know how to determine if a
> >     device is DMA capable this low in the call stack. So, should it be
> >     allocated together with the containing structure? AFAICS this would
> >     mean changing nearly all device drivers... =20
>=20
> The bus code knows whether it's a DMA-capable bus or not, and as such=20
> should already be providing a .dma_configure method and/or performing=20
> some initialisation of DMA fields. Many of the ones that would need to=20
> are already providing dma_parms, in fact.
>=20
> Thanks,
> Robin.
>=20
> >=20
> > As you can see, I need some more guidance from you before I can start
> > working on this. ;-)
> >=20
> > Petr T =20

