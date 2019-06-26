Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18056C48BD6
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 09:48:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923492082F
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E4cA2IDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923492082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6581AED3;
	Wed, 26 Jun 2019 09:48:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 67A9AE8D
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 09:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B787B710
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 09:48:06 +0000 (UTC)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id
	20190626094804epoutp03dc1eb0704fd05cfa41d5fd946835982e~rtp3VpKRf2109721097epoutp03X
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 09:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
	20190626094804epoutp03dc1eb0704fd05cfa41d5fd946835982e~rtp3VpKRf2109721097epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1561542484;
	bh=rVy5lGOJhuQ7ItlHfQywyyEHAq75fB9utHjrktZKaCA=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=E4cA2IDHiIevEosomTpZUVq9vSyffWRn4bfFNv1J++4FgYYV1EM+7leNM1X5SvVzb
	G7g2aRud+maLILZVqJ+UdMj8KLqvqYk+iIJZi0PH68dxWhirNo/chZrwfYUb4XWPaD
	cKAi0bzO7vXSm7LKE6KmliiNo/EraH0xtLZpKaqM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20190626094804epcas5p413f170c532846a1e66b35fd6f250bbe6~rtp3FsYGX1287012870epcas5p4C;
	Wed, 26 Jun 2019 09:48:04 +0000 (GMT)
X-AuditID: b6c32a4b-7a3ff70000000fe3-8b-5d133f5470ce
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.62.04067.45F331D5; Wed, 26 Jun 2019 18:48:04 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: CMA in AMD IOMMU driver
From: Sathyavathi M <sathya.m@samsung.com>
To: Christoph Hellwig <hch@infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190626065847.GA14605@infradead.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190626094804epcms5p259576d5f98e8caf2968f7303676beb4a@epcms5p2>
Date: Wed, 26 Jun 2019 15:18:04 +0530
X-CMS-MailID: 20190626094804epcms5p259576d5f98e8caf2968f7303676beb4a
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCmhm6IvXCswd1+GYvTExYxWSzYb+3A
	5LF5hZbH5BvLGQOYorhsUlJzMstSi/TtErgy3u5uZyvYxlrx6+sl1gbGbtYuRk4OCQETiSNf
	p7CB2EICuxklZq3n6GLk4OAVEJT4u0MYJCwsoCGx/tBdRogSOYk7h7uYIOI6En3PprGDlLMJ
	aEm8esoDEhYR0JS4tbydGcRmFvCU2H7rIDvEJl6JGe1PWSBsaYnty7eCjeQUMJb4Omc6I0Rc
	VOLm6rfsMPb7Y/Oh4iISrffOMkPYghIPfu5mBFkLMmfiqQCIcLnEme0bgcZzAdkNjBJdN/ZC
	fWguMffed7CZvAK+EveP3geLswioSizb8JoZYo6LxLqdIRAna0ssWwgRZgZ6Zf0ufYgwn0Tv
	7ydMMJ/smAdjK0mc+PwWypaQWLMfZquHRNfU+4wg5wgJ7GOUODzxJMsERvlZiLCdhWTbLIRt
	CxiZVzFKphYU56anFpsWGOellusVJ+YWl+al6yXn525iBMe9lvcOxk3nfA4xCnAwKvHwNsgL
	xQqxJpYVV+YeYpTgYFYS4V2aKBArxJuSWFmVWpQfX1Sak1p8iFGag0VJnHcS69UYIYH0xJLU
	7NTUgtQimCwTB6dUA6P4Q9akEB1G8dmPtHbzPXHbe1Yqu2kWn/G8Zp9YteeSC46faK/qe/Nh
	0b/sJ0b+vr1Sk2J27a6ylXkkuz9/7/9zqS7Hp/qJC0pn63ItWn9lRdSCc7GOtmXh7OnzMqyd
	RIU/rPKuEdwoHb5gM5/ok+2v84O73j31LJNcHnem+UHri9JLM/nv3FBiKc5INNRiLipOBAAZ
	WaXi9wIAAA==
X-CMS-RootMailID: 20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea
References: <20190626065847.GA14605@infradead.org>
	<20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p8>
	<CGME20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p2>
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

RGVhciBDaHJpc3RvcGgsCgpUaGFua3MgZm9yIHRoZSByZXBseS4KY2FuIHlvdSBwbGVhc2UgbGV0
IG1lIGtub3cgd2hpY2gga2VybmVsIGhhcyBpdD8KCgpUaGFua3MsClNhdGh5YcKgDQrCoA0KLS0t
LS0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0tLS0tDQpTZW5kZXIgOiBDaHJpc3RvcGggSGVs
bHdpZ8KgPGhjaEBpbmZyYWRlYWQub3JnPg0KRGF0ZSAgIDogMjAxOS0wNi0yNiAxMjoyOCAoR01U
KzU6MzApDQpUaXRsZSAgOiBSZTogQ01BIGluIEFNRCBJT01NVSBkcml2ZXINClRvIDogU2F0aHlh
dmF0aGkgTTxzYXRoeWEubUBzYW1zdW5nLmNvbT4NCkNDIDogbnVsbDxpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZz4NCsKgDQpUb21zwqBjb252ZXJzaW9uwqBvZsKgdGhlwqBBTUTCoElP
TU1VwqBkcml2ZXLCoHRvwqB1c2XCoGRtYS1pb21tdcKgYWRkc8KgQ01BDQpzdXBwb3J0wqA6KQ0K
wqANCsKgDQpSZWdhcmRzLA0KU2F0aHlhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
