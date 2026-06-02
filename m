Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 111343A6F00
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380790; cv=none; b=TKk4mg8UnbBgxS80YzWZFrkOK3+C0CQSxzSUI7oj6Dr2DSxXW5nGg+Y7ia63TC0jabE2muNjvmQpJqgXcwk0suJTAc/+D2c7d9PBei39g94OLQZyfMAFEi9mBnpvJj88ZHN4f6m3NZnp0N/JTbAlhitQ9I3cmY5S8Xvo+GpbuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380790; c=relaxed/simple;
	bh=j8XkaFnC+tR0rsFSAgivf5+ys/9MUe+F5qo2sbZJ60Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSjyi2ap3k+XeTdUtAzcIJ+lrZSzvjOIvSM7lhUYB1suQtm0hoVuj6VqkTOKyaN12EifkMBtXE1M6wMOgzV/Fv/LqKFQ8+WTZS/AJsu4xA2K5PL0yyAn2qwJ8yZ/ILwQYSDx8NcCp4hVJVAa3ZeG+UrWUAquLRtiaSrGcT5W+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=XNA7Rzt5; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="XNA7Rzt5"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.12
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
Thread-Index: AQHc8CeCWq5soguHakyPgVn1i3dxJrYpWbGAgAFzGHA=
Date: Tue, 2 Jun 2026 06:12:50 +0000
Message-ID: <5e2f30a4121e4672ab309460630d011b@baidu.com>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
In-Reply-To: <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
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
	s=selector1; t=1780380775;
	bh=j8XkaFnC+tR0rsFSAgivf5+ys/9MUe+F5qo2sbZJ60Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XNA7Rzt5TvJlax3CL9sePA96jgTnVt6ShxjXDFGVqDqyuybcZHYmHdb8lM4SPT1g2
	 WS18TFOipt8B6RdqiHdAy3OdEnVE2mmmQsq1XGflDS6Ry45RXIZjuv/imMSPqO5NvI
	 KE1UALkch6izzM6p9YJS7BIS8NWarDQi0Gvw0nsVzhQFJBPVsHDwyTaW1lITLKOLwW
	 OLIllHBAOlZhMPWA7ymD94Y671RHMgF9JrQqgaCZgJ79/0TZiZfJ7FzLiLnOv9aw/H
	 KuG0Q2UKs+AhacaRH9SGh7jS+X/hmO+hlX7XuLeXYj1IuHAV3xllc/VdBMwmu3l/39
	 Ob9kOsFNBMtWQ==

DQo+IE9uIDIwMjYtMDUtMzAgMDU6MjgsIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTogTGkg
Um9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+DQo+ID4gSW4gaW9tbXVfZG1hX21h
cF9zZygpLCB3aGVuIGhhbmRsaW5nIFBDSSBQMlBETUEgY2FzZXMsIHRoZSBETUENCj4gbGVuZ3Ro
DQo+ID4gb2YgdGhlIGN1cnJlbnQgc2NhdHRlcmxpc3Qgc2VnbWVudCBgc2AgaXMgaW5jb3JyZWN0
bHkgYXNzaWduZWQgZnJvbQ0KPiA+IHRoZSBoZWFkIGVudHJ5IGBzZy0+bGVuZ3RoYCBpbnN0ZWFk
IG9mIHRoZSBjdXJyZW50IGVudHJ5IGBzLT5sZW5ndGhgLg0KPiA+DQo+ID4gVGhpcyB0eXBvIGNh
dXNlcyBhbGwgUDJQRE1BIHNlZ21lbnRzIGluIHRoZSBzY2F0dGVybGlzdCB0byBpbmhlcml0IHRo
ZQ0KPiA+IGxlbmd0aCBvZiB0aGUgZmlyc3Qgc2VnbWVudCwgbGVhZGluZyB0byBjb3JydXB0ZWQg
RE1BIGxlbmd0aHMgZm9yDQo+ID4gbXVsdGktIHNlZ21lbnQgc2NhdHRlcmxpc3RzLg0KPiA+DQo+
ID4gRml4IHRoaXMgYnkgdXNpbmcgYHMtPmxlbmd0aGAgaW5zdGVhZCBvZiBgc2ctPmxlbmd0aGAu
DQo+ID4NCj4gPiBGaXhlczogYTI1ZTc5NjJkYiAoIlBDSS9QMlBETUE6IFJlZmFjdG9yIHRoZSBw
MnBkbWEgbWFwcGluZyBoZWxwZXJzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8
bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiBIbW0sIEkgdGhvdWdodCBJIGhhZCB0ZXN0ZWQg
dGhpcyBzdHVmZiBwcmV0dHkgdGhvcm91Z2hseSBzbyBJJ20gc3VycHJpc2VkIEkNCj4gbWlzc2Vk
IHRoYXQuIEJ1dCBJIGd1ZXNzIHNlZWluZyB0aGUgdXNlcnMgb2YgdGhlc2Ugc3BlY2lmaWNhbGx5
IGRvbid0IGFsbG93DQo+IG1peGluZyB3aXRoIGFub255bW91cyBtZW1vcnkgdGhlIHZhc3QgbWFq
b3JpdHkgb2YgdGVzdHMgd291bGQgb25seSBoYXZlDQo+IG9uZSBzZWdtZW50Lg0KPiANCj4gQ2Fu
IHlvdSBjb25maXJtIHRoYXQgeW91J3ZlIHJlcHJvZHVjZWQgYW5kIHRlc3RlZCB0aGlzIGFuZCBp
dCBhY3R1YWxseSBmaXhlcyBhDQo+IGJ1Zz8gTm90IGp1c3Qgc2VlaW5nIHNvbWV0aGluZyB0aGF0
IGxvb2tzIHN0cmFuZ2UuIEkgaGF2ZSBhIHZhZ3VlIGZlZWxpbmcgaXQNCj4gd2FzIGludGVudGlv
bmFsIGJ1dCBsb29raW5nIGF0IHRoZSBjb2RlIGl0IGxvb2tzIHdyb25nIHRvIG1lIHRvby4NCj4g
DQo+IFRoYW5rcywNCj4gDQpDYzogQ2hyaXN0b3BoIEhlbGx3aWcNCg0KVGhhbmtzIGZvciB5b3Vy
IGZlZWRiYWNrIQ0KDQpUaGlzIHdhcyBmb3VuZCB2aWEgY29kZSBpbnNwZWN0aW9uLiBZb3UgYXJl
IHJpZ2h0IHRoYXQgaWYgbmVudHMgPT0gMSwgb3IgaWYgbmVudHMgPiAxIGJ1dCBhbGwgc2VnbWVu
dHMgaGFwcGVuIHRvIGhhdmUgdGhlIGV4YWN0IHNhbWUgbGVuZ3RoLCB0aGlzIHR5cG8gcmVtYWlu
cyBiZW5pZ24gYnkgcHVyZSBjb2luY2lkZW5jZS4NCg0KSG93ZXZlciwgZm9yIGEgbXVsdGktc2Vn
bWVudCBzY2F0dGVybGlzdCB3aXRoIHZhcnlpbmcgbGVuZ3RocyAoZS5nLiwgYSBzaG9ydCAyS0Ig
aGVhZCBzZWdtZW50IGZvbGxvd2VkIGJ5IHN0YW5kYXJkIDRLQiBzZWdtZW50cyksIHNnX2RtYV9s
ZW4ocykgd2lsbCBtaXN0YWtlbmx5IGFzc2lnbiB0aGUgMktCIGhlYWQgbGVuZ3RoIHRvIGFsbCBz
dWJzZXF1ZW50IDRLQiBzZWdtZW50cy4gVGhpcyB3aWxsIGluZXZpdGFibHkgbGVhZCB0byBzaWxl
bnQgZGF0YSB0cnVuY2F0aW9uIG9yIElPTU1VIHBhZ2UgZmF1bHRzLg0KDQpTaW5jZSBzZ19waHlz
KHMpIGNvcnJlY3RseSB0YWtlcyB0aGUgY3VycmVudCBzZWdtZW50J3MgYWRkcmVzcywgc2dfZG1h
X2xlbihzKSBzaG91bGQgZGVmaW5pdGVseSB1c2Ugcy0+bGVuZ3RoIHRvIG1hdGNoIGl0Lg0KDQpJ
IGRvbid0IGhhdmUgYSBzcGVjaWZpYyBQMlBETUEgdGVzdCByaWcgdG8gZm9yY2UgbXVsdGktc2Vn
bWVudCBsaXN0cyBvbiBoYW5kIHJpZ2h0IG5vdywgYnV0IHRoZSB0eXBvIGFuZCBpdHMgaW1wYWN0
IG9uIHZhcmllZCBzZWdtZW50IGxlbmd0aHMgc2VlbSBkZXRlcm1pbmlzdGljLg0KDQpUaGFua3MN
Cg0KW0xpLFJvbmdxaW5nXSANCg0KPiBMb2dhbg0KDQo=
