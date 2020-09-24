Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A8C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 02:42:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345A821D20
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 02:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345A821D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C6CDC86AA0;
	Thu, 24 Sep 2020 02:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jx6wDBst9MsM; Thu, 24 Sep 2020 02:42:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AAC1186A95;
	Thu, 24 Sep 2020 02:42:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7447DC0859;
	Thu, 24 Sep 2020 02:42:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63E0FC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 02:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3FDB327400
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 02:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gKOA6pEiVt4 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 02:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 95402204A6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 02:42:02 +0000 (UTC)
IronPort-SDR: AdjVTONlkip+KfAzyjxu7X/imkV9mskwrM3VwjbUPaUxUhvmbkDSWSz9e33wHoGOoZUDwtLMi1
 16+1Ef+iefuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="245880006"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="245880006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 19:42:01 -0700
IronPort-SDR: asylT+JbdLNXq6L0zm+GPs77pxTgYnTgoBkQW1BuBc8Pi7Q6+pWojFR9A2tsXYVeeHZ1BtbX+s
 9RGRjnVy7Jyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="413193282"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2020 19:41:59 -0700
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu api
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
 <001f4446-7c43-9832-42d8-55dc4a13c2ae@linux.intel.com>
 <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a689dd8f-5390-fd4e-ab91-5ba5549faa9c@linux.intel.com>
Date: Thu, 24 Sep 2020 10:35:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9173fed9-e60f-5189-e17d-b23bfabdaa38@linux.intel.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org
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

SGkgVHZydGtvLAoKT24gOS8xNS8yMCA0OjMxIFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPj4+
IFdpdGggdGhlIHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHNlcmllcyBJIGhpdCBhIHByb2JsZW0g
b24gSXZ5YnJpZGdlIAo+Pj4gd2hlcmUgYXBwYXJlbnRseSB0aGUgZG1hIGVuZ2luZSB3aWR0aCBp
cyBub3QgcmVzcGVjdGVkLiBBdCBsZWFzdCB0aGF0IAo+Pj4gaXMgbXkgbGF5bWFuIGludGVycHJl
dGF0aW9uIG9mIHRoZSBlcnJvcnMuIEZyb20gdGhlIG9sZGVyIHRocmVhZDoKPj4+Cj4+PiA8Mz4g
WzIwOS41MjY2MDVdIERNQVI6IGludGVsX2lvbW11X21hcDogaW9tbXUgd2lkdGggKDM5KSBpcyBu
b3QgCj4+PiBzdWZmaWNpZW50IGZvciB0aGUgbWFwcGVkIGFkZHJlc3MgKGZmZmYwMDgwMDApCj4+
Pgo+Pj4gUmVsZXZhbnQgaW9tbXUgYm9vdCByZWxhdGVkIG1lc3NhZ2VzIGFyZToKPj4+Cj4+PiA8
Nj5bwqDCoMKgIDAuMTg0MjM0XSBETUFSOiBIb3N0IGFkZHJlc3Mgd2lkdGggMzYKPj4+IDw2PlvC
oMKgwqAgMC4xODQyNDVdIERNQVI6IERSSEQgYmFzZTogMHgwMDAwMDBmZWQ5MDAwMCBmbGFnczog
MHgwCj4+PiA8Nj5bwqDCoMKgIDAuMTg0Mjg4XSBETUFSOiBkbWFyMDogcmVnX2Jhc2VfYWRkciBm
ZWQ5MDAwMCB2ZXIgMTowIGNhcCAKPj4+IGMwMDAwMDIwZTYwMjYyIGVjYXAgZjAxMDFhCj4+PiA8
Nj5bwqDCoMKgIDAuMTg0MzA4XSBETUFSOiBEUkhEIGJhc2U6IDB4MDAwMDAwZmVkOTEwMDAgZmxh
Z3M6IDB4MQo+Pj4gPDY+W8KgwqDCoCAwLjE4NDMzN10gRE1BUjogZG1hcjE6IHJlZ19iYXNlX2Fk
ZHIgZmVkOTEwMDAgdmVyIDE6MCBjYXAgCj4+PiBjOTAwODAyMDY2MDI2MiBlY2FwIGYwMTA1YQo+
Pj4gPDY+W8KgwqDCoCAwLjE4NDM1N10gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMGQ4ZDI4MDAw
IGVuZDogCj4+PiAweDAwMDAwMGQ4ZDQ2ZmZmCj4+PiA8Nj5bwqDCoMKgIDAuMTg0Mzc3XSBETUFS
OiBSTVJSIGJhc2U6IDB4MDAwMDAwZGIwMDAwMDAgZW5kOiAKPj4+IDB4MDAwMDAwZGYxZmZmZmYK
Pj4+IDw2PlvCoMKgwqAgMC4xODQzOThdIERNQVItSVI6IElPQVBJQyBpZCAyIHVuZGVyIERSSEQg
YmFzZcKgIDB4ZmVkOTEwMDAgCj4+PiBJT01NVSAxCj4+PiA8Nj5bwqDCoMKgIDAuMTg0NDE0XSBE
TUFSLUlSOiBIUEVUIGlkIDAgdW5kZXIgRFJIRCBiYXNlIDB4ZmVkOTEwMDAKPj4+IDw2PlvCoMKg
wqAgMC4xODQ0MjhdIERNQVItSVI6IFF1ZXVlZCBpbnZhbGlkYXRpb24gd2lsbCBiZSBlbmFibGVk
IHRvIAo+Pj4gc3VwcG9ydCB4MmFwaWMgYW5kIEludHItcmVtYXBwaW5nLgo+Pj4gPDY+W8KgwqDC
oCAwLjE4NTE3M10gRE1BUi1JUjogRW5hYmxlZCBJUlEgcmVtYXBwaW5nIGluIHgyYXBpYyBtb2Rl
Cj4+Pgo+Pj4gPDY+W8KgwqDCoCAwLjg3ODkzNF0gRE1BUjogTm8gQVRTUiBmb3VuZAo+Pj4gPDY+
W8KgwqDCoCAwLjg3ODk2Nl0gRE1BUjogZG1hcjA6IFVzaW5nIFF1ZXVlZCBpbnZhbGlkYXRpb24K
Pj4+IDw2PlvCoMKgwqAgMC44NzkwMDddIERNQVI6IGRtYXIxOiBVc2luZyBRdWV1ZWQgaW52YWxp
ZGF0aW9uCj4+Pgo+Pj4gPDY+W8KgwqDCoCAwLjkxNTAzMl0gRE1BUjogSW50ZWwoUikgVmlydHVh
bGl6YXRpb24gVGVjaG5vbG9neSBmb3IgCj4+PiBEaXJlY3RlZCBJL08KPj4+IDw2PlvCoMKgwqAg
MC45MTUwNjBdIFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElP
IAo+Pj4gKFNXSU9UTEIpCj4+PiA8Nj5bwqDCoMKgIDAuOTE1MDg0XSBzb2Z0d2FyZSBJTyBUTEI6
IG1hcHBlZCBbbWVtIDB4YzgwZDQwMDAtMHhjYzBkNDAwMF0gCj4+PiAoNjRNQikKPj4+Cj4+PiAo
RnVsbCBib290IGxvZyBhdCAKPj4+IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2Ry
bS10aXAvVHJ5Ym90XzcwNTQvZmktaXZiLTM3NzAvYm9vdDAudHh0LCAKPj4+IGZhaWx1cmVzIGF0
IAo+Pj4gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9Ucnlib3RfNzA1
NC9maS1pdmItMzc3MC9pZ3RAaTkxNV9zZWxmdGVzdEBsaXZlQGJsdC5odG1sLikgCj4+Pgo+Pj4K
Pj4+IERvZXMgdGhpcyBsb29rIGZhbWlsaWFyIG9yIGF0IGxlYXN0IHBsYXVzaWJsZSB0byB5b3U/
IElzIHRoaXMgCj4+PiBzb21ldGhpbmcgeW91ciBuZXcgc2VyaWVzIGhhcyBmaXhlZD8KPj4KPj4g
VGhpcyBoYXBwZW5zIGR1cmluZyBhdHRhY2hpbmcgYSBkb21haW4gdG8gZGV2aWNlLiBJdCBoYXMg
bm90aGluZyB0byBkbwo+PiB3aXRoIHRoaXMgcGF0Y2ggc2VyaWVzLiBJIHdpbGwgbG9vayBpbnRv
IHRoaXMgaXNzdWUsIGJ1dCBub3QgaW4gdGhpcwo+PiBlbWFpbCB0aHJlYWQgY29udGV4dC4KPiAK
PiBJIGFtIG5vdCBzdXJlIHdoYXQgc3RlcCBpcyBhdHRhY2hpbmcgZG9tYWluIHRvIGRldmljZSwg
YnV0IHRoZXNlIHR5cGUgCj4gbWVzc2FnZXM6Cj4gCj4gPDM+IFsyMDkuNTI2NjA1XSBETUFSOiBp
bnRlbF9pb21tdV9tYXA6IGlvbW11IHdpZHRoICgzOSkgaXMgbm90Cj4gID4+IHN1ZmZpY2llbnQg
Zm9yIHRoZSBtYXBwZWQgYWRkcmVzcyAoZmZmZjAwODAwMCkKPiAKPiBUaGV5IGRlZmluaXRlbHkg
YXBwZWFyIHRvIGhhcHBlbiBhdCBydW50aW1lLCBhcyBpOTE1IGlzIGdldHRpbmcgCj4gZXhlcmNp
c2VkIGJ5IHVzZXJzcGFjZS4KCkNhbiB5b3UgcGxlYXNlIGNoZWNrIHdoZXRoZXIgYmVsb3cgY2hh
bmdlIGhlbHBzIGhlcmU/CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCmluZGV4IGM4MzIzYTlmOGJkZS4uMDQ4NGM1
MzlkZWJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jCkBAIC03MjQsNiArNzI0LDcgQEAgc3RhdGljIGludCBk
b21haW5fdXBkYXRlX2RldmljZV9ub2RlKHN0cnVjdCAKZG1hcl9kb21haW4gKmRvbWFpbikKICAv
KiBTb21lIGNhcGFiaWxpdGllcyBtYXkgYmUgZGlmZmVyZW50IGFjcm9zcyBpb21tdXMgKi8KICBz
dGF0aWMgdm9pZCBkb21haW5fdXBkYXRlX2lvbW11X2NhcChzdHJ1Y3QgZG1hcl9kb21haW4gKmRv
bWFpbikKICB7CisgICAgICAgZG9tYWluLT5nZW9tZXRyeS5hcGVydHVyZV9lbmQgPSBfX0RPTUFJ
Tl9NQVhfQUREUihkbWFyX2RvbWFpbi0+Z2F3KTsKICAgICAgICAgZG9tYWluX3VwZGF0ZV9pb21t
dV9jb2hlcmVuY3koZG9tYWluKTsKICAgICAgICAgZG9tYWluLT5pb21tdV9zbm9vcGluZyA9IGRv
bWFpbl91cGRhdGVfaW9tbXVfc25vb3BpbmcoTlVMTCk7CiAgICAgICAgIGRvbWFpbi0+aW9tbXVf
c3VwZXJwYWdlID0gZG9tYWluX3VwZGF0ZV9pb21tdV9zdXBlcnBhZ2UoZG9tYWluLCAKTlVMTCk7
CgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
