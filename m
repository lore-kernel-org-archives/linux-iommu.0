Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E7BC433F5
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 10:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 592B4403CA;
	Fri, 15 Apr 2022 10:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lx5VX_5Fmp8q; Fri, 15 Apr 2022 10:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1290D400AB;
	Fri, 15 Apr 2022 10:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2679C002F;
	Fri, 15 Apr 2022 10:50:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14A68C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F07FB84142
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6XxAnrojFRW for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:50:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D27B84141
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650019846; x=1681555846;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FcSxV9zaoQXd7xmHux0rD+oliTDOyHpL0739/2mzHhw=;
 b=P5HNS1PEbqnueCKBe/5IWPCq/OY6956v4T1gvVGA050FcTLP1uX24qoE
 tY29hj7O805cftAk8w5CfIOGo7iOkJdVWxL36/OARQ4+dKq9EJM9tpLFg
 piXyfXl9JftXrf0Qx0p8/eZA3j7f+u92GQYqYlus2HRGDWR+TQD+L9m/5
 oIwcqELgjQLROeumA39djTG0T4XRvV3kdRVBXwt5BIRhv9pZadouTZHQX
 vpPJG3bz5z+tA2XyDPWTyettaDNqZdqQwyHuueddTrfCvu3VTOySzNy2g
 Caehg8AMeMqs1Ruf7BlAtNSIJ5jB6C6KrpMG9ImCe6s25VlGgKiTXyxQ8 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243068635"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="243068635"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 03:50:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="574306314"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 03:50:44 -0700
Date: Fri, 15 Apr 2022 03:50:36 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
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

SGksIFpoYW5nZmVpLAoKT24gRnJpLCBBcHIgMTUsIDIwMjIgYXQgMDY6MTQ6MDlQTSArMDgwMCwg
emhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjIvNC8xNSDkuIvl
jYg1OjUxLCBGZW5naHVhIFl1IHdyb3RlOgo+ID4gT24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDY6
MDg6MDlQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+ID4gPiBPbiAy
MDIyLzQvMTIg5LiL5Y2IMTE6MzUsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPiA+
ID4gPiBIaSwgRmVuZ2h1YQo+ID4gPiA+IAo+ID4gPiA+IE9uIDIwMjIvNC8xMiDkuIvljYg5OjQx
LCBGZW5naHVhIFl1IHdyb3RlOgo+ID4gIEZyb20gYTY0NDRlMWU1YmQ4MDc2ZjVlNWM1ZTk1MGQz
MTkyZGUzMjdmMGM5YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiA+IEZyb206IEZlbmdodWEg
WXUgPGZlbmdodWEueXVAaW50ZWwuY29tPgo+ID4gRGF0ZTogRnJpLCAxNSBBcHIgMjAyMiAwMDo1
MTozMyAtMDcwMAo+ID4gU3ViamVjdDogW1JGQyBQQVRDSF0gaW9tbXUvc3ZhOiBGaXggUEFTSUQg
dXNlLWFmdGVyLWZyZWUgaXNzdWUKPiA+IAo+ID4gQSBQQVNJRCBtaWdodCBiZSBzdGlsbCB1c2Vk
IGV2ZW4gdGhvdWdoIGl0IGlzIGZyZWVkIG9uIG1tIGV4aXQuCj4gPiAKPiA+IHByb2Nlc3MgQToK
PiA+IAlzdmFfYmluZCgpOwo+ID4gCWlvYXNpZF9hbGxvYygpID0gTjsgLy8gR2V0IFBBU0lEIE4g
Zm9yIHRoZSBtbQo+ID4gCWZvcmsoKTogLy8gc3Bhd24gcHJvY2VzcyBCCj4gPiAJZXhpdCgpOwo+
ID4gCWlvYXNpZF9mcmVlKE4pOwo+ID4gCj4gPiBwcm9jZXNzIEI6Cj4gPiAJZGV2aWNlIHVzZXMg
UEFTSUQgTiAtPiBmYWlsdXJlCj4gPiAJc3ZhX3VuYmluZCgpOwo+ID4gCj4gPiBEYXZlIEhhbnNl
biBzdWdnZXN0cyB0byB0YWtlIGEgcmVmY291bnQgb24gdGhlIG1tIHdoZW5ldmVyIGJpbmRpbmcg
dGhlCj4gPiBQQVNJRCB0byBhIGRldmljZSBhbmQgZHJvcCB0aGUgcmVmY291bnQgb24gdW5iaW5k
aW5nLiBUaGUgbW0gd29uJ3QgYmUKPiA+IGRyb3BwZWQgaWYgdGhlIFBBU0lEIGlzIHN0aWxsIGJv
dW5kIHRvIGl0Lgo+ID4gCj4gPiBGaXhlczogNzAxZmFjNDAzODRmICgiaW9tbXUvc3ZhOiBBc3Np
Z24gYSBQQVNJRCB0byBtbSBvbiBQQVNJRCBhbGxvY2F0aW9uIGFuZCBmcmVlIGl0IG9uIG1tIGV4
aXQiKQo+ID4gCj4gPiBSZXBvcnRlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AZm94
bWFpbC5jb20+Cj4gPiBTdWdnZXN0ZWQtYnk6IERhdmUgSGFuc2VuIiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBp
bnRlbC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMtc3ZhLmMgfCA2ICsrKysrKwo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5j
ICAgICAgICAgICAgICAgICAgICAgICB8IDQgKysrKwo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMtc3ZhLmMKPiA+IGluZGV4IDIyZGRkMDViYmRjZC4uM2ZjYjg0MmEwZGYw
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUt
djMtc3ZhLmMKPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLXN2YS5jCj4gPiBAQCAtNyw2ICs3LDcgQEAKPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21tdV9j
b250ZXh0Lmg+Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KPiA+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQvbW0uaD4KPiA+
ICAgI2luY2x1ZGUgImFybS1zbW11LXYzLmgiCj4gPiAgICNpbmNsdWRlICIuLi8uLi9pb21tdS1z
dmEtbGliLmgiCj4gPiBAQCAtMzYzLDYgKzM2NCw5IEBAIGFybV9zbW11X3N2YV9iaW5kKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IG1tX3N0cnVjdCAqbW0sIHZvaWQgKmRydmRhdGEpCj4gPiAg
IAltdXRleF9sb2NrKCZzdmFfbG9jayk7Cj4gPiAgIAloYW5kbGUgPSBfX2FybV9zbW11X3N2YV9i
aW5kKGRldiwgbW0pOwo+ID4gKwkvKiBUYWtlIGFuIG1tIHJlZmNvdW50IG9uIGEgc3VjY2Vzc2Z1
bCBiaW5kLiAqLwo+ID4gKwlpZiAoIUlTX0VSUihoYW5kbGUpKQo+ID4gKwkJbW1nZXQobW0pOwo+
ID4gICAJbXV0ZXhfdW5sb2NrKCZzdmFfbG9jayk7Cj4gPiAgIAlyZXR1cm4gaGFuZGxlOwo+ID4g
ICB9Cj4gPiBAQCAtMzcyLDYgKzM3Niw4IEBAIHZvaWQgYXJtX3NtbXVfc3ZhX3VuYmluZChzdHJ1
Y3QgaW9tbXVfc3ZhICpoYW5kbGUpCj4gPiAgIAlzdHJ1Y3QgYXJtX3NtbXVfYm9uZCAqYm9uZCA9
IHN2YV90b19ib25kKGhhbmRsZSk7Cj4gPiAgIAltdXRleF9sb2NrKCZzdmFfbG9jayk7Cj4gPiAr
CS8qIERyb3AgYW4gbW0gcmVmY291bnQuICovCj4gPiArCW1tcHV0KGJvbmQtPm1tKTsKPiA+ICAg
CWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmJvbmQtPnJlZnMpKSB7Cj4gPiAgIAkJbGlzdF9k
ZWwoJmJvbmQtPmxpc3QpOwo+ID4gICAJCWFybV9zbW11X21tdV9ub3RpZmllcl9wdXQoYm9uZC0+
c21tdV9tbik7Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMKPiA+IGluZGV4IDIzYTM4NzYzYzFkMS4uMzQ1YTBkNWQ3
OTIyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwo+ID4gQEAgLTQwMyw2ICs0MDMsOCBAQCBzdGF0aWMg
c3RydWN0IGlvbW11X3N2YSAqaW50ZWxfc3ZtX2JpbmRfbW0oc3RydWN0IGludGVsX2lvbW11ICpp
b21tdSwKPiA+ICAgCQlnb3RvIGZyZWVfc2RldjsKPiA+ICAgCWxpc3RfYWRkX3JjdSgmc2Rldi0+
bGlzdCwgJnN2bS0+ZGV2cyk7Cj4gPiArCS8qIFRha2UgYW4gbW0gcmVmY291bnQgb24gYmluZGlu
ZyBtbS4gKi8KPiA+ICsJbW1nZXQobW0pOwo+ID4gICBzdWNjZXNzOgo+ID4gICAJcmV0dXJuICZz
ZGV2LT5zdmE7Cj4gPiBAQCAtNDY1LDYgKzQ2Nyw4IEBAIHN0YXRpYyBpbnQgaW50ZWxfc3ZtX3Vu
YmluZF9tbShzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBwYXNpZCkKPiA+ICAgCQkJCWtmcmVlKHN2
bSk7Cj4gPiAgIAkJCX0KPiA+ICAgCQl9Cj4gPiArCQkvKiBEcm9wIGFuIG1tIHJlZmVyZW5jZSBv
biB1bmJpbmRpbmcgbW0uICovCj4gPiArCQltbXB1dChtbSk7Cj4gPiAgIAl9Cj4gPiAgIG91dDoK
PiA+ICAgCXJldHVybiByZXQ7Cj4gVGhpcyBwYXRjaCBjYW4gbm90IGJlIGFwcGxpZWQgb24gNS4x
OC1yYzIgZm9yIGludGVsIHBhcnQuCgpXaGF0IGVycm9yIGRvIHlvdSBzZWU/IENvdWxkIHlvdSBw
bGVhc2Ugc2VuZCB0byBtZSBlcnJvcnM/CgpJIGRvd25sb2FkIHRoaXMgcGF0Y2ggZnJvbToKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZbGxBREw2dU1vTGxselFvQGZ5dTEuc2MuaW50ZWwu
Y29tL3JhdwpnaXQgYW0gdG8gZWl0aGVyIHY1LjE4LXJjMiBvciB0aGUgbGF0ZXN0IHVwc3RyZWFt
IHdpdGhvdXQgYW55IGlzc3VlLgoKPiBJdCBzaG91bGQgd29yayBmb3IgYXJtLgo+IAo+IEluIGZh
Y3QgSSBoYXZlIGEgc2ltaWxhciBwYXRjaCBhdCBoYW5kIGJ1dCBwZW5kaW5nIHNpbmNlIEkgZm91
bmQgYW4gaXNzdWUuCj4gCj4gSSBzdGFydCAmIHN0b3AgbmdpbnggdmlhIHRoaXMgY21kLgo+IC8v
c3RhcnQKPiBzdWRvIHNiaW4vbmdpbnjCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IC8vIHRoaXMgYWxsb2MgYW4gaW9hc2lkPTEKPiAvL3N0b3AKPiBzdWRvIHNiaW4vbmdpbnggLXMg
cXVpdMKgwqDCoCAvLyB0aGlzIGRvZXMgbm90IGZyZWUgaW9hc2lkPTEsIGJ1dCBzdGlsbCBhbGxv
Ywo+IGlvYXNpZD0yLgo+IFNvIGlvYXNpZCB3aWxsIGtlZXAgYWxsb2NhdGVkIGJ1dCBub3QgZnJl
ZWQgaWYgY29udGludWUgc3RhcnQvc3RvcCBuZ2lueCzCoAo+IHRob3VnaCBub3QgaW1wYWN0IHRo
ZSBuZ2lueCBmdW5jdGlvbi4KPiAKPiBzdG9wIG5naW54IHdpdGggLXMgcXVpdCBzdGlsbCBjYWxs
cwo+IHNyYy9jb3JlL25naW54LmMKPiBtYWluIC0+IG5neF9zc2xfaW5pdCAtPiBvcGVuc3NsIGVu
Z2luZTogwqDCoCBiaW5kX2ZuIC0+IC4uLiAtPiBhbGxvYyBhc2lkCj4gQnV0IG9wZW5zc2wgZW5n
aW5lOiBFTkdJTkVfZnJlZSBpcyBub3QgY2FsbGVkCj4gCj4gU3RpbGwgaW4gY2hlY2tpbmcgbmdp
bnggY29kZS4KPiAKPiBPciBkbyB5b3UgdGVzdCB3aXRoIG5naW54PwoKT24gbXkgWDg2IG1hY2hp
bmUsIG5naW54IGRvZXNuJ3QgdHJpZ2dlciB0aGUga2VybmVsIHN2YSBiaW5kaW5nIGZ1bmN0aW9u
CnRvIGFsbG9jYXRlIGlvYXNpZC4gSSB0cmllZCBwcmUtIG5zdGFsbGVkIG5naW54L29wZW5zc2wg
YW5kIGFsc28gdHJpZWQgbXkgYnVpbHQKYSBmZXcgdmVyc2lvbnMgb2Ygbmdpbngvb3BlbnNzbC4g
bmdpbnggZG9lcyBjYWxsIE9QRU5TU0xfaW5pdF9zc2woKSBidXQKZG9lc24ndCBnbyB0byB0aGUg
YmluZGluZyBmdW5jdGlvbi4gRG9uJ3Qga25vdyBpZiBpdCdzIG15IGNvbmZpZ3VyYXRpb24gaXNz
dWUuCk1heWJlIHlvdSBjYW4gZ2l2ZSBtZSBzb21lIGFkdmljZT8KCkkgdGVzdCB0aGUgcGF0Y2gg
d2l0aCBhIGZldyBpbnRlcm5hbCB0ZXN0IHRvb2xzIGFuZCBvYnNlcnZlIG1tZ2V0KCkvbW1wdXQo
KQp3b3JrcyBmaW5lIGluIHZhcmlvdXMgY2FzZXMuCgpUaGFua3MuCgotRmVuZ2h1YSAKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
