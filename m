Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBABC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:44:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9842E64E9B
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9842E64E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3F4F420426;
	Mon,  1 Feb 2021 11:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMyBk5bteaJv; Mon,  1 Feb 2021 11:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9820220334;
	Mon,  1 Feb 2021 11:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F41C0FA7;
	Mon,  1 Feb 2021 11:44:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0A8FC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9592386F6F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZB0jYOST1uo for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id C44CB86E1D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:44:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0929B1042;
 Mon,  1 Feb 2021 03:44:37 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2373F718;
 Mon,  1 Feb 2021 03:44:35 -0800 (PST)
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU
 register space
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-4-thunder.leizhen@huawei.com>
 <fa170300-57d9-3883-c70f-d455a9e461f0@arm.com>
 <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cd174cbf-e006-c7be-a707-d7973a26ed31@arm.com>
Date: Mon, 1 Feb 2021 11:44:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

T24gMjAyMS0wMS0zMCAwMTo1NCwgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+IAo+IAo+
IE9uIDIwMjEvMS8yOSAyMzoyNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIxLTAxLTI3
IDExOjMyLCBaaGVuIExlaSB3cm90ZToKPj4+IGNvbW1pdCA1MmYzZmFiMDA2N2QgKCJpb21tdS9h
cm0tc21tdS12MzogRG9uJ3QgcmVzZXJ2ZSBpbXBsZW1lbnRhdGlvbgo+Pj4gZGVmaW5lZCByZWdp
c3RlciBzcGFjZSIpIG9ubHkgcmVzZXJ2ZXMgdGhlIGJhc2ljIFNNTVUgcmVnaXN0ZXIgc3BhY2Uu
IFNvCj4+PiB0aGUgRUNNRFEgcmVnaXN0ZXIgc3BhY2UgaXMgbm90IGNvdmVyZWQsIGl0IHNob3Vs
ZCBiZSBtYXBwZWQgYWdhaW4uIER1ZQo+Pj4gdG8gdGhlIHNpemUgb2YgdGhpcyBFQ01EUSByZXNv
dXJjZSBpcyBub3QgZml4ZWQsIGRlcGVuZGluZyBvbgo+Pj4gU01NVV9JRFI2LkNNRFFfQ09OVFJP
TF9QQUdFX0xPRzJOVU1RLiBQcm9jZXNzaW5nIGl0cyByZXNvdXJjZSByZXNlcnZhdGlvbgo+Pj4g
dG8gYXZvaWQgcmVzb3VyY2UgY29uZmxpY3Qgd2l0aCBQTUNHIGlzIGEgYml0IG1vcmUgY29tcGxp
Y2F0ZWQuCj4+Pgo+Pj4gVGhlcmVmb3JlLCB0aGUgcmVzb3VyY2VzIG9mIHRoZSBQTUNHIGFyZSBu
b3QgcmVzZXJ2ZWQsIGFuZCB0aGUgZW50aXJlIFNNTVUKPj4+IHJlc291cmNlcyBhcmUgcmVzZXJ2
ZWQuCj4+Cj4+IFRoaXMgaXMgdGhlIG9wcG9zaXRlIG9mIHdoYXQgSSBzdWdnZXN0ZWQuIE15IHBv
aW50IHdhcyB0aGF0IGl0IHdpbGwgbWFrZSB0aGUgbW9zdCBzZW5zZSB0byBtYXAgdGhlIEVDTURR
IHBhZ2VzIGFzIGEgc2VwYXJhdGUgcmVxdWVzdCBhbnl3YXksIHRoZXJlZm9yZSB0aGVyZSBpcyBu
byByZWFzb24gdG8gc3RvcCBtYXBwaW5nIHBhZ2UgMCBhbmQgcGFnZSAxIHNlcGFyYXRlbHkgZWl0
aGVyLgo+IAo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhlIEVDTURRIG1hcHBpbmcgbXVzdCBi
ZSBwZXJmb3JtZWQgc2VwYXJhdGVseS4gSWYgdGhlIGNvbmZsaWN0IHdpdGggUE1DRyByZXNvdXJj
ZXMgaXMgZWxpbWluYXRlZC4gRUNNRFEgY2Fubm90IGJlIGEgc2VwYXJhdGUgZHJpdmVyIGxpa2Ug
UE1DRy4KCkkgbWVhbiBpbiB0ZXJtcyBvZiB0aGUgYmFzaWMgcHJhY3RpY2Ugb2Ygbm90IG1hcHBp
bmcgbWVnYWJ5dGVzIHdvcnRoIG9mIApJTVAtREVGIGNyYXAgdGhhdCB0aGlzIGRyaXZlciBkb2Vz
bid0IG5lZWQgb3IgZXZlbiB1bmRlcnN0YW5kLiBJZiB3ZSAKZG9uJ3QgaGF2ZSBFQ01EUSwgd2Ug
ZGVmaW5pdGVseSBkb24ndCBuZWVkIGFueXRoaW5nIGJleW9uZCBwYWdlIDEsIHNvIAp0aGVyZSdz
IG5vIHBvaW50IG1hcHBpbmcgaXQgYWxsLCBhbmQgaW5kZWVkIGl0J3Mgc2FmZXN0IG5vdCB0byBh
bnl3YXkuIApFdmVuIGlmIHdlIGRvIGhhdmUgRUNNRFEsIGl0J3Mgc3RpbGwgc2FmZXIgbm90IHRv
IG1hcCBhbGwgdGhlIHVua25vd24gCnN0dWZmIHRoYXQgbWF5IGJlIGluIGJldHdlZW4sIGFuZCB1
bnRpbCB3ZSd2ZSBtYXBwZWQgcGFnZSAwIHdlIGRvbid0IAprbm93IHdoZXRoZXIgd2UgaGF2ZSBF
Q01EUSBvciBub3QuCgpUaGVyZWZvcmUgdGhlIG1vc3Qgc2Vuc2libGUgdGhpbmcgdG8gZG8gZWl0
aGVyIHdheSBpcyB0byBtYXAgdGhlIGJhc2ljIApwYWdlKHMpIGZpcnN0LCB0aGVuIG1hcCB0aGUg
RUNNRFEgcGFnZXMgc3BlY2lmaWNhbGx5IGlmIHdlIGRldGVybWluZSAKdGhhdCB3ZSBuZWVkIHRv
LiBBbmQgZWl0aGVyIHdheSB3ZSBkb24ndCBldmVuIG5lZWQgdG8gdGhpbmsgYWJvdXQgdGhpcyAK
dW50aWwgYWRkaW5nIEVDTURRIHN1cHBvcnQuCgpSb2Jpbi4KCj4+IElmIHdlIG5lZWQgdG8gZXhw
YW5kIHRoZSBwYWdlIDAgbWFwcGluZyB0byBjb3ZlciBtb3JlIG9mIHBhZ2UgMCB0byByZWFjaCB0
aGUgU01NVV9DTURRX0NPTlRST0xfUEFHRV8qIHJlZ2lzdGVycywgd2UgY2FuIGRvIHRoYXQgd2hl
biB3ZSBhY3R1YWxseSBhZGQgRUNNRFEgc3VwcG9ydC4KPj4KPj4gUm9iaW4uCj4+Cj4+PiBTdWdn
ZXN0ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+Cj4+PiAtLS0KPj4+
ICDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgMjQgKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiAgwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuaCB8wqAgMiAtLQo+Pj4gIMKgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4+IGluZGV4IGYwNGM1NWE3NTAzYzc5MC4uZmRlMjQ0
MDNiMDZhOWUzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuYwo+Pj4gQEAgLTM0NzYsMTQgKzM0NzYsNiBAQCBzdGF0aWMgaW50IGFybV9zbW11
X3NldF9idXNfb3BzKHN0cnVjdCBpb21tdV9vcHMgKm9wcykKPj4+ICDCoMKgwqDCoMKgIHJldHVy
biBlcnI7Cj4+PiAgwqAgfQo+Pj4gIMKgIC1zdGF0aWMgdm9pZCBfX2lvbWVtICphcm1fc21tdV9p
b3JlbWFwKHN0cnVjdCBkZXZpY2UgKmRldiwgcmVzb3VyY2Vfc2l6ZV90IHN0YXJ0LAo+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNvdXJjZV9zaXplX3Qg
c2l6ZSkKPj4+IC17Cj4+PiAtwqDCoMKgIHN0cnVjdCByZXNvdXJjZSByZXMgPSBERUZJTkVfUkVT
X01FTShzdGFydCwgc2l6ZSk7Cj4+PiAtCj4+PiAtwqDCoMKgIHJldHVybiBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCAmcmVzKTsKPj4+IC19Cj4+PiAtCj4+PiAgwqAgc3RhdGljIGludCBhcm1f
c21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4+ICDCoCB7
Cj4+PiAgwqDCoMKgwqDCoCBpbnQgaXJxLCByZXQ7Cj4+PiBAQCAtMzUxOSwyMiArMzUxMSwxNCBA
QCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+Pj4gIMKgwqDCoMKgwqAgfQo+Pj4gIMKgwqDCoMKgwqAgaW9hZGRyID0gcmVzLT5z
dGFydDsKPj4+ICDCoCAtwqDCoMKgIC8qCj4+PiAtwqDCoMKgwqAgKiBEb24ndCBtYXAgdGhlIElN
UExFTUVOVEFUSU9OIERFRklORUQgcmVnaW9ucywgc2luY2UgdGhleSBtYXkgY29udGFpbgo+Pj4g
LcKgwqDCoMKgICogdGhlIFBNQ0cgcmVnaXN0ZXJzIHdoaWNoIGFyZSByZXNlcnZlZCBieSB0aGUg
UE1VIGRyaXZlci4KPj4+IC3CoMKgwqDCoCAqLwo+Pj4gLcKgwqDCoCBzbW11LT5iYXNlID0gYXJt
X3NtbXVfaW9yZW1hcChkZXYsIGlvYWRkciwgQVJNX1NNTVVfUkVHX1NaKTsKPj4+ICvCoMKgwqAg
c21tdS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7Cj4+PiAgwqDCoMKg
wqDCoCBpZiAoSVNfRVJSKHNtbXUtPmJhc2UpKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gUFRSX0VSUihzbW11LT5iYXNlKTsKPj4+ICDCoCAtwqDCoMKgIGlmIChhcm1fc21tdV9yZXNv
dXJjZV9zaXplKHNtbXUpID4gU1pfNjRLKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgc21tdS0+cGFn
ZTEgPSBhcm1fc21tdV9pb3JlbWFwKGRldiwgaW9hZGRyICsgU1pfNjRLLAo+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVJNX1NNTVVfUkVH
X1NaKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXUtPnBhZ2UxKSkKPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXUtPnBhZ2UxKTsKPj4+IC3C
oMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqAgaWYgKGFybV9zbW11X3Jlc291cmNlX3NpemUoc21t
dSkgPiBTWl82NEspCj4+PiArwqDCoMKgwqDCoMKgwqAgc21tdS0+cGFnZTEgPSBzbW11LT5iYXNl
ICsgU1pfNjRLOwo+Pj4gK8KgwqDCoCBlbHNlCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHNtbXUt
PnBhZ2UxID0gc21tdS0+YmFzZTsKPj4+IC3CoMKgwqAgfQo+Pj4gIMKgIMKgwqDCoMKgwqAgLyog
SW50ZXJydXB0IGxpbmVzICovCj4+PiAgwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5oCj4+PiBpbmRleCBkYTUyNWY0NmRhYjRmYzEuLjYzZjJiNDc2OTg3ZDZh
ZSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmgKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmgKPj4+IEBAIC0xNTIsOCArMTUyLDYgQEAKPj4+ICDCoCAjZGVmaW5lIEFSTV9TTU1VX1BSSVFf
SVJRX0NGRzHCoMKgwqDCoMKgwqDCoCAweGQ4Cj4+PiAgwqAgI2RlZmluZSBBUk1fU01NVV9QUklR
X0lSUV9DRkcywqDCoMKgwqDCoMKgwqAgMHhkYwo+Pj4gIMKgIC0jZGVmaW5lIEFSTV9TTU1VX1JF
R19TWsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhlMDAKPj4+IC0KPj4+ICDCoCAvKiBDb21tb24g
TVNJIGNvbmZpZyBmaWVsZHMgKi8KPj4+ICDCoCAjZGVmaW5lIE1TSV9DRkcwX0FERFJfTUFTS8Kg
wqDCoMKgwqDCoMKgIEdFTk1BU0tfVUxMKDUxLCAyKQo+Pj4gIMKgICNkZWZpbmUgTVNJX0NGRzJf
U0jCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdFTk1BU0soNSwgNCkKPj4+Cj4+Cj4+IC4KPj4KPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
