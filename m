Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F1CCB29
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445169; cv=none; b=QOx3qbZp6Kj27XsH89lOkObVeDU93Jv5P9WuXov/mh/Z/ahOhjaGCAk0U7QMJ5sxb/PoO5qdCv4qItyygUGuxXCR30dIS4ziurHGDX6ZY8F5tvkRF2wTbsSPJEoKwAojaOZeuCogk16PfMLQg0e6w8Tr0IDi37omFwH1N3BJPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445169; c=relaxed/simple;
	bh=yENLbIwzaSXudtAKO8rxWrLEYSmWs26lPwRqbk3Tc1I=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=nDzOllzQ0C2OTSUZgS8Kg0wfSk+dDgCDwjfABAgsy40N+hdvmgdZhoXQWXJQd0hl7fuaT4gOT9Mg/6zeYShpD7fJVwiK9fXuqSlYP0f+Bftbbn/+N3WXu3ALXroa9jljJCsMoBKjHDDhTCVkWTEbVOSoYUTbNMMWn6noImDxSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MQXJw79Z; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQXJw79Z"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240904101924euoutp020869412c93ce281a69bab8d4fbd9f392~yAzxBlIWa2791427914euoutp02R
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:19:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240904101924euoutp020869412c93ce281a69bab8d4fbd9f392~yAzxBlIWa2791427914euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725445164;
	bh=2E3980v8yN3y/wrC2ukf22OKX1OaZcxCNFuPShUMfHE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MQXJw79ZtCwKfFbtRqnFD8krq+k7EXZb2jdOdjL0RKMFVOlMvaIp33xuauyIhU/Px
	 iRxb+J9he2RedwF+93E0DQy3CSGgyn+5HsKM3o5dPzXUUatvC7S8TJEdczZ00sVRrJ
	 4c3hBLxZmSTAb/0nAmiZQoMwUwDHG6sfOn6/Dzzo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240904101924eucas1p1f5f430b337daf63daba12eafce9a4fcd~yAzwm6DwB0099000990eucas1p1h;
	Wed,  4 Sep 2024 10:19:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.4B.09624.B2438D66; Wed,  4
	Sep 2024 11:19:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904101923eucas1p138ef42fb306d27c0f693e71708f7500d~yAzwEdEVh0099000990eucas1p1g;
	Wed,  4 Sep 2024 10:19:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240904101923eusmtrp197ad8fd8ddd912eebdb109fa1e37f5a0~yAzwDmggy2782327823eusmtrp1W;
	Wed,  4 Sep 2024 10:19:23 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-93-66d8342b5843
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.CE.19096.B2438D66; Wed,  4
	Sep 2024 11:19:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240904101923eusmtip1953528a14a8142e81bc27de1020ff889~yAzvzp2Xk1230312303eusmtip1q;
	Wed,  4 Sep 2024 10:19:23 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 11:19:19 +0100
Date: Wed, 4 Sep 2024 12:19:16 +0200
From: Joel Granados <j.granados@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Minwoo Im
	<minwoo.im@samsung.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 6/6] iommu/vt-d: do not require a PASID in
 page requests
Message-ID: <20240904101916.ia5n7s4tbczkqnws@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826-iopf-for-all-v1-6-59174e6a7528@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7raJjfSDO5/sLbYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	roymdU0sBbO4K1q+HGJuYHzB0cXIySEhYCLR/+MnWxcjF4eQwApGiUsLFrCDJIQEvjBKzLgX
	DpH4zCgxaf8NRpiOt1Nms0EULWeU2NilDVf08eopqFFbGCVWf9/JClLFIqAisbR/JZjNJqAj
	cf7NHWYQWwQo/vTfXhaQBmaBBmaJrzfPgo0VFoiS+DBjA9gdvAIOErPXtzFC2IISJ2c+YQGx
	mYEGLdj9CaieA8iWllj+D+wfTgEnic6P3VCXKkscXHaIHcKulTi15RYTyC4JgdmcEvOvToEq
	cpHYe/4+VJGwxKvjW6BsGYnTk3tYIBomM0rs//eBHcJZzSixrPErE0SVtUTLlSdQHY4SM/pB
	VnAA2XwSN94KQhzKJzFp23RmiDCvREebEES1msTqe29YJjAqz0Ly2iwkr81CeG0BI/MqRvHU
	0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwLR1+t/xTzsY5776qHeIkYmD8RCjBAezkgjva5Eb
	aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1ME0UOpm2W
	/fVy4aKWm/N7poab7byfvmzx7SV1qwwZngj0FDE61bVuNFxj8yDy9MdpTYcmsk5mU157deei
	1fxCcdqOHPNt3O0Yd+2ZOWNtFR/7x+4G99NGjOFFXu9kgzIbijf2G7w5eyE05u+66Dc8y92e
	ibdn9Px84P5hd4Ld0+elF1O1VibKMK9e8PxPU7HDrX0TQ1sF05k1rHyvWh5esmvi3rcs5lYK
	1gubnP0Vfh+dFMAi1aggn3+4bcOXm7M0237ND2l7+eSP04MAb8Xce6u21bDq6QUkyDq3Tzrz
	qFf5lCh37IsTK7ZGXGf7Xdr+crrdvZJ9L9IKH/57zOcref3i44jns6/2GzB9fOibocRSnJFo
	qMVcVJwIADPe+hDKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7raJjfSDN7sk7TYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYymdU0sBbO4K1q+HGJuYHzB
	0cXIySEhYCLxdspsti5GLg4hgaWMEifXdDJBJGQkNn65ygphC0v8udYFVfSRUeLg1hMsEM4W
	RokF97vYQapYBFQklvavBOtgE9CROP/mDjOILQIUf/pvL1gDs0ADs8TXm2fZQBLCAlESH2Zs
	AGvmFXCQmL2+jRFi6llGidvP77JBJAQlTs58wgJiMwNNXbD7E1CcA8iWllj+D+wHTgEnic6P
	3YwQpypLHFx2iB3CrpX4/PcZ4wRG4VlIJs1CMmkWwqQFjMyrGEVSS4tz03OLjfSKE3OLS/PS
	9ZLzczcxAuN327GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe1yI30oR4UxIrq1KL8uOLSnNSiw8x
	mgLDYiKzlGhyPjCB5JXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnV
	wMQ8k19jwp0FF7fekPltlcoRdjHD/LTZuf/T/mz4c/7wpIN/Jl19+ufACTY2uYsb5u2verD/
	0pvNvzeeNL/6Q/WHRj332teHa3k51zNOEra/dcarsOWbaNfNHdP+rebUOc0SZezy8tbfIrEM
	ycCZWw0dvKdt2eAY5cwYa/cnXrelZs32kqst5rl3KjVXmhWbGTAIvE51mDldXHDfS7vznol1
	/Bp+Kpcq5znN5rF44H4ttm/P5bL6fOV32cV8Ue/5Bd14DVzO3yneFfpt3vLeJ7N27N/oNMf1
	cPPtexqrTp3kmmZ3bwuDisqty7sYM/fPePdr9VMZnbMpFZeizf5K7/fUE2K8t91FztnVfNmc
	zNXtSizFGYmGWsxFxYkAEy99PWgDAAA=
X-CMS-MailID: 20240904101923eucas1p138ef42fb306d27c0f693e71708f7500d
X-Msg-Generator: CA
X-RootMTR: 20240826114110eucas1p2de6af1717324c944cd3036826492df44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826114110eucas1p2de6af1717324c944cd3036826492df44
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826114110eucas1p2de6af1717324c944cd3036826492df44@eucas1p2.samsung.com>
	<20240826-iopf-for-all-v1-6-59174e6a7528@samsung.com>

On Mon, Aug 26, 2024 at 01:40:32PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> PRQ events can now be handled without a PASID being present. Remove the
> restriction.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  drivers/iommu/intel/prq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index 2814373e95d8..cc36198ebf91 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -101,18 +101,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		req = &iommu->prq[head / sizeof(*req)];
>  		address = (u64)req->addr << VTD_PAGE_SHIFT;
>  
> -		if (unlikely(!req->pasid_present)) {
> -			pr_err("IOMMU: %s: Page request without PASID\n",
> -			       iommu->name);
> -bad_req:
> -			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> -			goto prq_advance;
> -		}
> -
>  		if (unlikely(!is_canonical_address(address))) {
>  			pr_err("IOMMU: %s: Address is not canonical\n",
>  			       iommu->name);
> -			goto bad_req;
> +bad_req:
> +			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> +			goto prq_advance;
>  		}
>  
>  		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
> 
> -- 
> 2.45.2
> 

I'll squash this commit with the one that introduces the prq.c file.

Best

-- 

Joel Granados
