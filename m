Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14623200C0
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lynxeye.de
Received: by lynxeye.de (Postfix, from userid 501)
	id 122B5E74016; Mon, 18 Dec 2023 15:40:30 +0100 (CET)
X-Spam-Level: 
Received: from [192.168.178.22] (a89-183-231-49.net-htp.de [89.183.231.49])
	by lynxeye.de (Postfix) with ESMTPSA id 08DAAE74008;
	Mon, 18 Dec 2023 15:40:30 +0100 (CET)
Message-ID: <11a2a527d59c967095d77ceba11c6edd41e594de.camel@lynxeye.de>
Subject: Re: dma_sync_sg_for_device/cpu look very inefficient
From: Lucas Stach <dev@lynxeye.de>
To: Christoph Hellwig <hch@lst.de>, Paul Cercueil <paul@crapouillou.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	 <robin.murphy@arm.com>, Nuno Sa <nuno.sa@analog.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, iommu@lists.linux.dev
Date: Mon, 18 Dec 2023 15:40:29 +0100
In-Reply-To: <20231218143003.GA15735@lst.de>
References: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
	 <20231218143003.GA15735@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Am Montag, dem 18.12.2023 um 15:30 +0100 schrieb Christoph Hellwig:
> On Mon, Dec 18, 2023 at 01:32:59PM +0100, Paul Cercueil wrote:
> > I am manipulating DMABUFs created with the udmabuf driver, that are 64
> > MiB each, on a ZedBoard (which should have ~512 KiB of L2 cache IIRC).
> >=20
> > When trying to access them with the CPU, dma_sync_sg_for_cpu() is
> > called. What ends up happening, is a cache sync for each one of the (up
> > to) 16 thousand pages that back up the DMABUF, which obviously takes a
> > huge amount of time, tanking performance.
> >=20
> > My guess (probably very na=C3=AFve) is that if the total length of the =
SG is
> > equal or bigger than the size of the wider non-coherent cache, it would
> > be much better to just flush the whole data cache.
>=20
> IFF we regularly =D1=95ync huge amount of data a complete flush is probab=
ly
> going to be more efficient.  But why are we doing that to start with?
> Ownership needs to transfer when the data is accessed, and when you
> regularly access 16.000 pages you're probably got other performance
> problems to start with.
>=20
In addition to that flushing the cache only works for data moving to
the device. When you have to deal with data written by the device you
would need to invalidate the cache, which is obviously not something
you can do to the whole cache without data corruption.

Regards,
Lucas
