Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2622EC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 10:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F39140AB5;
	Thu, 30 Jun 2022 10:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F39140AB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJpQGbUG0Bfw; Thu, 30 Jun 2022 10:52:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E241340ABA;
	Thu, 30 Jun 2022 10:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E241340ABA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 958FBC0021;
	Thu, 30 Jun 2022 10:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 317F6C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E473184581
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:52:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E473184581
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4bhFeMZLiN4 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 10:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA5E98457C
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA5E98457C
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:52:21 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYZpp4y5fz67Q6Z;
 Thu, 30 Jun 2022 18:49:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 12:52:17 +0200
Received: from [10.126.174.156] (10.126.174.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:52:16 +0100
Message-ID: <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
Date: Thu, 30 Jun 2022 11:52:18 +0100
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
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
In-Reply-To: <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
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

Pj4+Cj4+Pj4gwqDCoCBbwqDCoMKgIDQuMzE5MjUzXSBpb21tdTogQWRkaW5nIGRldmljZSAwMDAw
OjA2OjAwLjIgdG8gZ3JvdXAgNQo+Pj4+IMKgwqAgW8KgwqDCoCA0LjMyNTg2OV0gaW9tbXU6IEFk
ZGluZyBkZXZpY2UgMDAwMDoyMDowMS4wIHRvIGdyb3VwIDE1Cj4+Pj4gwqDCoCBbwqDCoMKgIDQu
MzMyNjQ4XSBpb21tdTogQWRkaW5nIGRldmljZSAwMDAwOjIwOjAyLjAgdG8gZ3JvdXAgMTYKPj4+
PiDCoMKgIFvCoMKgwqAgNC4zMzg5NDZdIHN3YXBwZXIvMCBpbnZva2VkIG9vbS1raWxsZXI6IAo+
Pj4+IGdmcF9tYXNrPTB4NjA0MGMwKEdGUF9LRVJORUx8X19HRlBfQ09NUCksIG5vZGVtYXNrPShu
dWxsKSwgb3JkZXI9MCwgCj4+Pj4gb29tX3Njb3JlX2Fkaj0wCj4+Pj4gwqDCoCBbwqDCoMKgIDQu
MzUwMjUxXSBzd2FwcGVyLzAgY3B1c2V0PS8gbWVtc19hbGxvd2VkPTAKPj4+PiDCoMKgIFvCoMKg
wqAgNC4zNTQ2MThdIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIAo+
Pj4+IDQuMTkuNTcubXg2NC4yODIgIzEKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdIEhhcmR3
YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjc0MjUvMDhWMDAxLCAKPj4+PiBCSU9TIDEu
OS4zIDA2LzI1LzIwMTkKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdIENhbGwgVHJhY2U6Cj4+
Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGR1bXBfc3RhY2srMHg0Ni8weDViCj4+Pj4gwqDC
oCBbwqDCoMKgIDQuMzU1NjEyXcKgIGR1bXBfaGVhZGVyKzB4NmIvMHgyODkKPj4+PiDCoMKgIFvC
oMKgwqAgNC4zNTU2MTJdwqAgb3V0X29mX21lbW9yeSsweDQ3MC8weDRjMAo+Pj4+IMKgwqAgW8Kg
wqDCoCA0LjM1NTYxMl3CoCBfX2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4OTcwLzB4MTAzMAo+Pj4+
IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBjYWNoZV9ncm93X2JlZ2luKzB4N2QvMHg1MjAKPj4+
PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgZmFsbGJhY2tfYWxsb2MrMHgxNDgvMHgyMDAKPj4+
PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAga21lbV9jYWNoZV9hbGxvY190cmFjZSsweGFjLzB4
MWYwCj4+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGluaXRfaW92YV9kb21haW4rMHgxMTIv
MHgxNzAKCk5vdGUgZm9yIEZlbmcgVGFuZzogVGhpcyBjYWxsY2hhaW4gZG9lcyBub3QgZXhpc3Qg
YW55bW9yZSBzaW5jZSB3ZSAKc2VwYXJhdGVkIG91dCB0aGUgcmNhY2hlIGluaXQgZnJvbSB0aGUg
SU9WQSBkb21haW4gaW5pdC4gSW5kZWVkLCBub3Qgc28gCm11Y2ggbWVtb3J5IGlzIHdhc3RlZCBm
b3IgdW51c2VkIHJjYWNoZXMgbm93LgoKTXkgcG9pbnQgcmVhbGx5IGlzIHRoYXQgaXQgd291bGQg
YmUgbmljZXIgdG8gc2VlIGEgbW9kZXJuIGNhbGxjaGFpbiAtIApidXQgZG9uJ3QgcmVhZCB0aGF0
IGFzIG1lIHNheWluZyB0aGF0IHRoZSBjaGFuZ2UgaXMgdGhpcyBwYXRjaCBpcyBiYWQuCgo+Pj4+
IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhbWRfaW9tbXVfZG9tYWluX2FsbG9jKzB4MTM4LzB4
MWEwCj4+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGlvbW11X2dyb3VwX2dldF9mb3JfZGV2
KzB4YzQvMHgxYTAKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgYW1kX2lvbW11X2FkZF9k
ZXZpY2UrMHgxM2EvMHg2MTAKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgYWRkX2lvbW11
X2dyb3VwKzB4MjAvMHgzMAo+Pj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBidXNfZm9yX2Vh
Y2hfZGV2KzB4NzYvMHhjMAo+Pj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBidXNfc2V0X2lv
bW11KzB4YjYvMHhmMAo+Pj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhbWRfaW9tbXVfaW5p
dF9hcGkrMHgxMTIvMHgxMzIKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgc3RhdGVfbmV4
dCsweGZiMS8weDExNjUKPj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgYW1kX2lvbW11X2lu
aXQrMHgxZi8weDY3Cj4+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIHBjaV9pb21tdV9pbml0
KzB4MTYvMHgzZgo+Pj4+IMKgwqAgLi4uCj4+Pj4gwqDCoCBbwqDCoMKgIDQuNjcwMjk1XSBVbnJl
Y2xhaW1hYmxlIHNsYWIgaW5mbzoKPj4+PiDCoMKgIC4uLgo+Pj4+IMKgwqAgW8KgwqDCoCA0Ljg1
NzU2NV0ga21hbGxvYy0yMDQ4wqDCoMKgwqDCoMKgwqDCoMKgwqAgNTkxNjRLQsKgwqDCoMKgwqAg
NTkxNjRLQgo+Pj4+Cj4+Pj4gQ2hhbmdlIElPVkFfTUFHX1NJWkUgZnJvbSAxMjggdG8gMTI3IHRv
IG1ha2Ugc2l6ZSBvZiAnaW92YV9tYWdhemluZScKPj4+PiAxMDI0IGJ5dGVzIHNvIHRoYXQgbm8g
bWVtb3J5IHdpbGwgYmUgd2FzdGVkLgo+Pj4+Cj4+Pj4gWzFdLiBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAxOS84LzEyLzI2Ngo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRmVuZyBUYW5nIDxmZW5n
LnRhbmdAaW50ZWwuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwg
NyArKysrKystCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJp
dmVycy9pb21tdS9pb3ZhLmMKPj4+PiBpbmRleCBkYjc3YWE2NzUxNDViLi4yNzYzNGRkZDliOTA0
IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+Pj4gKysrIGIvZHJpdmVy
cy9pb21tdS9pb3ZhLmMKPj4+PiBAQCAtNjE0LDcgKzYxNCwxMiBAQCBFWFBPUlRfU1lNQk9MX0dQ
TChyZXNlcnZlX2lvdmEpOwo+Pj4+IMKgwqAgKiBkeW5hbWljIHNpemUgdHVuaW5nIGRlc2NyaWJl
ZCBpbiB0aGUgcGFwZXIuCj4+Pj4gwqDCoCAqLwo+Pj4+IC0jZGVmaW5lIElPVkFfTUFHX1NJWkUg
MTI4Cj4+Pj4gKy8qCj4+Pj4gKyAqIEFzIGttYWxsb2MncyBidWZmZXIgc2l6ZSBpcyBmaXhlZCB0
byBwb3dlciBvZiAyLCAxMjcgaXMgY2hvc2VuIHRvCj4+Pj4gKyAqIGFzc3VyZSBzaXplIG9mICdp
b3ZhX21hZ3ppbmUnIHRvIGJlIDEwMjQgYnl0ZXMsIHNvIHRoYXQgbm8gbWVtb3J5Cj4+Pgo+Pj4g
VHlwbzogaW92YV9tYWdhemluZQo+Pj4KPj4+PiArICogd2lsbCBiZSB3YXN0ZWQuCj4+Pj4gKyAq
Lwo+Pj4+ICsjZGVmaW5lIElPVkFfTUFHX1NJWkUgMTI3Cj4+Cj4+IEkgZG8gd29uZGVyIGlmIHdl
IHdpbGwgc2VlIHNvbWUgc3RyYW5nZSBuZXcgYmVoYXZpb3VyIHNpbmNlIAo+PiBJT1ZBX0ZRX1NJ
WkUgJSBJT1ZBX01BR19TSVpFICE9IDAgbm93Li4uCj4gCj4gSSBkb3VidCBpdCAtIGV2ZW4gaWYg
YSBmbHVzaCBxdWV1ZSBkb2VzIGhhcHBlbiB0byBiZSBlbnRpcmVseSBmdWxsIG9mIAo+IGVxdWFs
LXNpemVkIElPVkFzLCBhIENQVSdzIGxvYWRlZCBtYWdhemluZXMgYWxzbyBib3RoIGJlaW5nIHBl
cmZlY3RseSAKPiBlbXB0eSB3aGVuIGl0IGNvbWVzIHRvIGR1bXAgYSBmdWxsIGZxIHNlZW0gZnVy
dGhlciB1bmxpa2VseSwgc28gaW4gCj4gcHJhY3RpY2UgSSBkb24ndCBzZWUgdGhpcyBtYWtpbmcg
YW55IGFwcHJlY2lhYmxlIGNoYW5nZSB0byB0aGUgCj4gbGlrZWxpaG9vZCBvZiBzcGlsbGluZyBi
YWNrIHRvIHRoZSBkZXBvdCBvciBub3QuIEluIGZhY3QgdGhlIHNtYWxsZXIgdGhlIAo+IG1hZ2F6
aW5lcyBnZXQsIHRoZSBsZXNzIHRpbWUgd291bGQgYmUgc3BlbnQgZmx1c2hpbmcgdGhlIGRlcG90
IGJhY2sgdG8gCj4gdGhlIHJidHJlZSwgd2hlcmUgeW91ciBpbnRlcmVzdGluZyB3b3JrbG9hZCBm
YWxscyBvZmYgdGhlIGNsaWZmIGFuZCAKPiBuZXZlciBjYXRjaGVzIGJhY2sgdXAgd2l0aCB0aGUg
ZnEgdGltZXIsIHNvIGF0IHNvbWUgcG9pbnQgaXQgbWlnaHQgZXZlbiAKPiBpbXByb3ZlICh1bmxl
c3MgaXQncyBhbHNvIGFscmVhZHkgY2xvc2UgdG8gdGhlIHBvaW50IHdoZXJlIHNtYWxsZXIgCj4g
Y2FjaGVzIHdvdWxkIGJvdHRsZW5lY2sgYWxsb2NhdGlvbikuLi4gbWlnaHQgYmUgaW50ZXJlc3Rp
bmcgdG8gCj4gZXhwZXJpbWVudCB3aXRoIGEgd2lkZXIgcmFuZ2Ugb2YgbWFnYXppbmUgc2l6ZXMg
aWYgeW91IGhhZCB0aGUgdGltZSBhbmQgCj4gaW5jbGluYXRpb24uCj4gCgpvaywgd2hhdCB5b3Ug
YXJlIHNheWluZyBzb3VuZHMgcmVhc29uYWJsZS4gSSBqdXN0IHJlbWVtYmVyIHRoYXQgd2hlbiB3
ZSAKYW5hbHl6ZWQgdGhlIGxvbmd0ZXJtIGFnaW5nIGlzc3VlIHRoYXQgd2UgY29uY2x1ZGVkIHRo
YXQgdGhlIEZRIHNpemUgYW5kIAppdHMgcmVsYXRpb24gdG8gdGhlIG1hZ2F6aW5lIHNpemUgd2Fz
IGEgZmFjdG9yIGFuZCB0aGlzIGNoYW5nZSBtYWtlcyBtZSAKYSBsaXR0bGUgd29ycmllZCBhYm91
dCBuZXcgaXNzdWVzLiBCZXR0ZXIgdGhlIGRldmlsIHlvdSBrbm93IGFuZCBhbGwgdGhhdC4uLgoK
QW55d2F5LCBpZiBJIGdldCBzb21lIHRpbWUgSSBtaWdodCBkbyBzb21lIHRlc3RpbmcgdG8gc2Vl
IGlmIHRoaXMgY2hhbmdlIApoYXMgYW55IGluZmx1ZW5jZS4KCkFub3RoZXIgdGhvdWdodCBpcyBp
ZiB3ZSBuZWVkIGV2ZW4gc3RvcmUgdGhlIHNpemUgaW4gdGhlIGlvdmFfbWFnYXppbmU/IAptYWdz
IGluIHRoZSBkZXBvdCBhcmUgYWx3YXlzIGZ1bGwuIEFzIHN1Y2gsIHdlIG9ubHkgbmVlZCB3b3Jy
eSBhYm91dCAKbWFncyBsb2FkZWQgaW4gdGhlIGNwdSByY2FjaGUgYW5kIHRoZWlyIHNpemVzLCBz
byBtYXliZSB3ZSBjb3VsZCBoYXZlIApzb21ldGhpbmcgbGlrZSB0aGlzOgoKc3RydWN0IGlvdmFf
bWFnYXppbmUgewotICAgICAgIHVuc2lnbmVkIGxvbmcgc2l6ZTsKICAgICAgICB1bnNpZ25lZCBs
b25nIHBmbnNbSU9WQV9NQUdfU0laRV07Cn07CgpAQCAtNjMxLDYgKzYzMCw4IEBAIHN0cnVjdCBp
b3ZhX2NwdV9yY2FjaGUgewogICAgICAgIHNwaW5sb2NrX3QgbG9jazsKICAgICAgICBzdHJ1Y3Qg
aW92YV9tYWdhemluZSAqbG9hZGVkOwogICAgICAgIHN0cnVjdCBpb3ZhX21hZ2F6aW5lICpwcmV2
OworICAgICAgIGludCBsb2FkZWRfc2l6ZTsKKyAgICAgICBpbnQgcHJldl9zaXplOwp9OwoKSSBo
YXZlbid0IHRyaWVkIHRvIGltcGxlbWVudCBpdCB0aG91Z2guLgoKVGhhbmtzLApKb2huCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
