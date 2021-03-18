Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367BAC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:53:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DE764F10
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DE764F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B6004E22C;
	Thu, 18 Mar 2021 19:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHYuA73G2wk1; Thu, 18 Mar 2021 19:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 394524DDE7;
	Thu, 18 Mar 2021 19:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F39DC000B;
	Thu, 18 Mar 2021 19:53:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58FB4C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54863842C4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ks486EjivL6L for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 19:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69482842C3
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:53:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D4031B;
 Thu, 18 Mar 2021 12:53:46 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005C33F792;
 Thu, 18 Mar 2021 12:53:43 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
Date: Thu, 18 Mar 2021 19:53:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
Content-Language: en-GB
Cc: opendmb@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mike Kravetz <mike.kravetz@oracle.com>
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

T24gMjAyMS0wMy0xOCAxOTo0MywgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPiAKPiAKPiBPbiAz
LzE4LzIwMjEgMTI6MzQgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMS0wMy0xOCAx
OToyMiwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMy8xOC8yMDIxIDEy
OjE4IFBNLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+Pj4+IEl0IG1heSBiZSB1c2VmdWwgdG8g
ZGlzYWJsZSB0aGUgU1dJT1RMQiBjb21wbGV0ZWx5IGZvciB0ZXN0aW5nIG9yIHdoZW4gYQo+Pj4+
IHBsYXRmb3JtIGlzIGtub3duIG5vdCB0byBoYXZlIGFueSBEUkFNIGFkZHJlc3NpbmcgbGltaXRh
dGlvbnMgd2hhdCBzbwo+Pj4+IGV2ZXIuCj4+Cj4+IElzbid0IHRoYXQgd2hhdCAic3dpb3RsYj1u
b2ZvcmNlIiBpcyBmb3I/IElmIHlvdSdyZSBjb25maWRlbnQgdGhhdCB3ZSd2ZQo+PiByZWFsbHkg
aXJvbmVkIG91dCAqYWxsKiB0aGUgYXdrd2FyZCBjb3JuZXJzIHRoYXQgdXNlZCB0byBibG93IHVw
IGlmCj4+IHZhcmlvdXMgaW50ZXJuYWwgYml0cyB3ZXJlIGxlZnQgdW5pbml0aWFsaXNlZCwgdGhl
biBpdCB3b3VsZCBtYWtlIHNlbnNlCj4+IHRvIGp1c3QgdHdlYWsgdGhlIGltcGxlbWVudGF0aW9u
IG9mIHdoYXQgd2UgYWxyZWFkeSBoYXZlLgo+IAo+IHN3aW90bGI9bm9mb3JjZSBkb2VzIHByZXZl
bnQgZG1hX2RpcmVjdF9tYXBfcGFnZSgpIGZyb20gcmVzb3J0aW5nIHRvIHRoZQo+IHN3aW90bGIs
IGhvd2V2ZXIgd2hhdCBJIGFtIGFsc28gYWZ0ZXIgaXMgcmVjbGFpbWluZyB0aGVzZSA2NE1CIG9m
Cj4gZGVmYXVsdCBTV0lPVExCIGJvdW5jZSBidWZmZXJpbmcgbWVtb3J5IGJlY2F1c2UgbXkgc3lz
dGVtcyBydW4gd2l0aAo+IGxhcmdlIGFtb3VudHMgb2YgcmVzZXJ2ZWQgbWVtb3J5IGludG8gWk9O
RV9NT1ZBQkxFIGFuZCBldmVyeXRoaW5nIGluCj4gWk9ORV9OT1JNQUwgaXMgcHJlY2lvdXMgYXQg
dGhhdCBwb2ludC4KCkl0IGFsc28gZm9yY2VzIGlvX3RsYl9uc2xhYnMgdG8gdGhlIG1pbmltdW0s
IHNvIGl0IHNob3VsZCBiZSBjbGFpbWluZyAKY29uc2lkZXJhYmx5IGxlc3MgdGhhbiA2NE1CLiBJ
SVJDIHRoZSBvcmlnaW5hbCBwcm9wb3NhbCAqZGlkKiBza2lwIAppbml0aWFsaXNhdGlvbiBjb21w
bGV0ZWx5LCBidXQgdGhhdCB0dXJuZWQgdXAgdGhlIGFmb3JlbWVudGlvbmVkIGlzc3Vlcy4KCj4+
IEkgd291bGRuJ3QgbmVjZXNzYXJpbHkgZGlzYWdyZWUgd2l0aCBhZGRpbmcgIm9mZiIgYXMgYW4g
YWRkaXRpb25hbCBhbGlhcwo+PiBmb3IgIm5vZm9yY2UiLCB0aG91Z2gsIHNpbmNlIGl0IGRvZXMg
Y29tZSBhY3Jvc3MgYXMgYSBiaXQgd2Fja3kgZm9yCj4+IGdlbmVyYWwgdXNlLgo+Pgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+Pj4K
Pj4+IENocmlzdG9waCwgaW4gYWRkaXRpb24gdG8gdGhpcyBjaGFuZ2UsIGhvdyB3b3VsZCB5b3Ug
ZmVlbCBpZiB3ZQo+Pj4gcXVhbGlmaWVkIHRoZSBzd2lvdGxiX2luaXQoKSBpbiBhcmNoL2FybS9t
bS9pbml0LmMgd2l0aCBhOgo+Pj4KPj4+Cj4+PiBpZiAobWVtYmxvY2tfZW5kX29mX0RSQU0oKSA+
PSBTWl80RykKPj4+ICDCoMKgwqDCoHN3aW90bGJfaW5pdCgxKQo+Pgo+PiBNb2R1bG8gInN3aW90
bGI9Zm9yY2UiLCBvZiBjb3Vyc2UgOykKPiAKPiBJbmRlZWQsIHdlIHdvdWxkIG5lZWQgdG8gaGFu
ZGxlIHRoYXQgY2FzZSBhcyB3ZWxsLiBEb2VzIGl0IHNvdW5kCj4gcmVhc29uYWJsZSB0byBkbyB0
aGF0IHRvIHlvdSBhcyB3ZWxsPwoKSSB3b3VsZG4ndCBsaWtlIGl0IGRvbmUgdG8gbWUgcGVyc29u
YWxseSwgYnV0IGZvciBhcm02NCwgb2JzZXJ2ZSB3aGF0IAptZW1faW5pdCgpIGluIGFyY2gvYXJt
NjQvbW0vaW5pdC5jIGFscmVhZHkgZG9lcy4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
