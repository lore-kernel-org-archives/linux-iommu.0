Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE5FC4332F
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 17:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C04A7403D6;
	Fri,  8 Apr 2022 17:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-0dyQzjClaW; Fri,  8 Apr 2022 17:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91808404BB;
	Fri,  8 Apr 2022 17:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73B2CC0084;
	Fri,  8 Apr 2022 17:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AADAAC002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 811E141163
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AUkv923AEE1C for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 17:53:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A836341166
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 17:53:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C10F31042;
 Fri,  8 Apr 2022 10:53:05 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB9593F5A1;
 Fri,  8 Apr 2022 10:53:04 -0700 (PDT)
Message-ID: <b15c5e05-aac5-6fbc-de28-d1590c081c4b@arm.com>
Date: Fri, 8 Apr 2022 18:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/tegra: Stop using iommu_present()
Content-Language: en-GB
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, thierry.reding@gmail.com
References: <25247f43672df0aa58c1952bf3df2bf948e9f8ae.1649168393.git.robin.murphy@arm.com>
 <49165024-5f33-b6e6-7ec9-1ede6f562748@collabora.com>
 <0f7bf1c2-7a21-13a0-8734-c53f624e1edd@arm.com>
 <4cbc5418-b92b-1eed-44cc-82030616cb02@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4cbc5418-b92b-1eed-44cc-82030616cb02@collabora.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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

T24gMjAyMi0wNC0wNyAxODo1MSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IE9uIDQvNi8yMiAy
MTowNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIyLTA0LTA2IDE1OjMyLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4+PiBPbiA0LzUvMjIgMTc6MTksIFJvYmluIE11cnBoeSB3cm90ZToK
Pj4+PiBSZW1vdmUgdGhlIHBvaW50bGVzcyBjaGVjay4gaG9zdDF4X2RybV93YW50c19pb21tdSgp
IGNhbm5vdCByZXR1cm4gdHJ1ZQo+Pj4+IHVubGVzcyBhbiBJT01NVSBleGlzdHMgZm9yIHRoZSBo
b3N0MXggcGxhdGZvcm0gZGV2aWNlLCB3aGljaCBhdCB0aGUKPj4+PiBtb21lbnQKPj4+PiBtZWFu
cyB0aGUgaW9tbXVfcHJlc2VudCgpIHRlc3QgY291bGQgbmV2ZXIgZmFpbC4KPj4+Pgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+Pj4gLS0t
Cj4+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9kcm0uYyB8IDIgKy0KPj4+PiAgwqAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RybS5jIGIvZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL2RybS5jCj4+Pj4gaW5kZXggOTQ2NGY1MjJlMjU3Li5iYzQzMjE1NjE0MDAgMTAwNjQ0Cj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RybS5jCj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3RlZ3JhL2RybS5jCj4+Pj4gQEAgLTExNDksNyArMTE0OSw3IEBAIHN0YXRpYyBpbnQg
aG9zdDF4X2RybV9wcm9iZShzdHJ1Y3QKPj4+PiBob3N0MXhfZGV2aWNlICpkZXYpCj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIHB1dDsKPj4+PiAgwqDCoMKgwqDCoCB9Cj4+Pj4gIMKgIC3C
oMKgwqAgaWYgKGhvc3QxeF9kcm1fd2FudHNfaW9tbXUoZGV2KSAmJgo+Pj4+IGlvbW11X3ByZXNl
bnQoJnBsYXRmb3JtX2J1c190eXBlKSkgewo+Pj4+ICvCoMKgwqAgaWYgKGhvc3QxeF9kcm1fd2Fu
dHNfaW9tbXUoZGV2KSkgewo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgdGVncmEtPmRvbWFpbiA9
IGlvbW11X2RvbWFpbl9hbGxvYygmcGxhdGZvcm1fYnVzX3R5cGUpOwo+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCF0ZWdyYS0+ZG9tYWluKSB7Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVyciA9IC1FTk9NRU07Cj4+Pgo+Pj4gaG9zdDF4X2RybV93YW50c19pb21tdSgpIHJl
dHVybnMgdHJ1ZSBpZiB0aGVyZSBpcyBubyBJT01NVSBmb3IgdGhlCj4+PiBob3N0MXggcGxhdGZv
cm0gZGV2aWNlIG9mIFRlZ3JhMjAvMzAgU29Dcy4KPj4KPj4gQWgsIGFwcGFyZW50bHkgdGhpcyBp
cyBhbm90aGVyIGV4YW1wbGUgb2Ygd2hhdCBoYXBwZW5zIHdoZW4gSSB3cml0ZQo+PiBwYXRjaGVz
IGxhdGUgb24gYSBGcmlkYXkgbmlnaHQuLi4KPj4KPj4gU28gb24gc2Vjb25kIGxvb2ssIHdoYXQg
d2Ugd2FudCB0byBhc2NlcnRhaW4gaGVyZSBpcyB3aGV0aGVyIGRldiBoYXMgYW4KPj4gSU9NTVUs
IGJ1dCBvbmx5IGlmIHRoZSBob3N0MXggcGFyZW50IGlzIG5vdCBhZGRyZXNzaW5nLWxpbWl0ZWQs
IGVpdGhlcgo+PiBiZWNhdXNlIGl0IGNhbiBhbHNvIHVzZSB0aGUgSU9NTVUsIG9yIGJlY2F1c2Ug
YWxsIHBvc3NpYmxlIGFkZHJlc3NlcyBhcmUKPj4gc21hbGwgZW5vdWdoIGFueXdheSwgcmlnaHQ/
Cj4gCj4gWWVzCj4gCj4+IEFyZSB3ZSBzcGVjaWZpY2FsbHkgbG9va2luZyBmb3IgdGhlIGhvc3Qx
eAo+PiBoYXZpbmcgYSBETUEtQVBJLW1hbmFnZWQgZG9tYWluLCBvciBjYW4gdGhhdCBhbHNvIGVu
ZCB1cCB1c2luZyB0aGUKPj4gdGVncmEtPmRvbWFpbiBvciBhbm90aGVyIHVubWFuYWdlZCBkb21h
aW4gdG9vPwo+IAo+IFdlIGhhdmUgaG9zdDF4IERNQSB0aGF0IGNvdWxkIGhhdmU6Cj4gCj4gMS4g
Tm8gSU9NTVUgZG9tYWluLCBkZXBlbmRpbmcgb24ga2VybmVsL0RUIGNvbmZpZwo+IDIuIE1hbmFn
ZWQgZG9tYWluLCBvbiBuZXdlciBTb0NzCj4gMy4gVW5tYW5hZ2VkIGRvbWFpbiwgb24gb2xkZXIg
U29Dcwo+IAo+IFdlIGhhdmUgVGVncmEgRFJNIGRldmljZXMgd2hpY2ggY2FuOgo+IAo+IDEuIEJl
IGF0dGFjaGVkIHRvIGEgc2hhcmVkIHVubWFuYWdlZCB0ZWdyYS0+ZG9tYWluLCBvbiBvbGRlciBT
b0NzCj4gMi4gSGF2ZSBvd24gbWFuYWdlZCBkb21haW5zLCBvbiBuZXdlciBTb0NzCj4gCj4+IEkg
Y2FuJ3QgcXVpdGUgZmlndXJlIG91dAo+PiBmcm9tIHRoZSBjb21tZW50cyB3aGV0aGVyIGl0J3Mg
cGh5c2ljYWwgYWRkcmVzc2VzLCBJT1ZBcywgb3IgYm90aCB0aGF0Cj4+IHdlJ3JlIGNvbmNlcm5l
ZCB3aXRoIGhlcmUuCj4gCj4gVGVncmEgRFJNIGFsbG9jYXRlcyBidWZmZXJzIGFuZCBzdWJtaXRz
IGpvYnMgdG8gaC93IHVzaW5nIGhvc3QxeCdzCj4gY2hhbm5lbCBETUEuIERSTSBmcmFtZWJ1ZmZl
cnMnIGFkZHJlc3NlcyBhcmUgaW5zZXJ0ZWQgaW50byBob3N0MXgKPiBjb21tYW5kIGJ1ZmZlcnMg
Ynkga2VybmVsIGRyaXZlciBhbmQgYWRkcmVzc2VzIGJleW9uZCAzMmJpdCBzcGFjZSBuZWVkCj4g
dG8gYmUgdHJlYXRlZCBzcGVjaWFsbHksIHdlIGRvbid0IHN1cHBvcnQgc3VjaCBhZGRyZXNzZXMg
aW4gdXBzdHJlYW0uCj4gCj4gSU9NTVUgQVMgaXMgbGltaXRlZCB0byAzMmJpdHMgb24gVGVncmEg
aW4gdXBzdHJlYW0ga2VybmVsIGZvciBwcmUtVDE4Ngo+IFNvQ3MsIGl0IGhpZGVzIDY0Yml0IGFk
ZHJlc3NlcyBmcm9tIGhvc3QxeC4gUG9zdC1UMTg2IFNvQ3MgaGF2ZSBleHRyYQo+IGZlYXR1cmVz
IHRoYXQgYWxsb3cga2VybmVsIGRyaXZlciBub3QgdG8gYm90aGVyIGFib3V0IGFkZHJlc3Nlcy4K
PiAKPiBGb3IgbmV3ZXIgQVJNNjQgU29DcyB0aGVyZSBpcyBhc3N1bXB0aW9uIGluIHRoZSBUZWdy
YSBkcml2ZXJzIHRoYXQgSU9NTVUKPiBhbHdheXMgcHJlc2VudHMsIHRvIHNpbXBsaWZ5IHRoaW5n
cy4KClRoYXQgc3VtbWFyeSBoZWxwcyBhIGxvdCwgdGhhbmsgeW91IQoKSSB3YXMgcGFydGljdWxh
cmx5IHdvcnJpZWQgYWJvdXQgdGhlIGNhc2Ugd2hlcmUgdGhlIGhvc3QxeCBoYXMgYSAKcGFzc3Ro
cm91Z2ggZG9tYWluLCB3aGljaCB3ZSdsbCBhc3N1bWUgaXMgYSBETUEgZG9tYWluIGFuZCBsZWF2
ZSBpbiAKcGxhY2UsIGJ1dCBpZiBhbGwgdGhlIFNvQ3Mgd2l0aCB0aGUgMzItYml0IGdhdGhlciBs
aW1pdGF0aW9uIGFyZSBhbHNvIAp0aGUgb25lcyB3aXRoIHRlZ3JhLXNtbXUsIHdoaWNoIGRvZXNu
J3Qgc3VwcG9ydCBkZWZhdWx0IGRvbWFpbnMgYW55d2F5LCAKdGhlbiBpdCBzb3VuZHMgbGlrZSB0
aGF0J3MgYSBub24taXNzdWUuCgpJJ2xsIGdpdmUgdGhpcyBhIGJpdCBtb3JlIHRob3VnaHQgdG8g
bWFrZSBzdXJlIEkgcmVhbGx5IGdldCBpdCByaWdodCwgCmFuZCBzZW5kIGEgdjIgbmV4dCB3ZWVr
LgoKVGhhbmtzLApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
