Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228BC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6576041CC0;
	Wed, 22 Jun 2022 14:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6576041CC0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G275/yy2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id awjUSZeOtB7n; Wed, 22 Jun 2022 14:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ACA8D418DC;
	Wed, 22 Jun 2022 14:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACA8D418DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDC3C0039;
	Wed, 22 Jun 2022 14:27:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9D50C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7693160C27
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7693160C27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G275/yy2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbKLmrAYQxYg for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:27:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2FF060B16
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2FF060B16
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655908034; x=1687444034;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vySRlmuNAAv4jlQBiztxT2Pq5CPlKHqWqSX5MtbK29c=;
 b=G275/yy21tKcWh0EBBG3Ce5zA+xUVs1ml7OhsdeYTZEAg+f6PIuP648f
 7nLK0HM5VLiq6/+Im/rHO2hOGNFer/h01YVavAvP8cOQCU73SyPQ1V8oh
 q3ficXuWMi2lg1H1U/l/YQ0ycD/8Mfl5/nQJgMmlKx8q5LezOosqUZOrU
 cAsaRpZntgpg1CHP118kW4P8zQZRSyRW399Vz6xe3aKQOtaRbJyVrA0/P
 AgAH8auNPfqDYrktiFQYIQa2kSxQCZZZV5E/kSW/YiZlp5MVFGFKDxs6T
 pJfQo9mBppzWP+rMp/iE4uqSRJhxaSv1p5ypwqtEW+PrRMEUBzKgblTS1 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269150553"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="269150553"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 07:27:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="834137199"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 07:27:10 -0700
Message-ID: <339eb9cc-e65d-eaf7-e4fa-44a99797e026@linux.intel.com>
Date: Wed, 22 Jun 2022 22:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
References: <20220622044120.21813-1-baolu.lu@linux.intel.com>
 <b7834cb5-4836-fb2d-1570-a46440341bed@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b7834cb5-4836-fb2d-1570-a46440341bed@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

T24gMjAyMi82LzIyIDE3OjA5LCBFdGhhbiBaaGFvIHdyb3RlOgo+IAo+IOWcqCAyMDIyLzYvMjIg
MTI6NDEsIEx1IEJhb2x1IOWGmemBkzoKPj4gVGhlIElPTU1VIGRyaXZlciBzaGFyZXMgdGhlIHBh
c2lkIHRhYmxlIGZvciBQQ0kgYWxpYXMgZGV2aWNlcy4gV2hlbiB0aGUKPj4gUklEMlBBU0lEIGVu
dHJ5IG9mIHRoZSBzaGFyZWQgcGFzaWQgdGFibGUgaGFzIGJlZW4gZmlsbGVkIGJ5IHRoZSBmaXJz
dAo+PiBkZXZpY2UsIHRoZSBzdWJzZXF1ZW50IGRldmljZXMgd2lsbCBlbmNvdW50ZXIgdGhlICJE
TUFSOiBTZXR1cCBSSUQyUEFTSUQKPj4gZmFpbGVkIiBmYWlsdXJlIGFzIHRoZSBwYXNpZCBlbnRy
eSBoYXMgYWxyZWFkeSBiZWVuIG1hcmtlZCBhcyBwcmVzZW50LiBBcwo+PiB0aGUgcmVzdWx0LCB0
aGUgSU9NTVUgcHJvYmluZyBwcm9jZXNzIHdpbGwgYmUgYWJvcnRlZC4KPj4KPj4gVGhpcyBmaXhl
cyBpdCBieSBza2lwcGluZyBSSUQyUEFTSUQgc2V0dGluZyBpZiB0aGUgcGFzaWQgZW50cnkgaGFz
IGJlZW4KPj4gcG9wdWxhdGVkLiBUaGlzIHdvcmtzIGJlY2F1c2UgdGhlIElPTU1VIGNvcmUgZW5z
dXJlcyB0aGF0IG9ubHkgdGhlIHNhbWUKPj4gSU9NTVUgZG9tYWluIGNhbiBiZSBhdHRhY2hlZCB0
byBhbGwgUENJIGFsaWFzIGRldmljZXMgYXQgdGhlIHNhbWUgdGltZS4KPj4gVGhlcmVmb3JlIHRo
ZSBzdWJzZXF1ZW50IGRldmljZXMganVzdCB0cnkgdG8gc2V0dXAgdGhlIFJJRDJQQVNJRCBlbnRy
eQo+PiB3aXRoIHRoZSBzYW1lIGRvbWFpbiwgd2hpY2ggaXMgbmVnbGlnaWJsZS4gVGhpcyBhbHNv
IGFkZHMgZG9tYWluIHZhbGlkaXR5Cj4+IGNoZWNrcyBmb3IgbW9yZSBjb25maWRlbmNlIGFueXdh
eS4KPj4KPj4gRml4ZXM6IGVmODQ4YjdlNWE2YTAgKCJpb21tdS92dC1kOiBTZXR1cCBwYXNpZCBl
bnRyeSBmb3IgUklEMlBBU0lEIAo+PiBzdXBwb3J0IikKPj4gUmVwb3J0ZWQtYnk6IENoZW55aSBR
aWFuZyA8Y2hlbnlpLnFpYW5nQGludGVsLmNvbT4KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4K
Pj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyB8IDIyICsrKysrKysrKysr
KysrKystLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCj4+Cj4+IENoYW5nZSBsb2c6Cj4+IHYyOgo+PiDCoCAtIEFkZCBkb21haW4gdmFs
aWRpdHkgY2hlY2sgaW4gUklEMlBBU0lEIGVudHJ5IHNldHVwLgo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5j
Cj4+IGluZGV4IGNiNGMxZDBjZjI1Yy4uNGYzNTI1ZjMzNDZmIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNp
ZC5jCj4+IEBAIC01NzUsNiArNTc1LDE5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBhc2lkX2VuYWJs
ZV93cGUoc3RydWN0IAo+PiBwYXNpZF9lbnRyeSAqcHRlKQo+PiDCoMKgwqDCoMKgIHJldHVybiAw
Owo+PiDCoCB9Owo+PiArLyoKPj4gKyAqIFJldHVybiB0cnVlIGlmIEBwYXNpZCBpcyBSSUQyUEFT
SUQgYW5kIHRoZSBkb21haW4gQGRpZCBoYXMgYWxyZWFkeQo+PiArICogYmVlbiBzZXR1cCB0byB0
aGUgQHB0ZS4gT3RoZXJ3aXNlLCByZXR1cm4gZmFsc2UuIFBDSSBhbGlhcyBkZXZpY2VzCj4+ICsg
KiBwcm9iYWJseSBzaGFyZSB0aGUgc2luZ2xlIFJJRDJQQVNJRCBwYXNpZCBlbnRyeSBpbiB0aGUg
c2hhcmVkIHBhc2lkCj4+ICsgKiB0YWJsZS4gSXQncyByZWFzb25hYmxlIHRoYXQgdGhvc2UgZGV2
aWNlcyB0cnkgdG8gc2V0IGEgc2hhcmUgZG9tYWluCj4+ICsgKiBpbiB0aGVpciBwcm9iZSBwYXRo
cy4KPj4gKyAqLwo+IAo+IEkgYW0gdGhpbmtpbmcgYWJvdXQgdGhlIGNvdW50ZXItcGFydCwgdGhl
IGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgpLAo+IAo+IE11bHRpIGRldmljZXMgc2hhcmUg
dGhlIHNhbWUgUEFTSUQgZW50cnksIHRoZW4gb25lIHdhcyBkZXRhY2hlZCBmcm9tIHRoZSAKPiBk
b21haW4sCj4gCj4gc28gdGhlIGVudHJ5IGRvZXNuJ3QgZXhpc3QgYW55bW9yZSwgd2hpbGUgYW5v
dGhlciBkZXZpY2VzIGRvbid0IGtub3cgCj4gYWJvdXQgdGhlIGNoYW5nZSwKPiAKPiBhbmQgdGhl
eSBhcmUgdXNpbmcgdGhlIG1hcHBpbmcsIGlzIGl0IHBvc3NpYmxlIGNhc2Ug77yfc2hhcmVkIHRo
aW5nLCBubyAKPiByZWZlci1jb3VudGVyLAo+IAo+IGFtIEkgbWlzc2luZyBzb21ldGhpbmcgPwoK
Tm8uIFlvdSBhcmUgcmlnaHQuIFdoZW4gYW55IGFsaWFzIGRldmljZSBpcyBob3QtcmVtb3ZlZCBm
cm9tIHRoZSBzeXN0ZW0sCnRoZSBzaGFyZWQgUklEMlBBU0lEIHdpbGwgYmUgY2xlYXJlZCB3aXRo
b3V0IGFueSBub3RpZmljYXRpb24gdG8gb3RoZXIKZGV2aWNlcy4gSGVuY2UgYW55IERNQXMgZnJv
bSB0aG9zZSBkZXZpY2VzIGFyZSBibG9ja2VkLgoKV2Ugc3RpbGwgaGF2ZSBhIGxvdCB0byBkbyBm
b3Igc2hhcmluZyBwYXNpZCB0YWJsZSBhbW9uZyBhbGlhcyBkZXZpY2VzLgpCZWZvcmUgd2UgYXJy
aXZlIHRoZXJlLCBsZXQncyByZW1vdmUgaXQgZm9yIG5vdy4KCkJlc3QgcmVnYXJkcywKYmFvbHUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
