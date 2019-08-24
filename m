Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1BC3A59E
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 16:27:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AB521897
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-ipv6.be header.i=@linux-ipv6.be header.b="Kks2UZXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AB521897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-ipv6.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 895087F6;
	Sat, 24 Aug 2019 16:27:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BDEA849F
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 16:27:37 +0000 (UTC)
X-Greylist: delayed 00:06:59 by SQLgrey-1.7.6
Received: from mail.tintel.eu (mail.tintel.eu [54.36.12.13])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AEE7CA7
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 16:27:36 +0000 (UTC)
Received: from localhost (localhost [IPv6:::1])
	by mail.tintel.eu (Postfix) with ESMTP id A2C9C423415B;
	Sat, 24 Aug 2019 18:20:33 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
	by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
	with ESMTP id dHe96I9mpIXQ; Sat, 24 Aug 2019 18:20:32 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by mail.tintel.eu (Postfix) with ESMTP id 5868D423414E;
	Sat, 24 Aug 2019 18:20:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu 5868D423414E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
	s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1566663632;
	bh=Z78MSMH3KDtHlzYjGro+kh5F85n9Q7rQo4m5LWvXrAk=;
	h=To:From:Message-ID:Date:MIME-Version;
	b=Kks2UZXwlBGN2/f/OfV5BnkVVN6I2IELcoYNAjBZBaAZx1u3Rt2KPPaXGwbIqu+GB
	+tLuzcHf8HC1ldypMTnh5spiRu4MhFhG66nLBX8F2dcfDU3R3ypxBcmRBvkmeetJjR
	u3NC5BO5AkBpQB/JEU8OsAPjj7DEs40mXDZSEZ6Y=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
	by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id rzOxxt5UXVEd; Sat, 24 Aug 2019 18:20:32 +0200 (CEST)
Received: from [IPv6:2001:67c:21bc:24::adb] (taz.sof.bg.adlevio.net
	[IPv6:2001:67c:21bc:24::adb]) (Authenticated sender: stijn@tintel.eu)
	by mail.tintel.eu (Postfix) with ESMTPSA id 91C134234152;
	Sat, 24 Aug 2019 18:20:29 +0200 (CEST)
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
From: Stijn Tintel <stijn@linux-ipv6.be>
Subject: [BISECTED REGRESSION 5.3-rc2] Marvell 88SE9128 SATA controller
	unusable with intel_iommu=on
Openpgp: preference=signencrypt
Message-ID: <8528653b-f2ad-a85d-437f-6e5dcb12042a@linux-ipv6.be>
Date: Sat, 24 Aug 2019 19:20:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-GB
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Xu Pengfei <pengfei.xu@intel.com>, iommu@lists.linux-foundation.org,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
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

SGksCgpUaGVyZSBpcyBhIGJ1ZyBpbiBrZXJuZWwgNS4zLXJjMiBhbmQgbGF0ZXIgdGhhdCBicmVh
a3MgbXkgTWFydmVsbAo4OFNFOTEyOCBTQVRBIGNvbnRyb2xsZXIuIFRoZSBwcm9ibGVtIGRvZXMg
bm90IG9jY3VyIHdoZW4gSSBib290IHdpdGgKaW50ZWxfaW9tbXU9b2ZmLiBUaGlzIHNlZW1zIHRv
IGJlIGEgcmVncmVzc2lvbiBvZgpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTQyNjc5LiBBIHF1aXJrIHdhcyBhZGRlZCB0bwpmaXggdGhpcywgaW4gY2MzNDZhNDcx
NGE1OWQwOGMxMThlOGYzM2ZkODY2OTJkMzU2MzEzMy4gVGhpcyBxdWlyayBpcwpzdGlsbCBpbiBw
bGFjZSwgYnV0IGl0IGFwcGVhcnMgdGhhdCBpdCBpcyBubyBsb25nZXIgd29ya2luZy4KCmF1ZyAy
MyAxODowNDoxNyB0YXoga2VybmVsOiBETUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMg
cmVnIDIKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTc6IFNBVEEgbGluayB1cCA2LjAg
R2JwcyAoU1N0YXR1cyAxMzMKU0NvbnRyb2wgMzAwKQphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5l
bDogYXRhOTogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApCmF1ZyAyMyAx
ODowNDoxNyB0YXoga2VybmVsOiBhdGE4OiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250
cm9sIDMwMCkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTEwOiBTQVRBIGxpbmsgZG93
biAoU1N0YXR1cyAwIFNDb250cm9sIDMwMCkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0
YTExOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9sIDMwMCkKYXVnIDIzIDE4OjA0
OjE3IHRheiBrZXJuZWw6IGF0YTUuMDA6IDE5NTM1MjUxNjggc2VjdG9ycywgbXVsdGkgMTY6IExC
QTQ4Ck5DUSAoZGVwdGggMzIpLCBBQQphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogRE1BUjog
W0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbMDk6MDAuMV0KZmF1bHQgYWRkciBmZmYwMDAwMCBb
ZmF1bHQgcmVhc29uIDAyXSBQcmVzZW50IGJpdCBpbiBjb250ZXh0IGVudHJ5IGlzIGNsZWFyCi4u
LgphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogc2QgNTowOjA6MDogW3NkZV0gQXR0YWNoZWQg
U0NTSSBkaXNrCmF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGExNC4wMDogcWMgdGltZW91
dCAoY21kIDB4YTEpCmF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE3LjAwOiBxYyB0aW1l
b3V0IChjbWQgMHhlYykKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0LjAwOiBmYWls
ZWQgdG8gSURFTlRJRlkgKEkvTyBlcnJvciwKZXJyX21hc2s9MHg0KQphdWcgMjMgMTg6MDQ6MTcg
dGF6IGtlcm5lbDogYXRhNy4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsCmVycl9t
YXNrPTB4NCkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0OiBTQVRBIGxpbmsgdXAg
MS41IEdicHMgKFNTdGF0dXMgMTEzClNDb250cm9sIDMwMCkKYXVnIDIzIDE4OjA0OjE3IHRheiBr
ZXJuZWw6IGF0YTc6IGxpbmsgaXMgc2xvdyB0byByZXNwb25kLCBwbGVhc2UgYmUKcGF0aWVudCAo
cmVhZHk9MCkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTc6IENPTVJFU0VUIGZhaWxl
ZCAoZXJybm89LTE2KQphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTQuMDA6IHFjIHRp
bWVvdXQgKGNtZCAweGExKQphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTQuMDA6IGZh
aWxlZCB0byBJREVOVElGWSAoSS9PIGVycm9yLAplcnJfbWFzaz0weDQpCmF1ZyAyMyAxODowNDox
NyB0YXoga2VybmVsOiBhdGExNDogU0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMwpT
Q29udHJvbCAzMDApCmF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE3OiBsaW5rIGlzIHNs
b3cgdG8gcmVzcG9uZCwgcGxlYXNlIGJlCnBhdGllbnQgKHJlYWR5PTApCmF1ZyAyMyAxODowNDox
NyB0YXoga2VybmVsOiBhdGE3OiBDT01SRVNFVCBmYWlsZWQgKGVycm5vPS0xNikKYXVnIDIzIDE4
OjA0OjE3IHRheiBrZXJuZWw6IGF0YTc6IGxpbmsgaXMgc2xvdyB0byByZXNwb25kLCBwbGVhc2Ug
YmUKcGF0aWVudCAocmVhZHk9MCkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0LjAw
OiBxYyB0aW1lb3V0IChjbWQgMHhhMSkKYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0
LjAwOiBmYWlsZWQgdG8gSURFTlRJRlkgKEkvTyBlcnJvciwKZXJyX21hc2s9MHg0KQphdWcgMjMg
MTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTQ6IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1
cyAxMTMKU0NvbnRyb2wgMzAwKQphdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhNzogQ09N
UkVTRVQgZmFpbGVkIChlcnJubz0tMTYpCmF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE3
OiBsaW1pdGluZyBTQVRBIGxpbmsgc3BlZWQgdG8gMy4wIEdicHMKYXVnIDIzIDE4OjA0OjE3IHRh
eiBrZXJuZWw6IGF0YTc6IENPTVJFU0VUIGZhaWxlZCAoZXJybm89LTE2KQphdWcgMjMgMTg6MDQ6
MTcgdGF6IGtlcm5lbDogYXRhNzogcmVzZXQgZmFpbGVkLCBnaXZpbmcgdXAKCgpUaGlzIGlzIHRo
ZSBvdXRjb21lIG9mIGdpdCBiaXNlY3Q6Cgo1NTc1Mjk0OTRkNzlmM2YxZmFkZDQ4NmRkMThkMmRl
MGIxOWJlNGRhIGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0CmNvbW1pdCA1NTc1Mjk0OTRkNzlmM2Yx
ZmFkZDQ4NmRkMThkMmRlMGIxOWJlNGRhCkF1dGhvcjogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KRGF0ZTrCoMKgIFR1ZSBKdWwgOSAxMzoyMjo0NSAyMDE5ICswODAwCgrCoMKg
wqAgaW9tbXUvdnQtZDogQXZvaWQgZHVwbGljYXRlZCBwY2kgZG1hIGFsaWFzIGNvbnNpZGVyYXRp
b24KCsKgwqDCoCBBcyB3ZSBoYXZlIGFiYW5kb25lZCB0aGUgaG9tZS1tYWRlIGxhenkgZG9tYWlu
IGFsbG9jYXRpb24KwqDCoMKgIGFuZCBkZWxlZ2F0ZWQgdGhlIERNQSBkb21haW4gbGlmZSBjeWNs
ZSB1cCB0byB0aGUgZGVmYXVsdArCoMKgwqAgZG9tYWluIG1lY2hhbmlzbSBkZWZpbmVkIGluIHRo
ZSBnZW5lcmljIGlvbW11IGxheWVyLCB3ZQrCoMKgwqAgbmVlZG4ndCBjb25zaWRlciBwY2kgYWxp
YXMgYW55bW9yZSB3aGVuIG1hcHBpbmcvdW5tYXBwaW5nCsKgwqDCoCB0aGUgY29udGV4dCBlbnRy
aWVzLiBXaXRob3V0IHRoaXMgZml4LCB3ZSBzZWUga2VybmVsIE5VTEwKwqDCoMKgIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgZHVyaW5nIHBjaSBkZXZpY2UgaG90LXBsdWcgdGVzdC4KCsKgwqDCoCBDYzog
QXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29tPgrCoMKgwqAgQ2M6IEphY29iIFBhbiA8amFj
b2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+CsKgwqDCoCBDYzogS2V2aW4gVGlhbiA8a2V2aW4u
dGlhbkBpbnRlbC5jb20+CsKgwqDCoCBGaXhlczogZmE5NTRlNjgzMTc4OSAoImlvbW11L3Z0LWQ6
IERlbGVnYXRlIHRoZSBkbWEgZG9tYWluIHRvIHVwcGVyCmxheWVyIikKwqDCoMKgIFNpZ25lZC1v
ZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+CsKgwqDCoCBSZXBvcnRl
ZC1hbmQtdGVzdGVkLWJ5OiBYdSBQZW5nZmVpIDxwZW5nZmVpLnh1QGludGVsLmNvbT4KwqDCoMKg
IFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgoKOjA0MDAwMCAw
NDAwMDAgMDEwZTcwNTdiODQwMTQ4MWU3MjU4OTQ4Nzg2YTI2NThmOWYxNDAzNwoxOGFlYWM1MGE2
MGQ4Yjg0MjRmY2RjY2QwYjMxMThmNTY1Y2UzOTA5IE3CoMKgwqDCoMKgIGRyaXZlcnMKClN0aWpu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
