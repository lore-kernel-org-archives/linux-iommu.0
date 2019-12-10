Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B6C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:04:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E039D20652
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E039D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96A77860AD;
	Tue, 10 Dec 2019 05:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnNXrfIJTkDf; Tue, 10 Dec 2019 05:04:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E979585F18;
	Tue, 10 Dec 2019 05:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFA17C1796;
	Tue, 10 Dec 2019 05:04:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5155CC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3AD2C20474
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6X4q0uosVPk for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 05:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 6F5E42041C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:04:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 21:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,298,1571727600"; d="scan'208";a="225020922"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 21:04:17 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <860d1f65-1fa6-577b-3dcd-f4d575a9db36@linux.intel.com>
Date: Tue, 10 Dec 2019 13:03:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210034753.wlmbqdvqpcnzfxyl@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksCgpPbiAxMi8xMC8xOSAxMTo0NyBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj4+Cj4+
PiBTbyB0aGUgZG9tYWluIHR5cGUgaXMgZG1hIGFmdGVyIDAxOjAwLjAgZ2V0cyBhZGRlZCwgYW5k
IHdoZW4KPj4+IGludGVsX2lvbW11X2FkZF9kZXZpY2UgaXMgY2FsbGVkIGZvciAwMTowMC4yIGl0
IHdpbGwgZ28gaW50byB0aGUgaWYKPj4+IHNlY3Rpb24uIFNpbmNlIHRoZSBkZXZpY2UgZGVmYXVs
dCBkb21haW4gdHlwZSBmb3IgMDE6MDAuMiBpcyBkbWEKPj4+IG5vdGhpbmcgaGFwcGVucyBpbiB0
aGVyZSwgYW5kIGl0IGdvZXMgb24gdG8gMDE6MDAuNC4gSXMgdGhlICJwcml2YXRlCj4+PiBpZGVu
dGl0eSBkb21haW4iIG1lc3NhZ2UgcmVhbGx5IGFjY3VyYXRlIHNpbmNlIGV2ZXJ5b25lIHdpbGwg
dXNlCj4+PiBzaV9kb21haW4/IEFkZGluZyBzb21lIG1vcmUgZGVidWdnaW5nLgo+Pgo+PiBUaGUg
ZmFjdHMgdGhhdCB3ZSBoYXZlIHNlZW46Cj4+Cj4+IDEpIDAxLjAwLjIgdXNlcyB0aGUgZGVmYXVs
dCBkb21haW4gaW4gZ3JvdXAgMjUuIFRoZSBkb21haW4gdHlwZSBvZiB0aGlzCj4+IMKgIGRlZmF1
bHQgZG9tYWluIGlzIERNQS4KPj4KPj4gMikgaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBw
aW5ncygpICpzaG91bGQqIGJlIGNhbGxlZCB3aGVuIGFkZGluZwo+PiDCoCAwMS4wMC4yIGludG8g
Z3JvdXAgMjUuIEFzIHRoZSByZXN1bHQsIFJNUlIgZm9yIHRoaXMgZGV2aWNlICpzaG91bGQqCj4+
IMKgIGJlIGlkZW50aXR5IG1hcHBlZC4KPj4KPj4gMykgQnkgY2hlY2tpbmcgRE1BUiB0YWJsZSwg
Uk1SUiAoMHgwMDAwMDBiZGY2ZjAwMCB+IDB4MDAwMDAwYmRmN2VmZmYpIGlzCj4+IMKgIHJlcG9y
dGVkIGZvciBkZXZpY2UgMDEuMDAuMi4KPj4KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCBSTVJSICgw
eDAwMDAwMGJkZjZmMDAwIH4gMHgwMDAwMDBiZGY3ZWZmZikgaGFzbid0Cj4+IGFjdHVhbGx5IGJl
ZW4gbWFwcGVkLCBhcyB0aGUgcmVzdWx0IElPTU1VIGZhdWx0cyBnZW5lcmF0ZWQgd2hlbiBkZXZp
Y2UKPj4gdHJ5IHRvIGFjY2VzcyB0aGlzIHJhbmdlLgo+Pgo+PiBTbyBJIGd1ZXNzIHlvdSBjb3Vs
ZCBhZGQgbW9yZSBkZWJ1ZyBtZXNzYWdlIHRvIGNoZWNrIHdoeQo+PiBpb21tdV9ncm91cF9jcmVh
dGVfZGlyZWN0X21hcHBpbmdzKCkgZG9lc24ndCBkbyB0aGUgcmlnaHQgdGhpbmc/Cj4+Cj4+IEJl
c3QgcmVnYXJkcywKPj4gYmFvbHUKPj4KPiAKPiBBIGNhbGwgdG8gaW9tbXVfbWFwIGlzIGZhaWxp
bmcuCj4gCj4gW8KgwqAgMzYuNjg2ODgxXSBwY2kgMDAwMDowMTowMC4yOiBpb21tdV9ncm91cF9h
ZGRfZGV2aWNlOiBjYWxsaW5nIAo+IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MK
PiBbwqDCoCAzNi42ODk4NDNdIHBjaSAwMDAwOjAxOjAwLjI6IGlvbW11X2dyb3VwX2NyZWF0ZV9k
aXJlY3RfbWFwcGluZ3M6IAo+IGl0ZXJhdGluZyB0aHJvdWdoIG1hcHBpbmdzCj4gW8KgwqAgMzYu
NjkyNzU3XSBwY2kgMDAwMDowMTowMC4yOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBp
bmdzOiAKPiBjYWxsaW5nIGFwcGx5X3Jlc3ZfcmVnaW9uCj4gW8KgwqAgMzYuNjk1NTI2XSBwY2kg
MDAwMDowMTowMC4yOiBlX2RpcmVjdF9tYXBwaW5nczogZW50cnkgdHlwZSBpcyBkaXJlY3QKPiBb
wqDCoCAzNy4xOTgwNTNdIGlvbW11OiBpb21tdV9tYXA6IG9wcy0+bWFwIGZhaWxlZCBpb3ZhIDB4
YmRkZGUwMDAgcGEgCj4gMHgwMDAwMDAwMGJkZGRlMDAwIHBnc2l6ZSAweDEwMDAKClNvIGNhbiB5
b3UgZnVydGhlciBjaGVjayB3aHkgaW50ZWxfaW9tbV9tYXAoKSBmYWlscyBoZXJlPwoKQmVzdCBy
ZWdhcmRzLApiYW9sdQoKPiBbwqDCoCAzNy4yMDEzNTddIHBjaSAwMDAwOjAxOjAwLjI6IGlvbW11
X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+IGlvbW11X21hcCBmYWlsZWQKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
