Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB91D15F
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JvxYc30U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702911677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zVnjHyqQWc5BKOZuVyXqtVZ1SSuv0CTn5G57agkpxTM=;
	b=JvxYc30U3o3XcUP9KCYuaqAiRlXEmu7FEtHtpVLDfuWG6DTSRByly2jUJMrTY5FSEkh+Zy
	J31T6Ay0HdWJtVTe9bAnwwjEBFg49TZmfXzxqM5UFLc0UjRNPtr7qzGpzXVcci54QtDRjG
	REkA0yMt1G3no+FKMew4X7DnYqVGHUw=
Message-ID: <b913c4163e809b28457a6c6b03551cbd5d2fcc7d.camel@crapouillou.net>
Subject: Re: dma_sync_sg_for_device/cpu look very inefficient
From: Paul Cercueil <paul@crapouillou.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	 <robin.murphy@arm.com>, Nuno Sa <nuno.sa@analog.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, iommu@lists.linux.dev
Date: Mon, 18 Dec 2023 16:01:14 +0100
In-Reply-To: <20231218143003.GA15735@lst.de>
References: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
	 <20231218143003.GA15735@lst.de>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Christoph,

Le lundi 18 d=C3=A9cembre 2023 =C3=A0 15:30 +0100, Christoph Hellwig a =C3=
=A9crit=C2=A0:
> On Mon, Dec 18, 2023 at 01:32:59PM +0100, Paul Cercueil wrote:
> > I am manipulating DMABUFs created with the udmabuf driver, that are
> > 64
> > MiB each, on a ZedBoard (which should have ~512 KiB of L2 cache
> > IIRC).
> >=20
> > When trying to access them with the CPU, dma_sync_sg_for_cpu() is
> > called. What ends up happening, is a cache sync for each one of the
> > (up
> > to) 16 thousand pages that back up the DMABUF, which obviously
> > takes a
> > huge amount of time, tanking performance.
> >=20
> > My guess (probably very na=C3=AFve) is that if the total length of the
> > SG is
> > equal or bigger than the size of the wider non-coherent cache, it
> > would
> > be much better to just flush the whole data cache.
>=20
> IFF we regularly =D1=95ync huge amount of data a complete flush is
> probably
> going to be more efficient.=C2=A0 But why are we doing that to start with=
?
> Ownership needs to transfer when the data is accessed, and when you
> regularly access 16.000 pages you're probably got other performance
> problems to start with.

I mmap the DMABUFs from user-space, so that I can pass huge amounts of
data back and forth between user-space and kernel/DMA space without
going through copy_to_user().

This works fine and is faster than copy_to_user() with coherent memory,
but it's much slower with non-coherent memory because of the time spent
in dma_sync_sg_for_cpu().

(Note that we also have regular use cases where we share the DMABUFs
between device drivers to transfer data in a zero-copy fashion - we're
not just abusing them as a kernel/userspace interface.)

You are right that the problem is more that I have an insane number of
pages :) Thanks for pointing that out. I will try to use huge pages
instead.

Cheers,
-Paul
