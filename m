Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EB178CE4
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949629; cv=none; b=p6UUQ9esO1gAEPmnRn3tlZl338b69c+NU2dllOQJPd/Fwmg+cdQZAYoc1Ji8Ld0WhYpM5vYEYiAxRb7zB6P9BwqjdswmoLEKxriH+QfsuOof4XM+D9OvFniDqDmKZqiS6AzYjeqy2sE3T38ecZA5N6WuiPyWIh91I4+K0imMAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949629; c=relaxed/simple;
	bh=gBSpn0+a/kGfSVjDSYxy6KPnKqHkaFUodo08onrpc7A=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=K/eLbBgo5gHlmeRuxJmidwlslgNu9kXFpDC5Lv/uCygP/kZP22flRdlj1WvpCjpO81zWimlf2S/xGablJSNy1Ydb5udCPb2pCfsOKFHdCm91VZIG5TeNvXvvV+f21R332AuO5lbB9VQCWThz5UidWIDR0Pwm7T+ClqxzEFNT/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gUgUACYR; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gUgUACYR"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240910061938euoutp0206275fbe7706759b87b10e754419cb8e~zzaI5aW-k3036930369euoutp02S
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:19:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240910061938euoutp0206275fbe7706759b87b10e754419cb8e~zzaI5aW-k3036930369euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725949178;
	bh=Um/elcx0Nv3kpTzyB5+UQQqdSo4Gc94HySx+FZ1SXmw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gUgUACYRCVaMdTx5I5Em31zhLCKJuRo0zXjo5EK4beIquqwfma5CqWuccWWNgyd8h
	 nPhqoPncO77pVW+rjEjIeqSpu1+MsPgmBEbtiPFOgh3dxDpfSHfXR87XQBpJCyp+zK
	 Gz1MLldbOvDtScdDNfJQxFk62mJhBhRYPIrvGCGI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240910061938eucas1p25e8fa38df93e8d1813a9ef4019682711~zzaIm2cRC2717127171eucas1p2s;
	Tue, 10 Sep 2024 06:19:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.F6.09875.AF4EFD66; Tue, 10
	Sep 2024 07:19:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240910061938eucas1p10fa941904d238a03d5817d79800355ad~zzaILyH071849618496eucas1p1B;
	Tue, 10 Sep 2024 06:19:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910061937eusmtrp23614bf6da9e8186f89d06d86f06f14ef~zzaIDuAbl2136121361eusmtrp2D;
	Tue, 10 Sep 2024 06:19:37 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-e6-66dfe4fae8b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.D9.14621.9F4EFD66; Tue, 10
	Sep 2024 07:19:37 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910061937eusmtip26590695d27fedfa04a4455516d64bee8~zzaH28iIO2703027030eusmtip2L;
	Tue, 10 Sep 2024 06:19:37 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 10 Sep 2024 07:19:33 +0100
Date: Mon, 9 Sep 2024 16:46:23 +0200
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
Message-ID: <20240909144623.kunm4xg4sglv77wb@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904161350.GE1909087@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87q/ntxPM1jVIGWxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBnP93WyFfzir1h6djFrA+MGni5GTg4JAROJ5a8fsHQxcnEICaxglHh/azIbhPOFUeLFglYm
	COczo8SFH/cZYVq2fu9lhUgsZ5S482wPQtXe/WvZIZzNjBLbHxxhBmlhEVCR+LN0IiuIzSag
	I3H+zR2wuIiAksS+XRPBGpgFWpgldr9tZgNJCAukSixZuYEJxOYVcJDYuv8OI4QtKHFy5hMW
	EJsZaNCC3Z+A6jmAbGmJ5f84QExOAQOJ1+t9IS5VlPi6+B4LhF0rcWrLLbBDJQRmc0psu7CY
	EaReQsBF4sqndIgaYYlXx7ewQ9gyEv93zoeqn8wosf/fB3YIZzWjxLLGr0wQVdYSLVeesEMM
	cpR4cjMCwuSTuPFWEOJKPolJ26YzQ4R5JTrahCAa1SRW33vDMoFReRaSv2Yh+WsWwl8LGJlX
	MYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCat0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4
	++3upQnxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwtXz2
	lT91PFYznfP2ac5Nqo+8l977IW07Z973kroF/9WibSd4NTjaxd6e2RUjd0rgkUzRArUdjuee
	RfC9ebtt+rR8e7PuqT9n7l99dNd+xp6PzZXFFx8Xys60+fRmbcZF0dmtph0OXqHCF++pCkkq
	b/ZR6cqseKrSyRQzu6RvnY3Sj+86xi2Hfu8udn3QVPRdwFXlzVzj1ElaLAtnKm3d0cUUnZhs
	w5ezdK1Kbde3TUd+7Hy98cecbR6Fkkendd6r0ynPPrUzc9OR6dGHltccW3XSzCP2lv+PKAt1
	lv+/vMpWGr28P2FD/Wrx8DsLg1vMO8o0pptrt8h+cGt3rcvyP+ZWHbb4xg/3T3fLc6Y9V2Ip
	zkg01GIuKk4EAKHWelfJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7o/n9xPM1jXa2yxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnP93WyFfzir1h6djFrA+MG
	ni5GTg4JAROJrd97WbsYuTiEBJYySuxdeZUZIiEjsfHLVVYIW1jiz7UuNoiij4wS53cehurY
	zChx/cNiFpAqFgEViT9LJ4J1sAnoSJx/cwdskoiAksS+XRPZQRqYBVqYJXa/bWYDSQgLpEos
	WbmBCcTmFXCQ2Lr/DiPE1BlMElP7tzBCJAQlTs58AraBGWjqgt2fgJo5gGxpieX/OEBMTgED
	idfrfSEuVZT4uvgeC4RdK/H57zPGCYzCs5AMmoVk0CyEQQsYmVcxiqSWFuem5xYb6hUn5haX
	5qXrJefnbmIERu+2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrz9dvfShHhTEiurUovy44tKc1KL
	DzGaAoNiIrOUaHI+MH3klcQbmhmYGpqYWRqYWpoZK4nzul0+nyYkkJ5YkpqdmlqQWgTTx8TB
	KdXAlLCp+X9cM/eeezOso0MyTbtbPbZZMf8Iuell3vT4z44tq69w1259ZaR1ZoGW90ame/Xm
	QRYTNj9IUDzvvWJWgL+lgx/b6vqE/h//OHwmz3Ff2Fw9OeRybJ+W/THGxJj306/E/uu7epqH
	eW/4i5Vdt2xVp6Ypta56ym06tZP1wpW7SbbLXr7IO2UjqsdXz/PaK6PDwjJmxbUvhrHRc1ed
	ftHLznq/pPq7tMGUWQ4PXO0vsRcc8naNazD6uPGShtvH76/XZGur5HNnLbqurth8rq/n0v/G
	BSpORWYlYvzrby/cOvmHXyvjrgwRQ/6eKg9jv4t35Kda9H3/d2Sienjmhp6JLKpcfhnXO4Ot
	nkxXYinOSDTUYi4qTgQAeSmB2GcDAAA=
X-CMS-MailID: 20240910061938eucas1p10fa941904d238a03d5817d79800355ad
X-Msg-Generator: CA
X-RootMTR: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
	<20240826135955.GI3468552@ziepe.ca>
	<20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
	<20240904161350.GE1909087@ziepe.ca>

On Wed, Sep 04, 2024 at 01:13:50PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2024 at 12:48:19PM +0200, Joel Granados wrote:
> > > >   Supplementary repositories supporting this patchset:
> > > >     1. A user space library libvfn [1] which is used for testing and
> > > >        verification (see examples/iopf.c), and
> > > 
> > > That's pretty neat, I've been wanting to see some kind of IOMMU test
> > > suite based around a capable widely available device. This is the
> > > closest I've seen..
> >
> > Yes! This is an obvious application of libvfn. Do you see it as a
> > something that can be included in tools/selftests/iommu?
> 
> Maybe? What would it look like in-kernel?
Having it in-kernel with libvfn might be a bit too much because we would
have to bring libvfn into the kernel sources. But we can have some sort
of DMA test suit that runs as CI. Similar to what fstests or blktest do
(dmatests?). And we can automate it all with kdevops.

Here is a very rough run down of the idea.
1. We create (or use if there is one already) a DMA test suit. That has
can run on its own
2. Use libvfn to create commands that poke at the iommu{,fd}, intel)
amd, arm drivers.
3. Use qemu iommu implementation as well as pci dma enabled devices as
the test devices.
4. Can use hardware if it is detected.
5. Can use kdevops to bring up the different environments (e.g. kernel and
qemu branch combinations) needed for the test.
6. And finally put the kdevops test targets into some existing kernel CI
like linux-next or 0day (or whatever makes sense).

> 
> I've been thinking the same thing with mlx5
Not too familiar with this driver, but if it makes sense to reuse it (or
part of it) to make the test happen, I'm all for that.

> 
> Maybe some kind of test runner with a plugin driver that has some kind
> of 'do dma', 'generate interrupt', etc sort of operations, IDK.
Yes. If you are up for it, we can maybe discuss it a bit in LPC and
flesh it out a bit more?

Best

-- 

Joel Granados
