Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB5C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 09:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C51BE60AE5;
	Fri, 15 Apr 2022 09:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKf9eDGo0B94; Fri, 15 Apr 2022 09:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EC9F605D5;
	Fri, 15 Apr 2022 09:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D01BC0033;
	Fri, 15 Apr 2022 09:50:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C986C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0810341879
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytL6eAWADSyo for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 09:50:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F093841875
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650016242; x=1681552242;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=k0+BB6ioS9sg4ZQkLIJuljI7na5dCngyl54RvX7fbN8=;
 b=hvEqWuLeRQ5mjL3060IaVYT6YPp2x6jdINCBQrCyJQzBFuH0wxOBg3CN
 9hha7IJ49RjtxnQd2AeZhPRUxZF9AnbmtImAOvuzPHQEdEEDqFbTlnMZ9
 m+UjVL63mmdDImm3JgQAIJ1KsrXxPQ8iYgJw745aseoNfXG50/xtSSkJE
 OuJ2pR9MqkABWOMmBALQBH1oXpjHs95E8QHuQy/coL+pcsAppkk0JvUsb
 ram+ASwu9H8GvEZFs37zKDx+lvlMpnC4a/zc3ADdCN0OqFbX/4yzd9nue
 4XQsmHIjqZ5XkSn/SE7dd2uLhyhuJqkKTT57YP+BPTpx6veSuR5ebpasy A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="263307107"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="263307107"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 02:50:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="553089696"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 02:50:41 -0700
Date: Fri, 15 Apr 2022 02:51:08 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
References: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
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

T24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDY6MDg6MDlQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIHdyb3RlOgo+IAo+IE9uIDIwMjIvNC8xMiDkuIvljYgxMTozNSwgemhhbmdmZWku
Z2FvQGZveG1haWwuY29tIHdyb3RlOgo+ID4gSGksIEZlbmdodWEKPiA+IAo+ID4gT24gMjAyMi80
LzEyIOS4i+WNiDk6NDEsIEZlbmdodWEgWXUgd3JvdGU6Cj4gPiA+IEhpLCBaaGFuZ2ZlaSwKPiA+
ID4gCj4gPiA+IE9uIFR1ZSwgQXByIDEyLCAyMDIyIGF0IDAzOjA0OjA5UE0gKzA4MDAsIHpoYW5n
ZmVpLmdhb0Bmb3htYWlsLmNvbQo+ID4gPiB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBPbiAyMDIy
LzQvMTEg5LiL5Y2IMTA6NTIsIERhdmUgSGFuc2VuIHdyb3RlOgo+ID4gPiA+ID4gT24gNC8xMS8y
MiAwNzo0NCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiAy
MDIyLzQvMTEg5LiL5Y2IMTA6MzYsIERhdmUgSGFuc2VuIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9u
IDQvMTEvMjIgMDc6MjAsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPiA+IEFncmVl
IHdpdGggRGF2ZSwgSSB0aGluayB1c2VyIHNwYWNlIHNob3VsZCBub3QgYmUgYnJva2VuLgo+ID4g
Cj4gPiBUaGFua3MKPiAKPiBBbnkgcGxhbiBhYm91dCB0aGlzIHJlZ3Jlc3Npb24/Cj4gQ3VycmVu
dGx5IEkgbmVlZCB0aGlzIHBhdGNoIHRvIHdvcmthcm91bmQgdGhlIGlzc3VlLgo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwo+
IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMKPiBpbmRl
eCAyMmRkZDA1YmJkY2QuLjJkNzRhYzUzZDExYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jCj4gQEAgLTQsNiArNCw3IEBACj4gwqAg
Ki8KPiAKPiDCoCNpbmNsdWRlIDxsaW51eC9tbS5oPgo+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQv
bW0uaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9tbXVfY29udGV4dC5oPgo+IMKgI2luY2x1ZGUgPGxp
bnV4L21tdV9ub3RpZmllci5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiBAQCAtMzYz
LDYgKzM2NCw3IEBAIGFybV9zbW11X3N2YV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IG1tX3N0cnVjdAo+ICptbSwgdm9pZCAqZHJ2ZGF0YSkKPiAKPiDCoMKgwqDCoMKgwqDCoCBtdXRl
eF9sb2NrKCZzdmFfbG9jayk7Cj4gwqDCoMKgwqDCoMKgwqAgaGFuZGxlID0gX19hcm1fc21tdV9z
dmFfYmluZChkZXYsIG1tKTsKPiArwqDCoMKgwqDCoMKgIG1tZ2V0KG1tKTsKPiDCoMKgwqDCoMKg
wqDCoCBtdXRleF91bmxvY2soJnN2YV9sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gaGFu
ZGxlOwo+IMKgfQo+IEBAIC0zNzcsNiArMzc5LDcgQEAgdm9pZCBhcm1fc21tdV9zdmFfdW5iaW5k
KHN0cnVjdCBpb21tdV9zdmEgKmhhbmRsZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYXJtX3NtbXVfbW11X25vdGlmaWVyX3B1dChib25kLT5zbW11X21uKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoYm9uZCk7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+ICvC
oMKgwqDCoMKgwqAgbW1wdXQoYm9uZC0+bW0pOwo+IMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9j
aygmc3ZhX2xvY2spOwo+IMKgfQoKQ291bGQgeW91IHBsZWFzZSByZXZpZXcgYW5kL29yIHRlc3Qg
dGhpcyBwYXRjaD8gSXQncyBzdXBwb3NlZCB0byBmaXgKdGhlIFBBU0lEIGlzc3VlIG9uIGJvdGgg
QVJNIGFuZCBYODYuCgpGcm9tIGE2NDQ0ZTFlNWJkODA3NmY1ZTVjNWU5NTBkMzE5MmRlMzI3ZjBj
OWMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEZlbmdodWEgWXUgPGZlbmdodWEueXVA
aW50ZWwuY29tPgpEYXRlOiBGcmksIDE1IEFwciAyMDIyIDAwOjUxOjMzIC0wNzAwClN1YmplY3Q6
IFtSRkMgUEFUQ0hdIGlvbW11L3N2YTogRml4IFBBU0lEIHVzZS1hZnRlci1mcmVlIGlzc3VlCgpB
IFBBU0lEIG1pZ2h0IGJlIHN0aWxsIHVzZWQgZXZlbiB0aG91Z2ggaXQgaXMgZnJlZWQgb24gbW0g
ZXhpdC4KCnByb2Nlc3MgQToKCXN2YV9iaW5kKCk7Cglpb2FzaWRfYWxsb2MoKSA9IE47IC8vIEdl
dCBQQVNJRCBOIGZvciB0aGUgbW0KCWZvcmsoKTogLy8gc3Bhd24gcHJvY2VzcyBCCglleGl0KCk7
Cglpb2FzaWRfZnJlZShOKTsKCnByb2Nlc3MgQjoKCWRldmljZSB1c2VzIFBBU0lEIE4gLT4gZmFp
bHVyZQoJc3ZhX3VuYmluZCgpOwoKRGF2ZSBIYW5zZW4gc3VnZ2VzdHMgdG8gdGFrZSBhIHJlZmNv
dW50IG9uIHRoZSBtbSB3aGVuZXZlciBiaW5kaW5nIHRoZQpQQVNJRCB0byBhIGRldmljZSBhbmQg
ZHJvcCB0aGUgcmVmY291bnQgb24gdW5iaW5kaW5nLiBUaGUgbW0gd29uJ3QgYmUKZHJvcHBlZCBp
ZiB0aGUgUEFTSUQgaXMgc3RpbGwgYm91bmQgdG8gaXQuCgpGaXhlczogNzAxZmFjNDAzODRmICgi
aW9tbXUvc3ZhOiBBc3NpZ24gYSBQQVNJRCB0byBtbSBvbiBQQVNJRCBhbGxvY2F0aW9uIGFuZCBm
cmVlIGl0IG9uIG1tIGV4aXQiKQoKUmVwb3J0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWku
Z2FvQGZveG1haWwuY29tPgpTdWdnZXN0ZWQtYnk6IERhdmUgSGFuc2VuIiA8ZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGlu
dGVsLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1z
dmEuYyB8IDYgKysrKysrCiBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jICAgICAgICAgICAgICAg
ICAgICAgICB8IDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMg
Yi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYwppbmRleCAy
MmRkZDA1YmJkY2QuLjNmY2I4NDJhMGRmMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hcm0v
YXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMKKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMKQEAgLTcsNiArNyw3IEBACiAjaW5jbHVkZSA8bGlu
dXgvbW11X2NvbnRleHQuaD4KICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQvbW0uaD4KIAogI2luY2x1
ZGUgImFybS1zbW11LXYzLmgiCiAjaW5jbHVkZSAiLi4vLi4vaW9tbXUtc3ZhLWxpYi5oIgpAQCAt
MzYzLDYgKzM2NCw5IEBAIGFybV9zbW11X3N2YV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sIHZvaWQgKmRydmRhdGEpCiAKIAltdXRleF9sb2NrKCZzdmFfbG9j
ayk7CiAJaGFuZGxlID0gX19hcm1fc21tdV9zdmFfYmluZChkZXYsIG1tKTsKKwkvKiBUYWtlIGFu
IG1tIHJlZmNvdW50IG9uIGEgc3VjY2Vzc2Z1bCBiaW5kLiAqLworCWlmICghSVNfRVJSKGhhbmRs
ZSkpCisJCW1tZ2V0KG1tKTsKIAltdXRleF91bmxvY2soJnN2YV9sb2NrKTsKIAlyZXR1cm4gaGFu
ZGxlOwogfQpAQCAtMzcyLDYgKzM3Niw4IEBAIHZvaWQgYXJtX3NtbXVfc3ZhX3VuYmluZChzdHJ1
Y3QgaW9tbXVfc3ZhICpoYW5kbGUpCiAJc3RydWN0IGFybV9zbW11X2JvbmQgKmJvbmQgPSBzdmFf
dG9fYm9uZChoYW5kbGUpOwogCiAJbXV0ZXhfbG9jaygmc3ZhX2xvY2spOworCS8qIERyb3AgYW4g
bW0gcmVmY291bnQuICovCisJbW1wdXQoYm9uZC0+bW0pOwogCWlmIChyZWZjb3VudF9kZWNfYW5k
X3Rlc3QoJmJvbmQtPnJlZnMpKSB7CiAJCWxpc3RfZGVsKCZib25kLT5saXN0KTsKIAkJYXJtX3Nt
bXVfbW11X25vdGlmaWVyX3B1dChib25kLT5zbW11X21uKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvc3ZtLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCmluZGV4IDIzYTM4
NzYzYzFkMS4uMzQ1YTBkNWQ3OTIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2
bS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMKQEAgLTQwMyw2ICs0MDMsOCBAQCBz
dGF0aWMgc3RydWN0IGlvbW11X3N2YSAqaW50ZWxfc3ZtX2JpbmRfbW0oc3RydWN0IGludGVsX2lv
bW11ICppb21tdSwKIAkJZ290byBmcmVlX3NkZXY7CiAKIAlsaXN0X2FkZF9yY3UoJnNkZXYtPmxp
c3QsICZzdm0tPmRldnMpOworCS8qIFRha2UgYW4gbW0gcmVmY291bnQgb24gYmluZGluZyBtbS4g
Ki8KKwltbWdldChtbSk7CiBzdWNjZXNzOgogCXJldHVybiAmc2Rldi0+c3ZhOwogCkBAIC00NjUs
NiArNDY3LDggQEAgc3RhdGljIGludCBpbnRlbF9zdm1fdW5iaW5kX21tKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdTMyIHBhc2lkKQogCQkJCWtmcmVlKHN2bSk7CiAJCQl9CiAJCX0KKwkJLyogRHJvcCBh
biBtbSByZWZlcmVuY2Ugb24gdW5iaW5kaW5nIG1tLiAqLworCQltbXB1dChtbSk7CiAJfQogb3V0
OgogCXJldHVybiByZXQ7Ci0tIAoyLjMyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
