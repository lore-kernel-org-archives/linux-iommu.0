Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E1EA65
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 11:10:19 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E319316D40F;
	Wed, 13 Sep 2023 13:10:11 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1694603412; bh=nomKvVpsDcQnPzW0cIPIUZLFN77yRrYe89HxEBAADPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTbivdtESa+u7FHVXEhTe0bqxjWPB4oR+xt/ONwZ9B235wM7Lw6ohpX95pD/qqJoi
	 mqW6U126ev2jJDV0qXiKuat7bF+zhjrOtcn0HKBWwBzgH6rN+N6ak06qX5k/09D6Pe
	 Ifdyauui05xRvfrpj2h924bwet2E4DH/xJfcn/3NmtfKf67EyiWRQ86PX8fhyPHj66
	 41d01l2vrjvMFWkreEvru/upJ5NNCSYYmgVYsVTiAc/sFTbWsSbd6eaa5IX6ijlSUB
	 xJmH45ZjKTN00fhSTkCy1vTTkFIPEP2ANawMAZohhwpnPeG5U4TSys3yeZnWa0h05Y
	 T0q+UYzSS0Qlw==
Date: Wed, 13 Sep 2023 13:10:11 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: add the missing dynamic swiotlb check in
 is_swiotlb_buffer
Message-ID: <20230913131011.1eb23294@meshulam.tesarici.cz>
In-Reply-To: <20230909084045.GA10357@lst.de>
References: <20230905064441.127588-1-hch@lst.de>
	<20230908144418.3f078dea@meshulam.tesarici.cz>
	<20230909084045.GA10357@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Sep 2023 10:40:45 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Sep 08, 2023 at 02:44:18PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> >=20
> > Not quite. This code is not SMP safe. I believe that:
> >=20
> > 1. the value must be read with a READ_ONCE(),
> > 2. the memory barrier must precede the read operation.
> >=20
> > Do you want to send a v2, or should I send my version instead? =20
>=20
> As I'm travelling right now I'd love you to take care of it.  It's
> probably a new thing and not a v2 so feel free to take full credit.

I'm sorry it took a bit longer than anticipated. I unexpectedly ran
into an apparent performance regression, but all looks good after I
fixed my test setup to compare apples with apples and oranges with
oranges. ;-)

Patch coming soon.

Petr T
