Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D42C69E
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.118.118.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183372; cv=none; b=u9YIfKO1UjN5Be6h6lfQ8JjxbqkCxgiPRt5WIwfOAVDOEvRoVjqh5YX6pbPtqYebNBPOoT+7YUHtUoLb2Vj8c/iB2cWlIvLnD628Sj3deE/hG5vxb1RVsZRjCnC6LFut5Ap/JrBCmQy3aE8/0uvu5xkiJ4jUHYwxya7OZO6QgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183372; c=relaxed/simple;
	bh=dv/ZAmJ8jFBOK84zvjccOr+eXdiyXOi0lb0TC/laEzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5ou4d1RDTD0j78rLkwDzf9UiGuP1pi4rmNeATyCDtKqhV/asc4vmXcmjTPbhPBF7YNdhrPIKw8a8jsB+jqUf98/MTwcTJCoOp8Mr8aK8zHca4jhtF5L5I7Zg2xWMwuuPH0lJXNBr4PEmCxJr+OhAgVdEcgFr8CGvupgRy8EV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de; spf=none smtp.mailfrom=lynxeye.de; arc=none smtp.client-ip=87.118.118.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lynxeye.de
Received: by lynxeye.de (Postfix, from userid 501)
	id 3EB2EE74016; Thu, 25 Jan 2024 12:41:03 +0100 (CET)
X-Spam-Level: 
Received: from [192.168.178.22] (a89-183-231-186.net-htp.de [89.183.231.186])
	by lynxeye.de (Postfix) with ESMTPSA id 98AD8E74012;
	Thu, 25 Jan 2024 12:41:01 +0100 (CET)
Message-ID: <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
Subject: Re: Uncached buffers from CMA DMA heap on some Arm devices?
From: Lucas Stach <dev@lynxeye.de>
To: Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 catalin.marinas@arm.com, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, Pavel Machek
 <pavel@ucw.cz>, Maxime Ripard <mripard@redhat.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, kieran.bingham@ideasonboard.com, Hans
 de Goede <hdegoede@redhat.com>
Date: Thu, 25 Jan 2024 12:41:01 +0100
In-Reply-To: <87bk9ahex7.fsf@redhat.com>
References: <87bk9ahex7.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Milan,

Am Mittwoch, dem 24.01.2024 um 19:27 +0100 schrieb Milan Zamazal:
> Hello,
>=20
> in the libcamera project, we experience a major performance problem relat=
ed to
> DMA buffers while working on camera image processing using CPU.  This hap=
pens
> only with some Arm boards, we have observed it on Debix Model A (NXP i.MX=
 8M
> Plus) and PinePhone.  We use /dev/dma_heap/linux,cma (or reserved) DMA bu=
ffer
> heap on Arm.
>=20
> Reading V4L2 camera data from buffers is very slow.  When we memcpy the d=
ata
> from the buffer to a malloc'ed memory before working with it (reading eac=
h byte
> multiple times, without any big non-sequential jumps across the data), we=
 get
> more than 10 times speed up.  It looks like the input buffer is uncached.
>=20
That's right and a reality you have to deal with on those small ARM
systems. The ARM architecture allows for systems that don't enforce
hardware coherency across the whole SoC and many of the small/cheap SoC
variants make use of this architectural feature.

What this means is that the CPU caches aren't coherent when it comes to
DMA from other masters like the video capture units. There are two ways
to enforce DMA coherency on such systems:
1. map the DMA buffers uncached on the CPU
2. require explicit cache maintenance when touching DMA buffers with
the CPU

Option 1 is what you see is happening in your setup, as it is simple,
straight-forward and doesn't require any synchronization points.

Option 2 could be implemented by allocating cached DMA buffers in the
V4L2 device and then executing the necessary cache synchronization in
qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
master. However this isn't guaranteed to be any faster, as the cache
synchronization itself is a pretty heavy-weight operation when you are
dealing with buffer that are potentially multi-megabytes in size.

> We experience slow down also when writing to output buffers.  It doesn't =
seem to
> matter whether we write to the output byte-by-byte or memcpy larger chunk=
s.
>=20
For DMA coherency it's sufficient to map the DMA buffers as write-
combined, which should at least give you okay-ish write performance,
depending on the specific micro-architecture of your system.

> We are having trouble to understand what's the problem with the buffers o=
n some
> hardware and what we can realistically do about it.  Could you please hel=
p us
> clarify this?  Is it possible to force the DMA buffer CMA heap to be cach=
ed?
> Or is there anything else we can do or try?

See above. You can work with cached buffers, but that is moving the
cost elsewhere and is not guaranteed to yield better performance. There
is no panacea on systems that don't enforce coherency at the hardware
level.

When working on uncached buffers directly, your best option is to try
to access the buffers in as large chunks as possible, using vector
loads or similar facilities. You certainly don't want to access a
single memory location multiple times. If that is what your algorithm
requires then copying the content into a cached buffer might be your
best option, as it might have similar performance to explicit cache
maintenance on cached DMA buffers and doesn't require another
maintenance operation when transitioning the buffer back to DMA master
ownership.

Regards,
Lucas
