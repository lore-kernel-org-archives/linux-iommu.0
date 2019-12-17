Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7AAC2D0BF
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B67C24650
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 19:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B67C24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0BAE86529;
	Tue, 17 Dec 2019 19:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7IejNJvoHSn; Tue, 17 Dec 2019 19:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E7C48636D;
	Tue, 17 Dec 2019 19:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25BB1C1D7D;
	Tue, 17 Dec 2019 19:19:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16E46C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 19:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 05B64863E1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 19:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Wm744AQfKca for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 19:19:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 40C208636D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 19:19:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 11:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="212478542"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63])
 ([10.3.52.63])
 by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2019 11:19:28 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To: Barret Rhoden <brho@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
 <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
From: "Chen, Yian" <yian.chen@intel.com>
Message-ID: <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
Date: Tue, 17 Dec 2019 11:19:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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

CgpPbiAxMi8xNi8yMDE5IDExOjM1IEFNLCBCYXJyZXQgUmhvZGVuIHdyb3RlOgo+IE9uIDEyLzE2
LzE5IDI6MDcgUE0sIENoZW4sIFlpYW4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDEyLzExLzIwMTkgMTE6
NDYgQU0sIEJhcnJldCBSaG9kZW4gd3JvdGU6Cj4+PiBSTVJSIGVudHJpZXMgZGVzY3JpYmUgbWVt
b3J5IHJlZ2lvbnMgdGhhdCBhcmUgRE1BIHRhcmdldHMgZm9yIGRldmljZXMKPj4+IG91dHNpZGUg
dGhlIGtlcm5lbCdzIGNvbnRyb2wuCj4+Pgo+Pj4gUk1SUiBlbnRyaWVzIHRoYXQgZmFpbCB0aGUg
c2FuaXR5IGNoZWNrIGFyZSBwb2ludGluZyB0byByZWdpb25zIG9mCj4+PiBtZW1vcnkgdGhhdCB0
aGUgZmlybXdhcmUgZGlkIG5vdCB0ZWxsIHRoZSBrZXJuZWwgYXJlIHJlc2VydmVkIG9yCj4+PiBv
dGhlcndpc2Ugc2hvdWxkIG5vdCBiZSB1c2VkLgo+Pj4KPj4+IEluc3RlYWQgb2YgYWJvcnRpbmcg
RE1BUiBwcm9jZXNzaW5nLCB0aGlzIGNvbW1pdCBza2lwcyB0aGVzZSBSTVJSCj4+PiBlbnRyaWVz
LsKgIFRoZXkgd2lsbCBub3QgYmUgbWFwcGVkIGludG8gdGhlIElPTU1VLCBidXQgdGhlIElPTU1V
IGNhbgo+Pj4gc3RpbGwgYmUgdXRpbGl6ZWQuwqAgSWYgYW55dGhpbmcsIHdoZW4gdGhlIElPTU1V
IGlzIG9uLCB0aG9zZSBkZXZpY2VzCj4+PiB3aWxsIG5vdCBiZSBhYmxlIHRvIGNsb2JiZXIgUkFN
IHRoYXQgdGhlIGtlcm5lbCBoYXMgYWxsb2NhdGVkIGZyb20gCj4+PiB0aG9zZQo+Pj4gcmVnaW9u
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+
Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDIgKy0KPj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lu
dGVsLWlvbW11LmMKPj4+IGluZGV4IGYxNjhjZDhlZTU3MC4uZjdlMDkyNDRjOWU0IDEwMDY0NAo+
Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+PiArKysgYi9kcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMKPj4+IEBAIC00MzE2LDcgKzQzMTYsNyBAQCBpbnQgX19pbml0IGRt
YXJfcGFyc2Vfb25lX3JtcnIoc3RydWN0IAo+Pj4gYWNwaV9kbWFyX2hlYWRlciAqaGVhZGVyLCB2
b2lkICphcmcpCj4+PiDCoMKgwqDCoMKgIHJtcnIgPSAoc3RydWN0IGFjcGlfZG1hcl9yZXNlcnZl
ZF9tZW1vcnkgKiloZWFkZXI7Cj4+PiDCoMKgwqDCoMKgIHJldCA9IGFyY2hfcm1ycl9zYW5pdHlf
Y2hlY2socm1ycik7Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJldDsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgwqDCoMKgwqAg
cm1ycnUgPSBremFsbG9jKHNpemVvZigqcm1ycnUpLCBHRlBfS0VSTkVMKTsKPj4+IMKgwqDCoMKg
wqAgaWYgKCFybXJydSkKPj4gUGFyc2luZyBybXJyIGZ1bmN0aW9uIHNob3VsZCByZXBvcnQgdGhl
IGVycm9yIHRvIGNhbGxlci4gVGhlIGJlaGF2aW9yIAo+PiB0byByZXNwb25zZSB0aGUgZXJyb3Ig
Y2FuIGJlCj4+IGNob3NlwqAgYnkgdGhlIGNhbGxlciBpbiB0aGUgY2FsbGluZyBzdGFjaywgZm9y
IGV4YW1wbGUsIAo+PiBkbWFyX3dhbGtfcmVtYXBwaW5nX2VudHJpZXMoKS4KPj4gQSBjb25jZXJu
IGlzIHRoYXQgaWdub3JpbmcgYSBkZXRlY3RlZCBmaXJtd2FyZSBidWcgbWlnaHQgaGF2ZSBhIAo+
PiBwb3RlbnRpYWwgc2lkZSBpbXBhY3QgdGhvdWdoCj4+IGl0IHNlZW1lZCBzYWZlIGZvciB5b3Vy
IGNhc2UuCj4KPiBUaGF0J3MgYSBsaXR0bGUgZGlmZmljdWx0IGdpdmVuIHRoZSBjdXJyZW50IGNv
ZGUuwqAgT25jZSB3ZSBhcmUgaW4KPiBkbWFyX3dhbGtfcmVtYXBwaW5nX2VudHJpZXMoKSwgdGhl
IHNwZWNpZmljIGZ1bmN0aW9uIChwYXJzZV9vbmVfcm1ycikgCj4gaXMgY2FsbGVkIHZpYSBjYWxs
YmFjazoKPgo+IMKgwqDCoMKgcmV0ID0gY2ItPmNiW2l0ZXItPnR5cGVdKGl0ZXIsIGNiLT5hcmdb
aXRlci0+dHlwZV0pOwo+IMKgwqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Owo+Cj4gSWYgdGhlcmUncyBhbiBlcnJvciBvZiBhbnkgc29ydCwgaXQgYWJvcnRzIHRoZSB3
YWxrLsKgIEhhbmRsaW5nIHRoZSAKPiBzcGVjaWZpYyBlcnJvcnMgaGVyZSBpcyBkaWZmaWN1bHQs
IHNpbmNlIHdlIGRvbid0IGtub3cgd2hhdCB0aGUgZXJyb3JzIAo+IG1lYW4gdG8gdGhlIHNwZWNp
ZmljIGNhbGxiYWNrLsKgIElzIHRoZXJlIHNvbWUgZXJybm8gd2UgY2FuIHVzZSB0aGF0IAo+IG1l
YW5zICJ0aGVyZSB3YXMgYSBwcm9ibGVtLCBidXQgaXQncyBub3Qgc28gYmFkIHRoYXQgeW91IGhh
dmUgdG8gCj4gYWJvcnQsIGJ1dCBJIGZpZ3VyZWQgeW91IG91Z2h0IHRvIGtub3ciP8KgIE5vdCB0
aGF0IEkgdGhpbmsgdGhhdCdzIGEgCj4gZ29vZCBpZGVhLgo+Cj4gVGhlIGtub3dsZWRnZSBvZiB3
aGV0aGVyIG9yIG5vdCBhIHNwZWNpZmljIGVycm9yIGlzIHdvcnRoIGFib3J0aW5nIGFsbCAKPiBE
TUFSIGZ1bmN0aW9uYWxpdHkgaXMgYmVzdCBrbm93biBpbnNpZGUgdGhlIHNwZWNpZmljIGNhbGxi
YWNrLsKgIFRoZSAKPiBvbmx5IGhhbmRsaW5nIHRvIGRvIGlzIHByaW50IGEgd2FybmluZyBhbmQg
ZWl0aGVyIHNraXAgaXQgb3IgYWJvcnQuCj4KPiBJIHRoaW5rIHNraXBwaW5nIHRoZSBlbnRyeSBm
b3IgYSBiYWQgUk1SUiBpcyBiZXR0ZXIgdGhhbiBhYm9ydGluZyAKPiBjb21wbGV0ZWx5LCB0aG91
Z2ggSSB1bmRlcnN0YW5kIGlmIHBlb3BsZSBkb24ndCBsaWtlIHRoYXQuwqAgSXQncyAKPiBkZWJh
dGFibGUuwqAgQnkgYWJvcnRpbmcsIHdlIGxvc2UgdGhlIGFiaWxpdHkgdG8gdXNlIHRoZSBJT01N
VSBhdCBhbGwsIAo+IGJ1dCB3ZSBhcmUgc3RpbGwgaW4gYSBzaXR1YXRpb24gd2hlcmUgdGhlIGRl
dmljZXMgdXNpbmcgdGhlIFJNUlIgCj4gcmVnaW9ucyBtaWdodCBiZSBjbG9iYmVyaW5nIGtlcm5l
bCBtZW1vcnksIHJpZ2h0P8KgIFVzaW5nIHRoZSBJT01NVSAKPiAod2l0aCBubyBtYXBwaW5ncyBm
b3IgdGhlIGJhZCBSTVJScykgd291bGQgc3RvcCB0aG9zZSBkZXZpY2VzIGZyb20gCj4gY2xvYmJl
cmluZyBtZW1vcnkuCj4KPiBSZWdhcmRsZXNzLCBJIGhhdmUgdHdvIG90aGVyIHBhdGNoZXMgaW4g
dGhpcyBzZXJpZXMgdGhhdCBjb3VsZCByZXNvbHZlIAo+IHRoZSBwcm9ibGVtIGZvciBtZSBhbmQg
cHJvYmFibHkgb3RoZXIgcGVvcGxlLsKgIEknZCBqdXN0IGxpa2UgYXQgbGVhc3QgCj4gb25lIG9m
IHRoZSB0aHJlZSBwYXRjaGVzIHRvIGdldCBtZXJnZWQgc28gdGhhdCBteSBtYWNoaW5lIGJvb3Rz
IHdoZW4gCj4gdGhlIG9yaWdpbmFsIGNvbW1pdCBmMDM2YzdmYTBhYjYgKCJpb21tdS92dC1kOiBD
aGVjayBWVC1kIFJNUlIgcmVnaW9uIAo+IGluIEJJT1MgaXMgcmVwb3J0ZWQgYXMgcmVzZXJ2ZWQi
KSBnZXRzIHJlbGVhc2VkLgo+CndoZW4gYSBmaXJtd2FyZSBidWcgYXBwZWFycywgdGhlIHBvdGVu
dGlhbCBwcm9ibGVtIG1heSBiZXlvbmQgdGhlIHNjb3BlIApvZiBpdHMgdmlzaWJsZSBpbXBhY3Rz
IHNvIHRoYXQgaW50cm9kdWNpbmcgYSB3b3JrYXJvdW5kIGluIG9mZmljaWFsIAppbXBsZW1lbnRh
dGlvbiBzaG91bGQgYmUgY29uc2lkZXJlZCB2ZXJ5IGNhcmVmdWxseS4KCklmIHRoZSB3b3JrYXJv
dW5kIGlzIHJlYWxseSBuZWVkZWQgYXQgdGhpcyBwb2ludCwgSSB3b3VsZCByZWNvbW1lbmQgCmFk
ZGluZyBhIFdBUk5fVEFJTlQgd2l0aCBUQUlOVF9GSVJNV0FSRV9XT1JLQVJPVU5ELCB0byB0ZWxs
IHRoZSAKd29ya2Fyb3VuZCBpcyBpbiB0aGUgcGxhY2UuCgpUaGFua3MKWWlhbgoKPiBUaGFua3Ms
Cj4KPiBCYXJyZXQKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
