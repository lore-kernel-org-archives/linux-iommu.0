Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059AC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F68E61246
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F68E61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BF30404D3;
	Mon, 14 Jun 2021 17:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id URSnCRkYvG8f; Mon, 14 Jun 2021 17:19:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0607E40353;
	Mon, 14 Jun 2021 17:19:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE2EBC000D;
	Mon, 14 Jun 2021 17:19:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD694C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB85B401D9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8lq9UQE9ULM for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 834D840191
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:19:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8101F11D4;
 Mon, 14 Jun 2021 10:19:36 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07B363F70D;
 Mon, 14 Jun 2021 10:19:34 -0700 (PDT)
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
 <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56f1fc88-baec-e1cf-109e-59978e2d16a8@arm.com>
Date: Mon, 14 Jun 2021 18:19:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

T24gMjAyMS0wNi0xNCAxODowMywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNC8wNi8yMDIxIDE3
OjI1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMDYtMTEgMTM6MjAsIEpvaG4gR2Fy
cnkgd3JvdGU6Cj4+PiBXZSBvbmx5IGV2ZXIgbm93IHNldCBzdHJpY3QgbW9kZSBlbmFibGVkIGlu
IGlvbW11X3NldF9kbWFfc3RyaWN0KCksIHNvCj4+PiBqdXN0IHJlbW92ZSB0aGUgYXJndW1lbnQu
Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29t
Pgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pbml0LmPCoMKgwqAgfCAyICstCj4+
PiDCoCBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA2ICsrKy0tLQo+Pj4gwqAgZHJpdmVy
cy9pb21tdS9pb21tdS5jwqDCoMKgwqDCoMKgIHwgNSArKy0tLQo+Pj4gwqAgaW5jbHVkZS9saW51
eC9pb21tdS5owqDCoMKgwqDCoMKgIHwgMiArLQo+Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYW1kL2luaXQuYyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+Pj4gaW5kZXggMGU2
YWU2ZDY4ZjE0Li4yN2U5Njc3ZWMzMDMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2Ft
ZC9pbml0LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+Pj4gQEAgLTMwOTgs
NyArMzA5OCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHBhcnNlX2FtZF9pb21tdV9vcHRpb25zKGNo
YXIgCj4+PiAqc3RyKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBmb3IgKDsgKnN0cjsgKytzdHIp
IHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RybmNtcChzdHIsICJmdWxsZmx1c2giLCA5
KSA9PSAwKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3Qo
dHJ1ZSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCgp
Owo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzdHJuY21wKHN0ciwgImZvcmNlX2VuYWJsZSIs
IDEyKSA9PSAwKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kX2lvbW11X2ZvcmNl
X2VuYWJsZSA9IHRydWU7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0cm5jbXAoc3RyLCAi
b2ZmIiwgMykgPT0gMCkKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4+IGluZGV4IDY3NjNlNTE2MzYyYy4u
ZTc3YjhiNmU3ODM4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
Cj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4+IEBAIC00NTIsNyArNDUy
LDcgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfaW9tbXVfc2V0dXAoY2hhciAqc3RyKQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigiaW50ZWxfaW9tbXU9Zm9yY2VkYWMg
ZGVwcmVjYXRlZDsgdXNlIAo+Pj4gaW9tbXUuZm9yY2VkYWMgaW5zdGVhZFxuIik7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfZm9yY2VkYWMgPSB0cnVlOwo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoIXN0cm5jbXAoc3RyLCAic3RyaWN0IiwgNikpIHsK
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKCFzdHJuY21wKHN0ciwgInNwX29mZiIsIDYpKSB7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJEaXNhYmxlIHN1cHBvcnRl
ZCBzdXBlciBwYWdlXG4iKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVsX2lv
bW11X3N1cGVycGFnZSA9IDA7Cj4+PiBAQCAtNDM5Miw3ICs0MzkyLDcgQEAgaW50IF9faW5pdCBp
bnRlbF9pb21tdV9pbml0KHZvaWQpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApKSB7Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJJT01NVSBiYXRjaGluZyBkaXNhbGxv
d2VkIGR1ZSB0byAKPj4+IHZpcnR1YWxpemF0aW9uXG4iKTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgmaW9tbXUtPmlvbW11
LCBOVUxMLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludGVsX2lvbW11X2dyb3VwcywKPj4+IEBAIC01NjYzLDcgKzU2NjMsNyBAQCBzdGF0aWMg
dm9pZCBxdWlya19jYWxwZWxsYV9ub19zaGFkb3dfZ3R0KHN0cnVjdCAKPj4+IHBjaV9kZXYgKmRl
dikKPj4+IMKgwqDCoMKgwqAgfSBlbHNlIGlmIChkbWFyX21hcF9nZngpIHsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiB3ZSBoYXZlIHRvIGVuc3VyZSB0aGUgZ2Z4IGRldmljZSBpcyBpZGxlIGJl
Zm9yZSB3ZSBmbHVzaCAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9pbmZvKGRldiwgIkRp
c2FibGluZyBiYXRjaGVkIElPVExCIGZsdXNoIG9uIElyb25sYWtlXG4iKTsKPj4+IC3CoMKgwqDC
oMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBp
b21tdV9zZXRfZG1hX3N0cmljdCgpOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCB9Cj4+PiDCoCBE
RUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgwMDQwLCAKPj4+
IHF1aXJrX2NhbHBlbGxhX25vX3NoYWRvd19ndHQpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gaW5kZXggY2NiZDVkNGMx
YTUwLi4xNDZjYjcxYzc0NDEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMK
Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gQEAgLTM1MCwxMCArMzUwLDkgQEAg
c3RhdGljIGludCBfX2luaXQgaW9tbXVfZG1hX3NldHVwKGNoYXIgKnN0cikKPj4+IMKgIH0KPj4+
IMKgIGVhcmx5X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwo+Pj4gLXZv
aWQgaW9tbXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBzdHJpY3QpCj4+PiArdm9pZCBpb21tdV9zZXRf
ZG1hX3N0cmljdCh2b2lkKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBpZiAoc3RyaWN0IHx8ICEoaW9t
bXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpKQo+Pgo+PiBXZSBzaG91bGRuJ3Qg
bmVlZCB0byBrZWVwIElPTU1VX0NNRF9MSU5FX1NUUklDVCBhdCBhbGwgbm93LCBzaW5jZSBpdCAK
Pj4gd2FzIG9ubHkgdG8gcHJldmVudCBhIGRyaXZlcidzICJkZWZhdWx0IGxhenkiIHNldHRpbmcg
cGFzc2VkIGluIGhlcmUgCj4+IGZyb20gZG93bmdyYWRpbmcgYW4gZXhwbGljaXRseS1zZXQgc3Ry
aWN0IG1vZGUuCj4+Cj4+IFdpdGggdGhhdCBjbGVhbmVkIHVwIHRvbywKPj4KPiAKPiBQYXRjaCAx
LzUgbWVudGlvbnMgd2hldGhlciB0aGUgaW52YWxpZGF0aW9uIHBvbGljeSBjb21lcyBmcm9tIHRo
ZSAKPiBjbWRsaW5lIC0gc2ltaWxhciB0byB0aGUgZGVmYXVsdCBkb21haW4gdHlwZSBwcmludCAt
IHNvIEkgd2FzIGdvaW5nIHRvIAo+IGtlZXAgdGhhdC4KCk9oLCBzaWxseSBtZSwgSSdkIGZvcmdv
dHRlbiB0aGF0IGFscmVhZHkgYW5kIHdhcyBqdXN0IGxvb2tpbmcgYXQgbXkgCmxvY2FsIHRyZWUu
Li4gTGV0J3Mga2VlcCBpdCBmb3IgY29uc2lzdGVuY3kgd2l0aCBob3cgd2UgcmVwb3J0IHRoZSAK
ZG9tYWluIHR5cGUgdGhlbi4KCj4gQW5kIHRoZW4gbWF5YmUgd2Ugc2hvdWxkIGFsc28gc2V0IGl0
IGZyb20gdGhlIGRlcHJlY2F0ZWQgeDg2IAo+IGRyaXZlci1zcGVjaWZpYyBwYXJhbXMuCgpJIGRv
bid0IHRoaW5rIGl0J3Mgd29ydGggZXhwb3J0aW5nIG1vcmUgbG93LWxldmVsIGd1dHMgdG8gYWxs
b3cgdGhhdCB0byAKaGFwcGVuIC0gdHlpbmcgaW4gdG8gaW9tbXVfc2V0X2RtYV9zdHJpY3QoKSB3
b3VsZCBiZSB0b28gbGF0ZSwgYXMgCmJlZm9yZS4gSSB0aGluayB0aGUgc2VwYXJhdGUgcHJfd2Fy
bigpcyB3aGljaCBhbm5vdW5jZSB0aGUgcmVsZXZhbnQgCnBhcmFtZXRlciBpcyBkZXByZWNhdGVk
IChidXQgaGFzIHN0aWxsIHRha2VuIGVmZmVjdCkgc2hvdWxkIGJlIGVub3VnaC4KCkNoZWVycywK
Um9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
