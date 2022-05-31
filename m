Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35929C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C30114058C;
	Tue, 31 May 2022 16:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgGaMqp0GjtW; Tue, 31 May 2022 16:42:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 599B141599;
	Tue, 31 May 2022 16:42:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 132BDC0039;
	Tue, 31 May 2022 16:42:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B98EEC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A3A341599
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FJbCAXGLKk37 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:42:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id D38DD4058C
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:42:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E38523A;
 Tue, 31 May 2022 09:42:44 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DE733F66F;
 Tue, 31 May 2022 09:42:42 -0700 (PDT)
Message-ID: <80f362fd-8e69-1dcd-ba7a-abfc55894d61@arm.com>
Date: Tue, 31 May 2022 17:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
 <20220531155904.GA3726345@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531155904.GA3726345@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

T24gMjAyMi0wNS0zMSAxNjo1OSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIFR1ZSwgTWF5
IDMxLCAyMDIyIGF0IDAyOjUyOjI4UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPiAKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwZ3RhYmxlX3dhbGtfbGV2ZWwobSwgcGh5c190b192aXJ0KHBoeXNfYWRkciks
Cj4+Cj4+IEFsc28sIG9ibGlnYXRvcnkgcmVtaW5kZXIgdGhhdCBwZm5fdmFsaWQoKSBvbmx5IG1l
YW5zIHRoYXQgcGZuX3RvX3BhZ2UoKQo+PiBnZXRzIHlvdSBhIHZhbGlkIHN0cnVjdCBwYWdlLiBX
aGV0aGVyIHRoYXQgcGFnZSBpcyBkaXJlY3QtbWFwcGVkIGtlcm5lbAo+PiBtZW1vcnkgb3Igbm90
IGlzIGEgZGlmZmVyZW50IG1hdHRlci4KPiAKPiBFdmVuIHRob3VnaCB0aGlzIGlzIGRlYnVnZnMs
IGlmIHRoZSBvcGVyYXRpb24gaXMgc2tldGNoeSBsaWtlIHRoYXQgYW5kCj4gY2FuIHRoZW9ydGlj
YWxseSBjcmFzaCB0aGUga2VybmVsIHRoZSBkcml2ZXIgc2hvdWxkIHRlc3QgY2FwYWJpbGl0aWVz
LAo+IENBUF9TWVNfUkFXSU8gb3Igc29tZXRoaW5nIG1heSBiZSBhcHByb3ByaWF0ZS4gSSBkb24n
dCB0aGluayB3ZSBoYXZlIGEKPiBiZXR0ZXIgY2FwIGZvciAndXNlcnNwYWNlIG1heSBjcmFzaCB0
aGUga2VybmVsJwoKSXQgc2hvdWxkbid0IGJlIGluc3VybW91bnRhYmxlIHRvIG1ha2UgdGhpcyBz
YWZlLCBpdCBqdXN0IG5lZWRzIGEgYml0IAptb3JlIHRoYW4gcGZuX3ZhbGlkKCksIHdoaWNoIGNh
biBzdGlsbCByZXR1cm4gdHJ1ZSBvZmYgdGhlIGVuZHMgb2YgdGhlIAptZW1vcnkgbWFwIGlmIHRo
ZXkncmUgbm90IHBlcmZlY3RseSBzZWN0aW9uLWFsaWduZWQsIGFuZCBmb3IgcmFuZG9tIApyZXNl
cnZlZCBob2xlcyBpbiB0aGUgbWlkZGxlLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
