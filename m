Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3590FC433FE
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 12:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C768761113;
	Fri, 15 Apr 2022 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Hu2CpoFCUuv; Fri, 15 Apr 2022 12:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D48C60A77;
	Fri, 15 Apr 2022 12:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46B8CC002F;
	Fri, 15 Apr 2022 12:37:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01570C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 12:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D363B40533
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 12:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqpmDR_BHytc for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 12:37:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBC65404E0
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650026231; x=1681562231;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=w+XDpmr+jFjSlmGjB+amwAH4Rfhi8cJjFE5vaPuGp/A=;
 b=i0Gf3iVylQ3M2zDQcGuNi+xSa8TfoKC0vfpOeZIcIY2dEgjEb+8fRwfK
 AVKQWj1ox/7LuQ/jnBr82xWMksTegI2V3zkvVcfWZGA4S8UGIaY6OYSAz
 rEdJbU7I9QDKsPI9UdTQkUrdb2Xx0C5g9+M05RzU9BtqghEJACYppTLK5
 D+xRu8gb4M7Rkx8Ic5F1cSHvnabjCqrwyjx4gfV5bgX98aq/gKU4bD0Ru
 XggxiGkvtL3H3uKLvpckYwC6LM1BVLRDhijhwz6j3DclWKXKQkRqDtbC+
 st6aLarwukgy9g4B6iB9ANBpRKx7n+is1XZ3OiuM4onELD2hMDvK99Eeu g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="288211432"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="288211432"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 05:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="508930396"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 05:37:09 -0700
Date: Fri, 15 Apr 2022 05:37:34 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

SGksIFpoYW5nZmVpLAoKT24gRnJpLCBBcHIgMTUsIDIwMjIgYXQgMDc6NTI6MDNQTSArMDgwMCwg
emhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjIvNC8xNSDkuIvl
jYg2OjUwLCBGZW5naHVhIFl1IHdyb3RlOgo+ID4gSGksIFpoYW5nZmVpLAo+ID4gCj4gPiBPbiBG
cmksIEFwciAxNSwgMjAyMiBhdCAwNjoxNDowOVBNICswODAwLCB6aGFuZ2ZlaS5nYW9AZm94bWFp
bC5jb20gd3JvdGU6Cj4gPiBJIGRvd25sb2FkIHRoaXMgcGF0Y2ggZnJvbToKPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvWWxsQURMNnVNb0xsbHpRb0BmeXUxLnNjLmludGVsLmNvbS9y
YXcKPiA+IGdpdCBhbSB0byBlaXRoZXIgdjUuMTgtcmMyIG9yIHRoZSBsYXRlc3QgdXBzdHJlYW0g
d2l0aG91dCBhbnkgaXNzdWUuCj4gSXQgaXMgbXkgY29weSBwYXN0ZSBpc3N1ZS4KPiAKPiBJIGhh
dmUgdGVzdGVkLCBuZ2lueCB3b2tzIHdlbGwuCgpHcmVhdCEKCj4gCj4gT3RoZXIgdGhhbiB0aGUg
Zm9sbG93aW5nIGlzc3VlLAo+IEVhY2ggdGltZSAvc2Jpbi9uZ2lueCB3aWxsIGFsbG9jIGlvYXNp
ZCBidXQgbm90IGZyZWUuCj4gd2hpY2ggSSB0aGluayBpdCBtYXliZSBuZ2lueCBpc3N1ZSBvciB0
aGUgbWlzLXVzYWdlLCB3aWxsIGFzayB0aGVyZS4KCldoaWNoIG5naW54L29wZW5zc2wgZnVuY3Rp
b24gaXMgc3VwcG9zZWQgdG8gY2FsbCBrZXJuZWwgc3ZhX3VuYmluZD8gSSBjb3VsZG4ndApmaW5k
IHRoZSBmdW5jdGlvbiBpbiBuZ2lueCB0cmVlLgoKSWYgbmdpbnggZG9lc24ndCBmcmVlIGlvYXNp
ZCwgaXQgd2lsbCBjYXVzZSBpb2FzaWQgbGVhayBhbmQgbWVtb3J5IGxlYWsuCgo+IAo+IFRlc3Rl
ZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4KClRoYW5rIHlvdSBm
b3IgeW91ciB0ZXN0aW5nIQoKPiAKPiA+IAo+ID4gPiBJdCBzaG91bGQgd29yayBmb3IgYXJtLgo+
ID4gPiAKPiA+ID4gSW4gZmFjdCBJIGhhdmUgYSBzaW1pbGFyIHBhdGNoIGF0IGhhbmQgYnV0IHBl
bmRpbmcgc2luY2UgSSBmb3VuZCBhbiBpc3N1ZS4KPiA+ID4gCj4gPiA+IEkgc3RhcnQgJiBzdG9w
IG5naW54IHZpYSB0aGlzIGNtZC4KPiA+ID4gLy9zdGFydAo+ID4gPiBzdWRvIHNiaW4vbmdpbnjC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIC8vIHRoaXMgYWxsb2MgYW4gaW9hc2lk
PTEKPiA+ID4gLy9zdG9wCj4gPiA+IHN1ZG8gc2Jpbi9uZ2lueCAtcyBxdWl0wqDCoMKgIC8vIHRo
aXMgZG9lcyBub3QgZnJlZSBpb2FzaWQ9MSwgYnV0IHN0aWxsIGFsbG9jCj4gPiA+IGlvYXNpZD0y
Lgo+ID4gPiBTbyBpb2FzaWQgd2lsbCBrZWVwIGFsbG9jYXRlZCBidXQgbm90IGZyZWVkIGlmIGNv
bnRpbnVlIHN0YXJ0L3N0b3AgbmdpbngsCj4gPiA+IHRob3VnaCBub3QgaW1wYWN0IHRoZSBuZ2lu
eCBmdW5jdGlvbi4KPiA+ID4gCj4gPiA+IHN0b3Agbmdpbnggd2l0aCAtcyBxdWl0IHN0aWxsIGNh
bGxzCj4gPiA+IHNyYy9jb3JlL25naW54LmMKPiA+ID4gbWFpbiAtPiBuZ3hfc3NsX2luaXQgLT4g
b3BlbnNzbCBlbmdpbmU6IMKgwqAgYmluZF9mbiAtPiAuLi4gLT4gYWxsb2MgYXNpZAo+ID4gPiBC
dXQgb3BlbnNzbCBlbmdpbmU6IEVOR0lORV9mcmVlIGlzIG5vdCBjYWxsZWQKPiA+ID4gCj4gPiA+
IFN0aWxsIGluIGNoZWNraW5nIG5naW54IGNvZGUuCj4gPiA+IAo+ID4gPiBPciBkbyB5b3UgdGVz
dCB3aXRoIG5naW54Pwo+ID4gT24gbXkgWDg2IG1hY2hpbmUsIG5naW54IGRvZXNuJ3QgdHJpZ2dl
ciB0aGUga2VybmVsIHN2YSBiaW5kaW5nIGZ1bmN0aW9uCj4gPiB0byBhbGxvY2F0ZSBpb2FzaWQu
IEkgdHJpZWQgcHJlLSBuc3RhbGxlZCBuZ2lueC9vcGVuc3NsIGFuZCBhbHNvIHRyaWVkIG15IGJ1
aWx0Cj4gPiBhIGZldyB2ZXJzaW9ucyBvZiBuZ2lueC9vcGVuc3NsLiBuZ2lueCBkb2VzIGNhbGwg
T1BFTlNTTF9pbml0X3NzbCgpIGJ1dAo+ID4gZG9lc24ndCBnbyB0byB0aGUgYmluZGluZyBmdW5j
dGlvbi4gRG9uJ3Qga25vdyBpZiBpdCdzIG15IGNvbmZpZ3VyYXRpb24gaXNzdWUuCj4gPiBNYXli
ZSB5b3UgY2FuIGdpdmUgbWUgc29tZSBhZHZpY2U/Cj4gSSBhbSB1c2luZyBvcGVuc3NsIGVuZ2lu
ZSwgd2hpY2ggdXNlIGNyeXB0byBkcml2ZXIgYW5kIHVzaW5nIHN2YSB2aWEgdWFjY2UuCj4gbmdp
bnggLT4gb3BlbnNzbCAtPiBvcGVuc3NsIGVuZ2luZSAtPiBzdmEgcmVsYXRlZC4KCkknbGwgZG8g
bW9yZSBuZ2lueCBleHBlcmltZW50cy4KCj4gCj4gPiAKPiA+IEkgdGVzdCB0aGUgcGF0Y2ggd2l0
aCBhIGZldyBpbnRlcm5hbCB0ZXN0IHRvb2xzIGFuZCBvYnNlcnZlIG1tZ2V0KCkvbW1wdXQoKQo+
ID4gd29ya3MgZmluZSBpbiB2YXJpb3VzIGNhc2VzLgo+IE9LLCB0aGFua3MKClRoYW5rIHlvdSB2
ZXJ5IG11Y2ghCgotRmVuZ2h1YQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
