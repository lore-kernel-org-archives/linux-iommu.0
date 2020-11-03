Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A51AC388F7
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:56:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0812321D91
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0812321D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A978E8644F;
	Tue,  3 Nov 2020 17:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vw7nbVC_-wMV; Tue,  3 Nov 2020 17:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A8A486447;
	Tue,  3 Nov 2020 17:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C1C6C088B;
	Tue,  3 Nov 2020 17:56:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2A7C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 50B842038A
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yW+ywF+lxXps for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 17:56:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 00BCE2002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:56:48 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id B50EB525C26A7AD26979;
 Tue,  3 Nov 2020 17:56:45 +0000 (GMT)
Received: from [10.47.5.37] (10.47.5.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 17:56:44 +0000
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot fills
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
Date: Tue, 3 Nov 2020 17:56:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.5.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
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

Pj4gVG8gc3VtbWFyaXplLCB0aGUgaXNzdWUgaXMgdGhhdCBhcyB0aW1lIGdvZXMgYnksIHRoZSBD
UFUgcmNhY2hlIGFuZCBkZXBvdAo+PiByY2FjaGUgY29udGludWUgdG8gZ3Jvdy4gQXMgc3VjaCwg
SU9WQSBSQiB0cmVlIGFjY2VzcyB0aW1lIGFsc28gY29udGludWVzCj4+IHRvIGdyb3cuCj4gCgpI
aSBSb2JpbiwKCj4gSSdtIHN0cnVnZ2xpbmcgdG8gc2VlIGhvdyB0aGlzIGlzIG5vdCBzaW1wbHkg
aW5kaWNhdGl2ZSBvZiBhIGxlYWsKPiBvcmlnaW5hdGluZyBlbHNld2hlcmUuIAoKSXQgc291bmRz
IGxpa2Ugb25lLCBidXQgSSBkb24ndCB0aGluayBpdCBpcy4KCj4gRm9yIHRoZSBudW1iZXIgb2Yg
bWFnYXppbmVzIHRvIGNvbnRpbnVhbGx5IGdyb3csCj4gaXQgbWVhbnMgSU9WQXMgKm9mIGEgcGFy
dGljdWxhciBzaXplKiBhcmUgYmVpbmcgZnJlZWQgZmFzdGVyIHRoYW4gdGhleQo+IGFyZSBiZWlu
ZyBhbGxvY2F0ZWQsIHdoaWxlIHRoZSBvbmx5IHBsYWNlIHRoYXQgb25nb2luZyBhbGxvY2F0aW9u
cwo+IHNob3VsZCBiZSBjb21pbmcgZnJvbSBpcyB0aG9zZSBzYW1lIG1hZ2F6aW5lcyEKCkJ1dCB0
aGF0IGlzIG5vdCB0aGUgbmF0dXJlIG9mIGhvdyB0aGUgSU9WQSBjYWNoaW5nIHdvcmtzLiBUaGUg
Y2FjaGUgc2l6ZSAKaXMgbm90IGRlZmluZWQgYnkgaG93IERNQSBtYXBwaW5ncyB3ZSBtYXkgaGF2
ZSBhdCBhIGdpdmVuIG1vbWVudCBpbiB0aW1lIApvciBtYXhpbXVtIHdoaWNoIHdlIGRpZCBoYXZl
IGF0IGEgcG9pbnQgZWFybGllci4gSXQganVzdCBncm93cyB0byBhIApsaW1pdCB0byB3aGVyZSBh
bGwgQ1BVIGFuZCBnbG9iYWwgZGVwb3QgcmNhY2hlcyBmaWxsLgoKSGVyZSdzIGFuIGFydGlmaWNp
YWwgZXhhbXBsZSBvZiBob3cgdGhlIHJjYWNoZSBjYW4gZ3JvdywgYnV0IEkgaG9wZSBjYW4gCmhl
bHAgaWxsdXN0cmF0ZToKLSBjb25zaWRlciBhIHByb2Nlc3Mgd2hpY2ggd2FudHMgbWFueSBETUEg
bWFwcGluZyBhY3RpdmUgYXQgYSBnaXZlbiAKcG9pbnQgaW4gdGltZQotIGlmIHdlIHRpZSB0byBj
cHUwLCBjcHUwIHJjYWNoZSB3aWxsIGdyb3cgdG8gMTI4ICogMgotIHRoZW4gdGllIHRvIGNwdTEs
IGNwdTEgcmNhY2hlIHdpbGwgZ3JvdyB0byAxMjggKiAyLCBzbyB0b3RhbCBDUFUgCnJjYWNoZSA9
IDIgKiAxMjggKiAyLiBDUFUgcmNhY2hlIGZvciBjcHUwIGlzIG5vdCBmbHVzaGVkIC0gdGhlcmUg
aXMgbm8gCm1haW50ZW5hbmNlIGZvciB0aGlzLgotIHRoZW4gdGllIHRvIGNwdTIsIGNwdTIgcmNh
Y2hlIHdpbGwgZ3JvdyB0byAxMjggKiAyLCBzbyB0b3RhbCBDUFUgCnJjYWNoZSA9IDMgKiAxMjgg
KiAyCi0gdGhlbiBjcHUzLCBjcHU0LCBhbmQgc28gb24uCi0gV2UgY2FuIGRvIHRoaXMgZm9yIGFs
bCBDUFVzIGluIHRoZSBzeXN0ZW0sIHNvIHRvdGFsIENQVSByY2FjaGUgZ3Jvd3MgCmZyb20gemVy
byAtPiAjQ1BVcyAqIDEyOCAqIDIuIFlldCBubyBETUEgbWFwcGluZyBsZWFrcy4KClNvbWV0aGlu
ZyBzaW1pbGFyIGNhbiBoYXBwZW4gaW4gbm9ybWFsIHVzZSwgd2hlcmUgdGhlIHNjaGVkdWxlciAK
cmVsb2NhdGVzIHByb2Nlc3NlcyBhbGwgb3ZlciB0aGUgQ1BVcyBpbiB0aGUgc3lzdGVtIGFzIHRp
bWUgZ29lcyBieSwgCndoaWNoIGNhdXNlcyB0aGUgdG90YWwgcmNhY2hlIHNpemUgdG8gY29udGlu
dWUgdG8gZ3Jvdy4gQW5kIGluIGFkZGl0aW9uIAp0byB0aGlzLCB0aGUgZ2xvYmFsIGRlcG90IGNv
bnRpbnVlcyB0byBncm93IHZlcnkgc2xvd2x5IGFzIHdlbGwuIEJ1dCAKd2hlbiBpdCBkb2VzIGZp
bGwgKHRoZSBnbG9iYWwgZGVwb3QsIHRoYXQgaXMpLCBhbmQgd2Ugc3RhcnQgdG8gZnJlZSAKbWFn
YXppbmVzIHRvIG1ha2Ugc3BhY2Ug4oCTIGFzIGlzIGN1cnJlbnQgcG9saWN5IC0gdGhhdCdzIHZl
cnkgc2xvdyBhbmQgCmNhdXNlcyB0aGUgcGVyZm9ybWFuY2UgZHJvcC4KCj4gCj4gTm93IGluZGVl
ZCB0aGF0IGNvdWxkIGhhcHBlbiBvdmVyIHRoZSBzaG9ydCB0ZXJtIGlmIElPVkFzIGFyZSBhbGxv
Y2F0ZWQKPiBhbmQgZnJlZWQgYWdhaW4gaW4gZ2lhbnQgYmF0Y2hlcyBsYXJnZXIgdGhhbiB0aGUg
dG90YWwgZ2xvYmFsIGNhY2hlCj4gY2FwYWNpdHksIGJ1dCB0aGF0IHdvdWxkIHNob3cgYSBjeWNs
aWMgYmVoYXZpb3VyIC0gd2hlbiBhY3Rpdml0eSBzdGFydHMsCj4gZXZlcnl0aGluZyBpcyBmaXJz
dCBhbGxvY2F0ZWQgc3RyYWlnaHQgZnJvbSB0aGUgdHJlZSwgdGhlbiB3aGVuIGl0IGVuZHMKPiB0
aGUgY2FjaGVzIHdvdWxkIGdldCBvdmVyd2hlbG1lZCBieSB0aGUgbGFyZ2UgYnVyc3Qgb2YgZnJl
ZWluZyBhbmQgc3RhcnQKPiBoYXZpbmcgdG8gcmVsZWFzZSB0aGluZ3MgYmFjayB0byB0aGUgdHJl
ZSwgYnV0IGV2ZW50dWFsbHkgdGhhdCB3b3VsZAo+IHN0b3Agb25jZSBldmVyeXRoaW5nICppcyog
ZnJlZWQsIHRoZW4gd2hlbiBhY3Rpdml0eSBiZWdpbnMgYWdhaW4gdGhlCj4gbmV4dCByb3VuZCBv
ZiBhbGxvY2F0aW5nIHdvdWxkIGluaGVyZW50bHkgY2xlYXIgb3V0IGFsbCB0aGUgY2FjaGVzCj4g
YmVmb3JlIGdvaW5nIGFueXdoZXJlIG5lYXIgdGhlIHRyZWUuIAoKQnV0IHRoZXJlIGlzIG5vIGNs
ZWFyaW5nLiBBIENQVSB3aWxsIGtlZXAgdGhlIElPVkEgY2FjaGVkIGluZGVmaW5pdGVseSwgCmV2
ZW4gd2hlbiB0aGVyZSBpcyBubyBhY3RpdmUgRE1BIG1hcHBpbmcgcHJlc2VudCBhdCBhbGwuCgo+
IFRvIG1lIHRoZSAic3RlYWR5IGRlY2xpbmUiCj4gYmVoYXZpb3VyIHN1Z2dlc3RzIHRoYXQgc29t
ZW9uZSBzb21ld2hlcmUgaXMgbWFraW5nIERNQSB1bm1hcCBjYWxscyB3aXRoCj4gYSBzbWFsbGVy
IHNpemUgdGhhbiB0aGV5IHdlcmUgbWFwcGVkIHdpdGggKHlvdSB0ZW5kIHRvIG5vdGljZSBpdCBx
dWlja2VyCj4gdGhlIG90aGVyIHdheSByb3VuZCBkdWUgdG8gYWxsIHRoZSBkZXZpY2UgZXJyb3Jz
IGFuZCByYW5kb20gbWVtb3J5Cj4gY29ycnVwdGlvbikgLSBpbiBtYW55IGNhc2VzIHRoYXQgd291
bGQgYXBwZWFyIHRvIHdvcmsgb3V0IGZpbmUgZnJvbSB0aGUKPiBkcml2ZXIncyBwb2ludCBvZiB2
aWV3LCBidXQgd291bGQgcHJvdm9rZSBleGFjdGx5IHRoaXMgYmVoYXZpb3VyIGluIHRoZQo+IElP
VkEgYWxsb2NhdG9yLgo+IAoKVGhhbmtzLApKb2huCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
