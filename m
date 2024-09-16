Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C75258
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491739; cv=none; b=XbgGoij+pZ97SDzXFSjJHt5heVzGvHGgUSyHCq7CYwBoO6+LzwQoOqT/wW3lp16gpZ+WIBT1wL6uNGJWWU6SbPAgpOnqgauTNAcu7q97kXKLup4FE13SJLnk8PLr9SZtGAXBEzy/08UNqlreS6NvQybpp7JkedlXe4LsP/EGlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491739; c=relaxed/simple;
	bh=FQtOdAadtJgxB15TMtnZ1MxtNBTYTLRHpvSphzowYPA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=UWwEcbrpUi8w5usTOfb+O4L20G/t1lC3+uQYtS0d+wSXWobK256kIyH5lV88Yc6r5233EWyfsL+X1HuR4EiFRrOUpfaIpWhZL/aQVVUvKcQba65mm+c76IBsuPNDg4rUsYo0K7BB50gLlrH0YA6sqU03TnAjqwuLt0dh70CtkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cieuSILB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cieuSILB"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240916130214euoutp02aa55feff6a36e37f4f936d30d83151c1~1uxXcT94g1811418114euoutp02Y
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 13:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240916130214euoutp02aa55feff6a36e37f4f936d30d83151c1~1uxXcT94g1811418114euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726491734;
	bh=Oh5AZ/A0I1IDwcZK/pV36EkdX2y9NmYlY6RctXXQcnE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cieuSILBmmCaGMH6JIDeeWjDpYQgVsuBJfjZBJUixBn5XLEjk7Oq+Ftt1v/Sg8ex2
	 xbi00lZIqhgBZXiqSH8J1tbyulXvDD86RMGhODWUrpb0g4rXQHMV/npX/mCScWw27e
	 gzZFn07aRAnwLAEYz4lRKtog0JE63r+Jv+FBc8/4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240916130214eucas1p1a342e3ed5fecdeb5519555a2400d0b5d~1uxXMjCGT1987919879eucas1p1H;
	Mon, 16 Sep 2024 13:02:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.52.09875.65C28E66; Mon, 16
	Sep 2024 14:02:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916130213eucas1p14bcfea10fff9a689e138a576d94e1560~1uxWrmGVj2332223322eucas1p17;
	Mon, 16 Sep 2024 13:02:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916130213eusmtrp19d08b0ff4cba97e7132c5e5c709bda8b~1uxWqnxco0912309123eusmtrp14;
	Mon, 16 Sep 2024 13:02:13 +0000 (GMT)
X-AuditID: cbfec7f4-9acd8a8000002693-1c-66e82c567579
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.9E.19096.55C28E66; Mon, 16
	Sep 2024 14:02:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916130213eusmtip274db698c54c972a1986f16d67d3c778f~1uxWcv1ip2259722597eusmtip2a;
	Mon, 16 Sep 2024 13:02:13 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 16 Sep 2024 14:02:13 +0100
Date: Mon, 16 Sep 2024 15:02:08 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20240916130208.g7a7isdby6ujpykh@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240915134928.GD869260@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87phOi/SDNqXiVtsnriVzWLiysnM
	Fr++WFjsP/iN1WLmjBOMFp2zN7BbLH27ld3i8q45bBYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bF6h5bF4z0smj3M7zrN7bFrVyeYx72Sgx4vNMxk9Pm+S89j6+TZLAFcUl01Kak5mWWqRvl0C
	V8bJK6fZChpFKi53zWFuYNzM38XIySEhYCJx/9435i5GLg4hgRWMEs+XbWeFcL4wSkycv5Ed
	wvnMKNH77RJjFyMHWMuXrQ4Q8eWMEus+3GCEK2pcfRFq1mZGifYXIBlODhYBVYlDq1rYQWw2
	AR2J82/uMIPYIgJKEvt2TQRbwSzwhUnix7tmNpCEsICPxPe2MywgNq+Ag8SPPU+YIWxBiZMz
	n4DFmYEGLdj9iQ3kJGYBaYnl/zhAwpwC+hK39m9hgXhOUeLr4ntQdq3EqS23mEB2SQjM55To
	n/+WHSLhItEwZxIjhC0s8er4Fqi4jMTpyT0sEA2TGSX2//vADuGsZpRY1viVCaLKWqLlyhOo
	DkeJq99OMUECiU/ixltBiEP5JCZtm84MEeaV6GgTgqhWk1h97w3LBEblWUhem4XktVkIry1g
	ZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmLhO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBW
	EuG1/f00TYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoEp
	9/rdOr/y95pW385272aW+bT8hLTPt0j5f3LPj52XE+YJnzNZdIfennu6vzZ27HFcxPteJfKu
	V8+bhzF5W1u1FPWYWh8fOB5nsa2vu1zvpCP7sTlXF4jG3n4UxB94LTh94jT1O+yXy999Ettc
	KhAnzGC5gccvyn6KUfZUpcbM6zn7Y2Ua9iru9Ak8nLFsxrFrZw5w9ZWwxftlh0msa5i9JcFk
	b/HDsC8fVQ+4G4Z867mz1CqVMbfCxlPR3sjm8zmmWxtfh3w/7N7/8MUPk71MrtFHmf26nPTy
	5bOeBUyx8gmRmmPUGOMUL63gxeTQ8D7x4OeuWUdv1x78knh3q+fG8k2ZJ3b4WD4yPVT65LES
	S3FGoqEWc1FxIgBXQz2tywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7qhOi/SDBavN7DYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyTV06zFTSKVFzumsPcwLiZ
	v4uRg0NCwETiy1aHLkYuDiGBpYwSjU+bGLsYOYHiMhIbv1xlhbCFJf5c62KDKPrIKLHzwSQo
	ZzOjxL81U1lAqlgEVCUOrWphB7HZBHQkzr+5wwxiiwgoSezbNZEdpIFZ4AuTxJdXF8ESwgI+
	Et/bzoA18wo4SPzY84QZYmobi8TsO+fYIBKCEidnPgErYgaaumD3JzaQu5kFpCWW/+MACXMK
	6Evc2r+FBeJURYmvi+9B2bUSn/8+Y5zAKDwLyaRZSCbNQpi0gJF5FaNIamlxbnpusZFecWJu
	cWleul5yfu4mRmD0bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCa/v7aZoQb0piZVVqUX58UWlO
	avEhRlNgWExklhJNzgemj7ySeEMzA1NDEzNLA1NLM2MlcV62K+fThATSE0tSs1NTC1KLYPqY
	ODilGpjK5z5onO1meu3ClScppvIVS9nNE1QSPT6t2xq1YG/plPkTpAy+XJjEN8+4/YzEi507
	KxRu27veW7WhfYLixKCkxVYPupsf511VVFvbarXAIndSR4r+klCVrq9LX72+d/8W25Z7h7p2
	z+Nta9i089Q20yNftK/dXXZ7V1nBpMzmuSrzL4SXXsq5+2K2Bce5sDzdtOfia3sDwj+t6Ns+
	aYPc6tnKn3u59upLSezVZz2zlVFGVrRWdNt0tc0l7AsS8lYKZrhO779zVDTW+KHE0iO3VA2V
	KoRuLGS7mr3Xase/6xcNDsTmyDfIMRz/t8Ls3bazzdyyKmH68bXhL1SXXReuKKnz+TA7WIch
	rO/MDlZ7JZbijERDLeai4kQAvGkvk2cDAAA=
X-CMS-MailID: 20240916130213eucas1p14bcfea10fff9a689e138a576d94e1560
X-Msg-Generator: CA
X-RootMTR: 20240915134935eucas1p264b4d0955ac93f2192dd29cef7a573aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240915134935eucas1p264b4d0955ac93f2192dd29cef7a573aa
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
	<20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
	<BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
	<e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
	<BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
	<c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
	<CGME20240915134935eucas1p264b4d0955ac93f2192dd29cef7a573aa@eucas1p2.samsung.com>
	<20240915134928.GD869260@ziepe.ca>

On Sun, Sep 15, 2024 at 10:49:28AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 01:49:44PM +0800, Baolu Lu wrote:
> > On 2024/9/14 10:53, Tian, Kevin wrote:
> > > > From: Baolu Lu<baolu.lu@linux.intel.com>
> > > > Sent: Saturday, September 14, 2024 9:18 AM
> > > > 
> > > > On 9/14/24 8:52 AM, Tian, Kevin wrote:
> > > > > > From: Joel Granados via B4 Relay
> > > > > > <devnull+j.granados.samsung.com@kernel.org>
> > > > > > 
> > > > > > From: Joel Granados<j.granados@samsung.com>
> > > > > > 
> > > > > > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
> > > > > > Move
> > > > > > all Page Request Queue (PRQ) functions that handle prq events to a new
> > > > > > file in drivers/iommu/intel/prq.c. The page_req_des struct is now
> > > > > > declared in drivers/iommu/intel/prq.c.
> > > > > > 
> > > > > > No functional changes are intended. This is a preparation patch to
> > > > > > enable the use of IO page faults outside the SVM/PASID use cases.
> > > > > Do we want to guard it under a new config option e.g.
> > > > > CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
> > > > > for the majority usages which don't require IOPF.
> > > > > 
> > > > > Baolu?
> > > > The OS builder doesn't know if Linux will run on a platform with PRI-
> > > > capable devices. They'll probably always enable this option if we
> > > > provide it.
> > > hmm then why do we need a SVM option? In reality I haven't seen
> > > a platform which supports IOPF but no pasid/SVM. so the reason
> > > for whether to have an option should be same between IOPF/SVM.
> > > 
> > > IMHO the point of options is to allow reducing footprint of the kernel
> > > image and many options are probably always enabled in distributions...
> > 
> > To be honest, I would hope to remove the SVM option some day. It's
> > nothing special except listening to an external notification and
> > synchronize the caches when the page table is updated. It's common to
> > all cases where a page table is shared between the IOMMU and another
> > component.
> > 
> > As for CONFIG_INTEL_IOMMU_IOPF, my suggestion is that we don't need to
> > add any unnecessary options unless we see a real need.
> 
> You could possibly bundle the SVA and IOPF options together
> 
> I called the new option on the ARM side CONFIG_ARM_SMMU_V3_IOMMUFD
> which seems like a reasonable cut point against embedded vs server.

I'll go with Baolu's suggestion of leaving as is for my V3.

Thx for the review

-- 

Joel Granados
