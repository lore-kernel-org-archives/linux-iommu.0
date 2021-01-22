Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1442DC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 02:50:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7803A23884
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 02:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7803A23884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17E6386D1F;
	Fri, 22 Jan 2021 02:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahUtlcCmNg6r; Fri, 22 Jan 2021 02:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E57DA86BB0;
	Fri, 22 Jan 2021 02:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7905C08A1;
	Fri, 22 Jan 2021 02:50:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B890C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E39E986CF3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFZowgxTP-Fv for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 02:50:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C08FE86BB0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:50:29 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMNyK6wpBzj9h7;
 Fri, 22 Jan 2021 10:49:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 22 Jan 2021 10:50:18 +0800
Subject: Re: [PATCH 2/2] Revert "iommu/arm-smmu-v3: Don't reserve
 implementation defined register space"
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-3-thunder.leizhen@huawei.com>
 <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
 <ca469958-179d-02c5-b147-0a0ff951d503@huawei.com>
 <72c979bd-501f-df9b-7bca-02b8c11d3860@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cfa002c0-593a-b4e8-7015-224726d73504@huawei.com>
Date: Fri, 22 Jan 2021 10:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <72c979bd-501f-df9b-7bca-02b8c11d3860@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIxLzEvMjEgMjA6NTAsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTIx
IDAyOjA0LCBMZWl6aGVuIChUaHVuZGVyVG93bikgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvMS8y
MCAyMzowMiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMS0wMS0xOSAwMTo1OSwgWmhl
biBMZWkgd3JvdGU6Cj4+Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCA1MmYzZmFiMDA2N2Q2ZmE5ZTk5
YzFiN2Y2MzI2NWRkNDhjYTc2MDQ2Lgo+Pj4+Cj4+Pj4gVGhpcyBwcm9ibGVtIGhhcyBiZWVuIGZp
eGVkIGJ5IGFub3RoZXIgcGF0Y2guIFRoZSBvcmlnaW5hbCBtZXRob2QgaGFkIHNpZGUKPj4+PiBl
ZmZlY3RzLCBpdCB3YXMgbm90IG1hcHBlZCB0byB0aGUgdXNlci1zcGVjaWZpZWQgcmVzb3VyY2Ug
c2l6ZS4gVGhlIGNvZGUKPj4+PiB3aWxsIGJlY29tZSBtb3JlIGNvbXBsZXggd2hlbiBFQ01EUSBp
cyBzdXBwb3J0ZWQgbGF0ZXIuCj4+Pgo+Pj4gRldJVyBJIGRvbid0IHRoaW5rIHRoYXQncyBhIHNp
Z25pZmljYW50IGlzc3VlIGVpdGhlciB3YXkgLSB0aGVyZSBjb3VsZCBiZSBhbnkgbnVtYmVyIG9m
IGltcC1kZWYgcGFnZXMgYmV0d2VlbiBTTU1VIHBhZ2UgMCBhbmQgdGhlIEVDTURRIGNvbnRyb2wg
cGFnZXMsIHNvIGl0IHdpbGwgc3RpbGwgYmUgbG9naWNhbCB0byBtYXAgdGhlbSBhcyBhbm90aGVy
IHNlcGFyYXRlIHRoaW5nIGFueXdheS4KPj4KPj4gWWVzLCBzbyBub3cgSSdtIHRoaW5raW5nIG9m
IHByZXNlcnZpbmcgdGhlIFNNTVV2MyByZXNvdXJjZXMgYW5kIGVsaW1pbmF0aW5nIHRoZSBpbXAt
ZGVmIGFyZWEuIFRoZW4gdXNlIGFub3RoZXIgZGV2bV9pb3JlbWFwKCkgdG8gY292ZXIgdGhlIGVu
dGlyZSByZXNvdXJjZe+8jGFzc2lnbiBpdCB0byBzbW11LT5iYXNlLgo+PiBPdGhlcndpc2UsIGEg
YmFzZSBwb2ludGVyIG5lZWRzIHRvIGJlIGRlZmluZWQgZm9yIGVhY2ggc2VwYXJhdGVkIHJlZ2lz
dGVyIHNwYWNl77yMb3IgY2FsbCBhIGZ1bmN0aW9uIHRvIGNvbnZlcnQgZWFjaCB0aW1lLgo+IAo+
IEJ1dCB3ZSdsbCBhbG1vc3QgY2VydGFpbmx5IHdhbnQgdG8gbWFpbnRhaW4gYSBwb2ludGVyIHRv
IHN0YXJ0IG9mIHRoZSBFQ01EUSBjb250cm9sIHBhZ2UgYmxvY2sgYW55d2F5LCBzaW5jZSB0aGF0
J3Mgbm90IGZpeGVkIHJlbGF0aXZlIHRvIHNtbXUtPmJhc2UuIFRoZXJlZm9yZSB3aGF0J3MgdGhl
IGhhcm0gaW4gaGFuZGxpbmcgdGhhdCB2aWEgYSBkZWRpY2F0ZWQgbWFwcGluZywgb25jZSB3ZSd2
ZSBkZXRlcm1pbmVkIHRoYXQgd2UgKmRvKiBpbnRlbmQgdG8gdXNlIEVDTURRcz8gT3RoZXJ3aXNl
IHdlIGVuZCB1cCB3aXRoIGluIHRoZSBjb21wbGljYXRlZCBkYW5jZSBvZiB0cnlpbmcgdG8gbWFw
ICJldmVyeXRoaW5nIiB1cC1mcm9udCBpbiBvcmRlciB0byBiZSBhYmxlIHRvIHJlYWQgdGhlIElE
IHJlZ2lzdGVycyB0byBkZXRlcm1pbmUgd2hhdCB0aGUgYWN0dWFsIGV4dGVudCBvZiAiZXZlcnl0
aGluZyIgaXMgc3VwcG9zZWQgdG8gYmUuCgpDdXJyZW50bHksIHdlIG9ubHkgbWFwcGVkIHRoZSBm
aXJzdCAweGUwMCBzaXplLCBzbyB0aGUgU01NVV9DTURRX0NPTlRST0xfUEFHRV9YWFhuIHJlZ2lz
dGVycyBzcGFjZSBhdCBvZmZzZXQgMHg0MDAwIHNob3VsZCBiZSBtYXBwZWQgYWdhaW4uClRoZSBz
aXplIG9mIHRoaXMgRUNNRFEgcmVzb3VyY2UgaXMgbm90IGZpeGVkLCBkZXBlbmRpbmcgb24gU01N
VV9JRFI2LkNNRFFfQ09OVFJPTF9QQUdFX0xPRzJOVU1RLgpQcm9jZXNzaW5nIGl0cyByZXNvdXJj
ZSByZXNlcnZhdGlvbiB0byBhdm9pZCByZXNvdXJjZSBjb25mbGljdCB3aXRoIFBNQ0cgaXMgYSBi
aXQgbW9yZSBjb21wbGljYXRlZC4KCj4gCj4gKGFsc28gdGhpcyByZW1pbmRzIG1lIHRoYXQgSSB3
YXMgZ29pbmcgdG8gcmVtb3ZlIGFybV9zbW11X3BhZ2UxX2ZpeHVwKCkgZW50aXJlbHkgLSBJJ2Qg
dG90YWxseSBmb3Jnb3R0ZW4gYWJvdXQgdGhhdC4uLikKCkFoLCB0aGF0IHBhdGNoIHlvdSBtYWRl
IGlzIHNvIGNsZXZlci4KCj4gCj4gUm9iaW4uCj4gCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbiBM
ZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgwqAgZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDMyICsrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+Pj4gwqDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5oIHzCoCAzIC0tLQo+Pj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCj4+Pj4gaW5kZXggOGNhNzQxNWQ3ODVkOWJmLi40Nzdm
NDczODQyZTUyNzIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMKPj4+PiBAQCAtOTEsOCArOTEsOSBAQCBzdHJ1Y3QgYXJtX3NtbXVfb3B0
aW9uX3Byb3Agewo+Pj4+IMKgwqAgc3RhdGljIGlubGluZSB2b2lkIF9faW9tZW0gKmFybV9zbW11
X3BhZ2UxX2ZpeHVwKHVuc2lnbmVkIGxvbmcgb2Zmc2V0LAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfZGV2
aWNlICpzbW11KQo+Pj4+IMKgwqAgewo+Pj4+IC3CoMKgwqAgaWYgKG9mZnNldCA+IFNaXzY0SykK
Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNtbXUtPnBhZ2UxICsgb2Zmc2V0IC0gU1pfNjRL
Owo+Pj4+ICvCoMKgwqAgaWYgKChvZmZzZXQgPiBTWl82NEspICYmCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIChzbW11LT5vcHRpb25zICYgQVJNX1NNTVVfT1BUX1BBR0UwX1JFR1NfT05MWSkpCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIG9mZnNldCAtPSBTWl82NEs7Cj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHJl
dHVybiBzbW11LT5iYXNlICsgb2Zmc2V0Owo+Pj4+IMKgwqAgfQo+Pj4+IEBAIC0zNDg2LDE4ICsz
NDg3LDYgQEAgc3RhdGljIGludCBhcm1fc21tdV9zZXRfYnVzX29wcyhzdHJ1Y3QgaW9tbXVfb3Bz
ICpvcHMpCj4+Pj4gwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4gwqDCoCB9Cj4+Pj4gwqDC
oCAtc3RhdGljIHZvaWQgX19pb21lbSAqYXJtX3NtbXVfaW9yZW1hcChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHJlc291cmNlX3NpemVfdCBzdGFydCwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlc291cmNlX3NpemVfdCBzaXplKQo+Pj4+IC17Cj4+Pj4gLcKg
wqDCoCBzdHJ1Y3QgcmVzb3VyY2UgcmVzID0gewo+Pj4+IC3CoMKgwqDCoMKgwqDCoCAuZmxhZ3Mg
PSBJT1JFU09VUkNFX01FTSwKPj4+PiAtwqDCoMKgwqDCoMKgwqAgLnN0YXJ0ID0gc3RhcnQsCj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIC5lbmQgPSBzdGFydCArIHNpemUgLSAxLAo+Pj4+IC3CoMKgwqAg
fTsKPj4+PiAtCj4+Pj4gLcKgwqDCoCByZXR1cm4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwg
JnJlcyk7Cj4+Pj4gLX0KPj4+PiAtCj4+Pj4gwqDCoCBzdGF0aWMgaW50IGFybV9zbW11X2Rldmlj
ZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+IMKgwqAgewo+Pj4+IMKg
wqDCoMKgwqDCoCBpbnQgaXJxLCByZXQ7Cj4+Pj4gQEAgLTM1MzMsMjMgKzM1MjIsMTAgQEAgc3Rh
dGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKPj4+PiDCoMKgwqDCoMKgwqAgfQo+Pj4+IMKgwqDCoMKgwqDCoCBpb2FkZHIgPSByZXMtPnN0
YXJ0Owo+Pj4+IMKgwqAgLcKgwqDCoCAvKgo+Pj4+IC3CoMKgwqDCoCAqIERvbid0IG1hcCB0aGUg
SU1QTEVNRU5UQVRJT04gREVGSU5FRCByZWdpb25zLCBzaW5jZSB0aGV5IG1heSBjb250YWluCj4+
Pj4gLcKgwqDCoMKgICogdGhlIFBNQ0cgcmVnaXN0ZXJzIHdoaWNoIGFyZSByZXNlcnZlZCBieSB0
aGUgUE1VIGRyaXZlci4KPj4+PiAtwqDCoMKgwqAgKi8KPj4+PiAtwqDCoMKgIHNtbXUtPmJhc2Ug
PSBhcm1fc21tdV9pb3JlbWFwKGRldiwgaW9hZGRyLCBBUk1fU01NVV9SRUdfU1opOwo+Pj4+ICvC
oMKgwqAgc21tdS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7Cj4+Pj4g
wqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21tdS0+YmFzZSkpCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIFBUUl9FUlIoc21tdS0+YmFzZSk7Cj4+Pj4gwqDCoCAtwqDCoMKgIGlmIChh
cm1fc21tdV9yZXNvdXJjZV9zaXplKHNtbXUpID4gU1pfNjRLKSB7Cj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIHNtbXUtPnBhZ2UxID0gYXJtX3NtbXVfaW9yZW1hcChkZXYsIGlvYWRkciArIFNaXzY0SywK
Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBBUk1fU01NVV9SRUdfU1opOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXUt
PnBhZ2UxKSkKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihzbW11
LT5wYWdlMSk7Cj4+Pj4gLcKgwqDCoCB9IGVsc2Ugewo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBzbW11
LT5wYWdlMSA9IHNtbXUtPmJhc2U7Cj4+Pj4gLcKgwqDCoCB9Cj4+Pj4gLQo+Pj4+IMKgwqDCoMKg
wqDCoCAvKiBJbnRlcnJ1cHQgbGluZXMgKi8KPj4+PiDCoMKgIMKgwqDCoMKgwqAgaXJxID0gcGxh
dGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgImNvbWJpbmVkIik7Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggYi9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oCj4+Pj4gaW5kZXggOTZj
MmU5NTY1ZTAwMjgyLi4wYzMwOTBjNjA4NDBjMjIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmgKPj4+PiBAQCAtMTUyLDggKzE1Miw2IEBA
Cj4+Pj4gwqDCoCAjZGVmaW5lIEFSTV9TTU1VX1BSSVFfSVJRX0NGRzHCoMKgwqDCoMKgwqDCoCAw
eGQ4Cj4+Pj4gwqDCoCAjZGVmaW5lIEFSTV9TTU1VX1BSSVFfSVJRX0NGRzLCoMKgwqDCoMKgwqDC
oCAweGRjCj4+Pj4gwqDCoCAtI2RlZmluZSBBUk1fU01NVV9SRUdfU1rCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDB4ZTAwCj4+Pj4gLQo+Pj4+IMKgwqAgLyogQ29tbW9uIE1TSSBjb25maWcgZmllbGRz
ICovCj4+Pj4gwqDCoCAjZGVmaW5lIE1TSV9DRkcwX0FERFJfTUFTS8KgwqDCoMKgwqDCoMKgIEdF
Tk1BU0tfVUxMKDUxLCAyKQo+Pj4+IMKgwqAgI2RlZmluZSBNU0lfQ0ZHMl9TSMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgR0VOTUFTSyg1LCA0KQo+Pj4+IEBAIC01ODQsNyArNTgyLDYgQEAgc3RydWN0
IGFybV9zbW11X3N0cnRhYl9jZmcgewo+Pj4+IMKgwqAgc3RydWN0IGFybV9zbW11X2RldmljZSB7
Cj4+Pj4gwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpk
ZXY7Cj4+Pj4gwqDCoMKgwqDCoMKgIHZvaWQgX19pb21lbcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KmJhc2U7Cj4+Pj4gLcKgwqDCoCB2b2lkIF9faW9tZW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpw
YWdlMTsKPj4+PiDCoMKgIMKgICNkZWZpbmUgQVJNX1NNTVVfRkVBVF8yX0xWTF9TVFJUQULCoMKg
wqAgKDEgPDwgMCkKPj4+PiDCoMKgICNkZWZpbmUgQVJNX1NNTVVfRkVBVF8yX0xWTF9DRFRBQsKg
wqDCoCAoMSA8PCAxKQo+Pj4+Cj4+Pgo+Pj4gLgo+Pj4KPj4KPiAKPiAuCj4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
