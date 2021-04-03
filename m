Return-Path: <SRS0=Uvpc=JA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337BC433ED
	for <iommu@archiver.kernel.org>; Sat,  3 Apr 2021 01:44:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92303611AE
	for <iommu@archiver.kernel.org>; Sat,  3 Apr 2021 01:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92303611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AA7740E75;
	Sat,  3 Apr 2021 01:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRKtgJ7sTQcL; Sat,  3 Apr 2021 01:44:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3440740E71;
	Sat,  3 Apr 2021 01:44:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 097F2C000C;
	Sat,  3 Apr 2021 01:44:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61466C000A
 for <iommu@lists.linux-foundation.org>; Sat,  3 Apr 2021 01:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 489136066E
 for <iommu@lists.linux-foundation.org>; Sat,  3 Apr 2021 01:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WORngVeK9OFR for <iommu@lists.linux-foundation.org>;
 Sat,  3 Apr 2021 01:44:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4683460668
 for <iommu@lists.linux-foundation.org>; Sat,  3 Apr 2021 01:44:49 +0000 (UTC)
IronPort-SDR: B41ybn6hjAUfZVmznapvue1Dfwm9YGuGayeWKbA5NungDzz7WnMxvSnDCsxZDFUbSrJeLbp2ux
 mOWFSuheWamg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="190330487"
X-IronPort-AV: E=Sophos;i="5.81,301,1610438400"; d="scan'208";a="190330487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2021 18:44:48 -0700
IronPort-SDR: 585omDKXY/+llUUlmTzmtkOe9KBo7zUuY3JY39nmWEj48sLxBgEiISi+OxRb56qW2JXiRkd3+c
 Zz/vCvvM8xjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,301,1610438400"; d="scan'208";a="439820375"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2021 18:44:46 -0700
Subject: Re: [RFC PATCH 2/5] iommu: Add an unmap_pages() op for IOMMU drivers
To: isaacm@codeaurora.org
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-3-isaacm@codeaurora.org>
 <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
 <4c396e68a076f321ed3f406c2c875006@codeaurora.org>
 <3a931043-71bc-88a2-ee57-be9c139e7c9f@linux.intel.com>
 <b9bbc82b3e405e5bc1d28ed073f6d5b4@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fde5cf0e-caed-077b-4d64-eb04ef9b7e07@linux.intel.com>
Date: Sat, 3 Apr 2021 09:35:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b9bbc82b3e405e5bc1d28ed073f6d5b4@codeaurora.org>
Content-Language: en-US
Cc: will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, pratikp@codeaurora.org
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

SGkgSXNhYWMsCgpPbiA0LzMvMjEgMToyNSBBTSwgaXNhYWNtQGNvZGVhdXJvcmEub3JnIHdyb3Rl
Ogo+IE9uIDIwMjEtMDMtMzAgMjI6MzksIEx1IEJhb2x1IHdyb3RlOgo+PiBPbiAzLzMxLzIxIDE6
MzYgUE0sIGlzYWFjbUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4+IE9uIDIwMjEtMDMtMzAgMjE6
NDcsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IE9uIDMvMzEvMjEgMTE6MDAgQU0sIElzYWFjIEouIE1h
bmphcnJlcyB3cm90ZToKPj4+Pj4gQWRkIGEgY2FsbGJhY2sgZm9yIElPTU1VIGRyaXZlcnMgdG8g
cHJvdmlkZSBhIHBhdGggZm9yIHRoZQo+Pj4+PiBJT01NVSBmcmFtZXdvcmsgdG8gY2FsbCBpbnRv
IGFuIElPTU1VIGRyaXZlciwgd2hpY2ggY2FuIGNhbGwKPj4+Pj4gaW50byB0aGUgaW8tcGd0YWJs
ZSBjb2RlLCB0byB1bm1hcCBhIHZpcnR1YWxseSBjb250aWd1b3VzCj4+Pj4+IHJhbmdlIG9mIHBh
Z2VzIG9mIHRoZSBzYW1lIHNpemUuCj4+Pj4+Cj4+Pj4+IEZvciBJT01NVSBkcml2ZXJzIHRoYXQg
ZG8gbm90IHNwZWNpZnkgYW4gdW5tYXBfcGFnZXMoKSBjYWxsYmFjaywKPj4+Pj4gdGhlIGV4aXN0
aW5nIGxvZ2ljIG9mIHVubWFwcGluZyBtZW1vcnkgb25lIHBhZ2UgYmxvY2sgYXQgYSB0aW1lCj4+
Pj4+IHdpbGwgYmUgdXNlZC4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSXNhYWMgSi4gTWFu
amFycmVzIDxpc2FhY21AY29kZWF1cm9yYS5vcmc+Cj4+Pj4+IFN1Z2dlc3RlZC1ieTogV2lsbCBE
ZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KPj4+Pj4gLS0tCj4+Pj4+IMKgIGluY2x1ZGUvbGludXgv
aW9tbXUuaCB8IDQgKysrKwo+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
Cj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRl
L2xpbnV4L2lvbW11LmgKPj4+Pj4gaW5kZXggNWU3ZmU1MTk0MzBhLi45Y2Y4MTI0MjU4MWEgMTAw
NjQ0Cj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+Pj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2lvbW11LmgKPj4+Pj4gQEAgLTE5Myw2ICsxOTMsNyBAQCBzdHJ1Y3QgaW9tbXVfaW90
bGJfZ2F0aGVyIHsKPj4+Pj4gwqDCoCAqIEBkZXRhY2hfZGV2OiBkZXRhY2ggZGV2aWNlIGZyb20g
YW4gaW9tbXUgZG9tYWluCj4+Pj4+IMKgwqAgKiBAbWFwOiBtYXAgYSBwaHlzaWNhbGx5IGNvbnRp
Z3VvdXMgbWVtb3J5IHJlZ2lvbiB0byBhbiBpb21tdSAKPj4+Pj4gZG9tYWluCj4+Pj4+IMKgwqAg
KiBAdW5tYXA6IHVubWFwIGEgcGh5c2ljYWxseSBjb250aWd1b3VzIG1lbW9yeSByZWdpb24gZnJv
bSBhbiAKPj4+Pj4gaW9tbXUgZG9tYWluCj4+Pj4+ICsgKiBAdW5tYXBfcGFnZXM6IHVubWFwIGEg
bnVtYmVyIG9mIHBhZ2VzIG9mIHRoZSBzYW1lIHNpemUgZnJvbSBhbiAKPj4+Pj4gaW9tbXUgZG9t
YWluCj4+Pj4+IMKgwqAgKiBAZmx1c2hfaW90bGJfYWxsOiBTeW5jaHJvbm91c2x5IGZsdXNoIGFs
bCBoYXJkd2FyZSBUTEJzIGZvciAKPj4+Pj4gdGhpcyBkb21haW4KPj4+Pj4gwqDCoCAqIEBpb3Rs
Yl9zeW5jX21hcDogU3luYyBtYXBwaW5ncyBjcmVhdGVkIHJlY2VudGx5IHVzaW5nIEBtYXAgdG8g
Cj4+Pj4+IHRoZSBoYXJkd2FyZQo+Pj4+PiDCoMKgICogQGlvdGxiX3N5bmM6IEZsdXNoIGFsbCBx
dWV1ZWQgcmFuZ2VzIGZyb20gdGhlIGhhcmR3YXJlIFRMQnMgCj4+Pj4+IGFuZCBlbXB0eSBmbHVz
aAo+Pj4+PiBAQCAtMjQ1LDYgKzI0Niw5IEBAIHN0cnVjdCBpb21tdV9vcHMgewo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLCBpbnQg
cHJvdCwgZ2ZwX3QgZ2ZwKTsKPj4+Pj4gwqDCoMKgwqDCoCBzaXplX3QgKCp1bm1hcCkoc3RydWN0
IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IHNpemUsIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRo
ZXIgKmlvdGxiX2dhdGhlcik7Cj4+Pj4+ICvCoMKgwqAgc2l6ZV90ICgqdW5tYXBfcGFnZXMpKHN0
cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgCj4+Pj4+IGxvbmcgaW92YSwKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IHBnc2l6ZSwgc2l6
ZV90IHBnY291bnQsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmlvdGxiX2dhdGhlcik7Cj4+Pj4KPj4+PiBJcyBpdCBw
b3NzaWJsZSB0byBhZGQgYW4gZXF1aXZhbGVudCBtYXBfcGFnZXMoKSBjYWxsYmFjaz8KPj4+IFll
cywgbWFwX3BhZ2VzKCkgY2FuIGJlIGltcGxlbWVudGVkIGFuZCBjYW4gbGV2ZXJhZ2UgYSBsb3Qg
b2YgdGhlIAo+Pj4gaW1wbGVtZW50YXRpb24KPj4+IG9mIHVubWFwX3BhZ2VzKCkuIFRoZSBwcm9i
bGVtIGlzIHRoYXQgaWYgeW91IG1hcCBzZXZlcmFsIHBhZ2VzIGluIG9uZSAKPj4+IGNhbGwsIGFu
ZCB0aGVuCj4+PiBlbmNvdW50ZXIgYW4gZXJyb3IgYW5kIGhhdmUgdG8gcm9sbGJhY2ssIHlvdSBz
aG91bGQgZG8gVExCIAo+Pj4gbWFpbnRlbmFuY2UsIGFzIGlvbW11X21hcAo+Pj4gZG9lcyB3aGVu
IGl0IGVuY291bnRlcnMgYW4gZXJyb3IuIEhvd2V2ZXIsIHdlIGNhbid0IGNhbGwgaW9tbXVfdW5t
YXAgCj4+PiBmcm9tIGlvLXBndGFibGUtYXJtCj4+PiBmb3IgZXhhbXBsZS4gV2UgY2FuIGNhbGwg
YXJtX2xwYWVfdW5tYXBfcGFnZXMoKSBmcm9tIHRoZSBsYXRlciAKPj4+IHBhdGNoZXMsIGJ1dCB0
aGF0IGRvZXNuJ3QKPj4+IHNvbHZlIHRoZSBUTEIgbWFpbnRlbmFuY2UgaXNzdWUuIERvIHlvdSBo
YXZlIGFueSB0aG91Z2h0cyBvbiBob3cgdG8gCj4+PiBhZGRyZXNzIHRoaXM/Cj4+Cj4+IENhbGwg
dW5tYXBfcGFnZXMoKSB3aXRoIHRoZSBzYW1lIHBhZ2VzIGFuZCBzaXplIHRvIHJvbGwgYmFjay4g
RG9lcyBpdAo+PiB3b3JrPwo+Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJhb2x1Cj4gSGkgTHUsCj4g
Cj4gSSd2ZSBnaXZlbiBtYXBfcGFnZXMoKSBhIHNob3QuIEhlcmUncyB0aGUgc2Vjb25kIHZlcnNp
b24gb2YgdGhlIFJGQyAKPiBzZXJpZXM6IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWlvbW11LzIwMjEwNDAyMDEzNDUyLjQwMTMtMS1pc2FhY21AY29kZWF1cm9yYS5vcmcvVC8jdC4g
CgpUaGFua3MgZm9yIGRvaW5nIHRoYXQuIEkgd2lsbCBsb29rIGludG8gaXQgYW5kIHRyeSBpdCB3
aXRoIGEgVlQtZAppbXBsZW1lbnRhdGlvbi4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
