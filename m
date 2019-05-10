Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D4C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 05:36:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EB42175B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 05:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EB42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F2919DB6;
	Fri, 10 May 2019 05:36:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84EC0D8E
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 05:36:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A4B3F1FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 05:36:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 22:36:01 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 09 May 2019 22:35:59 -0700
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
	type
To: Robin Murphy <robin.murphy@arm.com>, Tom Murphy <tmurphy@arista.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
	<20190429020925.18136-2-baolu.lu@linux.intel.com>
	<CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
	<bba1f327-21b7-ed3c-8fd4-217ad97a6a7c@arm.com>
	<3e0da076-4916-1a02-615c-927c1b3528b8@linux.intel.com>
	<56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6dbbfc10-3247-744c-ae8d-443a336e0c50@linux.intel.com>
Date: Fri, 10 May 2019 13:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <56205a21-c72f-a460-77a2-4bb4f46f6e08@arm.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgUm9iaW4sCgpPbiA1LzEwLzE5IDEyOjExIEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MDkvMDUvMjAxOSAwMzozMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiA1
LzcvMTkgNjoyOCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMDYvMDUvMjAxOSAxNjoz
MiwgVG9tIE11cnBoeSB2aWEgaW9tbXUgd3JvdGU6Cj4+Pj4gVGhlIEFNRCBkcml2ZXIgYWxyZWFk
eSBzb2x2ZXMgdGhpcyBwcm9ibGVtIGFuZCB1c2VzIHRoZSBnZW5lcmljCj4+Pj4gaW9tbXVfcmVx
dWVzdF9kbV9mb3JfZGV2IGZ1bmN0aW9uLiBJdCBzZWVtcyBsaWtlIGJvdGggZHJpdmVycyBoYXZl
IHRoZQo+Pj4+IHNhbWUgcHJvYmxlbSBhbmQgY291bGQgdXNlIHRoZSBzYW1lIHNvbHV0aW9uLiBJ
cyB0aGVyZSBhbnkgcmVhc29uIHdlCj4+Pj4gY2FuJ3QgaGF2ZSB1c2UgdGhlIHNhbWUgc29sdXRp
b24gZm9yIHRoZSBpbnRlbCBhbmQgYW1kIGRyaXZlcj8KPj4+Pgo+Pj4+IENvdWxkIHdlIGp1c3TC
oCBjb3B5IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQU1EIGRyaXZlcj8gSXQgd291bGQgYmUK
Pj4+PiBuaWNlIHRvIGhhdmUgdGhlIHNhbWUgYmVoYXZpb3IgYWNyb3NzIGJvdGggZHJpdmVycyBl
c3BlY2lhbGx5IGFzIHdlCj4+Pj4gbW92ZSB0byBtYWtlIGJvdGggZHJpdmVycyB1c2UgbW9yZSBn
ZW5lcmljIGNvZGUuCj4+Pgo+Pj4gVEJIIEkgZG9uJ3QgdGhpbmsgdGhlIEFQSSByZWFsbHkgbmVl
ZHMgdG8gYmUgaW52b2x2ZWQgYXQgYWxsIGhlcmUuIAo+Pj4gRHJpdmVycyBjYW4gYWxyZWFkeSBu
b3QgcHJvdmlkZSB0aGUgcmVxdWVzdGVkIGRlZmF1bHQgZG9tYWluIHR5cGUgaWYgCj4+PiB0aGV5
IGRvbid0IHN1cHBvcnQgaXQsIHNvIGFzIGxvbmcgYXMgdGhlIGRyaXZlciBjYW4gZW5zdXJlIHRo
YXQgdGhlIAo+Pj4gZGV2aWNlIGVuZHMgdXAgd2l0aCBJT01NVSBvciBkaXJlY3QgRE1BIG9wcyBh
cyBhcHByb3ByaWF0ZSwgSSBkb24ndCAKPj4+IHNlZSBhbnkgZ3JlYXQgcHJvYmxlbSB3aXRoIGRy
aXZlcnMganVzdCByZXR1cm5pbmcgYSBwYXNzdGhyb3VnaCAKPj4+IGRvbWFpbiB3aGVuIGEgRE1B
IGRvbWFpbiB3YXMgcmVxdWVzdGVkLCBvciB2aWNlIHZlcnNhIChhbmQgbG9nZ2luZyBhIAo+Pj4g
bWVzc2FnZSB0aGF0IHRoZSByZXF1ZXN0ZWQgdHlwZSB3YXMgb3ZlcnJpZGRlbikuIFRoZSBvbmx5
IHR5cGUgdGhhdCAKPj4+IHdlIHJlYWxseSBkbyBoYXZlIHRvIGhvbm91ciBzdHJpY3RseSBpcyBu
b24tZGVmYXVsdCAoaS5lLiB1bm1hbmFnZWQpIAo+Pj4gZG9tYWlucy4KPj4KPj4gSSBhZ3JlZSB3
aXRoIHlvdSB0aGF0IHdlIG9ubHkgaGF2ZSB0byBob25vciBzdHJpY3RseSB0aGUgbm9uLWRlZmF1
bHQKPj4gZG9tYWlucy4gQnV0IGRvbWFpbiB0eXBlIHNhdmVkIGluIGlvbW11X2RvbWFpbiBpcyBj
b25zdW1lZCBpbiBpb21tdS5jCj4+IGFuZCBleHBvc2VkIHRvIHVzZXIgdGhyb3VnaCBzeXNmcy4g
SXQncyBub3QgY2xlYW4gaWYgdGhlIGlvbW11IGRyaXZlcgo+PiBzaWxlbnRseSByZXBsYWNlIHRo
ZSBkZWZhdWx0IGRvbWFpbi4KPiAKPiBSaWdodCwgSSBkaWQgZ2V0IGEgYml0IGFoZWFkIG9mIG15
c2VsZiB0aGVyZSAtIHRoZSBpbXBsaWNpdCBzdGVwIGJlZm9yZSAKPiB0aGF0IGlzIHRvIGZpeCBk
ZWZhdWx0IGRvbWFpbiBhbGxvY2F0aW9uIHNvIHRoYXQgdGhlIGNvcmUgYWN0dWFsbHkgCj4gcGFz
c2VzIHRoZSByZWxldmFudCBkZXZpY2Ugd2hpY2ggaXQgaGFzIHRvIGhhbmQsIHN1Y2ggdGhhdCB0
aGUgSU9NTVUgCj4gZHJpdmVycyAqY2FuKiBtYWtlIHRoZSByaWdodCBkZWNpc2lvbiB1cC1mcm9u
dC4KPiAKClllcywgcGFzc2luZyB0aGUgcmVsZXZhbnQgZGV2aWNlIHdoZW4gYWxsb2NhdGluZyB0
aGUgZGVmYXVsdCBkb21haW4gc28KdGhhdCB0aGUgSU9NTVUgZHJpdmVyIGNvdWxkIG1ha2Ugcmln
aHQgZGVjaXNpb24gc2VlbXMgdG8gYmUgYSBiZXR0ZXIKc29sdXRpb24uIFNvbWVib2R5IGNhbiBj
b21lIHVwIHdpdGggYSBwYXRjaCBzZXQgdG8gYnJpbmcgdGhpcyB1cCBmb3IKZGlzY3Vzc2lvbi4g
SSB3b24ndCBpbmNsdWRlIHRoaXMgaW4gdGhpcyBwYXRjaCBzZXQgc2luY2UgaXQncyBub3QgZm9y
CnRoYXQgcHVycG9zZS4gSSB3aWxsIGZvbGxvdyB0aGUgZXhpc3RpbmcgbWVjaGFuaXNtIHRoYXQg
aXMgdXNpbmcgb24gYW1kCmFuZCBvdGhlciBpb21tdSBkcml2ZXJzLgoKQmVzdCByZWdhcmRzLApM
dSBCYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
