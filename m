Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB95660
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 13:27:39 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-4nbod_VCNS6CniD6MKxGaw-1; Wed, 12 Apr 2023 14:27:36 +0100
X-MC-Unique: 4nbod_VCNS6CniD6MKxGaw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Apr
 2023 14:27:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Apr 2023 14:27:34 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Baolu Lu' <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC: Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEHu9QGkmONo40W+xGFseOdGmq8mnrSggAA1HQCAAG80EIAAVAMAgAAVX6A=
Date: Wed, 12 Apr 2023 13:27:34 +0000
Message-ID: <d996281ed80647e0ae38cea00285f710@AcuMS.aculab.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
 <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
 <cbf041c7-119b-e23a-185d-288194629324@linux.intel.com>
In-Reply-To: <cbf041c7-119b-e23a-185d-288194629324@linux.intel.com>
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

RnJvbTogQmFvbHUgTHUNCj4gU2VudDogMTIgQXByaWwgMjAyMyAxNDoxMQ0KLi4uDQo+IFRoZSBh
ZGRyZXNzZXMgdGhlIGZvbGxvd2luZyBpc3N1ZSByZXBvcnRlZCBieSBrbG9jd29yayB0b29sOg0K
PiANCj4gICAtIG9wZXJhbmRzIG9mIGRpZmZlcmVudCBzaXplIGluIGJpdHdpc2Ugb3BlcmF0aW9u
cw0KDQpUaGVuIGZpeCB0aGUgc3R1cGlkIHRvb2wgdG8gbm90IGJlIHRoYXQgcGVkYW50aWMuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

