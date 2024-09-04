Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637721A727F
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441157; cv=none; b=rmfJgWKiXD+XHF09rmGnjqMRSa9BMQ8ECyd6SEQQlI8CDDhNNlEmK64ebOw4qXLjcYUI6W2n+Xtwklol2EntPYENKeJjW1nY9y3VuGqmJ2zW0cgMxYVnm3o4X4yZy2o2XAonafg3saL8ESdhscvrO34703UevCxLoi9nJnVg+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441157; c=relaxed/simple;
	bh=8uIojRuUuh/ITTtgr6KCPgIS+H0p20N1kXWqEKyAHtk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Ah3NkvfvjrnKO+Qh9LvjjoaZaZqnYpbJoGSlJXYTIOeXCvrUwRxVUz41vOulau0PYrbyb0P/NGehUj/6yXv5h7RR7UmpUBVxiz34t5Ogpax0MGgy7+9IIR7L7Fv02UnlwgvVSTjrcil56Iq2m12sESDvwyWw0MDXaXexjygsvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vb6oO/A4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vb6oO/A4"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240904091233euoutp02c744957b7f4a086f77c61587fcac6318~x-5ZlpKFJ1684116841euoutp02k
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:12:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240904091233euoutp02c744957b7f4a086f77c61587fcac6318~x-5ZlpKFJ1684116841euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725441153;
	bh=qNCe5lDbU9IwCknv8oknYeAE3i96AqlNVmC+nptC8QU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vb6oO/A4HE0MLLSeOQxKPwAB9jF1YHsvxwCryCn42rZ1x7bY9UEsAIDR983dQj1Vc
	 nprMHSIinTp8g0/54PWp3MX2mhXVNdwknAiov3JZEsy8gD3e5ppI2FRC0hFMBVZHVm
	 +kbVIInOumTHW36KjXU6RYXrXWcJGXZnaZWQm51Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240904091233eucas1p14c334c438221935d3334208e3b47aadb~x-5ZRbd762523625236eucas1p1e;
	Wed,  4 Sep 2024 09:12:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id E7.39.09875.18428D66; Wed,  4
	Sep 2024 10:12:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240904091232eucas1p23cc532e9cd4acdbb7f3d2c7ad0073eca~x-5Yt0Oj72250522505eucas1p2j;
	Wed,  4 Sep 2024 09:12:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240904091232eusmtrp1f68797bd09f4a3efe112ec34e912568d~x-5YtLCaH1929319293eusmtrp1h;
	Wed,  4 Sep 2024 09:12:32 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-41-66d82481ad97
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.A3.19096.08428D66; Wed,  4
	Sep 2024 10:12:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240904091232eusmtip1b77e812b7d40ab4f8927fb666b12dad3~x-5YfRP6s0064500645eusmtip1c;
	Wed,  4 Sep 2024 09:12:32 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 10:12:27 +0100
Date: Wed, 4 Sep 2024 11:12:23 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 1/6] iommu/vt-d: Separate page request queue
 from SVM
Message-ID: <20240904091223.f3olpzrv5lkgekfe@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <242056a5-9d16-415a-9913-0add5b050f47@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7qNKjfSDO7dZ7fYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	rozt/x6xFvwTrZh/bS5TA+NkwS5GTg4JAROJWbeusHcxcnEICaxglHg86zkThPOFUWLfvH5W
	COczo8Sm/x2MMC13P82GalnOKDG39TUjXNW5ucuYQaqEBLYwSqydXgZiswioSGyeeB0sziag
	I3H+zR0wW0RAXaKpcS8bSDOzwF8miaW7n7CDJIQFwiVar+xnAbF5BRwkGrs6mSFsQYmTM5+A
	xZmBBi3Y/QmomQPIlpZY/o8DJMwp4Cxx9/ApqEuVJQ4uO8QOYddKnNpyC+w3CYHZnBKtl16w
	QiRcJG42zIcqEpZ4dXwLlC0jcXpyDwtEw2RGif3/PrBDOKsZJZY1fmWCqLKWaLnyBKrDUeL/
	/80sIBdJCPBJ3HgrCHEon8SkbdOZIcK8Eh1tQhDVahKr771hmcCoPAvJa7OQvDYL4bUFjMyr
	GMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPX6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8
	r0VupAnxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwTdlW
	M/XitcOBkbsC7itxFSy2dDc69vDG0wU7xPfKqz0In/M/ZldrvISg3z2l2/es5B7u5r0flOcz
	ozr1P0PTD9vsjoJgK62YVfwbCqK+nWrYvW6js2sb/5Q5T7yWcKUmvIy5JsT5kVW6frXveeHH
	mzckWEfoHjIIn5e5plj6UFT7k8D0PyfNb7LKeOtMjuu+92XjdIng7NWc0gp2R1/snvBl+uPJ
	E4Lkglg7jBasdfF+zuj2bfeV3VycLY9XFobvjfQLT/Jbc7B6YePxqTE7pPIz/yj8jHvsljKT
	he/D4urOz9cE2f+G6qpJvmKuPLCjY7uScepRnVX9NlvsfU5bm75e+eq9tsyE7jUn9zmvV2Ip
	zkg01GIuKk4EAKymABXLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7oNKjfSDP5OV7XYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzt/x6xFvwTrZh/bS5TA+Nk
	wS5GTg4JAROJu59ms4PYQgJLGSXObpWEiMtIbPxylRXCFpb4c62LrYuRC6jmI6PE438n2SGc
	LYwS3fMesoBUsQioSGyeeJ0ZxGYT0JE4/+YOmC0ioC7R1LgXrJtZ4C+TxNLdT8DWCQuES7Re
	2Q/WzCvgINHY1ckMMbWNSeLN7MeMEAlBiZMzn4AVMQNNXbD7E9AkDiBbWmL5Pw6QMKeAs8Td
	w6cYIU5Vlji47BA7hF0r8fnvM8YJjMKzkEyahWTSLIRJCxiZVzGKpJYW56bnFhvpFSfmFpfm
	pesl5+duYgRG77ZjP7fsYFz56qPeIUYmDsZDjBIczEoivK9FbqQJ8aYkVlalFuXHF5XmpBYf
	YjQFhsVEZinR5Hxg+sgriTc0MzA1NDGzNDC1NDNWEudlu3I+TUggPbEkNTs1tSC1CKaPiYNT
	qoEpS/dl+utpnkG1U1fUtgcyTrVjO3iTo3yWAWv/tytZPA7hGonuGifumKacC6yR6K8X3Nm+
	1+3PkZmqjX99PwRPnvSG+YnKf5ejpU7Kdp9qlk/T+hd+3cfnvOPKF5eO8rRrW2StlJi1a84y
	VYWNGRH57ydKnQzYlNWyPSO7+8e1GCbrg+c8H7x5+fUtO+POeXt9pj/czCs9jyvev8tveve8
	x9s3/IrVPrOgWOD1HqEH39WXBZcubnicln9b722IlmO+zoKlL6q011+78+O/TI6wR+eHXH7f
	xpA0tfSW9j9HFxbKHZA1OX16PWNP/pWXTYd6Wvk0/dQDmGzT7zvPtfnxpLotKtLw3eLWR+Ib
	zjIqsRRnJBpqMRcVJwIAvV2NrWcDAAA=
X-CMS-MailID: 20240904091232eucas1p23cc532e9cd4acdbb7f3d2c7ad0073eca
X-Msg-Generator: CA
X-RootMTR: 20240826130923eucas1p285627a5a210e62fbb0187962b1f8dde5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826130923eucas1p285627a5a210e62fbb0187962b1f8dde5
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
	<CGME20240826130923eucas1p285627a5a210e62fbb0187962b1f8dde5@eucas1p2.samsung.com>
	<242056a5-9d16-415a-9913-0add5b050f47@linux.intel.com>

On Mon, Aug 26, 2024 at 09:09:14PM +0800, Baolu Lu wrote:
> On 2024/8/26 19:40, Klaus Jensen wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
> > all Page Request Queue (PRQ) functions that handle prq events to a new
> > file in drivers/iommu/intel/prq.c. The page_req_des struct is made
> > available in drivers/iommu/intel/iommu.h.
> > 
> > No functional changes are intended. This is a preparation patch to
> > enable the use of IO page faults outside the SVM and nested use cases.
> > 
> > Signed-off-by: Joel Granados<j.granados@samsung.com>
> > ---
> >   drivers/iommu/intel/Makefile |   2 +-
> >   drivers/iommu/intel/iommu.c  |  18 +--
> >   drivers/iommu/intel/iommu.h  |  40 +++++-
> >   drivers/iommu/intel/prq.c    | 290 ++++++++++++++++++++++++++++++++++++++++
> >   drivers/iommu/intel/svm.c    | 308 -------------------------------------------
> >   5 files changed, 331 insertions(+), 327 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> > index c8beb0281559..d3bb0798092d 100644
> > --- a/drivers/iommu/intel/Makefile
> > +++ b/drivers/iommu/intel/Makefile
> > @@ -1,6 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   obj-$(CONFIG_DMAR_TABLE) += dmar.o
> > -obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
> > +obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
> >   obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
> >   obj-$(CONFIG_DMAR_PERF) += perf.o
> >   obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
> 
> Thanks for the patch! Now that IOPF is separate from SVA, the Kconfig
> needs to be updated accordingly.
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index f52fb39c968e..2888671c9278 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -15,6 +15,7 @@ config INTEL_IOMMU
>          select DMA_OPS
>          select IOMMU_API
>          select IOMMU_IOVA
> +       select IOMMU_IOPF
This will force IOMMU_IOPF when INTEL_IOMMU is selected. You do this in
order to use IOPF if available, but it wont conflict with Intel IOMMU's
that do not support IOPF. right?

>          select IOMMUFD_DRIVER if IOMMUFD
>          select NEED_DMA_MAP_STATE
>          select DMAR_TABLE
> @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
>          depends on X86_64
>          select MMU_NOTIFIER
>          select IOMMU_SVA
> -       select IOMMU_IOPF
I already had this one
>          help
>            Shared Virtual Memory (SVM) provides a facility for devices
>            to access DMA resources through process address space by
> 
> Thanks,
> baolu

Thx for the review

best
-- 

Joel Granados
