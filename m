Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F325B0AC
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417698; cv=none; b=LlSmQqxtNBhRe0sNsc34ewtVQY+svb1l+NBgOKU43JvCRLFMOWKMXhlk/ekQ4xQpim60dd6LAFBGXN5Jj1qsE3WXNw8pv/xtaBwK160ZVml2mjYMiX4jfbUp0sAXiwvaZ56WIPvkcxbCRJNZccVAOfmU7TuoDo+Z3MadSmS/cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417698; c=relaxed/simple;
	bh=1uPDEr3HIV5YG4p8D5KJZ05iu8cxrjsZZLs2LzXgWeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPoeEzoL1SGLWat+5O5RF7kUgq9YvibDOjY3Dp9H5miNaNLORNkLQOtE98KYbal+Gfa/JBJMNdSHH3pUWaW1sD7OjKEum10f+O+M30/fFA9ID9p82euL3KoWhnTby/KfKpgrRqiY4ySyQM4SqkTrHwQcUd0ME93YD2Q1HTfoCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKsYIuTu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKsYIuTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792417696; x=1823953696;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1uPDEr3HIV5YG4p8D5KJZ05iu8cxrjsZZLs2LzXgWeY=;
  b=fKsYIuTuO5AQEQW5W8ElUp7L8akBhE6mvla+xizR9D9Dbdgs+GNsXZja
   bnyRdEQb/0ryyYaDlnIZjPCh/DbAVVZopJuLpz84xgtxudBJnT+eIxpvK
   9p1R6LqzltE4kxR6LXrx3gGHfwSw4KczEP7kvTrHQaDfvorHzqWympRmR
   BK7wiA2mKI2Ddb7hc9MD9f1XtRsKqB65ORU3qAA9Yn9XL9Z68uVb4h7VV
   7jbAeKK4ptxtLbresIoco9fReU99okV9coI8c8GBXUhYaSCSGHElCvXzq
   AqGl/Bv3NFST3wDraJVX4RGWoinCATCAcxIxHsAjgEw6qsA3LrCPkQ3xr
   w==;
X-CSE-ConnectionGUID: cFBSKzgIT7St7X/8859T/A==
X-CSE-MsgGUID: dyIfT1TbQWKGGAMFm4hFJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="999427"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="999427"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 06:48:15 -0700
X-CSE-ConnectionGUID: QvL0Ti8ZQd6z6qPl5njqCQ==
X-CSE-MsgGUID: i2O2ctf8Rya27oi/wURERQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4372774"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.47]) ([10.245.244.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 06:47:58 -0700
Message-ID: <5f57c49d34f2812b0b68be71218ce0a9b6510c14.camel@linux.intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Karl
 Mehltretter <kmehltretter@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky	
 <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org, 
	linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vivek Kasireddy	 <vivek.kasireddy@intel.com>
Date: Mon, 19 Oct 2026 15:47:55 +0200
In-Reply-To: <20261019133031.GQ13920@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
	 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
	 <20261016202653.97339-1-kmehltretter@gmail.com>
	 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
	 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
	 <20261019133031.GQ13920@nvidia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:30 -0300, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2026 at 02:43:29PM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2026-10-19 at 10:35 +0200, Christian K=C3=B6nig wrote:
> > > On 10/16/26 22:26, Karl Mehltretter wrote:
> > > > On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe
> > > > wrote:
> > > > > +	match_args.attach =3D attach;
> > > > > +	if (dmabuf->ops->match_mapping) {
> > > > > +		ret =3D dmabuf->ops-
> > > > > >match_mapping(&match_args);
> > > > > +	}
> > > > > +
> > > > > =C2=A0	attach->dmabuf =3D dmabuf;
> > > > > =C2=A0	attach->importer_ops =3D importer_ops;
> > > > > =C2=A0	attach->importer_priv =3D importer_priv;
> > > >=20
> > > > I may misunderstand the intended contract. match_mapping() runs
> > > > while the
> > > > attachment is still zeroed and without dmabuf->resv held.
> > > >=20
> > > > Patch 11's amdgpu callback needs importer_ops and
> > > > importer_priv, so
> > > > its XGMI
> > > > match cannot work here. Patch 12's VFIO callback asserts
> > > > dmabuf-
> > > > > resv and
> > > > reads priv->vdev, which cleanup changes under that lock.
> > > >=20
> > > > Should the core initialize the attachment and hold dmabuf->resv
> > > > for
> > > > match_mapping(), or should callbacks avoid attachment and lock-
> > > > protected
> > > > state?
> > >=20
> > > Right. This completely misplaced.
> > >=20
> > > The matching can't be done at attachment time, but rather needs
> > > to be
> > > done before creating a mapping while holding the resv lock so
> > > that
> > > the matching decision can't change.
> >=20
> > So question is what exactly should the contract be?
> > Looking at the pcie_p2p negotiation today it looks somewhat like.
> >=20
> > 1) Importer and exporter agree at attach time what mappings are
> > allowed
> > pending placement conditions and other attachers.
> > 2) At map-time the mapping is negotiated taking all constraints
> > into
> > account.
> > 3) The negotiated mapping is valid until an invalidate_mappings()
> > callback is received.
> >=20
> > Following this would allow a re-implementation of pcie_p2p as a
> > mapping
> > type and would allow a controlled link-severing to send an
> > invalidate_mappings() notifier and the mappings to be re-
> > negotiated.
> >=20
> > Importers requiring an early hint as to what the actual mapping
> > would
> > look like would need to be prepared to re-consider at map-time,
> > with a
> > reasonable assumption that the reconsideration and re-mapping would
> > happen seldom enough.
>=20
> The idea was the supported mapping types are fixed properties of the
> importer and exporter.
>=20
> Like iommufd is not suddenly going to start understanding ualink
> after
> an invalidation.
>=20
> Further, I had the (perhaps naive) expectation that the interconnect
> option was not something that would change during mapping. I did not
> think you would loose your PCIe option if ualink becomes available,
> or
> vice versa. Though on deeper reflection I suppose someone could build
> HW so you might loose your ualink option if the dmabuf is moved to
> system memory while PCIe would still work.

True, but there are other complications. Let's say at map time there is
another importer that don't support anything but system memory dma-
bufs. Then both ualink and PCIe p2p could not be used, and we'd fall
back to system. Or a map() move to VRAM from system for a fast
interconnect failed for some reason. (Somebody might have pinned it in
system).

But agreed it sounds to me like the interconnect capabilities should be
fixed at attach time.

>=20
> Making the decision right before map seems like a reasonable
> enhancement, but I can no longer remember off hand if that would
> cause
> complications :)

It was that mellanox ATS thing, right? That's the only case I heard of
that needed the mapping type decision (or at least a strong hint)
early.

/Thomas


>=20
> Jason
