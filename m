Return-Path: <SRS0=izKu=U2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38082C48BD6
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 05:55:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A195B2054F
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IX03YAhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A195B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 359AFCC8;
	Thu, 27 Jun 2019 05:55:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB7D7C9B
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 05:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC4F13D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 05:55:37 +0000 (UTC)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id
	20190627055535epoutp0404a6eb1b1c69d54cc1aa0afbb91d77ee~r_IKcDsQH2274122741epoutp04Y
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 05:55:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
	20190627055535epoutp0404a6eb1b1c69d54cc1aa0afbb91d77ee~r_IKcDsQH2274122741epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1561614935;
	bh=oxKtuFXFu5WD9Homk5xhMeXg/GuXZII8dMpoFSiCOT0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=IX03YAhJe922Q7CrwSHQRjXTQwCgBKpnsewG0B3cZ/XJcO4/SJ2yUhhSLdFMOTkTQ
	1tlhBd/ocChssNE8C5gpXih9qOeDkGZ//qYIeQsjo/SfYWYqrw7fxL33ribdCZSZ6N
	2dY1VWeXjMmeEtIyBXskDhUK7dB7nxXchiL5Oj+I=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20190627055535epcas5p45ab2832e1276616ff656c3cb002c153b~r_IKPVhJ72044020440epcas5p47;
	Thu, 27 Jun 2019 05:55:35 +0000 (GMT)
X-AuditID: b6c32a4a-95bff70000000fe2-37-5d145a5523d6
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.D1.04066.55A541D5; Thu, 27 Jun 2019 14:55:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: RE: Re: CMA in AMD IOMMU driver
From: Sathyavathi M <sathya.m@samsung.com>
To: Christoph Hellwig <hch@infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190626094804epcms5p259576d5f98e8caf2968f7303676beb4a@epcms5p2>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190627055533epcms5p4cfa5be15b120d9bdbc8467a704d96e32@epcms5p4>
Date: Thu, 27 Jun 2019 11:25:33 +0530
X-CMS-MailID: 20190627055533epcms5p4cfa5be15b120d9bdbc8467a704d96e32
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCmlm5olEiswbUv8hanJyxisliw39qB
	yWPzCi2PyTeWMwYwRXHZpKTmZJalFunbJXBlzHvxiK1gNV/F391/mBoYz/J2MXJySAiYSGx5
	2MLcxcjFISSwm1Hi2O4d7F2MHBy8AoISf3cIg5jCAjoSE1+kgJQLCchJ3DncxQRig4T7nk0D
	q2YT0JJ49ZQHJCwioClxa3k7M4jNLOApsf3WQXaITbwSM9qfskDY0hLbl29lBLE5BfwkOt+u
	Y4aIi0rcXP2WHcZ+f2w+I4QtItF67yxUjaDEg5+7GUHWgsyZeCoAIlwucWb7RhaQRyQEGhgl
	um7sZYVImEvMvfcd6ilfidcHvEBMFgFVifs7+CAqXCQmHZ7FAnGxtsSyha+ZQUqYgT5Zv0sf
	Iswn0fv7CRPMIzvmwdhKEic+v4WyJSTW7IdZ6iHRNfU+IyRYm5gkXn+dyziBUX4WImRnIdk2
	C2HbAkbmVYySqQXFuempxaYFRnmp5XrFibnFpXnpesn5uZsYwVGv5bWDcdk5n0OMAhyMSjy8
	K3YKxwqxJpYVV+YeYpTgYFYS4c0PE4kV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzjuJ9WqMkEB6
	YklqdmpqQWoRTJaJg1OqgVEpnVfBkn1N1CLnS+6OvgfDeP4KxIXtnPxXTFciQeSB4OytCnc9
	Q++kfZpkrrHj2bTTOaGBqloTRU6fi6w4pyPYtWEr59+s8s9PPj5Q/dzz/nXm/PsuHz5NLFrv
	sDCBY7Pck55zEdtsSo+kcX6//erz9Vrx3iW68Uv643cs0D//XXRJqbJ64jklluKMREMt5qLi
	RABP1Wi49gIAAA==
X-CMS-RootMailID: 20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea
References: <20190626094804epcms5p259576d5f98e8caf2968f7303676beb4a@epcms5p2>
	<20190626065847.GA14605@infradead.org>
	<20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p8>
	<CGME20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p4>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
Reply-To: sathya.m@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SSB0cmllZCB0byBhcHBseSB0aGUgcGF0Y2ggKEFNRCBJT01NVSBkcml2ZXIgdG8gdXNlIGRtYS1p
b21tdSkgdG8gbGludXgga2VyZW5sIDUuMS4xNSBidXQgaXQgZ2l2ZXMgbWUgc29tZSBlcnJvcnMu
IApEb3dubG9hZGVkIHRoZSBwYXRjaCBmcm9tIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cGF0Y2gvMTA5NjAxNS8KCklzIHRoaXMgdGhlIHJpZ2h0IHdheSBpbSBkb2luZz8KClBsZWFzZSBs
ZXQgbWUga25vdy4KClRoYW5rcywKU2F0aHlhwqANCsKgDQotLS0tLS0tLS0gT3JpZ2luYWwgTWVz
c2FnZSAtLS0tLS0tLS0NClNlbmRlciA6IFNhdGh5YXZhdGhpIE3CoDxzYXRoeWEubUBzYW1zdW5n
LmNvbT7CoEVuZ2luZWVyL0hvc3QgU29mdHdhcmUgL1NTSVIvU2Ftc3VuZyBFbGVjdHJvbmljcw0K
RGF0ZSAgIDogMjAxOS0wNi0yNiAxNToyMSAoR01UKzU6MzApDQpUaXRsZSAgOiBSRTogUmU6IENN
QSBpbiBBTUQgSU9NTVUgZHJpdmVyDQpUbyA6IG51bGw8aGNoQGluZnJhZGVhZC5vcmc+DQpDQyA6
IG51bGw8aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+DQrCoA0KRGVhcsKgQ2hyaXN0
b3BoLA0KwqANClRoYW5rc8KgZm9ywqB0aGXCoHJlcGx5Lg0KY2FuwqB5b3XCoHBsZWFzZcKgbGV0
wqBtZcKga25vd8Kgd2hpY2jCoGtlcm5lbMKgaGFzwqBpdD8NCsKgDQrCoA0KVGhhbmtzLA0KU2F0
aHlhwqANCsKgDQotLS0tLS0tLS3CoE9yaWdpbmFswqBNZXNzYWdlwqAtLS0tLS0tLS0NClNlbmRl
csKgOsKgQ2hyaXN0b3BowqBIZWxsd2lnwqA8aGNoQGluZnJhZGVhZC5vcmc+DQpEYXRlwqDCoMKg
OsKgMjAxOS0wNi0yNsKgMTI6MjjCoChHTVQrNTozMCkNClRpdGxlwqDCoDrCoFJlOsKgQ01BwqBp
bsKgQU1EwqBJT01NVcKgZHJpdmVyDQpUb8KgOsKgU2F0aHlhdmF0aGnCoE08c2F0aHlhLm1Ac2Ft
c3VuZy5jb20+DQpDQ8KgOsKgbnVsbDxpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4N
CsKgDQpUb21zwqBjb252ZXJzaW9uwqBvZsKgdGhlwqBBTUTCoElPTU1VwqBkcml2ZXLCoHRvwqB1
c2XCoGRtYS1pb21tdcKgYWRkc8KgQ01BDQpzdXBwb3J0wqA6KQ0KwqANCsKgDQpSZWdhcmRzLA0K
U2F0aHlhDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
aW9tbXXCoG1haWxpbmfCoGxpc3QNCmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ0K
wqANClJlZ2FyZHMsDQpTYXRoeWEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
