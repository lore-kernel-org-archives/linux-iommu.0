Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10BBC433EF
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 18:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30018404B4;
	Wed, 24 Nov 2021 18:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VkN_3CxIxCX; Wed, 24 Nov 2021 18:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E76A5400E9;
	Wed, 24 Nov 2021 18:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC922C001E;
	Wed, 24 Nov 2021 18:00:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42BF5C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3172980DDC
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JF5NhTouLQFu for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 18:00:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09A3480DD7
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:00:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B781FB;
 Wed, 24 Nov 2021 10:00:29 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDBA3F66F;
 Wed, 24 Nov 2021 10:00:27 -0800 (PST)
Message-ID: <e95f682b-a9b4-d946-c6fc-e59aba624466@arm.com>
Date: Wed, 24 Nov 2021 18:00:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 9/9] iommu: Move flush queue data into iommu_dma_cookie
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <cover.1637671820.git.robin.murphy@arm.com>
 <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
 <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 willy@infradead.org
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

T24gMjAyMS0xMS0yNCAxNzoyNSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyMy8xMS8yMDIxIDE0
OjEwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IHJ1Y3QgaW9tbXVfZG1hX21zaV9wYWdlIHsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkwqDCoMKgIGxpc3Q7Cj4+IEBAIC00MSw3ICs0Mywx
OSBAQCBzdHJ1Y3QgaW9tbXVfZG1hX2Nvb2tpZSB7Cj4+IMKgwqDCoMKgwqAgZW51bSBpb21tdV9k
bWFfY29va2llX3R5cGXCoMKgwqAgdHlwZTsKPj4gwqDCoMKgwqDCoCB1bmlvbiB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBGdWxsIGFsbG9jYXRvciBmb3IgSU9NTVVfRE1BX0lPVkFfQ09PS0lF
ICovCj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW92YV9kb21haW7CoMKgwqAgaW92YWQ7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgaW92YV9kb21haW7CoMKgwqAgaW92YWQ7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGlvdmFfZnEgX19wZXJjcHUgKmZxO8KgwqDCoCAvKiBGbHVzaCBxdWV1ZSAqLwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBOdW1iZXIgb2YgVExCIGZsdXNoZXMgdGhhdCBo
YXZlIGJlZW4gc3RhcnRlZCAqLwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWM2NF90
wqDCoMKgwqDCoMKgwqAgZnFfZmx1c2hfc3RhcnRfY250Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBOdW1iZXIgb2YgVExCIGZsdXNoZXMgdGhhdCBoYXZlIGJlZW4gZmluaXNoZWQgKi8K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljNjRfdMKgwqDCoMKgwqDCoMKgIGZxX2Zs
dXNoX2ZpbmlzaF9jbnQ7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFRpbWVyIHRvIHJl
Z3VsYXJpbHkgZW1wdHkgdGhlIGZsdXNoIHF1ZXVlcyAqLwo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgdGltZXJfbGlzdMKgwqDCoCBmcV90aW1lcjsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogMSB3aGVuIHRpbWVyIGlzIGFjdGl2ZSwgMCB3aGVuIG5vdCAqLwo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfdMKgwqDCoMKgwqDCoMKgIGZxX3RpbWVyX29uOwo+
IAo+IEkgdGhvdWdodCB0aGF0IHB1dHRpbmcgYWxsIHRoZSBGUSBzdHVmZiBpbiBpdHMgb3duIHN0
cnVjdHVyZSB3b3VsZCBiZSAKPiBuZWF0ZXIsIGJ1dCB0aGF0J3MganVzdCBwZXJzb25hbCBwcmVm
ZXJlbmNlLgoKQnV0IGxvb2ssIGl0IGlzISA7KQoKVGhlIGlvdmFfZG9tYWluIGlzIHN0aWxsIGEg
ZnVuZGFtZW50YWwgcGFydCBvZiB0aGUgZmx1c2ggcXVldWUgYnVpbHQgCmFyb3VuZCBpdDsgdGhl
IHJlc3Qgb2YgdGhlIG1hY2hpbmVyeSBjYW4ndCBzdGFuZCBpbiBpc29sYXRpb24uIEl0J3MganVz
dCAKYW4gYW5vbnltb3VzIHN0cnVjdHVyZSBiZWNhdXNlIEkgZG9uJ3QgZmVlbCBsaWtlIG5lZWRs
ZXNzbHkgY2x1dHRlcmluZyAKdXAgdGhlIGNvZGUgd2l0aCAiY29va2llLT5mcS5mcSIgc2lsbGlu
ZXNzLgoKQ2hlZXJzLApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
