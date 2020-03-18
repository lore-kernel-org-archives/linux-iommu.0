Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0822BC10F29
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 17:14:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E6D2071C
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 17:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6D2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F60D8819F;
	Wed, 18 Mar 2020 17:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBM0U3QHCCBw; Wed, 18 Mar 2020 17:14:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7905883C0;
	Wed, 18 Mar 2020 17:14:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABBF2C18DA;
	Wed, 18 Mar 2020 17:14:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F46EC013E;
 Wed, 18 Mar 2020 17:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 879B7886D0;
 Wed, 18 Mar 2020 17:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dcrPrBvWusRg; Wed, 18 Mar 2020 17:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4C2F4886A5;
 Wed, 18 Mar 2020 17:14:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAECF31B;
 Wed, 18 Mar 2020 10:14:02 -0700 (PDT)
Received: from [10.57.55.121] (unknown [10.57.55.121])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777723F52E;
 Wed, 18 Mar 2020 10:14:01 -0700 (PDT)
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
To: Auger Eric <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
 <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5b637bf5-dc49-b6eb-852a-a4317602d43e@arm.com>
Date: Wed, 18 Mar 2020 17:13:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
Content-Language: en-GB
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
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

T24gMjAyMC0wMy0xOCA0OjE0IHBtLCBBdWdlciBFcmljIHdyb3RlOgo+IEhpLAo+IAo+IE9uIDMv
MTgvMjAgMTowMCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIwLTAzLTE4IDExOjQw
IGFtLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+PiBXZSBkb24ndCBjdXJyZW50bHkg
c3VwcG9ydCBJT01NVXMgd2l0aCBhIHBhZ2UgZ3JhbnVsZSBsYXJnZXIgdGhhbiB0aGUKPj4+IHN5
c3RlbSBwYWdlIHNpemUuIFRoZSBJT1ZBIGFsbG9jYXRvciBoYXMgYSBCVUdfT04oKSBpbiB0aGlz
IGNhc2UsIGFuZAo+Pj4gVkZJTyBoYXMgYSBXQVJOX09OKCkuCj4gCj4gQWRkaW5nIEFsZXggaW4g
Q0MgaW4gY2FzZSBoZSBoYXMgdGltZSB0byBqdW1wIGluLiBBdCB0aGUgbW9tZW50IEkgZG9uJ3QK
PiBnZXQgd2h5IHRoaXMgV0FSTl9PTigpIGlzIGhlcmUuCj4gCj4gVGhpcyB3YXMgaW50cm9kdWNl
ZCBpbgo+IGM4ZGJjYTE2NWJiMDkwZjkyNjk5NmE1NzJlYTJiNWI1NzdiMzRiNzAgdmZpby9pb21t
dV90eXBlMTogQXZvaWQgb3ZlcmZsb3cKPiAKPj4+Cj4+PiBJdCBtaWdodCBiZSBwb3NzaWJsZSB0
byByZW1vdmUgdGhlc2Ugb2JzdGFjbGVzIGlmIG5lY2Vzc2FyeS4gSWYgdGhlIGhvc3QKPj4+IHVz
ZXMgNjRrQiBwYWdlcyBhbmQgdGhlIGd1ZXN0IHVzZXMgNGtCLCB0aGVuIGEgZGV2aWNlIGRyaXZl
ciBjYWxsaW5nCj4+PiBhbGxvY19wYWdlKCkgZm9sbG93ZWQgYnkgZG1hX21hcF9wYWdlKCkgd2ls
bCBjcmVhdGUgYSA2NGtCIG1hcHBpbmcgZm9yIGEKPj4+IDRrQiBwaHlzaWNhbCBwYWdlLCBhbGxv
d2luZyB0aGUgZW5kcG9pbnQgdG8gYWNjZXNzIHRoZSBuZWlnaGJvdXJpbmcgNjBrQgo+Pj4gb2Yg
bWVtb3J5LiBUaGlzIHByb2JsZW0gY291bGQgYmUgd29ya2VkIGFyb3VuZCB3aXRoIGJvdW5jZSBi
dWZmZXJzLgo+Pgo+PiBGV0lXIHRoZSBmdW5kYW1lbnRhbCBpc3N1ZSBpcyB0aGF0IGNhbGxlcnMg
b2YgaW9tbXVfbWFwKCkgbWF5IGV4cGVjdCB0bwo+PiBiZSBhYmxlIHRvIG1hcCB0d28gb3IgbW9y
ZSBwYWdlLWFsaWduZWQgcmVnaW9ucyBkaXJlY3RseSBhZGphY2VudCB0bwo+PiBlYWNoIG90aGVy
IGZvciBzY2F0dGVyLWdhdGhlciBwdXJwb3NlcyAob3IgcmluZyBidWZmZXIgdHJpY2tzKSwgYW5k
Cj4+IHRoYXQncyBqdXN0IG5vdCBwb3NzaWJsZSBpZiB0aGUgSU9NTVUgZ3JhbnVsZSBpcyB0b28g
YmlnLiBCb3VuY2UKPj4gYnVmZmVyaW5nIHdvdWxkIGJlIGEgdmlhYmxlIHdvcmthcm91bmQgZm9y
IHRoZSBzdHJlYW1pbmcgRE1BIEFQSSBhbmQKPj4gY2VydGFpbiBzaW1pbGFyIHVzZS1jYXNlcywg
YnV0IG5vdCBpbiBnZW5lcmFsIChlLmcuIGNvaGVyZW50IERNQSwgVkZJTywKPj4gR1BVcywgZXRj
LikKPj4KPj4gUm9iaW4uCj4+Cj4+PiBGb3IgdGhlIG1vbWVudCwgcmF0aGVyIHRoYW4gdHJpZ2dl
cmluZyB0aGUgSU9WQSBCVUdfT04oKSBvbiBtaXNtYXRjaGVkCj4+PiBwYWdlIHNpemVzLCBhYm9y
dCB0aGUgdmlydGlvLWlvbW11IHByb2JlIHdpdGggYW4gZXJyb3IgbWVzc2FnZS4KPiAKPiBJIHVu
ZGVyc3RhbmQgdGhpcyBpcyBhIGludHJvZHVjZWQgYXMgYSB0ZW1wb3Jhcnkgc29sdXRpb24gYnV0
IHRoaXMKPiBzb3VuZHMgYXMgYW4gaW1wb3J0YW50IGxpbWl0YXRpb24gdG8gbWUuIEZvciBpbnN0
YW5jZSB0aGlzIHdpbGwgcHJldmVudAo+IGZyb20gcnVubmluZyBhIGZlZG9yYSBndWVzdCBleHBv
c2VkIHdpdGggYSB2aXJ0aW8taW9tbXUgd2l0aCBhIFJIRUwgaG9zdC4KCkFzIGFib3ZlLCBldmVu
IGlmIHlvdSBieXBhc3NlZCBhbGwgdGhlIHdhcm5pbmdzIGl0IHdvdWxkbid0IHJlYWxseSB3b3Jr
IApwcm9wZXJseSBhbnl3YXkuIEluIGFsbCBjYXNlcyB0aGF0IHdvdWxkbid0IGJlIGNvbnNpZGVy
ZWQgYnJva2VuLCB0aGUgCnVuZGVybHlpbmcgaGFyZHdhcmUgSU9NTVVzIHNob3VsZCBzdXBwb3J0
IHRoZSBzYW1lIHNldCBvZiBncmFudWxlcyBhcyAKdGhlIENQVXMgKG9yIGF0IGxlYXN0IHRoZSBz
bWFsbGVzdCBvbmUpLCBzbyBpcyBpdCBhY3R1YWxseSBhcHByb3ByaWF0ZSAKZm9yIFJIRUwgdG8g
KHByZXN1bWFibHkpIGV4cG9zZSBhIDY0SyBncmFudWxlIGluIHRoZSBmaXJzdCBwbGFjZSwgcmF0
aGVyIAp0aGFuICJ3b3JrcyB3aXRoIGFueXRoaW5nIiA0Sz8gQW5kL29yIG1vcmUgZ2VuZXJhbGx5
IGlzIHRoZXJlIHBlcmhhcHMgYSAKaG9sZSBpbiB0aGUgdmlydGlvLWlvbW11IHNwZWMgV1JUIGJl
aW5nIGFibGUgdG8gbmVnb3RpYXRlIHBhZ2Vfc2l6ZV9tYXNrIApmb3IgYSBwYXJ0aWN1bGFyIGdy
YW51bGUgaWYgbXVsdGlwbGUgb3B0aW9ucyBhcmUgYXZhaWxhYmxlPwoKUm9iaW4uCgo+IAo+IFRo
YW5rcwo+IAo+IEVyaWMKPj4+Cj4+PiBSZXBvcnRlZC1ieTogQmhhcmF0IEJodXNoYW4gPGJiaHVz
aGFuMkBtYXJ2ZWxsLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tl
ciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVycy9pb21t
dS92aXJ0aW8taW9tbXUuYyB8IDkgKysrKysrKysrCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3ZpcnRpby1p
b21tdS5jIGIvZHJpdmVycy9pb21tdS92aXJ0aW8taW9tbXUuYwo+Pj4gaW5kZXggNmQ0ZTNjMmEy
ZGRiLi44MGQ1ZDhmNjIxYWIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L3ZpcnRpby1p
b21tdS5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jCj4+PiBAQCAtOTk4
LDYgKzk5OCw3IEBAIHN0YXRpYyBpbnQgdmlvbW11X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+Pj4gIMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqcGFyZW50X2RldiA9IHZkZXYt
PmRldi5wYXJlbnQ7Cj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlvbW11X2RldiAqdmlvbW11ID0g
TlVMTDsKPj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZ2ZGV2LT5kZXY7Cj4+
PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgdmlvbW11X3BhZ2Vfc2l6ZTsKPj4+ICDCoMKgwqDCoMKg
IHU2NCBpbnB1dF9zdGFydCA9IDA7Cj4+PiAgwqDCoMKgwqDCoCB1NjQgaW5wdXRfZW5kID0gLTFV
TDsKPj4+ICDCoMKgwqDCoMKgIGludCByZXQ7Cj4+PiBAQCAtMTAyOCw2ICsxMDI5LDE0IEBAIHN0
YXRpYyBpbnQgdmlvbW11X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlCj4+PiAqdmRldikKPj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfZnJlZV92cXM7Cj4+PiAgwqDCoMKgwqDCoCB9
Cj4+PiAgwqAgK8KgwqDCoCB2aW9tbXVfcGFnZV9zaXplID0gMVVMIDw8IF9fZmZzKHZpb21tdS0+
cGdzaXplX2JpdG1hcCk7Cj4+PiArwqDCoMKgIGlmICh2aW9tbXVfcGFnZV9zaXplID4gUEFHRV9T
SVpFKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2VycihkZXYsICJncmFudWxlIDB4JWx4IGxh
cmdlciB0aGFuIHN5c3RlbSBwYWdlIHNpemUKPj4+IDB4JWx4XG4iLAo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdmlvbW11X3BhZ2Vfc2l6ZSwgUEFHRV9TSVpFKTsKPj4+ICvCoMKgwqDCoMKg
wqDCoCByZXQgPSAtRUlOVkFMOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX2ZyZWVfdnFz
Owo+Pj4gK8KgwqDCoCB9Cj4+PiArCj4+PiAgwqDCoMKgwqDCoCB2aW9tbXUtPm1hcF9mbGFncyA9
IFZJUlRJT19JT01NVV9NQVBfRl9SRUFEIHwKPj4+IFZJUlRJT19JT01NVV9NQVBfRl9XUklURTsK
Pj4+ICDCoMKgwqDCoMKgIHZpb21tdS0+bGFzdF9kb21haW4gPSB+MFU7Cj4+PiAgIAo+Pgo+IApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
