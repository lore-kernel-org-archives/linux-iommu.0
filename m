Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC031CCECB
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443086; cv=none; b=fAZnBGKcmHBQOvzdqQlqwv6wuVXgPVnYRztrIh/IVjSk+TPYaDh+mnBAOwLrgu8iAttINAR/ZhVuQn2SjpEyn+gbeovQkmVB85p6t4XzihhS13albYRfqyHwqdef48RLagIOhxCKieCuCAu4Z7uwZiDPdgwL4uml3bmGgdN/XPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443086; c=relaxed/simple;
	bh=pEjJo9w+OQGCfFs5ci6p4FBPg9h0vwHF3mqobw06WSU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=I/FRmutiU51NWC4FfUORvpQTBOM3bLHvCpjIuUIhrg7oBvjQpJk/o+tcpLhVVoYbMxBh18lnxG3dOTYDs5qnOuyBThyE5wMbxeqVKsHBD7aWubp/mwJ90XWRX0vPUdxC1yXv3ogTLif9CLutdi2O2CguDu5YQ6HXsezE4F0Eeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J8I8UmSx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J8I8UmSx"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240904094441euoutp01688bd179bee1f5ee037761944ef8aa6e~yAVc9q21y2087020870euoutp016
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240904094441euoutp01688bd179bee1f5ee037761944ef8aa6e~yAVc9q21y2087020870euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725443081;
	bh=cis/h+2GNZMbK0VnPVfWVXy9Bsg9Qt9GelL3ICKUMy8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J8I8UmSx4SqdY5Vvnf45uqroRKtcQfH96ZlhL3mdd0791RudGY2B0HeGaHyrqxYQV
	 d5kP+0jExYJ+F1xfyCtw1ewpU8J22vKnq4HB8bqQRrbhUtCtpgcjv/4pYiFQ9D4THI
	 PHaXTKqIXkiDfQxxAXwVKhLnalJ1w1aelgCOEhdw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240904094441eucas1p22ece35d7e84bfdf861cda3c6974249b9~yAVcqasTV1101111011eucas1p2f;
	Wed,  4 Sep 2024 09:44:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.A2.09624.80C28D66; Wed,  4
	Sep 2024 10:44:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904094440eucas1p1dc4f682d5f39faa90aec5b0cac15761f~yAVcQVghL3131531315eucas1p1E;
	Wed,  4 Sep 2024 09:44:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240904094440eusmtrp25de335df8a0a9215d032ab1037e2595e~yAVcPJdUD2986129861eusmtrp2t;
	Wed,  4 Sep 2024 09:44:40 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-f5-66d82c083beb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.57.14621.80C28D66; Wed,  4
	Sep 2024 10:44:40 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240904094440eusmtip2eca1b404d6a3f6d0e1ea474d9e81b910~yAVcC3QxV1538915389eusmtip2y;
	Wed,  4 Sep 2024 09:44:40 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 10:44:33 +0100
Date: Wed, 4 Sep 2024 11:44:28 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 2/6] iommu: Make IOMMU_IOPF selectable in
 Kconfig
Message-ID: <20240904094428.vmzu43ituehn4qo4@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826140558.GJ3468552@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7qcOjfSDPofM1psnriVzWLiysnM
	Fr++WFjsP/iN1WLmjBOMFp2zN7BbLH27ld3i8q45bBYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bF6h5bF4z0smj3M7zrN7bFrVyeYx72Sgx4vNMxk9Pm+S89j6+TZLAFcUl01Kak5mWWqRvl0C
	V8bKJy3MBft5Kx51zmZrYDzK1cXIySEhYCLR/+0PE4gtJLCCUeL/hJouRi4g+wujxMtDDxkh
	nM+MEsvfnmOD6Vj2fAo7RGI5o8TXmy+Z4KrOfJ8HldnCKHHs6QRmkBYWARWJXwcbGUFsNgEd
	ifNv7oDFRQSUJPbtmgjWwCzQwiyx+20z0A4ODmGBYImbe3RBangFHCSurHrMBmELSpyc+YQF
	xGYGmrNg9yewcmYBaYnl/zhAwpwCBhIXLmxghrhUWeLgskPsEHatxKktt8AOlRCYzSmxfvZO
	FoiEi8SO46ehioQlXh3fAmXLSPzfOR+qYTKjxP5/H9ghnNWMEssavzJBVFlLtFx5AtXhKPFg
	5kRGkIskBPgkbrwVhDiUT2LStunMEGFeiY42IYhqNYnV996wTGBUnoXktVlIXpuF8NoCRuZV
	jOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgWnr9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe
	1yI30oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGanphakFsFkmTg4pRqYel79
	nasRPvW9RYTA/8j5UjNfFF2TSJ92MrntytT6nLdzeSOefVUx6+n2vSrxdLqXbdiXe3+L6u5x
	7/o+jXnplpkFt94IJFvvUNn47sqs+PPlvWf8i1+2CQiqfZ3zx/ZT8axGRY+lHqxm3h2r6xlC
	K5N+RTBN8rv7Iq72WchD5giefNeNdo0BPh9jdnvLmQg1REueXrWiJmNzZVXbYYmEFyx3l5/o
	f3E+SqDyqyiHr712WOKlS/YXl3puPSgoPO/knV+frAsZ4gXfrxA9tEBh+mFNtwOOIg/VV9pc
	WXrzLpv44nK+m9/PXleeoKmSsLh55rnCr5Gfk3d0THm+6pSj4WvZt7Y5PwSEdmcpZPv6KrEU
	ZyQaajEXFScCAP9lgCjKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7ocOjfSDI5vULHYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyVT1qYC/bzVjzqnM3WwHiU
	q4uRk0NCwERi2fMp7F2MXBxCAksZJQ7f/s8EkZCR2PjlKiuELSzx51oXG0TRR0aJyVOeQnVs
	YZQ40fSTGaSKRUBF4tfBRkYQm01AR+L8mztgcREBJYl9uyaCNTALtDBL7H7bDDSKg0NYIFji
	5h5dkBpeAQeJK6seQ234zCixvWklG0RCUOLkzCcsIDYz0NAFuz+B9TILSEss/8cBEuYUMJC4
	cGEDM8SlyhIHlx1ih7BrJT7/fcY4gVF4FpJJs5BMmoUwaQEj8ypGkdTS4tz03GJDveLE3OLS
	vHS95PzcTYzA6N127OfmHYzzXn3UO8TIxMF4iFGCg1lJhPe1yI00Id6UxMqq1KL8+KLSnNTi
	Q4ymwKCYyCwlmpwPTB95JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0MXFw
	SjUwFVV5SjZLNewq/65QrPL7nEhpY9FbhvoEpjgXvzsN99/9nMc9x6Cr1jNylgtz5MdNC6cd
	mlf+1/p2U4HTn8DLv9k0L/70/pXLYmDWl3jyk1JOFcf5/UoXQn4/vT91/8SE0mmWflfEVf9L
	2F/hDZopwqh50+5V7dMdP1ZuWhh0Z4n4Ew7+9gnPbPhychc9DVkZrvr+xPrllkFeKoGxOWrP
	rlzycblqN933/KWk8MZSpagPW9e+7Jj/0OZdxAQFva1K0iolGr9vlTjt5Dh508x6QaCuUcD1
	wLlyeww0L8d2xTVsOihWzL7y/e/Wnil2f+uLP5+Rjtp9S00jID/myr/oBBPnnclBF8sij19P
	YX6mxFKckWioxVxUnAgAgRKfpmcDAAA=
X-CMS-MailID: 20240904094440eucas1p1dc4f682d5f39faa90aec5b0cac15761f
X-Msg-Generator: CA
X-RootMTR: 20240826140602eucas1p2024399b3fa6c41a7939bd4ee7cc7e888
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826140602eucas1p2024399b3fa6c41a7939bd4ee7cc7e888
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>
	<CGME20240826140602eucas1p2024399b3fa6c41a7939bd4ee7cc7e888@eucas1p2.samsung.com>
	<20240826140558.GJ3468552@ziepe.ca>

On Mon, Aug 26, 2024 at 11:05:58AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2024 at 01:40:28PM +0200, Klaus Jensen wrote:
> > From: Joel Granados <j.granados@samsung.com>
> > 
> > IOMMU_IOPF is no longer selectable through INTEL_IOMMU_SVM effectively
> > severing their relation and allowing them to be used independently.
> > 
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  drivers/iommu/Kconfig       | 2 +-
> >  drivers/iommu/intel/Kconfig | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index a82f10054aec..d3ee8a0ad4a6 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -164,7 +164,7 @@ config IOMMU_SVA
> >  	bool
> >  
> >  config IOMMU_IOPF
> > -	bool
> > +	bool "Enable IO page fault in IOMMU"
> 
> 
> Currently IOMMU_IOPF indicates that the driver wants to consume the
> library functions around IOPF, it is not a user selectable because any
> driver that links to those functions should have them working. If you
> want to make the core driver use them then the select should be moved
> from the SVM sub config to the core driver config.
This is in line with the feedback that I got from Lu. I'll put
IOMMU_IOPF under INTEL_IOMMU and drop this commit from the set.

Thx.

> 
> If you want to change IOMMU_IOPF to a user configurable then it should
> have a full help text and all the kconfig places touching it should be
> turned into
> 
>   depends IOMMU_IOPF
> 
> Ie you can't enable any drivers SVA kconfig without also picking
> IOMMU_IOPF.
> 
> This is doing neither fully.. Pick one :)
> 
> Jason

-- 

Joel Granados
