Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5617EA
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 07:11:29 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-UbfbuGmJMbSwt-VYwJ58OQ-1; Wed, 12 Apr 2023 08:11:26 +0100
X-MC-Unique: UbfbuGmJMbSwt-VYwJ58OQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Apr
 2023 08:11:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Apr 2023 08:11:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Baolu Lu' <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC: Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEHu9QGkmONo40W+xGFseOdGmq8mnrSggAA1HQCAAG80EA==
Date: Wed, 12 Apr 2023 07:11:24 +0000
Message-ID: <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
In-Reply-To: <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQmFvbHUgTHUNCj4gU2VudDogMTIgQXByaWwgMjAyMyAwMjozMg0KPiANCj4gT24gNC8x
Mi8yMyA1OjIyIEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+IFNlbnQ6IDExIEFwcmlsIDIw
MjMgMDc6NDgNCj4gPj4NCj4gPj4gRnJvbTogVGluYSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNv
bT4NCj4gPj4NCj4gPj4gVGhlIHBhdGNoIGZpeGVzIHRoZSBrbG9jd29yayBpc3N1ZXMgdGhhdCBv
cGVyYW5kcyBpbiBhIGJpdHdpc2Ugb3BlcmF0aW9uDQo+ID4+IGhhdmUgZGlmZmVyZW50IHNpemUg
YXQgbGluZSAxNjkyIG9mIGRtYXIuYywgbGluZSAxODk4IGFuZCBsaW5lIDE5MDcgb2YNCj4gPj4g
aW9tbXUuYy4NCj4gPiBXaHkgaXMgdGhpcyBhbnkga2luZCBvZiB0aGluZyB0aGF0IG5lZWRzIGZp
eGluZz8NCj4gDQo+IFRoaXMgZGVzY3JpcHRpb24gaXMgYSBiaXQgbWlzbGVhZGluZy4gQWN0dWFs
bHkgSSBxdWV1ZWQgaXQgYXMgYSBjbGVhbnVwDQo+IHBhdGNoLg0KDQpIb3BlZnVsbHkgd2l0aG91
dCAnZml4JyBhbnl3aGVyZSBpbiB0aGUgZGVzY3JpcHRpb24uDQpPdGhlcndpc2UgdGhlIHNjcmlw
dHMgd2lsbCBwaWNrIGl0IGZvciBhIGJhY2stcG9ydC4NCg0KPiA+IC0JCXZhbCB8PSAoMSA8PCAx
MSkgfCAxOw0KPiA+ICsJCXZhbCB8PSBCSVRfVUxMKDExKSB8IEJJVF9VTEwoMCk7DQoNCk1vcmUg
cHJvYmxlbWF0aWMgaXQgd2hhdCBpcyBiaXQgMTEgYW55d2F5Pw0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

