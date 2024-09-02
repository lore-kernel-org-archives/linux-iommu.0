Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC0185B56
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275223; cv=none; b=CH992jBCitDYeRmFKl9BQ56coJeBnvsEv7AFPnC8Gs9tCHNul1v6ko9XrTQno7qACsEeIIm7pOSgcv64RPHUQ2eeSVFxNrKr10uMRuSBeUQXiIizgznvUXK5TVZN2JP3rmMi8gHVCDs79raXOnYn0tSKZqa40Tq8pus5SspTcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275223; c=relaxed/simple;
	bh=a5KaArWim1jgkpd9lRD2RDBCehUDwxq3A5E+Qkv3nSE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=UAL25A79sCaW4ezGxSnbN5gNtjQXvZmIkhK2Vze17OhFpfAFaeOAuuzViX5ZZ+Z2SwBMb/ljkIeClPCWbaJh3lp3RHFBLz86+/Tg1hNX8d/VFcYxHFRYQ/s1ccJIISKIOHePI1j5nBeBFZt1yNYRdqUsKCAELzuCbUkWp3+7xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BcCvsTPA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BcCvsTPA"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240902110659euoutp022cb3a2901e9a5da89df0d05bb14b4d73~xaKvFhfWT0209402094euoutp02p
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 11:06:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240902110659euoutp022cb3a2901e9a5da89df0d05bb14b4d73~xaKvFhfWT0209402094euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725275219;
	bh=xOdOKreQd2XZ1x7oFdQ2707cX7No2r6RlN3xMLIIENU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BcCvsTPA8NrxpocNbPFw/A+N9DeklFbiAVA79qyAk9pNnKizKBpBK2uZz4RC29dwc
	 TxTcB9EsHrczQLg19bCElmDYWbGB+Dowfs1N/8axHnXJHW5lWNEvxrOXIEg1TSxLKE
	 Hh4NuF40lx/5mBgPG5dwJe5go7xME5nPnrjSboLw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240902110658eucas1p15751d4dd65b6d93e9a2626481138aef3~xaKuxZq4K1177911779eucas1p1Y;
	Mon,  2 Sep 2024 11:06:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.3F.09624.25C95D66; Mon,  2
	Sep 2024 12:06:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902110658eucas1p1936ef7bc9f13972db6863e2dc189ba70~xaKuOO8PX1177911779eucas1p1W;
	Mon,  2 Sep 2024 11:06:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902110658eusmtrp1d60ff84a11b651244bae3a64fd704ca0~xaKuNJQ_C2024020240eusmtrp1G;
	Mon,  2 Sep 2024 11:06:58 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-a6-66d59c52593a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.0A.14621.25C95D66; Mon,  2
	Sep 2024 12:06:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240902110658eusmtip2fcbe6570f09ebdb6f4be3596c755df30~xaKuABIaS1423314233eusmtip2n;
	Mon,  2 Sep 2024 11:06:58 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 2 Sep 2024 12:06:56 +0100
Date: Mon, 2 Sep 2024 13:06:52 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240902110652.dscriqvzzfpdmewr@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7pBc66mGWz9oWWxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBkPvuxlKTgjUfFv8grWBsZFwl2MHBwSAiYSG275djFycQgJrGCUeHLgLBOE84VRovHBJzYI
	5zOjxK5Vl9m7GDnBOhbfO8YMkVjOKLHp0yxWuKpLb/4xQjibGCU+nVrLArKERUBFon1RBkg3
	m4COxPk3d5hBbBEBJYl9uyayg9QzC7QwS+x+28wGkhAWSJVYsnIDE0gvr4CDxJIWSZAwr4Cg
	xMmZT1hAbGagOQt2g5zHAWRLSyz/xwES5hRwlPj4fz0bxKGKEl8X32OBsGslTm25BfaahMBy
	TokHdxuhvnGR6Lz0mxHCFpZ4dXwLVFxG4vTkHhaIhsmMEvv/fWCHcFYzSixr/MoEUWUt0XLl
	CTskJB0lntyMgDD5JG68FYS4k09i0rbpzBBhXomONiGIRjWJ1ffesExgVJ6F5LNZSD6bhfDZ
	AkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIEp6/S/4592MM599VHvECMTB+MhRgkO
	ZiUR3qV7LqYJ8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1
	MM2OOBo++f7Je12JYatn6LQGN3Ooz2ZY7mS8uDH73p5j3tOPzbjn+OHUuQnRi5jnlS/ZYhd1
	sWJP7BxlRfEFfqx18UZr8nMqRO6alrsf/FHtKdjLKhedtZJ3z7Kt1neUz35TeN8puGcK/9cT
	F+7GzZLh+dxzX9Pcv5/N7EKilmKa1cUz4bXuR87a5X2YZnady1ihTzXSIuxMyM6YD2qmXeq+
	Ox9O3+3YfVXw1zqBS0Z/3r8Ta771cIvCij2XYk5+lux4e/H9srRnZZyLgxfJm1iGLrqV12lU
	n/LR6kzDU6+O6OyDt3y2dUrlxN6cwNLdcPaKwPO+JTOVZ4pNaDGPqowT3u+1+Hn99ml7TsdU
	/VdiKc5INNRiLipOBADJpNZcyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pBc66mGfy8wGWxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkPvuxlKTgjUfFv8grWBsZF
	wl2MnBwSAiYSi+8dY+5i5OIQEljKKLHt7wR2iISMxMYvV1khbGGJP9e62CCKPjJKHPi1iQnC
	2cQoMWXuUcYuRg4OFgEVifZFGSANbAI6Euff3GEGsUUElCT27ZrIDlLPLNDCLLH7bTMbSEJY
	IFViycoNTCC9vAIOEktaJCFmfmKUeN19BuwKXgFBiZMzn7CA2MxAQxfs/sQGUs8sIC2x/B8H
	SJhTwFHi4//1bBCHKkp8XXyPBcKulfj89xnjBEbhWUgmzUIyaRbCpAWMzKsYRVJLi3PTc4sN
	9YoTc4tL89L1kvNzNzECY3fbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd6ley6mCfGmJFZWpRbl
	xxeV5qQWH2I0BYbERGYp0eR8YPLIK4k3NDMwNTQxszQwtTQzVhLndbt8Pk1IID2xJDU7NbUg
	tQimj4mDU6qBqXJuwrG/Ks8PsM1OOH7rvGPk5fRc413B91Pm7dj8IGXX91VG6ttqle79nOn5
	UTo1dld0gF2965lJkz23xiqLy8gJnfvA+9Bq6aWlN3dOvbvcLi6Nl+237lafvHNBVvPnL98R
	9SpCMeYpwyuuzxttv1yTYvNb5nEgb24IV+bp6S8SmzfVsMvs9hH3qpkxRyJ1X/R3nX+Smq1a
	jrwdwbbZHNtX3DfNOnQnXFSG+e+0XH9f2w+NE6ZvLdQ7nTtnU7SI/OScc55TxVk3Kqm+1tVq
	byx7/Ovh91drzNb0CB4RPK/903dieOZ8v+cHDuxvnvlYtFJnftm8mesPLjn4w3+ib9NW9v3p
	Ntk/jk3amr51Z7kSS3FGoqEWc1FxIgC2SH9xZgMAAA==
X-CMS-MailID: 20240902110658eucas1p1936ef7bc9f13972db6863e2dc189ba70
X-Msg-Generator: CA
X-RootMTR: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
	<20240826135955.GI3468552@ziepe.ca>
	<20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>

On Mon, Sep 02, 2024 at 12:48:19PM +0200, Joel Granados wrote:
> On Mon, Aug 26, 2024 at 10:59:55AM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 26, 2024 at 01:40:26PM +0200, Klaus Jensen wrote:
> > > This is a Request for Comment series that will hopefully generate
> > > initial feedback on the use of the iommufd_hwpt_replace_device to
> > > execute non-nested and non-svm user space IOPFs. Our main motivation is
> > > to enable user-space driver driven device verification with default
> > > pasid and without nesting nor SVM.
> > > 
> > > What?
> > >   * Enable IO page fault handling in user space in a non-nested, non-svm
> > >     and non-virtualised use case.
> > >   * Removing the relation between IOPF and INTEL_IOMMU_SVM by allowing
> > >     the user to (de)select the IOPF code through Kconfig.
> > >   * Create a new file under iommu/intel (prq.c) that contains all the
> > >     page request queue related logic and is not under intel/svm.c.
> > >   * Add the IOMMU_HWPT_FAULT_ID_VALID to the valid flags used to create
> > >     IOMMU_HWPT_ALLOC allocations.
> > >   * Create a default (zero) pasid handle and insert it to the pasid
> > >     array within the dev->iommu_group when replacing the old HWPT with
> > >     an iopf enabled HWPT.
> > > 
> > > Why?
> > >   The PCI ATS Extended Capability allows peripheral devices to
> > >   participate in the caching of translations when operating under an
> > >   IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
> > >   devices to handle missing mappings. Currently, PRI is mainly used in
> > >   the context of Shared Virtual Addressing, requiring support for the
> > >   Process Address Space Identifier (PASID) capability, but other use
> > >   cases such as enabling user-space driver driven device verification
> > >   and reducing memory pinning exists. This patchest sets out to enable
> > >   these use cases.
> > 
> Sorry for the late reply, Slowly getting through my backlog after PTO
> 
> > I definitely expect PRI to work outside PASID and SVA cases, so this
> > is going in a good direction
> This touches on a detail (at least in Intel's vtd-io spec) that is not
> 100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
> Address Translation" reads:
> "
>   ... Scalable-mode context-entries support both requests-without-PASID
>   and requests-with-PASID. However unlike legacy mode, in scalable-mode,
>   requests-without-PASID obtain a PASID value from the RID_PASID field of
>   the scalable-mode context- entry and are processed similarly to
>   requests-with-PASID.Implementations not supporting RID_PASID capability
>   (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
>   translation for requests without PASID.
> "
> This basically means that a default PASID is used even though the
> request is without PASID. Right? Therefore "outside PASID" means with
> the default PASID (at least in Intels case). Right?
This is something that is related to patches 5/6 and 6/6 of this set.
And maybe is more a question for Lu Baolu.

Best

-- 

Joel Granados
