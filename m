Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795732202;
	b=MbmVyzk7C3GszMQBPLOAroi6fhotdVNCQTpBcHTAtZkSaQDwB4W6YFOD3i7wyxt6CCrc
	 PSsG4iMByAZqkuW3IfyEbwH/Cw3r1YhJHsPzWDkuYJvv7P825QWYCEe47/EESzQnaoNYf
	 cKyMR6F9cIAIR8ZgATeJrrjuCLiCr6Vv3wzj8lYxRTlG+it/Pv5Mg2oaOHbEf2w7yyS7m
	 LK/huJQFUeuZTBxzyHrjest8oA6g8obDzsqmi2Xsi8gY1whrcytg1KfweddQsqimcOgv7
	 rXhzWqyZLKg5D0DcTujnMGZRBFqR10WNHxTxx2FaASz2j1OhM8F94RjPaGXVwbgoIhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795732202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
	b=0TirkHb565vRdnFxZN9Ky1c65/80sLhoEUlVkiIv4qZLtkQFk47//rxMGfsJJklBU6ZU
	 I+W5JjyIhCyKe563eEKyxEW6AbDdidQ5sqO6s9t/zu2TGg90iRM/XJm2FZktPU41m70Mi
	 M4GWiZKQYzRY2LCiXmDIrLkDFKRcB+/543pKlmk4zsgjOPEvZcX6C1uyXpN6SbUqJS9Qp
	 K62n7RqmHlCfhUuX/Q8n7iRBrSHoLDm6hV6RmC++1Cysm1gzf1Lkpo1v/1Vma9JOHlx4+
	 S9o0bMrNG32i7Whf17ZCP5kiIO+XZ6jlrrsDXFDaoqgDez269RKysCjqjaD/DqKb8Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fb8abVIk;
	arc=fail smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FA606A326
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 22:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fb8abVIk
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-921342fae7eso76144406d6.3
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 14:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795732201; cv=none;
        d=google.com; s=arc-20260327;
        b=Xsg7zDj3IbFmkmtHYFQiF2Q9z935lZDE/v3QSRPE004fJiiX3xUG7zhsi0KUsXbqCP
         /pqH7xjpLjw0eAS+BmoV88syAl+atAo7u3/8egdFD+Gf32zW8b2/t/sy0Cr+OkozRSbo
         YPisMfgYULArZqyj3IkhznQaRYHYYJtc37j/0o/8vh+oX8v/ja0J3ld3Ec7CMai4V6XR
         x2LXXKvW0LTreFhm7nj9UDzo+aw2i6rZQdkznr5Xvr4SKNPkAOYynYYIdTQIgpMJfSh6
         cOhv4Z4LIMhUf9d9uIt3dz6amOlPmh2BSCs2D2fC9iMcyH7D6Q9ZoTI0F4rseDtj6jLz
         92Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        fh=O1bUTZDXIh3IoNRzan9gbdypKs+Sfk9PnvCKZ/gd/N4=;
        b=TnOTEh1OL41w46dbq4gu9ZsYbrS26aqxNZyt1T7nu0oO+qqEq7rqQZqG6x7dmpk+fT
         xY7rz0+72ZqP0J35BXD/kc/KwQCl6d7bdKNzI1ZTsSyg42+fKR5eJSIhd4D8EniCHAiB
         EqcYDL1GZbCSI2APNGtYtnPOZtQ5huKeohZ7NU9qy4gDjB3OiV0llbnlvNAkxEBf6e8e
         OLjzfEjQawAvlgMfzqbUvWTeOai4ah/TFSvEq0hIG/9VKj4QSUl/G/4BrDlaiXJFkD6M
         5kmqun2VhHe6xKJv10k9k3qxnmFuysdLJSRVjJXLbQYhU9WuCgkgjFBtsU++ldrgy9VC
         pJag==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795732201; x=1796337001; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        b=Fb8abVIkGAuDSN/deog0YpIMe+texdjHWH1YbFOBs+DCO5ocfLhdqjjdo10Tk7+ZXH
         +ETT0UlZbBa+mvJ+1PSpoQzzoRNSnOL9hWYIlCaA5aMJt6i0HSTPntUeviGvuAFNQ6XQ
         NVmJVLvbILqp8dLf1twBKc8lxkctrDCbX3IUaqfm+imZu/il7ukyrtF83F/XpvqL7Edw
         ICDH3FepRwrdxLqO0p1QYQKpDsEHCdcfKGRaDECF0HedX1vEvDE4Gi1OX+TDz+KzaT85
         1Dx3jxkrq+ea5p5k9FFrvjexZYLXdeaGpsxgIGT6Eakz/oontlblSFc+so4oTZePD0qk
         PxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795732201; x=1796337001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        b=pb/+JVd1juPWzu2pH+oDrG0hfSttc/5/3uC8AB3iYGSHy+4OaF0m4WaBFKBJFC+TAl
         9DIhjHDV0/jIeRzOUadz+iUmzdT2dyTEpUgN+H1BLVlWh7EfapBUZs6Y4rve6nEw/V8t
         lOjh8OPjEmYDfOqsK1whrG/oHc3UXISokEaVbyqeV26W7aJwvutwKI8+/j5m7DZtrxNh
         YeferEyqupznIjY+dHAMGNqkJDPy4sgQpN17SNxo8oOYmgewwxkV1h6xz8hICjS+nsDK
         QJg03oQn8pzo3LXvgH8RJuW6DBfZ8FB8y84HtZvdo2YSSI2P62cuxSxp/8Ih4rj+sIXy
         zACA==
X-Forwarded-Encrypted: i=1; AL+hErEJRDKFwxPBKJtgD/kf1B9xogHNH9UUdMPDdVi6JRC/wmXykjOKcQLs7UE+S1E3SkLxJbjCYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+c/HySL38NeLl4IHBrlzORE3znB1b0+rf+5c5Tvl3Huj/4Lk2E
	RXoZYHWb3EnydXSL1KesrJf80kq+5PpTVHow+IEMRIh62n59PJ2KTjA5TsX1gCh4d440j/L0XrQ
	yIl7Js2NqC5m/VgXZGyXcOEGA2ivPoLg=
X-Gm-Gg: AZFdTZcK6KdFEm54dK2E2s4FOc+nTSJBHaunONnwF508IQ2M72CLuiq+qzuHfHYZYRR
	if6fCb+SpndXF+iU6xZoPahlfKhYnJBqyKC/rXSBK4WSl3hL8OXV/W2wwXvYLKpIGGLpgLYDOwE
	5nlCOTdOgVdkPqRmzyxIWROZxXE4phmqDGy0Bu4yPMY08RwwHH4kaKMEtXTaMqczxAhkaMKPMPN
	i2lRqWKjd/odRVIYW8AqTr/RjO489Yh9jp1HpZZE4JTjF4jntVOzLqqW01lRLRl2ZfoytF1qiS5
	0IZAjDk93v0D6A22VbJWRJiixwlNWbzv9yBKODCKRqhPCPD5w7NJo+wfNazcA7RVrqys1u0A/rG
	Y+l0Gqx79o/YwwJ3b2BICLMGwA+fqVJlsrzokGZOtnvXoY7YBSfGWdwKi2b6hc1QAv+Y7BgefMa
	suKIJ3SAJrMFzmaSxqnyWBPA==
X-Received: by 2002:ad4:5d61:0:b0:91e:8bb3:82 with SMTP id 6a1803df08f44-92134988818mr432424486d6.4.1795732201165;
 Thu, 26 Nov 2026 14:30:01 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com> <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com> <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 27 Nov 2026 08:29:49 +1000
X-Gm-Features: Aa3M54rvnH00v1NCtGrc73zPMs4ZrSy5Ip3saymlbe4-GLTg5bt7TBC0zEJEFjg
Message-ID: <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Dongwon Kim <dongwon.kim@intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
	chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 03:26, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/24/26 07:23, Alistair Popple wrote:
> > On 2026-11-24 at 05:37 +1100, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote...
> >> On 11/23/26 17:57, Jason Gunthorpe wrote:
> >>> On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian K=C3=B6nig wrote:
> >>>> On 11/20/26 06:55, Alistair Popple wrote:
> >>>>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>>>
> >>>>> The SGT (Scatter Gather Table) DMA mapping type represents the exis=
ting
> >>>>> sg_table/scatterlist based DMA mapping. For now it continues to use=
 a
> >>>>> sg_table for map/unmap, but this will allow a future patch series t=
o
> >>>>> convert to using a different data structure for importers without h=
aving
> >>>>> to convert all at once.
> >>>>
> >>>> I strongly think we shouldn't have an SGT mapping type in the new DM=
A-buf mapping API.
> >>>>
> >>>> Instead we should have something like either an array or an xarray
> >>>> of DMA addresses.
> >>>
> >>> My plan was always to get there, but I don't think it is reasonable t=
o
> >>> start there? There are too many places all over the place that are
> >>> just hardwired to do SGT right now.
> >
> > Right. There are around 70 drivers upstream that make use of the sg_tab=
le handed
> > down via a dma-buf import, so I don't think it's tractable to convert t=
hem all
> > in one go. So obviously we will need some way of phasing this in to giv=
e time
> > for each driver change to be implemented, reviewed, etc.
>
> My suggestion is not to convert all drivers in one go, but rather to come=
 up with some sane representation of the DMA addresses instead of using an =
SGT in the new interface.
>
> > Obviously some of those will share a common structure/helper and conver=
sions
> > will be similar, so that is an over-estimate. But based on an initial p=
oke
> > around there are plenty of drivers that bake the sg_table more deeply i=
nto their
> > data structures.
> >
> >>> Part of the design of this series was to allow the conversion away
> >>> from SGT to be done incrementally without breaking compatibility.
> >>
> >> Do you know the joke from the hitchhikers guide to the galaxy where th=
e dolphins are happy for exactly the same reasons?
> >>
> >> I'm pushing against this plan for exactly the same reason because I th=
ink it will make the conversation away from SGT even more problematic than =
it already is.
> >>
> >>> So it is effectively this:
> >>>
> >>>> The framework should then either connect the SGT directly if both
> >>>> importer and export are using the "classic" interface
> >>
> >> Yeah but that should not be a separate mapping type, it's rather that =
we just convert back and forth from DMA addresses to SGT for compatibility =
reasons.
> >
> > Right, I think this is actually fairly close to my plan, which is to pr=
ovide a type
> > for each address class an exporter can produce - either a CPU physical =
address
> > or some device context + P2P/MMIO address but in future could be some o=
ther
> > interconnect type.
> >
> > The core then negotiates compatible types and adds converters between t=
hem,
>
> I have strong objections to that plan and would potentially NAK it.
>
> DMA-buf should *NEVER* accept CPU physical addresses nor provide conversi=
on between different address types.
>
> Keep in mind that DMA-buf is solely a container for DMA addresses, nothin=
g else and it should not provide any mapping functionality whatsoever.

Is that because it's called dma-buf, if we just called it's shared-buf
would that alleviate things? I just feel like there are use-cases
where it containing CPU physical addresses might be what is optimal
for a certain scenario, and re-creating a whole parallel
infrastructure that ends up being 'I-can't-believe-it's-not-dma-buf'
would end up being bad.

If we need to shared object backings and have clearly typed and
negotiated on what the backing contains then we should allow it.
However I mostly agree on the mapping thing, I'd want drivers to
negotiate and natively support whatever backings they can rather than
having an intermediate trying to handle the conversions Not saying the
code doing the conversions can't be a helper, bit it shouldn't ever be
autoamtic or outside driver control.

Dave.
