Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66224C28D16
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 13:30:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476882146E
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 13:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476882146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9683BB3;
	Mon, 10 Jun 2019 13:30:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 79B90BA4
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 13:30:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BEAA4885
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 13:30:16 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id m3so13242385itl.1
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 06:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FSaiN1DGIOpo9wbwPTRGmWSmcDUKGj8HneroXcSzc/M=;
	b=T77Lh2PKMkz+pMqGzFh3fNeyredB5/BwIMFDofvo3oWCwBy15LgyQddFRMrQjOUSzY
	cFmcAiM7wi1558+Buk7DjPLPxyMR/E7jApqFTIIhQ1iFdpNqtB84pGb7yhW5sb2lcH6F
	P3k6Efxlc673YLQaahldQFSrdFvKZtFZzi34lmbpC9sgWJ4YkBIH9uHEjTCYY62AM4/t
	7wDJ1bwDZpUlUy0MOjOP/a+pnziAZ4nJ1CKsheVkSe6TjYVzAsZo2xiBqG359UTxMtVN
	iRreAATtIDXmNUzIjlLcY+mQ0P34S6A4J5TAFBWmuYiBt+tJI6oU6yRBLhmRGF5rRxim
	CxPQ==
X-Gm-Message-State: APjAAAWmtVRiJ5UQSscCOJO8eVVDKxbTLiw21H2w6jvImrAckK8aYhaI
	nEmKf3Y35DMUMsCv+PNLrXBTn4InH+ndNeKWfSc=
X-Google-Smtp-Source: APXvYqyq4NHqWPMvbk/l889DlLgBf0SpgBNg21nvVRXHFPp/Y/5gdMDmhh1wO+sZM71UpN8V7nXXar8bbgMezmYJflM=
X-Received: by 2002:a02:7b2d:: with SMTP id q45mr42271200jac.127.1560173415987;
	Mon, 10 Jun 2019 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
	<CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
	<4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
In-Reply-To: <4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon, 10 Jun 2019 15:30:03 +0200
Message-ID: <CAAObsKB=vNr6bBomQ_hMfic8CuwZcqF_x7UJR6rSm2cG=EJAcg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>,
	David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

T24gV2VkLCAyOSBNYXkgMjAxOSBhdCAxOTozOCwgUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlA
YXJtLmNvbT4gd3JvdGU6Cj4KPiBPbiAyOS8wNS8yMDE5IDE2OjA5LCBUb21ldSBWaXpvc28gd3Jv
dGU6Cj4gPiBPbiBUdWUsIDIxIE1heSAyMDE5IGF0IDE4OjExLCBDbMOpbWVudCBQw6lyb24gPHBl
cm9uLmNsZW1AZ21haWwuY29tPiB3cm90ZToKPiA+Pgo+ID4gW3NuaXBdCj4gPj4gWyAgMzQ1LjIw
NDgxM10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBpcnEgc3RhdHVzPTEKPiA+PiBbICAzNDUu
MjA5NjE3XSBwYW5mcm9zdCAxODAwMDAwLmdwdTogVW5oYW5kbGVkIFBhZ2UgZmF1bHQgaW4gQVMw
IGF0IFZBCj4gPj4gMHgwMDAwMDAwMDAyNDAwNDAwCj4gPgo+ID4gIEZyb20gd2hhdCBJIGNhbiBz
ZWUgaGVyZSwgMHgwMDAwMDAwMDAyNDAwNDAwIHBvaW50cyB0byB0aGUgZmlyc3QgYnl0ZQo+ID4g
b2YgdGhlIGZpcnN0IHN1Ym1pdHRlZCBqb2IgZGVzY3JpcHRvci4KPiA+Cj4gPiBTbyBtYXBwaW5n
IGJ1ZmZlcnMgZm9yIHRoZSBHUFUgZG9lc24ndCBzZWVtIHRvIGJlIHdvcmtpbmcgYXQgYWxsIG9u
Cj4gPiA2NC1iaXQgVC03NjAuCj4gPgo+ID4gU3RldmVuLCBSb2JpbiwgZG8geW91IGhhdmUgYW55
IGlkZWEgb2Ygd2h5IHRoaXMgY291bGQgYmU/Cj4KPiBJIHRyaWVkIHJvbGxpbmcgYmFjayB0byB0
aGUgb2xkIHBhbmZyb3N0L25vbmRybSBzaGltLCBhbmQgaXQgd29ya3MgZmluZQo+IHdpdGgga2Jh
c2UsIGFuZCBJIGFsc28gZm91bmQgdGhhdCBULTgyMCBmYWxscyBvdmVyIGluIHRoZSBleGFjdCBz
YW1lCj4gbWFubmVyLCBzbyB0aGUgZmFjdCB0aGF0IGl0IHNlZW1lZCB0byBiZSBjb21tb24gdG8g
dGhlIHNtYWxsZXIgMzMtYml0Cj4gZGVzaWducyByYXRoZXIgdGhhbiBhbnl0aGluZyB0byBkbyB3
aXRoIHRoZSBvdGhlcgo+IGpvYl9kZXNjcmlwdG9yX3NpemUvdjQvdjUgY29tcGxpY2F0aW9uIHR1
cm5lZCBvdXQgdG8gYmUgdGVsbGluZy4KPgo+IFsgYXMgYW4gYXNpZGUsIGFyZSA2NC1iaXQgam9i
cyBhY3R1YWxseSBrbm93biBub3QgdG8gd29yayBvbiB2NCBHUFVzLCBvcgo+IGlzIGl0IGp1c3Qg
dGhhdCBub2JvZHkncyB5ZXQgb2JzZXJ2ZWQgYSA2NC1iaXQgYmxvYiBkcml2aW5nIG9uZT8gXQoK
RG8geW91IGtub3cgaWYgNjQtYml0IGRlc2NyaXB0b3JzIHdvcmsgb24gdjQgR1BVcyB3aXRoIG91
ciBrZXJuZWwKZHJpdmVyIGJ1dCB3aXRoIHRoZSBEREs/CgpXb25kZXIgaWYgdGhlcmUgc29tZXRo
aW5nIGVsc2UgdG8gYmUgZml4ZWQgaW4gdGhlIGtlcm5lbCBmb3IgdGhhdCBzY2VuYXJpby4KClRo
YW5rcywKClRvbWV1Cgo+IExvbmcgc3Rvcnkgc2hvcnQsIGl0IGFwcGVhcnMgdGhhdCAnTWFsaSBM
UEFFJyBpcyBhbHNvIGxhY2tpbmcgdGhlIHN0YXJ0Cj4gbGV2ZWwgbm90aW9uIG9mIFZNU0EsIGFu
ZCBleHBlY3RzIGEgZnVsbCA0LWxldmVsIHRhYmxlIGV2ZW4gZm9yIDw0MCBiaXRzCj4gd2hlbiBs
ZXZlbCAwIGVmZmVjdGl2ZWx5IHJlZHVuZGFudC4gVGh1cyB3YWxraW5nIHRoZSAzLWxldmVsIHRh
YmxlIHRoYXQKPiBpby1wZ3RhYmxlIGNvbWVzIGJhY2sgd2l0aCBlbmRzIHVwIGdvaW5nIHdpbGRs
eSB3cm9uZy4gVGhlIGhhY2sgYmVsb3cKPiBzZWVtcyB0byBkbyB0aGUgam9iIGZvciBtZTsgaWYg
Q2zDqW1lbnQgY2FuIGNvbmZpcm0gKG9uIFQtNzIwIHlvdSdsbAo+IHN0aWxsIG5lZWQgdGhlIHVz
ZXJzcGFjZSBoYWNrIHRvIGZvcmNlIDMyLWJpdCBqb2JzIGFzIHdlbGwpIHRoZW4gSSB0aGluawo+
IEknbGwgY29vayB1cCBhIHByb3BlciByZWZhY3RvcmluZyBvZiB0aGUgYWxsb2NhdG9yIHRvIHB1
dCB0aGluZ3MgcmlnaHQuCj4KPiBSb2Jpbi4KPgo+Cj4gLS0tLS0+OC0tLS0tCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0
YWJsZS1hcm0uYwo+IGluZGV4IDU0Njk2OGQ4YTM0OS4uZjI5ZGE2ZThkYzA4IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW8tcGd0YWJsZS1hcm0uYwo+IEBAIC0xMDIzLDEyICsxMDIzLDE0IEBAIGFybV9tYWxpX2xwYWVf
YWxsb2NfcGd0YWJsZShzdHJ1Y3QKPiBpb19wZ3RhYmxlX2NmZyAqY2ZnLCB2b2lkICpjb29raWUp
Cj4gICAgICAgICBpb3AgPSBhcm1fNjRfbHBhZV9hbGxvY19wZ3RhYmxlX3MxKGNmZywgY29va2ll
KTsKPiAgICAgICAgIGlmIChpb3ApIHsKPiAgICAgICAgICAgICAgICAgdTY0IG1haXIsIHR0YnI7
Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBhcm1fbHBhZV9pb19wZ3RhYmxlICpkYXRhID0gaW9f
cGd0YWJsZV9vcHNfdG9fZGF0YSgmaW9wLT5vcHMpOwo+Cj4gKyAgICAgICAgICAgICAgIGRhdGEt
PmxldmVscyA9IDQ7Cj4gICAgICAgICAgICAgICAgIC8qIENvcHkgdmFsdWVzIGFzIHVuaW9uIGZp
ZWxkcyBvdmVybGFwICovCj4gICAgICAgICAgICAgICAgIG1haXIgPSBjZmctPmFybV9scGFlX3Mx
X2NmZy5tYWlyWzBdOwo+ICAgICAgICAgICAgICAgICB0dGJyID0gY2ZnLT5hcm1fbHBhZV9zMV9j
ZmcudHRiclswXTsKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
