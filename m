Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690AC433E6
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5083E23730
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083E23730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 389C68730C;
	Fri, 15 Jan 2021 11:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUzpXG0sxkvq; Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 240C6872EC;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 068C5C0893;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E6E1C088B
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F20520131
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yt2gzPBP7sLm for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 11:26:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 71E7C1FFFF
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:23 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DHJkx1v36zj6ws;
 Fri, 15 Jan 2021 19:25:29 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 15 Jan 2021
 19:26:10 +0800
Subject: Re: Consult on ARM SMMU debugfs
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
References: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
 <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <37db40a7-a244-cf52-a30d-18a7875bc3b8@hisilicon.com>
Date: Fri, 15 Jan 2021 19:26:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

CgrlnKggMjAyMS8xLzEyIDQ6MDEsIFJvYmluIE11cnBoeSDlhpnpgZM6Cj4gT24gMjAyMS0wMS0w
NyAwMjo0NSwgY2hlbnhpYW5nIChNKSB3cm90ZToKPj4gSGkgV2lsbCwgIFJvYmluIG9yIG90aGVy
IGd1eXMsCj4+Cj4+IFdoZW4gZGVidWdnaW5nIFNNTVUvU1ZBIGlzc3VlIG9uIGh1YXdlaSBBUk02
NCBib2FyZCwgd2UgZmluZCB0aGF0IGl0IAo+PiBsYWNrcyBvZiBlbm91Z2ggZGVidWdmcyBmb3Ig
QVJNIFNNTVUgZHJpdmVyIChzdWNoIGFzCj4+Cj4+IHRoZSB2YWx1ZSBvZiBTVEUvQ0Qgd2hpY2gg
d2UgbmVlZCB0byBjaGVjayBzb21ldGltZXMpLiBDdXJyZW50bHkgaXQgCj4+IGNyZWF0ZXMgdG9w
LWxldmVsIGlvbW11IGRpcmVjdG9yeSBpbiBkZWJ1Z2ZzLCBidXQgdGhlcmUgaXMgbm8gZGVidWdm
cwo+Pgo+PiBmb3IgQVJNIFNNTVUgZHJpdmVyIHNwZWNpYWxseS4gRG8geW91IGtub3cgd2hldGhl
ciBBUk0gaGF2ZSB0aGUgcGxhbiAKPj4gdG8gZG8gdGhhdCByZWNlbnRseT8KPgo+IEZXSVcgSSBk
b24ndCB0aGluayBJJ3ZlIGV2ZXIgZmVsdCB0aGUgbmVlZCB0byBuZWVkIHRvIGluc3BlY3QgdGhl
IAo+IFN0cmVhbSBUYWJsZSBvbiBhIGxpdmUgc3lzdGVtLiBTbyBmYXIgdGhlIG5hdHVyZSBvZiB0
aGUgU1RFIGNvZGUgaGFzIAo+IGJlZW4gc2ltcGxlIGVub3VnaCB0aGF0IGl0J3MgdmVyeSBoYXJk
IGZvciBhbnkgZ2l2ZW4gU1RFIHRvIGJlICp3cm9uZyogCj4gLSBlaXRoZXIgaXQncyBzZXQgdXAg
YXMgZXhwZWN0ZWQgYW5kIHRodXMgd29ya3MgZmluZSwgb3IgaXQncyBub3QgCj4gaW5pdGlhbGlz
ZWQgYXQgYWxsIGFuZCB5b3UgZ2V0IENfQkFEX1NURSwgd2hlcmUgOTklIG9mIHRoZSB0aW1lIHlv
dSAKPiB0aGVuIGp1c3QgY3Jvc3MtcmVmZXJlbmNlIHRoZSBTdHJlYW0gSUQgYWdhaW5zdCB0aGUg
ZmlybXdhcmUgYW5kIGZpbmQgCj4gdGhhdCB0aGUgRFQvSU9SVCBpcyB3cm9uZy4KPgo+IFNpbWls
YXJseSBJIGRvbid0IHRoaW5rIEkndmUgZXZlbiBldmVuICpzZWVuKiBhbiBpc3N1ZSB0aGF0IGNv
dWxkIGJlIAo+IGF0dHJpYnV0ZWQgdG8gYSBjb250ZXh0IGRlc2NyaXB0b3IsIGFsdGhvdWdoIEkg
YXBwcmVjaWF0ZSB0aGF0IGFzIHdlIAo+IHN0YXJ0IGxhbmRpbmcgbW9yZSBQQVNJRCBhbmQgU1ZB
IHN1cHBvcnQgdGhlIHNjb3BlIGZvciB0aGF0IHN0YXJ0cyB0byAKPiB3aWRlbiBjb25zaWRlcmFi
bHkuCgpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuICBJIGFnZ3JlZSB0aGF0IGl0IGlzIHZlcnkg
aGFyZCBmb3IgdGhlIGNvbnRlbnQgCm9mIFNURS9DRCB0byBiZSB3cm9uZyBpbiBjdXJyZW50IGNv
ZGUsIGJ1dCAgdGhlcmUgYXJlIG1vcmUgdXBzdGVhbWluZyAKZmVhdHVyZXMoc3VjaCBhcyBTVkEv
dlNNTVUpIHdoaWNoIGFyZSByZWxhdGVkIHRvIFNNTVUsCndoZW4gZGVidWdnaW5nIHdpdGggdGhv
c2UgZmVhdHVyZXMsIGl0IGlzIHVzZWZ1bCBmb3IgdXMgdG8gbG9jYXRlIGlzc3VlcyAKaWYgdGhl
cmUgYXJlIGludGVyZmFjZXMgdG8gZHVtcCB0aG9zZSBpbmZvLiBBbmQgYWxzbyB3aGVuIGRlYnVn
Z2luZyAKdG9nZXRoZXIgd2l0aCBoYXJkd2FyZSBndXlzLCB0aGUgY29udGVudCBvZiBkdW1wIGlz
IGltcG9ydGFudCBmb3IgdGhlbSB0b28uCgo+Cj4gRmVlbCBmcmVlIHRvIHByb3Bvc2UgYSBwYXRj
aCBpZiB5b3UgYmVsaWV2ZSBpdCB3b3VsZCBiZSBnZW51aW5lbHkgCj4gdXNlZnVsIGFuZCB3b24n
dCBqdXN0IGJpdC1yb3QgaW50byBhIG1haW50ZW5hbmNlIGJ1cmRlbiwgYnV0IGl0J3Mgbm90IAo+
IHNvbWV0aGluZyB0aGF0J3Mgb24gb3VyIHJvYWRtYXAgaGVyZS4KCk9LLCB3ZSBhcmUgY29uc2lk
ZXJpbmcgYWJvdXQgaW5jb3Jwb3JhdGluZyBmb2xsb3dpbmcgcmVxdWlyZW1lbnRzIGludG8gCnRo
ZSBwbGFuOgotIER1bXAgdGhlIHZhbHVlIG9mIFNURS9DRCBvZiBkZXZpY2VzCi0gRHVtcCBwYWdl
IHRhYmxlIGVudHJpZXMgb2YgZGV2aWNlcwotIER1bXAgdGhlIGVudHJpZXMgaW5mbyBvZiBDTURR
L0VWRU5UUQoKPgo+IFRoYW5rcywKPiBSb2Jpbi4KPgo+IC4KPgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
