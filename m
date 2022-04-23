Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE05BC433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 08:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FFFF83196;
	Sat, 23 Apr 2022 08:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6t8GDJrWcN_C; Sat, 23 Apr 2022 08:37:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25141831A9;
	Sat, 23 Apr 2022 08:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B98C0032;
	Sat, 23 Apr 2022 08:37:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66FFDC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D3A94016F
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxMieF2ojiDb for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 08:37:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4221840012
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 08:37:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E0B1FB;
 Sat, 23 Apr 2022 01:37:31 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AFF33F766;
 Sat, 23 Apr 2022 01:37:27 -0700 (PDT)
Message-ID: <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
Date: Sat, 23 Apr 2022 09:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
 <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
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

T24gMjAyMi0wNC0yMyAwOTowMSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMi80LzE5IDE1OjIwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjItMDQtMTkgMDA6
MzcsIEx1IEJhb2x1IHdyb3RlOgo+Pj4gT24gMjAyMi80LzE5IDY6MDksIFJvYmluIE11cnBoeSB3
cm90ZToKPj4+PiBPbiAyMDIyLTA0LTE2IDAxOjA0LCBMdSBCYW9sdSB3cm90ZToKPj4+Pj4gT24g
MjAyMi80LzE0IDIwOjQyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+PiBAQCAtMTg4MywyNyAr
MTkwMCwxMiBAQCBzdGF0aWMgaW50IGlvbW11X2J1c19pbml0KHN0cnVjdCBidXNfdHlwZSAKPj4+
Pj4+ICpidXMpCj4+Pj4+PiDCoMKgICovCj4+Pj4+PiDCoCBpbnQgYnVzX3NldF9pb21tdShzdHJ1
Y3QgYnVzX3R5cGUgKmJ1cywgY29uc3Qgc3RydWN0IGlvbW11X29wcyAKPj4+Pj4+ICpvcHMpCj4+
Pj4+PiDCoCB7Cj4+Pj4+PiAtwqDCoMKgIGludCBlcnI7Cj4+Pj4+PiAtCj4+Pj4+PiAtwqDCoMKg
IGlmIChvcHMgPT0gTlVMTCkgewo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3Bz
ID0gTlVMTDsKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4+IC3CoMKgwqAg
fQo+Pj4+Pj4gLQo+Pj4+Pj4gLcKgwqDCoCBpZiAoYnVzLT5pb21tdV9vcHMgIT0gTlVMTCkKPj4+
Pj4+ICvCoMKgwqAgaWYgKGJ1cy0+aW9tbXVfb3BzICYmIG9wcyAmJiBidXMtPmlvbW11X29wcyAh
PSBvcHMpCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQlVTWTsKPj4+Pj4+IMKg
wqDCoMKgwqAgYnVzLT5pb21tdV9vcHMgPSBvcHM7Cj4+Pj4+Cj4+Pj4+IERvIHdlIHN0aWxsIG5l
ZWQgdG8ga2VlcCBhYm92ZSBsaW5lcyBpbiBidXNfc2V0X2lvbW11KCk/Cj4+Pj4KPj4+PiBJdCBw
cmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGJlaGF2aW91ciB1bnRpbCBlYWNoIGNhbGxzaXRlIGFuZCBp
dHMgCj4+Pj4gYXNzb2NpYXRlZCBlcnJvciBoYW5kbGluZyBhcmUgcmVtb3ZlZCBsYXRlciBvbiwg
d2hpY2ggc2VlbXMgbGlrZSBhcyAKPj4+PiBnb29kIGEgdGhpbmcgdG8gZG8gYXMgYW55LiBTaW5j
ZSBJJ20gYWxyZWFkeSByZWxheGluZyAKPj4+PiBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSB0byBh
IHdhcm4tYnV0LWNvbnRpbnVlIGJlaGF2aW91ciB3aGlsZSBpdCAKPj4+PiBrZWVwcyB0aGUgYnVz
IG9wcyBvbiBsaWZlLXN1cHBvcnQgaW50ZXJuYWxseSwgSSBmaWd1cmVkIG5vdCBjaGFuZ2luZyAK
Pj4+PiB0b28gbXVjaCBhdCBvbmNlIHdvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIGJpc2VjdCBhbnkg
cG90ZW50aWFsIGlzc3VlcyAKPj4+PiBhcmlzaW5nIGZyb20gdGhpcyBmaXJzdCBzdGVwLgo+Pj4K
Pj4+IEZhaXIgZW5vdWdoLiBUaGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4KPj4+Cj4+PiBE
byB5b3UgaGF2ZSBhIHB1YmxpYyB0cmVlIHRoYXQgSSBjb3VsZCBwdWxsIHRoZXNlIHBhdGNoZXMg
YW5kIHRyeSB0aGVtCj4+PiBvbiBhbiBJbnRlbCBoYXJkd2FyZT8gT3IgcGVyaGFwcyB5b3UgaGF2
ZSBkb25lIHRoaXM/IEkgbGlrZSB0aGUgd2hvbGUKPj4+IGlkZWEgb2YgdGhpcyBzZXJpZXMsIGJ1
dCBpdCdzIGJldHRlciB0byB0cnkgaXQgd2l0aCBhIHJlYWwgaGFyZHdhcmUuCj4+Cj4+IEkgaGF2
ZW4ndCBib3RoZXJlZCB3aXRoIHNlcGFyYXRlIGJyYW5jaGVzIHNpbmNlIHRoZXJlJ3Mgc28gbWFu
eSAKPj4gZGlmZmVyZW50IHBpZWNlcyBpbi1mbGlnaHQsIGJ1dCBteSBjb21wbGV0ZSAodW5zdGFi
bGUpIGRldmVsb3BtZW50IAo+PiBicmFuY2ggY2FuIGJlIGZvdW5kIGhlcmU6Cj4+Cj4+IGh0dHBz
Oi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJtL2xpbnV4LXJtLy0vY29tbWl0cy9pb21tdS9idXMK
Pj4KPj4gRm9yIG5vdyBJJ2QgcmVjb21tZW5kIHdpbmRpbmcgdGhlIGhlYWQgYmFjayB0byAiaW9t
bXU6IENsZWFuIHVwIAo+PiBidXNfc2V0X2lvbW11KCkiIGZvciB0ZXN0aW5nIC0gc29tZSBvZiB0
aGUgcGF0Y2hlcyBhYm92ZSB0aGF0IGhhdmUgCj4+IGFscmVhZHkgYmVlbiBwb3N0ZWQgYW5kIHBp
Y2tlZCB1cCBieSB0aGVpciByZXNwZWN0aXZlIHN1YnN5c3RlbXMsIGJ1dCAKPj4gb3RoZXJzIGFy
ZSBpbmNvbXBsZXRlIGFuZCBiYXJlbHkgY29tcGlsZS10ZXN0ZWQuIEknbGwgcHJvYmFibHkgCj4+
IHJlYXJyYW5nZSBpdCBsYXRlciB0aGlzIHdlZWsgdG8gYmV0dGVyIHJlZmxlY3Qgd2hhdCdzIGhh
cHBlbmVkIHNvIGZhci4KPiAKPiBJIHdvdW5kIHRoZSBoZWFkIGJhY2sgdG8gImlvbW11OiBDbGVh
biB1cCBidXNfc2V0X2lvbW11IiBhbmQgdGVzdGVkIGl0Cj4gb24gYW4gSW50ZWwgbWFjaGluZS4g
SXQgZ290IHN0dWNrIGR1cmluZyBib290LiBUaGlzIHRlc3Qgd2FzIG9uIGEgcmVtb3RlCj4gbWFj
aGluZSBhbmQgSSBoYXZlIG5vIG1lYW5zIHRvIGFjY2VzcyBpdCBwaHlzaWNhbGx5LiBTbyBJIGNh
bid0IGdldCBhbnkKPiBrZXJuZWwgZGVidWdnaW5nIG1lc3NhZ2VzLiAoSSBoYXZlIHRvIHdvcmsg
ZnJvbSBob21lIHRoZXNlIGRheXMuIDotKCkKPiAKPiBJIGd1ZXNzIGl0J3MgZHVlIHRvIHRoZSBm
YWN0IHRoYXQgaW50ZWxfaW9tbXVfcHJvYmVfZGV2aWNlKCkgY2FsbGJhY2sKPiBvbmx5IHdvcmtz
IGZvciB0aGUgcGNpIGRldmljZXMuIFRoZSBpc3N1ZSBvY2N1cnMgd2hlbiBwcm9iaW5nIGEgZGV2
aWNlCj4gb3RoZXIgdGhhbiBhIFBDSSBvbmUuCgpZZWFoLCBJIHdhcyB3b25kZXJpbmcgaWYgdGhh
dCB3b3VsZCBiZSBzaWduaWZpY2FudCwgc2luY2UgaXQncyB0aGUgb25seSAKZHJpdmVyIHRoYXQg
bmV2ZXIgcmVnaXN0ZXJlZCBpdHNlbGYgZm9yIHBsYXRmb3JtX2J1c190eXBlIHNvIHdvbid0IGhh
dmUgCmFjdHVhbGx5IHNlZW4gdGhvc2UgY2FsbHMgYmVmb3JlLiBJJ20gaW5jbGluZWQgdG8gYm9k
Z2UgdGhhdCBhcyBiZWxvdyAKZm9yIG5vdywgYXMgbG9uZyBhcyBpdCB0aGVuIHdvcmtzIE9LIGlu
IHRlcm1zIG9mIHRoZSByZXN0IG9mIHRoZSBjaGFuZ2VzLgoKVGhhbmtzLApSb2Jpbi4KCi0tLS0t
PjgtLS0tLQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jCmluZGV4IDlmYTFiOTgxODZhMy4uNmUzNTlmOTJlYzAwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jCkBAIC00NTY1LDYgKzQ1NjUsMTAgQEAgc3RhdGljIHN0cnVjdCBpb21t
dV9kZXZpY2UgCippbnRlbF9pb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQog
IAl1bnNpZ25lZCBsb25nIGZsYWdzOwogIAl1OCBidXMsIGRldmZuOwoKKwkvKiBBTkREIHBsYXRm
b3JtIGRldmljZSBzdXBwb3J0IG5lZWRzIGZpeGluZyAqLworCWlmICghcGRldikKKwkJcmV0dXJu
IEVSUl9QVFIoLUVOT0RFVik7CisKICAJaW9tbXUgPSBkZXZpY2VfdG9faW9tbXUoZGV2LCAmYnVz
LCAmZGV2Zm4pOwogIAlpZiAoIWlvbW11KQogIAkJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
