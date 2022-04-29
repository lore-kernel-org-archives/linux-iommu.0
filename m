Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8446C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 639AD41CB1;
	Fri, 29 Apr 2022 08:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cuyhBBzwdyho; Fri, 29 Apr 2022 08:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91F9D41CAE;
	Fri, 29 Apr 2022 08:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B979C0039;
	Fri, 29 Apr 2022 08:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9DFC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A320160D73
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LkrTFExHv_HA for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7135660AB2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:50:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8CB1063;
 Fri, 29 Apr 2022 01:50:33 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96C363F73B;
 Fri, 29 Apr 2022 01:50:30 -0700 (PDT)
Message-ID: <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
Date: Fri, 29 Apr 2022 09:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
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

T24gMjAyMi0wNC0yOSAwNzo1NywgQmFvbHUgTHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMi80LzI4IDIxOjE4LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE1vdmUgdGhlIGJ1cyBzZXR1
cCB0byBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKS4gVGhpcyBzaG91bGQgYWxsb3cKPj4gYnVzX2lv
bW11X3Byb2JlKCkgdG8gYmUgY29ycmVjdGx5IHJlcGxheWVkIGZvciBtdWx0aXBsZSBJT01NVSBp
bnN0YW5jZXMsCj4+IGFuZCBsZWF2ZXMgYnVzX3NldF9pb21tdSgpIGFzIGEgZ2xvcmlmaWVkIG5v
LW9wIHRvIGJlIGNsZWFuZWQgdXAgbmV4dC4KPiAKPiBJIHJlLWZldGNoZWQgdGhlIGxhdGVzdCBw
YXRjaGVzIG9uCj4gCj4gaHR0cHM6Ly9naXRsYWIuYXJtLmNvbS9saW51eC1hcm0vbGludXgtcm0v
LS9jb21taXRzL2lvbW11L2J1cwo+IAo+IGFuZCByb2xsZWQgYmFjayB0aGUgaGVhZCB0byAiaW9t
bXU6IENsZWFudXAgYnVzX3NldF9pb21tdSIuCj4gCj4gVGhlIHRlc3QgbWFjaGluZSBzdGlsbCBo
YW5ncyBkdXJpbmcgYm9vdC4KPiAKPiBJIHdlbnQgdGhyb3VnaCB0aGUgY29kZS4gSXQgc2VlbXMg
dGhhdCB0aGUgLnByb2JlX2RldmljZSBmb3IgSW50ZWwgSU9NTVUKPiBkcml2ZXIgY2FuJ3QgaGFu
ZGxlIHRoZSBwcm9iZSByZXBsYXkgd2VsbC4gSXQgYWx3YXlzIGFzc3VtZXMgdGhhdCB0aGUKPiBk
ZXZpY2UgaGFzIG5ldmVyIGJlZW4gcHJvYmVkLgoKSG1tLCBidXQgcHJvYmVfaW9tbXVfZ3JvdXAo
KSBpcyBzdXBwb3NlZCB0byBwcmV2ZW50IHRoZSAKX19pb21tdV9wcm9iZV9kZXZpY2UoKSBjYWxs
IGV2ZW4gaGFwcGVuaW5nIGlmIHRoZSBkZXZpY2UgKmhhcyogYWxyZWFkeSAKYmVlbiBwcm9iZWQg
YmVmb3JlIDovCgpJJ3ZlIHN0aWxsIGdvdCBhbiBvbGQgSW50ZWwgYm94IHNwYXJlIGluIHRoZSBv
ZmZpY2Ugc28gSSdsbCByaWcgdGhhdCB1cCAKYW5kIHNlZSBpZiBJIGNhbiBzZWUgd2hhdCBtaWdo
dCBiZSBnb2luZyBvbiBoZXJlLi4uCgpUaGFua3MsClJvYmluLgoKPiAKPiBCZXN0IHJlZ2FyZHMs
Cj4gYmFvbHUKPiAKPj4KPj4gQXQgdGhpcyBwb2ludCB3ZSBjYW4gYWxzbyBoYW5kbGUgY2xlYW51
cCBiZXR0ZXIgdGhhbiBqdXN0IHJvbGxpbmcgYmFjawo+PiB0aGUgbW9zdC1yZWNlbnRseS10b3Vj
aGVkIGJ1cyB1cG9uIGZhaWx1cmUgLSB3aGljaCBtYXkgcmVsZWFzZSBkZXZpY2VzCj4+IG93bmVk
IGJ5IG90aGVyIGFscmVhZHktcmVnaXN0ZXJlZCBpbnN0YW5jZXMsIGFuZCBzdGlsbCBsZWF2ZSBk
ZXZpY2VzIG9uCj4+IG90aGVyIGJ1c2VzIHdpdGggZGFuZ2xpbmcgcG9pbnRlcnMgdG8gdGhlIGZh
aWxlZCBpbnN0YW5jZS4gTm93IGl0J3MgZWFzeQo+PiB0byBjbGVhbiB1cCB0aGUgZXhhY3QgZm9v
dHByaW50IG9mIGEgZ2l2ZW4gaW5zdGFuY2UsIG5vIG1vcmUsIG5vIGxlc3MuCj4+Cj4+IFRlc3Rl
ZC1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+PiAtLS0KPj4g
wqAgZHJpdmVycy9pb21tdS9pb21tdS5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
MjQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gaW5kZXggNmM0NjIxYWZjOGNmLi5jODlhZjRkYzU0
YzIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiArKysgYi9kcml2ZXJz
L2lvbW11L2lvbW11LmMKPj4gQEAgLTE3NSw2ICsxNzUsMTQgQEAgc3RhdGljIGludCBfX2luaXQg
aW9tbXVfc3Vic3lzX2luaXQodm9pZCkKPj4gwqAgfQo+PiDCoCBzdWJzeXNfaW5pdGNhbGwoaW9t
bXVfc3Vic3lzX2luaXQpOwo+PiArc3RhdGljIGludCByZW1vdmVfaW9tbXVfZ3JvdXAoc3RydWN0
IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQo+PiArewo+PiArwqDCoMKgIGlmIChkZXYtPmlvbW11
ICYmIGRldi0+aW9tbXUtPmlvbW11X2RldiA9PSBkYXRhKQo+PiArwqDCoMKgwqDCoMKgwqAgaW9t
bXVfcmVsZWFzZV9kZXZpY2UoZGV2KTsKPj4gKwo+PiArwqDCoMKgIHJldHVybiAwOwo+PiArfQo+
PiArCj4+IMKgIC8qKgo+PiDCoMKgICogaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCkgLSBSZWdpc3Rl
ciBhbiBJT01NVSBoYXJkd2FyZSBpbnN0YW5jZQo+PiDCoMKgICogQGlvbW11OiBJT01NVSBoYW5k
bGUgZm9yIHRoZSBpbnN0YW5jZQo+PiBAQCAtMTk3LDEyICsyMDUsMjkgQEAgaW50IGlvbW11X2Rl
dmljZV9yZWdpc3RlcihzdHJ1Y3QgaW9tbXVfZGV2aWNlIAo+PiAqaW9tbXUsCj4+IMKgwqDCoMKg
wqAgc3Bpbl9sb2NrKCZpb21tdV9kZXZpY2VfbG9jayk7Cj4+IMKgwqDCoMKgwqAgbGlzdF9hZGRf
dGFpbCgmaW9tbXUtPmxpc3QsICZpb21tdV9kZXZpY2VfbGlzdCk7Cj4+IMKgwqDCoMKgwqAgc3Bp
bl91bmxvY2soJmlvbW11X2RldmljZV9sb2NrKTsKPj4gKwo+PiArwqDCoMKgIGZvciAoaW50IGkg
PSAwOyBpIDwgQVJSQVlfU0laRShpb21tdV9idXNlcyk7IGkrKykgewo+PiArwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGJ1c190eXBlICpidXMgPSBpb21tdV9idXNlc1tpXTsKPj4gK8KgwqDCoMKgwqDC
oMKgIGludCBlcnI7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIFdBUk5fT04oYnVzLT5pb21tdV9v
cHMgJiYgYnVzLT5pb21tdV9vcHMgIT0gb3BzKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGJ1cy0+aW9t
bXVfb3BzID0gb3BzOwo+PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gYnVzX2lvbW11X3Byb2JlKGJ1
cyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlvbW11X2RldmljZV91bnJlZ2lzdGVyKGlvbW11KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGVycjsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+ICsK
Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiDCoCBFWFBPUlRfU1lNQk9MX0dQTChp
b21tdV9kZXZpY2VfcmVnaXN0ZXIpOwo+PiDCoCB2b2lkIGlvbW11X2RldmljZV91bnJlZ2lzdGVy
KHN0cnVjdCBpb21tdV9kZXZpY2UgKmlvbW11KQo+PiDCoCB7Cj4+ICvCoMKgwqAgZm9yIChpbnQg
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKGlvbW11X2J1c2VzKTsgaSsrKQo+PiArwqDCoMKgwqDCoMKg
wqAgYnVzX2Zvcl9lYWNoX2Rldihpb21tdV9idXNlc1tpXSwgTlVMTCwgaW9tbXUsIAo+PiByZW1v
dmVfaW9tbXVfZ3JvdXApOwo+PiArCj4+IMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZpb21tdV9kZXZp
Y2VfbG9jayk7Cj4+IMKgwqDCoMKgwqAgbGlzdF9kZWwoJmlvbW11LT5saXN0KTsKPj4gwqDCoMKg
wqDCoCBzcGluX3VubG9jaygmaW9tbXVfZGV2aWNlX2xvY2spOwo+PiBAQCAtMTY1NSwxMyArMTY4
MCw2IEBAIHN0YXRpYyBpbnQgcHJvYmVfaW9tbXVfZ3JvdXAoc3RydWN0IGRldmljZSAKPj4gKmRl
diwgdm9pZCAqZGF0YSkKPj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCB9Cj4+IC1zdGF0
aWMgaW50IHJlbW92ZV9pb21tdV9ncm91cChzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEp
Cj4+IC17Cj4+IC3CoMKgwqAgaW9tbXVfcmVsZWFzZV9kZXZpY2UoZGV2KTsKPj4gLQo+PiAtwqDC
oMKgIHJldHVybiAwOwo+PiAtfQo+PiAtCj4+IMKgIHN0YXRpYyBpbnQgaW9tbXVfYnVzX25vdGlm
aWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKQo+PiDCoCB7
Cj4+IEBAIC0xODg0LDI3ICsxOTAyLDEyIEBAIHN0YXRpYyBpbnQgaW9tbXVfYnVzX2luaXQoc3Ry
dWN0IGJ1c190eXBlICpidXMpCj4+IMKgwqAgKi8KPj4gwqAgaW50IGJ1c19zZXRfaW9tbXUoc3Ry
dWN0IGJ1c190eXBlICpidXMsIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcykKPj4gwqAgewo+
PiAtwqDCoMKgIGludCBlcnI7Cj4+IC0KPj4gLcKgwqDCoCBpZiAob3BzID09IE5VTEwpIHsKPj4g
LcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3BzID0gTlVMTDsKPj4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiAwOwo+PiAtwqDCoMKgIH0KPj4gLQo+PiAtwqDCoMKgIGlmIChidXMtPmlvbW11X29w
cyAhPSBOVUxMKQo+PiArwqDCoMKgIGlmIChidXMtPmlvbW11X29wcyAmJiBvcHMgJiYgYnVzLT5p
b21tdV9vcHMgIT0gb3BzKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQlVTWTsKPj4g
wqDCoMKgwqDCoCBidXMtPmlvbW11X29wcyA9IG9wczsKPj4gLcKgwqDCoCAvKiBEbyBJT01NVSBz
cGVjaWZpYyBzZXR1cCBmb3IgdGhpcyBidXMtdHlwZSAqLwo+PiAtwqDCoMKgIGVyciA9IGJ1c19p
b21tdV9wcm9iZShidXMpOwo+PiAtwqDCoMKgIGlmIChlcnIpIHsKPj4gLcKgwqDCoMKgwqDCoMKg
IC8qIENsZWFuIHVwICovCj4+IC3CoMKgwqDCoMKgwqDCoCBidXNfZm9yX2VhY2hfZGV2KGJ1cywg
TlVMTCwgTlVMTCwgcmVtb3ZlX2lvbW11X2dyb3VwKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+
aW9tbXVfb3BzID0gTlVMTDsKPj4gLcKgwqDCoCB9Cj4+IC0KPj4gLcKgwqDCoCByZXR1cm4gZXJy
Owo+PiArwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKGJ1
c19zZXRfaW9tbXUpOwo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
