Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D247C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 18:56:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85E6613E1
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 18:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85E6613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C5154225E;
	Thu, 17 Jun 2021 18:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NsQtuVgJSSBL; Thu, 17 Jun 2021 18:56:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B2CB4225C;
	Thu, 17 Jun 2021 18:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D203DC000D;
	Thu, 17 Jun 2021 18:56:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B931C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 18:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F6C5842E1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 18:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6oflZnjwjoK7 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 18:56:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91244842D9
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 18:56:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73B131424;
 Thu, 17 Jun 2021 11:56:51 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A93833F694;
 Thu, 17 Jun 2021 11:56:49 -0700 (PDT)
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
 <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7d0fb0e2-4671-16db-6963-b0493d7a549b@arm.com>
Date: Thu, 17 Jun 2021 19:56:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMjAyMS0wNi0xNyAwODozNiwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gNi8xNi8yMSA3OjAzIFBN
LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBXZSBvbmx5IGV2ZXIgbm93IHNldCBzdHJpY3QgbW9kZSBl
bmFibGVkIGluIGlvbW11X3NldF9kbWFfc3RyaWN0KCksIHNvCj4+IGp1c3QgcmVtb3ZlIHRoZSBh
cmd1bWVudC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3
ZWkuY29tPgo+PiBSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNv
bT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuY8KgwqDCoCB8IDIgKy0KPj4g
wqAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNiArKystLS0KPj4gwqAgZHJpdmVycy9p
b21tdS9pb21tdS5jwqDCoMKgwqDCoMKgIHwgNSArKy0tLQo+PiDCoCBpbmNsdWRlL2xpbnV4L2lv
bW11LmjCoMKgwqDCoMKgwqAgfCAyICstCj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9h
bWQvaW5pdC5jIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCj4+IGluZGV4IGZiMzYxOGFmNjQz
Yi4uN2JjNDYwMDUyNjc4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMK
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCj4+IEBAIC0zMDk5LDcgKzMwOTksNyBA
QCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9hbWRfaW9tbXVfb3B0aW9ucyhjaGFyIAo+PiAqc3Ry
KQo+PiDCoMKgwqDCoMKgIGZvciAoOyAqc3RyOyArK3N0cikgewo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHN0cm5jbXAoc3RyLCAiZnVsbGZsdXNoIiwgOSkgPT0gMCkgewo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJhbWRfaW9tbXU9ZnVsbGZsdXNoIGRlcHJlY2F0ZWQ7
IHVzZSAKPj4gaW9tbXUuc3RyaWN0IGluc3RlYWRcbiIpOwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChzdHJuY21wKHN0ciwgImZvcmNlX2VuYWJsZSIsIDEyKSA9PSAw
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRfaW9tbXVfZm9yY2VfZW5hYmxlID0g
dHJ1ZTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBpbmRleCBkNTg2OTkwZmE3NTEuLjA2MThjMzVjZmI1
MSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBAQCAtNDU0LDcgKzQ1NCw3IEBAIHN0YXRpYyBp
bnQgX19pbml0IGludGVsX2lvbW11X3NldHVwKGNoYXIgKnN0cikKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW9tbXVfZG1hX2ZvcmNlZGFjID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIH0gZWxzZSBpZiAoIXN0cm5jbXAoc3RyLCAic3RyaWN0IiwgNikpIHsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigiaW50ZWxfaW9tbXU9c3RyaWN0IGRlcHJlY2F0ZWQ7
IHVzZSBpb21tdS5zdHJpY3QgCj4+IGluc3RlYWRcbiIpOwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBp
ZiAoIXN0cm5jbXAoc3RyLCAic3Bfb2ZmIiwgNikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJfaW5mbygiRGlzYWJsZSBzdXBwb3J0ZWQgc3VwZXIgcGFnZVxuIik7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVsX2lvbW11X3N1cGVycGFnZSA9IDA7Cj4+IEBAIC00
MzgyLDcgKzQzODIsNyBAQCBpbnQgX19pbml0IGludGVsX2lvbW11X2luaXQodm9pZCkKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjYXBfY2FjaGlu
Z19tb2RlKGlvbW11LT5jYXApKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dh
cm4oIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIAo+PiB2aXJ0dWFsaXphdGlvblxu
Iik7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUp
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCgpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGV2aWNlX3N5
c2ZzX2FkZCgmaW9tbXUtPmlvbW11LCBOVUxMLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfZ3JvdXBzLAo+PiBAQCAtNTY5OSw3
ICs1Njk5LDcgQEAgc3RhdGljIHZvaWQgcXVpcmtfY2FscGVsbGFfbm9fc2hhZG93X2d0dChzdHJ1
Y3QgCj4+IHBjaV9kZXYgKmRldikKPj4gwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGRtYXJfbWFwX2dm
eCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogd2UgaGF2ZSB0byBlbnN1cmUgdGhlIGdmeCBk
ZXZpY2UgaXMgaWRsZSBiZWZvcmUgd2UgZmx1c2ggKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBj
aV9pbmZvKGRldiwgIkRpc2FibGluZyBiYXRjaGVkIElPVExCIGZsdXNoIG9uIElyb25sYWtlXG4i
KTsKPj4gLcKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwo+PiArwqDC
oMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKg
IH0KPj4gwqAgREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4
MDA0MCwgCj4+IHF1aXJrX2NhbHBlbGxhX25vX3NoYWRvd19ndHQpOwo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4IDYw
YjFlYzQyZTczYi4uZmYyMjFkM2RkY2JjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lv
bW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0zNDksMTAgKzM0OSw5
IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4+IMKgIH0K
Pj4gwqAgZWFybHlfcGFyYW0oImlvbW11LnN0cmljdCIsIGlvbW11X2RtYV9zZXR1cCk7Cj4+IC12
b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgc3RyaWN0KQo+PiArdm9pZCBpb21tdV9zZXRf
ZG1hX3N0cmljdCh2b2lkKQo+PiDCoCB7Cj4+IC3CoMKgwqAgaWYgKHN0cmljdCB8fCAhKGlvbW11
X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkKPj4gLcKgwqDCoMKgwqDCoMKgIGlv
bW11X2RtYV9zdHJpY3QgPSBzdHJpY3Q7Cj4+ICvCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRy
dWU7Cj4gCj4gU29ycnksIEkgc3RpbGwgY2FuJ3QgZ2V0IGhvdyBpb21tdS5zdHJpY3Qga2VybmVs
IG9wdGlvbiB3b3Jrcy4KPiAKPiBzdGF0aWMgaW50IF9faW5pdCBpb21tdV9kbWFfc2V0dXAoY2hh
ciAqc3RyKQo+IHsKPiAgwqDCoMKgwqDCoMKgwqAgaW50IHJldCA9IGtzdHJ0b2Jvb2woc3RyLCAm
aW9tbXVfZG1hX3N0cmljdCk7CgpOb3RlIHRoYXQgdGhpcyBpcyB0aGUgYml0IHRoYXQgZG9lcyB0
aGUgcmVhbCB3b3JrIC0gaWYgdGhlIGFyZ3VtZW50IApwYXJzZXMgT0sgdGhlbiBpb21tdV9kbWFf
c3RyaWN0IGlzIHJlYXNzaWduZWQgd2l0aCB0aGUgYXBwcm9wcmlhdGUgCnZhbHVlLiBUaGUgaW9t
bXVfY21kX2xpbmUgc3R1ZmYgaXMgYSBiaXQgb2YgYWRkaXRpb25hbCBib29ra2VlcGluZywgCmJh
c2ljYWxseSBqdXN0IHNvIHdlIGNhbiBzZWUgd2hldGhlciBkZWZhdWx0IHZhbHVlcyBoYXZlIGJl
ZW4gb3ZlcnJpZGRlbi4KClJvYmluLgoKPiAKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXQpCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9jbWRfbGluZSB8PSBJT01NVV9D
TURfTElORV9TVFJJQ1Q7Cj4gIMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gfQo+IGVhcmx5
X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwo+IAo+IFRoZSBiaXQgSU9N
TVVfQ01EX0xJTkVfU1RSSUNUIGlzIG9ubHkgc2V0LCBidXQgbm90IHVzZWQgYW55d2hlcmUuIEhl
bmNlLAo+IEkgYW0gd29uZGVyaW5nIGhvdyBjb3VsZCBpdCB3b3JrPyBBIGJ1ZyBvciBJIG1pc3Nl
ZCBhbnl0aGluZz8KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gYmFvbHUKPiAKPj4gwqAgfQo+PiDCoCBi
b29sIGlvbW11X2dldF9kbWFfc3RyaWN0KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikKPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUu
aAo+PiBpbmRleCAzMmQ0NDgwNTBiZjcuLjc1NGY2N2Q2ZGQ5MCAxMDA2NDQKPj4gLS0tIGEvaW5j
bHVkZS9saW51eC9pb21tdS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiBAQCAt
NDc2LDcgKzQ3Niw3IEBAIGludCBpb21tdV9lbmFibGVfbmVzdGluZyhzdHJ1Y3QgaW9tbXVfZG9t
YWluIAo+PiAqZG9tYWluKTsKPj4gwqAgaW50IGlvbW11X3NldF9wZ3RhYmxlX3F1aXJrcyhzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIHF1aXJrcyk7Cj4+IC12b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgdmFsKTsKPj4g
K3ZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3Qodm9pZCk7Cj4+IMKgIGJvb2wgaW9tbXVfZ2V0X2Rt
YV9zdHJpY3Qoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKTsKPj4gwqAgZXh0ZXJuIGludCBy
ZXBvcnRfaW9tbXVfZmF1bHQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgCj4+
IGRldmljZSAqZGV2LAo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
