Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A5153BC7
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052237; cv=none; b=EtAMN9zt07zQg2mbckFTNfIuyfdEel+QtmtFgBWCiID0lWD8VCvIQncHb7mhlEIXXomqk2qqtckpfPs7qjjVOJ6zrMjbQQWHOyK2LoF3TLetJHv6z1mi1mlzQUDwgtkMFGkMuwKBfw9slzStf/zlfsVFkrNA+2aldDg9vjwjlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052237; c=relaxed/simple;
	bh=18ZNckk6FjR7ip7D+UJz4KPDfiLlRhGGvbomCsn0jI0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=kxbM9V/iTFID6NNMAanaHwp7T7B3sy1wpV3xlTwVBsMdpcJKUJyiNWO1mfuTQDV5xCmzJCvWZOIoyCYN3oUUMnndaUsviOytJ4VJ3DLujdQGjmF4ejPQLDSeSkkR2tdvpu1Rrr3HkipQngI+uD3drfP6iZRWMra4MvnIfaP+mMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r8wmYRra; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r8wmYRra"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240911105712euoutp023f659c764b5bf761e282e45749163660~0K1xL7_mB1520315203euoutp02U
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:57:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240911105712euoutp023f659c764b5bf761e282e45749163660~0K1xL7_mB1520315203euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726052232;
	bh=Hl+GFYWFhkSr8PV50aJtpBPf4Ss06AJQHxeDfZs8vwg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=r8wmYRraV8y6URB9hpR6bgyJOiVLGRQynMu6QrRvetUaaeMwE90xKxHzCcd+Q2mXW
	 Gg0XRdMFMQC/5wrrwa26MQK9nQPy+VOxVOcRNLxvJQGDI8mzI4dr49vtT2DAgAPuXA
	 5Bq+sNPfYJXRM1dwX9VoJRpgAU4/H+tHCifQH6Lc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240911105712eucas1p1d0781938f6b9436240ce394d36c4f4f3~0K1wwsBbk2148121481eucas1p19;
	Wed, 11 Sep 2024 10:57:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.10.09624.88771E66; Wed, 11
	Sep 2024 11:57:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911105711eucas1p103b9e37bfc58347a06d84d0800a9558e~0K1wVC5o81277312773eucas1p1n;
	Wed, 11 Sep 2024 10:57:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911105711eusmtrp152f1912db32208c1cd93a16aa20b7bcf~0K1wUMuCV0922709227eusmtrp1V;
	Wed, 11 Sep 2024 10:57:11 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-84-66e17788dce8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.51.19096.78771E66; Wed, 11
	Sep 2024 11:57:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911105711eusmtip16f7e83687e99ba68f50ae70048bdc1ba~0K1wJdjEK2589425894eusmtip1j;
	Wed, 11 Sep 2024 10:57:11 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 11 Sep 2024 11:57:01 +0100
Date: Wed, 11 Sep 2024 12:56:57 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7od5Q/TDFZcYLHYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	royZF+ILXnBXTG5/zNrAeJizi5GTQ0LAROL86xnMXYxcHEICKxgllnb8Y4RwvjBKnL3Szgrh
	fGaUuLbkEztMy9MXj1hAbCGB5YwSGxvt4YqWX/4F1b6ZUWLq7PXMIFUsAqoSzbu+gnWzCehI
	nH9zBywuIqAu0dS4lw2kgVlgI5PE3H+HwRLCAgkSM/+eYQKxeQUcJD5+f8gOYQtKnJz5BGw1
	M9CgBbs/ATVzANnSEsv/cYCEOQWcJf5Ob2SGuFRR4uvieywQdq3EqS23mEB2SQhM55Ro2tgE
	VeQicfPJSyYIW1ji1fEtUG/KSJye3MMC0TCZUWL/vw/sEM5qRolljV+hOqwlWq48gepwlOj7
	3M0EcpGEAJ/EjbeCEIfySUzaNp0ZIswr0dEmBFGtJrH63huWCYzKs5C8NgvJa7MQXlvAyLyK
	UTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMG2d/nf80w7Gua8+6h1iZOJgPMQowcGsJMLb
	b3cvTYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoHJpFu/
	81Piyr5VzG32KVWh6qWyyz5dPWXd1DM/ceNs12Nf1r2cxKu3M1X12bR4r4+tiQ+XbTFrM1k4
	fWnbxPcr/rS1fbqoNP/Wn+j6958Xtc04rfZiNlf+E9l5xnp8wrYhtttPzue92FMiMyfoLde8
	gCWJRRo675kSMjcXBjNPq+fe1bHg9+QTRRcqpU0tz96QfXD4QlJc5QLjhw45HrbyC11eBha+
	SCq5Liny3e2ExmLL7j6Jigbvvwt+hnytZ/8aUFhd6sRfYnx7Kef+q0nndx6azsa9OSH+Vl/V
	J4Gq31xnjnNP3hds+KsofWXOzXfPw9ewFFxeJfEhW2nugtcu9f4Ze3S2HF/i6xsr/6RKiaU4
	I9FQi7moOBEAKZ2OrMoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7rt5Q/TDHZ+UrXYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyZF+ILXnBXTG5/zNrAeJiz
	i5GTQ0LAROLpi0csXYxcHEICSxkl/r48zASRkJHY+OUqK4QtLPHnWhcbRNFHRomra5ZBdWxm
	lDh77TALSBWLgKpE866v7CA2m4COxPk3d5hBbBEBdYmmxr1g3cwCG5kkbpxrAlshLJAgMfPv
	GTCbV8BB4uP3h+wQU5uYJNrXvGeBSAhKnJz5BMxmBpq6YPcnoEkcQLa0xPJ/HCBhTgFnib/T
	G5khTlWU+Lr4HguEXSvx+e8zxgmMwrOQTJqFZNIshEkLGJlXMYqklhbnpucWG+kVJ+YWl+al
	6yXn525iBEbvtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8/Xb30oR4UxIrq1KL8uOLSnNSiw8x
	mgLDYiKzlGhyPjB95JXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnV
	wFSvoSy3dFmi4uEJHbpP7vpvfy04O7qwRy/ESNi7VPO5pRTrRYbdJ3ae2O2oujsoYeqLfSvb
	OSpmHbyttUv9undKcbheeduSNX8KWZ98OrvCPMbbmmv1EsF26R2W8ixr7l5LjvO6xMbq98c2
	3uqE5qX1jR9nMZxIKNq8uUVxndrODofO7+trlhSLP58ZkMwTd8bod0b0gmxOCYt+Axbf9FvH
	FihKZNm0RfXvNDXlcFnx4ZnvpAAD7b5bDaXbXaQFrJaKTO7+P22iR+Jprdy9GjkcmxiFl+xv
	+PjS+aFT280H/emCchv9jOqqZ6acFf2yY9XSw11PLxVKPd6QrhOcvHWC37t929OT/m1+mX9k
	tRJLcUaioRZzUXEiAJYauZhnAwAA
X-CMS-MailID: 20240911105711eucas1p103b9e37bfc58347a06d84d0800a9558e
X-Msg-Generator: CA
X-RootMTR: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
	<CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
	<c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>

On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > iommu_report_device_fault expects a pasid array to have an
> > iommu_attach_handle when a fault is detected.
> 
> The iommu_attach_handle is expected only when an iopf-capable domain is
> attached to the device or PASID. The iommu_report_device_fault() treats
> it as a fault when a fault occurs, but no iopf-capable domain is
> attached.
> 
> > Add this handle when the
> > replacing hwpt has a valid iommufd fault object. Remove it when we
> > release ownership of the group.
> 
> The iommu_attach_handle is managed by the caller (iommufd here for
> example). Therefore, before iommu_attach_handle tries to attach a domain
> to an iopf-capable device or pasid, it should allocate the handle and
> pass it to the domain attachment interfaces.
What do you mean here?
1. Do you want to move the iommufd_init_pasid_array call up to
iommufd_hwpt_replace_device?
2. Do you want to move it further up to iommufd_device_do_replace?

Note that all this implemented on a call to replace HWPT. So a
non-iopf-capable VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl has already been
completed before the one that calls iommufd_device_do_replace.

> Conversely, the handle can
> only be freed after the domain is detached.
Do you have a function in specific where you would put the free handle
logic?

Best

-- 

Joel Granados
