Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAAFC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:20:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA43164EB4
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA43164EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4626586303;
	Tue,  9 Feb 2021 12:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dBmF1b0CAJH6; Tue,  9 Feb 2021 12:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A687986278;
	Tue,  9 Feb 2021 12:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 668FCC0174;
	Tue,  9 Feb 2021 12:20:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC62DC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A0F85862BC
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4d4pOWm-mQuF for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:20:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2169E86278
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:20:30 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZhlD3HWsz7jM7;
 Tue,  9 Feb 2021 20:19:04 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 20:20:18 +0800
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
To: Greg KH <gregkh@linuxfoundation.org>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
 <YCJX6QFQ4hsNRrFj@kroah.com>
 <f73951ba-84be-b7f8-8c79-db84bc9081f3@hisilicon.com>
 <YCJ5k/Bxxkg3BNNj@kroah.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <2237506a-0c98-7ba6-5d5f-b60b637174c5@hisilicon.com>
Date: Tue, 9 Feb 2021 20:20:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YCJ5k/Bxxkg3BNNj@kroah.com>
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 zhangfei.gao@linaro.org, Andrew
 Morton <akpm@linux-foundation.org>, liguozhu@hisilicon.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS8yLzkgMjA6MDEsIEdyZWcgS0ggd3JvdGU6Cj4gT24gVHVlLCBGZWIgMDksIDIwMjEg
YXQgMDc6NTg6MTVQTSArMDgwMCwgWmhvdSBXYW5nIHdyb3RlOgo+PiBPbiAyMDIxLzIvOSAxNzoz
NywgR3JlZyBLSCB3cm90ZToKPj4+IE9uIFR1ZSwgRmViIDA5LCAyMDIxIGF0IDA1OjE3OjQ2UE0g
KzA4MDAsIFpob3UgV2FuZyB3cm90ZToKPj4+PiBPbiAyMDIxLzIvOCA2OjAyLCBBbmR5IEx1dG9t
aXJza2kgd3JvdGU6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+PiBPbiBGZWIgNywgMjAyMSwgYXQgMTI6MzEg
QU0sIFpob3UgV2FuZyA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+IHdyb3RlOgo+Pj4+Pj4KPj4+
Pj4+IO+7v1NWQShzaGFyZSB2aXJ0dWFsIGFkZHJlc3MpIG9mZmVycyBhIHdheSBmb3IgZGV2aWNl
IHRvIHNoYXJlIHByb2Nlc3MgdmlydHVhbAo+Pj4+Pj4gYWRkcmVzcyBzcGFjZSBzYWZlbHksIHdo
aWNoIG1ha2VzIG1vcmUgY29udmVuaWVudCBmb3IgdXNlciBzcGFjZSBkZXZpY2UKPj4+Pj4+IGRy
aXZlciBjb2RpbmcuIEhvd2V2ZXIsIElPIHBhZ2UgZmF1bHRzIG1heSBoYXBwZW4gd2hlbiBkb2lu
ZyBETUEKPj4+Pj4+IG9wZXJhdGlvbnMuIEFzIHRoZSBsYXRlbmN5IG9mIElPIHBhZ2UgZmF1bHQg
aXMgcmVsYXRpdmVseSBiaWcsIERNQQo+Pj4+Pj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBhZmZlY3Rl
ZCBzZXZlcmVseSB3aGVuIHRoZXJlIGFyZSBJTyBwYWdlIGZhdWx0cy4KPj4+Pj4+IEZyb20gYSBs
b25nIHRlcm0gdmlldywgRE1BIHBlcmZvcm1hbmNlIHdpbGwgYmUgbm90IHN0YWJsZS4KPj4+Pj4+
Cj4+Pj4+PiBJbiBoaWdoLXBlcmZvcm1hbmNlIEkvTyBjYXNlcywgYWNjZWxlcmF0b3JzIG1pZ2h0
IHdhbnQgdG8gcGVyZm9ybQo+Pj4+Pj4gSS9PIG9uIGEgbWVtb3J5IHdpdGhvdXQgSU8gcGFnZSBm
YXVsdHMgd2hpY2ggY2FuIHJlc3VsdCBpbiBkcmFtYXRpY2FsbHkKPj4+Pj4+IGluY3JlYXNlZCBs
YXRlbmN5LiBDdXJyZW50IG1lbW9yeSByZWxhdGVkIEFQSXMgY291bGQgbm90IGFjaGlldmUgdGhp
cwo+Pj4+Pj4gcmVxdWlyZW1lbnQsIGUuZy4gbWxvY2sgY2FuIG9ubHkgYXZvaWQgbWVtb3J5IHRv
IHN3YXAgdG8gYmFja3VwIGRldmljZSwKPj4+Pj4+IHBhZ2UgbWlncmF0aW9uIGNhbiBzdGlsbCB0
cmlnZ2VyIElPIHBhZ2UgZmF1bHQuCj4+Pj4+Pgo+Pj4+Pj4gVmFyaW91cyBkcml2ZXJzIHdvcmtp
bmcgdW5kZXIgdHJhZGl0aW9uYWwgbm9uLVNWQSBtb2RlIGFyZSB1c2luZwo+Pj4+Pj4gdGhlaXIg
b3duIHNwZWNpZmljIGlvY3RsIHRvIGRvIHBpbi4gU3VjaCBpb2N0bCBjYW4gYmUgc2VlbiBpbiB2
NGwyLAo+Pj4+Pj4gZ3B1LCBpbmZpbmliYW5kLCBtZWRpYSwgdmZpbywgZXRjLiBEcml2ZXJzIGFy
ZSB1c3VhbGx5IGRvaW5nIGRtYQo+Pj4+Pj4gbWFwcGluZyB3aGlsZSBkb2luZyBwaW4uCj4+Pj4+
Pgo+Pj4+Pj4gQnV0LCBpbiBTVkEgbW9kZSwgcGluIGNvdWxkIGJlIGEgY29tbW9uIG5lZWQgd2hp
Y2ggaXNuJ3QgbmVjZXNzYXJpbHkKPj4+Pj4+IGJvdW5kIHdpdGggYW55IGRyaXZlcnMsIGFuZCBu
ZWl0aGVyIGlzIGRtYSBtYXBwaW5nIG5lZWRlZCBieSBkcml2ZXJzCj4+Pj4+PiBzaW5jZSBkZXZp
Y2VzIGFyZSB1c2luZyB0aGUgdmlydHVhbCBhZGRyZXNzIG9mIENQVS4gVGh1cywgSXQgaXMgYmV0
dGVyCj4+Pj4+PiB0byBpbnRyb2R1Y2UgYSBuZXcgY29tbW9uIHN5c2NhbGwgZm9yIGl0Lgo+Pj4+
Pj4KPj4+Pj4+IFRoaXMgcGF0Y2ggbGV2ZXJhZ2VzIHRoZSBkZXNpZ24gb2YgdXNlcmZhdWx0ZmQg
YW5kIGFkZHMgbWVtcGluZmQgZm9yIHBpbgo+Pj4+Pj4gdG8gYXZvaWQgbWVzc2luZyB1cCBtbV9z
dHJ1Y3QuIEEgZmQgd2lsbCBiZSBnb3QgYnkgbWVtcGluZmQsIHRoZW4gdXNlcgo+Pj4+Pj4gc3Bh
Y2UgY2FuIGRvIHBpbi91bnBpbiBwYWdlcyBieSBpb2N0bHMgb2YgdGhpcyBmZCwgYWxsIHBpbm5l
ZCBwYWdlcyB1bmRlcgo+Pj4+Pj4gb25lIGZpbGUgd2lsbCBiZSB1bnBpbm5lZCBpbiBmaWxlIHJl
bGVhc2UgcHJvY2Vzcy4gTGlrZSBwaW4gcGFnZSBjYXNlcyBpbgo+Pj4+Pj4gb3RoZXIgcGxhY2Vz
LCBjYW5fZG9fbWxvY2sgaXMgdXNlZCB0byBjaGVjayBwZXJtaXNzaW9uIGFuZCBpbnB1dAo+Pj4+
Pj4gcGFyYW1ldGVycy4KPj4+Pj4KPj4+Pj4KPj4+Pj4gQ2FuIHlvdSBkb2N1bWVudCB3aGF0IHRo
ZSBzeXNjYWxsIGRvZXM/Cj4+Pj4KPj4+PiBXaWxsIGFkZCByZWxhdGVkIGRvY3VtZW50IGluIERv
Y3VtZW50YXRpb24vdm0uCj4+Pgo+Pj4gQSBtYW5wYWdlIGlzIGFsd2F5cyBnb29kLCBhbmQgd2ls
bCBiZSByZXF1aXJlZCBldmVudHVhbGx5IDopCj4+Cj4+IG1hbnBhZ2UgaXMgbWFpbnRhaW5lZCBp
biBhbm90aGVyIHJlcG8uIERvIHlvdSBtZWFuIGFkZCBhIG1hbnBhZ2UKPj4gcGF0Y2ggaW4gdGhp
cyBzZXJpZXM/Cj4gCj4gSXQncyBnb29kIHRvIHNob3cgaG93IGl0IHdpbGwgYmUgdXNlZCwgZG9u
J3QgeW91IHRoaW5rPwoKQWdyZWUsIHdpbGwgYWRkIGl0IGluIG5leHQgdmVyc2lvbi4KClRoYW5r
cywKWmhvdQoKPiAKPiB0aGFua3MsCj4gCj4gZ3JlZyBrLWgKPiAKPiAuCj4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
