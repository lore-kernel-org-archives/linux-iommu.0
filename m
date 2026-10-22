Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654156;
	b=xYt4UIQ5N4GkpfGEv3fPU91E4AmdgEHh1DbZA7gon/EZetzm4ZOfAXnxOpRIN7kvQoZd
	 lYFAXPyhHPNO8sQiK8yd/9pGxfIYe5LA0Yy5ZKRkCeVtrR8bOskpiwnQThoSnEH+TXzDp
	 ACWvjxIfPY6rRoRku0paAejD4zVQ03J+T9WGKtwMI1eTX4Lv4cvlNaEREjX/VC9INd50O
	 vZ+EWKqvqwkBYpsHGbcnUlV2QV0FSdTCZRiiBcX7Ik6JhhHu+bajOswETj7jgJugVHZGX
	 Ibt+zzAnyHVrP94Dym8WYVpcB61aW2u1fnWUtuI01SkJyGWjNMpKWJi+qdeA768kEBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=grua3t4lyGOc5KQB2bj7bgFlt7G4CgMGY6Vk01NoFjU=;
	b=3fwLo4FRHte9fToQEwJy6zPrU1TFa7xGBHuAa9BA25ZKRNuASYi/Xn0kkSLomYr0EK/7
	 SonnknUIao2CDc4ic1fm5lc9XtlbNkzL0UV2YQw1p/d4WvPeHLmwoEvEMFxkBkpTVjeI0
	 pxDDlEMYzvDlRogj1BkQX6/BjrMy7wgIbaDETfvQ+0NI0nlaIZYfjy1InIj9KgDFF3cw+
	 Mez5UdWbnZizJ9vykX2WZhKS5wh2KtqcLyKjA/Y41P5WNdAuFNJpuYQERXlR7zcdqTvbs
	 ouD3iq8ku/tpIRY4WxQE9TeBYxCgH6WD+bY1xrHTBRaORVBJJ8j8T5//NzSr71ZLUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306A606A31B
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B306A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792654148; x=1824190148;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uj54q50VB5yWIB4fc6XXNtaRZa8JIR319hS6Vo2rUI0=;
  b=Aybwvr7g3gpieTlLeuHKH5ajwa3OG5gsVnhDi+w/l4x3yDPFzQ77qjfR
   UchEdfhbCYEfZ1tLg/xYJAC5TnmCSBWZ8ULsafq2otZFrKFo0sY/rWEMz
   T/TNIW2CalteNIW1y4SPeRE5GDSNKoKneoLA6q3DOhctC7hZ26be764cV
   qpY88c/mqBcApVRC7sAblDKL1B+lFFnKRF6k1SurGondxl28IHySsYzeB
   sAUEhQfgt0Zg2LwEfxoSfwtsEyuvPFxbBQIhvzZ2tLT5JsV7htSP3unEE
   LjcL6M7tYro3lnZtPoc3M1Gqk1mlgH+TEE7B8F5t0hC1KT0M7cA9sebLA
   Q==;
X-CSE-ConnectionGUID: pfw5s9XBSsWCxSIDk4Ny9Q==
X-CSE-MsgGUID: JiFiL5wpSgCd/gB6PDMHqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1275300"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1275300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:26:02 -0700
X-CSE-ConnectionGUID: Ft4hr3JHQH6PDx3z3FoomA==
X-CSE-MsgGUID: D9DumUkdRa6lAODh30OJ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3213751"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180]) ([10.245.245.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:25:58 -0700
Message-ID: <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Dongwon Kim	
 <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, iommu@lists.linux.dev, Kevin Tian	
 <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
	linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, Matthew Brost	
 <matthew.brost@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, Sumit
 Semwal	 <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>
Date: Thu, 22 Oct 2026 09:25:55 +0200
In-Reply-To: <atmurtZOhKwwGjV3@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
	 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
	 <20261021123755.GL3008132@nvidia.com> <atmurtZOhKwwGjV3@nvdebian.thelocal>
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

On Thu, 2026-10-22 at 17:52 +1100, Alistair Popple wrote:
> On 2026-10-21 at 23:37 +1100, Jason Gunthorpe <jgg@nvidia.com>
> wrote...
> > On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellstr=C3=B6m wrote:
> > > > struct dma_buf_mapping_exp_ops
> > > > =C2=A0=C2=A0 Base type for the per-mapping type exporter provided
> > > > functions.
> > > > This
> > > > =C2=A0=C2=A0 would be the map/unmap callbacks. Each mapping type ca=
n
> > > > provide
> > > > its own
> > > > =C2=A0=C2=A0 functions for map/unmap type operations with optimal t=
ype
> > > > signatures.
> > >=20
> > > Does it make sense to try to land this patch first, plus a
> > > conversion
> > > of pcie_p2p so we could agree on what the contract should look
> > > like?
> >=20
> > I think it would be good to focus on this patch as the main 'crux'
> > of
> > the series. The API contract is the main agreement. I'm relucant to
> > merge code that has no users, so it woudl be ebtter to go up to at
> > least through SGT.
> > =C2=A0
> > > s/mapping/interconnect/? My gut feeling is that "interconnect"
> > > best
> > > describes what's typically going on, but "mapping" perhaps better
> > > describes all cases.
> >=20
> > My intention was to cover more than just the phyiscal transport. We
> > do
> > really want to get away from scatterlist, so having PCIe map with
> > scatterlist and PCIe map with <something else> still ends up with
> > two
> > mapping types in the system.
> >=20
> > This is why I choose the name over interconnect.
> >=20
> > > Location of common protocols which typically carry cross-
> > > subsystem
> > > dependencies?
> > > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> >=20
> > I'd encourage people to design more like PCI where the actual
> > *interconnect* has its own home and there is just some minor call
> > outs
> > from dmabuf to help the matching logic.
> >=20
> > > As discussed previously:=20
> > > Agree on theoretically possible matches at attach time, Match at
> > > mapping time and guarantee the match is valid until
> > > invalidate_mappings().
> >=20
> > I was thinking about this some more, and I'm less sure now.
> >=20
> > If I think about mlx5, in a multi-path PCIe configuration, it can
> > move
> > the translation around within a single PCIe path, but it cannot
> > move
> > it to another path without creating disruption for the
> > application. This is a HW limitation in how the internal routing
> > works..
> >=20
> > I strongly suspect this will be the norm for any hardware that
> > doesn't
> > rely on decorated page tables to select the IO path..
> >=20
> > So, while I agree we should support hardware that can fully change
> > the
> > path on each and every map, we also need to suport hardware that
> > must
> > pin the path during attach.
> >=20
> > Probably this points to needing a 'pin' operation for the mapping
> > selection after attach.
>=20
> If I'm understanding things correctly we're expecting a change in
> path between
> attach and map time to be rare in practice. Therefore the need to
> handle this
> case is mostly as a fallback to not break things. So instead of
> pinning could
> new attachments just invalidate all existing incompatible attachments
> on the
> list by setting eg. attach->valid =3D 0?

I agree, (although I think the "invalidate_attachment" needs to be
discussed). In the end the importer should be given a choice, either
pin  and accept that subsequent attachers might see errors or accept
app disruption.

>=20
> Attachment could also scan existing attachments to preferentially
> pick matching
> mapping_types that are compatible with existing attachments, thus
> avoiding
> invalidation where possible.

Current design appears to be that attach only determines the set of
theoretically possible mapping types, disregarding other attachments.=20
Taking other attachments into account is also problematic because the
dma-resv lock is not held.

Looking at current GPU drivers, what you describe above is typically
done at pin() time, but if some importers want an early very likely
decision on what mapping_type to use, one could introduce a separate
function that match the mapping_types, but that would be very similar
to the map() function but without returning a sgt/mapping, or a pin()
without actually pinning. One could reuse the invalidate_mappings()
callback to indicate the mapping type is no longer valid?

/Thomas


>=20
> Map time functions (eg. dma_buf_sgt_map_attachment) would check
> attach->valid
> and return a failure if a subsequent attachment/event had invalidated
> the
> mapping type.
>=20
> Importers with invalidated attachments would then have to retry
> creating the
> attachment, probably getting a different mapping_type. Would this be
> acceptable?
> Or do some importers absolutely require the mapping_type to never
> change once
> the intial match/attachment has happened?
>=20
> =C2=A0- Alistair
>=20
> > > > +/*
> > > > + * Match items are generated by the importer using the
> > > > DMA_BUF_IMAPPING_*() and
> > > > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > > > mapping type
> > > > + * defines its own signature with its own data to make the
> > > > match and
> > > > attachment.
> > > > + */
> > > > +struct dma_buf_mapping_match {
> > > > +	const struct dma_buf_mapping_type *type;
> > > > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > > > +	union {
> > > > +		/* Each mapping_type has unique match
> > > > parameters
> > > > here */
> > > > +	};
> > >=20
> > > Do we really need to add all global mapping types here? Then we'd
> > > need
> > > something for driver-private mapping types as well.
> >=20
> > IIRC it is fixed size up front like this because of how the
> > structure's memory is managed in this design..
> >=20
> > If you want a driver private thing then I'd add a 'u64
> > driver_private[2]' to the union and the driver can cast over it.
> >=20
> > But this is the kernel, if you want to add an xe_mapping_type, then
> > just add it. I don't know we need to do driver private things.
> >=20
> > Jason
