Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D19C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 02:28:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DAA61051
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 02:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80DAA61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4637A402E9;
	Wed, 18 Aug 2021 02:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLwUSO045xPR; Wed, 18 Aug 2021 02:28:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08D70402DF;
	Wed, 18 Aug 2021 02:28:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFF61C001A;
	Wed, 18 Aug 2021 02:28:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA1BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 02:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1409740222
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 02:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ohjoGb9aHrI for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 02:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 819EA401B4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 02:28:27 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GqBYK5wKfz8sYn;
 Wed, 18 Aug 2021 10:24:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:28:10 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:28:10 +0800
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify useless instructions in
 arm_smmu_cmdq_build_cmd()
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210817113450.2026-1-thunder.leizhen@huawei.com>
 <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <54b94259-628a-1763-0f1e-e2e7c2b2a297@huawei.com>
Date: Wed, 18 Aug 2021 10:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIxLzgvMTcgMjE6MjMsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTA4LTE3
IDEyOjM0LCBaaGVuIExlaSB3cm90ZToKPj4gQWx0aG91Z2ggdGhlIHBhcmFtZXRlciAnY21kJyBp
cyBhbHdheXMgcGFzc2VkIGJ5IGEgbG9jYWwgYXJyYXkgdmFyaWFibGUsCj4+IGFuZCBvbmx5IHRo
aXMgZnVuY3Rpb24gbW9kaWZpZXMgaXQsIHRoZSBjb21waWxlciBkb2VzIG5vdCBrbm93IHRoaXMu
IFRoZQo+PiBjb21waWxlciBhbG1vc3QgYWx3YXlzIHJlYWRzIHRoZSB2YWx1ZSBvZiBjbWRbaV0g
ZnJvbSBtZW1vcnkgcmF0aGVyIHRoYW4KPj4gZGlyZWN0bHkgdXNpbmcgdGhlIHZhbHVlIGNhY2hl
ZCBpbiB0aGUgcmVnaXN0ZXIuIFRoaXMgZ2VuZXJhdGVzIG1hbnkKPj4gdXNlbGVzcyBpbnN0cnVj
dGlvbiBvcGVyYXRpb25zIGFuZCBhZmZlY3RzIHRoZSBwZXJmb3JtYW5jZSB0byBzb21lIGV4dGVu
dC4KPiAKPiBXaGljaCBjb21waWxlcj8gR0NDIDQuOSBkb2VzIG5vdCBtYWtlIHRoZSBzYW1lIGNv
ZGVnZW4gZGVjaXNpb25zIHRoYXQgR0NDIDEwIGRvZXM7IENsYW5nIGlzIGRpZmZlcmVudCBhZ2Fp
bi4gVGhlcmUgYXJlIGFsc28gdmFyaW91cyBjb25maWcgb3B0aW9ucyB3aGljaCBhZmZlY3QgYSBj
b21waWxlcidzIGlubGluaW5nL29wdGltaXNhdGlvbiBjaG9pY2VzIGVpdGhlciBkaXJlY3RseSBv
ciBpbmRpcmVjdGx5LgoKZ2NjIHZlcnNpb24gNy4zLjEgMjAxODA0MjUgW2xpbmFyby03LjMtMjAx
OC4wNSByZXZpc2lvbiBkMjkxMjBhNDI0ZWNmYmMxNjdlZjkwMDY1YzBlZWI3ZjkxOTc3NzAxXSAo
TGluYXJvIEdDQyA3LjMtMjAxOC4wNSkKCkluIGFkZGl0aW9uLCB5ZXN0ZXJkYXkgbW9ybmluZyBJ
IGFsc28gcHVycG9zZWx5IGNvbXBpbGVkIGEgY29tcGlsZXIgd2l0aCB0aGUgbGF0ZXN0CkdDQyBz
b3VyY2UgY29kZS4gVGhlIHJlc3VsdCBpcyB0aGUgc2FtZS4KCmdjYyB2ZXJzaW9uIDExLjIuMCAo
R0NDKQoKPiAKPiBJZiBpdCdzIHNvbWV0aGluZyB0aGF0IG5ld2VyIGNvbXBpbGVycyBjYW4gZ2V0
IHJpZ2h0IGFueXdheSwgdGhlbiBtaWNyby1vcHRpbWlzaW5nIGp1c3QgZm9yIG9sZGVyIG9uZXMg
bWlnaHQgd2FycmFudCBhIGJpdCBtb3JlIGp1c3RpZmljYXRpb24uCj4gCj4+IFRvIGd1aWRlIHRo
ZSBjb21waWxlciBmb3IgcHJvcGVyIG9wdGltaXphdGlvbiwgJ2NtZCcgaXMgZGVmaW5lZCBhcyBh
IGxvY2FsCj4+IGFycmF5IHZhcmlhYmxlLCBtYXJrZWQgYXMgcmVnaXN0ZXIsIGFuZCBjb3BpZWQg
dG8gdGhlIG91dHB1dCBwYXJhbWV0ZXIgYXQKPj4gYSB0aW1lIHdoZW4gdGhlIGZ1bmN0aW9uIGlz
IHJldHVybmVkLgo+Pgo+PiBUaGUgb3B0aW1pemF0aW9uIGVmZmVjdCBjYW4gYmUgdmlld2VkIGJ5
IHJ1bm5pbmcgdGhlICJzaXplIGFybS1zbW11LXYzLm8iCj4+IGNvbW1hbmQuCj4+Cj4+IEJlZm9y
ZToKPj4gwqDCoMKgIHRleHTCoMKgwqAgZGF0YcKgwqDCoMKgIGJzc8KgwqDCoMKgIGRlY8KgwqDC
oMKgIGhleAo+PiDCoMKgIDI3NjAywqDCoMKgIDEzNDjCoMKgwqDCoMKgIDU2wqDCoCAyOTAwNsKg
wqDCoCA3MTRlCj4+Cj4+IEFmdGVyOgo+PiDCoMKgwqAgdGV4dMKgwqDCoCBkYXRhwqDCoMKgwqAg
YnNzwqDCoMKgwqAgZGVjwqDCoMKgwqAgaGV4Cj4+IMKgwqAgMjc0MDLCoMKgwqAgMTM0OMKgwqDC
oMKgwqAgNTbCoMKgIDI4ODA2wqDCoMKgIDcwODYKPj4KPj4gU2lnbmVkLW9mZi1ieTogWmhlbiBM
ZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDE4ICsrKysrKysrKysrKysrKy0tLQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+IGluZGV4
IGQ3NmJiYmRlNTU4Yjc3Ni4uNTBhOWRiNWJhYzQ2NmM3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gQEAgLTIzMywxMSArMjMzLDE5IEBA
IHN0YXRpYyBpbnQgcXVldWVfcmVtb3ZlX3JhdyhzdHJ1Y3QgYXJtX3NtbXVfcXVldWUgKnEsIHU2
NCAqZW50KQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgICsjZGVmaW5lIGFy
bV9zbW11X2NtZHFfY29weV9jbWQoZHN0LCBzcmMpwqDCoMKgIFwKPj4gK8KgwqDCoCBkbyB7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArwqDCoMKgwqDCoMKgwqAg
ZHN0WzBdID0gc3JjWzBdO8KgwqDCoMKgwqDCoMKgIFwKPj4gK8KgwqDCoMKgwqDCoMKgIGRzdFsx
XSA9IHNyY1sxXTvCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqAgfSB3aGlsZSAoMCkKPj4gKwo+
PiDCoCAvKiBIaWdoLWxldmVsIHF1ZXVlIGFjY2Vzc29ycyAqLwo+PiAtc3RhdGljIGludCBhcm1f
c21tdV9jbWRxX2J1aWxkX2NtZCh1NjQgKmNtZCwgc3RydWN0IGFybV9zbW11X2NtZHFfZW50ICpl
bnQpCj4+ICtzdGF0aWMgaW50IGFybV9zbW11X2NtZHFfYnVpbGRfY21kKHU2NCAqb3V0X2NtZCwg
c3RydWN0IGFybV9zbW11X2NtZHFfZW50ICplbnQpCj4+IMKgIHsKPj4gLcKgwqDCoCBtZW1zZXQo
Y21kLCAwLCAxIDw8IENNRFFfRU5UX1NaX1NISUZUKTsKPj4gLcKgwqDCoCBjbWRbMF0gfD0gRklF
TERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKPj4gK8KgwqDCoCByZWdpc3RlciB1NjQg
Y21kW0NNRFFfRU5UX0RXT1JEU107Cj4+ICsKPj4gK8KgwqDCoCBjbWRbMF0gPSBGSUVMRF9QUkVQ
KENNRFFfMF9PUCwgZW50LT5vcGNvZGUpOwo+PiArwqDCoMKgIGNtZFsxXSA9IDA7Cj4+IMKgIMKg
wqDCoMKgwqAgc3dpdGNoIChlbnQtPm9wY29kZSkgewo+PiDCoMKgwqDCoMKgIGNhc2UgQ01EUV9P
UF9UTEJJX0VMMl9BTEw6Cj4+IEBAIC0zMDksNiArMzE3LDcgQEAgc3RhdGljIGludCBhcm1fc21t
dV9jbWRxX2J1aWxkX2NtZCh1NjQgKmNtZCwgc3RydWN0IGFybV9zbW11X2NtZHFfZW50ICplbnQp
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBSSV9SRVNQX1NVQ0M6Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtX3NtbXVfY21kcV9jb3B5X2NtZChvdXRfY21kLCBj
bWQpOwo+IAo+IFdoeSBib3RoZXIgd3JpdGluZyBiYWNrIGEgcGFydGlhbCBjb21tYW5kIHdoZW4g
d2UncmUgdGVsbGluZyB0aGUgY2FsbGVyIGl0J3MgaW52YWxpZCBhbnl3YXk/CgpTb21lIGNhbGxl
cnMgZG8gbm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgYXJtX3NtbXVfY21kcV9idWlsZF9j
bWQoKS4KSW4gcGFydGljdWxhciwgdGhlIGFybV9zbW11X2NtZHFfYmF0Y2hfYWRkIGhhcyBubyBq
dWRnbWVudC4gWWVzLCBJIHNob3VsZAphZGQganVkZ21lbnQgdGhlcmUuCgo+IAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNtZFsxXSB8PSBGSUVMRF9QUkVQKENNRFFfUFJJXzFf
UkVTUCwgZW50LT5wcmkucmVzcCk7Cj4+IEBAIC0zMjksOSArMzM4LDEyIEBAIHN0YXRpYyBpbnQg
YXJtX3NtbXVfY21kcV9idWlsZF9jbWQodTY0ICpjbWQsIHN0cnVjdCBhcm1fc21tdV9jbWRxX2Vu
dCAqZW50KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY21kWzBdIHw9IEZJRUxEX1BSRVAoQ01EUV9T
WU5DXzBfTVNJQVRUUiwgQVJNX1NNTVVfTUVNQVRUUl9PSVdCKTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4+ICvCoMKgwqDCoMKgwqDCoCBhcm1f
c21tdV9jbWRxX2NvcHlfY21kKG91dF9jbWQsIGNtZCk7Cj4gCj4gRGl0dG8uCj4gCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0VOVDsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKg
wqAgYXJtX3NtbXVfY21kcV9jb3B5X2NtZChvdXRfY21kLCBjbWQpOwo+IAo+IC4uLmFuZCB0aGVu
IGl0IHdvdWxkIGJlIHNpbXBsZXIgdG8gb3Blbi1jb2RlIHRoZSBhc3NpZ25tZW50IGhlcmUuCgpS
aWdodCwgSSdsbCBtb2RpZnkgaXQgaW4gdjIuIEkgYWxzbyBkb24ndCBsaWtlIHRoZSBhZGRpdGlv
biBvZiBhcm1fc21tdV9jbWRxX2NvcHlfY21kKCkuCgo+IAo+IEkgZ3Vlc3MgaWYgeW91J3JlIHJl
YWxseSBjb25jZXJuZWQgd2l0aCBhdm9pZGluZyB0ZW1wb3JhcnkgY29tbWFuZHMgYmVpbmcgd3Jp
dHRlbiBiYWNrIHRvIHRoZSBzdGFjayBhbmQgcmVsb2FkZWQsIGl0IG1pZ2h0IGJlIHdvcnRoIGV4
cGVyaW1lbnRpbmcgd2l0aCB3cmFwcGluZyB0aGVtIGluIGEgc3RydWN0IHdoaWNoIGNhbiBiZSBw
YXNzZWQgYXJvdW5kIGJ5IHZhbHVlIC0gQUFQQ1M2NCBhbGxvd3MgcGFzc2luZyBhIDE2LWJ5dGUg
Y29tcG9zaXRlIHR5cGUgcHVyZWx5IGluIHJlZ2lzdGVycy4KCidvdXRfY21kJyBpcyBhbiBvdXRw
dXQgcGFyYW1ldGVyLiBVc2UgMTYtYnl0ZSBjb21wb3NpdGUgdHlwZSBuZWVkIHRvIG1vZGlmeQpt
YW55IGZ1bmN0aW9ucywgdGhpcyBtYXkgbm90IGJlIGdvb2QuLgoKPiAKPiBSb2Jpbi4KPiAKPj4g
Kwo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgCj4gLgo+IApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
