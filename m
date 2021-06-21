Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF7C48BE5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 08:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482F4610C7
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 08:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482F4610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7CE1831B0;
	Mon, 21 Jun 2021 08:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrmVBlNoKMiv; Mon, 21 Jun 2021 08:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6D6D83103;
	Mon, 21 Jun 2021 08:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D409C000E;
	Mon, 21 Jun 2021 08:19:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11A1DC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 08:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB5674036C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 08:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WNmgrPyZS790 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 08:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09F0240345
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 08:18:58 +0000 (UTC)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7hxk3T1Vz6K7Td;
 Mon, 21 Jun 2021 16:08:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 10:18:54 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 09:18:53 +0100
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>, <corbet@lwn.net>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
Date: Mon, 21 Jun 2021 09:12:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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

T24gMjEvMDYvMjAyMSAwNjoxNywgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMjAyMS82LzE4IDE5OjM0
LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IGluZGV4IDYwYjFlYzQyZTczYi4uZmYyMjFkM2Rk
Y2JjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4gKysrIGIvZHJpdmVy
cy9pb21tdS9pb21tdS5jCj4+IEBAIC0zNDksMTAgKzM0OSw5IEBAIHN0YXRpYyBpbnQgX19pbml0
IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4+IMKgIH0KPj4gwqAgZWFybHlfcGFyYW0oImlv
bW11LnN0cmljdCIsIGlvbW11X2RtYV9zZXR1cCk7Cj4+IC12b2lkIGlvbW11X3NldF9kbWFfc3Ry
aWN0KGJvb2wgc3RyaWN0KQo+PiArdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdCh2b2lkKQo+PiDC
oCB7Cj4+IC3CoMKgwqAgaWYgKHN0cmljdCB8fCAhKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01E
X0xJTkVfU1RSSUNUKSkKPj4gLcKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSBzdHJp
Y3Q7Cj4+ICvCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4+IMKgIH0KPiAKCkhpIGJh
b2x1LAoKPiBTb3JyeSBmb3IgdGhpcyBsYXRlIGNvbW1lbnQuCj4gID4gTm9ybWFsbHkgdGhlIGNh
Y2hlIGludmFsaWRhdGlvbiBwb2xpY3kgc2hvdWxkIGNvbWUgZnJvbSB0aGUgdXNlci4gV2UKPiBo
YXZlIHByZS1idWlsZCBrZXJuZWwgb3B0aW9uIGFuZCBhbHNvIGEga2VybmVsIGJvb3QgY29tbWFu
ZCBpb21tdS5zdHJpY3QKPiB0byBvdmVycmlkZSBpdC4gVGhlc2Ugc2VlbSByZWFzb25hYmxlLgo+
IAo+IFdlIGFsc28gaGF2ZSBhIGhlbHBlciAoaW9tbXVfc2V0X2RtYV9zdHJpY3QoKSkgc28gdGhh
dCB0aGUgdmVuZG9yIGlvbW11Cj4gZHJpdmVyIGNvdWxkIHNxdWVlemUgaW4gYW5kIGNoYW5nZSB0
aGUgcHJldmlvdXMgc2V0dGluZ3MgbW9zdGx5IGR1ZSB0bzoKPiAKPiBhKSB2ZW5kb3IgaW9tbXUg
ZHJpdmVyIHNwZWNpZmljIGtlcm5lbCBib290IGNvbW1hbmQuIChXZSBhcmUgYWJvdXQgdG8KPiAg
wqDCoCBkZXByZWNhdGUgdGhvc2UuKQo+IAo+IGIpIHF1aXJreSBoYXJkd2FyZS4KPiAKPiBjKSBr
ZXJuZWwgb3B0aW1pemF0aW9uIChlLnguIHN0cmljdCBtb2RlIGluIFZNIGVudmlyb25tZW50KS4K
PiAKPiBhKSBhbmQgYikgYXJlIG1hbmRhdG9yeSwgd2hpbGUgYykgaXMgb3B0aW9uYWwuIEluIGFu
eSBpbnN0YW5jZSBzaG91bGQgYykKPiBvdmVycmlkZSB0aGUgZmx1c2ggbW9kZSBzcGVjaWZpZWQg
YnkgdGhlIHVzZXIuIEhlbmNlLCBwcm9iYWJseSB3ZSBzaG91bGQKPiBhbHNvIGhhdmUgYW5vdGhl
ciBoZWxwZXIgbGlrZToKPiAKPiB2b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0X29wdGlvbmFsKCkK
PiB7Cj4gIMKgwqDCoMKgaWYgKCEoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJ
Q1QpKQo+ICDCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPiB9Cj4gCj4g
QW55IHRob3VnaHRzPwoKV2hhdCB5b3UgYXJlIHN1Z2dlc3RpbmcgaXMgYSBjaGFuZ2UgaW4gcG9s
aWN5IGZyb20gbWFpbmxpbmUgY29kZS4gCkN1cnJlbnRseSBmb3IgYykgd2UgYWx3YXlzIHNldCBz
dHJpY3QgZW5hYmxlZCwgcmVnYXJkbGVzcyBvZiBhbnkgdXNlciAKY21kbGluZSBpbnB1dC4gQnV0
IG5vdyB5b3UgYXJlIHNheWluZyB0aGF0IHlvdSB3YW50IGlvbW11LnN0cmljdCB0byAKb3ZlcnJp
ZGUgaW4gcGFydGljdWxhciBzY2VuYXJpbywgcmlnaHQ/CgpJbiB0aGF0IGNhc2UgSSB3b3VsZCB0
aGluayBpdCdzIGJldHRlciB0byByZXdvcmsgdGhlIGN1cnJlbnQgQVBJLCBsaWtlIAphZGRpbmcg
YW4gb3B0aW9uIHRvICJmb3JjZSIgc3RyaWN0IG1vZGU6Cgp2b2lkIGlvbW11X3NldF9kbWFfc3Ry
aWN0KGJvb2wgZm9yY2UpCnsKICAgICAgCWlmIChmb3JjZSA9PSB0cnVlKQoJCWlvbW11X2RtYV9z
dHJpY3QgPSB0cnVlOwoJZWxzZSBpZiAoIShpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5F
X1NUUklDVCkpCgkJaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cn0KClNvIHdlIHdvdWxkIHVzZSBp
b21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKSBmb3IgYSkgYW5kIGIpLCBidXQgCmlvbW11X3NldF9k
bWFfc3RyaWN0KGZhbHNlKSBmb3IgYykuCgpUaGVuIEkgYW0gbm90IHN1cmUgd2hhdCB5b3Ugd2Fu
dCB0byBkbyB3aXRoIHRoZSBhY2NvbXBhbnlpbmcgcHJpbnQgZm9yIApjKS4gSXQgd2FzOgoiSU9N
TVUgYmF0Y2hpbmcgaXMgZGlzYWJsZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uIgoKQW5kIG5vdyBp
cyBmcm9tIHRoaXMgc2VyaWVzOgoiSU9NTVUgYmF0Y2hpbmcgZGlzYWxsb3dlZCBkdWUgdG8gdmly
dHVhbGl6YXRpb24iCgpVc2luZyBpb21tdV9nZXRfZG1hX3N0cmljdChkb21haW4pIGlzIG5vdCBh
cHByb3ByaWF0ZSBoZXJlIHRvIGtub3cgdGhlIApjdXJyZW50IG1vZGUgKHNvIHdlIGtub3cgd2hl
dGhlciB0byBwcmludCkuCgpOb3RlIHRoYXQgdGhpcyBjaGFuZ2Ugd291bGQgbWVhbiB0aGF0IHRo
ZSBjdXJyZW50IHNlcmllcyB3b3VsZCByZXF1aXJlIApub24tdHJpdmlhbCByZXdvcmssIHdoaWNo
IHdvdWxkIGJlIHVuZm9ydHVuYXRlIHNvIGxhdGUgaW4gdGhlIGN5Y2xlLgoKVGhhbmtzLApKb2hu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
