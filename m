Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DCDC04AAC
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 05:35:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434B720881
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D5CUV9HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434B720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB437F18;
	Thu, 23 May 2019 05:35:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5FC36F15
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 05:35:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
	[210.118.77.12])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A294C5D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 05:35:17 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190523053515euoutp02296cdf3ee77ee21181c8af27db0b50bb~hORal4VgI1560915609euoutp02G
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 05:35:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
	20190523053515euoutp02296cdf3ee77ee21181c8af27db0b50bb~hORal4VgI1560915609euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1558589715;
	bh=gPaeOPeAy+SCHwNWglSiXOmUaID43N80JI9hQwAPuEs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=D5CUV9HIuwWtJyRwwGb0iNTFNqY0VQSkq6+pquk6qWq1qwafXeHPdM4O1NDEiEiqn
	jAT3DFwIdrVkXq3biNuLjTI3Ey0/qcPBoGnpvOoHiST9sMlXFnQuNEqdTyxZm3ZoaR
	40ymijvUmEXMK5uubKT08MfRLuReJEFM14lG3Duw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20190523053514eucas1p1f1d23fd3ca299a4acedd08d175974f8d~hORZw5IY_2901129011eucas1p17;
	Thu, 23 May 2019 05:35:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.46.04298.21136EC5;
	Thu, 23 May 2019 06:35:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20190523053513eucas1p1078d4f2cb308d9e79e4edef9adaf49dc~hORY7W82t2901229012eucas1p1n;
	Thu, 23 May 2019 05:35:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20190523053513eusmtrp1f0cd137533c806dcf0f77924f6a512c5~hORYtU5GR3054330543eusmtrp1J;
	Thu, 23 May 2019 05:35:13 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-12-5ce631125843
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.EB.04146.11136EC5;
	Thu, 23 May 2019 06:35:13 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20190523053513eusmtip1d5a9726961a4037d0915ebfa6c2a104b~hORYXSmQc1674916749eusmtip1E;
	Thu, 23 May 2019 05:35:13 +0000 (GMT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
Date: Thu, 23 May 2019 07:35:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3e2szmaHafmk5XCzKgkbVQ0W0hZ4b50JQxroMsdneim7HjJ
	+tDIEbq0vIDptLKk5jVJdIiC4sSGWuqmgRdCHZuFYGhLhlqZ2+nit99z/T//l5eD8ZtZgZwU
	VSapVsnSBDiXaXy3OnyYL5yXHhlv8BHVN/YzREsjfQxRTY9Y9LrWgUS6tXpMNNZZjYt6l+ys
	02xJ07MmJCmbMCBJ16QGl7z92sGQLDummBJna9Bl/Ab3lJxMS8km1RFRCVyF5dMsI6Oddzvv
	aTVLg1xcHfLiAHEMSjcGMTfziToEHz8c0CHuJn9HULTqRHTgRFBS/BjXIY5nYmYuhM4bECzX
	OHA6WESg7TF5VvkS0ZBX+MLDfkQMrOSPst1NGNGDwGBzIXcBJ4SgW9ThbuYRUWD4MepRYBKh
	4LIo3OhPSOGl80+HDwxU2plu9iLE0GjTerZgRDDktVdhNAfAlP05wy0FRDcbTOMrOG3zHMxM
	V2A0+8KCuY1N8x4YKitk0gN5COaGm9l0UIhg7H4ForvE0Ge2sNwXYcRBaOmMoNNnYMaiYdCv
	4g0Tiz70Ed5QanyC0Wke5D/g0937QW9+80+2d9SKFSOBfos1/RY7+i129P91axCzAQWQWZQy
	maSEKjInnJIpqSxVcnhiurIVbX6ioV/mbx1oxXrLhAgOEmznKU44pHyWLJvKVZoQcDCBH29o
	0Cbl8+Sy3DukOj1enZVGUia0m8MUBPDubpu9ySeSZZlkKklmkOq/VQbHK1CDuj5/Ka9LslkL
	Knu714LXMyOntfsiHVwsxlC1Qxwux4yJu3Icr1J/GtNdZQnr2kdLw9m6uHLJw/cll5S2MEFo
	0WR87YWj56OvVq0dTx056Xd2p128MT4Zl4Rfj5JEhsTOt7UUuPbazP3XFua8g63yewPTyouW
	Sps6qMX/ynxsmIBJKWTCQ5iakv0GsMTKrUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7qChs9iDO72SlusXH2UyeLD+cNM
	Fgv2W1ssW/yU0aLr10pmi8u75rBZHPzwhNWB3WPNvDWMHpNvLGf02H2zgc1j47sdTB4fn95i
	8fi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
	LkEv4+LdB0wFW3krmufOYW1g/M7VxcjBISFgInH/oXIXIxeHkMBSRokVK94zdjFyAsVlJE5O
	a2CFsIUl/lzrYoMoes0oMWfGUjaQhLCAk0Rzz0JmEFtEwF3ia8cFdpAiZoGDjBJ7tvWyQHS0
	MUvs2HqUBaSKTcBQouttF1g3r4CdxPI/F9hAzmARUJX4fjEDJCwqECNxYuoWdogSQYmTM5+A
	tXIKWEusftQCdh2zgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiy
	ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzD6th37uXkH46WNwYcYBTgYlXh4M8yfxgixJpYV
	V+YeYpTgYFYS4T196lGMEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucDE0NeSbyhqaG5haWh
	ubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG6G3b5VS9K9wfcu3atXPhrctbnMQS
	/vgdvtzJVGBUoOUZ5/z80y2u4K+r5352Pvv4lYOcSUbrzZ2t4Tov1AOLRNS36+2KX/VWxY11
	cUjcA25HX0PFNPNvQQx2TL9Y5byV86svzzga9qJIZ4OOUoKUSeDuJXYlC/1rNfboT5l9L8Bq
	pcqkx/eVWIozEg21mIuKEwG5w3z51AIAAA==
X-CMS-MailID: 20190523053513eucas1p1078d4f2cb308d9e79e4edef9adaf49dc
X-Msg-Generator: CA
X-RootMTR: 20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b
References: <20190522072018.10660-1-horia.geanta@nxp.com>
	<20190522123243.GA26390@lst.de>
	<6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
	<20190522130921.GA26874@lst.de>
	<fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
	<20190522133400.GA27229@lst.de>
	<CGME20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b@epcas2p3.samsung.com>
	<ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
Cc: linux-imx@nxp.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgUm9iaW4sCgpPbiAyMDE5LTA1LTIyIDE1OjU1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjIvMDUvMjAxOSAxNDozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIFdlZCwgTWF5
IDIyLCAyMDE5IGF0IDAyOjI1OjM4UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IFN1
cmUsIGJ1dCB0aGF0IHNob3VsZCBiZSBpcnJlbGV2YW50IHNpbmNlIHRoZSBlZmZlY3RpdmUgcHJv
YmxlbSBoZXJlIAo+Pj4gaXMgaW4KPj4+IHRoZSBzeW5jXypfZm9yX2NwdSBkaXJlY3Rpb24sIGFu
ZCBpdCdzIHRoZSB1bm1hcCB3aGljaCBub2JibGVzIHRoZSAKPj4+IGJ1ZmZlci4KPj4+IElmIHRo
ZSBkcml2ZXIgZG9lcyB0aGlzOgo+Pj4KPj4+IMKgwqDCoMKgZG1hX21hcF9zaW5nbGUod2hvbGUg
YnVmZmVyKTsKPj4+IMKgwqDCoMKgPGRldmljZSB3cml0ZXMgdG8gcGFydCBvZiBidWZmZXI+Cj4+
PiDCoMKgwqDCoGRtYV91bm1hcF9zaW5nbGUod2hvbGUgYnVmZmVyKTsKPj4+IMKgwqDCoMKgPGNv
bnRlbnRzIG9mIHJlc3Qgb2YgYnVmZmVyIG5vdyB1bmRlZmluZWQ+Cj4+Pgo+Pj4gdGhlbiBpdCBj
b3VsZCBpbnN0ZWFkIGRvIHRoaXMgYW5kIGJlIGhhcHB5Ogo+Pj4KPj4+IMKgwqDCoMKgZG1hX21h
cF9zaW5nbGUod2hvbGUgYnVmZmVyLCBTS0lQX0NQVV9TWU5DKTsKPj4+IMKgwqDCoMKgPGRldmlj
ZSB3cml0ZXMgdG8gcGFydCBvZiBidWZmZXI+Cj4+PiDCoMKgwqDCoGRtYV9zeW5jX3NpbmdsZV9m
b3JfY3B1KHVwZGF0ZWQgcGFydCBvZiBidWZmZXIpOwo+Pj4gwqDCoMKgwqBkbWFfdW5tYXBfc2lu
Z2xlKHdob2xlIGJ1ZmZlciwgU0tJUF9DUFVfU1lOQyk7Cj4+PiDCoMKgwqDCoDxjb250ZW50cyBv
ZiByZXN0IG9mIGJ1ZmZlciBzdGlsbCB2YWxpZD4KPj4KPj4gQXNzdW1pbmcgdGhlIGRyaXZlciBr
bm93cyBob3cgbXVjaCB3YXMgYWN0dWFsbHkgRE1BZWQgdGhpcyB3b3VsZAo+PiBzb2x2ZSB0aGUg
aXNzdWUuwqAgSG9yaWEsIGRvZXMgdGhpcyB3b3JrIGZvciB5b3U/Cj4KPiBPaGhoLCBhbmQgbm93
IEkndmUganVzdCB0d2lnZ2VkIHdoYXQgeW91IHdlcmUgc3VnZ2VzdGluZyAtIHlvdXIgCj4gRE1B
X0FUVFJfUEFSVElBTCBmbGFnIHdvdWxkIG1lYW4gInRyZWF0IHRoaXMgYXMgYSByZWFkLW1vZGlm
eS13cml0ZSBvZiAKPiB0aGUgYnVmZmVyIGJlY2F1c2Ugd2UgKmRvbid0KiBrbm93IGV4YWN0bHkg
d2hpY2ggcGFydHMgdGhlIGRldmljZSBtYXkgCj4gd3JpdGUgdG8iLiBTbyBpbmRlZWQgaWYgd2Ug
ZGlkIGdvIGRvd24gdGhhdCByb3V0ZSB3ZSB3b3VsZG4ndCBuZWVkIGFueSAKPiBvZiB0aGUgc3lu
YyBzdHVmZiBJIHdhcyB3b3JyeWluZyBhYm91dCAoYnV0IEkgbWlnaHQgc3VnZ2VzdCBuYW1pbmcg
aXQgCj4gRE1BX0FUVFJfVVBEQVRFIGluc3RlYWQpLiBBcG9sb2dpZXMgZm9yIGJlaW5nIHNsb3cg
OikKCkRvbid0IHdlIGhhdmUgRE1BX0JJRElSRUNUSU9OQUwgZm9yIHN1Y2ggY2FzZT8gTWF5YmUg
d2Ugc2hvdWxkIHVwZGF0ZSAKZG9jdW1lbnRhdGlvbiBhIGJpdCB0byBwb2ludCB0aGF0IERNQV9G
Uk9NX0RFVklDRSBleHBlY3RzIHRoZSB3aG9sZSAKYnVmZmVyIHRvIGJlIGZpbGxlZCBieSB0aGUg
ZGV2aWNlPwoKQmVzdCByZWdhcmRzCi0tIApNYXJlayBTenlwcm93c2tpLCBQaEQKU2Ftc3VuZyBS
JkQgSW5zdGl0dXRlIFBvbGFuZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
