Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B96C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:09:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6119611CA
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6119611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D97060801;
	Mon, 14 Jun 2021 17:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PiNMJhro4pl; Mon, 14 Jun 2021 17:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F99360767;
	Mon, 14 Jun 2021 17:09:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43837C000D;
	Mon, 14 Jun 2021 17:09:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26288C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 148D060802
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wqNBhuCxzWhP for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:09:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FECE60801
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:09:11 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3czB2N7wz6H7db;
 Tue, 15 Jun 2021 00:56:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 19:09:08 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 18:09:07 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b12d96fa-9879-2739-fadd-2ebb02d75918@huawei.com>
Date: Mon, 14 Jun 2021 18:03:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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

T24gMTQvMDYvMjAyMSAxNzoyNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDYtMTEg
MTM6MjAsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IFdlIG9ubHkgZXZlciBub3cgc2V0IHN0cmljdCBt
b2RlIGVuYWJsZWQgaW4gaW9tbXVfc2V0X2RtYV9zdHJpY3QoKSwgc28KPj4ganVzdCByZW1vdmUg
dGhlIGFyZ3VtZW50Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9pbml0LmPCoMKgwqAg
fCAyICstCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDYgKysrLS0tCj4+IMKg
IGRyaXZlcnMvaW9tbXUvaW9tbXUuY8KgwqDCoMKgwqDCoCB8IDUgKystLS0KPj4gwqAgaW5jbHVk
ZS9saW51eC9pb21tdS5owqDCoMKgwqDCoMKgIHwgMiArLQo+PiDCoCA0IGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYW1kL2luaXQuYyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+PiBpbmRleCAw
ZTZhZTZkNjhmMTQuLjI3ZTk2NzdlYzMwMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9h
bWQvaW5pdC5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYwo+PiBAQCAtMzA5OCw3
ICszMDk4LDcgQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfYW1kX2lvbW11X29wdGlvbnMoY2hh
ciAKPj4gKnN0cikKPj4gwqAgewo+PiDCoMKgwqDCoMKgIGZvciAoOyAqc3RyOyArK3N0cikgewo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0cm5jbXAoc3RyLCAiZnVsbGZsdXNoIiwgOSkgPT0g
MCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KCk7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RybmNtcChzdHIsICJmb3JjZV9lbmFibGUiLCAxMikgPT0g
MCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kX2lvbW11X2ZvcmNlX2VuYWJsZSA9
IHRydWU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RybmNtcChzdHIsICJvZmYiLCAzKSA9
PSAwKQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IGluZGV4IDY3NjNlNTE2MzYyYy4uZTc3YjhiNmU3ODM4
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IEBAIC00NTIsNyArNDUyLDcgQEAgc3RhdGljIGlu
dCBfX2luaXQgaW50ZWxfaW9tbXVfc2V0dXAoY2hhciAqc3RyKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcl93YXJuKCJpbnRlbF9pb21tdT1mb3JjZWRhYyBkZXByZWNhdGVkOyB1c2Ug
Cj4+IGlvbW11LmZvcmNlZGFjIGluc3RlYWRcbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpb21tdV9kbWFfZm9yY2VkYWMgPSB0cnVlOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBl
bHNlIGlmICghc3RybmNtcChzdHIsICJzdHJpY3QiLCA2KSkgewo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxz
ZSBpZiAoIXN0cm5jbXAoc3RyLCAic3Bfb2ZmIiwgNikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHJfaW5mbygiRGlzYWJsZSBzdXBwb3J0ZWQgc3VwZXIgcGFnZVxuIik7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVsX2lvbW11X3N1cGVycGFnZSA9IDA7Cj4+IEBA
IC00MzkyLDcgKzQzOTIsNyBAQCBpbnQgX19pbml0IGludGVsX2lvbW11X2luaXQodm9pZCkKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjYXBfY2Fj
aGluZ19tb2RlKGlvbW11LT5jYXApKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBy
X3dhcm4oIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIAo+PiB2aXJ0dWFsaXphdGlv
blxuIik7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRy
dWUpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCgpOwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGV2aWNl
X3N5c2ZzX2FkZCgmaW9tbXUtPmlvbW11LCBOVUxMLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfZ3JvdXBzLAo+PiBAQCAtNTY2
Myw3ICs1NjYzLDcgQEAgc3RhdGljIHZvaWQgcXVpcmtfY2FscGVsbGFfbm9fc2hhZG93X2d0dChz
dHJ1Y3QgCj4+IHBjaV9kZXYgKmRldikKPj4gwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGRtYXJfbWFw
X2dmeCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogd2UgaGF2ZSB0byBlbnN1cmUgdGhlIGdm
eCBkZXZpY2UgaXMgaWRsZSBiZWZvcmUgd2UgZmx1c2ggKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHBjaV9pbmZvKGRldiwgIkRpc2FibGluZyBiYXRjaGVkIElPVExCIGZsdXNoIG9uIElyb25sYWtl
XG4iKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwo+PiAr
wqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QoKTsKPj4gwqDCoMKgwqDCoCB9Cj4+
IMKgIH0KPj4gwqAgREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUws
IDB4MDA0MCwgCj4+IHF1aXJrX2NhbHBlbGxhX25vX3NoYWRvd19ndHQpOwo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4
IGNjYmQ1ZDRjMWE1MC4uMTQ2Y2I3MWM3NDQxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0zNTAsMTAgKzM1
MCw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4+IMKg
IH0KPj4gwqAgZWFybHlfcGFyYW0oImlvbW11LnN0cmljdCIsIGlvbW11X2RtYV9zZXR1cCk7Cj4+
IC12b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgc3RyaWN0KQo+PiArdm9pZCBpb21tdV9z
ZXRfZG1hX3N0cmljdCh2b2lkKQo+PiDCoCB7Cj4+IC3CoMKgwqAgaWYgKHN0cmljdCB8fCAhKGlv
bW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkKPiAKPiBXZSBzaG91bGRuJ3Qg
bmVlZCB0byBrZWVwIElPTU1VX0NNRF9MSU5FX1NUUklDVCBhdCBhbGwgbm93LCBzaW5jZSBpdCB3
YXMgCj4gb25seSB0byBwcmV2ZW50IGEgZHJpdmVyJ3MgImRlZmF1bHQgbGF6eSIgc2V0dGluZyBw
YXNzZWQgaW4gaGVyZSBmcm9tIAo+IGRvd25ncmFkaW5nIGFuIGV4cGxpY2l0bHktc2V0IHN0cmlj
dCBtb2RlLgo+IAo+IFdpdGggdGhhdCBjbGVhbmVkIHVwIHRvbywKPiAKClBhdGNoIDEvNSBtZW50
aW9ucyB3aGV0aGVyIHRoZSBpbnZhbGlkYXRpb24gcG9saWN5IGNvbWVzIGZyb20gdGhlIApjbWRs
aW5lIC0gc2ltaWxhciB0byB0aGUgZGVmYXVsdCBkb21haW4gdHlwZSBwcmludCAtIHNvIEkgd2Fz
IGdvaW5nIHRvIAprZWVwIHRoYXQuCgpBbmQgdGhlbiBtYXliZSB3ZSBzaG91bGQgYWxzbyBzZXQg
aXQgZnJvbSB0aGUgZGVwcmVjYXRlZCB4ODYgCmRyaXZlci1zcGVjaWZpYyBwYXJhbXMuCgpCdXQg
aWYgeW91IHRoaW5rIHRoYXQgdGhlcmUgaXMgbm90IG11Y2ggdmFsdWUgaW4gdGhpcyBhZGRpdGlv
bmFsIGluZm8sIAp0aGVuIEkgY2FuIGp1c3QgZHJvcCBpdC4KCkNoZWVycywKSm9obgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
