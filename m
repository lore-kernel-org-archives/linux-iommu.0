Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BCEC43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 09:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 800EC41BD5;
	Thu, 30 Jun 2022 09:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 800EC41BD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDc3z38YdlZ5; Thu, 30 Jun 2022 09:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A2D194032F;
	Thu, 30 Jun 2022 09:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2D194032F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C75DC002D;
	Thu, 30 Jun 2022 09:37:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A951BC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D49D8452F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D49D8452F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AvdKT4IUZOSZ for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96B9284387
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96B9284387
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:37:27 +0000 (UTC)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYY8N6qV4z686VP;
 Thu, 30 Jun 2022 17:35:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:37:23 +0200
Received: from [10.126.174.156] (10.126.174.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:37:22 +0100
Message-ID: <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
Date: Thu, 30 Jun 2022 10:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
To: Robin Murphy <robin.murphy@arm.com>, Feng Tang <feng.tang@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, "Vlastimil
 Babka" <vbabka@suse.cz>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
In-Reply-To: <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
X-Originating-IP: [10.126.174.156]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Paul Menzel <pmenzel@molgen.mpg.de>
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMzAvMDYvMjAyMiAxMDowMiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDYtMzAg
MDg6MzMsIEZlbmcgVGFuZyB3cm90ZToKPj4ga21hbGxvYyB3aWxsIHJvdW5kIHVwIHRoZSByZXF1
ZXN0IHNpemUgdG8gcG93ZXIgb2YgMiwgYW5kIGN1cnJlbnQKPj4gaW92YV9tYWdhemluZSdzIHNp
emUgaXMgMTAzMiAoMTAyNCs4KSBieXRlcywgc28gZWFjaCBpbnN0YW5jZQo+PiBhbGxvY2F0ZWQg
d2lsbCBnZXQgMjA0OCBieXRlcyBmcm9tIGttYWxsb2MsIGNhdXNpbmcgYXJvdW5kIDFLQgo+PiB3
YXN0ZS4KPj4KPj4gQW5kIGluIHNvbWUgZXhzdHJlbWUgY2FzZSwgdGhlIG1lbW9yeSB3YXN0ZWQg
Y2FuIHRyaWdnZXIgT09NIGFzCj4+IHJlcG9ydGVkIGluIDIwMTkgb24gYSBjcmFzaCBrZXJuZWwg
d2l0aCAyNTYgTUIgbWVtb3J5IFsxXS4KPiAKPiBJIGRvbid0IHRoaW5rIGl0IHJlYWxseSBuZWVk
cyBwb2ludGluZyBvdXQgdGhhdCBleGNlc3NpdmUgbWVtb3J5IAo+IGNvbnN1bXB0aW9uIGNhbiBj
YXVzZSBPT00uIEVzcGVjaWFsbHkgbm90IGluIHRoZSBwYXJ0aWN1bGFybHkgc2lsbHkgCj4gY29u
dGV4dCBvZiBhIHN5c3RlbSB3aXRoIG9ubHkgMk1CIG9mIFJBTSBwZXIgQ1BVIC0gdGhhdCdzIHBy
ZXR0eSBtdWNoIAo+IGd1YXJhbnRlZWQgdG8gYmUgZG9vbWVkIG9uZSB3YXkgb3IgYW5vdGhlci4K
PiAKPj4gwqDCoCBbwqDCoMKgIDQuMzE5MjUzXSBpb21tdTogQWRkaW5nIGRldmljZSAwMDAwOjA2
OjAwLjIgdG8gZ3JvdXAgNQo+PiDCoMKgIFvCoMKgwqAgNC4zMjU4NjldIGlvbW11OiBBZGRpbmcg
ZGV2aWNlIDAwMDA6MjA6MDEuMCB0byBncm91cCAxNQo+PiDCoMKgIFvCoMKgwqAgNC4zMzI2NDhd
IGlvbW11OiBBZGRpbmcgZGV2aWNlIDAwMDA6MjA6MDIuMCB0byBncm91cCAxNgo+PiDCoMKgIFvC
oMKgwqAgNC4zMzg5NDZdIHN3YXBwZXIvMCBpbnZva2VkIG9vbS1raWxsZXI6IAo+PiBnZnBfbWFz
az0weDYwNDBjMChHRlBfS0VSTkVMfF9fR0ZQX0NPTVApLCBub2RlbWFzaz0obnVsbCksIG9yZGVy
PTAsIAo+PiBvb21fc2NvcmVfYWRqPTAKPj4gwqDCoCBbwqDCoMKgIDQuMzUwMjUxXSBzd2FwcGVy
LzAgY3B1c2V0PS8gbWVtc19hbGxvd2VkPTAKPj4gwqDCoCBbwqDCoMKgIDQuMzU0NjE4XSBDUFU6
IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCAKPj4gNC4xOS41Ny5teDY0LjI4
MiAjMQo+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQ
b3dlckVkZ2UgUjc0MjUvMDhWMDAxLCAKPj4gQklPUyAxLjkuMyAwNi8yNS8yMDE5Cj4+IMKgwqAg
W8KgwqDCoCA0LjM1NTYxMl0gQ2FsbCBUcmFjZToKPj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKg
IGR1bXBfc3RhY2srMHg0Ni8weDViCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBkdW1wX2hl
YWRlcisweDZiLzB4Mjg5Cj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBvdXRfb2ZfbWVtb3J5
KzB4NDcwLzB4NGMwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBfX2FsbG9jX3BhZ2VzX25v
ZGVtYXNrKzB4OTcwLzB4MTAzMAo+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgY2FjaGVfZ3Jv
d19iZWdpbisweDdkLzB4NTIwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBmYWxsYmFja19h
bGxvYysweDE0OC8weDIwMAo+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAga21lbV9jYWNoZV9h
bGxvY190cmFjZSsweGFjLzB4MWYwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBpbml0X2lv
dmFfZG9tYWluKzB4MTEyLzB4MTcwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhbWRfaW9t
bXVfZG9tYWluX2FsbG9jKzB4MTM4LzB4MWEwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBp
b21tdV9ncm91cF9nZXRfZm9yX2RldisweGM0LzB4MWEwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYx
Ml3CoCBhbWRfaW9tbXVfYWRkX2RldmljZSsweDEzYS8weDYxMAo+PiDCoMKgIFvCoMKgwqAgNC4z
NTU2MTJdwqAgYWRkX2lvbW11X2dyb3VwKzB4MjAvMHgzMAo+PiDCoMKgIFvCoMKgwqAgNC4zNTU2
MTJdwqAgYnVzX2Zvcl9lYWNoX2RldisweDc2LzB4YzAKPj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEy
XcKgIGJ1c19zZXRfaW9tbXUrMHhiNi8weGYwCj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBh
bWRfaW9tbXVfaW5pdF9hcGkrMHgxMTIvMHgxMzIKPj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKg
IHN0YXRlX25leHQrMHhmYjEvMHgxMTY1Cj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhbWRf
aW9tbXVfaW5pdCsweDFmLzB4NjcKPj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIHBjaV9pb21t
dV9pbml0KzB4MTYvMHgzZgo+PiDCoMKgIC4uLgo+PiDCoMKgIFvCoMKgwqAgNC42NzAyOTVdIFVu
cmVjbGFpbWFibGUgc2xhYiBpbmZvOgo+PiDCoMKgIC4uLgo+PiDCoMKgIFvCoMKgwqAgNC44NTc1
NjVdIGttYWxsb2MtMjA0OMKgwqDCoMKgwqDCoMKgwqDCoMKgIDU5MTY0S0LCoMKgwqDCoMKgIDU5
MTY0S0IKPj4KPj4gQ2hhbmdlIElPVkFfTUFHX1NJWkUgZnJvbSAxMjggdG8gMTI3IHRvIG1ha2Ug
c2l6ZSBvZiAnaW92YV9tYWdhemluZScKPj4gMTAyNCBieXRlcyBzbyB0aGF0IG5vIG1lbW9yeSB3
aWxsIGJlIHdhc3RlZC4KPj4KPj4gWzFdLiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS84LzEy
LzI2Ngo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIFRhbmcgPGZlbmcudGFuZ0BpbnRlbC5jb20+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDcgKysrKysrLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+IGluZGV4
IGRiNzdhYTY3NTE0NWIuLjI3NjM0ZGRkOWI5MDQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9t
bXUvaW92YS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+IEBAIC02MTQsNyArNjE0
LDEyIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHJlc2VydmVfaW92YSk7Cj4+IMKgwqAgKiBkeW5hbWlj
IHNpemUgdHVuaW5nIGRlc2NyaWJlZCBpbiB0aGUgcGFwZXIuCj4+IMKgwqAgKi8KPj4gLSNkZWZp
bmUgSU9WQV9NQUdfU0laRSAxMjgKPj4gKy8qCj4+ICsgKiBBcyBrbWFsbG9jJ3MgYnVmZmVyIHNp
emUgaXMgZml4ZWQgdG8gcG93ZXIgb2YgMiwgMTI3IGlzIGNob3NlbiB0bwo+PiArICogYXNzdXJl
IHNpemUgb2YgJ2lvdmFfbWFnemluZScgdG8gYmUgMTAyNCBieXRlcywgc28gdGhhdCBubyBtZW1v
cnkKPiAKPiBUeXBvOiBpb3ZhX21hZ2F6aW5lCj4gCj4+ICsgKiB3aWxsIGJlIHdhc3RlZC4KPj4g
KyAqLwo+PiArI2RlZmluZSBJT1ZBX01BR19TSVpFIDEyNwoKSSBkbyB3b25kZXIgaWYgd2Ugd2ls
bCBzZWUgc29tZSBzdHJhbmdlIG5ldyBiZWhhdmlvdXIgc2luY2UgSU9WQV9GUV9TSVpFIAolIElP
VkFfTUFHX1NJWkUgIT0gMCBub3cuLi4KCj4gCj4gVGhlIGNoYW5nZSBpdHNlbGYgc2VlbXMgcGVy
ZmVjdGx5IHJlYXNvbmFibGUsIHRob3VnaC4KPiAKPiBBY2tlZC1ieTogUm9iaW4gTXVycGh5IDxy
b2Jpbi5tdXJwaHlAYXJtLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
