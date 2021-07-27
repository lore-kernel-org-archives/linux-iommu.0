Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910BC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A2460F46
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 10:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28A2460F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD1166FB01;
	Tue, 27 Jul 2021 10:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSBTuGTT5Hw2; Tue, 27 Jul 2021 10:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7C356FAFC;
	Tue, 27 Jul 2021 10:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C4BC001A;
	Tue, 27 Jul 2021 10:33:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD1F5C000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8668082FD5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pcS5-xiwLhD for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 10:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FD3E82F49
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 10:33:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 079541FB;
 Tue, 27 Jul 2021 03:33:08 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E263F70D;
 Tue, 27 Jul 2021 03:33:06 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
From: Robin Murphy <robin.murphy@arm.com>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Taniya Das <tdas@codeaurora.org>,
 srimuc <srimuc@codeaurora.org>
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
 <955a3034-f7e7-f8f9-4abd-b65efbfbb404@arm.com>
Message-ID: <c23a16d8-e39c-253f-5631-cffa94a1d532@arm.com>
Date: Tue, 27 Jul 2021 11:33:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <955a3034-f7e7-f8f9-4abd-b65efbfbb404@arm.com>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNy0yNyAxMToyNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDctMjcg
MTA6MzMsIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4gU29tZSBjbG9ja3MgZm9yIFNNTVUg
Y2FuIGhhdmUgcGFyZW50IGFzIFhPIHN1Y2ggYXMgZ3B1X2NjX2h1Yl9jeF9pbnRfY2xrCj4+IG9m
IEdQVSBTTU1VIGluIFFUSSBTQzcyODAgU29DIGFuZCBpbiBvcmRlciB0byBlbnRlciBkZWVwIHNs
ZWVwIHN0YXRlcyBpbgo+PiBzdWNoIGNhc2VzLCB3ZSB3b3VsZCBuZWVkIHRvIGRyb3AgdGhlIFhP
IGNsb2NrIHZvdGUgaW4gdW5wcmVwYXJlIGNhbGwgYW5kCj4+IHRoaXMgdW5wcmVwYXJlIGNhbGxi
YWNrIGZvciBYTyBpcyBpbiBSUE1oIChSZXNvdXJjZSBQb3dlciAKPj4gTWFuYWdlci1IYXJkZW5l
ZCkKPj4gY2xvY2sgZHJpdmVyIHdoaWNoIGNvbnRyb2xzIFJQTWggbWFuYWdlZCBjbG9jayByZXNv
dXJjZXMgZm9yIG5ldyBRVEkgU29Dcwo+PiBhbmQgaXMgYSBibG9ja2luZyBjYWxsLgo+Pgo+PiBH
aXZlbiB3ZSBjYW5ub3QgaGF2ZSBhIHNsZWVwaW5nIGNhbGxzIHN1Y2ggYXMgY2xrX2J1bGtfcHJl
cGFyZSgpIGFuZAo+PiBjbGtfYnVsa191bnByZXBhcmUoKSBpbiBhcm0tc21tdSBydW50aW1lIHBt
IGNhbGxiYWNrcyBzaW5jZSB0aGUgaW9tbXUKPj4gb3BlcmF0aW9ucyBsaWtlIG1hcCBhbmQgdW5t
YXAgY2FuIGJlIGluIGF0b21pYyBjb250ZXh0IGFuZCBhcmUgaW4gZmFzdAo+PiBwYXRoLCBhZGQg
dGhpcyBwcmVwYXJlIGFuZCB1bnByZXBhcmUgY2FsbCB0byBkcm9wIHRoZSBYTyB2b3RlIG9ubHkg
Zm9yCj4+IHN5c3RlbSBwbSBjYWxsYmFja3Mgc2luY2UgaXQgaXMgbm90IGEgZmFzdCBwYXRoIGFu
ZCB3ZSBleHBlY3QgdGhlIHN5c3RlbQo+PiB0byBlbnRlciBkZWVwIHNsZWVwIHN0YXRlcyB3aXRo
IHN5c3RlbSBwbSBhcyBvcHBvc2VkIHRvIHJ1bnRpbWUgcG0uCj4+Cj4+IFRoaXMgaXMgYSBzaW1p
bGFyIHNlcXVlbmNlIG9mIGNsb2NrIHJlcXVlc3RzIChwcmVwYXJlLGVuYWJsZSBhbmQKPj4gZGlz
YWJsZSx1bnByZXBhcmUpIGluIGFybS1zbW11IHByb2JlIGFuZCByZW1vdmUuCj4gCj4gTm9wZS4g
V2UgY2FsbCBhcm1fc21tdV9ycG1fZ2V0KCksIHdoaWNoIG1heSByZXN1bWUgdGhlIGRldmljZSwg
ZnJvbSAKPiBhdG9taWMgY29udGV4dHMuIGNsa19wcmVwYXJlKCkgbWF5IHNsZWVwLiBUaGlzIGRv
ZXNuJ3Qgd29yay4KClVyZ2gsIG9yIG1heWJlIEkgc2tpbW1lZCB0aGUgY29tbWl0IG1lc3NhZ2Ug
dG9vIGxpZ2h0bHkgKmFuZCogbWFuYWdlZCB0byAKdG90YWxseSBtaXNyZWFkIHRoZSBwYXRjaCwg
c29ycnkgOigKCkknbGwgd2FrZSB1cCBzb21lIG1vcmUgYW5kIHRyeSBhZ2FpbiBsYXRlci4uLgoK
Um9iaW4uCgo+PiBTaWduZWQtb2ZmLWJ5OiBTYWkgUHJha2FzaCBSYW5qYW4gPHNhaXByYWthc2gu
cmFuamFuQGNvZGVhdXJvcmEub3JnPgo+PiBDby1kZXZlbG9wZWQtYnk6IFJhamVuZHJhIE5heWFr
IDxybmF5YWtAY29kZWF1cm9yYS5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IFJhamVuZHJhIE5heWFr
IDxybmF5YWtAY29kZWF1cm9yYS5vcmc+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9hcm0tc21tdS5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0KPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIAo+PiBiL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMKPj4gaW5kZXggZDNjNmY1NDExMGE1Li45NTYx
YmE0YzVkMzkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1z
bW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+PiBA
QCAtMjI3Nyw2ICsyMjc3LDEzIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgCj4+IGFybV9z
bW11X3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IMKgIHN0YXRpYyBpbnQg
X19tYXliZV91bnVzZWQgYXJtX3NtbXVfcG1fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKPj4g
wqAgewo+PiArwqDCoMKgIGludCByZXQ7Cj4+ICvCoMKgwqAgc3RydWN0IGFybV9zbW11X2Rldmlj
ZSAqc21tdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+PiArCj4+ICvCoMKgwqAgcmV0ID0gY2xr
X2J1bGtfcHJlcGFyZShzbW11LT5udW1fY2xrcywgc21tdS0+Y2xrcyk7Cj4+ICvCoMKgwqAgaWYg
KHJldCkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+ICsKPj4gwqDCoMKgwqDCoCBp
ZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZGV2KSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+PiBAQCAtMjI4NSwxMCArMjI5MiwxOSBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2Vk
IAo+PiBhcm1fc21tdV9wbV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoCBzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIGFybV9zbW11X3BtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQo+PiDCoCB7Cj4+ICvCoMKgwqAgaW50IHJldCA9IDA7Cj4+ICvCoMKgwqAgc3RydWN0IGFybV9z
bW11X2RldmljZSAqc21tdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+PiArCj4+IMKgwqDCoMKg
wqAgaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGRldikpCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1
cm4gMDsKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gY2xrX3VucHJlcGFyZTsKPj4gLcKgwqDCoCBy
ZXR1cm4gYXJtX3NtbXVfcnVudGltZV9zdXNwZW5kKGRldik7Cj4+ICvCoMKgwqAgcmV0ID0gYXJt
X3NtbXVfcnVudGltZV9zdXNwZW5kKGRldik7Cj4+ICvCoMKgwqAgaWYgKHJldCkKPj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+ICsKPj4gK2Nsa191bnByZXBhcmU6Cj4+ICvCoMKgwqAg
Y2xrX2J1bGtfdW5wcmVwYXJlKHNtbXUtPm51bV9jbGtzLCBzbW11LT5jbGtzKTsKPj4gK8KgwqDC
oCByZXR1cm4gcmV0Owo+PiDCoCB9Cj4+IMKgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBhcm1fc21tdV9wbV9vcHMgPSB7Cj4+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
