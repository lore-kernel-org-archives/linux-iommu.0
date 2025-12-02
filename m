Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DCC7E30FC31
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675289; cv=none; b=QhcMXQJLQVdVI8megNS8kqunyHLjsWA08g5kvKJIbZgquNRQdCIRa4kzJBtVRy6ioDLjrnDwOw3wcKFSIID7TTpjlCjQhW5s+THFOo1ju/8BRDyYNXhgpa0XvMjMn5ZaWaRoTlYGWGtJKDcubZG3ram8B1Quq525D56KgegI2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675289; c=relaxed/simple;
	bh=HGMJzs2PTvlSKpT6P8f7+CBnwvGjZVuQLGyJtCTYP4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jmICkPVKNG2Z/XzfQ9Kgqsbnh5v70pd/lNNO5cuWGCcZQHoxaO9+5QyALrD5iKe8kyIdFlS0BhnkIHL2jDSeUtni/b7MolQujYKPtYeVdhM6TJbnFf2lZjr5/812B0YX9LdGgUrDZWwthQxzo1UdTslMSco4DzajotnmsZdLieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=DF4FlaNE; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="DF4FlaNE"
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id D7261191C96A8D;
	Tue,  2 Dec 2025 19:28:30 +0800 (CST)
Received: from BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 2 Dec 2025 19:31:26 +0800
Received: from BJ02-ACTMBX-01.didichuxing.com ([fe80::3bf1:97df:b93f:7b9a]) by
 BJ02-ACTMBX-01.didichuxing.com ([fe80::3bf1:97df:b93f:7b9a%7]) with mapi id
 15.02.1748.010; Tue, 2 Dec 2025 19:31:26 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.19
From: =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To: "vasant.hegde@amd.com" <vasant.hegde@amd.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "zyhtheonly@gmail.com"
	<zyhtheonly@gmail.com>
Subject: Seeking help on AMD IOMMU unmap logic
Thread-Topic: Seeking help on AMD IOMMU unmap logic
Thread-Index: AQHcY38xL9sWGDOSgk6XxNzb3tMdug==
Date: Tue, 2 Dec 2025 11:31:26 +0000
Message-ID: <E16714B0-F380-4AA3-9F71-944C83FD7E45@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7E10BE797E2942978304BC9CB47200@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1764674913;
	bh=HGMJzs2PTvlSKpT6P8f7+CBnwvGjZVuQLGyJtCTYP4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=DF4FlaNEnDl/Gen+LV8rFs2SKCgOYPZX77ZDiB1Az2nt6g87eOzzYlMzwwIAGhRUV
	 sq5qYfGlblWeOzfqwQYbzb37IbSs9Jpd8FLtx82rrfmfw8F0ov4Sy3xnJNjhCsSyQJ
	 EkCGiVYHMw7ulTpm+wS7mGqsGVkOcrRD2SrL2mrk=

SGkgVmFzYW50LA0KICBIb3BlIGFsbCBpcyB3ZWxsIQ0KDQogIE15IG1hY2hpbmVzIGNyYXNoIGF0
ICJCVUdfT04odW5tYXBwZWQgJiYgIWlzX3Bvd2VyX29mXzIodW5tYXBwZWQpKTsiIGluIGlvbW11
X3YxX3VubWFwX3BhZ2UoKSwNCmZyb20gdm1jb3JlIEkgbGVhcm4gdGhhdCBpdCBpcyBwcm9iYWJs
eSBjYXVzZWQgYnkgYWRkaW5nIHVubWFwcGVkIHRvIGFuIHVuZXhwZWN0ZWQgdmFsdWUgYWZ0ZXIg
YSBOVUxMIHB0ZSBmb3VuZC4NCg0KICAyNTFjNGRiNjk5Y2E3Yjk2NmRiN2U1OWU4NjYzYTIzMWM5
NmJhNDU0IHNlZW1zIGZpeGVkIHRoaXMsIHdpdGggdGhlIGNvbW1pdCBtZXNzYWdlDQoiQWxzbyBp
ZiBmZXRjaF9wdGUoKSByZXR1cm5zIE5VTEwgdGhlbiByZXR1cm4gZnJvbSB1bm1hcF9tYXBhZ2Vz
KCkNCmluc3RlYWQgb2YgdHJ5aW5nIHRvIGNvbnRpbnVlIHRvIHVubWFwIHJlbWFpbmluZyBwYWdl
cy4iDQogIENvdWxkIEkgZml4IHRoZSBjcmFzaCBieSBvbmx5IGFwcGx5aW5nIHRoaXMgcGFydCAo
cmV0dXJuIHdoZW4gZmV0Y2hfcHRlKCkgcmV0dXJucyBOVUxMKSBvZiB0aGUgcGF0Y2g/DQoNCiAg
VHJhY2tpbmcgdGhlIG1haWwgbGlzdCwgSSBmaW5kDQpJbiBvcmlnaW5hbCBwYXRjaHNldCBWMiwg
dGhpcyBCVUdfT04gcmVtYWluZWQNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11
LzIwMjIwNzEzMDUzMDM0LjEyMDYxLTQtdmFzYW50LmhlZ2RlQGFtZC5jb20gPG1haWx0bzoyMDIy
MDcxMzA1MzAzNC4xMjA2MS00LXZhc2FudC5oZWdkZUBhbWQuY29tPiA8bWFpbHRvOjIwMjIwNzEz
MDUzMDM0LjEyMDYxLTQtdmFzYW50LmhlZ2RlQGFtZC5jb20gPG1haWx0bzoyMDIyMDcxMzA1MzAz
NC4xMjA2MS00LXZhc2FudC5oZWdkZUBhbWQuY29tPj4vDQogIFRoZW4gaW4gcGF0Y2hzZXQgVjMs
IHRoaXMgQlVHX09OIHJlbW92ZWQgd2l0aCAiYW5kIG1pbm9yIGZpeGVzIHRvIHVubWFwIHBhdGgu
IiBkZXNjcmliZWQgb24gc3VtbWFyeQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIw
ODI1MDYzOTM5LjgzNjAtNC12YXNhbnQuaGVnZGVAYW1kLmNvbSA8bWFpbHRvOjIwMjIwODI1MDYz
OTM5LjgzNjAtNC12YXNhbnQuaGVnZGVAYW1kLmNvbT4gPG1haWx0bzoyMDIyMDgyNTA2MzkzOS44
MzYwLTQtdmFzYW50LmhlZ2RlQGFtZC5jb20gPG1haWx0bzoyMDIyMDgyNTA2MzkzOS44MzYwLTQt
dmFzYW50LmhlZ2RlQGFtZC5jb20+Pi8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIy
MDgyNTA2MzkzOS44MzYwLTctdmFzYW50LmhlZ2RlQGFtZC5jb20gPG1haWx0bzoyMDIyMDgyNTA2
MzkzOS44MzYwLTctdmFzYW50LmhlZ2RlQGFtZC5jb20+IDxtYWlsdG86MjAyMjA4MjUwNjM5Mzku
ODM2MC03LXZhc2FudC5oZWdkZUBhbWQuY29tIDxtYWlsdG86MjAyMjA4MjUwNjM5MzkuODM2MC03
LXZhc2FudC5oZWdkZUBhbWQuY29tPj4vDQogIEknbSBhbHNvIGN1cmlvdXMgYWJvdXQgdGhlIGRl
dGFpbHMgb2Ygd2h5IHRoaXMgc2hvdWxkIGJlIGZpeGVkPyAoSSBrbm93IGxpdHRsZSBhYm91dCBJ
T01NVSwgZnJvbSBteSB1bmRlcnN0YW5kaW5nDQpJZiB3ZSBkbyBub3QgY29udGludWUgdW5tYXAg
cmVtYWluaW5nIHBhZ2VzLCB3b3VsZCBpb3ZhIHJlbWFpbnMgaW5jb25zaXN0ZW50IHdpdGggR1BB
PykNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHRpbWUhDQoNCg0KDQoNCg0KDQoNCg0K
