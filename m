Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829E25776
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082905; cv=none; b=Ke8CNcH6J8+4HEaI7NWQhNln9zqXg/1vD98OVZ6QwJu8IH/azONs6HH8QqM8RpfQpIMM3FHbhGGtPQUKikFIAIXdt/+2naY8xCN3JWiKYtsn3gdY4Hvo//omQoqXmS0Lmap0Bny8rYiAQEgaujCIpMZfYZvtCCLv+jvPFL6KR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082905; c=relaxed/simple;
	bh=N+wdbgo0cJW/eGTvVFXKGpds42oOMJMCxVmoGGqy3n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hnsHNwhJwzc0N3o1vXKuRKhMFwCEYStBvb0K+/Vkovsuy8M1xNIWhK2xv3S42U7RRR8cZbAW3qL4lxDsESRMRl6VNAzL+uPOu2i+6bH9X8ozQHrD8fFpvjSktnyoVmcrlQSIXKb2JQoaz4x0Obn/JFaJXxyv0UhlceMjsiKmLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X+XjMhRr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X+XjMhRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=N+wdbgo0cJW/eGTvVFXKGpds42oOMJMCxVmoGGqy3n8=; b=X
	+XjMhRrfKG9cmoG9KHJ/zD+Uk/c4ePDeFeEBmbLjPWrsueVM0xbHioK4ZuPRaSkc
	Emmg2g3A6zKhW+eUoJ1WNnZ1fuqkwDQkR6OsjeY4OA8L69sIt8IWG7epammliR9h
	6vsR9LwynAWtbgsOjekorYfcEIJwg4RXj/jnG1//mI=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Wed, 15 Jul 2026 10:34:41 +0800
 (CST)
Date: Wed, 15 Jul 2026 10:34:41 +0800 (CST)
From: "Xiong Weimin" <15927021679@163.com>
To: "Ankit Soni" <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re:Re: [PATCH] iommu/amd: Use device max PRI outstanding requests
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <orrfv3ikdiyebm6zpb23xqvawnmoc4jpc5leeliwfmdm64rxhe@ma3wf7vutd66>
References: <20260714020250.175808-1-15927021679@163.com>
 <orrfv3ikdiyebm6zpb23xqvawnmoc4jpc5leeliwfmdm64rxhe@ma3wf7vutd66>
X-NTES-SC: AL_Qu2TBvyTvUAj5yWfZOkckk8Ugeg8Xsewsvgh249ec/0Esgvg4D4seGJsM3f1+tCEMxC8tT+ufDlxw99fcYZknxmV/Chr2Tc9acje0szMXA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <7a8c2306.20ed.19f63a05c2b.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgD3t93B8VZqTj0eAA--.14167W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QHcZWpW8cEc2gAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBBbmtpdCwKCgpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4KCgpJIG92ZXJsb29rZWQg
dGhhdCB0aGUgUFBSIGxvZyBpcyBhIHNoYXJlZCBJT01NVS13aWRlIHJlc291cmNlCndpdGggbGlt
aXRlZCBkZXB0aCwgd2hpbGUgfjBVIHdvdWxkIGVuYWJsZSBlYWNoIGRldmljZSB1cCB0byBpdHMK
ZnVsbCBhZHZlcnRpc2VkIFBSSSBjYXBhY2l0eS4gVGhhdCBjYW4gY2xlYXJseSBvdmVyc3Vic2Ny
aWJlIHRoZQpsb2cuCgoKSSB3aWxsIGRyb3AgdGhpcyBjaGFuZ2UgYXMgcHJvcG9zZWQgYW5kIHdp
bGwgbm90IHNlbmQgYSB2MiB0aGF0CnNpbXBseSBzd2l0Y2hlcyAzMiB0byB+MFUuCgoKSWYgdGhl
cmUgaXMgYSBwcmVmZXJyZWQgcG9saWN5IGxhdGVyIChlLmcuIGEgYm91bmRlZCBkZXJpdmF0aW9u
CmZyb20gUFBSIGxvZyBkZXB0aCAvIG51bWJlciBvZiBQUkkgZGV2aWNlcyksIEkgYW0gaGFwcHkg
dG8gZm9sbG93CnRoYXQgZ3VpZGFuY2UuCgoKVGhhbmtzLApXZWltaW4KCkF0IDIwMjYtMDctMTQg
MjA6MDc6NDMsICJBbmtpdCBTb25pIiA8QW5raXQuU29uaUBhbWQuY29tPiB3cm90ZToKPk9uIFR1
ZSwgSnVsIDE0LCAyMDI2IGF0IDEwOjAyOjUwQU0gKzA4MDAsIHdlaW1pbiB4aW9uZyB3cm90ZToK
Pj4gRnJvbTogeGlvbmd3ZWltaW4gPHhpb25nd2VpbWluQGt5bGlub3MuY24+Cj4+IAo+PiBwY2lf
ZW5hYmxlX3ByaSgpIGFscmVhZHkgY2xhbXBzIHRoZSByZXF1ZXN0ZWQgb3V0c3RhbmRpbmcgY291
bnQgdG8gdGhlCj4+IGRldmljZSBQQ0lfUFJJX01BWF9SRVEgdmFsdWUuIFBhc3NpbmcgYSBoYXJk
Y29kZWQgMzIgdW5kZXItdXRpbGl6ZXMKPj4gY2FwYWJsZSBkZXZpY2VzIGFuZCBjYW4gb3ZlcnN1
YnNjcmliZSB3ZWFrZXIgb25lcy4KPj4gCj4+IFBhc3MgfjBVIHNvIHRoZSBhbGxvY2F0ZWQgcmVx
dWVzdCBjb3VudCBtYXRjaGVzIHdoYXQgdGhlIGRldmljZQo+PiBhZHZlcnRpc2VzLgo+PiAKPj4g
U2lnbmVkLW9mZi1ieTogeGlvbmd3ZWltaW4gPHhpb25nd2VpbWluQGt5bGlub3MuY24+Cj4+IC0t
LQo+PiAgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyB8IDYgKysrLS0tCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jCj4+
IGluZGV4IDU2M2Y5YzI2Ny4uZTFlYzVlZTc2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2FtZC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMKPj4gQEAgLTYw
MiwxMCArNjAyLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHBkZXZfZW5hYmxlX2NhcF9wcmkoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYpCj4+ICAKPj4gIAlpZiAoZGV2X2RhdGEtPmZsYWdzICYgQU1EX0lP
TU1VX0RFVklDRV9GTEFHX1BSSV9TVVApIHsKPj4gIAkJLyoKPj4gLQkJICogRmlyc3QgcmVzZXQg
dGhlIFBSSSBzdGF0ZSBvZiB0aGUgZGV2aWNlLgo+PiAtCQkgKiBGSVhNRTogSGFyZGNvZGUgbnVt
YmVyIG9mIG91dHN0YW5kaW5nIHJlcXVlc3RzIGZvciBub3cKPj4gKwkJICogUmVzZXQgUFJJIHRo
ZW4gZW5hYmxlIHdpdGggdGhlIGRldmljZS1hZHZlcnRpc2VkIG1heGltdW0uCj4+ICsJCSAqIHBj
aV9lbmFibGVfcHJpKCkgY2xhbXBzIEByZXFzIHRvIFBDSV9QUklfTUFYX1JFUS4KPj4gIAkJICov
Cj4KPkhpLAo+Cj5JIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBnb29kIGlkZWEuCj4KPlRoZSBvdXRz
dGFuZGluZy1yZXF1ZXN0IGFsbG9jYXRpb24gaXMgYSBwZXItZGV2aWNlIGNhcCwgYnV0IHRoZSBQ
UFIgbG9nIGlzIGEKPnNpbmdsZSBidWZmZXIgc2hhcmVkIGJ5IGFsbCBkZXZpY2VzIGJlaGluZCB0
aGUgSU9NTVUgKDUxMiBlbnRyaWVzIGJ5IGRlZmF1bHQpLgo+fjBVIGdyYW50cyBldmVyeSBkZXZp
Y2UgaXRzIGZ1bGwgYWR2ZXJ0aXNlZCBjYXBhY2l0eSAocG90ZW50aWFsbHkgaHVuZHJlZHMgCj5v
ciB0aG91c2FuZHMpLCBzbyBhIGZldyBQUkktY2FwYWJsZSBkZXZpY2VzIGNhbiBjb2xsZWN0aXZl
bHkgZmFyIGV4Y2VlZCB0aGUgCj5sb2cgZGVwdGggYW5kIHJlbHkgZW50aXJlbHkgb24gdGhlIG9w
dGlvbmFsIG92ZXJmbG93IGhhbmRsaW5nIHRvIHN0YXkgY29ycmVjdC4KPgo+LUFua2l0Cj4KPj4g
LQkJaWYgKCFwY2lfcmVzZXRfcHJpKHBkZXYpICYmICFwY2lfZW5hYmxlX3ByaShwZGV2LCAzMikp
IHsKPj4gKwkJaWYgKCFwY2lfcmVzZXRfcHJpKHBkZXYpICYmICFwY2lfZW5hYmxlX3ByaShwZGV2
LCB+MFUpKSB7Cj4+ICAJCQlkZXZfZGF0YS0+cHJpX2VuYWJsZWQgPSAxOwo+PiAgCQkJZGV2X2Rh
dGEtPnByaV90bHAgICAgID0gcGNpX3ByZ19yZXNwX3Bhc2lkX3JlcXVpcmVkKHBkZXYpOwo+PiAg
Cj4+IC0tIAo+PiAyLjQzLjAKPj4gCj4+IAo+PiBObyB2aXJ1cyBmb3VuZAo+PiAJCUNoZWNrZWQg
YnkgSGlsbHN0b25lIE5ldHdvcmsgQW50aVZpcnVzCj4+IAo=
