Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8E1333D47A3
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393741; cv=none; b=C+uwlWFVlZq1gT2FkyslQOMFlvUOhNt1hdwV0kjsfw+F+7Q6OxiRlbg1C/DG/xKc53gkdkGBVw4xXsKb23vYkyWddhrxE+P6/wRz+sQcaoNgLsKB2AWdIuqfoeSthwMndmVmFCinrufhifrh75dhsDKXB7kZfBDur1TkiAAq6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393741; c=relaxed/simple;
	bh=qx7LAsMT+1/8BfzDVmrovHiV8WAtJsHvCOKi5RmKS+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htljPVlX5WjE/43VTp2vj6mYPrv1BzIyQxZw8ZXfWC12xAlODEYMGTl1v7MhXUb3R+WuV2bOBzruOm1U4w8M2MBA+jeFnEg0cWWNv64uXJbnX4RhsDZ+3+ks/eTE1yiDZK6vrhI0OUJ8G+Cbwv2qVDG5Z8/PRl2te4lkb0JRnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=kgQExwlD; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="kgQExwlD"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Logan Gunthorpe <logang@deltatee.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBpb21tdS9kbWEt?=
 =?utf-8?B?aW9tbXU6IEZpeCB3cm9uZyBzY2F0dGVybGlzdCBsZW5ndGggYXNzaWdubWVu?=
 =?utf-8?Q?t_in_P2PDMA_path?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9tbXUvZG1hLWlvbW11OiBG?=
 =?utf-8?B?aXggd3Jvbmcgc2NhdHRlcmxpc3QgbGVuZ3RoIGFzc2lnbm1lbnQgaW4gUDJQ?=
 =?utf-8?Q?DMA_path?=
Thread-Index: AQHc8CeCWq5soguHakyPgVn1i3dxJrYpWbGAgAFzGHCAADutkA==
Date: Tue, 2 Jun 2026 09:48:44 +0000
Message-ID: <ceebcd436ac44548a299ed7b44cee4c8@baidu.com>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
In-Reply-To: <5e2f30a4121e4672ab309460630d011b@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780393726;
	bh=qx7LAsMT+1/8BfzDVmrovHiV8WAtJsHvCOKi5RmKS+A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=kgQExwlDR1JBUybcjHu3OclsgwW5woUSKNORymbSaxV4iKlW/ax5LKcFsgWJwX5Db
	 BZiVC7P1x7xw3CinglCXcxxGNL49AyEHix/E4ccAwBi3E26WmhOXpJcBVjYyHnLvXe
	 aTh3YlD63KX3feu11EzvJIF3YCU38CM3zvOTNMoV6bQYNdigz+QzJzD5n24ID/mP/U
	 P0tLUnjJMLtUIOoPbLubJLTkIKvL7WhARqVXrUZ62F9x6UHd6kBAR5kFLZHadE8KqX
	 /R+8b2aPbfRxCMrJJ2GQqLBgfYY9p/QdRc5or9vcFwmnTiHAabGf15YXvmtiVyKIUz
	 4Nnh5NrFaOUIg==

PiANCj4gPiBPbiAyMDI2LTA1LTMwIDA1OjI4LCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+ID4gRnJv
bTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+ID4NCj4gPiA+IEluIGlv
bW11X2RtYV9tYXBfc2coKSwgd2hlbiBoYW5kbGluZyBQQ0kgUDJQRE1BIGNhc2VzLCB0aGUgRE1B
DQo+ID4gbGVuZ3RoDQo+ID4gPiBvZiB0aGUgY3VycmVudCBzY2F0dGVybGlzdCBzZWdtZW50IGBz
YCBpcyBpbmNvcnJlY3RseSBhc3NpZ25lZCBmcm9tDQo+ID4gPiB0aGUgaGVhZCBlbnRyeSBgc2ct
Pmxlbmd0aGAgaW5zdGVhZCBvZiB0aGUgY3VycmVudCBlbnRyeSBgcy0+bGVuZ3RoYC4NCj4gPiA+
DQo+ID4gPiBUaGlzIHR5cG8gY2F1c2VzIGFsbCBQMlBETUEgc2VnbWVudHMgaW4gdGhlIHNjYXR0
ZXJsaXN0IHRvIGluaGVyaXQNCj4gPiA+IHRoZSBsZW5ndGggb2YgdGhlIGZpcnN0IHNlZ21lbnQs
IGxlYWRpbmcgdG8gY29ycnVwdGVkIERNQSBsZW5ndGhzDQo+ID4gPiBmb3INCj4gPiA+IG11bHRp
LSBzZWdtZW50IHNjYXR0ZXJsaXN0cy4NCj4gPiA+DQo+ID4gPiBGaXggdGhpcyBieSB1c2luZyBg
cy0+bGVuZ3RoYCBpbnN0ZWFkIG9mIGBzZy0+bGVuZ3RoYC4NCj4gPiA+DQo+ID4gPiBGaXhlczog
YTI1ZTc5NjJkYiAoIlBDSS9QMlBETUE6IFJlZmFjdG9yIHRoZSBwMnBkbWEgbWFwcGluZw0KPiA+
ID4gaGVscGVycyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWlu
Z0BiYWlkdS5jb20+DQo+ID4NCj4gPiBIbW0sIEkgdGhvdWdodCBJIGhhZCB0ZXN0ZWQgdGhpcyBz
dHVmZiBwcmV0dHkgdGhvcm91Z2hseSBzbyBJJ20NCj4gPiBzdXJwcmlzZWQgSSBtaXNzZWQgdGhh
dC4gQnV0IEkgZ3Vlc3Mgc2VlaW5nIHRoZSB1c2VycyBvZiB0aGVzZQ0KPiA+IHNwZWNpZmljYWxs
eSBkb24ndCBhbGxvdyBtaXhpbmcgd2l0aCBhbm9ueW1vdXMgbWVtb3J5IHRoZSB2YXN0DQo+ID4g
bWFqb3JpdHkgb2YgdGVzdHMgd291bGQgb25seSBoYXZlIG9uZSBzZWdtZW50Lg0KPiA+DQo+ID4g
Q2FuIHlvdSBjb25maXJtIHRoYXQgeW91J3ZlIHJlcHJvZHVjZWQgYW5kIHRlc3RlZCB0aGlzIGFu
ZCBpdCBhY3R1YWxseQ0KPiA+IGZpeGVzIGEgYnVnPyBOb3QganVzdCBzZWVpbmcgc29tZXRoaW5n
IHRoYXQgbG9va3Mgc3RyYW5nZS4gSSBoYXZlIGENCj4gPiB2YWd1ZSBmZWVsaW5nIGl0IHdhcyBp
bnRlbnRpb25hbCBidXQgbG9va2luZyBhdCB0aGUgY29kZSBpdCBsb29rcyB3cm9uZyB0bw0KPiBt
ZSB0b28uDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnDQo+
IA0KPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shDQo+IA0KPiBUaGlzIHdhcyBmb3VuZCB2aWEg
Y29kZSBpbnNwZWN0aW9uLiBZb3UgYXJlIHJpZ2h0IHRoYXQgaWYgbmVudHMgPT0gMSwgb3IgaWYN
Cj4gbmVudHMgPiAxIGJ1dCBhbGwgc2VnbWVudHMgaGFwcGVuIHRvIGhhdmUgdGhlIGV4YWN0IHNh
bWUgbGVuZ3RoLCB0aGlzIHR5cG8NCj4gcmVtYWlucyBiZW5pZ24gYnkgcHVyZSBjb2luY2lkZW5j
ZS4NCj4gDQo+IEhvd2V2ZXIsIGZvciBhIG11bHRpLXNlZ21lbnQgc2NhdHRlcmxpc3Qgd2l0aCB2
YXJ5aW5nIGxlbmd0aHMgKGUuZy4sIGEgc2hvcnQNCj4gMktCIGhlYWQgc2VnbWVudCBmb2xsb3dl
ZCBieSBzdGFuZGFyZCA0S0Igc2VnbWVudHMpLCBzZ19kbWFfbGVuKHMpIHdpbGwNCj4gbWlzdGFr
ZW5seSBhc3NpZ24gdGhlIDJLQiBoZWFkIGxlbmd0aCB0byBhbGwgc3Vic2VxdWVudCA0S0Igc2Vn
bWVudHMuIFRoaXMNCj4gd2lsbCBpbmV2aXRhYmx5IGxlYWQgdG8gc2lsZW50IGRhdGEgdHJ1bmNh
dGlvbiBvciBJT01NVSBwYWdlIGZhdWx0cy4NCj4gDQo+IFNpbmNlIHNnX3BoeXMocykgY29ycmVj
dGx5IHRha2VzIHRoZSBjdXJyZW50IHNlZ21lbnQncyBhZGRyZXNzLCBzZ19kbWFfbGVuKHMpDQo+
IHNob3VsZCBkZWZpbml0ZWx5IHVzZSBzLT5sZW5ndGggdG8gbWF0Y2ggaXQuDQo+IA0KPiBJIGRv
bid0IGhhdmUgYSBzcGVjaWZpYyBQMlBETUEgdGVzdCByaWcgdG8gZm9yY2UgbXVsdGktc2VnbWVu
dCBsaXN0cyBvbiBoYW5kDQo+IHJpZ2h0IG5vdywgYnV0IHRoZSB0eXBvIGFuZCBpdHMgaW1wYWN0
IG9uIHZhcmllZCBzZWdtZW50IGxlbmd0aHMgc2VlbQ0KPiBkZXRlcm1pbmlzdGljLg0KPiANCj4g
VGhhbmtzDQo+IA0KQUkgcmVwb3J0IHRoaXMgY29tbWl0IGEyNWU3OTYyZGIwZDc5ICgiUENJL1Ay
UERNQTogUmVmYWN0b3IgdGhlIHAycGRtYSBtYXBwaW5nIGhlbHBlcnMiKSBoYXMgb3RoZXIgaXNz
dWUsIHNnLT5kbWFfYWRkcmVzcyBpcyB1bmluaXRpYWxpemVkIGluIGNhc2Ugb2YgUENJX1AyUERN
QV9NQVBfVEhSVV9IT1NUX0JSSURHRSBpbiBrZXJuZWwvZG1hL2RpcmVjdC5jLCBhIHBvc3NpYmxl
IGZpeCBpcyBiZWxvdzoNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvZGlyZWN0LmMgYi9rZXJu
ZWwvZG1hL2RpcmVjdC5jDQppbmRleCA1ODNjNTkyLi40MzkxYjc5IDEwMDY0NA0KLS0tIGEva2Vy
bmVsL2RtYS9kaXJlY3QuYw0KKysrIGIva2VybmVsL2RtYS9kaXJlY3QuYw0KQEAgLTQ3Niw3ICs0
NzYsNyBAQCBpbnQgZG1hX2RpcmVjdF9tYXBfc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
c2NhdHRlcmxpc3QgKnNnbCwgaW50IG5lbnRzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICog
bXVzdCBiZSBtYXBwZWQgd2l0aCBDUFUgcGh5c2ljYWwgYWRkcmVzcyBhbmQgbm90IFBDSQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgICogYnVzIGFkZHJlc3Nlcy4NCiAgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQorICAgICAgICAgICAg
ICAgICAgICAgICBmYWxsdGhyb3VnaDsNCiAgICAgICAgICAgICAgICBjYXNlIFBDSV9QMlBETUFf
TUFQX05PTkU6DQogICAgICAgICAgICAgICAgICAgICAgICBuZWVkX3N5bmMgPSB0cnVlOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgc2ctPmRtYV9hZGRyZXNzID0gZG1hX2RpcmVjdF9tYXBfcGh5
cyhkZXYsIHNnX3BoeXMoc2cpLA0KDQoNCnRoYW5rcw0KDQpbTGksUm9uZ3FpbmddIA0K
