Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01002C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964CA613AD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964CA613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 412D2404C2;
	Tue,  1 Jun 2021 16:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qz64SZr_SN8u; Tue,  1 Jun 2021 16:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDA40404B6;
	Tue,  1 Jun 2021 16:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE6F8C000D;
	Tue,  1 Jun 2021 16:42:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6783AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 16:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C40B404B8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 16:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yCvlsm0KRLZ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 16:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10754404B6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 16:42:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA9B101E;
 Tue,  1 Jun 2021 09:42:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFABC3F719;
 Tue,  1 Jun 2021 09:42:33 -0700 (PDT)
Subject: Re: [PATCH] iommu: Print default strict or lazy mode at init time
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
 <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
 <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <58ea001c-4c37-9c5a-77be-38ac3bea2476@arm.com>
Date: Tue, 1 Jun 2021 17:42:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
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

T24gMjAyMS0wNi0wMSAxNjo1MCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMS8wNi8yMDIxIDEw
OjA5LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+PiBpbmRleCA4MDhhYjcwZDVkZjUuLmYy
NWZhZTYyZjA3NyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysr
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+PiBAQCAtMTM4LDYgKzEzOCwxMSBAQCBzdGF0aWMg
aW50IF9faW5pdCBpb21tdV9zdWJzeXNfaW5pdCh2b2lkKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IChpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5FX0RNQV9BUEkpID8KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICIoc2V0IHZpYSBrZXJuZWwgY29tbWFuZCBsaW5lKSIgOiAiIik7
Cj4+PiArwqDCoMKgIHByX2luZm8oIkRlZmF1bHQgRE1BIGRvbWFpbiBtb2RlOiAlcyAlc1xuIiwK
Pj4KPj4gTml0OiBJIHRoaW5rIHRoaXMgbWlnaHQgYmUgYSBsaXR0bGUgdW5jbGVhciBmb3IgZW5k
LXVzZXJzIC0gKkknbSogbm90IAo+PiBldmVuIHN1cmUgd2hldGhlciAiRGVmYXVsdCIgaGVyZSBp
cyBtZWFudCB0byByZWZlciB0byB0aGUgbW9kZSBzZXR0aW5nIAo+PiBpdHNlbGYgb3IgdG8gZGVm
YXVsdCBkb21haW5zIChvZiBETUEgdHlwZSkuIE1heWJlIHNvbWV0aGluZyBsaWtlICJETUEgCj4+
IGRvbWFpbiBUTEIgaW52YWxpZGF0aW9uIHBvbGljeSI/IENlcnRhaW5seSBpdCBzZWVtcyBsaWtl
IGEgZ29vZCBpZGVhIAo+PiB0byBleHBsaWNpdGx5IG1lbnRpb24gaW52YWxpZGF0aW9uIHRvIGNv
cnJlbGF0ZSB3aXRoIHRoZSBkb2N1bWVudGF0aW9uIAo+PiBvZiB0aGUgImlvbW11LnN0cmljdCIg
cGFyYW1ldGVyLgo+Pgo+PiBBY2sgdG8gdGhlIGdlbmVyYWwgaWRlYSB0aG91Z2guCj4gCj4gb2ss
IHNvIEknbGwgZ28gd2l0aCB0aGlzOgo+IAo+IHByX2luZm8oIkRNQSBkb21haW4gZGVmYXVsdCBU
TEIgaW52YWxpZGF0aW9uIHBvbGljeTogJXMgbW9kZSAlc1xuIiwKPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA/ICJzdHJpY3QiIDogImxhenkiLAo+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5F
X1NUUklDVCkgPwo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiKHNldCB2aWEga2VybmVsIGNvbW1hbmQgbGluZSkiIDogIiIpOwo+IAo+IEkgdGhpbmsgaXQn
cyB3b3J0aCBtZW50aW9uaW5nICJkZWZhdWx0IiBzb21ld2hlcmUsIGFzIG5vdCBhbGwgSU9NTVVz
IG9yIAo+IGRldmljZXMgd2lsbCB1c2UgbGF6eSBtb2RlIGV2ZW4gaWYgaXQncyBkZWZhdWx0LgoK
QnV0IHRoYXQncyBwYXJ0IG9mIHdoYXQgSSB0aGluayBpcyBtaXNsZWFkaW5nIC0gSSBib290IGFu
ZCBzZWUgdGhhdCB0aGUgCmRlZmF1bHQgaXMgc29tZXRoaW5nLCBzbyBJIHJlYm9vdCB3aXRoIGlv
bW11LnN0cmljdCB0byBleHBsaWNpdGx5IHNldCBpdCAKdGhlIG90aGVyIHdheSwgYnV0IG5vdyB0
aGF0J3MgdGhlIGRlZmF1bHQuLi4gaHVoPwoKVGhlIHdheSBJIHNlZSBpdCwgd2UncmUgc2F5aW5n
IHdoYXQgdGhlIGN1cnJlbnQgSU9NTVUgQVBJIHBvbGljeSBpcyAtIAp0aGUgdmFsdWUgb2YgaW9t
bXVfZG1hX3N0cmljdCBhdCBhbnkgZ2l2ZW4gdGltZSBpcyBmYWN0IC0gYnV0IHdlJ3JlIG5vdCAK
bmVjZXNzYXJpbHkgc2F5aW5nIGhvdyB3aWRlbHkgdGhhdCBwb2xpY3kgaXMgZW5mb3JjZWQuIFdl
IHNpbWlsYXJseSAKcmVwb3J0IHRoZSB0eXBlIGZvciBkZWZhdWx0IGRvbWFpbnMgZnJvbSBnbG9i
YWwgcG9saWN5IGV2ZW4gdGhvdWdoIHRoYXQgCm1heSBhbHNvIGJlIG92ZXJyaWRkZW4gcGVyLWdy
b3VwIGJ5IGRyaXZlcnMgYW5kL29yIHVzZXJzcGFjZSBsYXRlcjsgd2UgCmRvbid0IHNheSBpdCdz
IHRoZSAqZGVmYXVsdCogZGVmYXVsdCBkb21haW4gdHlwZS4KCkhvd2V2ZXIsIGhhdmluZyBub3cg
ZGVidWdnZWQgdGhlIEFNRCBpc3N1ZSBmcm9tIGFub3RoZXIgdGhyZWFkLCBJIHRoaW5rIApkb2lu
ZyB0aGlzIGF0IHN1YnN5c19pbml0Y2FsbCBpcyBpbiBmYWN0IGdvaW5nIHRvIGJlIHRvbyBlYXJs
eSB0byBiZSAKbWVhbmluZ2Z1bCwgc2luY2UgaXQgaWdub3JlcyBkcml2ZXJzJyBhYmlsaXR5IHRv
IGNoYW5nZSB0aGUgZ2xvYmFsIHBvbGljeSA6KAoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
