Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ADFC43C10A9
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180505; cv=none; b=Agq1d11slNHCji/LnGmW5qzGUGNlJnhnhIZfZXoiZK3JJ9CX7RX+xSRMkrkbP2337whmYY4mIIt9Af9sJpfZVX6djDAeB8Mnddwg9iWMqb59KDn8aA4MCABFz2gP+E9RgfssaPd2oyaNIAvFDVddgE+wh3dPH9Ig0J83pC0lpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180505; c=relaxed/simple;
	bh=Y5JVzd9Fs3QwW2vRbwMKpPMUJucGnI04Nnd+MFa49B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bPsyAcD8sNgzThdvrjQ9qoY+l2JsflAN0yqBCzGbRXf/POBmanV0YwYaPQmplW87NKh0ba3hmH5eooYqp3ZNV4QuVzet9THsqrlHWLNHBvIheAxvsGwQXaQQULPOiBvdV8Avb00T0igk6iNZG1nq8WFNMloAMO1Z5jh+Le2Ub8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=npZd1qbU; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="npZd1qbU"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.13
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW83isr/Tyrz+XSBSZTogW1BBVENIXSBpb21tdS9kbWEt?=
 =?gb2312?B?aW9tbXU6IEZpeCB3cm9uZyBzY2F0dGVybGlzdCBsZW5ndGggYXNzaWdubWVu?=
 =?gb2312?Q?t_in_P2PDMA_path?=
Thread-Topic: =?gb2312?B?tPC4tDogW83isr/Tyrz+XSBSZTogW1BBVENIXSBpb21tdS9kbWEtaW9tbXU6?=
 =?gb2312?B?IEZpeCB3cm9uZyBzY2F0dGVybGlzdCBsZW5ndGggYXNzaWdubWVudCBpbiBQ?=
 =?gb2312?Q?2PDMA_path?=
Thread-Index: AQHc8CeCWq5soguHakyPgVn1i3dxJrYpWbGAgAFzGHCAABmvAIAN5qoAgACKlnA=
Date: Thu, 11 Jun 2026 12:21:27 +0000
Message-ID: <f9d9a6b67cf84073a7dc453c277dcd9f@baidu.com>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
 <c441256c-e4f6-427f-9f25-7570c991a420@deltatee.com>
 <20260611115938.GF1066031@ziepe.ca>
In-Reply-To: <20260611115938.GF1066031@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781180492;
	bh=Y5JVzd9Fs3QwW2vRbwMKpPMUJucGnI04Nnd+MFa49B4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=npZd1qbUDg/8iMxg5hXYkf7X1oGwHIiktXkhLd6PBEOb4EOh1uhUvycemNKMVnqSB
	 DxkvFvzNuTu28l0DhWIu5a10Agek79iz7AEN0BXn6qYUuM5JYMCACBOSjZkvEBR+X3
	 3kuGfQrkh06nUGbqxirqJAW9Dme0+ug2Qi0gDQJCwvpxibSyrpcZN1C2D8vtuXdyJ3
	 hatfAzKmUYTAwo3dQQGKd4YSHUBG3ZU9pUoa1109pFYHLGHpPxJDMr1MEs6/Ca2fN5
	 rYmBwaBkpsTZIf6WRkB61WLIMajYw7x92W0FzPSBgEYDpZKZ/kPd3kz8m5+edDvdVa
	 PW20PPLQR0KIg==

DQo+ID4gSGkgTGksDQo+ID4NCj4gPiBPbiAyMDI2LTA2LTAyIDAwOjEyLCBMaSxSb25ncWluZyB3
cm90ZToNCj4gPiA+Pj4gRml4ZXM6IGEyNWU3OTYyZGIgKCJQQ0kvUDJQRE1BOiBSZWZhY3RvciB0
aGUgcDJwZG1hIG1hcHBpbmcNCj4gPiA+Pj4gaGVscGVycyIpDQo+ID4gPj4+IFNpZ25lZC1vZmYt
Ynk6IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPiA+Pg0KPiA+ID4+IEht
bSwgSSB0aG91Z2h0IEkgaGFkIHRlc3RlZCB0aGlzIHN0dWZmIHByZXR0eSB0aG9yb3VnaGx5IHNv
IEknbQ0KPiA+ID4+IHN1cnByaXNlZCBJIG1pc3NlZCB0aGF0LiBCdXQgSSBndWVzcyBzZWVpbmcg
dGhlIHVzZXJzIG9mIHRoZXNlDQo+ID4gPj4gc3BlY2lmaWNhbGx5IGRvbid0IGFsbG93IG1peGlu
ZyB3aXRoIGFub255bW91cyBtZW1vcnkgdGhlIHZhc3QNCj4gPiA+PiBtYWpvcml0eSBvZiB0ZXN0
cyB3b3VsZCBvbmx5IGhhdmUgb25lIHNlZ21lbnQuDQo+ID4gPj4NCj4gPiA+PiBDYW4geW91IGNv
bmZpcm0gdGhhdCB5b3UndmUgcmVwcm9kdWNlZCBhbmQgdGVzdGVkIHRoaXMgYW5kIGl0DQo+ID4g
Pj4gYWN0dWFsbHkgZml4ZXMgYSBidWc/IE5vdCBqdXN0IHNlZWluZyBzb21ldGhpbmcgdGhhdCBs
b29rcyBzdHJhbmdlLg0KPiA+ID4+IEkgaGF2ZSBhIHZhZ3VlIGZlZWxpbmcgaXQgd2FzIGludGVu
dGlvbmFsIGJ1dCBsb29raW5nIGF0IHRoZSBjb2RlIGl0IGxvb2tzDQo+IHdyb25nIHRvIG1lIHRv
by4NCj4gPiA+Pg0KPiA+ID4+IFRoYW5rcywNCj4gPiA+Pg0KPiA+ID4gQ2M6IENocmlzdG9waCBI
ZWxsd2lnDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KPiA+ID4NCj4g
PiA+IFRoaXMgd2FzIGZvdW5kIHZpYSBjb2RlIGluc3BlY3Rpb24uIFlvdSBhcmUgcmlnaHQgdGhh
dCBpZiBuZW50cyA9PSAxLCBvciBpZg0KPiBuZW50cyA+IDEgYnV0IGFsbCBzZWdtZW50cyBoYXBw
ZW4gdG8gaGF2ZSB0aGUgZXhhY3Qgc2FtZSBsZW5ndGgsIHRoaXMgdHlwbw0KPiByZW1haW5zIGJl
bmlnbiBieSBwdXJlIGNvaW5jaWRlbmNlLg0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIsIGZvciBhIG11
bHRpLXNlZ21lbnQgc2NhdHRlcmxpc3Qgd2l0aCB2YXJ5aW5nIGxlbmd0aHMgKGUuZy4sIGEgc2hv
cnQNCj4gMktCIGhlYWQgc2VnbWVudCBmb2xsb3dlZCBieSBzdGFuZGFyZCA0S0Igc2VnbWVudHMp
LCBzZ19kbWFfbGVuKHMpIHdpbGwNCj4gbWlzdGFrZW5seSBhc3NpZ24gdGhlIDJLQiBoZWFkIGxl
bmd0aCB0byBhbGwgc3Vic2VxdWVudCA0S0Igc2VnbWVudHMuIFRoaXMNCj4gd2lsbCBpbmV2aXRh
Ymx5IGxlYWQgdG8gc2lsZW50IGRhdGEgdHJ1bmNhdGlvbiBvciBJT01NVSBwYWdlIGZhdWx0cy4N
Cj4gPiA+DQo+ID4gPiBTaW5jZSBzZ19waHlzKHMpIGNvcnJlY3RseSB0YWtlcyB0aGUgY3VycmVu
dCBzZWdtZW50J3MgYWRkcmVzcywNCj4gc2dfZG1hX2xlbihzKSBzaG91bGQgZGVmaW5pdGVseSB1
c2Ugcy0+bGVuZ3RoIHRvIG1hdGNoIGl0Lg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgaGF2ZSBhIHNw
ZWNpZmljIFAyUERNQSB0ZXN0IHJpZyB0byBmb3JjZSBtdWx0aS1zZWdtZW50IGxpc3RzIG9uDQo+
IGhhbmQgcmlnaHQgbm93LCBidXQgdGhlIHR5cG8gYW5kIGl0cyBpbXBhY3Qgb24gdmFyaWVkIHNl
Z21lbnQgbGVuZ3RocyBzZWVtDQo+IGRldGVybWluaXN0aWMuDQo+ID4NCj4gPiBPaywgeWVhaCwg
SSB0aGluayB5b3UgYXJlIGNvcnJlY3QuIE15IHRlc3RzIHRoYXQgcmFuIG11bHRpcGxlIHNlZ21l
bnRzDQo+ID4gaGFwcGVuZWQgdG8gYWxsIGhhdmUgdGhlIHNhbWUgbGVuZ3RoLiBCdXQgSSBkb24n
dCBoYXZlIHRoZSBoYXJkd2FyZSBJDQo+ID4gdXNlZCBhdCB0aGUgbW9tZW50IHNvIEkgY2FuJ3Qg
dGVzdCBpdCBlaXRoZXIuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPg0KPiANCj4gUm9uZ3FpbmcgY2FuIHlvdSBwbGVhc2Ugc2VuZCBh
IHByb3BlciBzZXJpZXMgd2l0aCBib3RoIG9mIHRoZXNlIGZpeGVzDQo+IHdpdGhvdXQgdGhyZWFk
aW5nIHNvIEpvZXJnIGNhbiBwaWNrIHRoZW0gdXA/DQo+IA0KDQpJIHRoaW5rIHRoZXJlIGlzIG5v
IG5lZWQgdG8gcmVzZW5kLg0KDQpUaGlzIHBhdGNoIG5lZWRzIHRvIGJlIG1lcmdlZCBieSBKb2Vy
Zw0KDQpBbm90aGVyIHBhdGNoIGhhcyBhbHJlYWR5IGJlZW4gbWVyZ2VkIGludG8gdGhlIERNQSBs
aWJyYXJ5Lg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bXN6eXByb3dza2kvbGludXguZ2l0L2NvbW1pdC8/aD1kbWEtbWFwcGluZy1maXhlcyZpZD01NjAw
MDBkNjE5ZWYxNjI1Njg3NDZjZTI4N2YwYzcyNWUyNGVhOTY3DQoNCg0KW0xpLFJvbmdxaW5nXSAN
Cg0KDQo+IFRoYW5rcywNCj4gSmFzb24NCg==
