Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A9C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 19:12:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D4E2087E
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iTNDKDrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4C035E0E;
	Mon, 19 Aug 2019 19:12:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 87DA1DCD
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 19:12:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 60BC467F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1566241925;
	bh=IQ1HrA8S91To3KwXtSgfjjTeQk7Gg1ku9YZqdtusm10=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=iTNDKDrrkZkvJaPoWEB4mj/uIXHEcJzWRRCH6EVg1Sh9tPoUgbaeD0D5JZPSNo9Ge
	XkPhupLiow9V9q7xCDyygKSSPzIxlpH/L4JuAJmy2ig2O8t0E8Ky7z5mI8J9R4rE2z
	HtFd6lruH2Nbi+IgzFh/BTLQC2PUjS+an0UbVNiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx001
	[212.227.17.190]) with ESMTPSA (Nemesis) id 0MQiVh-1hq4KG0mdx-00U01C;
	Mon, 19 Aug 2019 21:12:05 +0200
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
From: Stefan Wahren <wahrenst@gmx.net>
Message-ID: <0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
Date: Mon, 19 Aug 2019 21:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
Content-Language: en-US
X-Provags-ID: V03:K1:AYO427Kp4/FPhSYXg5yavhHIxSlgjbel/9eiTflwvl9n1Bz/fCk
	OPkb0VILTvcc7tr2s6r1YJXRiDPioZj53VJ+8Lrbjlal8Pf8PNAhhQkTHFfLi+na0B6om1y
	msKzHU8/2+5CyPeL/G3lAlcmWiu0sUaSlbTLxoYn8I+xr+q9izDY3jyMIdAulmhvzTKAJR/
	3sq22QTSRnebKRDasJtMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cAoPz/oMr0I=:zHdyGVRVvr4Qvd+hXguSVq
	rCmPfukVZocx3mP+WN+jfN3ZaCFOiZfogqrmRM1Jup1lgYOSHPUFfbwPqoHXSQi/VhpMOJJ13
	4kD3Zjkuu67RSJuiSdTOtQOd9Xv/bQIISot770hojOZdAhs7p4FTGiDUKfhm3CfM4bkLL0U8H
	LhLoAzeGSW8DBOIpYTdFzFBWFyUWZQ91vrKiuhTtLg52LeA6mrt0dfCKhn2cW0mQiZvtwBuvo
	3f2G1+R5r2lHzGDFiD4ACEoXrNPNpbnhxfzx+VlgM53ldXRkHkhYuXtiHofCPEYvS1Dvi8/Ad
	qFl2FIUUx8MC+Ox49+aiYoxEi7+xCXeot1eli3HnWM2VfBHn3T9WvhGN4q9QgQuc6LgECYh0N
	I3j1+MZuVWL6+RQfS6cbZCno2RMCc7hv8LQLiFRRbPuNlllND9+6H1EnBtwyDDJTSyAERcyBb
	vMHprq/VRkHdfN07j1v/EZ/PIpEmWHXtS5Pn8lJhyCGsfouyXRwoh6LWSUMCe4dp4wzmpLFsA
	T4yhuVAlIFBeJqYuT7z3RWlcwYg4JfiphoAv0d1QKuLPr0pB6zfu+g3So49GhPlbvF1l7rZPG
	WleYrOxO/LTEP3HKHrbhNAMyJy0X3La/HNNk83yOqOtslcKFWyZhZ6yLZeSf8mrKIwmdws+IR
	NgUvmGB4KRKsGjBavvQAuYmOzo3KmUZHdrIuOtS7H+N+IAWiX3bOEQQ5EbCIdbgf0qvBJJjhi
	WORRqqWc9dOzcafrdOze+DvEZEXOHRzrZxSLlcT63dYSpbOjcZCpkP34v3RibFK4DCL6D/K0L
	TBdNSoI8bdOgrP9Z9rDIHma5O/DevpsaavPb6ggv1Eevyb+ybfJrD/ir/GoouvrzizJ2z2sLa
	xPe7jrd4I2N+nxnyVRzNEYgnkHWv0YDQdy8O0E3XYY/byakLRf5nKtSQckj75fe+qg/rTIFQy
	YmGhhsUqxEx0O5Mo6J3mJnXpuM8V+DevOBYAMHmyIhlWgPNL2Dy6c9hstkjO0WNmVDI9O24dR
	0nEjqyYFne8Mk1lQ4wW7yjuI9dBAbhpLnP1ulvCiDUYYX6NWfm20HrEQrcL5CgFZUFuhkl7mE
	iriwiwM6Hap0diCN7way9SC9zeIaTx3vZ8y5tlE5SKl2xnljoNNCLf3Fyhnjb9K1CAYxcXgai
	mhwoA=
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

QW0gMTkuMDguMTkgdW0gMjE6MDIgc2NocmllYiBSb2JpbiBNdXJwaHk6DQo+IE9uIDE5LzA4LzIw
MTkgMTk6MzcsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBpIHRyaWVkIHRv
IGNyb3NzIGNvbXBpbGUgYXJtL211bHRpX3Y3X2RlZmNvbmZpZyB3aXRoIENPTkZJR19YRU49eSB3
aXRoDQo+PiBMaW51eCA1LjMtcmM1IGFuZCBpJ20gZ2V0dGluZyB0aGlzOg0KPj4NCj4+IGFyY2gv
YXJtL21tL2RtYS1tYXBwaW5nLmM6IEluIGZ1bmN0aW9uIOKAmGFyY2hfc2V0dXBfZG1hX29wc+KA
mToNCj4+IGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6MjM0Nzo1OiBlcnJvcjog4oCYc3RydWN0
IGRldmljZeKAmSBoYXMgbm8gbWVtYmVyDQo+PiBuYW1lZCDigJhkbWFfY29oZXJlbnTigJkNCj4+
IMKgwqAgZGV2LT5kbWFfY29oZXJlbnQgPSBjb2hlcmVudDsNCj4+IMKgwqDCoMKgwqAgXn4NCj4+
IGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6IEF0IHRvcCBsZXZlbDoNCj4+IGFyY2gvYXJtL21t
L2RtYS1tYXBwaW5nLmM6MjM4NTo2OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mDQo+PiDigJhhcmNo
X3N5bmNfZG1hX2Zvcl9kZXZpY2XigJkNCj4+IMKgwqB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2Rl
dmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHBhZGRyLA0KPj4gwqDCoMKgwqDC
oMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGFy
Y2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6MTg6MDoNCj4+IC4vaW5jbHVkZS9saW51eC9kbWEtbm9u
Y29oZXJlbnQuaDo2NzoyMDogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZg0KPj4g4oCYYXJj
aF9zeW5jX2RtYV9mb3JfZGV2aWNl4oCZIHdhcyBoZXJlDQo+PiDCoMKgc3RhdGljIGlubGluZSB2
b2lkIGFyY2hfc3luY19kbWFfZm9yX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPj4gYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYzoyMzkyOjY6IGVycm9yOiByZWRlZmlu
aXRpb24gb2YNCj4+IOKAmGFyY2hfc3luY19kbWFfZm9yX2NwdeKAmQ0KPj4gwqDCoHZvaWQgYXJj
aF9zeW5jX2RtYV9mb3JfY3B1KHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgcGFkZHIs
DQo+PiDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYzoxODowOg0KPj4gLi9pbmNsdWRlL2xp
bnV4L2RtYS1ub25jb2hlcmVudC5oOjc3OjIwOiBub3RlOiBwcmV2aW91cyBkZWZpbml0aW9uIG9m
DQo+PiDigJhhcmNoX3N5bmNfZG1hX2Zvcl9jcHXigJkgd2FzIGhlcmUNCj4+IMKgwqBzdGF0aWMg
aW5saW5lIHZvaWQgYXJjaF9zeW5jX2RtYV9mb3JfY3B1KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+DQo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL2FybS9pbmNsdWRlL2FzbS9w
YWdlLmg6MTQ5OjAsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20g
Li9hcmNoL2FybS9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oOjE0LA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9saW51eC90aHJlYWRfaW5mby5o
OjM4LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVk
ZS9hc20tZ2VuZXJpYy9wcmVlbXB0Lmg6NSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZnJvbSAuL2FyY2gvYXJtL2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9wcmVlbXB0Lmg6
MSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2luY2x1ZGUv
bGludXgvcHJlZW1wdC5oOjc4LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmcm9tIC4vaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjUxLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9saW51eC9zZXFsb2NrLmg6MzYsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4
L3RpbWUuaDo2LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4v
aW5jbHVkZS9saW51eC9zdGF0Lmg6MTksDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21vZHVsZS5oOjEwLA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6OToN
Cj4+DQo+PiBUaGVyZSBpcyBubyBidWlsZCBpc3N1ZSB3aXRoIExpbnV4IDUuMiwgc28gdGhpcyBt
dXN0IGJlIGludHJvZHVjZWQgd2l0aA0KPj4gNS4zLXJjLiBJIGhvcGUgeW91IGhhdmUgYSBjbHVl
IHdpdGhvdXQgYmlzZWN0aW5nIHRoaXMuDQo+DQo+IE9oLCB0aGF0IG11c3QgYmUgYWQzYzdiMThj
NWIsIHNpbmNlIHRoZSBkbWEtbm9uY29oZXJlbnQgc3R1ZmYgaXMgb25seQ0KPiBzZWxlY3RlZCBi
eSBDT05GSUdfQVJNX0xQQUUsIGJ1dCB0aGUgcmVmZXJlbmNlcyB0byBpdCBhcmUgZ3VhcmRlZCBi
eQ0KPiBDT05GSUdfU1dJT1RMQiwgYW5kIENPTkZJR19YRU4gYnJpbmdzIGluIHRoZSBsYXR0ZXIg
d2l0aG91dCB0aGUgZm9ybWVyLg0KWWVzLCByZXZlcnRpbmcgYWQzYzdiMThjNWIgKCJhcm06IHVz
ZSBzd2lvdGxiIGZvciBib3VuY2UgYnVmZmVyaW5nIG9uDQpMUEFFIGNvbmZpZ3MiKSBhdm9pZCB0
aGlzIGJ1aWxkIGlzc3VlLg0KPg0KPiBSb2Jpbi4NCj4NCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
