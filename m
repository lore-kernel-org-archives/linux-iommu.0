Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F10C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 18:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59C5742557;
	Fri, 10 Dec 2021 18:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wHXb_-UmMd-j; Fri, 10 Dec 2021 18:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 44D7D42519;
	Fri, 10 Dec 2021 18:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF53C001E;
	Fri, 10 Dec 2021 18:13:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D076CC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B79C1614B4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w19ONdTo6Ifk for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:13:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C1F16147D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:13:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F0212FC;
 Fri, 10 Dec 2021 10:13:15 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3668E3F73D;
 Fri, 10 Dec 2021 10:13:14 -0800 (PST)
Message-ID: <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
Date: Fri, 10 Dec 2021 18:13:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and
 teardown
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
 <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
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

T24gMjAyMS0xMi0xMCAxODowNCwgSm9obiBHYXJyeSB2aWEgaW9tbXUgd3JvdGU6Cj4gT24gMTAv
MTIvMjAyMSAxNzo1NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBGcm9tOiBYaW9uZ2ZlbmcgV2Fu
Zzx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPgo+Pgo+PiBJdCB0dXJucyBvdXQgdG8gYmUgcG9z
c2libGUgZm9yIGhvdHBsdWdnaW5nIG91dCBhIGRldmljZSB0byByZWFjaCB0aGUKPj4gc3RhZ2Ug
b2YgdGVhcmluZyBkb3duIHRoZSBkZXZpY2UncyBncm91cCBhbmQgZGVmYXVsdCBkb21haW4gYmVm
b3JlIHRoZQo+PiBkb21haW4ncyBmbHVzaCBxdWV1ZSBoYXMgZHJhaW5lZCBuYXR1cmFsbHkuIEF0
IHRoaXMgcG9pbnQsIGl0IGlzIHRoZW4KPj4gcG9zc2libGUgZm9yIHRoZSB0aW1lb3V0IHRvIGV4
cGlyZSBqdXN0KmJlZm9yZSrCoCB0aGUgZGVsX3RpbWVyKCkgY2FsbAo+IAo+IHN1cGVyIG5pdDog
Imp1c3QqYmVmb3JlKsKgIHRoZSIgLSBuZWVkcyBhIHdoaXRlc3BhY2UgYmVmb3JlICJiZWZvcmUi
IDopCgpXZWlyZC4uLiB0aGUgb3JpZ2luYWwgcGF0Y2ggZmlsZSBoZXJlIGFuZCB0aGUgY29weSBy
ZWNlaXZlZCBieSBsb3JlIHZpYSAKbGludXgtaW9tbXUgbG9vayBmaW5lLCBncmVtbGlucyBpbiB5
b3VyIE1VQSBvciBkZWxpdmVyeSBwYXRoIHBlcmhhcHM/Cgo+PiBmcm9tIGZyZWVfaW92YV9mbHVz
aF9xdWV1ZSgpLCBzdWNoIHRoYXQgd2UgdGhlbiBwcm9jZWVkIHRvIGZyZWUgdGhlIEZRCj4+IHJl
c291cmNlcyB3aGlsZSBmcV9mbHVzaF90aW1lb3V0KCkgaXMgc3RpbGwgYWNjZXNzaW5nIHRoZW0g
b24gYW5vdGhlcgo+PiBDUFUuIENyYXNoZXMgZHVlIHRvIHRoaXMgaGF2ZSBiZWVuIG9ic2VydmVk
IGluIHRoZSB3aWxkIHdoaWxlIHJlbW92aW5nCj4+IE5WTWUgZGV2aWNlcy4KPj4KPj4gQ2xvc2Ug
dGhlIHJhY2Ugd2luZG93IGJ5IHVzaW5nIGRlbF90aW1lcl9zeW5jKCkgdG8gc2FmZWx5IHdhaXQg
Zm9yIGFueQo+PiBhY3RpdmUgdGltZW91dCBoYW5kbGVyIHRvIGZpbmlzaCBiZWZvcmUgd2Ugc3Rh
cnQgdG8gZnJlZSB0aGluZ3MuIFdlCj4+IGFscmVhZHkgYXZvaWQgYW55IGxvY2tpbmcgaW4gZnJl
ZV9pb3ZhX2ZsdXNoX3F1ZXVlKCkgc2luY2UgdGhlIEZRIGlzCj4+IHN1cHBvc2VkIHRvIGJlIGlu
YWN0aXZlIGFueXdheSwgc28gdGhlIHBvdGVudGlhbCBkZWFkbG9jayBzY2VuYXJpbyBkb2VzCj4+
IG5vdCBhcHBseS4KPj4KPj4gRml4ZXM6IDlhMDA1YTgwMGFlOCAoImlvbW11L2lvdmE6IEFkZCBm
bHVzaCB0aW1lciIpCj4+IFNpZ25lZC1vZmYtYnk6IFhpb25nZmVuZyBXYW5nPHdhbmd4aW9uZ2Zl
bmcyQGh1YXdlaS5jb20+Cj4+IFsgcm06IHJld3JpdGUgY29tbWl0IG1lc3NhZ2UgXQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHk8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gCj4gRldJVywK
PiAKPiBSZXZpZXdlZC1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgoKVGhh
bmtzIEpvaG4hCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
