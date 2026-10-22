Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670738;
	b=zEr0j+staf3MdW+ojowaeSQTupsJRsbDZTx4fG+jqZD7Zcey5KN/J0iQPs3jmDAgn4TT
	 2ZTqMbaqRCcsX3WUFWlFY1RwVKktoewtH4rWHjgQlPtGRk+geLqalZ6vXkKOPuCaOYaEi
	 9Xz23em6Prjn5YgrKsbfzU7wZ6ZoWhYDwQRdUe6cmDiWQ3Dh5Lv3ZyvFr240upKtnyhru
	 VB1BJZ7OvOhyGCXl+MPlUyV/DK1V1y0sDbLWmr11Yyz7dbStZii62Q8Fk64cXKlHCoESA
	 u6oik7F78Lo8x3ly3U8Xg7Z2I1YI7jpyag2XzOYu8y2JBziRZGveUTGnEW50wPxqrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670738;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=FXkfA/bBRHRDEgHeRdJ9rUV1p4ghzX+6hSaSjg25qgY=;
	b=a38b70sjLQ7TLqBzBPbn8kRvV57ogW/uUGh9XIsYSvWBzYZeHskumpwoAbWjcD8SNol5
	 G9uvUWDJysUtDUn/kl/qFBzJKRZ+Y3ybUkJdfAdZfEGHZ2l0w8+NJFFvfcrgr1PqaKlh6
	 UkxV0c3c+74xqPJsSuYQmDHGPbpdtIMInXfvu49CiHrPMiQSHZ73fpWUxbrSaqHhWm/2c
	 Nzd9jaqKBZ30EeocMXpXkyAsnJtdRfbDAqJUmsJ4i/i88gdBHYPoP7XUhHyRjMiJHG6xM
	 ymnJXMljj4PP6eRHwiIq11j/kHINjTocHLppSjRQcOdH/ciBhMuetx/PUnGFVoJDLHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EzQkZ8Ne;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7E606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 12:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EzQkZ8Ne
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792670738; x=1824206738;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FXkfA/bBRHRDEgHeRdJ9rUV1p4ghzX+6hSaSjg25qgY=;
  b=EzQkZ8Ne3xxA89H+0xulPOyJCRwZ5SkTupLBc0iFyeSAYMje2nowWMOQ
   w/Y4QKy9PTBYbWHyCKv5i5ScMVY1wUW+ZCqiEpXdVeRCku8v3wVODjQc5
   Ou7GWTfz9L85wGOVBP80pSVLsC5S4GSSabDchi54VsySMD8kdORw14w7a
   weIuG97BnS13ceY9qcrYDz8Ydbmi0g04+EgJfpyIptMEvmrKnrxeU3bda
   0zr1zWoUMKaJWF/mvW30UG4dbo4/F4hJuxLH7dNSrjJ+wjeKHKAkaLpPA
   icF4TaNsP/npb4ogJ/FaGslS66HZaCEf+tagVKujslTIseLq596H5sJfJ
   w==;
X-CSE-ConnectionGUID: Cp/evZRTTSedMRMvYTSipg==
X-CSE-MsgGUID: I4la6IdlRsWmrzmBk3cWFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1451931"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1451931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 05:05:37 -0700
X-CSE-ConnectionGUID: MECgBnPiSzm4aUb67+emgQ==
X-CSE-MsgGUID: kbz7huL0RaaHxaUjMCr9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3336468"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180]) ([10.245.245.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 05:05:33 -0700
Message-ID: <995d4ff6f8ba968c75ef3ac70e1dc0a60b6cbc14.camel@linux.intel.com>
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
Date: Thu, 22 Oct 2026 14:05:30 +0200
In-Reply-To: <20261022115239.GY3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
	 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
	 <20261021123755.GL3008132@nvidia.com> <atmurtZOhKwwGjV3@nvdebian.thelocal>
	 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
	 <20261022115239.GY3008132@nvidia.com>
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

On Thu, 2026-10-22 at 08:52 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 22, 2026 at 09:25:55AM +0200, Thomas Hellstr=C3=B6m wrote:
> > > Attachment could also scan existing attachments to preferentially
> > > pick matching
> > > mapping_types that are compatible with existing attachments, thus
> > > avoiding
> > > invalidation where possible.
> >=20
> > Current design appears to be that attach only determines the set of
> > theoretically possible mapping types, disregarding other
> > attachments.=20
> > Taking other attachments into account is also problematic because
> > the
> > dma-resv lock is not held.
>=20
> Stating my restriction in a different way, the attach may start with
> {ualink, pcie} as options. Then we do the first map and select
> ualink.
>=20
> Then we get an invalidation and do a second map. Here we need a way
> to
> change the mapping type options to {ualink}.
>=20
> The exporter would have to make the memory visible on ualink to
> succeed the map.

That sounds like detaching and reattaching with a different set of
options. Would that be a fit?

/Thomas


>=20
> > Looking at current GPU drivers, what you describe above is
> > typically
> > done at pin() time, but if some importers want an early very likely
> > decision on what mapping_type to use, one could introduce a
> > separate
> > function that match the mapping_types, but that would be very
> > similar
> > to the map() function but without returning a sgt/mapping, or a
> > pin()
> > without actually pinning. One could reuse the invalidate_mappings()
> > callback to indicate the mapping type is no longer valid?
>=20
> I don't know that anyone needs a very early decision, but mlx5
> certainly needs something like the above flow..
>=20
> Jason
