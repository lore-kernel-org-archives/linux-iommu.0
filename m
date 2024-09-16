Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91F156C73
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489506; cv=none; b=FlBppSKsEKD8hBGAoOPKtkcUIdEmPXsYZbQfJypyNIN8SgGhEZDUhijphNU7d0PcP4IjXEuW91HN88wvljDg97KQA+opsAEszphqYdHwRzLyPBpUYoXNvSybHyIb3OmXQZT+Tj69IPXDqb4CUNKIcsnDxD43a18cI+ZpcoGrWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489506; c=relaxed/simple;
	bh=o9EnbdwllzhNTbJpj69Z9Kw1ccdl7ftBqQM5447Z5PE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=YwUPEBHc9ciL/Gf/y9E2OS/z+pqN3sFpci9iAWQWCnD94mzBqlXhxK8n4TcdBUa1C0ZcMmhtJ950nJcQt63Ueo+m8n4ty6SQQXLY1+P2GrUuWcEFHFd7MoQMMSUoOf2EAXAMyEtJDnwhQUvYBOztZ14eZZpk0qtdaa9mO+ljwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZgaCTtNx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZgaCTtNx"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240916122502euoutp018f75ee798f941a81dd3b1f68ad202082~1uQ4UQ9qM2472824728euoutp01D
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 12:25:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240916122502euoutp018f75ee798f941a81dd3b1f68ad202082~1uQ4UQ9qM2472824728euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726489502;
	bh=YG451YJHsgVJn8e6zQFyXx78G1vI5JSdgFvQqBcmLVE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZgaCTtNxBSMPpKAZ2R7UQku2LUm+3/p5aTqe4anb7xB+oUJuOmd6CnLSQxGxa8zzv
	 bew9EM9Xfr+RTC8PQMN6ENaZMjOodrlUPU8r+5Ex++yvmL8ElCT+NLDUDcVrhfp0fD
	 5R1UXPnYGWQB09y6jIiL75AJJzNzXe11obJibFKw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240916122501eucas1p254275e22abdaf7df9a77e7954d2c44e3~1uQ37SlYK2892628926eucas1p2D;
	Mon, 16 Sep 2024 12:25:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.49.09624.D9328E66; Mon, 16
	Sep 2024 13:25:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916122501eucas1p1372c5ce0f8988b2e3a313971452c187b~1uQ3eKInq0914009140eucas1p1f;
	Mon, 16 Sep 2024 12:25:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916122501eusmtrp15995193d78df13a67b4938b962ca3e89~1uQ3bbTJZ1937519375eusmtrp1L;
	Mon, 16 Sep 2024 12:25:01 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-86-66e8239d2b5a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.F4.14621.D9328E66; Mon, 16
	Sep 2024 13:25:01 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916122501eusmtip267fbebe6a98e60ad221a30ac23e11cc1~1uQ3OTPji2645126451eusmtip2X;
	Mon, 16 Sep 2024 12:25:01 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 16 Sep 2024 13:25:00 +0100
Date: Mon, 16 Sep 2024 14:24:56 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <20240916122456.gzb5oukf5m3ehh6q@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240915133734.GC869260@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87pzlV+kGVw/Z2CxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBm/TjxlKujgrvh/5TFzA+Ntji5GTg4JAROJ270LmUFsIYEVjBK/rph0MXIB2V8YJSY/+ccI
	4XxmlPjYNYURpmPBiedMEInljBL3vixgg2gHqpo9WRcisZlR4vq7i2AdLAKqEtM3bATbwSag
	I3H+zR0wW0RASWLfronsIA3MAjuYJPpmTwKbJCzgKfGw7RuYzSvgIHFm1n8oW1Di5MwnLCA2
	M9CgBbs/AcU5gGxpieX/wP7hFNCXeL3qOjPEpYoSXxffY4GwayVObbkFdrWEwHxOiX/Xb0EV
	uUi87X3PDmELS7w6vgXKlpE4PbmHBaJhMqPE/n8f2CGc1YwSyxq/MkFUWUu0XHkC1eEo8e3J
	O1aQiyQE+CRuvBWEOJRPYtK26cwQYV6JjjYhiGo1idX33rBMYFSeheS1WUhem4Xw2gJG5lWM
	4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBaev0v+OfdjDOffVR7xAjEwfjIUYJDmYlEV7b
	30/ThHhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGpjmp0yK
	OSPr0Vj0OetYheaXOJuEC7XfpqxfWNjmsyGMl8/H8vwnttIDfwsympdGyCz3s7jG082xY2P0
	qW8Ba1ZtWWrO7R3HdDR4zk3O5SsWtEvM/HR79nuxc8UtCjzLzszquxLIOanuTrBFitVjVaHb
	dYGcEfeYls3/1sU2+8mJ00X1Wfsu2U95c80jufCwvVW0lkaZutxcx5KibK5fwXVn+yTEol+c
	8czMOvvH1/7sLNn/PVZxCbPK7voLH0ibInTt/Lp/STzVbh4d8jH79jQv+eRfVDlJXuFC2UPD
	G0lRj2/vm/l1yUrON45NLtaf727N3iFZtV1RptntTPISgdW/WDrOLGcy1Y26mV5sZ6jEUpyR
	aKjFXFScCABNOgmQygMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pzlV+kGfy8xG+xeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehm/TjxlKujgrvh/5TFzA+Nt
	ji5GTg4JAROJBSeeM4HYQgJLGSWOTQmBiMtIbPxylRXCFpb4c62LrYuRC6jmI6PEjq0tTBDO
	ZkaJKXf2sINUsQioSkzfsJEZxGYT0JE4/+YOmC0ioCSxb9dEdpAGZoEdTBJ9syexgSSEBTwl
	HrZ9A7N5BRwkzsz6D7XiMJPEhjNfWSESghInZz5hAbGZgaYu2P0JqIgDyJaWWP4P7AVOAX2J
	16uuM0OcqijxdfE9Fgi7VuLz32eMExiFZyGZNAvJpFkIkxYwMq9iFEktLc5Nzy021CtOzC0u
	zUvXS87P3cQIjN5tx35u3sE479VHvUOMTByMhxglOJiVRHhtfz9NE+JNSaysSi3Kjy8qzUkt
	PsRoCgyLicxSosn5wPSRVxJvaGZgamhiZmlgamlmrCTO63b5fJqQQHpiSWp2ampBahFMHxMH
	p1QDU7ZR9NlZwgWidjX+xUk27g/jI8pDr0/uP2MToL7/2KpMV9UtoQFrlDPnmjT+UpN6e/WL
	cViw/501TJqlp+V8Nu0t+lS3/9hFhZKPXEeW1YcH3E77tnXV4f1PVX/U7GBxDD3SoSMotPqs
	4wcnAaEPGQG/mkqWr3Pd8veE/cG8NZF8smdvv17S5M7Y6349S1x6+YJ5XGufHr235uu8oslX
	rLVv1xs5XdkR9FzrfqSq1BPP3fdjH66a8TzQSy9fT8e/xu33zmrXxybP90pq6r74X2jenBX2
	5JFA7tPX7Rp6WTumhew8tLDj6IODH1/9iTyT/2ODw7WPk6u3Mx+xFncWa8vd5T1z6Zq9Cp++
	hp/5vUSJpTgj0VCLuag4EQDhxHDnZwMAAA==
X-CMS-MailID: 20240916122501eucas1p1372c5ce0f8988b2e3a313971452c187b
X-Msg-Generator: CA
X-RootMTR: 20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
	<CGME20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba@eucas1p2.samsung.com>
	<ZtxFAxM6QQBYVSJp@ziepe.ca>
	<20240911074059.f3i22vso6g6payrj@joelS2.panther.com>
	<20240915133734.GC869260@ziepe.ca>

On Sun, Sep 15, 2024 at 10:37:34AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 11, 2024 at 09:40:59AM +0200, Joel Granados wrote:
> > On Sat, Sep 07, 2024 at 09:20:19AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> > > > @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
> > > >  	depends on X86_64
> > > >  	select MMU_NOTIFIER
> > > >  	select IOMMU_SVA
> > > > -	select IOMMU_IOPF
> > > 

Will answer this based on https://lore.kernel.org/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com
as there are small differences with the current version of this patch.

> > > Does patch 1 still compile if INTEL_IOMMU_SVM=n?
> > It does for me. With and without INTEL_IOMMU_SVM. Is there a config that
> > is not compiling for you? You can send that you to me and I can give it
> > a try, to see if I get the same issue.
> 
> Okay, it compiles, but it is broken right? This hunk just can't be
> correct, SVM needs IOPF to work

AFAIK Yes: SVM *does* need IOPF to work. But IOMMU_IOPF *will* be
selected if INTEL_IOMMU_SVM is selected because INTEL_IOMMU_SVM is
covered by the `if INTEL_IOMMU` condition. Its the same way that the
relation between INTEL_IOMMU_SVM and PCI_PASID is handled: PCI_PASID
will be set if INTEL_IOMMU_SVM is set.

Please let me know if I'm misreading or have missed something.

Best

-- 

Joel Granados
