Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652403;
	b=aEnWDmJJS4BS1rnzb6S8NE+F8VSo0lLYeort8shGP6y/cL2rRL1gdckbEYWlR8r5/5qM
	 sDDWFyztHKxeJWoW4Jz3E7yu0DQ/M6/GhIAQNWLO/LP6yqyy0JaiHBd+UFn1z4+IanNrr
	 FDoKYJ15sepgh4DmGw5jcwTVWc0WK1t20GqmkYXufy5pQ+S6A5hnw7DOLF7JzAgg9oA+d
	 +mG/QaiM+qekb23aT6FqBcBpz1FtQA7965e2eP1cc5/63tdSpggZorA5yYsyzrPzN5qjS
	 MCUFWFKc5MMO6McgukkP/MS7wCa10MxZnb4i/VMDMHyrcVpXxTQtqbPmIY9zWdjj+zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=3sYhE1LnkUeOEzCUYOrX9Pw0APlnYIdWTDdRY57Pm84=;
	b=NB3xNje7gHUUy1jdU8FH6lGviwUH9WoRWlaacBF2xv/eXbKv3Vn6wAcz4a/N5xTfAigt
	 cynkVni+10yWEL52hZoabAV3xWsfIXPJCQiobfVvVWZh/CNQ9nJnJmEh9g23ejbn2kW4v
	 aH2SMj45okxLPUlV6ipNJ/CIQzm2gvdKyF85twkfbvJUykfnXw1Qbtf7vjUV4CNy3//t+
	 HlgryAShq8KrWhI6Gdcra9wkzPCxGetN3zx/vwwer4ZDfxUUanWWuAB7nyitwkoDLb53I
	 DM6ueC+6MbmHcszWDuhkuXrvizMX0zqJLLeoZOT7287cwoPAP54TWzoL2C+XP3DR3Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730C606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 06:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9730C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792652398; x=1824188398;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dhEbDEiT/lA7DMbvWHqU5u/hokCu4VBBB7VCvllxzTM=;
  b=L+dgkiX/fCSW6oBP4mcG6SXTybmeRYf2BHna3fvNr7qh/rhZ/aFkmFEE
   1fO6wGF+wUdr3oZyxfS9D3ESg37HHb2BM1upW29QofvlrVlJxs9Z4F6wO
   t5b80Toy0TP0BCLU035jqUW08WVrTTON7+zZuwB1ehpvdPpoZesPipm2o
   1uP2MQCZeTb9MB4i8Np6JukWzDyLf92yCpbo/rRLdxk74USjHgTVitQTp
   6Q3/SVBdoIt1ur3+BVXzJjZZXi2J1V+WaFKyj9UriQZ8R+qizcSedmWhq
   js2D1GAh2gzwb+bp6Mm/Q6h6DgpsDN9/tFUh78zReR7DzLhwuAja2zFLZ
   w==;
X-CSE-ConnectionGUID: ubT4NK+7R1+BwzCJVAmFPQ==
X-CSE-MsgGUID: 4aHXg+EQStGzWQfspVjs8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1404572"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1404572"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:59:57 -0700
X-CSE-ConnectionGUID: MQJXkMSyRUSqZSG/an9M6w==
X-CSE-MsgGUID: e963k2HUS+uOSFXT4/U5/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3209140"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180]) ([10.245.245.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:59:53 -0700
Message-ID: <598bc83d8070c9bcb364a336b91d1e6c6fff4256.camel@linux.intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Christian Koenig	
 <christian.koenig@amd.com>, Dongwon Kim <dongwon.kim@intel.com>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky	
 <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org, 
	linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vivek Kasireddy	 <vivek.kasireddy@intel.com>
Date: Thu, 22 Oct 2026 08:59:51 +0200
In-Reply-To: <20261021123755.GL3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
	 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
	 <20261021123755.GL3008132@nvidia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 09:37 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellstr=C3=B6m wrote:
> > > struct dma_buf_mapping_exp_ops
> > > =C2=A0=C2=A0 Base type for the per-mapping type exporter provided
> > > functions.
> > > This
> > > =C2=A0=C2=A0 would be the map/unmap callbacks. Each mapping type can
> > > provide
> > > its own
> > > =C2=A0=C2=A0 functions for map/unmap type operations with optimal typ=
e
> > > signatures.
> >=20
> > Does it make sense to try to land this patch first, plus a
> > conversion
> > of pcie_p2p so we could agree on what the contract should look
> > like?
>=20
> I think it would be good to focus on this patch as the main 'crux' of
> the series. The API contract is the main agreement. I'm relucant to
> merge code that has no users, so it woudl be ebtter to go up to at
> least through SGT.

I agree about unused code, but wouldn't a pcie_p2p conversion to a
mapping type be a valid use-case?

> =C2=A0
> > s/mapping/interconnect/? My gut feeling is that "interconnect" best
> > describes what's typically going on, but "mapping" perhaps better
> > describes all cases.
>=20
> My intention was to cover more than just the phyiscal transport. We
> do
> really want to get away from scatterlist, so having PCIe map with
> scatterlist and PCIe map with <something else> still ends up with two
> mapping types in the system.
>=20
> This is why I choose the name over interconnect.
>=20
> > Location of common protocols which typically carry cross-subsystem
> > dependencies?
> > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
>=20
> I'd encourage people to design more like PCI where the actual
> *interconnect* has its own home and there is just some minor call
> outs
> from dmabuf to help the matching logic.
>=20
> > As discussed previously:=20
> > Agree on theoretically possible matches at attach time, Match at
> > mapping time and guarantee the match is valid until
> > invalidate_mappings().
>=20
> I was thinking about this some more, and I'm less sure now.
>=20
> If I think about mlx5, in a multi-path PCIe configuration, it can
> move
> the translation around within a single PCIe path, but it cannot move
> it to another path without creating disruption for the
> application. This is a HW limitation in how the internal routing
> works..
>=20
> I strongly suspect this will be the norm for any hardware that
> doesn't
> rely on decorated page tables to select the IO path..
>=20
> So, while I agree we should support hardware that can fully change
> the
> path on each and every map, we also need to suport hardware that must
> pin the path during attach.
>=20
> Probably this points to needing a 'pin' operation for the mapping
> selection after attach.
>=20
> > > +/*
> > > + * Match items are generated by the importer using the
> > > DMA_BUF_IMAPPING_*() and
> > > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > > mapping type
> > > + * defines its own signature with its own data to make the match
> > > and
> > > attachment.
> > > + */
> > > +struct dma_buf_mapping_match {
> > > +	const struct dma_buf_mapping_type *type;
> > > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > > +	union {
> > > +		/* Each mapping_type has unique match parameters
> > > here */
> > > +	};
> >=20
> > Do we really need to add all global mapping types here? Then we'd
> > need
> > something for driver-private mapping types as well.
>=20
> IIRC it is fixed size up front like this because of how the
> structure's memory is managed in this design..
>=20
> If you want a driver private thing then I'd add a 'u64
> driver_private[2]' to the union and the driver can cast over it.
>=20
> But this is the kernel, if you want to add an xe_mapping_type, then
> just add it. I don't know we need to do driver private things.

I guess it's my wish to separate components. Couldn't this lead to
excessive includes and unnecessary dma-buf recompilations when mostly
unrelated headers are touched? Except possibly for memory size, core
dma-buf shouldn't need to know about this, it's a mapping private
thing?

/Thomas


>=20
> Jason
