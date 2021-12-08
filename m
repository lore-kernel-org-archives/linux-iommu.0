Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA1CC433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 18:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E08D141BEE;
	Wed,  8 Dec 2021 18:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQbiIhIdYX3Z; Wed,  8 Dec 2021 18:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D33E7409CD;
	Wed,  8 Dec 2021 18:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD42FC001E;
	Wed,  8 Dec 2021 18:40:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98132C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 795D56066D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2C4FAWho-iwB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 18:40:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4077D60648
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:40:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E1A11FB;
 Wed,  8 Dec 2021 10:40:36 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5483F73D;
 Wed,  8 Dec 2021 10:40:35 -0800 (PST)
Message-ID: <aaa42ce4-7a8a-44a5-2f84-54981bf0b742@arm.com>
Date: Wed, 8 Dec 2021 18:40:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>,
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
 <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
 <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
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

T24gMjAyMS0xMi0wOCAxODoxNywgSm9obiBHYXJyeSB3cm90ZToKPj4+IERpZCB5b3Ugbm90aWNl
IGFueSBwZXJmb3JtYW5jZSBjaGFuZ2Ugd2l0aCB0aGlzIGNoYW5nZT8KPj4KPj4gSGkgSm9objoK
Pj4gwqDCoCBUaGFua3MgZm9yIHRoZSB0aXAuIEkgd3JvdGUgYSB0ZXN0IGNhc2UgdG9kYXksIGFu
ZCBJIGZvdW5kIHRoYXQgdGhlCj4+IHBlcmZvcm1hbmNlIGRpZCBub3QgZ28gdXAgYnV0IGRvd24u
Cj4gCj4gSSB2ZXJ5IHF1aWNrbHkgdGVzdGVkIG9uIGEgRE1BIG1hcHBpbmcgYmVuY2htYXJrIHZl
cnkgc2ltaWxhciB0byB0aGUgCj4ga2VybmVsIERNQSBiZW5jaG1hcmsgbW9kdWxlIC0gSSBnb3Qg
bWl4ZWQgcmVzdWx0cy4gRm9yIGZld2VyIENQVXMgKDw4KSwgCj4gYSBzbWFsbCBpbXByb3ZlbWVu
dCwgbGlrZSAwLjclLiBGb3IgbW9yZSBDUFVzLCBhIGRpcy1pbXByb3ZlbWVudCAtIAo+IHRoYXQn
cyBzdXJwcmlzaW5nLCBJIGRpZCBleHBlY3QganVzdCBubyBjaGFuZ2UgYXMgYW55IGltcHJvdmVt
ZW50IHdvdWxkIAo+IGdldCBkd2FyZmVkIGZyb20gdGhlIHNsb3dlciB1bm1hcCByYXRlcyBmb3Ig
bW9yZSBDUFVzLiBJIGNhbiBjaGVjayB0aGlzCj4gbW9yZSB0b21vcnJvdy4KPiAKPj4gSXQncyBz
byB3ZWlyZC4gU28gSSBkZWNpZGVkIG5vdCB0bwo+PiBjaGFuZ2UgaXQsIGJlY2F1c2UgaXQncyBh
bHNvIHBvb3JseSByZWFkYWJsZS4gU28gSSBwbGFuIHRvIG1ha2Ugb25seQo+PiB0aGUgZm9sbG93
aW5nIG1vZGlmaWNhdGlvbnM6Cj4+IEBAIC0yMzcsNyArMjM3LDcgQEAgc3RhdGljIGludCBxdWV1
ZV9yZW1vdmVfcmF3KHN0cnVjdCBhcm1fc21tdV9xdWV1ZSAKPj4gKnEsIHU2NCAqZW50KQo+PiDC
oCBzdGF0aWMgaW50IGFybV9zbW11X2NtZHFfYnVpbGRfY21kKHU2NCAqY21kLCBzdHJ1Y3QgCj4+
IGFybV9zbW11X2NtZHFfZW50ICplbnQpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBtZW1z
ZXQoY21kLCAwLCAxIDw8IENNRFFfRU5UX1NaX1NISUZUKTsKPj4gLcKgwqDCoMKgwqDCoCBjbWRb
MF0gfD0gRklFTERfUFJFUChDTURRXzBfT1AsIGVudC0+b3Bjb2RlKTsKPj4gK8KgwqDCoMKgwqDC
oCBjbWRbMF0gPSBGSUVMRF9QUkVQKENNRFFfMF9PUCwgZW50LT5vcGNvZGUpOwo+Pgo+PiDCoMKg
wqDCoMKgwqDCoMKgIHN3aXRjaCAoZW50LT5vcGNvZGUpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBj
YXNlIENNRFFfT1BfVExCSV9FTDJfQUxMOgo+Pgo+PiBUaGlzIHByZXZlbnRzIHRoZSBjb21waWxl
ciBmcm9tIGdlbmVyYXRpbmcgdGhlIGZvbGxvd2luZyB0d28gaW5lZmZpY2llbnQKPj4gaW5zdHJ1
Y3Rpb25zOgo+PiDCoMKgwqDCoMKgIDM5NDrCoMKgwqDCoMKgwqAgZjk0MDAwMDLCoMKgwqDCoMKg
wqDCoCBsZHLCoMKgwqDCoCB4MiwgW3gwXcKgwqDCoCAvL3gyID0gY21kWzBdCj4+IMKgwqDCoMKg
wqAgMzk4OsKgwqDCoMKgwqDCoCBhYTAyMDA2MsKgwqDCoMKgwqDCoMKgIG9ycsKgwqDCoMKgIHgy
LCB4MywgeDLCoMKgwqAgLy94MyA9IAo+PiBGSUVMRF9QUkVQKENNRFFfMF9PUCwgZW50LT5vcGNv
ZGUpCj4+Cj4+IE1heWJlIGl0J3Mgbm90IHdvcnRoIGNoYW5naW5nIGJlY2F1c2UgSSd2ZSBvbmx5
IHNlZW4gYSAwLnggbmFub3NlY29uZCAKPj4gcmVkdWN0aW9uCj4+IGluIHBlcmZvcm1hbmNlLiBC
dXQgb25lIHRoaW5nIGlzLCBpdCBvbmx5IGNvbWVzIHdpdGggYmVuZWZpdHMsIG5vIHNpZGUgCj4+
IGVmZmVjdHMuCj4+Cj4gCj4gSSBqdXN0IHRoaW5rIHRoYXQgd2l0aCB0aGUgb3JpZ2luYWwgY29k
ZSB0aGF0IGNtZFtdIGlzIG9uIHRoZSBzdGFjayBhbmQgCj4gY2FjaGVkLCBzbyBpZiB3ZSBoYXZl
IHdyaXRlLWJhY2sgYXR0cmlidXRlICh3aGljaCBJIHRoaW5rIHdlIGRvKSB0aGVuIAo+IHRoZXJl
IHdvdWxkIG5vdCBuZWNlc3NhcmlseSBhIHdyaXRlIHRvIGV4dGVybmFsIG1lbW9yeSBwZXIgd3Jp
dGUgdG8gY21kW10uCj4gCj4gU28sIGFwYXJ0IGZyb20gdGhpcyBhcHByb2FjaCwgSSB0aGluayB0
aGF0IGlmIHdlIGNhbiBqdXN0IHJlZHVjZSB0aGUgCj4gaW5zdHJ1Y3Rpb25zIHRocm91Z2ggb3Ro
ZXIgZWZmaWNpZW5jaWVzIGluIHRoZSBmdW5jdGlvbiB0aGVuIHRoYXQgd291bGQgCj4gYmUgZ29v
ZC4KCk5vdCBzdXJlIGlmIGl0J3Mgc3RpbGwgdHJ1ZSwgYnV0IEZXSVcgbGFzdCB0aW1lIHRoZSBi
ZXN0IHJlc3VsdCBhY3R1YWxseSAKY2FtZSBmcm9tIGRvaW5nIHRoZSByaWRpY3Vsb3VzbHkgY291
bnRlci1pbnR1aXRpdmU6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8xNDFk
ZTNjMzI3OGUyODA3MTJkMTZkOWFjOWFiMzA1YzNiODBhODEwLjE1MzQzNDQxNjcuZ2l0LnJvYmlu
Lm11cnBoeUBhcm0uY29tLwoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
