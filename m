Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3A7C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 10:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D398458F;
	Thu, 30 Jun 2022 10:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06D398458F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6VqO9Ee1k0RW; Thu, 30 Jun 2022 10:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FF0E81B99;
	Thu, 30 Jun 2022 10:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FF0E81B99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 441D6C0021;
	Thu, 30 Jun 2022 10:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70237C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30E6483E8B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30E6483E8B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfvns1eCK03o for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 10:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD73C81B99
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD73C81B99
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 10:06:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 521B11042;
 Thu, 30 Jun 2022 03:06:30 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3C23F5A1;
 Thu, 30 Jun 2022 03:06:27 -0700 (PDT)
Message-ID: <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
Date: Thu, 30 Jun 2022 11:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, Feng Tang <feng.tang@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi0wNi0zMCAxMDozNywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAzMC8wNi8yMDIyIDEw
OjAyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjItMDYtMzAgMDg6MzMsIEZlbmcgVGFu
ZyB3cm90ZToKPj4+IGttYWxsb2Mgd2lsbCByb3VuZCB1cCB0aGUgcmVxdWVzdCBzaXplIHRvIHBv
d2VyIG9mIDIsIGFuZCBjdXJyZW50Cj4+PiBpb3ZhX21hZ2F6aW5lJ3Mgc2l6ZSBpcyAxMDMyICgx
MDI0KzgpIGJ5dGVzLCBzbyBlYWNoIGluc3RhbmNlCj4+PiBhbGxvY2F0ZWQgd2lsbCBnZXQgMjA0
OCBieXRlcyBmcm9tIGttYWxsb2MsIGNhdXNpbmcgYXJvdW5kIDFLQgo+Pj4gd2FzdGUuCj4+Pgo+
Pj4gQW5kIGluIHNvbWUgZXhzdHJlbWUgY2FzZSwgdGhlIG1lbW9yeSB3YXN0ZWQgY2FuIHRyaWdn
ZXIgT09NIGFzCj4+PiByZXBvcnRlZCBpbiAyMDE5IG9uIGEgY3Jhc2gga2VybmVsIHdpdGggMjU2
IE1CIG1lbW9yeSBbMV0uCj4+Cj4+IEkgZG9uJ3QgdGhpbmsgaXQgcmVhbGx5IG5lZWRzIHBvaW50
aW5nIG91dCB0aGF0IGV4Y2Vzc2l2ZSBtZW1vcnkgCj4+IGNvbnN1bXB0aW9uIGNhbiBjYXVzZSBP
T00uIEVzcGVjaWFsbHkgbm90IGluIHRoZSBwYXJ0aWN1bGFybHkgc2lsbHkgCj4+IGNvbnRleHQg
b2YgYSBzeXN0ZW0gd2l0aCBvbmx5IDJNQiBvZiBSQU0gcGVyIENQVSAtIHRoYXQncyBwcmV0dHkg
bXVjaCAKPj4gZ3VhcmFudGVlZCB0byBiZSBkb29tZWQgb25lIHdheSBvciBhbm90aGVyLgo+Pgo+
Pj4gwqDCoCBbwqDCoMKgIDQuMzE5MjUzXSBpb21tdTogQWRkaW5nIGRldmljZSAwMDAwOjA2OjAw
LjIgdG8gZ3JvdXAgNQo+Pj4gwqDCoCBbwqDCoMKgIDQuMzI1ODY5XSBpb21tdTogQWRkaW5nIGRl
dmljZSAwMDAwOjIwOjAxLjAgdG8gZ3JvdXAgMTUKPj4+IMKgwqAgW8KgwqDCoCA0LjMzMjY0OF0g
aW9tbXU6IEFkZGluZyBkZXZpY2UgMDAwMDoyMDowMi4wIHRvIGdyb3VwIDE2Cj4+PiDCoMKgIFvC
oMKgwqAgNC4zMzg5NDZdIHN3YXBwZXIvMCBpbnZva2VkIG9vbS1raWxsZXI6IAo+Pj4gZ2ZwX21h
c2s9MHg2MDQwYzAoR0ZQX0tFUk5FTHxfX0dGUF9DT01QKSwgbm9kZW1hc2s9KG51bGwpLCBvcmRl
cj0wLCAKPj4+IG9vbV9zY29yZV9hZGo9MAo+Pj4gwqDCoCBbwqDCoMKgIDQuMzUwMjUxXSBzd2Fw
cGVyLzAgY3B1c2V0PS8gbWVtc19hbGxvd2VkPTAKPj4+IMKgwqAgW8KgwqDCoCA0LjM1NDYxOF0g
Q1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgCj4+PiA0LjE5LjU3Lm14
NjQuMjgyICMxCj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdIEhhcmR3YXJlIG5hbWU6IERlbGwg
SW5jLiBQb3dlckVkZ2UgUjc0MjUvMDhWMDAxLCAKPj4+IEJJT1MgMS45LjMgMDYvMjUvMjAxOQo+
Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXSBDYWxsIFRyYWNlOgo+Pj4gwqDCoCBbwqDCoMKgIDQu
MzU1NjEyXcKgIGR1bXBfc3RhY2srMHg0Ni8weDViCj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJd
wqAgZHVtcF9oZWFkZXIrMHg2Yi8weDI4OQo+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIG91
dF9vZl9tZW1vcnkrMHg0NzAvMHg0YzAKPj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBfX2Fs
bG9jX3BhZ2VzX25vZGVtYXNrKzB4OTcwLzB4MTAzMAo+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEy
XcKgIGNhY2hlX2dyb3dfYmVnaW4rMHg3ZC8weDUyMAo+Pj4gwqDCoCBbwqDCoMKgIDQuMzU1NjEy
XcKgIGZhbGxiYWNrX2FsbG9jKzB4MTQ4LzB4MjAwCj4+PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJd
wqAga21lbV9jYWNoZV9hbGxvY190cmFjZSsweGFjLzB4MWYwCj4+PiDCoMKgIFvCoMKgwqAgNC4z
NTU2MTJdwqAgaW5pdF9pb3ZhX2RvbWFpbisweDExMi8weDE3MAo+Pj4gwqDCoCBbwqDCoMKgIDQu
MzU1NjEyXcKgIGFtZF9pb21tdV9kb21haW5fYWxsb2MrMHgxMzgvMHgxYTAKPj4+IMKgwqAgW8Kg
wqDCoCA0LjM1NTYxMl3CoCBpb21tdV9ncm91cF9nZXRfZm9yX2RldisweGM0LzB4MWEwCj4+PiDC
oMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgYW1kX2lvbW11X2FkZF9kZXZpY2UrMHgxM2EvMHg2MTAK
Pj4+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhZGRfaW9tbXVfZ3JvdXArMHgyMC8weDMwCj4+
PiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgYnVzX2Zvcl9lYWNoX2RldisweDc2LzB4YzAKPj4+
IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBidXNfc2V0X2lvbW11KzB4YjYvMHhmMAo+Pj4gwqDC
oCBbwqDCoMKgIDQuMzU1NjEyXcKgIGFtZF9pb21tdV9pbml0X2FwaSsweDExMi8weDEzMgo+Pj4g
wqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIHN0YXRlX25leHQrMHhmYjEvMHgxMTY1Cj4+PiDCoMKg
IFvCoMKgwqAgNC4zNTU2MTJdwqAgYW1kX2lvbW11X2luaXQrMHgxZi8weDY3Cj4+PiDCoMKgIFvC
oMKgwqAgNC4zNTU2MTJdwqAgcGNpX2lvbW11X2luaXQrMHgxNi8weDNmCj4+PiDCoMKgIC4uLgo+
Pj4gwqDCoCBbwqDCoMKgIDQuNjcwMjk1XSBVbnJlY2xhaW1hYmxlIHNsYWIgaW5mbzoKPj4+IMKg
wqAgLi4uCj4+PiDCoMKgIFvCoMKgwqAgNC44NTc1NjVdIGttYWxsb2MtMjA0OMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDU5MTY0S0LCoMKgwqDCoMKgIDU5MTY0S0IKPj4+Cj4+PiBDaGFuZ2UgSU9WQV9N
QUdfU0laRSBmcm9tIDEyOCB0byAxMjcgdG8gbWFrZSBzaXplIG9mICdpb3ZhX21hZ2F6aW5lJwo+
Pj4gMTAyNCBieXRlcyBzbyB0aGF0IG5vIG1lbW9yeSB3aWxsIGJlIHdhc3RlZC4KPj4+Cj4+PiBb
MV0uIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzgvMTIvMjY2Cj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogRmVuZyBUYW5nIDxmZW5nLnRhbmdAaW50ZWwuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2
ZXJzL2lvbW11L2lvdmEuYyB8IDcgKysrKysrLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiBpbmRleCBkYjc3YWE2NzUxNDVi
Li4yNzYzNGRkZDliOTA0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiBAQCAtNjE0LDcgKzYxNCwxMiBAQCBFWFBP
UlRfU1lNQk9MX0dQTChyZXNlcnZlX2lvdmEpOwo+Pj4gwqDCoCAqIGR5bmFtaWMgc2l6ZSB0dW5p
bmcgZGVzY3JpYmVkIGluIHRoZSBwYXBlci4KPj4+IMKgwqAgKi8KPj4+IC0jZGVmaW5lIElPVkFf
TUFHX1NJWkUgMTI4Cj4+PiArLyoKPj4+ICsgKiBBcyBrbWFsbG9jJ3MgYnVmZmVyIHNpemUgaXMg
Zml4ZWQgdG8gcG93ZXIgb2YgMiwgMTI3IGlzIGNob3NlbiB0bwo+Pj4gKyAqIGFzc3VyZSBzaXpl
IG9mICdpb3ZhX21hZ3ppbmUnIHRvIGJlIDEwMjQgYnl0ZXMsIHNvIHRoYXQgbm8gbWVtb3J5Cj4+
Cj4+IFR5cG86IGlvdmFfbWFnYXppbmUKPj4KPj4+ICsgKiB3aWxsIGJlIHdhc3RlZC4KPj4+ICsg
Ki8KPj4+ICsjZGVmaW5lIElPVkFfTUFHX1NJWkUgMTI3Cj4gCj4gSSBkbyB3b25kZXIgaWYgd2Ug
d2lsbCBzZWUgc29tZSBzdHJhbmdlIG5ldyBiZWhhdmlvdXIgc2luY2UgSU9WQV9GUV9TSVpFIAo+
ICUgSU9WQV9NQUdfU0laRSAhPSAwIG5vdy4uLgoKSSBkb3VidCBpdCAtIGV2ZW4gaWYgYSBmbHVz
aCBxdWV1ZSBkb2VzIGhhcHBlbiB0byBiZSBlbnRpcmVseSBmdWxsIG9mIAplcXVhbC1zaXplZCBJ
T1ZBcywgYSBDUFUncyBsb2FkZWQgbWFnYXppbmVzIGFsc28gYm90aCBiZWluZyBwZXJmZWN0bHkg
CmVtcHR5IHdoZW4gaXQgY29tZXMgdG8gZHVtcCBhIGZ1bGwgZnEgc2VlbSBmdXJ0aGVyIHVubGlr
ZWx5LCBzbyBpbiAKcHJhY3RpY2UgSSBkb24ndCBzZWUgdGhpcyBtYWtpbmcgYW55IGFwcHJlY2lh
YmxlIGNoYW5nZSB0byB0aGUgCmxpa2VsaWhvb2Qgb2Ygc3BpbGxpbmcgYmFjayB0byB0aGUgZGVw
b3Qgb3Igbm90LiBJbiBmYWN0IHRoZSBzbWFsbGVyIHRoZSAKbWFnYXppbmVzIGdldCwgdGhlIGxl
c3MgdGltZSB3b3VsZCBiZSBzcGVudCBmbHVzaGluZyB0aGUgZGVwb3QgYmFjayB0byAKdGhlIHJi
dHJlZSwgd2hlcmUgeW91ciBpbnRlcmVzdGluZyB3b3JrbG9hZCBmYWxscyBvZmYgdGhlIGNsaWZm
IGFuZCAKbmV2ZXIgY2F0Y2hlcyBiYWNrIHVwIHdpdGggdGhlIGZxIHRpbWVyLCBzbyBhdCBzb21l
IHBvaW50IGl0IG1pZ2h0IGV2ZW4gCmltcHJvdmUgKHVubGVzcyBpdCdzIGFsc28gYWxyZWFkeSBj
bG9zZSB0byB0aGUgcG9pbnQgd2hlcmUgc21hbGxlciAKY2FjaGVzIHdvdWxkIGJvdHRsZW5lY2sg
YWxsb2NhdGlvbikuLi4gbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gCmV4cGVyaW1lbnQgd2l0aCBh
IHdpZGVyIHJhbmdlIG9mIG1hZ2F6aW5lIHNpemVzIGlmIHlvdSBoYWQgdGhlIHRpbWUgYW5kIApp
bmNsaW5hdGlvbi4KCkNoZWVycywKUm9iaW4uCgo+IAo+Pgo+PiBUaGUgY2hhbmdlIGl0c2VsZiBz
ZWVtcyBwZXJmZWN0bHkgcmVhc29uYWJsZSwgdGhvdWdoLgo+Pgo+PiBBY2tlZC1ieTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiAKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
