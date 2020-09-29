Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9419C2D0A8
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:17:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9F2075B
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4491F866B2;
	Tue, 29 Sep 2020 00:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZhcSYLGYBPF; Tue, 29 Sep 2020 00:17:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9FE37866C3;
	Tue, 29 Sep 2020 00:17:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86665C016F;
	Tue, 29 Sep 2020 00:17:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9DAAC0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E151886D5A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4tzgu+5S3VUh for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:17:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C90186A98
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:17:50 +0000 (UTC)
IronPort-SDR: 3jf2S9Sc1E5VMZYJcPI6k9vIeBH8whCcWhrjUU5IqFsCk5SBhWzBV36ruJcpSmwm8YdSs5P1iJ
 r1nLQFA1qJ6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223676491"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; d="scan'208";a="223676491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 17:17:49 -0700
IronPort-SDR: vBRBwymd2PTiWX2JYPy/kVamnLH16EZO03swENsMtJAUXMzMi//4+COfuiuFAY5Az4SbuQygQB
 dsW9T/Fk2OZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; d="scan'208";a="415182150"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2020 17:17:47 -0700
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
Date: Tue, 29 Sep 2020 08:11:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
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

SGkgVHZydGtvLAoKT24gOS8yOC8yMCA1OjQ0IFBNLCBUdnJ0a28gVXJzdWxpbiB3cm90ZToKPiAK
PiBPbiAyNy8wOS8yMDIwIDA3OjM0LCBMdSBCYW9sdSB3cm90ZToKPj4gSGksCj4+Cj4+IFRoZSBw
cmV2aW91cyBwb3N0IG9mIHRoaXMgc2VyaWVzIGNvdWxkIGJlIGZvdW5kIGhlcmUuCj4+Cj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAwOTEyMDMyMjAwLjExNDg5LTEt
YmFvbHUubHVAbGludXguaW50ZWwuY29tLyAKPj4KPj4KPj4gVGhpcyB2ZXJzaW9uIGludHJvZHVj
ZSBhIG5ldyBwYXRjaCBbNC83XSB0byBmaXggYW4gaXNzdWUgcmVwb3J0ZWQgaGVyZS4KPj4KPj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvNTFhMWJhZWMtNDhkMS1jMGFjLTE4
MWItMWZiYTkyYWE0MjhkQGxpbnV4LmludGVsLmNvbS8gCj4+Cj4+Cj4+IFRoZXJlIGFyZW4ndCBh
bnkgb3RoZXIgY2hhbmdlcy4KPj4KPj4gUGxlYXNlIGhlbHAgdG8gdGVzdCBhbmQgcmV2aWV3Lgo+
Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJhb2x1Cj4+Cj4+IEx1IEJhb2x1ICgzKToKPj4gwqDCoCBp
b21tdTogQWRkIHF1aXJrIGZvciBJbnRlbCBncmFwaGljIGRldmljZXMgaW4gbWFwX3NnCj4gCj4g
U2luY2UgSSBkbyBoYXZlIHBhdGNoZXMgdG8gZml4IGk5MTUgdG8gaGFuZGxlIHRoaXMsIGRvIHdl
IHdhbnQgdG8gCj4gY28tb3JkaW5hdGUgdGhlIHR3byBhbmQgYXZvaWQgaGF2aW5nIHRvIGFkZCB0
aGlzIHF1aXJrIGFuZCB0aGVuIGxhdGVyIAo+IHJlbW92ZSBpdD8gT3IgeW91IHdhbnQgdG8gZ28g
dGhlIHN0YWdlZCBhcHByb2FjaD8KCkkgaGF2ZSBubyBwcmVmZXJlbmNlLiBJdCBkZXBlbmRzIG9u
IHdoaWNoIHBhdGNoIGdvZXMgZmlyc3QuIExldCB0aGUKbWFpbnRhaW5lcnMgaGVscCBoZXJlLgoK
QmVzdCByZWdhcmRzLApiYW9sdQoKPiAKPiBSZWdhcmRzLAo+IAo+IFR2cnRrbwo+IAo+PiDCoMKg
IGlvbW11L3Z0LWQ6IFVwZGF0ZSBkb21haW4gZ2VvbWV0cnkgaW4gaW9tbXVfb3BzLmF0KGRlKXRh
Y2hfZGV2Cj4+IMKgwqAgaW9tbXUvdnQtZDogQ2xlYW51cCBhZnRlciBjb252ZXJ0aW5nIHRvIGRt
YS1pb21tdSBvcHMKPj4KPj4gVG9tIE11cnBoeSAoNCk6Cj4+IMKgwqAgaW9tbXU6IEhhbmRsZSBm
cmVlbGlzdHMgd2hlbiB1c2luZyBkZWZlcnJlZCBmbHVzaGluZyBpbiBpb21tdSBkcml2ZXJzCj4+
IMKgwqAgaW9tbXU6IEFkZCBpb21tdV9kbWFfZnJlZV9jcHVfY2FjaGVkX2lvdmFzKCkKPj4gwqDC
oCBpb21tdTogQWxsb3cgdGhlIGRtYS1pb21tdSBhcGkgdG8gdXNlIGJvdW5jZSBidWZmZXJzCj4+
IMKgwqAgaW9tbXUvdnQtZDogQ29udmVydCBpbnRlbCBpb21tdSBkcml2ZXIgdG8gdGhlIGlvbW11
IG9wcwo+Pgo+PiDCoCAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0wqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCA1IC0KPj4gwqAgZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMjggKysrKy0KPj4gwqAgZHJp
dmVycy9pb21tdS9pbnRlbC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDEgKwo+PiDCoCBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA5MDEgKysrLS0tLS0tLS0tLS0tLS0tCj4+IMKg
IGluY2x1ZGUvbGludXgvZG1hLWlvbW11LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDggKwo+PiDCoCBpbmNsdWRlL2xpbnV4L2lvbW11LmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4+IMKgIDYg
ZmlsZXMgY2hhbmdlZCwgMzM2IGluc2VydGlvbnMoKyksIDgwOCBkZWxldGlvbnMoLSkKPj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
