Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1905C4332F
	for <iommu@archiver.kernel.org>; Sat, 26 Mar 2022 22:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 652CE410B0;
	Sat, 26 Mar 2022 22:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFU6Dp1cCy34; Sat, 26 Mar 2022 22:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20FBA410AE;
	Sat, 26 Mar 2022 22:38:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4F25C001D;
	Sat, 26 Mar 2022 22:38:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB407C0012
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B321A813E5
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VK-D5Qr-65H0 for <iommu@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 22:38:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BD368127D
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:38:33 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-sg83NcgSN6CniSYATwmuJw-1; Sat, 26 Mar 2022 22:38:30 +0000
X-MC-Unique: sg83NcgSN6CniSYATwmuJw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sat, 26 Mar 2022 22:38:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sat, 26 Mar 2022 22:38:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>,
 =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Subject: RE: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Topic: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Thread-Index: AQHYQUDBK/9JYQDqEEKfLChLw6SC36zSPELQ
Date: Sat, 26 Mar 2022 22:38:27 +0000
Message-ID: <d9fbd3ab9b514b0d8121d4d7d21662a6@AcuMS.aculab.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <cce202fb-5185-aa3e-9e9b-11626192cb49@arm.com>
 <20220326003853.44c3285c.pasic@linux.ibm.com> <8735j47l7y.fsf@toke.dk>
 <CAHk-=wjorwZTQuQB8QBgNpdBZNz7uyprgaTT+1Q6_1FaT3sAmQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjorwZTQuQB8QBgNpdBZNz7uyprgaTT+1Q6_1FaT3sAmQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgTWFyY2ggMjAyMiAxODozOQ0KPiANCj4g
T24gU2F0LCBNYXIgMjYsIDIwMjIgYXQgOTowNiBBTSBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4g
PHRva2VAdG9rZS5kaz4gd3JvdGU6DQo+ID4NCj4gPiBJIHdhcyBhbHNvIHRveWluZyB3aXRoIHRo
ZSBpZGVhIG9mIGhhdmluZyBhIGNvcHktYmFzZWQgcGVlayBoZWxwZXIgbGlrZToNCj4gPg0KPiA+
IHUzMiBkYXRhID0gZG1hX3BlZWtfd29yZChidWYsIG9mZnNldCkNCj4gDQo+IEkgcmVhbGx5IGRv
bid0IHRoaW5rIHlvdSBjYW4gb3Igd2FudCB0byBoYXZlIGEgd29yZC1iYXNlZCBvbmUuDQo+IA0K
PiBUaGF0IHNhaWQsIEkgbGlrZSB0aGUgKm5hbWUqIG9mIHRoYXQgdGhpbmcuDQo+IA0KPiBJIHRo
aW5rIGEgbG90IG9mIGNvbmZ1c2lvbiBjb21lcyBmcm9tIHRoZSB2ZXJ5IHN1YnRsZSBuYW1pbmcg
b2YNCj4gZnVuZGFtZW50YWxseSBoYXZpbmcgYSBsb3Qgb2Ygb2RkIGNvbmRpdGlvbnMgd2l0aA0K
PiANCj4gIC0gdHdvIGRpZmZlcmVudCAiZGlyZWN0aW9ucyBvZiB0aGUgc3luYyIgLSBpZSB3aG8g
aXQgaXMgdGhhdCBjYXJlczoNCj4gDQo+ICAgICAgICBkbWFfc3luY19zaW5nbGVfZm9yX3tjcHUs
ZGV2aWNlfQ0KPiANCj4gIC0gdGhyZWUgZGlmZmVyZW50ICJkaXJlY3Rpb24gb2YgdGhlIGRhdGEi
IC0gaWUgd2hvIGl0IGlzIHRoYXQgd3JpdGVzIHRoZSBkYXRhOg0KPiANCj4gICAgICAgICBETUFf
RlJPTV9ERVZJQ0UgLyBETUFfVE9fREVWSUNFIC8gRE1BX0JJRElSRUNUSU9OQUwNCj4gDQo+IHNv
IHlvdSBoYXZlIHNpeCBwb3NzaWJsZSBjb21iaW5hdGlvbnMsIHRocmVlIG9mIHdoaWNoIHNlZW0g
aW5zYW5lIGFuZA0KPiBub3QgdXNlZnVsLCBhbmQgb2YgdGhlIHRocmVlIHRoYXQgYXJlIGFjdHVh
bGx5IHBvc3NpYmxlLCBzb21lIGFyZSB2ZXJ5DQo+IHVudXN1YWwgKGl0IGV4YWN0bHkgdGhhdCAi
ZGV2aWNlIGlzIHRoZSBvbmUgd3JpdGluZywgYnV0IHdlIHdhbnQgdG8NCj4gc3luYyB0aGUgZG1h
IGFyZWEgZm9yIHRoZSBkZXZpY2UiKS4NCg0KQW5vdGhlciAyYyA6LSkNCg0KSXMgdGhlIGlkZWEg
b2YgJ2J1ZmZlciBvd25lcnNoaXAnIGV2ZW4gYSBnb29kIG9uZT8NClBlcmhhcHMgdGhlIHdob2xl
IHRoaW5nIHdvdWxkIGJlIGJldHRlciBkZXNjcmliZWQgaW4gdGVybXMgb2YNCndoYXQgaGFwcGVu
cyB3aGVuIGJvdW5jZSBidWZmZXJzIGFyZSB1c2VkLg0KU28gdGhlcmUgYXJlIG5vdGlvbmFsbHkg
dHdvIGJ1ZmZlcnMuDQpPbmUgYWNjZXNzZWQgYnkgdGhlIGNwdSwgdGhlIG90aGVyIGJ5IHRoZSBk
ZXZpY2UuDQoNClRoZXJlIGFyZSB0aGVuIGp1c3QgMyB0aGluZ3MgdGhhdCBoYXBwZW46DQoxKSBE
aXJ0eSBkYXRhIG1heSBnZXQgbW92ZWQgdG8gdGhlIG90aGVyIGJ1ZmZlciBhdCBhbnkgdGltZS4N
CiAgIFNvIHRoZSBkcml2ZXIgbXVzdCBub3QgZGlydHkgYnVmZmVycyAoY2FjaGUgbGluZXMpIHRo
YXQgdGhlDQogICBkZXZpY2UgbWlnaHQgd3JpdGUgdG8uDQoyKSBUaGUgY3B1IGhhcyB0byByZXF1
ZXN0IGRhdGEgYmUgY29waWVkIHRvIHRoZSBkZXZpY2UgYnVmZmVyDQogICBhZnRlciB1cGRhdGlu
ZyB0aGUgY3B1IGJ1ZmZlci4NCiAgIFRoaXMgbWFrZXMgdGhlIGNwdSBidWZmZXIgJ25vdCBkaXJ0
eScgc28gY29waWVzICgxKSBjYW4gbm8NCiAgIGxvbmdlciBoYXBwZW4uDQozKSBUaGUgY3B1IGhh
cyB0byByZXF1ZXN0IGRhdGEgYmUgY29waWVkIGZyb20gdGhlIGRldmljZSBidWZmZXINCiAgIGJl
Zm9yZSBsb29raW5nIGF0IHRoZSBkYXRhLg0KQWxsIGNvcGllcyBhZmZlY3QgYSBkbWEtY2FjaGUt
bGluZSBzaXplZCBibG9jayBvZiBkYXRhICh3aGljaA0KbWlnaHQgYmUgZGV2aWNlIGRlcGVuZGFu
dCkuDQpBbiBvcHRpbWlzZWQgdmVyc2lvbiBvZiAoMikgdGhhdCBkb2Vzbid0IGFjdHVhbGx5IGRv
IHRoZSBjb3B5DQpjYW4gYmUgaW1wbGVtZW50ZWQgZm9yIHVzZSBwcmlvciB0byByZWFkIHJlcXVl
c3RzLg0KDQpGb3IgY2FjaGUtY29oZXJlbnQgbWVtb3J5IG9ubHkgKDEpIGhhcHBlbnMgYW5kICgy
KSBhbmQgKDMpDQphcmUgbm8gb3BlcmF0aW9ucy4NCkZvciBub24tY29oZXJlbnQgbWVtb3J5ICgy
KSBpcyB3cml0ZS1iYWNrLWFuZC1pbnZhbGlkYXRlIGFuZA0KKDMpIG1pZ2h0IGp1c3QgYmUgYW4g
aW52YWxpZGF0ZS4NCkZvciBib3VuY2UgYnVmZmVycyBhbGwgYXJlIGFjdHVhbCBjb3BpZXMgLSBh
bmQgYWRkaXRpb25hbA0Kb3BlcmF0aW9ucyBtaWdodCBiZSBuZWVkZWQgZm9yIGRldmljZSBhY2Nl
c3MgdG8gdGhlIGJvdW5jZQ0KYnVmZmVyIGl0c2VsZi4NCg0KRm9yIHNlY3VyaXR5IHJlYXNvbnMg
Ym91bmNlIGJ1ZmZlcnMgbWF5IG5lZWQgaW5pdGlhbGlzaW5nLg0KQnV0IHRoaXMgd291bGQgYmUg
ZG9uZSB3aGVuIHRoZXkgYXJlIGFsbG9jYXRlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
