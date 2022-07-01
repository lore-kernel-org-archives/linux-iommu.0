Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94040C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 111E960FD1;
	Fri,  1 Jul 2022 07:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 111E960FD1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UnFL8spe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6oGsOYQQvTq0; Fri,  1 Jul 2022 07:19:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5DC760B5A;
	Fri,  1 Jul 2022 07:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5DC760B5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96B9EC0071;
	Fri,  1 Jul 2022 07:19:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 282D4C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F065A60FBF
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F065A60FBF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvEbGEsbGN85 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:19:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2936C60B5A
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2936C60B5A
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656659962; x=1688195962;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f2LF3fbG7J5Wrn29s+XWM8ikKjq+11FqN+GTp4OI9WM=;
 b=UnFL8speaaok+35D/VwQdRPpArxFNZRpQEP/4eBap9akU6cGxcNx96mk
 S5/LXUOlHGZ9zRjDb1QABXGqYzb4D8ZmXFpt+kMW9/QxoB36kVd+XRm4G
 uQwjOxs4OvLqLNzFBTYV2+SVZz99NWhnTHLt9iZjfIPdZmBdQtkRW053Y
 thkWGHd8pCJ3eIxc8Pn9Loq2UMqynxjuyTAchZwzD2lXklfxRRJhWAZy+
 tIJGxLo9OdObtXSu7OIz8UiovGFb+fksNCgFKpsa2kgKEWIWBIcFKAek/
 H96Tf+Xffv2jiPK7MnZDdjCnbuWaOWzW3cwm3NKTvo1LeM3h1MgccJZEa A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346563600"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="346563600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 00:19:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="596143082"
Received: from pchai-mobl.ccr.corp.intel.com (HELO [10.249.171.241])
 ([10.249.171.241])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 00:19:16 -0700
Message-ID: <ffca1789-1e96-ae01-74a0-942fecb9caac@linux.intel.com>
Date: Fri, 1 Jul 2022 15:19:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Fix suspicious RCU usage in
 probe_acpi_namespace_devices()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
 <20190612002851.17103-6-baolu.lu@linux.intel.com>
 <f3619c80-14d3-d934-755a-4c3734bfde20@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f3619c80-14d3-d934-755a-4c3734bfde20@arm.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, cai@lca.pw, jacob.jun.pan@intel.com
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

T24gMjAyMi82LzI5IDIxOjAzLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAxOS0wNi0xMiAw
MToyOCwgTHUgQmFvbHUgd3JvdGU6Cj4+IFRoZSBkcmhkIGFuZCBkZXZpY2Ugc2NvcGUgbGlzdCBz
aG91bGQgYmUgaXRlcmF0ZWQgd2l0aCB0aGUKPj4gaW9tbXUgZ2xvYmFsIGxvY2sgaGVsZC4gT3Ro
ZXJ3aXNlLCBhIHN1c3BpY2lvdXMgUkNVIHVzYWdlCj4+IG1lc3NhZ2Ugd2lsbCBiZSBkaXNwbGF5
ZWQuCj4+Cj4+IFvCoMKgwqAgMy42OTU4ODZdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Cj4+IFvCoMKgwqAgMy42OTU5MTddIFdBUk5JTkc6IHN1c3BpY2lvdXMgUkNVIHVzYWdlCj4+IFvC
oMKgwqAgMy42OTU5NTBdIDUuMi4wLXJjMisgIzI0NjcgTm90IHRhaW50ZWQKPj4gW8KgwqDCoCAz
LjY5NTk4MV0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gW8KgwqDCoCAzLjY5NjAx
NF0gZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jOjQ1Njkgc3VzcGljaW91cyAKPj4gcmN1X2Rl
cmVmZXJlbmNlX2NoZWNrKCkgdXNhZ2UhCj4+IFvCoMKgwqAgMy42OTYwNjldCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1
ZyB0aGlzOgo+Pgo+PiBbwqDCoMKgIDMuNjk2MTI2XQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmN1X3NjaGVkdWxlcl9hY3RpdmUgPSAyLCBkZWJ1Z19sb2NrcyA9IDEKPj4gW8Kg
wqDCoCAzLjY5NjE3M10gbm8gbG9ja3MgaGVsZCBieSBzd2FwcGVyLzAvMS4KPj4gW8KgwqDCoCAz
LjY5NjIwNF0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YWNrIGJhY2t0cmFj
ZToKPj4gW8KgwqDCoCAzLjY5NjI0MV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90
IHRhaW50ZWQgNS4yLjAtcmMyKyAjMjQ2Nwo+PiBbwqDCoMKgIDMuNjk2MzcwXSBDYWxsIFRyYWNl
Ogo+PiBbwqDCoMKgIDMuNjk2NDA0XcKgIGR1bXBfc3RhY2srMHg4NS8weGNiCj4+IFvCoMKgwqAg
My42OTY0NDFdwqAgaW50ZWxfaW9tbXVfaW5pdCsweDEyOGMvMHgxM2NlCj4+IFvCoMKgwqAgMy42
OTY0NzhdwqAgPyBrbWVtX2NhY2hlX2ZyZWUrMHgxNmIvMHgyYzAKPj4gW8KgwqDCoCAzLjY5NjUx
Nl3CoCA/IF9fZnB1dCsweDE0Yi8weDI3MAo+PiBbwqDCoMKgIDMuNjk2NTUwXcKgID8gX19jYWxs
X3JjdSsweGI3LzB4MzAwCj4+IFvCoMKgwqAgMy42OTY1ODNdwqAgPyBnZXRfbWF4X2ZpbGVzKzB4
MTAvMHgxMAo+PiBbwqDCoMKgIDMuNjk2NjMxXcKgID8gc2V0X2RlYnVnX3JvZGF0YSsweDExLzB4
MTEKPj4gW8KgwqDCoCAzLjY5NjY2OF3CoCA/IGU4MjBfX21lbWJsb2NrX3NldHVwKzB4NjAvMHg2
MAo+PiBbwqDCoMKgIDMuNjk2NzA0XcKgID8gcGNpX2lvbW11X2luaXQrMHgxNi8weDNmCj4+IFvC
oMKgwqAgMy42OTY3MzddwqAgPyBzZXRfZGVidWdfcm9kYXRhKzB4MTEvMHgxMQo+PiBbwqDCoMKg
IDMuNjk2NzcwXcKgIHBjaV9pb21tdV9pbml0KzB4MTYvMHgzZgo+PiBbwqDCoMKgIDMuNjk2ODA1
XcKgIGRvX29uZV9pbml0Y2FsbCsweDVkLzB4MmU0Cj4+IFvCoMKgwqAgMy42OTY4NDRdwqAgPyBz
ZXRfZGVidWdfcm9kYXRhKzB4MTEvMHgxMQo+PiBbwqDCoMKgIDMuNjk2ODgwXcKgID8gcmN1X3Jl
YWRfbG9ja19zY2hlZF9oZWxkKzB4NmIvMHg4MAo+PiBbwqDCoMKgIDMuNjk2OTI0XcKgIGtlcm5l
bF9pbml0X2ZyZWVhYmxlKzB4MWYwLzB4MjdjCj4+IFvCoMKgwqAgMy42OTY5NjFdwqAgPyByZXN0
X2luaXQrMHgyNjAvMHgyNjAKPj4gW8KgwqDCoCAzLjY5Njk5N13CoCBrZXJuZWxfaW5pdCsweGEv
MHgxMTAKPj4gW8KgwqDCoCAzLjY5NzAyOF3CoCByZXRfZnJvbV9mb3JrKzB4M2EvMHg1MAo+Pgo+
PiBGaXhlczogZmEyMTJhOTdmM2EzNiAoImlvbW11L3Z0LWQ6IFByb2JlIERNQS1jYXBhYmxlIEFD
UEkgbmFtZSBzcGFjZSAKPj4gZGV2aWNlcyIpCj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2ludGVs
LWlvbW11LmMgfCAyICsrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwtaW9tbXUuYwo+PiBpbmRleCAxOWM0YzM4N2EzZjYuLjg0ZTY1MGM2YTQ2ZCAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwtaW9tbXUuYwo+PiBAQCAtNDc5Myw4ICs0NzkzLDEwIEBAIGludCBfX2luaXQg
aW50ZWxfaW9tbXVfaW5pdCh2b2lkKQo+PiDCoMKgwqDCoMKgIGNwdWhwX3NldHVwX3N0YXRlKENQ
VUhQX0lPTU1VX0lOVEVMX0RFQUQsICJpb21tdS9pbnRlbDpkZWFkIiwgTlVMTCwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVsX2lvbW11X2NwdV9kZWFkKTsKPj4gK8KgwqDC
oCBkb3duX3JlYWQoJmRtYXJfZ2xvYmFsX2xvY2spOwo+PiDCoMKgwqDCoMKgIGlmIChwcm9iZV9h
Y3BpX25hbWVzcGFjZV9kZXZpY2VzKCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJB
Q1BJIG5hbWUgc3BhY2UgZGV2aWNlcyBkaWRuJ3QgcHJvYmUgY29ycmVjdGx5XG4iKTsKPj4gK8Kg
wqDCoCB1cF9yZWFkKCZkbWFyX2dsb2JhbF9sb2NrKTsKPiAKPiBEb2luZyBhIGJpdCBvZiBhcmNo
YWVvbG9neSBoZXJlLCBpcyB0aGlzIGFjdHVhbGx5IGJyb2tlbj8gSWYgYW55IEFOREQgCj4gZW50
cmllcyBleGlzdCwgd2UnZCBlbmQgdXAgZG9pbmc6Cj4gCj4gIMKgIGRvd25fcmVhZCgmZG1hcl9n
bG9iYWxfbG9jaykKPiAgwqAgcHJvYmVfYWNwaV9uYW1lc3BhY2VfZGV2aWNlcygpCj4gIMKgIC0+
IGlvbW11X3Byb2JlX2RldmljZSgpCj4gIMKgwqDCoMKgIC0+IGlvbW11X2NyZWF0ZV9kZXZpY2Vf
ZGlyZWN0X21hcHBpbmdzKCkKPiAgwqDCoMKgwqDCoMKgwqAgLT4gaW9tbXVfZ2V0X3Jlc3ZfcmVn
aW9ucygpCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0+IGludGVsX2lvbW11X2dldF9yZXN2X3Jl
Z2lvbnMoKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtPiBkb3duX3JlYWQoJmRtYXJf
Z2xvYmFsX2xvY2spCj4gCj4gSSdtIHdvbmRlcmluZyB3aGV0aGVyIHRoaXMgbWlnaHQgZXhwbGFp
biB3aHkgbXkgYnVzX3NldF9pb21tdSBzZXJpZXMgCj4gcHJldmVudGVkIEJhb2x1J3MgbWFjaGlu
ZSBmcm9tIGJvb3RpbmcsIHNpbmNlICJpb21tdTogTW92ZSBidXMgc2V0dXAgdG8gCj4gSU9NTVUg
ZGV2aWNlIHJlZ2lzdHJhdGlvbiIgY3JlYXRlcyB0aGUgc2FtZSBjb25kaXRpb24gd2hlcmUgd2Ug
ZW5kIHVwIGluIAo+IGdldF9yZXN2X3JlZ2lvbnMgKHZpYSBidXNfaW9tbXVfcHJvYmUoKSB0aGlz
IHRpbWUpIGZyb20gdGhlIHNhbWUgdGFzayAKPiB0aGF0IGFscmVhZHkgaG9sZHMgZG1hcl9nbG9i
YWxfbG9jay4gT2YgY291cnNlIHRoYXQgbGVhdmVzIG1lIHdvbmRlcmluZyAKPiBob3cgaXQgKmRp
ZCogbWFuYWdlIHRvIGJvb3QgT0sgb24gbXkgWGVvbiBib3gsIGJ1dCBtYXliZSB0aGVyZSdzIGEg
Cj4gY29uZmlnIGRpZmZlcmVuY2Ugb3IgZHVtYiBsdWNrIGF0IHBsYXk/CgpUaGlzIGlzIHJlYWxs
eSBwcm9ibGVtYXRpYy4gV2hlcmUgZG9lcyB0aGUgbGF0ZXN0IGJ1c19zZXRfaW9tbXUgc2VyaWVz
CmxvY2F0ZT8gSSdkIGxpa2UgdG8gdGFrZSBhIGNsb3NlciBsb29rIGF0IHdoYXQgaGFwcGVuZWQg
aGVyZS4gUGVyaGFwcwp0d28gd2Vla3MgbGF0ZXI/IEknbSBidXN5IHdpdGggcHJlcGFyaW5nIElu
dGVsIElPTU1VIHBhdGNoZXMgZm9yIHY1LjIwCnRoZXNlIGRheXMuCgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
