Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D25BC636CE
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 14:18:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7346044F
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 14:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7346044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF9576082C;
	Wed, 21 Jul 2021 14:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImohbZUQhMMu; Wed, 21 Jul 2021 14:18:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A794605FB;
	Wed, 21 Jul 2021 14:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 667FFC0010;
	Wed, 21 Jul 2021 14:18:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D8EC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 14:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D90E2401D6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 14:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M3itkk157BSv for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:18:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FB69400D0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 14:18:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208325212"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; d="scan'208";a="208325212"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2021 07:18:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; d="scan'208";a="501302795"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.149])
 ([10.254.213.149])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2021 07:18:11 -0700
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Liu Yi L <yi.l.liu@intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
 <20210720013856.4143880-5-baolu.lu@linux.intel.com>
 <22302277-0470-db41-7a19-41b5f73bd2c5@arm.com>
 <4d3a2546-da21-605d-26a9-1f6f52123056@linux.intel.com>
 <5662caea-a974-e511-9509-010606fda251@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/5] iommu/vt-d: Disallow SVA if devices don't support
 64-bit address
Message-ID: <f1fd4464-d186-e18f-3e33-eac56d488bba@linux.intel.com>
Date: Wed, 21 Jul 2021 22:17:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5662caea-a974-e511-9509-010606fda251@arm.com>
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

T24gMjAyMS83LzIxIDE5OjEyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNy0yMSAw
Mjo1MCwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBUaGFua3MgYSBsb3QgZm9y
IHJldmlld2luZyBteSBwYXRjaCEKPj4KPj4gT24gNy8yMC8yMSA1OjI3IFBNLCBSb2JpbiBNdXJw
aHkgd3JvdGU6Cj4+PiBPbiAyMDIxLTA3LTIwIDAyOjM4LCBMdSBCYW9sdSB3cm90ZToKPj4+PiBX
aGVuIHRoZSBkZXZpY2UgYW5kIENQVSBzaGFyZSBhbiBhZGRyZXNzIHNwYWNlIChzdWNoIGFzIFNW
QSksIHRoZSAKPj4+PiBkZXZpY2UKPj4+PiBtdXN0IHN1cHBvcnQgdGhlIHNhbWUgYWRkcmVzc2lu
ZyBjYXBhYmlsaXR5IGFzIHRoZSBDUFUuIFRoZSBDUFUgZG9lcyAKPj4+PiBub3QKPj4+PiBjb25z
aWRlciB0aGUgYWRkcmVzc2luZyBhYmlsaXR5IG9mIGFueSBkZXZpY2Ugd2hlbiBtYW5hZ2luZyB0
aGUgcGFnZSAKPj4+PiB0YWJsZQo+Pj4+IG9mIGEgcHJvY2Vzcywgc28gdGhlIGRldmljZSBtdXN0
IGhhdmUgZW5vdWdoIGFkZHJlc3NpbmcgYWJpbGl0eSB0byBiaW5kCj4+Pj4gdGhlIHBhZ2UgdGFi
bGUgb2YgdGhlIHByb2Nlc3MuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFv
bHUubHVAbGludXguaW50ZWwuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuYyB8IDMgKysrCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4+IGluZGV4IGY0NWM4MGNlMjM4MS4uZjNjY2Ex
ZGQzODRkIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4+IEBAIC01MzcyLDYgKzUzNzIs
OSBAQCBzdGF0aWMgaW50IGludGVsX2lvbW11X2VuYWJsZV9zdmEoc3RydWN0IAo+Pj4+IGRldmlj
ZSAqZGV2KQo+Pj4+IMKgwqDCoMKgwqAgaWYgKCEoaW9tbXUtPmZsYWdzICYgVlREX0ZMQUdfU1ZN
X0NBUEFCTEUpKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4+PiAr
wqDCoMKgIGlmICghZGV2LT5kbWFfbWFzayB8fCAqZGV2LT5kbWFfbWFzayAhPSBETUFfQklUX01B
U0soNjQpKQo+Pj4KPj4+IENhcmVmdWwgLSBWRklPIGRvZXNuJ3Qgc2V0IERNQSBtYXNrcyAoc2lu
Y2UgaXQgZG9lc24ndCB1c2UgdGhlIERNQSBBUEkpLAo+Pgo+PiBTVkEgZG9lc24ndCB3b3JrIHRo
cm91Z2ggdGhlIFZGSU8gZnJhbWV3b3JrLgo+IAo+IERpZCBhbnlvbmUgc2F5IGl0IGRvZXM/IE15
IHBvaW50IGlzIHRoYXQsIGFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIHRoZSAKPiBTVkEgVUFQSSBp
cyB2ZXJ5IG11Y2ggaW50ZW5kZWQgdG8gd29yayAqd2l0aCogVkZJTywgYW5kIGV2ZW4gaWYgdGhl
IAo+IGZpbmVyIGRldGFpbHMgYXJlIHN0aWxsIG1pcmVkIGluIHRoZSAvZGV2L2lvYXNpZCBkaXNj
dXNzaW9uIHRvZGF5IHdlIAo+IHNob3VsZCBkZWZpbml0ZWx5IGV4cGVjdCB0byBzZWUgVkZJTy1s
aWtlIHVzZS1jYXNlcyBhdCBzb21lIHBvaW50LiBJIAo+IGNlcnRhaW5seSBkb24ndCBzZWUgd2h5
IGFueSBvZiB0aGUgZ3Vlc3QgU1ZBIHN0dWZmIGV4aXN0cyBhbHJlYWR5IGlmIG5vdCAKPiBmb3Ig
VkZJTy1hc3NpZ25lZCBkZXZpY2VzPwoKQWdyZWVkLiBGcm9tIC9kZXYvaW9hc2lkIGRlc2lnbiBw
b2ludCBvZiB2aWV3LCBpdCdzIHBvc3NpYmxlIHRvIGhhdmUKVkZJTy1saWtlIHVzZSBjYXNlIG9m
IFNWQS4gUGVyaGFwcyB0aGUgZGV2aWNlIGFkZHJlc3NpbmcgY2FwYWJpbGl0eQpjb3VsZCBiZSBp
bmNsdWRlZCBpbiBHRVRfREVWX0lORk8gb2YgL2Rldi9pb2FzaWQgVUFQSS4KCj4gCj4+PiBzbyB0
aGlzIGFwcGVhcnMgdG8gYmUgcmVseWluZyBvbiBhbm90aGVyIGRyaXZlciBoYXZpbmcgYm91bmQg
cHJldmlvdXNseSwKPj4KPj4gWWVzLiBZb3UgYXJlIHJpZ2h0Lgo+Pgo+Pj4gb3RoZXJ3aXNlIHRo
ZSBtYXNrIHdvdWxkIHN0aWxsIGJlIHRoZSBkZWZhdWx0IDMyLWJpdCBvbmUgZnJvbSAKPj4+IHBj
aV9zZXR1cF9kZXZpY2UoKS4gSSdtIG5vdCBzdXJlIHRoYXQncyBhbiBlbnRpcmVseSByb2J1c3Qg
YXNzdW1wdGlvbi4KPj4KPj4gQ3VycmVudGx5IFNWQSBpbXBsZW1lbnRhdGlvbiBhbHdheXMgcmVx
dWlyZXMgYSBuYXRpdmUga2VybmVsIGRyaXZlci4gVGhlCj4+IGFzc3VtcHRpb24gaXMgdGhhdCB0
aGUgZHJpdmVycyBzaG91bGQgY2hlY2sgYW5kIHNldCA2NC1iaXQgYWRkcmVzc2luZwo+PiBjYXBh
YmlsaXR5IGJlZm9yZSBjYWxsaW5nIGlvbW11X3N2YV94eHgoKSBBUElzLgo+IAo+IC4uLmFuZCBn
aXZlbiB0aGF0IHRoYXQgaXMgbm90IGEgZG9jdW1lbnRlZCByZXF1aXJlbWVudCwgYW5kIGNlcnRh
aW5seSAKPiBub3QgYSB0ZWNobmljYWwgb25lIChldmVuIGEgc2VsZi1jb250YWluZWQga2VybmVs
IGRyaXZlciBjb3VsZCBjaG9vc2UgdG8gCj4gb25seSB1c2UgU1ZBIGNvbnRleHRzIGFuZCBub3Qg
dG91Y2ggdGhlIERNQSBBUEkpLCBpdCdzIGFuIGluaGVyZW50bHkgCj4gZnJhZ2lsZSBhc3N1bXB0
aW9uIHdoaWNoIEknbSBjb25maWRlbnQgKndpbGwqIGJlIGJyb2tlbiBldmVudHVhbGx5IDopCj4g
CgpGYWlyIGVub3VnaC4gSSB3aWxsIGRyb3AgdGhpcyBwYXRjaC4KClRoYW5rcyBhIGxvdCBmb3Ig
dGhlIGNvbW1lbnRzLgoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiBSb2Jpbi4KPiAKPj4+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAgaWYgKGlu
dGVsX2lvbW11X2VuYWJsZV9wYXNpZChpb21tdSwgZGV2KSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
