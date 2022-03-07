Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D103C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 13:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF7A7410B4;
	Mon,  7 Mar 2022 13:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HgfL5b_97GV; Mon,  7 Mar 2022 13:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 994B74090D;
	Mon,  7 Mar 2022 13:12:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69FA9C001D;
	Mon,  7 Mar 2022 13:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C1D0C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A1B8405E3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ico3yxHHetjU for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 13:12:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 302A340470
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:12:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74BC6D6E;
 Mon,  7 Mar 2022 05:12:34 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574253F66F;
 Mon,  7 Mar 2022 05:12:33 -0800 (PST)
Message-ID: <b7a3e828-c848-2d42-9f91-d282b9c1ac9e@arm.com>
Date: Mon, 7 Mar 2022 13:12:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
 <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
 <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
 <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
In-Reply-To: <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

T24gMjAyMi0wMy0wNyAxMzowMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDMtMDcg
MTI6NDcsIEdpbGFkIEJlbi1Zb3NzZWYgd3JvdGU6Cj4+IE9uIE1vbiwgTWFyIDcsIDIwMjIgYXQg
MjozNiBQTSBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPj4+Cj4+
PiBPbiAyMDIyLTAzLTA3IDEyOjE3LCBHaWxhZCBCZW4tWW9zc2VmIHdyb3RlOgo+Pj4+IE9uIE1v
biwgTWFyIDcsIDIwMjIgYXQgMToxNCBQTSBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPiAKPj4+PiB3cm90ZToKPj4+Pgo+Pj4+PiBUaGUgIm92ZXJsYXAiIGlzIGluIHRoZSBzZW5z
ZSBvZiBoYXZpbmcgbW9yZSB0aGFuIG9uZSBtYXBwaW5nIAo+Pj4+PiB3aXRoaW4gdGhlCj4+Pj4+
IHNhbWUgY2FjaGVsaW5lOgo+Pj4+Pgo+Pj4+PiBbwqAgMTQyLjQ1ODEyMF0gRE1BLUFQSTogYWRk
X2RtYV9lbnRyeSBzdGFydCBQPWJhNzlmMjAwIE49YmE3OWYKPj4+Pj4gRD1iYTc5ZjIwMCBMPTEw
IERNQV9GUk9NX0RFVklDRSBhdHRycz0wCj4+Pj4+IFvCoCAxNDIuNDU4MTU2XSBETUEtQVBJOiBh
ZGRfZG1hX2VudHJ5IHN0YXJ0IFA9NDQ1ZGMwMTAgTj00NDVkYwo+Pj4+PiBEPTQ0NWRjMDEwIEw9
MTAgRE1BX1RPX0RFVklDRSBhdHRycz0wCj4+Pj4+IFvCoCAxNDIuNDU4MTc4XSBzdW44aS1zcyAx
YzE1MDAwLmNyeXB0bzogU1JDIDAvMS8xIDQ0NWRjMDAwIGxlbj0xNiBiaT0wCj4+Pj4+IFvCoCAx
NDIuNDU4MjE1XSBzdW44aS1zcyAxYzE1MDAwLmNyeXB0bzogRFNUIDAvMS8xIGJhNzlmMjAwIGxl
bj0xNiBiaT0wCj4+Pj4+IFvCoCAxNDIuNDU4MjM0XSBETUEtQVBJOiBhZGRfZG1hX2VudHJ5IHN0
YXJ0IFA9YmE3OWYyMTAgTj1iYTc5Zgo+Pj4+PiBEPWJhNzlmMjEwIEw9MTAgRE1BX0ZST01fREVW
SUNFIGF0dHJzPTAKPj4+Pj4KPj4+Pj4gVGhpcyBhY3R1YWxseSBpbGx1c3RyYXRlcyBleGFjdGx5
IHRoZSByZWFzb24gd2h5IHRoaXMgaXMgCj4+Pj4+IHVuc3VwcG9ydGFibGUuCj4+Pj4+IGJhNzlm
MjAwIGlzIG1hcHBlZCBmb3IgRE1BX0ZST01fREVWSUNFLCB0aGVyZWZvcmUgc3Vic2VxdWVudGx5
IG1hcHBpbmcKPj4+Pj4gYmE3OWYyMTAgZm9yIERNQV9UT19ERVZJQ0UgbWF5IGNhdXNlIHRoZSBj
YWNoZWxpbmUgY292ZXJpbmcgdGhlIHJhbmdlCj4+Pj4+IGJhNzlmMjAwLWJhNzlmMjNmIHRvIGJl
IHdyaXR0ZW4gYmFjayBvdmVyIHRoZSB0b3Agb2YgZGF0YSB0aGF0IHRoZQo+Pj4+PiBkZXZpY2Ug
aGFzIGFscmVhZHkgc3RhcnRlZCB0byB3cml0ZSB0byBtZW1vcnkuIEhlbGxvIGRhdGEgY29ycnVw
dGlvbi4KPj4+Pj4KPj4+Pj4gU2VwYXJhdGUgRE1BIG1hcHBpbmdzIHNob3VsZCBiZSBmcm9tIHNl
cGFyYXRlIG1lbW9yeSBhbGxvY2F0aW9ucywKPj4+Pj4gcmVzcGVjdGluZyBBUkNIX0RNQV9NSU5B
TElHTi4KPj4+Pgo+Pj4+IGhtbS4uLiBJIGtub3cgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUs
IGJ1dCBob3cgZG9lcyB0aGlzIGFsaWduIHdpdGgKPj4+PiB0aGUgZm9sbG93aW5nIGZyb20gYWN0
aXZlX2NhY2hlbGluZV9pbnNlcnQoKSBpbiBrZXJuZWwvZG1hL2RlYnVnLmMgPwo+Pj4+Cj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIElmIHRoZSBkZXZpY2UgaXMgbm90IHdyaXRpbmcgbWVtb3J5
IHRoZW4gd2UgZG9uJ3QgaGF2ZSBhbnkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNvbmNl
cm5zIGFib3V0IHRoZSBjcHUgY29uc3VtaW5nIHN0YWxlIGRhdGEuwqAgVGhpcyAKPj4+PiBtaXRp
Z2F0ZXMKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGxlZ2l0aW1hdGUgdXNhZ2VzIG9mIG92
ZXJsYXBwaW5nIG1hcHBpbmdzLgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChlbnRyeS0+ZGlyZWN0aW9uID09IERNQV9UT19ERVZJQ0UpCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Cj4+PiBJ
dCdzIE9LIHRvIGhhdmUgbXVsdGlwbGUgbWFwcGluZ3MgdGhhdCBhcmUgKmFsbCogRE1BX1RPX0RF
VklDRSwgd2hpY2gKPj4+IGxvb2tzIHRvIGJlIHRoZSBjYXNlIHRoYXQgdGhpcyBjaGVjayB3YXMg
aW50ZW5kZWQgdG8gYWxsb3cuIEhvd2V2ZXIgSQo+Pj4gdGhpbmsgeW91J3JlIHJpZ2h0IHRoYXQg
aXQgc2hvdWxkIHN0aWxsIGFjdHVhbGx5IGNoZWNrIGZvciBjb25mbGljdGluZwo+Pj4gZGlyZWN0
aW9ucyBiZXR3ZWVuIHRoZSBuZXcgZW50cnkgYW5kIGFueSBleGlzdGluZyBvbmVzLCBvdGhlcndp
c2UgaXQKPj4+IGVuZHMgdXAgYSBiaXQgdG9vIGxlbmllbnQuCj4+Pgo+Pj4gQ2hlZXJzLAo+Pj4g
Um9iaW4uCj4+Cj4+IEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgc2F5aW5nIGFib3V0IHdoeSBj
aGVja2luZyBmb3IgY29uZmxpY3RpbmcKPj4gZGlyZWN0aW9ucyBtYXkgYmUgYSBnb29kIHRoaW5n
LCBidXQgZ2l2ZW4gdGhhdCB0aGUgY29kZSBpcyBhcyBpdCBpcwo+PiByaWdodCBub3csIGhvdyBh
cmUgd2Ugc2VlaW5nIHRoZSB3YXJuaW5nIGZvciB0d28gbWFwcGluZyB0aGF0IG9uZSBvZgo+PiB0
aGVtIGlzIERNQV9UT19ERVZJQ0U/Cj4gCj4gQmVjYXVzZSBpdCdzIHRoZSBzZWNvbmQgb25lIHRo
YXQgaXNuJ3QuIFRoZSB3YXJuaW5nIGlzIHRyaWdnZXJlZCBieSAKPiBhZGRpbmcgdGhlIERNQV9G
Uk9NX0RFVklDRSBlbnRyeSwgd2hpY2ggKmlzKiBjaGVja2VkLCBhbmQgZmluZHMgdGhlIAo+IERN
QV9UT19ERVZJQ0UgZW50cnkgYWxyZWFkeSBwcmVzZW50LiBXaGF0J3Mgbm90IGdyZWF0IGlzIHRo
YXQgaWYgdGhvc2UgCj4gdHdvIG1hcHBpbmdzIGhhcHBlbmVkIHRvIGJlIG1hZGUgaW4gdGhlIG9w
cG9zaXRlIG9yZGVyIHRoZW4gaXQgd291bGQgYmUgCj4gbWlzc2VkIGVudGlyZWx5LgoKVXJnaCwg
bm8sIHNvcnJ5LCB0aGF0J3Mgc29tZSBpbWFnaW5hcnkgY29uZmxhdGlvbiBvZiB0aGUgY2FjaGVs
aW5lIHJhZGl4IAp0cmVlIHdpdGggdGhlIGVudHJ5IGhhc2ggYnVja2V0Li4uCgpXaGF0J3MgYWN0
dWFsbHkgaGFwcGVuZWQgaGVyZSBpcyB0aGF0IEkndmUgZmFpbGVkIHRvIHJlYWQgdGhlIGxvZyAK
cHJvcGVybHkgYW5kIHRoZXkncmUgYm90aCBETUFfRlJPTV9ERVZJQ0UuIEJ1dCB0aGUgcG90ZW50
aWFsIHByb2JsZW0gb2YgCm1peGVkLWRpcmVjdGlvbiBtYXBwaW5ncyBiZWluZyBtaXNzZWQgZG9l
cyBzdGlsbCBzdGFuZCBpbiBnZW5lcmFsLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
