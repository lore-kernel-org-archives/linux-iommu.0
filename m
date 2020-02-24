Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5627FC35679
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:13:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220D320658
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E290E86252;
	Mon, 24 Feb 2020 08:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UdWnCaSarKN3; Mon, 24 Feb 2020 08:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E20BE860BE;
	Mon, 24 Feb 2020 08:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5E0CC18DA;
	Mon, 24 Feb 2020 08:12:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9712DC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D5B1860BF
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkpsS4FHixlq for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 08:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF877860BE
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:12:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 00:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="255507683"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 00:12:46 -0800
Subject: Re: [PATCH V2 3/5] iommu: Add support to change default domain of an
 iommu_group
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
 <b8b5ac1f-b736-531d-a621-030ec8e3e7b1@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F572177EC@ORSMSX114.amr.corp.intel.com>
 <4a92bc90-735f-8dbf-1a7c-7bc58563f75f@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F5721A118@ORSMSX114.amr.corp.intel.com>
 <d5138046-b613-b070-2af8-4a9a519ca42a@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F5721AB7A@ORSMSX114.amr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <17eae788-1ed7-a24b-339e-4800496f9542@linux.intel.com>
Date: Mon, 24 Feb 2020 16:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F5721AB7A@ORSMSX114.amr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

T24gMjAyMC8yLzI0IDE1OjU3LCBQcmFraHlhLCBTYWkgUHJhbmVldGggd3JvdGU6Cj4+IE9uIDIw
MjAvMi8yNCAxNTowMywgUHJha2h5YSwgU2FpIFByYW5lZXRoIHdyb3RlOgo+Pj4+IE9uIDIwMjAv
Mi8yNCAxMToyMCwgUHJha2h5YSwgU2FpIFByYW5lZXRoIHdyb3RlOgo+Pj4+Pj4+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZlKGdycF9kZXYsIHRlbXAsICZncm91cC0+ZGV2aWNlcywgbGlzdCkg
ewo+Pj4+Pj4+ICsJCXN0cnVjdCBkZXZpY2UgKmRldjsKPj4+Pj4+PiArCj4+Pj4+Pj4gKwkJZGV2
ID0gZ3JwX2Rldi0+ZGV2Owo+Pj4+Pj4+ICsJCWlvbW11X3JlbGVhc2VfZGV2aWNlKGRldik7Cj4+
Pj4+Pj4gKwo+Pj4+Pj4+ICsJCXJldCA9IGlvbW11X2dyb3VwX2FkZF9kZXZpY2UoZ3JvdXAsIGRl
dik7Cj4+Pj4+Pj4gKwkJaWYgKHJldCkKPj4+Pj4+PiArCQkJZGV2X2VycihkZXYsICJGYWlsZWQg
dG8gYWRkIHRvIGlvbW11IGdyb3VwICVkOiAlZFxuIiwKPj4+Pj4+PiArCQkJCWdyb3VwLT5pZCwg
cmV0KTsKPj4+Pj4+IE5lZWQgdG8gaGFuZGxlIHRoaXMgZXJyb3IgY2FzZS4KPj4+Pj4gSSB3YXNu
J3Qgc3VyZSBvbiBob3cgdG8gaGFuZGxlIHRoZSBlcnJvciDimLkKPj4+PiBKdXN0IHJvbGwgYmFj
ayB0byB0aGUgc3RhdGUgYmVmb3JlIGNhbGxpbmcgdGhpcyBmdW5jdGlvbiBhbmQgcmV0dXJuCj4+
Pj4gYW4gYXBwcm9wcmlhdGUgZXJyb3IgdmFsdWUuCj4+Pj4KPj4+PiBUaGUgbGlrZWx5IGJlaGF2
aW9yIGlzIGRldGFjaGluZyB0aGUgbmV3IGRvbWFpbnMgZnJvbSBhbGwgZGV2aWNlcyAoaWYKPj4+
PiBpdCBoYXMgYWxyZWFkeSBhdHRhY2hlZCksIGF0dGFjaGluZyB0aGUgb2xkIGRvbWFpbnMgdG8g
YWxsIGRldmljZXMgaW4KPj4+PiB0aGUgZ3JvdXAsCj4+PiBBbmQgd2hpbGUgaGFuZGxpbmcgdGhp
cyBlcnJvciBjYXNlLCB0aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRoYXQgYXR0YWNoaW5nIHRvIG9s
ZAo+PiBkb21haW4gY291bGQgZmFpbC4uIHNvLCB3ZSBtaWdodCBuZWVkIHRvIGhhbmRsZSB0aGF0
IGVycm9yIGNhc2UgYXMgd2VsbC4gSWYgd2UKPj4gcGxhbiB0byBoYW5kbGUgZXJyb3IgY2FzZSwg
c2luY2Ugd2UgaGF2ZSByZW1vdmVkIGRldmljZXMgZnJvbSBncm91cCBhYm92ZSwKPj4gYWRkaW5n
IHRoZW0gYmFjayBjb3VsZCBmYWlsIHRvby4uIHRoYXQgd291bGQgbGVhZCBpbnRvIGhhbmRsaW5n
IGVycm9yIGNhc2UgZm9yIGFuCj4+IGVycm9yIGNhc2UuCj4+Cj4+IFdlIGNhbiBhc3N1bWUgdGhh
dCB0aGUgb2xkIGRvbWFpbiBzaG91bGQgYWx3YXlzIGJlIGF0dGFjaGVkIGJhY2suCj4+IE90aGVy
d2lzZSwgdGhlcmUgbXVzdCBiZSBzb21lIGJ1Z3MgaW4gdGhlIHZlbmRvciBpb21tdSBkcml2ZXIu
Cj4+Cj4+IEl0IG11c3QgYmUgYWJsZSB0byByb2xlIGJhY2ssIG90aGVyd2lzZSB1c2VycyBoYXZl
IHRvIHJlYm9vdCB0aGUgc3lzdGVtIGluIG9yZGVyCj4+IHRvIHVzZSB0aGUgZGV2aWNlcyBpbiB0
aGUgZ3JvdXAuIFRoaXMgaXMgbm90IGFjY2VwdGFibGUgaW4gdGhlIHByb2R1Y3Rpb24ga2VybmVs
Lgo+IEkgYWdyZWUgdGhhdCB3ZSBzaG91bGQgYmUgYWJsZSB0byByb2xsIGJhY2sgYnV0IEkgYW0g
YWZyYWlkIHRoYXQgdGhlIGVycm9yIGhhbmRsaW5nIGNvZGUgY291bGQgYmVjb21lIGNvbXBsZXgg
dGhhbiB0aGUgdXN1YWwgY29kZSB0aGF0IGdldHMgdG8gcnVuLiBGb3IgZXhhbXBsZSwgYXNzdW1l
IHRoZXJlIGFyZSAnbicgZGV2aWNlcyBpbiB0aGUgZ3JvdXAsICdrJyBvZiB0aGVtIGFyZSBzdWNj
ZXNzZnVsbHkgcHJvY2Vzc2VkIChpLmUuIGRlZmF1bHQgZG9tYWluIHR5cGUgaGFzIGJlZW4gY2hh
bmdlZCkgYW5kIGlmIGsrMSBmYWlscyB3aGlsZSBjaGFuZ2luZyBkZWZhdWx0IGRvbWFpbiB0eXBl
LCB0byByb2xsIGJhY2sgc3RhdGUgb2YgayBkZXZpY2VzLCB3ZSBuZWVkIHRvIG1haW50YWluIGEg
bGlzdCBvZiBwcm9jZXNzZWQgZGV2aWNlcyBzbyB0aGF0IHdlIG5vdyByb2xsIGJhY2sgc3RhdGUg
Zm9yIGRldmljZXMgaW4gdGhpcyBsaXN0LiBUaGUgcHJlc2VudCBjb2RlIGRvZXMgbm90IGhhdmUg
YW55IGxpc3QgYmVjYXVzZSBpdCdzIHByb2Nlc3Npbmcgc2VxdWVudGlhbGx5LCBpdCB0YWtlcyBh
IGRldmljZSBmcm9tIHRoZSBncm91cCwgY2hhbmdlcyBpdCBkb21haW4gYW5kIG1vdmVzIHRvIG90
aGVyIGRldmljZSBhbmQgaGVuY2UgZG9lcyBub3QgcmVxdWlyZSBhIGxpc3QuCj4gCj4gQWxsIHNh
aWQsIEkgY291bGQgZ2l2ZSB0aGlzIGEgdHJ5IGFuZCBzZWUgaG93IGNvbXBsZXggdGhlIGNvZGUg
Y291bGQgdHVybiBvdXQgdG8gYmUuIEkgaG9wZSBJIGFtIHdyb25nIChpLmUuIHR1cm5zIG91dCBp
bXBsZW1lbnRpbmcgZXJyb3IgaGFuZGxpbmcgaXMgc2ltcGxlKS4KPiAKCkkgdGhpbmsgc29tZXRo
aW5nIGxpa2UgYmVsb3cgc2hvdWxkIHdvcmsuCgpzdGF0aWMgaW50IGlvbW11X2dyb3VwX2RvX2F0
dGFjaF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQp7CiAgICAgICAgIHN0
cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiA9IGRhdGE7CgogICAgICAgICByZXR1cm4gX19pb21t
dV9hdHRhY2hfZGV2aWNlKGRvbWFpbiwgZGV2KTsKfQoKc3RhdGljIGludCBfX2lvbW11X2F0dGFj
aF9ncm91cChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXApCnsKICAgICAgICAgaW50IHJl
dDsKCiAgICAgICAgIGlmIChncm91cC0+ZGVmYXVsdF9kb21haW4gJiYgZ3JvdXAtPmRvbWFpbiAh
PSAKZ3JvdXAtPmRlZmF1bHRfZG9tYWluKQogICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7
CgogICAgICAgICByZXQgPSBfX2lvbW11X2dyb3VwX2Zvcl9lYWNoX2Rldihncm91cCwgZG9tYWlu
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9ncm91cF9k
b19hdHRhY2hfZGV2aWNlKTsKICAgICAgICAgaWYgKHJldCA9PSAwKQogICAgICAgICAgICAgICAg
IGdyb3VwLT5kb21haW4gPSBkb21haW47CgogICAgICAgICByZXR1cm4gcmV0Owp9CgpUaGUgdmVu
ZG9yIGlvbW11IGRyaXZlciBzaG91bGQgYWx3YXlzIGRlcHJlY2F0ZSB0aGUgb2xkIGRvbWFpbiBp
ZiBpdApleGlzdHMuIEFkZCBhIGNvbW1lbnQgdGhlcmUuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
