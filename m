Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF15C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 05:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1788060E5F;
	Wed,  1 Jun 2022 05:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDNBam4MMb0Q; Wed,  1 Jun 2022 05:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6C4E60E2E;
	Wed,  1 Jun 2022 05:33:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A89D0C0032;
	Wed,  1 Jun 2022 05:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAAFFC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A9060E53
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNGjMsyczO06 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 05:33:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF82360E2E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 05:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654061624; x=1685597624;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8H5F2NUfv7ermpA8eablQSAS3teC1dmJ9SzBQt0ppCM=;
 b=QM0adqCEkVjbydw3TaZ1sj9JD30Vvhnf5Ek3cuj/QhYUeom4//8Iwms7
 27CRCo4b6kw+v65zPS0WU9MJ7YHLnQPAzV7dknIzAo6qfTCbndbWRxfV5
 O45wyf6DVF8tLVKu5cFoS+FfhYpiFyC6NB2f/knkkGjE4MqPTagnUccy6
 +PE19CAmuZYxeKQUonO9t1ZP3tESHD2xb41JK3LMNusP+OHG+lMKYq660
 Ubj9ZQGCctXExx6VT5JshLEisxu2cRWOjYp8QbsWYHFeMdvzZP3pS2lDF
 bGfkw96uk7LLoCgszhHteroUVwQTeMD+ID+zlEGvRN0WY2q0VFGSk/F9m w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="273042729"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="273042729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 22:33:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="706905410"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 22:33:38 -0700
Message-ID: <c9289db7-2d5b-4d1e-ca8b-261b12b264f3@linux.intel.com>
Date: Wed, 1 Jun 2022 13:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
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

SGkgUm9iaW4sCgpUaGFuayB5b3UgZm9yIHRoZSBjb21tZW50cy4KCk9uIDIwMjIvNS8zMSAyMTo1
MiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDUtMzEgMDQ6MDIsIEJhb2x1IEx1IHdy
b3RlOgo+PiBPbiAyMDIyLzUvMzAgMjA6MTQsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4+IE9u
IFN1biwgTWF5IDI5LCAyMDIyIGF0IDAxOjE0OjQ2UE0gKzA4MDAsIEJhb2x1IEx1IHdyb3RlOgoK
Wy0tc25pcC0tXQoKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvZGVidWdmcy5j
IAo+PiBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZGVidWdmcy5jCj4+IGluZGV4IGQ5MjdlZjEwNjQx
Yi4uZTZmNDgzNWI4ZDlmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2RlYnVn
ZnMuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RlYnVnZnMuYwo+PiBAQCAtMzMzLDI1
ICszMzMsMjggQEAgc3RhdGljIHZvaWQgcGd0YWJsZV93YWxrX2xldmVsKHN0cnVjdCBzZXFfZmls
ZSAKPj4gKm0sIHN0cnVjdCBkbWFfcHRlICpwZGUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnRpbnVlOwo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGF0aFtsZXZlbF0gPSBwZGUt
PnZhbDsKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChkbWFfcHRlX3N1cGVycGFnZShwZGUpIHx8IGxl
dmVsID09IDEpCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZG1hX3B0ZV9zdXBlcnBhZ2UocGRlKSB8
fCBsZXZlbCA9PSAxKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR1bXBfcGFnZV9p
bmZvKG0sIHN0YXJ0LCBwYXRoKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcGd0YWJsZV93YWxrX2xldmVsKG0sIHBoeXNfdG9fdmlydChkbWFfcHRl
X2FkZHIocGRlKSksCj4+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBoeXNfYWRkcjsKPj4gKwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwaHlzX2FkZHIgPSAodW5zaWduZWQgbG9uZylkbWFfcHRlX2FkZHIocGRlKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFwZm5fdmFsaWQoX19waHlzX3RvX3Bmbihw
aHlzX2FkZHIpKSkKPiAKPiBHaXZlbiB0aGF0IHB0ZV9wcmVzZW50KHBkZSkgcGFzc2VkIGp1c3Qg
YWJvdmUsIGl0IHdhcyBhbG1vc3QgY2VydGFpbmx5IGEgCj4gdmFsaWQgZW50cnksIHNvIGl0IHNl
ZW1zIHVubGlrZWx5IHRoYXQgdGhlIHBoeXNpY2FsIGFkZHJlc3MgaXQgcG9pbnRlZCAKPiB0byBj
b3VsZCBoYXZlIGRpc2FwcGVhcmVkIGluIHRoZSBtZWFudGltZS4gSWYgeW91J3JlIHdvcnJpZWQg
YWJvdXQgdGhlIAo+IHBvdGVudGlhbCBjYXNlIHdoZXJlIHdlJ3ZlIGJlZW4gcHJlZW1wdGVkIGR1
cmluZyB0aGlzIHdhbGsgZm9yIGxvbmcgCj4gZW5vdWdoIHRoYXQgdGhlIHBhZ2UgaGFzIGFscmVh
ZHkgYmVlbiBmcmVlZCBieSBhbiB1bm1hcCwgcmVhbGxvY2F0ZWQsIAoKWWVzLiBUaGlzIGlzIGV4
YWN0bHkgd2hhdCBJIGFtIHdvcnJpZWQgYWJvdXQgYW5kIHdoYXQgdGhpcyBwYXRjaCB3YW50cwp0
byBzb2x2ZS4KCj4gYW5kIGZpbGxlZCB3aXRoIHNvbWVvbmUgZWxzZSdzIGRhdGEgdGhhdCBoYXBw
ZW5zIHRvIGxvb2sgbGlrZSB2YWxpZCAKPiBQVEVzLCB0aGlzIHN0aWxsIGlzbid0IGVub3VnaCwg
c2luY2UgdGhhdCBkYXRhIGNvdWxkIGp1c3QgYXMgd2VsbCBoYXBwZW4gCj4gdG8gbG9vayBsaWtl
IHZhbGlkIHBoeXNpY2FsIGFkZHJlc3NlcyB0b28uCj4gSSBpbWFnaW5lIHRoYXQgaWYgeW91IHdh
bnQgdG8gc2FmZWx5IHdhbGsgcGFnZXRhYmxlcyBjb25jdXJyZW50bHkgd2l0aCAKPiB0aGVtIHBv
dGVudGlhbGx5IGJlaW5nIGZyZWVkLCB5b3UnZCBwcm9iYWJseSBuZWVkIHRvIGdldCBSQ1UgaW52
b2x2ZWQuCgpJIGRvbid0IHdhbnQgdG8gbWFrZSB0aGUgbWFwL3VubWFwIGludGVyZmFjZSBtb3Jl
IGNvbXBsZXggb3IgaW5lZmZpY2llbnQKYmVjYXVzZSBvZiBhIGRlYnVnZnMgZmVhdHVyZS4gSSBo
b3BlIHRoYXQgdGhlIGRlYnVnZnMgYW5kIG1hcC91bm1hcAppbnRlcmZhY2VzIGFyZSBvcnRob2dv
bmFsLCBqdXN0IGxpa2UgdGhlIElPTU1VIGhhcmR3YXJlIHRyYXZlcnNpbmcgdGhlCnBhZ2UgdGFi
bGVzLCBhcyBsb25nIGFzIHRoZSBhY2Nlc3NlZCBwaHlzaWNhbCBhZGRyZXNzIGlzIHZhbGlkIGFu
ZAphY2Nlc3NpYmxlLiBPdGhlcndpc2UsIHN0b3AgdGhlIHRyYXZlcnNhbCBpbW1lZGlhdGVseS4g
SWYgd2UgY2FuJ3QKYWNoaWV2ZSB0aGlzLCBJJ2QgcmF0aGVyIHN0b3Agc3VwcG9ydGluZyB0aGlz
IGRlYnVnZnMgbm9kZS4KCj4gCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBndGFibGVfd2Fsa19sZXZlbChtLCBwaHlz
X3RvX3ZpcnQocGh5c19hZGRyKSwKPiAKPiBBbHNvLCBvYmxpZ2F0b3J5IHJlbWluZGVyIHRoYXQg
cGZuX3ZhbGlkKCkgb25seSBtZWFucyB0aGF0IHBmbl90b19wYWdlKCkgCj4gZ2V0cyB5b3UgYSB2
YWxpZCBzdHJ1Y3QgcGFnZS4gV2hldGhlciB0aGF0IHBhZ2UgaXMgZGlyZWN0LW1hcHBlZCBrZXJu
ZWwgCj4gbWVtb3J5IG9yIG5vdCBpcyBhIGRpZmZlcmVudCBtYXR0ZXIuCgpQZXJoYXBzIEkgY2Fu
IGNoZWNrIHRoaXMgZnJvbSB0aGUgcGFnZSBmbGFncz8KCj4gCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXZlbCAtIDEsIHN0YXJ0LCBwYXRoKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBhdGhbbGV2ZWxdID0g
MDsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqB9Cj4+Cj4+IC1zdGF0aWMgaW50IHNob3dfZGV2aWNl
X2RvbWFpbl90cmFuc2xhdGlvbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgCj4+ICpkYXRhKQo+
PiArc3RhdGljIGludCBfX3Nob3dfZGV2aWNlX2RvbWFpbl90cmFuc2xhdGlvbihzdHJ1Y3QgZGV2
aWNlICpkZXYsIHZvaWQgCj4+ICpkYXRhKQo+PiDCoMKgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBk
ZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsKPj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiA9IGluZm8tPmRvbWFpbjsKPj4gwqDC
oMKgwqDCoCBzdHJ1Y3Qgc2VxX2ZpbGUgKm0gPSBkYXRhOwo+PiDCoMKgwqDCoMKgIHU2NCBwYXRo
WzZdID0geyAwIH07Cj4+Cj4+IC3CoMKgwqAgaWYgKCFkb21haW4pCj4+IC3CoMKgwqDCoMKgwqDC
oCByZXR1cm4gMDsKPj4gLQo+PiDCoMKgwqDCoMKgIHNlcV9wcmludGYobSwgIkRldmljZSAlcyBA
MHglbGx4XG4iLCBkZXZfbmFtZShkZXYpLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHU2
NCl2aXJ0X3RvX3BoeXMoZG9tYWluLT5wZ2QpKTsKPj4gwqDCoMKgwqDCoCBzZXFfcHV0cyhtLCAK
Pj4gIklPVkFfUEZOXHRcdFBNTDVFXHRcdFx0UE1MNEVcdFx0XHRQRFBFXHRcdFx0UERFXHRcdFx0
UFRFXG4iKTsKPj4gQEAgLTM1OSwyMCArMzYyLDI3IEBAIHN0YXRpYyBpbnQgc2hvd19kZXZpY2Vf
ZG9tYWluX3RyYW5zbGF0aW9uKHN0cnVjdCAKPj4gZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpCj4+
IMKgwqDCoMKgwqAgcGd0YWJsZV93YWxrX2xldmVsKG0sIGRvbWFpbi0+cGdkLCBkb21haW4tPmFn
YXcgKyAyLCAwLCBwYXRoKTsKPj4gwqDCoMKgwqDCoCBzZXFfcHV0YyhtLCAnXG4nKTsKPj4KPj4g
LcKgwqDCoCByZXR1cm4gMDsKPj4gK8KgwqDCoCByZXR1cm4gMTsKPj4gwqDCoH0KPj4KPj4gLXN0
YXRpYyBpbnQgZG9tYWluX3RyYW5zbGF0aW9uX3N0cnVjdF9zaG93KHN0cnVjdCBzZXFfZmlsZSAq
bSwgdm9pZCAKPj4gKnVudXNlZCkKPj4gK3N0YXRpYyBpbnQgc2hvd19kZXZpY2VfZG9tYWluX3Ry
YW5zbGF0aW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAKPj4gKmRhdGEpCj4+IMKgwqB7Cj4+
IC3CoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsKPj4gLcKgwqDCoCBpbnQgcmV0Owo+PiArwqDC
oMKgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXA7Cj4+Cj4+IC3CoMKgwqAgc3Bpbl9sb2NrX2ly
cXNhdmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOwo+PiAtwqDCoMKgIHJldCA9IGJ1c19m
b3JfZWFjaF9kZXYoJnBjaV9idXNfdHlwZSwgTlVMTCwgbSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaG93X2RldmljZV9kb21haW5fdHJhbnNsYXRpb24pOwo+PiAt
wqDCoMKgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3Mp
Owo+PiArwqDCoMKgIGdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0KGRldik7Cj4+ICvCoMKgwqAgaWYg
KGdyb3VwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV9ncm91cF9mb3JfZWFjaF9kZXYoZ3Jv
dXAsIGRhdGEsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9f
c2hvd19kZXZpY2VfZG9tYWluX3RyYW5zbGF0aW9uKTsKPiAKPiBXaHkgZ3JvdXBfZm9yX2VhY2hf
ZGV2PwoKVGhpcyB3aWxsIGhvbGQgdGhlIGdyb3VwIG11dGV4IHdoZW4gdGhlIGNhbGxiYWNrIGlz
IGludm9rZWQuIFdpdGggdGhlCmdyb3VwIG11dGV4IGhvbGQsIHRoZSBkb21haW4gY291bGQgbm90
IGdldCBjaGFuZ2VkLgoKPiBJZiB0aGVyZSAqYXJlKiBtdWx0aXBsZSBkZXZpY2VzIGluIHRoZSBn
cm91cCAKPiB0aGVuIGJ5IGRlZmluaXRpb24gdGhleSBzaG91bGQgYmUgYXR0YWNoZWQgdG8gdGhl
IHNhbWUgZG9tYWluLCBzbyAKPiBkdW1waW5nIHRoYXQgZG9tYWluJ3MgbWFwcGluZ3MgbW9yZSB0
aGFuIG9uY2Ugc2VlbXMgcG9pbnRsZXNzLiAKPiBFc3BlY2lhbGx5IGdpdmVuIHRoYXQgdGhlIG91
dGVyIGJ1c19mb3JfZWFjaF9kZXYgaXRlcmF0aW9uIHdpbGwgYWxyZWFkeSAKPiB2aXNpdCBlYWNo
IGluZGl2aWR1YWwgZGV2aWNlIGFueXdheSwgc28gdGhpcyB3b3VsZCBvbmx5IG1ha2UgdGhlIAo+
IHJlZHVuZGFuY3kgZXZlbiB3b3JzZSB0aGFuIGl0IGFscmVhZHkgaXMuCgpfX3Nob3dfZGV2aWNl
X2RvbWFpbl90cmFuc2xhdGlvbigpIG9ubHkgZHVtcHMgbWFwcGluZ3Mgb25jZSBhcyBpdCBhbHdh
eXMKcmV0dXJucyAxLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
