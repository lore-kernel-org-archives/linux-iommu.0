Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C6C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 10:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0826A415C0;
	Wed,  8 Jun 2022 10:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0rXjYvZrAnb; Wed,  8 Jun 2022 10:54:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53C304159A;
	Wed,  8 Jun 2022 10:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2551DC0039;
	Wed,  8 Jun 2022 10:54:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9D5C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C7BD8402A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCBbnWS9WRDP for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 10:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C75383F71
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:54:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39283139F;
 Wed,  8 Jun 2022 03:54:29 -0700 (PDT)
Received: from [10.57.83.136] (unknown [10.57.83.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897F33F73B;
 Wed,  8 Jun 2022 03:54:26 -0700 (PDT)
Message-ID: <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
Date: Wed, 8 Jun 2022 11:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-GB
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, Will Deacon <will@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
 <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
 <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, martin.botka@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi0wNi0wOCAxMToyNywgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6Cj4g
SWwgMDYvMDYvMjIgMDA6MDYsIE1hcmlqbiBTdWlqdGVuIGhhIHNjcml0dG86Cj4+IE9uIDIwMjIt
MDUtMzEgMTY6NTU6NTksIFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4gT24gRnJpLCBNYXkgMjcsIDIw
MjIgYXQgMTE6Mjg6NTdQTSArMDIwMCwgS29ucmFkIER5YmNpbyB3cm90ZToKPj4+PiBGcm9tOiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyAKPj4+PiA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bzb21haW5saW5lLm9yZz4KPj4+Pgo+Pj4+IEFzIGFsc28gc3RhdGVkIGluIHRoZSBhcm0tc21t
dSBkcml2ZXIsIHdlIG11c3Qgd3JpdGUgdGhlIFRDUiBiZWZvcmUKPj4+PiB3cml0aW5nIHRoZSBU
VEJScywgc2luY2UgdGhlIFRDUiBkZXRlcm1pbmVzIHRoZSBhY2Nlc3MgYmVoYXZpb3Igb2YKPj4+
PiBzb21lIGZpZWxkcy4KPj4+Cj4+PiBXaGVyZSBpcyB0aGlzIHN0YXRlZCBpbiB0aGUgYXJtLXNt
bXUgZHJpdmVyPwo+Pj4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8g
RGVsIFJlZ25vIAo+Pj4+IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQHNvbWFpbmxpbmUub3Jn
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmlqbiBTdWlqdGVuIDxtYXJpam4uc3VpanRlbkBzb21h
aW5saW5lLm9yZz4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHli
Y2lvQHNvbWFpbmxpbmUub3JnPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11L3Fjb21faW9tbXUuYyB8IDEyICsrKysrKy0tLS0tLQo+Pj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvcWNvbV9pb21tdS5jIAo+Pj4+IGIvZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUvcWNvbV9pb21tdS5jCj4+Pj4gaW5kZXggMTcyOGQ0ZDdmZTI1
Li43NWYzNTM4NjZjNDAgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUvcWNvbV9pb21tdS5jCj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvcWNv
bV9pb21tdS5jCj4+Pj4gQEAgLTI3MywxOCArMjczLDE4IEBAIHN0YXRpYyBpbnQgcWNvbV9pb21t
dV9pbml0X2RvbWFpbihzdHJ1Y3QgCj4+Pj4gaW9tbXVfZG9tYWluICpkb21haW4sCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3R4LT5zZWN1cmVfaW5pdCA9IHRydWU7Cj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgLyogVFRCUnMgKi8KPj4+PiAt
wqDCoMKgwqDCoMKgwqAgaW9tbXVfd3JpdGVxKGN0eCwgQVJNX1NNTVVfQ0JfVFRCUjAsCj4+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ3RibF9jZmcuYXJtX2xwYWVfczFfY2Zn
LnR0YnIgfAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRklFTERfUFJFUChB
Uk1fU01NVV9UVEJSbl9BU0lELCBjdHgtPmFzaWQpKTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgaW9t
bXVfd3JpdGVxKGN0eCwgQVJNX1NNTVVfQ0JfVFRCUjEsIDApOwo+Pj4+IC0KPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogVENSICovCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X3dyaXRl
bChjdHgsIEFSTV9TTU1VX0NCX1RDUjIsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhcm1fc21tdV9scGFlX3RjcjIoJnBndGJsX2NmZykpOwo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBpb21tdV93cml0ZWwoY3R4LCBBUk1fU01NVV9DQl9UQ1IsCj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybV9zbW11X2xwYWVfdGNyKCZwZ3RibF9jZmcp
IHwgQVJNX1NNTVVfVENSX0VBRSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFRUQlJzICovCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X3dyaXRlcShjdHgsIEFSTV9TTU1VX0NCX1RUQlIwLAo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGd0YmxfY2ZnLmFybV9scGFlX3Mx
X2NmZy50dGJyIHwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZJRUxEX1BS
RVAoQVJNX1NNTVVfVFRCUm5fQVNJRCwgY3R4LT5hc2lkKSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlvbW11X3dyaXRlcShjdHgsIEFSTV9TTU1VX0NCX1RUQlIxLCAwKTsKPj4+Cj4+PiBJJ2QgaGF2
ZSB0aG91Z2h0IHRoYXQgU0NUTFIuTSB3b3VsZCBiZSBjbGVhciBoZXJlLCBzbyBpdCBzaG91bGRu
J3QgCj4+PiBtYXR0ZXIKPj4+IHdoYXQgb3JkZXIgd2Ugd3JpdGUgdGhlc2UgaW4uCj4+Cj4+IEhh
dmluZyB0ZXN0ZWQgdGhlIHNlcmllcyB3aXRob3V0IHRoaXMgcGFydGljdWxhciBwYXRjaCBvbiA4
OTc2IChTb255Cj4+IExvaXJlIFN1enUpLCBpdCBkb2Vzbid0IHNlZW0gdG8gbWF0dGVyIGluZGVl
ZC7CoCBJJ2xsIGFzayBhcm91bmQgaWYgdGhpcwo+PiAiYWNjZXNzIGJlaGF2aW91ciIgd2FzIG9i
c2VydmVkIG9uIGEgZGlmZmVyZW50IGJvYXJkL3BsYXRmb3JtLgo+Pgo+PiAtIE1hcmlqbgo+IAo+
IE9uIHNvbWUgcGxhdGZvcm1zLCB0aGUgYm9vdGxvYWRlciAoYW5kL29yIHRoZSBoeXBlcnZpc29y
KSBpcyBwZXJmb3JtaW5nIAo+IHNvbWUKPiBpbml0aWFsaXphdGlvbiBvZiB0aGUgSU9NTVUgd2hp
Y2gsIGRlcGVuZGluZyBvbiB0aGUgYWN0dWFsIGZpcm13YXJlIHZlcnNpb24KPiB0aGF0IHJhbiBi
ZWZvcmUgYm9vdGluZyBMaW51eCwgbWF5IG9yIG1heSBub3QgbGVhdmUgU0NUTFIuTSBjbGVhcmVk
LgoKQnV0IGRvZXMgaXQgYWN0dWFsbHkgbWF0dGVyIGV2ZW4gdGhlbj8gSWYgd2UncmUgb25seSBh
bGxvd2VkIHRvIHByb2dyYW0gCnRoZSBzYW1lIEFTSUQgdGhhdCB3YXMgaW4gdXNlIGJlZm9yZWhh
bmQsIHRoZW4gbG9naWNhbGx5IHdlIGNhbid0IGJlIApjaGFuZ2luZyBUQ1IyLkFTIGluIGEgd2F5
IHRoYXQgbWFrZXMgYW55IGRpZmZlcmVuY2UgYW55d2F5LgoKSSBzZWUgbm8gcG9pbnQgaW4gcHJl
dGVuZGluZyB0byB3b3JyeSBhYm91dCB0aGVvcmV0aWNhbCBhcmNoaXRlY3R1cmFsIApjb3JyZWN0
bmVzcyBpbiBhIGRyaXZlciB0aWVkIHRvIHNwZWNpZmljIGltcGxlbWVudGF0aW9ucyB0aGF0IGFs
cmVhZHkgCnZpb2xhdGUgdGhlIGdpdmVuIGFyY2hpdGVjdHVyZSBpbiBtYW55IG90aGVyIHdheXMu
IElmIHRoZXJlJ3MgYSBrbm93biAKZmlybXdhcmUgaW1wbGVtZW50YXRpb24gdGhhdCBkZWZpbml0
ZWx5IHJlcXVpcmVzIHRoaXMsIHRoYXQgc2hvdWxkIGJlIApjYWxsZWQgb3V0OyBvdGhlcndpc2Us
IHRoZXJlIGRvZXNuJ3Qgc2VlbSBtdWNoIGp1c3RpZmljYXRpb24gZm9yIHRoZSAKcGF0Y2ggYXQg
YWxsLgoKVGhhbmtzLApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
