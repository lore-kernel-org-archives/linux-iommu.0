Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1EC48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:30:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAEE60E0B
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAEE60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE036076C;
	Wed,  9 Jun 2021 15:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kEWbACyxtIN2; Wed,  9 Jun 2021 15:30:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3642E6061F;
	Wed,  9 Jun 2021 15:30:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2E4C000E;
	Wed,  9 Jun 2021 15:30:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D53A5C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1E074056C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqAH5ga-3aQx for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 15:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D8A34053A
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:30:07 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0W1T6RGvz6J9WM;
 Wed,  9 Jun 2021 23:17:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 17:30:04 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 16:30:03 +0100
Subject: Re: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
 <1623158308-180604-2-git-send-email-john.garry@huawei.com>
 <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <bef59822-71ab-a82e-ed95-0e139cf1fbf0@huawei.com>
Date: Wed, 9 Jun 2021 16:24:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com
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

T24gMDkvMDYvMjAyMSAxNjowMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDYtMDgg
MTQ6MTgsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IEZyb206IFpoZW4gTGVpIDx0aHVuZGVyLmxlaXpo
ZW5AaHVhd2VpLmNvbT4KPj4KPj4gRmlyc3QsIGFkZCBidWlsZCBvcHRpb25zIElPTU1VX0RFRkFV
TFRfe0xBWll8U1RSSUNUfSwgc28gdGhhdCB3ZSBoYXZlIHRoZQo+PiBvcHBvcnR1bml0eSB0byBz
ZXQge2xhenl8c3RyaWN0fSBtb2RlIGFzIGRlZmF1bHQgYXQgYnVpbGQgdGltZS4gVGhlbiBwdXQK
Pj4gdGhlIHR3byBjb25maWcgb3B0aW9ucyBpbiBhIGNob2ljZSwgYXMgdGhleSBhcmUgbXV0dWFs
bHkgZXhjbHVzaXZlLgo+Pgo+PiBbanBnOiBNYWtlIGNob2ljZSBiZXR3ZWVuIHN0cmljdCBhbmQg
bGF6eSBvbmx5IChhbmQgbm90IHBhc3N0aHJvdWdoKV0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbiBM
ZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIEdh
cnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L0tj
b25maWcgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCBkcml2
ZXJzL2lvbW11L2lvbW11LmMgfMKgIDMgKystCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9LY29uZmlnIGIvZHJpdmVycy9pb21tdS9LY29uZmlnCj4+IGluZGV4IDFmMTExYjM5OWJjYS4u
MzY5YTNhZjllNWJmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L0tjb25maWcKPj4gKysr
IGIvZHJpdmVycy9pb21tdS9LY29uZmlnCj4+IEBAIC05MCw2ICs5MCw0MSBAQCBjb25maWcgSU9N
TVVfREVGQVVMVF9QQVNTVEhST1VHSAo+PiDCoMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBO
IGhlcmUuCj4+ICtjaG9pY2UKPj4gK8KgwqDCoCBwcm9tcHQgIklPTU1VIGRlZmF1bHQgRE1BIG1v
ZGUiCj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBJT01NVV9BUEkKPj4gK8KgwqDCoCBkZXBlbmRzIG9u
IFg4NiB8fCBJQTY0IHx8IFg4Nl82NCB8fCBBUk0gfHwgQVJNNjQKPiAKPiBTaW1wbHkgImRlcGVu
ZHMgb24gSU9NTVVfRE1BIiBzaG91bGQgc3VmZmljZSwgc2luY2UgdGhhdCdzIG5vdyB0aGUgb25s
eSAKPiBwbGFjZSB3aGVyZSBmbHVzaCBxdWV1ZXMgbWF0dGVyLgoKSSBzdXBwb3NlIHNvLgoKQ29u
ZmlncyBBUk02NCwgQU1EX0lPTU1VLCBhbmQgSU5URUxfSU9NTVUgYWxsIHNlbGVjdCB0aGlzLgoK
PiAKPj4gKwo+PiArwqDCoMKgIGRlZmF1bHQgSU9NTVVfREVGQVVMVF9TVFJJQ1QKPj4gK8KgwqDC
oCBoZWxwCj4+ICvCoMKgwqDCoMKgIFRoaXMgb3B0aW9uIGFsbG93cyBhbiBJT01NVSBETUEgbW9k
ZSB0byBiZSBjaG9zZW4gYXQgYnVpbGQgCj4+IHRpbWUsIHRvCj4+ICvCoMKgwqDCoMKgIG92ZXJy
aWRlIHRoZSBkZWZhdWx0IERNQSBtb2RlIG9mIGVhY2ggQVJDSCwgcmVtb3ZpbmcgdGhlIG5lZWQg
dG8KPj4gK8KgwqDCoMKgwqAgcGFzcyBpbiBrZXJuZWwgcGFyYW1ldGVycyB0aHJvdWdoIGNvbW1h
bmQgbGluZS4gSXQgaXMgc3RpbGwgCj4+IHBvc3NpYmxlCj4+ICvCoMKgwqDCoMKgIHRvIHByb3Zp
ZGUgQVJDSC1zcGVjaWZpYyBvciBjb21tb24gYm9vdCBvcHRpb25zIHRvIG92ZXJyaWRlIHRoaXMK
Pj4gK8KgwqDCoMKgwqAgb3B0aW9uLgo+PiArCj4+ICvCoMKgwqDCoMKgIElmIHVuc3VyZSwga2Vl
cCB0aGUgZGVmYXVsdC4KPj4gKwo+PiArY29uZmlnIElPTU1VX0RFRkFVTFRfTEFaWQo+PiArwqDC
oMKgIGJvb2wgImxhenkiCj4+ICvCoMKgwqAgaGVscAo+PiArwqDCoMKgwqDCoCBTdXBwb3J0IGxh
enkgbW9kZSwgd2hlcmUgZm9yIGV2ZXJ5IElPTU1VIERNQSB1bm1hcCBvcGVyYXRpb24sIHRoZQo+
PiArwqDCoMKgwqDCoCBmbHVzaCBvcGVyYXRpb24gb2YgSU9UTEIgYW5kIHRoZSBmcmVlIG9wZXJh
dGlvbiBvZiBJT1ZBIGFyZSAKPj4gZGVmZXJyZWQuCj4+ICvCoMKgwqDCoMKgIFRoZXkgYXJlIG9u
bHkgZ3VhcmFudGVlZCB0byBiZSBkb25lIGJlZm9yZSB0aGUgcmVsYXRlZCBJT1ZBIAo+PiB3aWxs
IGJlCj4+ICvCoMKgwqDCoMKgIHJldXNlZC4KPj4gKwo+PiArY29uZmlnIElPTU1VX0RFRkFVTFRf
U1RSSUNUCj4+ICvCoMKgwqAgYm9vbCAic3RyaWN0Igo+PiArwqDCoMKgIGhlbHAKPj4gK8KgwqDC
oMKgwqAgRm9yIGV2ZXJ5IElPTU1VIERNQSB1bm1hcCBvcGVyYXRpb24sIHRoZSBmbHVzaCBvcGVy
YXRpb24gb2YgCj4+IElPVExCIGFuZAo+PiArwqDCoMKgwqDCoCB0aGUgZnJlZSBvcGVyYXRpb24g
b2YgSU9WQSBhcmUgZ3VhcmFudGVlZCB0byBiZSBkb25lIGluIHRoZSB1bm1hcAo+PiArwqDCoMKg
wqDCoCBmdW5jdGlvbi4KPj4gKwo+PiArwqDCoMKgwqDCoCBUaGlzIG1vZGUgaXMgc2FmZXIgdGhh
biBsYXp5IG1vZGUsIGJ1dCBpdCBtYXkgYmUgc2xvd2VyIGluIHNvbWUgCj4+IGhpZ2gKPj4gK8Kg
wqDCoMKgwqAgcGVyZm9ybWFuY2Ugc2NlbmFyaW9zLgo+IAo+IEZXSVcsIGFzIGFuIGVuZCB1c2Vy
IHdobyBkb2Vzbid0IGNhcmUgbXVjaCBhYm91dCB0aGUgaW1wbGVtZW50YXRpb24gCj4gZGV0YWls
cyBJJ2QgcHJvYmFibHkgYXBwcmVjaWF0ZSB0aGUgYWN0dWFsIGltcGxpY2F0aW9ucyBiZWluZyBj
bGVhcmVyLCAKPiBpLmUuIHdoYXQgZG9lcyAic2FmZXIiIG1lYW4gaW4gcHJhY3RpY2UgYW5kIHdo
YXQgaXMgaXQgcmVsYXRpdmUgdG8/Cj4gCgpGaW5lLCBJIGNhbiBtZW50aW9uIHRoYXQgbGF6eSBt
b2RlIG1lYW5zIHRoYXQgd2UgaGF2ZSByZWR1Y2VkIGRldmljZSAKaXNvbGF0aW9uIGFuZCBhIGRh
bmdlcm91cyB3aW5kb3cgY2FuIGJlIGNyZWF0ZWQgYmV0d2VlbiBkZXZpY2UgZHJpdmVyIApETUEg
dW5tYXAgYW5kIHphcHBpbmcgdGhlIG1hcHBpbmcgaW4gdGhlIElPTU1VOyBob3dldmVyIHN0aWxs
IG11Y2ggc2FmZXIgCnRoYW4gcGFzc3Rocm91Z2gvbm8gSU9NTVUsIHdoaWNoIG1lYW5zIG5vIGlz
b2xhdGlvbiBhdCBhbGwuCgpUaGFua3MsCkpvaG4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
