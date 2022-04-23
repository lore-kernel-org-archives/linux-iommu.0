Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344B1C433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 08:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A0283F13;
	Sat, 23 Apr 2022 08:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7I3f7ZlSjUX; Sat, 23 Apr 2022 08:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C7F7883F10;
	Sat, 23 Apr 2022 08:51:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9D0C0032;
	Sat, 23 Apr 2022 08:51:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAECC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 621A841974
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vu3dXuVys__7 for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:51:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFAC741925
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650703889; x=1682239889;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=71X3VAZ/W4Qn+fhYYtVbqq7/IxbzVMIhPoTM4I0qmkg=;
 b=PfDCkikD7n8Fp8fbNFror77hKXhELfcONxf2yvDi6PRQnXnx2PmpMi12
 BlMQcK0AbtoRw8FrX2oobvb8YRlYmnqZCFnelRgts8Zu/O1dQOZZYYV1c
 dwGe85OzyfQBLOv3JLQkseY9PmJg+/BYNI3nRL2td1h68Quud4hobUrh8
 9+cH6QwTtt8Gug3p/Hut5kWBtKrxJ5k8VRAXeElmdqStJq/UIAfMZKaNh
 7CxJJeiRxdAmby1fNOmWLZf7XUk0QG3Pf2dwLU+UGBQk2vSrRjSo29hYL
 i7tQt655rXiMPfqddrp/YwXeCTUuSacJkebmzNm1fQcMJ1NMuc++O/Xrc w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252202789"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="252202789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:51:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="578323205"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 01:51:24 -0700
Message-ID: <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
Date: Sat, 23 Apr 2022 16:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
 <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
 <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

T24gMjAyMi80LzIzIDE2OjM3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNC0yMyAw
OTowMSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiAyMDIyLzQvMTkgMTU6
MjAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjItMDQtMTkgMDA6MzcsIEx1IEJhb2x1
IHdyb3RlOgo+Pj4+IE9uIDIwMjIvNC8xOSA2OjA5LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+
IE9uIDIwMjItMDQtMTYgMDE6MDQsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+Pj4gT24gMjAyMi80LzE0
IDIwOjQyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+Pj4gQEAgLTE4ODMsMjcgKzE5MDAsMTIg
QEAgc3RhdGljIGludCBpb21tdV9idXNfaW5pdChzdHJ1Y3QgYnVzX3R5cGUgCj4+Pj4+Pj4gKmJ1
cykKPj4+Pj4+PiDCoMKgICovCj4+Pj4+Pj4gwqAgaW50IGJ1c19zZXRfaW9tbXUoc3RydWN0IGJ1
c190eXBlICpidXMsIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgCj4+Pj4+Pj4gKm9wcykKPj4+Pj4+
PiDCoCB7Cj4+Pj4+Pj4gLcKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+IC0KPj4+Pj4+PiAtwqDCoMKg
IGlmIChvcHMgPT0gTlVMTCkgewo+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBidXMtPmlvbW11X29w
cyA9IE5VTEw7Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+IC3CoMKg
wqAgfQo+Pj4+Pj4+IC0KPj4+Pj4+PiAtwqDCoMKgIGlmIChidXMtPmlvbW11X29wcyAhPSBOVUxM
KQo+Pj4+Pj4+ICvCoMKgwqAgaWYgKGJ1cy0+aW9tbXVfb3BzICYmIG9wcyAmJiBidXMtPmlvbW11
X29wcyAhPSBvcHMpCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+
Pj4+Pj4gwqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9IG9wczsKPj4+Pj4+Cj4+Pj4+PiBEbyB3
ZSBzdGlsbCBuZWVkIHRvIGtlZXAgYWJvdmUgbGluZXMgaW4gYnVzX3NldF9pb21tdSgpPwo+Pj4+
Pgo+Pj4+PiBJdCBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGJlaGF2aW91ciB1bnRpbCBlYWNoIGNh
bGxzaXRlIGFuZCBpdHMgCj4+Pj4+IGFzc29jaWF0ZWQgZXJyb3IgaGFuZGxpbmcgYXJlIHJlbW92
ZWQgbGF0ZXIgb24sIHdoaWNoIHNlZW1zIGxpa2UgYXMgCj4+Pj4+IGdvb2QgYSB0aGluZyB0byBk
byBhcyBhbnkuIFNpbmNlIEknbSBhbHJlYWR5IHJlbGF4aW5nIAo+Pj4+PiBpb21tdV9kZXZpY2Vf
cmVnaXN0ZXIoKSB0byBhIHdhcm4tYnV0LWNvbnRpbnVlIGJlaGF2aW91ciB3aGlsZSBpdCAKPj4+
Pj4ga2VlcHMgdGhlIGJ1cyBvcHMgb24gbGlmZS1zdXBwb3J0IGludGVybmFsbHksIEkgZmlndXJl
ZCBub3QgCj4+Pj4+IGNoYW5naW5nIHRvbyBtdWNoIGF0IG9uY2Ugd291bGQgbWFrZSBpdCBlYXNp
ZXIgdG8gYmlzZWN0IGFueSAKPj4+Pj4gcG90ZW50aWFsIGlzc3VlcyBhcmlzaW5nIGZyb20gdGhp
cyBmaXJzdCBzdGVwLgo+Pj4+Cj4+Pj4gRmFpciBlbm91Z2guIFRoYW5rIHlvdSBmb3IgdGhlIGV4
cGxhbmF0aW9uLgo+Pj4+Cj4+Pj4gRG8geW91IGhhdmUgYSBwdWJsaWMgdHJlZSB0aGF0IEkgY291
bGQgcHVsbCB0aGVzZSBwYXRjaGVzIGFuZCB0cnkgdGhlbQo+Pj4+IG9uIGFuIEludGVsIGhhcmR3
YXJlPyBPciBwZXJoYXBzIHlvdSBoYXZlIGRvbmUgdGhpcz8gSSBsaWtlIHRoZSB3aG9sZQo+Pj4+
IGlkZWEgb2YgdGhpcyBzZXJpZXMsIGJ1dCBpdCdzIGJldHRlciB0byB0cnkgaXQgd2l0aCBhIHJl
YWwgaGFyZHdhcmUuCj4+Pgo+Pj4gSSBoYXZlbid0IGJvdGhlcmVkIHdpdGggc2VwYXJhdGUgYnJh
bmNoZXMgc2luY2UgdGhlcmUncyBzbyBtYW55IAo+Pj4gZGlmZmVyZW50IHBpZWNlcyBpbi1mbGln
aHQsIGJ1dCBteSBjb21wbGV0ZSAodW5zdGFibGUpIGRldmVsb3BtZW50IAo+Pj4gYnJhbmNoIGNh
biBiZSBmb3VuZCBoZXJlOgo+Pj4KPj4+IGh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJt
L2xpbnV4LXJtLy0vY29tbWl0cy9pb21tdS9idXMKPj4+Cj4+PiBGb3Igbm93IEknZCByZWNvbW1l
bmQgd2luZGluZyB0aGUgaGVhZCBiYWNrIHRvICJpb21tdTogQ2xlYW4gdXAgCj4+PiBidXNfc2V0
X2lvbW11KCkiIGZvciB0ZXN0aW5nIC0gc29tZSBvZiB0aGUgcGF0Y2hlcyBhYm92ZSB0aGF0IGhh
dmUgCj4+PiBhbHJlYWR5IGJlZW4gcG9zdGVkIGFuZCBwaWNrZWQgdXAgYnkgdGhlaXIgcmVzcGVj
dGl2ZSBzdWJzeXN0ZW1zLCBidXQgCj4+PiBvdGhlcnMgYXJlIGluY29tcGxldGUgYW5kIGJhcmVs
eSBjb21waWxlLXRlc3RlZC4gSSdsbCBwcm9iYWJseSAKPj4+IHJlYXJyYW5nZSBpdCBsYXRlciB0
aGlzIHdlZWsgdG8gYmV0dGVyIHJlZmxlY3Qgd2hhdCdzIGhhcHBlbmVkIHNvIGZhci4KPj4KPj4g
SSB3b3VuZCB0aGUgaGVhZCBiYWNrIHRvICJpb21tdTogQ2xlYW4gdXAgYnVzX3NldF9pb21tdSIg
YW5kIHRlc3RlZCBpdAo+PiBvbiBhbiBJbnRlbCBtYWNoaW5lLiBJdCBnb3Qgc3R1Y2sgZHVyaW5n
IGJvb3QuIFRoaXMgdGVzdCB3YXMgb24gYSByZW1vdGUKPj4gbWFjaGluZSBhbmQgSSBoYXZlIG5v
IG1lYW5zIHRvIGFjY2VzcyBpdCBwaHlzaWNhbGx5LiBTbyBJIGNhbid0IGdldCBhbnkKPj4ga2Vy
bmVsIGRlYnVnZ2luZyBtZXNzYWdlcy4gKEkgaGF2ZSB0byB3b3JrIGZyb20gaG9tZSB0aGVzZSBk
YXlzLiA6LSgpCj4+Cj4+IEkgZ3Vlc3MgaXQncyBkdWUgdG8gdGhlIGZhY3QgdGhhdCBpbnRlbF9p
b21tdV9wcm9iZV9kZXZpY2UoKSBjYWxsYmFjawo+PiBvbmx5IHdvcmtzIGZvciB0aGUgcGNpIGRl
dmljZXMuIFRoZSBpc3N1ZSBvY2N1cnMgd2hlbiBwcm9iaW5nIGEgZGV2aWNlCj4+IG90aGVyIHRo
YW4gYSBQQ0kgb25lLgo+IAo+IFllYWgsIEkgd2FzIHdvbmRlcmluZyBpZiB0aGF0IHdvdWxkIGJl
IHNpZ25pZmljYW50LCBzaW5jZSBpdCdzIHRoZSBvbmx5IAo+IGRyaXZlciB0aGF0IG5ldmVyIHJl
Z2lzdGVyZWQgaXRzZWxmIGZvciBwbGF0Zm9ybV9idXNfdHlwZSBzbyB3b24ndCBoYXZlIAo+IGFj
dHVhbGx5IHNlZW4gdGhvc2UgY2FsbHMgYmVmb3JlLiBJJ20gaW5jbGluZWQgdG8gYm9kZ2UgdGhh
dCBhcyBiZWxvdyAKPiBmb3Igbm93LCBhcyBsb25nIGFzIGl0IHRoZW4gd29ya3MgT0sgaW4gdGVy
bXMgb2YgdGhlIHJlc3Qgb2YgdGhlIGNoYW5nZXMuCj4gCj4gVGhhbmtzLAo+IFJvYmluLgo+IAo+
IC0tLS0tPjgtLS0tLQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBpbmRleCA5ZmExYjk4MTg2YTMuLjZlMzU5
ZjkyZWMwMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiArKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBAQCAtNDU2NSw2ICs0NTY1LDEwIEBAIHN0
YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlIAo+ICppbnRlbF9pb21tdV9wcm9iZV9kZXZpY2Uoc3Ry
dWN0IGRldmljZSAqZGV2KQo+ICDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICDCoMKg
wqDCoCB1OCBidXMsIGRldmZuOwo+IAo+ICvCoMKgwqAgLyogQU5ERCBwbGF0Zm9ybSBkZXZpY2Ug
c3VwcG9ydCBuZWVkcyBmaXhpbmcgKi8KPiArwqDCoMKgIGlmICghcGRldikKPiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7Cj4gKwo+ICDCoMKgwqDCoCBpb21tdSA9IGRl
dmljZV90b19pb21tdShkZXYsICZidXMsICZkZXZmbik7Cj4gIMKgwqDCoMKgIGlmICghaW9tbXUp
Cj4gIMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7CgpJIGhhdmVuJ3Qg
c2VlbiBhbnkgcmVhbCBBTkREIHBsYXRmb3JtIGRldmljZXMsIGhlbmNlIHRoaXMgd29ya3MgZm9y
IG1lLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
