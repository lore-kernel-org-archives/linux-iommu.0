Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E36C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 17:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93309817E4;
	Tue, 14 Dec 2021 17:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TATIYt4A0l31; Tue, 14 Dec 2021 17:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C85B817B3;
	Tue, 14 Dec 2021 17:50:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F10EC002F;
	Tue, 14 Dec 2021 17:50:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1156C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81EAF60C0F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWOvMbYJM78L for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 17:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A01F660BC2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:50:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38B1D6E;
 Tue, 14 Dec 2021 09:50:47 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862113F5A1;
 Tue, 14 Dec 2021 09:50:46 -0800 (PST)
Message-ID: <ddbe509c-8e54-e653-040f-e7edc8774060@arm.com>
Date: Tue, 14 Dec 2021 17:50:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 10/11] iommu/iova: Move flush queue code to iommu-dma
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <cover.1639157090.git.robin.murphy@arm.com>
 <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
 <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, willy@infradead.org
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

T24gMjAyMS0xMi0xNCAxNzoxOCwgSm9obiBHYXJyeSB2aWEgaW9tbXUgd3JvdGU6Cj4gT24gMTAv
MTIvMjAyMSAxNzo1NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiArwqDCoMKgIGlvdmFkLT5mcV9k
b21haW4gPSBmcV9kb21haW47Cj4+ICvCoMKgwqAgaW92YWQtPmZxID0gcXVldWU7Cj4+ICsKPj4g
K8KgwqDCoCB0aW1lcl9zZXR1cCgmaW92YWQtPmZxX3RpbWVyLCBmcV9mbHVzaF90aW1lb3V0LCAw
KTsKPj4gK8KgwqDCoCBhdG9taWNfc2V0KCZpb3ZhZC0+ZnFfdGltZXJfb24sIDApOwo+PiArCj4+
ICvCoMKgwqAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gKwo+IAo+IG5pdDogYSBzaW5nbGUgYmxh
bmsgbGluZSBpcyBzdGFuZGFyZCwgSSB0aGluawoKSG1tLCB5b3UncmUgcmlnaHQgLSBJJ3ZlIGdy
b3duIGZvbmQgb2YgbGVhdmluZyBhbiBleHRyYSBsaXR0bGUgYml0IG9mIApicmVhdGhpbmcgc3Bh
Y2UgYmV0d2VlbiBsb2dpY2FsbHktaW5kZXBlbmRlbnQgc2VjdGlvbnMgb2YgY29kZSwgYW5kIGZv
ciAKc29tZSByZWFzb24gSSB0aG91Z2h0IHRoaXMgZmlsZSB3YXMgYWxyZWFkeSBpbiB0aGF0IHN0
eWxlLCBidXQgaW5kZWVkIGl0IAppc24ndC4KCkpvZXJnIC0gbGV0IG1lIGtub3cgaWYgeW91IGZl
ZWwgc3Ryb25nbHkgZW5vdWdoIHRoYXQgeW91J2QgbGlrZSBtZSB0byAKY2hhbmdlIHRoYXQuIEkn
bSBnb2luZyB0byBoYXZlIG9uZSBsYXN0IGdvIGF0IGZpeGluZyB0ZWdyYS1kcm0sIHNvIEknbSAK
aGFwcHkgdG8gc2VuZCBhIHYzIG9mIHRoZSB3aG9sZSBzZXJpZXMgbGF0ZXIgdGhpcyB3ZWVrIGlm
IHRoZXJlIGFyZSBhbnkgCm90aGVyIG1pbm9yIHR3ZWFrcyB0b28uCgpUaGFua3MgZm9yIGFsbCB0
aGUgcmV2aWV3cyEKClJvYmluLgoKPiAKPiBDaGVlcnMKPiAKPj4gwqAgc3RhdGljIGlubGluZSBz
aXplX3QgY29va2llX21zaV9ncmFudWxlKHN0cnVjdCBpb21tdV9kbWFfY29va2llIAo+PiAqY29v
a2llKQo+PiDCoCB7Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
