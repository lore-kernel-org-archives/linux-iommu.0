Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2DAC433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 09:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33606607B5;
	Sat, 23 Apr 2022 09:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hkhbPVpX3Tc5; Sat, 23 Apr 2022 09:00:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07B0A60A9E;
	Sat, 23 Apr 2022 09:00:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D66BAC0032;
	Sat, 23 Apr 2022 09:00:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8BEFC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6EAA4092D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nnUtKwxFjR7k for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 09:00:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8568F4092A
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650704449; x=1682240449;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=8FB4N5+BQcUfsB0XAhS4jENfvDwsU+GAIvqUf13Y6Qc=;
 b=BbNSmZP8lGkjeVswRr8yc2rKQxWODaF1F77dW+2QOqWeOxhqXIbLbIqT
 hYqujSNO0L5ULG62LADXkwlpUs3qI1vSEIaFn6hLJluHK506nIzThJA35
 Fd2BA6AmrUd+nq6NvCUxm7pEtUwLeq8evRiRaNSHOug0/HhkWF5Etar2p
 OFoiCFCPG6EDfaztdCL6z+5+9INWUJavjRLewZ1b/wHfeKqaX/v9bn8JX
 jg/dno8xbjKCghBGATrpc5TBP/k2fa/aBArHeO5cpThNXUIPhTMXrY/6l
 hKqN3hCdZRLiW0HYuIn9MzFcS1Y5qTf9TCDk+O61ojW+XYFPaHJcalto8 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246779974"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="246779974"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 02:00:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="578325099"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 02:00:46 -0700
Message-ID: <60d6a35e-5d12-b8c2-b0d2-7155965a10e5@linux.intel.com>
Date: Sat, 23 Apr 2022 17:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
 <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
 <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
 <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
In-Reply-To: <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi80LzIzIDE2OjUxLCBMdSBCYW9sdSB3cm90ZToKPiBPbiAyMDIyLzQvMjMgMTY6Mzcs
IFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wNC0yMyAwOTowMSwgTHUgQmFvbHUgd3Jv
dGU6Cj4+PiBIaSBSb2JpbiwKPj4+Cj4+PiBPbiAyMDIyLzQvMTkgMTU6MjAsIFJvYmluIE11cnBo
eSB3cm90ZToKPj4+PiBPbiAyMDIyLTA0LTE5IDAwOjM3LCBMdSBCYW9sdSB3cm90ZToKPj4+Pj4g
T24gMjAyMi80LzE5IDY6MDksIFJvYmluIE11cnBoeSB3cm90ZToKPj4+Pj4+IE9uIDIwMjItMDQt
MTYgMDE6MDQsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+Pj4+IE9uIDIwMjIvNC8xNCAyMDo0MiwgUm9i
aW4gTXVycGh5IHdyb3RlOgo+Pj4+Pj4+PiBAQCAtMTg4MywyNyArMTkwMCwxMiBAQCBzdGF0aWMg
aW50IGlvbW11X2J1c19pbml0KHN0cnVjdCAKPj4+Pj4+Pj4gYnVzX3R5cGUgKmJ1cykKPj4+Pj4+
Pj4gwqDCoCAqLwo+Pj4+Pj4+PiDCoCBpbnQgYnVzX3NldF9pb21tdShzdHJ1Y3QgYnVzX3R5cGUg
KmJ1cywgY29uc3Qgc3RydWN0IGlvbW11X29wcyAKPj4+Pj4+Pj4gKm9wcykKPj4+Pj4+Pj4gwqAg
ewo+Pj4+Pj4+PiAtwqDCoMKgIGludCBlcnI7Cj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4gLcKgwqDCoCBp
ZiAob3BzID09IE5VTEwpIHsKPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3Bz
ID0gTlVMTDsKPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+PiAtwqDC
oMKgIH0KPj4+Pj4+Pj4gLQo+Pj4+Pj4+PiAtwqDCoMKgIGlmIChidXMtPmlvbW11X29wcyAhPSBO
VUxMKQo+Pj4+Pj4+PiArwqDCoMKgIGlmIChidXMtPmlvbW11X29wcyAmJiBvcHMgJiYgYnVzLT5p
b21tdV9vcHMgIT0gb3BzKQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQlVT
WTsKPj4+Pj4+Pj4gwqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9IG9wczsKPj4+Pj4+Pgo+Pj4+
Pj4+IERvIHdlIHN0aWxsIG5lZWQgdG8ga2VlcCBhYm92ZSBsaW5lcyBpbiBidXNfc2V0X2lvbW11
KCk/Cj4+Pj4+Pgo+Pj4+Pj4gSXQgcHJlc2VydmVzIHRoZSBleGlzdGluZyBiZWhhdmlvdXIgdW50
aWwgZWFjaCBjYWxsc2l0ZSBhbmQgaXRzIAo+Pj4+Pj4gYXNzb2NpYXRlZCBlcnJvciBoYW5kbGlu
ZyBhcmUgcmVtb3ZlZCBsYXRlciBvbiwgd2hpY2ggc2VlbXMgbGlrZSAKPj4+Pj4+IGFzIGdvb2Qg
YSB0aGluZyB0byBkbyBhcyBhbnkuIFNpbmNlIEknbSBhbHJlYWR5IHJlbGF4aW5nIAo+Pj4+Pj4g
aW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCkgdG8gYSB3YXJuLWJ1dC1jb250aW51ZSBiZWhhdmlvdXIg
d2hpbGUgaXQgCj4+Pj4+PiBrZWVwcyB0aGUgYnVzIG9wcyBvbiBsaWZlLXN1cHBvcnQgaW50ZXJu
YWxseSwgSSBmaWd1cmVkIG5vdCAKPj4+Pj4+IGNoYW5naW5nIHRvbyBtdWNoIGF0IG9uY2Ugd291
bGQgbWFrZSBpdCBlYXNpZXIgdG8gYmlzZWN0IGFueSAKPj4+Pj4+IHBvdGVudGlhbCBpc3N1ZXMg
YXJpc2luZyBmcm9tIHRoaXMgZmlyc3Qgc3RlcC4KPj4+Pj4KPj4+Pj4gRmFpciBlbm91Z2guIFRo
YW5rIHlvdSBmb3IgdGhlIGV4cGxhbmF0aW9uLgo+Pj4+Pgo+Pj4+PiBEbyB5b3UgaGF2ZSBhIHB1
YmxpYyB0cmVlIHRoYXQgSSBjb3VsZCBwdWxsIHRoZXNlIHBhdGNoZXMgYW5kIHRyeSB0aGVtCj4+
Pj4+IG9uIGFuIEludGVsIGhhcmR3YXJlPyBPciBwZXJoYXBzIHlvdSBoYXZlIGRvbmUgdGhpcz8g
SSBsaWtlIHRoZSB3aG9sZQo+Pj4+PiBpZGVhIG9mIHRoaXMgc2VyaWVzLCBidXQgaXQncyBiZXR0
ZXIgdG8gdHJ5IGl0IHdpdGggYSByZWFsIGhhcmR3YXJlLgo+Pj4+Cj4+Pj4gSSBoYXZlbid0IGJv
dGhlcmVkIHdpdGggc2VwYXJhdGUgYnJhbmNoZXMgc2luY2UgdGhlcmUncyBzbyBtYW55IAo+Pj4+
IGRpZmZlcmVudCBwaWVjZXMgaW4tZmxpZ2h0LCBidXQgbXkgY29tcGxldGUgKHVuc3RhYmxlKSBk
ZXZlbG9wbWVudCAKPj4+PiBicmFuY2ggY2FuIGJlIGZvdW5kIGhlcmU6Cj4+Pj4KPj4+PiBodHRw
czovL2dpdGxhYi5hcm0uY29tL2xpbnV4LWFybS9saW51eC1ybS8tL2NvbW1pdHMvaW9tbXUvYnVz
Cj4+Pj4KPj4+PiBGb3Igbm93IEknZCByZWNvbW1lbmQgd2luZGluZyB0aGUgaGVhZCBiYWNrIHRv
ICJpb21tdTogQ2xlYW4gdXAgCj4+Pj4gYnVzX3NldF9pb21tdSgpIiBmb3IgdGVzdGluZyAtIHNv
bWUgb2YgdGhlIHBhdGNoZXMgYWJvdmUgdGhhdCBoYXZlIAo+Pj4+IGFscmVhZHkgYmVlbiBwb3N0
ZWQgYW5kIHBpY2tlZCB1cCBieSB0aGVpciByZXNwZWN0aXZlIHN1YnN5c3RlbXMsIAo+Pj4+IGJ1
dCBvdGhlcnMgYXJlIGluY29tcGxldGUgYW5kIGJhcmVseSBjb21waWxlLXRlc3RlZC4gSSdsbCBw
cm9iYWJseSAKPj4+PiByZWFycmFuZ2UgaXQgbGF0ZXIgdGhpcyB3ZWVrIHRvIGJldHRlciByZWZs
ZWN0IHdoYXQncyBoYXBwZW5lZCBzbyBmYXIuCj4+Pgo+Pj4gSSB3b3VuZCB0aGUgaGVhZCBiYWNr
IHRvICJpb21tdTogQ2xlYW4gdXAgYnVzX3NldF9pb21tdSIgYW5kIHRlc3RlZCBpdAo+Pj4gb24g
YW4gSW50ZWwgbWFjaGluZS4gSXQgZ290IHN0dWNrIGR1cmluZyBib290LiBUaGlzIHRlc3Qgd2Fz
IG9uIGEgcmVtb3RlCj4+PiBtYWNoaW5lIGFuZCBJIGhhdmUgbm8gbWVhbnMgdG8gYWNjZXNzIGl0
IHBoeXNpY2FsbHkuIFNvIEkgY2FuJ3QgZ2V0IGFueQo+Pj4ga2VybmVsIGRlYnVnZ2luZyBtZXNz
YWdlcy4gKEkgaGF2ZSB0byB3b3JrIGZyb20gaG9tZSB0aGVzZSBkYXlzLiA6LSgpCj4+Pgo+Pj4g
SSBndWVzcyBpdCdzIGR1ZSB0byB0aGUgZmFjdCB0aGF0IGludGVsX2lvbW11X3Byb2JlX2Rldmlj
ZSgpIGNhbGxiYWNrCj4+PiBvbmx5IHdvcmtzIGZvciB0aGUgcGNpIGRldmljZXMuIFRoZSBpc3N1
ZSBvY2N1cnMgd2hlbiBwcm9iaW5nIGEgZGV2aWNlCj4+PiBvdGhlciB0aGFuIGEgUENJIG9uZS4K
Pj4KPj4gWWVhaCwgSSB3YXMgd29uZGVyaW5nIGlmIHRoYXQgd291bGQgYmUgc2lnbmlmaWNhbnQs
IHNpbmNlIGl0J3MgdGhlIAo+PiBvbmx5IGRyaXZlciB0aGF0IG5ldmVyIHJlZ2lzdGVyZWQgaXRz
ZWxmIGZvciBwbGF0Zm9ybV9idXNfdHlwZSBzbyAKPj4gd29uJ3QgaGF2ZSBhY3R1YWxseSBzZWVu
IHRob3NlIGNhbGxzIGJlZm9yZS4gSSdtIGluY2xpbmVkIHRvIGJvZGdlIAo+PiB0aGF0IGFzIGJl
bG93IGZvciBub3csIGFzIGxvbmcgYXMgaXQgdGhlbiB3b3JrcyBPSyBpbiB0ZXJtcyBvZiB0aGUg
Cj4+IHJlc3Qgb2YgdGhlIGNoYW5nZXMuCj4+Cj4+IFRoYW5rcywKPj4gUm9iaW4uCj4+Cj4+IC0t
LS0tPjgtLS0tLQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IGluZGV4IDlmYTFiOTgxODZhMy4uNmUzNTlm
OTJlYzAwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gKysr
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IEBAIC00NTY1LDYgKzQ1NjUsMTAgQEAg
c3RhdGljIHN0cnVjdCBpb21tdV9kZXZpY2UgCj4+ICppbnRlbF9pb21tdV9wcm9iZV9kZXZpY2Uo
c3RydWN0IGRldmljZSAqZGV2KQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+
IMKgwqDCoMKgwqAgdTggYnVzLCBkZXZmbjsKPj4KPj4gK8KgwqDCoCAvKiBBTkREIHBsYXRmb3Jt
IGRldmljZSBzdXBwb3J0IG5lZWRzIGZpeGluZyAqLwo+PiArwqDCoMKgIGlmICghcGRldikKPj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwo+PiArCj4+IMKgwqDCoMKg
wqAgaW9tbXUgPSBkZXZpY2VfdG9faW9tbXUoZGV2LCAmYnVzLCAmZGV2Zm4pOwo+PiDCoMKgwqDC
oMKgIGlmICghaW9tbXUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRU5P
REVWKTsKPiAKPiBJIGhhdmVuJ3Qgc2VlbiBhbnkgcmVhbCBBTkREIHBsYXRmb3JtIGRldmljZXMs
IGhlbmNlIHRoaXMgd29ya3MgZm9yIG1lLgoKT3IgbW9yZSBwcmVjaXNlbHksIHJldHVybiBOVUxM
IHdoZW4gQGRldiBnb2VzIHRocm91Z2ggZGV2aWNlX3RvX2lvbW11KCk/CgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
CmluZGV4IGRmNWM2MmVjZjk0Mi4uMGQ0NDc3MzllMDc2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMKKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCkBAIC03
OTcsOCArNzk3LDExIEBAIHN0cnVjdCBpbnRlbF9pb21tdSAqZGV2aWNlX3RvX2lvbW11KHN0cnVj
dCBkZXZpY2UgCipkZXYsIHU4ICpidXMsIHU4ICpkZXZmbikKICAgICAgICAgICAgICAgICBwZl9w
ZGV2ID0gcGNpX3BoeXNmbihwZGV2KTsKICAgICAgICAgICAgICAgICBkZXYgPSAmcGZfcGRldi0+
ZGV2OwogICAgICAgICAgICAgICAgIHNlZ21lbnQgPSBwY2lfZG9tYWluX25yKHBkZXYtPmJ1cyk7
Ci0gICAgICAgfSBlbHNlIGlmIChoYXNfYWNwaV9jb21wYW5pb24oZGV2KSkKKyAgICAgICB9IGVs
c2UgaWYgKGhhc19hY3BpX2NvbXBhbmlvbihkZXYpKSB7CiAgICAgICAgICAgICAgICAgZGV2ID0g
JkFDUElfQ09NUEFOSU9OKGRldiktPmRldjsKKyAgICAgICB9IGVsc2UgeworICAgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7CisgICAgICAgfQoKICAgICAgICAgcmN1X3JlYWRfbG9jaygpOwogICAg
ICAgICBmb3JfZWFjaF9pb21tdShpb21tdSwgZHJoZCkgewoKQmVzdCByZWdhcmRzLApiYW9sdQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
