Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB91D0152
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449980; cv=none; b=LoOQqcs/M/OxGIKhlKYUp2rSLBEyHr2rwSCH805fapSLZO1pMTyopZ80pQcv2typ4sllkvHBrxX9+CPmcEWlIwWv/OvoKpnaORj4spZ/LGu3ofIf5LevoPNY9YPw57f6ezUsQ8U1xCc4SZ/tBZbvqN377eZtC4Itwi2GTJq4qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449980; c=relaxed/simple;
	bh=BQJeSS6zRJ+NgR1rjvQRaeNKt6ErNK9rbLSyjBuiAyg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=kQ0bgydS8UUuOdbQjP6kUPiwT0uL74P5BaDPSzhuYLOnQXSo4qYcRdizKqIB1a9eCaBpabzRWeZFt7mPx0xHl/hy4r8Tp04ajFWfhP70+5clV7u4E275RlpBjTB0S+ZXGEAtAknWBc8FFhpUuxAgMQXL6asDiEEPdDpgYtq1sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BihiCRYh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BihiCRYh"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240904113936euoutp02a8cd6af126a27b8b69b7a8f7d44cd1ff~yB5yD0ao72112521125euoutp02V
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 11:39:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240904113936euoutp02a8cd6af126a27b8b69b7a8f7d44cd1ff~yB5yD0ao72112521125euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725449976;
	bh=EGFj9Lt3U6NEqj732WrUihZyBNzE5JpUCAm9adYfXVA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BihiCRYhZuWs7WsiH0EVUsKUe83dajXPKd7AlreVFfQN1ROVL1lyMBzCS1ovX5XHv
	 qlRQl2lf1n2N1Oo1PTziPnsqg1rh9bJcE1DJhdx2qwL4r4qDPcwTnyho6bNgj9VuYc
	 VrYF3I/6Wu8SZLDm10xI6Yjiz9fo5erDcx2hvHAA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240904113935eucas1p19aaff846f2dde90710a991ae1ad85b5d~yB5xwse_Q2497324973eucas1p1W;
	Wed,  4 Sep 2024 11:39:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.06.09620.7F648D66; Wed,  4
	Sep 2024 12:39:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904113935eucas1p15916049ce037ad579a1b095e35cbc59c~yB5xGzl211822318223eucas1p1-;
	Wed,  4 Sep 2024 11:39:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240904113935eusmtrp12bce0583f0a63605cc8926dacbf8a6ae~yB5xF6dl11271512715eusmtrp1S;
	Wed,  4 Sep 2024 11:39:35 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-fb-66d846f75153
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.D8.14621.6F648D66; Wed,  4
	Sep 2024 12:39:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240904113934eusmtip23bbd296a6fd04b69addea4babd0ad253~yB5w6o_521668916689eusmtip2Y;
	Wed,  4 Sep 2024 11:39:34 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 12:39:33 +0100
Date: Wed, 4 Sep 2024 13:39:30 +0200
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
Message-ID: <20240904113930.zzlrcyui6mwxjzb5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904101916.ia5n7s4tbczkqnws@joelS2.panther.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7rf3W6kGew8q2qxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBnn/m5kK9jIV3GmYTtLA+NE7i5GTg4JAROJOaf+M3UxcnEICaxglOhb+4UVJCEk8IVR4scL
	L4jEZ0aJ2YsmMcF0vPmzmgWiaDmjxIU3zhA2UNG+i3IQDVsYJR7dWMoOkmARUJFYOOcgG4jN
	JqAjcf7NHWYQWwQo/vTfXhaQBmaBBmaJrzfPghUJC0RJfJixAayZV8BB4vTrKUwQtqDEyZlP
	wDYzAw1asPsTUD0HkC0tsfwfB0iYU8BRYsX3u1CHKkscXHaIHcKulTi15RZUfDanxI9OHwjb
	ReL41DYWCFtY4tXxLVD1MhKnJ/eA3SYhMJlRYv+/D+wQzmpGiWWNX6EmWUu0XHkC1eEoMaMf
	ZAMHkM0nceOtIMSdfBKTtk1nhgjzSnS0CUFUq0msvveGZQKj8iwkn81C8tkshM8WMDKvYhRP
	LS3OTU8tNs5LLdcrTswtLs1L10vOz93ECExZp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nwvha5
	kSbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXApMXvekAl
	JmVFmoy6xtUF2Se3tM9dLrJi/b95IqsvtJ4PXOV6plTxxi7/iptmkuumTa4wdzT8UzXR7+mx
	C/t2cT37cWwB78XCd/2l/WvD1tx/1LHSJqRN282Ml0F8VblL6LTSV6tf8669093w79TWRVPT
	TzVt2LnYd+++PW2O76Umb9hef2mr4P0z88pvB09w/Lp/p5OE+YtjV79u5/ZPaMsX/Rr8/WRz
	t8/EK2u+rF64T3iCpd432zVNT3wKa+dzHYhQ1b0bwv6nSVfcYbOloOtWs/QLNVv2xwcanWl4
	+kJv8UuZK7v+NKrvi7bOnxZzXPBEYC+XkObZcwK5UrskFrz6d1HsnEDvu4gNq69e+rhXiaU4
	I9FQi7moOBEASnLmlsgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rf3G6kGZzeZWGxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnn/m5kK9jIV3GmYTtLA+NE
	7i5GTg4JAROJN39Ws3QxcnEICSxllNhyppsFIiEjsfHLVVYIW1jiz7UuNhBbSOAjo8TStmyI
	hi2MEm29D5lBEiwCKhIL5xwEK2IT0JE4/+YOWFwEKP70316wDcwCDcwSX2+eBSsSFoiS+DBj
	AzuIzSvgIHH69RQmiKktTBJXPrSwQiQEJU7OfAJ2EjPQ1AW7PwE1cwDZ0hLL/3GAhDkFHCVW
	fL/LBHGpssTBZYfYIexaic9/nzFOYBSehWTSLCSTZiFMWsDIvIpRJLW0ODc9t9hQrzgxt7g0
	L10vOT93EyMwercd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4X0tciNNiDclsbIqtSg/vqg0J7X4
	EKMpMCwmMkuJJucD00deSbyhmYGpoYmZpYGppZmxkjiv2+XzaUIC6YklqdmpqQWpRTB9TByc
	Ug1MzMYi652sFW6oBz7S17nJXMeXs35T9Ab/aIbCH7En37JwKBW5514wT1I0OyI59eHWSpfF
	96yOsbwSr5RbuuG19Z8vB87Pad5w1Cxo4Z1rMW4TRAXY73YweG6o76/4r8Kivz3UbbrvzcS2
	o3uudM3z13itn7o0STiXV9i48LbctcCjb5LSPjvVts78qWT9YeF0PeWKWctenjB/9C/UIu3B
	8YUTGIPuFJX0Jn7xc5n5ukZ7+cxy62RL671PxTKN7x5a5WUuI/3VpaTvSMJ7q9KMHzPMSzrO
	9mfbP2Y4/0u4s2Cl4ivXoviZu73Oin3slXV5ZKtf/Esto+/GPLOEc0fKKo7uerk3IaoocDN3
	wxElluKMREMt5qLiRACwLRodZwMAAA==
X-CMS-MailID: 20240904113935eucas1p15916049ce037ad579a1b095e35cbc59c
X-Msg-Generator: CA
X-RootMTR: 20240826114110eucas1p2de6af1717324c944cd3036826492df44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826114110eucas1p2de6af1717324c944cd3036826492df44
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826114110eucas1p2de6af1717324c944cd3036826492df44@eucas1p2.samsung.com>
	<20240826-iopf-for-all-v1-6-59174e6a7528@samsung.com>
	<20240904101916.ia5n7s4tbczkqnws@joelS2.panther.com>

On Wed, Sep 04, 2024 at 12:19:16PM +0200, Joel Granados wrote:
> On Mon, Aug 26, 2024 at 01:40:32PM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > PRQ events can now be handled without a PASID being present. Remove the
> > restriction.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  drivers/iommu/intel/prq.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> > index 2814373e95d8..cc36198ebf91 100644
> > --- a/drivers/iommu/intel/prq.c
> > +++ b/drivers/iommu/intel/prq.c
> > @@ -101,18 +101,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
> >  		req = &iommu->prq[head / sizeof(*req)];
> >  		address = (u64)req->addr << VTD_PAGE_SHIFT;
> >  
> > -		if (unlikely(!req->pasid_present)) {
> > -			pr_err("IOMMU: %s: Page request without PASID\n",
> > -			       iommu->name);
> > -bad_req:
> > -			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> > -			goto prq_advance;
> > -		}
> > -
> >  		if (unlikely(!is_canonical_address(address))) {
> >  			pr_err("IOMMU: %s: Address is not canonical\n",
> >  			       iommu->name);
> > -			goto bad_req;
> > +bad_req:
> > +			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> > +			goto prq_advance;
> >  		}
> >  
> >  		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
> > 
> > -- 
> > 2.45.2
> > 
> 
> I'll squash this commit with the one that introduces the prq.c file.
On second thought. I'll leave it as a separate commit. The first one
will be the "copy all the code to a new file" commit and the second one
will be "remove the pasid check" I'll change the commit message a bit so
it is clear why they are not together.

Best

-- 

Joel Granados
