Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D8270560;
	Fri,  9 May 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776895; cv=none; b=lVQI4tfpSMxnBy9byi0OhgqGA7LEtYvXJsJykqGjG6WKEE3dW4y+Dv73p299eRPDU/F5P+LTokpzdNuXukaO/QJggfPZ5VxuuZUn2sLDfT4nWsBLnXcgT+KWjddlHc2Wxw/DGd4wMEe6yNFhDJqimvoHYLZFhwvigU+m++clrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776895; c=relaxed/simple;
	bh=6Bb1bCIHUhcZpksKyLvuXWjp5mJsajaLw4Ijf+x0huU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McOTW9vynJRsdXQZp+P1s9DIudtaRgHIw4cgIIjPNlXyuuA3uDyKJLi7214su2gqzDzw00KEFt/51skoXsMSUz0KAiCFw4lf6v5OBbsCKXERCml2h9zQFQfd/OlZzQBZTD61be3v6NvRRH5w/BktICD3UAcFYGMPi5bTmyp9JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 09:48:04 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Fri, 9 May 2025 09:48:04 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Stefano Stabellini <sstabellini@kernel.org>, Christoph Hellwig
	<hch@infradead.org>
CC: Juergen Gross <jgross@suse.com>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Topic: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Index: AQHbu1cR+sKkXAZoXEOAUfrcrER157O/dMAAgAX2O4CAAkbqgIAAVVAAgAE+k4CAAI9lgA==
Date: Fri, 9 May 2025 07:48:03 +0000
Message-ID: <df9da8af-3a10-4f8b-8e4a-63e4ba473e17@actia.se>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
 <20250502114043.1968976-3-john.ernberg@actia.se>
 <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop>
 <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
 <alpine.DEB.2.22.394.2505071602570.3879245@ubuntu-linux-20-04-desktop>
 <aBwvrLKD_VJapYkB@infradead.org>
 <alpine.DEB.2.22.394.2505081614450.3879245@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2505081614450.3879245@ubuntu-linux-20-04-desktop>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B14453667D66
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE583C0E761E94898DF9F230B77BD62@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

SGkgU3RlZmFubywNCg0KT24gNS85LzI1IDE6MTQgQU0sIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90
ZToNCj4gT24gV2VkLCA3IE1heSAyMDI1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9u
IFdlZCwgTWF5IDA3LCAyMDI1IGF0IDA0OjA5OjE1UE0gLTA3MDAsIFN0ZWZhbm8gU3RhYmVsbGlu
aSB3cm90ZToNCj4+Pj4gVGhpcyBtYXBwaW5nIGlzIG5vdCBmb3IgYSBSQU0gYmFja2VkIGFkZHJl
c3MuIEluIHRoZSBlRE1BIGNhc2UgZm9yIHRoZQ0KPj4+PiBpTVg4UVhQIHRoZSBgcGh5c2AgY29t
aW5nIGluIGhlcmUgaXMgdGhlIGFkZHJlc3Mgb2YgYSByZWdpc3Rlci4NCj4+Pg0KPj4+IE9rLCB0
aGlzIGluZm9ybWF0aW9uIGlzIGltcG9ydGFudCA6LSkNCj4+Pg0KPj4+IEkgYW0gbm90IGNlcnRh
aW4gd2hldGhlciB0aGUgbWFwX3Jlc291cmNlIGludGVyZmFjZSBjYW4gb25seSBiZSBjYWxsZWQN
Cj4+PiBmb3IgTU1JTyBhZGRyZXNzZXMgb3IgaWYgaXQgY2FuIGFsc28gYmUgY2FsbGVkIGZvciBS
QU0tYmFja2VkIGFkZHJlc3Nlcw0KPj4+IHdpdGggYSBzaXplID4gUEFHRV9TSVpFLiBJbiB0aGUg
bGF0dGVyIGNhc2UsIHdlIGNvdWxkIHJ1biBpbnRvIHRoZSBpc3N1ZQ0KPj4+IEkgd2FzIGRlc2Ny
aWJpbmcuDQo+Pg0KPj4gbWFwX3Jlc291cmNlIGlzIGludGVuZGVkIGZvciBNTUlPIHJlZ2lvbnMs
IGFsdGhvdWdoIHRob3NlIGNvdWxkIGJlID4NCj4+IFBBR0VfU0laRS4gIEl0IG11c3Qgbm90IGJl
IGNhbGxlZCBvbiBSQU0uDQo+IA0KPiBJbiB0aGF0IGNhc2UsIEpvaG4sIHlvdSBjYW4ganVzdCB1
c2UgZG1hX2RpcmVjdF9tYXBfcmVzb3VyY2UoKS4NCj4gDQo+IFRoYXQncyBiZWNhdXNlIE1NSU8g
cmVnaW9uczoNCj4gLSBhcmUgMToxIG1hcHBlZCBvbiBBUk0NCj4gLSBhcmUgMToxIG1hcHBlZCBv
biB4ODYgZm9yIFBWIERvbTANCj4gLSBtaWdodCBub3QgYmUgMToxIG1hcHBlZCBvbiB4ODYgZm9y
IFBWSCBEb20wLCBidXQgaW4gdGhpcyBjYXNlIHdlIHJlbHkNCj4gICAgb24gdGhlIElPTU1VIHRv
IGRvIGFkZHJlc3MgdHJhbnNsYXRpb24NCj4gDQo+IEluIG5vbmUgb2YgdGhlc2UgY2FzZXMgeGVu
X3BoeXNfdG9fZG1hIHdvdWxkIGdpdmUgdXMgYW55IGludGVyZXN0aW5nDQo+IHJlc3VsdHMuICBJ
dCB3b3VsZCBiZSB0aGUgc2FtZSBhcyBjYWxsaW5nIHBoeXNfdG9fZG1hLg0KDQpUaGFuayB5b3Ug
Zm9yIGV4cGxhaW5pbmcuIEkgd2lsbCBzcGluIGEgVjIgaW5jb3Jwb3JhdGluZyB0aGlzLg0KVGhh
bmtzISAvLyBKb2huIEVybmJlcmcNCg==
