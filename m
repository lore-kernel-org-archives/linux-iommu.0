Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAEBC3567B
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911B220661
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911B220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 547D686D78;
	Mon, 24 Feb 2020 08:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIfPIBvf2lPk; Mon, 24 Feb 2020 08:39:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A84086AD4;
	Mon, 24 Feb 2020 08:39:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46709C18DA;
	Mon, 24 Feb 2020 08:39:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7C1C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 678B9204DB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4kkZAN5y9+P for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 08:39:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F9B3204D7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:39:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 00:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="255513561"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 00:39:44 -0800
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
 <17eae788-1ed7-a24b-339e-4800496f9542@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e7addf56-3b7d-e9c4-178c-2de53e7f9d95@linux.intel.com>
Date: Mon, 24 Feb 2020 16:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <17eae788-1ed7-a24b-339e-4800496f9542@linux.intel.com>
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

T24gMjAyMC8yLzI0IDE2OjEyLCBMdSBCYW9sdSB3cm90ZToKPiBPbiAyMDIwLzIvMjQgMTU6NTcs
IFByYWtoeWEsIFNhaSBQcmFuZWV0aCB3cm90ZToKPj4+IE9uIDIwMjAvMi8yNCAxNTowMywgUHJh
a2h5YSwgU2FpIFByYW5lZXRoIHdyb3RlOgo+Pj4+PiBPbiAyMDIwLzIvMjQgMTE6MjAsIFByYWto
eWEsIFNhaSBQcmFuZWV0aCB3cm90ZToKPj4+Pj4+Pj4gK8KgwqDCoCBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUoZ3JwX2RldiwgdGVtcCwgJmdyb3VwLT5kZXZpY2VzLCAKPj4+Pj4+Pj4gbGlzdCkg
ewo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2Owo+Pj4+Pj4+PiAr
Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBkZXYgPSBncnBfZGV2LT5kZXY7Cj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBpb21tdV9yZWxlYXNlX2RldmljZShkZXYpOwo+Pj4+Pj4+PiArCj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9ncm91cF9hZGRfZGV2aWNlKGdyb3VwLCBk
ZXYpOwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gYWRkIHRvIGlvbW11IGdyb3Vw
ICVkOiAlZFxuIiwKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncm91
cC0+aWQsIHJldCk7Cj4+Pj4+Pj4gTmVlZCB0byBoYW5kbGUgdGhpcyBlcnJvciBjYXNlLgo+Pj4+
Pj4gSSB3YXNuJ3Qgc3VyZSBvbiBob3cgdG8gaGFuZGxlIHRoZSBlcnJvciDimLkKPj4+Pj4gSnVz
dCByb2xsIGJhY2sgdG8gdGhlIHN0YXRlIGJlZm9yZSBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gYW5k
IHJldHVybgo+Pj4+PiBhbiBhcHByb3ByaWF0ZSBlcnJvciB2YWx1ZS4KPj4+Pj4KPj4+Pj4gVGhl
IGxpa2VseSBiZWhhdmlvciBpcyBkZXRhY2hpbmcgdGhlIG5ldyBkb21haW5zIGZyb20gYWxsIGRl
dmljZXMgKGlmCj4+Pj4+IGl0IGhhcyBhbHJlYWR5IGF0dGFjaGVkKSwgYXR0YWNoaW5nIHRoZSBv
bGQgZG9tYWlucyB0byBhbGwgZGV2aWNlcyBpbgo+Pj4+PiB0aGUgZ3JvdXAsCj4+Pj4gQW5kIHdo
aWxlIGhhbmRsaW5nIHRoaXMgZXJyb3IgY2FzZSwgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0aGF0
IAo+Pj4+IGF0dGFjaGluZyB0byBvbGQKPj4+IGRvbWFpbiBjb3VsZCBmYWlsLi4gc28sIHdlIG1p
Z2h0IG5lZWQgdG8gaGFuZGxlIHRoYXQgZXJyb3IgY2FzZSBhcyAKPj4+IHdlbGwuIElmIHdlCj4+
PiBwbGFuIHRvIGhhbmRsZSBlcnJvciBjYXNlLCBzaW5jZSB3ZSBoYXZlIHJlbW92ZWQgZGV2aWNl
cyBmcm9tIGdyb3VwIAo+Pj4gYWJvdmUsCj4+PiBhZGRpbmcgdGhlbSBiYWNrIGNvdWxkIGZhaWwg
dG9vLi4gdGhhdCB3b3VsZCBsZWFkIGludG8gaGFuZGxpbmcgZXJyb3IgCj4+PiBjYXNlIGZvciBh
bgo+Pj4gZXJyb3IgY2FzZS4KPj4+Cj4+PiBXZSBjYW4gYXNzdW1lIHRoYXQgdGhlIG9sZCBkb21h
aW4gc2hvdWxkIGFsd2F5cyBiZSBhdHRhY2hlZCBiYWNrLgo+Pj4gT3RoZXJ3aXNlLCB0aGVyZSBt
dXN0IGJlIHNvbWUgYnVncyBpbiB0aGUgdmVuZG9yIGlvbW11IGRyaXZlci4KPj4+Cj4+PiBJdCBt
dXN0IGJlIGFibGUgdG8gcm9sZSBiYWNrLCBvdGhlcndpc2UgdXNlcnMgaGF2ZSB0byByZWJvb3Qg
dGhlIAo+Pj4gc3lzdGVtIGluIG9yZGVyCj4+PiB0byB1c2UgdGhlIGRldmljZXMgaW4gdGhlIGdy
b3VwLiBUaGlzIGlzIG5vdCBhY2NlcHRhYmxlIGluIHRoZSAKPj4+IHByb2R1Y3Rpb24ga2VybmVs
Lgo+PiBJIGFncmVlIHRoYXQgd2Ugc2hvdWxkIGJlIGFibGUgdG8gcm9sbCBiYWNrIGJ1dCBJIGFt
IGFmcmFpZCB0aGF0IHRoZSAKPj4gZXJyb3IgaGFuZGxpbmcgY29kZSBjb3VsZCBiZWNvbWUgY29t
cGxleCB0aGFuIHRoZSB1c3VhbCBjb2RlIHRoYXQgZ2V0cyAKPj4gdG8gcnVuLiBGb3IgZXhhbXBs
ZSwgYXNzdW1lIHRoZXJlIGFyZSAnbicgZGV2aWNlcyBpbiB0aGUgZ3JvdXAsICdrJyBvZiAKPj4g
dGhlbSBhcmUgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZCAoaS5lLiBkZWZhdWx0IGRvbWFpbiB0eXBl
IGhhcyBiZWVuIAo+PiBjaGFuZ2VkKSBhbmQgaWYgaysxIGZhaWxzIHdoaWxlIGNoYW5naW5nIGRl
ZmF1bHQgZG9tYWluIHR5cGUsIHRvIHJvbGwgCj4+IGJhY2sgc3RhdGUgb2YgayBkZXZpY2VzLCB3
ZSBuZWVkIHRvIG1haW50YWluIGEgbGlzdCBvZiBwcm9jZXNzZWQgCj4+IGRldmljZXMgc28gdGhh
dCB3ZSBub3cgcm9sbCBiYWNrIHN0YXRlIGZvciBkZXZpY2VzIGluIHRoaXMgbGlzdC4gVGhlIAo+
PiBwcmVzZW50IGNvZGUgZG9lcyBub3QgaGF2ZSBhbnkgbGlzdCBiZWNhdXNlIGl0J3MgcHJvY2Vz
c2luZyAKPj4gc2VxdWVudGlhbGx5LCBpdCB0YWtlcyBhIGRldmljZSBmcm9tIHRoZSBncm91cCwg
Y2hhbmdlcyBpdCBkb21haW4gYW5kIAo+PiBtb3ZlcyB0byBvdGhlciBkZXZpY2UgYW5kIGhlbmNl
IGRvZXMgbm90IHJlcXVpcmUgYSBsaXN0Lgo+Pgo+PiBBbGwgc2FpZCwgSSBjb3VsZCBnaXZlIHRo
aXMgYSB0cnkgYW5kIHNlZSBob3cgY29tcGxleCB0aGUgY29kZSBjb3VsZCAKPj4gdHVybiBvdXQg
dG8gYmUuIEkgaG9wZSBJIGFtIHdyb25nIChpLmUuIHR1cm5zIG91dCBpbXBsZW1lbnRpbmcgZXJy
b3IgCj4+IGhhbmRsaW5nIGlzIHNpbXBsZSkuCj4+Cj4gCj4gSSB0aGluayBzb21ldGhpbmcgbGlr
ZSBiZWxvdyBzaG91bGQgd29yay4KPiAKPiBzdGF0aWMgaW50IGlvbW11X2dyb3VwX2RvX2F0dGFj
aF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQo+IHsKPiAgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluID0gZGF0YTsKPiAKPiAgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIF9faW9tbXVfYXR0YWNoX2RldmljZShkb21haW4sIGRldik7Cj4gfQo+IAo+
IHN0YXRpYyBpbnQgX19pb21tdV9hdHRhY2hfZ3JvdXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9t
YWluLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwKQo+IHsKPiAgwqDCoMKgwqDC
oMKgwqAgaW50IHJldDsKPiAKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGdyb3VwLT5kZWZhdWx0X2Rv
bWFpbiAmJiBncm91cC0+ZG9tYWluICE9IAo+IGdyb3VwLT5kZWZhdWx0X2RvbWFpbikKPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4gCj4gIMKgwqDCoMKg
wqDCoMKgIHJldCA9IF9faW9tbXVfZ3JvdXBfZm9yX2VhY2hfZGV2KGdyb3VwLCBkb21haW4sCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2dyb3VwX2RvX2F0dGFjaF9kZXZpY2UpOwo+
ICDCoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IDApCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBncm91cC0+ZG9tYWluID0gZG9tYWluOwo+IAo+ICDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+IH0KPiAKPiBUaGUgdmVuZG9yIGlvbW11IGRyaXZlciBzaG91bGQgYWx3YXlzIGRl
cHJlY2F0ZSB0aGUgb2xkIGRvbWFpbiBpZiBpdAo+IGV4aXN0cy4gQWRkIGEgY29tbWVudCB0aGVy
ZS4KPgoKQnkgdGhlIHdheSwgdGhpcyBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IuIFBsZWFzZSBj
aGVjawpfX2lvbW11X2RldGFjaF9ncm91cCgpLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
