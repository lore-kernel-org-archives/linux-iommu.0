Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B1C07E9B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 01:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3F361178
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 01:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3F361178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F240182A0E;
	Wed, 21 Jul 2021 01:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WNsu5BUFF1Es; Wed, 21 Jul 2021 01:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7959829BB;
	Wed, 21 Jul 2021 01:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5523C0010;
	Wed, 21 Jul 2021 01:53:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFCEC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AEF9402BC
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xSOhQCFHiG3F for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 01:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 838EF400E8
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 01:53:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211416026"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; d="scan'208";a="211416026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 18:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; d="scan'208";a="462240705"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 20 Jul 2021 18:52:58 -0700
Subject: Re: [PATCH 4/5] iommu/vt-d: Disallow SVA if devices don't support
 64-bit address
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Liu Yi L <yi.l.liu@intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
 <20210720013856.4143880-5-baolu.lu@linux.intel.com>
 <22302277-0470-db41-7a19-41b5f73bd2c5@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d3a2546-da21-605d-26a9-1f6f52123056@linux.intel.com>
Date: Wed, 21 Jul 2021 09:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <22302277-0470-db41-7a19-41b5f73bd2c5@arm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

SGkgUm9iaW4sCgpUaGFua3MgYSBsb3QgZm9yIHJldmlld2luZyBteSBwYXRjaCEKCk9uIDcvMjAv
MjEgNToyNyBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDctMjAgMDI6MzgsIEx1
IEJhb2x1IHdyb3RlOgo+PiBXaGVuIHRoZSBkZXZpY2UgYW5kIENQVSBzaGFyZSBhbiBhZGRyZXNz
IHNwYWNlIChzdWNoIGFzIFNWQSksIHRoZSBkZXZpY2UKPj4gbXVzdCBzdXBwb3J0IHRoZSBzYW1l
IGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBhcyB0aGUgQ1BVLiBUaGUgQ1BVIGRvZXMgbm90Cj4+IGNv
bnNpZGVyIHRoZSBhZGRyZXNzaW5nIGFiaWxpdHkgb2YgYW55IGRldmljZSB3aGVuIG1hbmFnaW5n
IHRoZSBwYWdlIAo+PiB0YWJsZQo+PiBvZiBhIHByb2Nlc3MsIHNvIHRoZSBkZXZpY2UgbXVzdCBo
YXZlIGVub3VnaCBhZGRyZXNzaW5nIGFiaWxpdHkgdG8gYmluZAo+PiB0aGUgcGFnZSB0YWJsZSBv
ZiB0aGUgcHJvY2Vzcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8
IDMgKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYwo+PiBpbmRleCBmNDVjODBjZTIzODEuLmYzY2NhMWRkMzg0ZCAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuYwo+PiBAQCAtNTM3Miw2ICs1MzcyLDkgQEAgc3RhdGljIGludCBpbnRlbF9pb21t
dV9lbmFibGVfc3ZhKHN0cnVjdCBkZXZpY2UgCj4+ICpkZXYpCj4+IMKgwqDCoMKgwqAgaWYgKCEo
aW9tbXUtPmZsYWdzICYgVlREX0ZMQUdfU1ZNX0NBUEFCTEUpKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9ERVY7Cj4+ICvCoMKgwqAgaWYgKCFkZXYtPmRtYV9tYXNrIHx8ICpkZXYt
PmRtYV9tYXNrICE9IERNQV9CSVRfTUFTSyg2NCkpCj4gCj4gQ2FyZWZ1bCAtIFZGSU8gZG9lc24n
dCBzZXQgRE1BIG1hc2tzIChzaW5jZSBpdCBkb2Vzbid0IHVzZSB0aGUgRE1BIEFQSSksCgpTVkEg
ZG9lc24ndCB3b3JrIHRocm91Z2ggdGhlIFZGSU8gZnJhbWV3b3JrLgoKPiBzbyB0aGlzIGFwcGVh
cnMgdG8gYmUgcmVseWluZyBvbiBhbm90aGVyIGRyaXZlciBoYXZpbmcgYm91bmQgcHJldmlvdXNs
eSwKClllcy4gWW91IGFyZSByaWdodC4KCj4gb3RoZXJ3aXNlIHRoZSBtYXNrIHdvdWxkIHN0aWxs
IGJlIHRoZSBkZWZhdWx0IDMyLWJpdCBvbmUgZnJvbSAKPiBwY2lfc2V0dXBfZGV2aWNlKCkuIEkn
bSBub3Qgc3VyZSB0aGF0J3MgYW4gZW50aXJlbHkgcm9idXN0IGFzc3VtcHRpb24uCgpDdXJyZW50
bHkgU1ZBIGltcGxlbWVudGF0aW9uIGFsd2F5cyByZXF1aXJlcyBhIG5hdGl2ZSBrZXJuZWwgZHJp
dmVyLiBUaGUKYXNzdW1wdGlvbiBpcyB0aGF0IHRoZSBkcml2ZXJzIHNob3VsZCBjaGVjayBhbmQg
c2V0IDY0LWJpdCBhZGRyZXNzaW5nCmNhcGFiaWxpdHkgYmVmb3JlIGNhbGxpbmcgaW9tbXVfc3Zh
X3h4eCgpIEFQSXMuCgo+Cj4gUm9iaW4uCj4gCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVO
T0RFVjsKPj4gKwo+PiDCoMKgwqDCoMKgIGlmIChpbnRlbF9pb21tdV9lbmFibGVfcGFzaWQoaW9t
bXUsIGRldikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4KCkJlc3Qg
cmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
