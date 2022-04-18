Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817C8C433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 18:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C31061124;
	Mon, 18 Apr 2022 18:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R64VNIjYVKBu; Mon, 18 Apr 2022 18:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F07F260FEF;
	Mon, 18 Apr 2022 18:11:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8F9DC0033;
	Mon, 18 Apr 2022 18:11:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD721C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93FBD414C9
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rHCFuGnUrIkU for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 18:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9F6C408D7
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650305484; x=1681841484;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4FtieXzTSKHMKDV88WzqEoh+kHjDQfwJ0Yydw1piwHk=;
 b=X1eskVLyDY6NiXcM38yERkGHT9mxXtBX8sLPWxq4WcePUr+AibLfQCJq
 jUr8nIYpBkp0FgKDVzIBO4g0IJ1TuRuQ+Xq6UttuiWoh5H1611FixgWuU
 0lxLgZIN2Cr5FXBYbVSNAsT5VMkAHPP/smN99K9RbGxH3aZalw/l7sjaf
 cHRngC86Os4SVahRQEtuZhEvrXJ6P6yZXbgGk4a6O2G7T9uLRtcMzUOAU
 JZ9BhcbK9Jt4/f0pbT9AQymIKAzNLZrYDYSCnIN+7VazymVmfOdhKwrgV
 N4903fA6qqeGCIGBGrT0q2WCuaKGCbeiQ17/TlIWo1Wj7h82AQLxpErTf g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250883452"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; d="scan'208";a="250883452"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 11:11:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; d="scan'208";a="646948978"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 11:11:22 -0700
Date: Mon, 18 Apr 2022 11:14:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220418111456.2f1a1285@jacob-builder>
In-Reply-To: <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
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
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
 <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 jean-philippe <jean-philippe@linaro.org>,
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

SGkgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tLAoKT24gU2F0LCAxNiBBcHIgMjAyMiAwOTo0Mzow
NyArMDgwMCwgInpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSIKPHpoYW5nZmVpLmdhb0Bmb3htYWls
LmNvbT4gd3JvdGU6Cgo+IE9uIDIwMjIvNC8xNiDkuIrljYg1OjAwLCBKYWNvYiBQYW4gd3JvdGU6
Cj4gPiBIaSB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20sCj4gPgo+ID4gT24gRnJpLCAxNSBBcHIg
MjAyMiAxOTo1MjowMyArMDgwMCwgInpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSIKPiA+IDx6aGFu
Z2ZlaS5nYW9AZm94bWFpbC5jb20+IHdyb3RlOgo+ID4gIAo+ID4+Pj4+IEEgUEFTSUQgbWlnaHQg
YmUgc3RpbGwgdXNlZCBldmVuIHRob3VnaCBpdCBpcyBmcmVlZCBvbiBtbSBleGl0Lgo+ID4+Pj4+
Cj4gPj4+Pj4gcHJvY2VzcyBBOgo+ID4+Pj4+IAlzdmFfYmluZCgpOwo+ID4+Pj4+IAlpb2FzaWRf
YWxsb2MoKSA9IE47IC8vIEdldCBQQVNJRCBOIGZvciB0aGUgbW0KPiA+Pj4+PiAJZm9yaygpOiAv
LyBzcGF3biBwcm9jZXNzIEIKPiA+Pj4+PiAJZXhpdCgpOwo+ID4+Pj4+IAlpb2FzaWRfZnJlZShO
KTsKPiA+Pj4+Pgo+ID4+Pj4+IHByb2Nlc3MgQjoKPiA+Pj4+PiAJZGV2aWNlIHVzZXMgUEFTSUQg
TiAtPiBmYWlsdXJlCj4gPj4+Pj4gCXN2YV91bmJpbmQoKTsKPiA+Pj4+Pgo+ID4+Pj4+IERhdmUg
SGFuc2VuIHN1Z2dlc3RzIHRvIHRha2UgYSByZWZjb3VudCBvbiB0aGUgbW0gd2hlbmV2ZXIgYmlu
ZGluZwo+ID4+Pj4+IHRoZSBQQVNJRCB0byBhIGRldmljZSBhbmQgZHJvcCB0aGUgcmVmY291bnQg
b24gdW5iaW5kaW5nLiBUaGUgbW0KPiA+Pj4+PiB3b24ndCBiZSBkcm9wcGVkIGlmIHRoZSBQQVNJ
RCBpcyBzdGlsbCBib3VuZCB0byBpdC4KPiA+Pj4+Pgo+ID4+Pj4+IEZpeGVzOiA3MDFmYWM0MDM4
NGYgKCJpb21tdS9zdmE6IEFzc2lnbiBhIFBBU0lEIHRvIG1tIG9uIFBBU0lECj4gPj4+Pj4gYWxs
b2NhdGlvbiBhbmQgZnJlZSBpdCBvbiBtbSBleGl0IikKPiA+Pj4+PiAgCj4gPiBJcyBwcm9jZXNz
IEEncyBtbSBpbnRlbmRlZCB0byBiZSB1c2VkIGJ5IHByb2Nlc3MgQj8gT3IgeW91IHJlYWxseSBz
aG91bGQKPiA+IHVzZSBQQVNJRCBOIG9uIHByb2Nlc3MgQidzIG1tPyBJZiB0aGUgbGF0dGVyLCBp
dCBtYXkgd29yayBmb3IgYSB3aGlsZQo+ID4gdW50aWwgQiBjaGFuZ2VzIG1hcHBpbmcuCj4gPgo+
ID4gSXQgc2VlbXMgeW91IGFyZSBqdXN0IGV4dGVuZGluZyB0aGUgbGlmZSBvZiBhIGRlZnVuY3Qg
bW0/ICAKPiAKPiAgRnJvbSBuZ2lueCBjb2RlLCB0aGUgbWFzdGVyIHByb2Nlc3MgaW5pdCByZXNv
dXJjZXMsIHRoZW4gZm9yayBkYWVtb24gCj4gcHJvY2VzcyB0byB0YWtlIG92ZXIsCj4gdGhlbiBt
YXN0ZXIgcHJvY2VzcyBleGl0IGJ5IGl0c2VsZi4KPiAKPiBzcmMvY29yZS9uZ2lueC5jCj4gbWFp
bgo+IG5neF9zc2xfaW5pdChsb2cpO8KgwqDCoCAtPiBvcGVuc3NsIGVuZ2luZSAtPiBiaW5kX2Zu
IC0+IHN2YV9iaW5kKCkKPiBuZ3hfZGFlbW9uKGN5Y2xlLT5sb2cpCj4gCj4gc3JjL29zL3VuaXgv
bmd4X2RhZW1vbi5jCj4gbmd4X2RhZW1vbihuZ3hfbG9nX3QgKmxvZykKPiB7Cj4gIMKgwqDCoMKg
IGludMKgIGZkOwo+IAo+ICDCoMKgwqDCoCBzd2l0Y2ggKGZvcmsoKSkgewo+ICDCoMKgwqDCoCBj
YXNlIC0xOgo+ICDCoMKgwqDCoMKgwqDCoMKgIG5neF9sb2dfZXJyb3IoTkdYX0xPR19FTUVSRywg
bG9nLCBuZ3hfZXJybm8sICJmb3JrKCkgZmFpbGVkIik7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIE5HWF9FUlJPUjsKPiAKPiAgwqDCoMKgwqAgY2FzZSAwOgo+ICDCoMKgwqDCoMKgwqDCoCAv
LyB0aGUgZm9yayBkYWVtb24gcHJvY2Vzcwo+ICDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IApE
b2VzIHRoaXMgY2hpbGQgcHJvY2VzcyBjYWxsIHN2YV9iaW5kKCkgYWdhaW4gdG8gZ2V0IGFub3Ro
ZXIgUEFTSUQ/IE9yIGl0CndpbGwga2VlcCB1c2luZyB0aGUgcGFyZW50J3MgUEFTSUQgZm9yIERN
QT8KCj4gIMKgwqDCoMKgIGRlZmF1bHQ6Cj4gIMKgwqDCoMKgwqDCoCAvLyBtYXN0ZXIgcHJvY2Vz
cyBkaXJlY3RseSBleGl0LCBhbmQgcmVsZWFzZSBtbSBhcyB3ZWxsIGFzIGlvYXNpZAo+ICDCoMKg
wqDCoMKgwqDCoMKgIGV4aXQoMCk7Cj4gIMKgwqDCoMKgIH0KPiAKPiAgwqDCoMKgwqDCoCAvLyBv
bmx5IGRhZW1vbiBwcm9jZXNzCj4gCj4gVGhhbmtzCj4gCj4gPgo+ID4gVGhhbmtzLAo+ID4KPiA+
IEphY29iICAKPiAKCgpUaGFua3MsCgpKYWNvYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
