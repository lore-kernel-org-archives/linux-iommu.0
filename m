Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34D4CDA22
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654630; cv=none; b=BRXeJfqxjR4ZCbGS0bKbgVEh0y4PaTXbzcURRU6i8c10ufSEAh1evR0stLyNXKaKBHEuJiTBxaNR/YS2cav5CiQvNTWvJII6FScrqQMGYNPb5f9BXcDlWnpZ0aLMy7aleEUreQfoW7HlHXsTAZjuf1e0c27Bb/HfLOgD29bs/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654630; c=relaxed/simple;
	bh=MDZHHIBC+OMEMEsQQONixUk9LTcLJLWtKNH7Kg/sPTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB0BP2+YZ2VmH/ZGoN6vjQY41379OB2WITUC/YiMOlbXrWNac1+JwYFHnx51AivlvB/krXJ64fMs4YzkcFe13vF933JrjYu/BCFcxPGLnRoUfk5rG9VFBuh/TU6/bdrV9nnDnzJr73JJD2qswdiJapUzARqvZjUIeGoOqnKvoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6QEB0nl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6QEB0nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789654628; x=1821190628;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MDZHHIBC+OMEMEsQQONixUk9LTcLJLWtKNH7Kg/sPTo=;
  b=h6QEB0nlR8z73OSfSy8ucVxshES69TJ1lMrKAyHdkLnuKwJYPGTwETks
   6nVQRhzAsqwa0wMZfQJOA1oXMMK9OnfDOM4Xlro3xTcsHwSrTTBTsjk5o
   XpLsGnDWimsVkkQWTteIBPpYYVuuKB9JdmMp8w3BewUpi9L5qKhLxmoOM
   azLUJyRtcXmF9r4hbnF537l6JTj4+Luntc+T5gXeYWJj5ArSwJ2+yuCGu
   ampmAD1EiwGyKLUuaV0R3esw3p9oiwiKa7mUYUuDgX+cCMzIK5efRYPJd
   zLiKYAkR89149ey4KivgxUIObrco4mhquHoawL39GeZgH6Ray38jydBz9
   g==;
X-CSE-ConnectionGUID: pnMjVrbYQNy2avtSuUthVw==
X-CSE-MsgGUID: A00P0ooVRfeWA27JQSoexQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89214234"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89214234"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:17:04 -0700
X-CSE-ConnectionGUID: /Qnwxs0ASJKRCbdsv2wkEA==
X-CSE-MsgGUID: kKQtuzvqRtudznznbRbuAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279045906"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.63]) ([10.245.245.63])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:16:59 -0700
Message-ID: <7d8118ee06f29b73988108c0892022b3a2626f1d.camel@linux.intel.com>
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson	 <alex@shazbot.org>, Ankit Agrawal
 <ankita@nvidia.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Joerg Roedel (AMD)"	 <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy	 <robin.murphy@arm.com>, Randy
 Dunlap <rdunlap@infradead.org>, Sumit Semwal	 <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,  Tushar Dave
 <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Date: Thu, 17 Sep 2026 16:16:57 +0200
In-Reply-To: <20260917140253.GG3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
	 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
	 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
	 <20260917140253.GG3196566@ziepe.ca>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2026-09-17 at 11:02 -0300, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellstr=C3=B6m wrote:
>=20
> > That is, a flag to tell the topology check that some transactions
> > *will* take the host-bridge path due to IOVA being used, and that
> > the
> > computations including pci_p2pdma_distance() need to check whether
> > that
> > is possible (checking whitelist etc.) and return the corresponding
> > THRU_HOST_BRIDGE mapping type. Translated transactions taking a
> > short-
> > cut using the bus-address would then be hidden from the driver.
>=20
> I imagined it would work by the driver passing in what modes it
> supports and Intel GPU would simply pass in ATS only.
>=20
> Even something like mlx has variation, only some operations can opt
> into ATS, many others are never-ATS.
>=20
> Driver should not make statements like " *will* take the host-bridge
> path" since it has no idea.

Yes, agreed, but anyway DMA-BUF would then, as part of the
dynamic_attach negotiation have an interface that takes an ATS only
flag and use it to determine whether P2P is possible at all, and use
them at mapping time to set up the correct SG list (IOVA or BUS
address).

Similarly the dma_map_page() needs to know these flags for p2pdma pages
so that it never sets up a BUS_ADDRESS to an ATS-enabled device that
didn't explicitly ask for it?

And this all (and in addition the previous discussion around pcie
subsystems calls from within dma-buf, and data-types for mapping
information) makes me think that abstracting fast dma-buf interconnects
along with our previous discussions is a good thing. Then interconnect
details and cross-subsystem dependencies can be hidden in the
interconnect implementations, suitably placed in the tree.


Thanks,
Thomas


>=20
> Jason
