Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF5C433EF
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 04:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C778F82C21;
	Tue, 26 Apr 2022 04:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agJFzDkpL3rP; Tue, 26 Apr 2022 04:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9221E828AA;
	Tue, 26 Apr 2022 04:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6458BC0039;
	Tue, 26 Apr 2022 04:35:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15563C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B91C60F40
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8Pv9BW1l0Yu for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D93360E30
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650947745; x=1682483745;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HoSgYXIAQU+NGqckIO+BRiklpNR9Ayr8HUcEmJ0UHcE=;
 b=ZCjW20/+91lruoBrkbbVvNmOv4I2ihYK9cjh9fp1q96LnNAgr26s5Olz
 VTNsuVQZN1LxVNhdXNc3F8GorV3Lr4JmGI42P4utR/ZRof8I+NUqLi3dd
 UVu6csQF+Xn0yxGOP/QbzbGRqokHMe++LDB+bJEJZhv+GaQAmGQyxn3IC
 J3qenFIvMEEZ0PO8g4qNd7nzdCVT2al8/vaQE+FBz1ZbUu/w5J/aM92rS
 M7nMIa4JQQLCUeXgGhKJSEjHIoBzeb2EUmbWy4MudojU8YqM5qOpBGq8h
 +AxW8hil6DWAqdm2setb1r9jLwFkYtefB/fXF0nju9eW/htUCnAee0Sff g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265254109"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="265254109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 21:35:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="595563703"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 21:35:43 -0700
Date: Mon, 25 Apr 2022 21:36:19 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTI6Mjg6MDBQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IEhpLCBKZWFuCj4gCj4gT24gMjAyMi80LzI2IOS4iuWNiDEyOjEzLCBKZWFuLVBoaWxp
cHBlIEJydWNrZXIgd3JvdGU6Cj4gPiBIaSBKYWNvYiwKPiA+IAo+ID4gT24gTW9uLCBBcHIgMjUs
IDIwMjIgYXQgMDg6MzQ6NDRBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+ID4gPiBIaSBKZWFu
LVBoaWxpcHBlLAo+ID4gPiAKPiA+ID4gT24gTW9uLCAyNSBBcHIgMjAyMiAxNToyNjo0MCArMDEw
MCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyCj4gPiA+IDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+
IHdyb3RlOgo+ID4gPiAKPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAwNzoxODozNkFN
IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToKPiA+ID4gPiA+IE9uIDQvMjUvMjIgMDY6NTMsIEpl
YW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToKPiA+ID4gPiA+ID4gT24gU2F0LCBBcHIgMjMsIDIw
MjIgYXQgMDc6MTM6MzlQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tCj4gPiA+ID4g
PiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiA1LjE3Cj4gPiA+ID4gPiA+ID4gPiA+IGZv
cHNfcmVsZWFzZSBpcyBjYWxsZWQgYXV0b21hdGljYWxseSwgYXMgd2VsbCBhcwo+ID4gPiA+ID4g
PiA+ID4gPiBpb21tdV9zdmFfdW5iaW5kX2RldmljZS4gT24gNS4xOC1yYzEuCj4gPiA+ID4gPiA+
ID4gPiA+IGZvcHNfcmVsZWFzZSBpcyBub3QgY2FsbGVkLCBoYXZlIHRvIG1hbnVhbGx5IGNhbGwg
Y2xvc2UoZmQpCj4gPiA+ID4gPiA+ID4gPiBSaWdodCB0aGF0J3Mgd2VpcmQKPiA+ID4gPiA+ID4g
PiBMb29rcyBpdCBpcyBjYXVzZWQgYnkgdGhlIGZpeCBwYXRjaCwgdmlhIG1tZ2V0LCB3aGljaCBt
YXkgYWRkCj4gPiA+ID4gPiA+ID4gcmVmY291bnQgb2YgZmQuCj4gPiA+ID4gPiA+IFllcyBpbmRp
cmVjdGx5IEkgdGhpbms6IHdoZW4gdGhlIHByb2Nlc3MgbW1hcHMgdGhlIHF1ZXVlLAo+ID4gPiA+
ID4gPiBtbWFwX3JlZ2lvbigpIHRha2VzIGEgcmVmZXJlbmNlIHRvIHRoZSB1YWNjZSBmZC4gVGhh
dCByZWZlcmVuY2UgaXMKPiA+ID4gPiA+ID4gcmVsZWFzZWQgZWl0aGVyIGJ5IGV4cGxpY2l0IGNs
b3NlKCkgb3IgbXVubWFwKCksIG9yIGJ5IGV4aXRfbW1hcCgpCj4gPiA+ID4gPiA+ICh3aGljaCBp
cyB0cmlnZ2VyZWQgYnkgbW1wdXQoKSkuIFNpbmNlIHRoZXJlIGlzIGFuIG1tLT5mZCBkZXBlbmRl
bmN5LAo+ID4gPiA+ID4gPiB3ZSBjYW5ub3QgYWRkIGEgZmQtPm1tIGRlcGVuZGVuY3ksIHNvIG5v
IG1tZ2V0KCkvbW1wdXQoKSBpbgo+ID4gPiA+ID4gPiBiaW5kKCkvdW5iaW5kKCkuCj4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiBJIGd1ZXNzIHdlIHNob3VsZCBnbyBiYWNrIHRvIHJlZmNvdW50ZWQg
UEFTSURzIGluc3RlYWQsIHRvIGF2b2lkCj4gPiA+ID4gPiA+IGZyZWVpbmcgdGhlbSB1bnRpbCB1
bmJpbmQoKS4KPiA+ID4gPiA+IFllYWgsIHRoaXMgaXMgYSBiaXQgZ25hcmx5IGZvciAtcmM0LiAg
TGV0J3MganVzdCBtYWtlIHN1cmUgdGhlcmUncwo+ID4gPiA+ID4gbm90aGluZyBlbHNlIHNpbXBs
ZSB3ZSBjYW4gZG8uCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEhvdyBkb2VzIHRoZSBJT01NVSBoYXJk
d2FyZSBrbm93IHRoYXQgYWxsIGFjdGl2aXR5IHRvIGEgZ2l2ZW4gUEFTSUQgaXMKPiA+ID4gPiA+
IGZpbmlzaGVkPyAgVGhhdCBhY3Rpdml0eSBzaG91bGQsIHRvZGF5LCBiZSBpbmRlcGVuZGVudCBv
ZiBhbiBtbSBvciBhCj4gPiA+ID4gPiBmZCdzIGxpZmV0aW1lLgo+ID4gPiA+IEluIHRoZSBjYXNl
IG9mIHVhY2NlLCBpdCdzIHRpZWQgdG8gdGhlIGZkIGxpZmV0aW1lOiBvcGVuaW5nIGFuIGFjY2Vs
ZXJhdG9yCj4gPiA+ID4gcXVldWUgY2FsbHMgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKCksIHdoaWNo
IHNldHMgdXAgdGhlIFBBU0lEIGNvbnRleHQgaW4KPiA+ID4gPiB0aGUgSU9NTVUuIENsb3Npbmcg
dGhlIHF1ZXVlIGNhbGxzIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlKCkgd2hpY2gKPiA+ID4gPiBk
ZXN0cm95cyB0aGUgUEFTSUQgY29udGV4dCAoYWZ0ZXIgdGhlIGRldmljZSBkcml2ZXIgc3RvcHBl
ZCBhbGwgRE1BIGZvcgo+ID4gPiA+IHRoaXMgUEFTSUQpLgo+ID4gPiA+IAo+ID4gPiBGb3IgVlQt
ZCwgaXQgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgZmxvdyBleGNlcHQgbWFuYWdlZCBieSB0aGUg
aW5kaXZpZHVhbAo+ID4gPiBkcml2ZXJzIHN1Y2ggYXMgRFNBLgo+ID4gPiBJZiBmcmVlKCkgaGFw
cGVucyBiZWZvcmUgdW5iaW5kKCksIHdlIGRlYWN0aXZhdGUgdGhlIFBBU0lEcyBhbmQgc3VwcHJl
c3MKPiA+ID4gZmF1bHRzIGZyb20gdGhlIGRldmljZS4gV2hlbiB0aGUgdW5iaW5kIGZpbmFsbHkg
Y29tZXMsIHdlIGZpbmFsaXplIHRoZQo+ID4gPiBQQVNJRCB0ZWFyZG93bi4gSXQgc2VlbXMgd2Ug
aGF2ZSBhIG5lZWQgZm9yIGFuIGludGVybWVkaWF0ZSBzdGF0ZSB3aGVyZQo+ID4gPiBQQVNJRCBp
cyAicGVuZGluZyBmcmVlIj8KPiA+IFllcyB3ZSBkbyBoYXZlIHRoYXQgc3RhdGUsIHRob3VnaCBJ
J20gbm90IHN1cmUgd2UgbmVlZCB0byBtYWtlIGl0IGV4cGxpY2l0Cj4gPiBpbiB0aGUgaW9hc2lk
IGFsbG9jYXRvci4KPiA+IAo+ID4gQ291bGQgd2UgbW92ZSBtbV9wYXNpZF9kcm9wKCkgdG8gX19t
bWRyb3AoKSBpbnN0ZWFkIG9mIF9fbW1wdXQoKT8gIEZvciBBcm0KPiA+IHdlIGRvIG5lZWQgdG8g
aG9sZCB0aGUgbW1fY291bnQgdW50aWwgdW5iaW5kKCksIGFuZCBtbWdyYWIoKS9tbWRyb3AoKSBp
cwo+ID4gYWxzbyBwYXJ0IG9mIEx1J3MgcmV3b3JrIFsxXS4KPiAKPiBNb3ZlIG1tX3Bhc2lkX2Ry
b3AgdG8gX19tbWRyb3AgbG9va3Mgd29ya2FibGUuCj4gCj4gVGhlIG5naW54IHdvcmtzIHNpbmNl
IGlvYXNpZCBpcyBub3QgZnJlZWQgd2hlbiBtYXN0ZXIgZXhpdCB1bnRpbCBuZ2lueCBzdG9wLgo+
IAo+IFRoZSBpb2FzaWQgZG9lcyBub3QgZnJlZSBpbW1lZGlhdGVseSB3aGVuIGZvcHNfcmVsZWFz
ZS0+dW5iaW5kIGZpbmlzaGVkLgo+IEluc3RlYWQsIF9fbW1kcm9wIGhhcHBlbnMgYSBiaXQgbGF6
eSzCoCB3aGljaCBoYXMgbm8gaXNzdWUgdGhvdWdoCj4gSSBwYXNzZWQgMTAwMDAgdGltZXMgZXhp
dCB3aXRob3V0IHVuYmluZCB0ZXN0LCB0aGUgcGFzaWQgYWxsb2NhdGlvbiBpcyBvay4KPiAKPiBU
aGFua3MKPiAKPiAKPiBkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMK
PiBpbmRleCA5Nzk2ODk3NTYwYWIuLjYwZjQxN2Y2OTM2NyAxMDA2NDQKPiAtLS0gYS9rZXJuZWwv
Zm9yay5jCj4gKysrIGIva2VybmVsL2ZvcmsuYwo+IEBAIC03OTIsNiArNzkyLDggQEAgdm9pZCBf
X21tZHJvcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkKPiDCoMKgwqDCoMKgwqDCoCBtbXVfbm90aWZp
ZXJfc3Vic2NyaXB0aW9uc19kZXN0cm95KG1tKTsKPiDCoMKgwqDCoMKgwqDCoCBjaGVja19tbSht
bSk7Cj4gwqDCoMKgwqDCoMKgwqAgcHV0X3VzZXJfbnMobW0tPnVzZXJfbnMpOwo+ICvCoMKgwqDC
oMKgwqAgbW1fcGFzaWRfZHJvcChtbSk7Cj4gwqDCoMKgwqDCoMKgwqAgZnJlZV9tbShtbSk7Cj4g
wqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTChfX21tZHJvcCk7Cj4gQEAgLTExOTAsNyArMTE5Miw2
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX21tcHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+IMKg
wqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoCBpZiAobW0tPmJpbmZtdCkKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW9kdWxlX3B1dChtbS0+YmluZm10LT5tb2R1bGUpOwo+
IC3CoMKgwqDCoMKgwqAgbW1fcGFzaWRfZHJvcChtbSk7Cj4gwqDCoMKgwqDCoMKgwqAgbW1kcm9w
KG1tKTsKPiDCoH0KClRoYW5rIHlvdSB2ZXJ5IG11Y2gsIFpoYW5nZmVpIQoKSSBqdXN0IG5vdyBz
ZW50IG91dCBhbiBpZGVudGljYWwgcGF0Y2guIEl0IHdvcmtzIG9uIFg4NiBhcyB3ZWxsLgoKU28g
c2VlbXMgdGhlIHBhdGNoIGlzIHRoZSByaWdodCBmaXguCgpFaXRoZXIgeW91IGNhbiBzZW5kIG91
dCB0aGUgcGF0Y2ggb3IgSSBhZGQgeW91ciBTaWduZWQtb2ZmLWJ5PyBFaXRoZXIgd2F5CmlzIE9L
IGZvciBtZS4KClRoYW5rcy4KCi1GZW5naHVhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
