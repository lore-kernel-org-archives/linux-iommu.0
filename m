Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B9C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 00:47:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F4B21655
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 00:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F4B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5680AD7D;
	Tue, 30 Apr 2019 00:47:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 373F8D7A
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 00:46:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C338E87B
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 00:46:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Apr 2019 17:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; d="scan'208";a="295632067"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 29 Apr 2019 17:46:37 -0700
Subject: Re: [PATCH v3 01/10] iommu: Add helper to get minimal page size of
	domain
To: Robin Murphy <robin.murphy@arm.com>, David Woodhouse
	<dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-2-baolu.lu@linux.intel.com>
	<05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <48ac694e-4551-40e2-f914-6942da810489@linux.intel.com>
Date: Tue, 30 Apr 2019 08:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, pengfei.xu@intel.com,
	jacob.jun.pan@intel.com, mika.westerberg@linux.intel.com,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430004020.UvNwvJiRjnnMT8GMSwfyiCzLGJYnwk4Ek-r2WeQ2g2I@z>

SGkgUm9iaW4sCgpPbiA0LzI5LzE5IDY6NTUgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MS8wNC8yMDE5IDAyOjE3LCBMdSBCYW9sdSB3cm90ZToKPj4gVGhpcyBtYWtlcyBpdCBwb3NzaWJs
ZSBmb3Igb3RoZXIgbW9kdWxlcyB0byBrbm93IHRoZSBtaW5pbWFsCj4+IHBhZ2Ugc2l6ZSBzdXBw
b3J0ZWQgYnkgYSBkb21haW4gd2l0aG91dCB0aGUga25vd2xlZGdlIG9mIHRoZQo+PiBzdHJ1Y3R1
cmUgZGV0YWlscy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KPj4gLS0tCj4+IMKgIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8IDEzICsrKysr
KysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPj4KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+
PiBpbmRleCBhNTAwN2QwMzUyMTguLjQ2Njc5ZWYxOWI3ZSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9pb21tdS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiBAQCAtMzc3
LDYgKzM3NywxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfdGxiX3N5bmMoc3RydWN0IAo+
PiBpb21tdV9kb21haW4gKmRvbWFpbikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbi0+b3Bz
LT5pb3RsYl9zeW5jKGRvbWFpbik7Cj4+IMKgIH0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyBkb21haW5fbWluaW1hbF9wZ3NpemUoc3RydWN0IGlvbW11X2RvbWFpbiAKPj4gKmRvbWFp
bikKPj4gK3sKPj4gK8KgwqDCoCBpZiAoZG9tYWluICYmIGRvbWFpbi0+cGdzaXplX2JpdG1hcCkK
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAxIDw8IF9fZmZzKGRvbWFpbi0+cGdzaXplX2JpdG1h
cCk7Cj4gCj4gTml0OiB0aGlzIHdvdWxkIHByb2JhYmx5IGJlIG1vcmUgZWZmaWNpZW50IG9uIG1v
c3QgYXJjaGl0ZWN0dXJlcyBhczoKPiAKPiAgwqDCoMKgwqBpZiAoZG9tYWluKQo+ICDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gZG9tYWluLT5wZ3NpemVfYml0bWFwICYgLWRvbWFpbi0+cGdzaXplX2Jp
dG1hcDsKPiAKCkl0IGxvb2tzIHJlYXNvbmFibGUgdG8gbWUuCgo+IAo+IEknZCBhbHNvIHN1Z2dl
c3Qgcy9taW5pbWFsL21pbi8gaW4gdGhlIG5hbWUsIGp1c3QgdG8gc3RvcCBpdCBnZXR0aW5nIHRv
byAKPiBsb25nLiBPdGhlcndpc2UsIHRob3VnaCwgSSBsaWtlIHRoZSBpZGVhLCBhbmQgdGhlcmUn
cyBhdCBsZWFzdCBvbmUgb3RoZXIgCj4gcGxhY2UgKGluIGlvbW11LWRtYSkgdGhhdCBjYW4gbWFr
ZSB1c2Ugb2YgaXQgc3RyYWlnaHQgYXdheS4KCk9rYXksIEkgd2lsbCBjaGFuZ2UgdGhlIG5hbWUg
dG8gZG9tYWluX21pbl9wZ3NpemUoKS4KCj4gCj4gUm9iaW4uCj4gCgpCZXN0IHJlZ2FyZHMsCkx1
IEJhb2x1Cgo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gwqAgLyogUENJ
IGRldmljZSBncm91cGluZyBmdW5jdGlvbiAqLwo+PiDCoCBleHRlcm4gc3RydWN0IGlvbW11X2dy
b3VwICpwY2lfZGV2aWNlX2dyb3VwKHN0cnVjdCBkZXZpY2UgKmRldik7Cj4+IMKgIC8qIEdlbmVy
aWMgZGV2aWNlIGdyb3VwaW5nIGZ1bmN0aW9uICovCj4+IEBAIC03MDQsNiArNzEyLDExIEBAIGNv
bnN0IHN0cnVjdCBpb21tdV9vcHMgCj4+ICppb21tdV9vcHNfZnJvbV9md25vZGUoc3RydWN0IGZ3
bm9kZV9oYW5kbGUgKmZ3bm9kZSkKPj4gwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPj4gwqAgfQo+
PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGRvbWFpbl9taW5pbWFsX3Bnc2l6ZShzdHJ1
Y3QgaW9tbXVfZG9tYWluIAo+PiAqZG9tYWluKQo+PiArewo+PiArwqDCoMKgIHJldHVybiAwOwo+
PiArfQo+PiArCj4+IMKgICNlbmRpZiAvKiBDT05GSUdfSU9NTVVfQVBJICovCj4+IMKgICNpZmRl
ZiBDT05GSUdfSU9NTVVfREVCVUdGUwo+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
