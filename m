Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B6C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 00:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21B774036A;
	Thu, 28 Apr 2022 00:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9OYDiSmFaDGC; Thu, 28 Apr 2022 00:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB60F403A4;
	Thu, 28 Apr 2022 00:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7444C0039;
	Thu, 28 Apr 2022 00:54:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 804A5C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 00:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5918F418CE
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 00:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsvcQP_Cy3IQ for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 00:54:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 468CC41615
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651107264; x=1682643264;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mF7e3wMds3iUFV1P2ZkCmb7Bzuyagf/LHBu67W4SX68=;
 b=EwT6GWylQmcgvaa/5aTlMm1z5Fub9bAIGyTNcZKZ+Lb+Gxn7fDTgel0W
 0ufxITSPqLT0DOWfIucfvWe8jg0/D42QQOwIRmgpBI7FYnVXGcjURls0c
 hEZpdoEBs0nTN62Aaloj3zfpFBS/S2c4NEfodblGFIMPaLRc2mIbu321t
 TsPZBQlyt+TgIzt2qf2Q9NedZsje1XGicPcQDW/U8hGU+RcivGaVRWa2R
 562BwUzX9G8TSXquK5djYvkufLOyiVoR3KrNSTszqNapI5137haFHwqXJ
 xtDBatLh70J3vW0GlfMkX+sAJqNKqp4tISQVP0eHMikUHUdP0GJBxN+Mw g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="265645141"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; d="scan'208";a="265645141"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 17:54:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; d="scan'208";a="559317565"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 17:54:22 -0700
Date: Wed, 27 Apr 2022 17:54:57 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
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

SGksIERhdmUgYW5kIEplYW4sCgpPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwMTowNDo0NVBNICsw
ODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4gCj4gCj4gT24gMjAyMi80LzI2IOS4i+WNiDEyOjIw
LCBGZW5naHVhIFl1IHdyb3RlOgo+ID4gSGksIEplYW4gYW5kIFpoYW5nZmVpLAo+ID4gCj4gPiBP
biBNb24sIEFwciAyNSwgMjAyMiBhdCAwNToxMzowMlBNICswMTAwLCBKZWFuLVBoaWxpcHBlIEJy
dWNrZXIgd3JvdGU6Cj4gPiA+IENvdWxkIHdlIG1vdmUgbW1fcGFzaWRfZHJvcCgpIHRvIF9fbW1k
cm9wKCkgaW5zdGVhZCBvZiBfX21tcHV0KCk/ICBGb3IgQXJtCj4gPiA+IHdlIGRvIG5lZWQgdG8g
aG9sZCB0aGUgbW1fY291bnQgdW50aWwgdW5iaW5kKCksIGFuZCBtbWdyYWIoKS9tbWRyb3AoKSBp
cwo+ID4gPiBhbHNvIHBhcnQgb2YgTHUncyByZXdvcmsgWzFdLgo+ID4gSXMgdGhpcyBhIHJpZ2h0
IGZpeCBmb3IgdGhlIGlzc3VlPyBDb3VsZCB5b3UgcGxlYXNlIHRlc3QgaXQgb24gQVJNPwo+ID4g
SSBkb24ndCBoYXZlIGFuIEFSTSBtYWNoaW5lLgo+ID4gCj4gPiBUaGFua3MuCj4gPiAKPiA+IC1G
ZW5naHVhCj4gPiAKPiA+ICBGcm9tIDg0YWE2OGY2MTc0NDM5ZDg2M2M0MGNkYzJkYjBlMWI4OWQ2
MjBkZDAgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gPiBGcm9tOiBGZW5naHVhIFl1IDxmZW5n
aHVhLnl1QGludGVsLmNvbT4KPiA+IERhdGU6IEZyaSwgMTUgQXByIDIwMjIgMDA6NTE6MzMgLTA3
MDAKPiA+IFN1YmplY3Q6IFtQQVRDSF0gaW9tbXUvc3ZhOiBGaXggUEFTSUQgdXNlLWFmdGVyLWZy
ZWUgaXNzdWUKPiA+IAo+ID4gQSBQQVNJRCBtaWdodCBiZSBzdGlsbCB1c2VkIG9uIEFSTSBhZnRl
ciBpdCBpcyBmcmVlZCBpbiBfX21tcHV0KCkuCj4gPiAKPiA+IHByb2Nlc3M6Cj4gPiAJb3Blbigp
LT5zdmFfYmluZCgpLT5pb2FzaWRfYWxsb2MoKSA9IE47IC8vIEdldCBQQVNJRCBOIGZvciB0aGUg
bW0KPiA+IAlleGl0KCk7Cj4gPiAJZXhpdF9tbSgpLT5fX21tcHV0KCktPm1tX3Bhc2lkX2Ryb3Ao
KS0+bW0tPnBhc2lkID0gLTE7IC8vIFBBU0lEIC0xCj4gPiAJZXhpdF9maWxlcygpLT5yZWxlYXNl
KGRldiktPnN2YV91bmJpbmQoKS0+dXNlIG1tLT5wYXNpZDsgLy8gRmFpbHVyZQo+ID4gCj4gPiBU
byBhdm9pZCB0aGUgdXNlLWFmdGVyLWZyZWUgaXNzdWUsIGZyZWUgdGhlIFBBU0lEIGFmdGVyIG5v
IGRldmljZSB1c2VzIGl0LAo+ID4gaS5lLiBhZnRlciBhbGwgZGV2aWNlcyBhcmUgdW5ib3VuZCBm
cm9tIHRoZSBtbS4KPiA+IAo+ID4gc3ZhX2JpbmQoKS9zdmFfdW5iaW5kKCkgY2FsbCBtbWdyYWIo
KS9tbWRyb3AoKSB0byB0cmFjayBtbS0+bW1fY291bnQuCj4gPiBfX21tZHJvcCgpIGlzIGNhbGxl
ZCBvbmx5IGFmdGVyIG1tLT5tbV9jb3VudCBpcyB6ZXJvLiBTbyBmcmVlaW5nIHRoZSBQQVNJRAo+
ID4gaW4gX19tbWRyb3AoKSBndWFyYW50ZWVzIHRoZSBQQVNJRCBpcyBzYWZlbHkgZnJlZWQgb25s
eSBhZnRlciBubyBkZXZpY2UKPiA+IGlzIGJvdW5kIHRvIHRoZSBtbS4KPiA+IAo+ID4gRml4ZXM6
IDcwMWZhYzQwMzg0ZiAoImlvbW11L3N2YTogQXNzaWduIGEgUEFTSUQgdG8gbW0gb24gUEFTSUQg
YWxsb2NhdGlvbiBhbmQgZnJlZSBpdCBvbiBtbSBleGl0IikKPiA+IAo+ID4gUmVwb3J0ZWQtYnk6
IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGZveG1haWwuY29tPgo+ID4gU3VnZ2VzdGVkLWJ5
OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPiA+IFN1
Z2dlc3RlZC1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4KPiA+
IFNpZ25lZC1vZmYtYnk6IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwuY29tPgo+IFRoYW5r
cyBmb3IgdGhlIGZpeC4KPiAKPiBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc+Cj4gCj4gCj4gPiAtLS0KPiA+ICAga2VybmVsL2ZvcmsuYyB8IDIgKy0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2ZvcmsuYwo+ID4gaW5kZXggOTc5
Njg5NzU2MGFiLi4zNWEzYmVmZjE0MGIgMTAwNjQ0Cj4gPiAtLS0gYS9rZXJuZWwvZm9yay5jCj4g
PiArKysgYi9rZXJuZWwvZm9yay5jCj4gPiBAQCAtNzkyLDYgKzc5Miw3IEBAIHZvaWQgX19tbWRy
b3Aoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gPiAgIAltbXVfbm90aWZpZXJfc3Vic2NyaXB0aW9u
c19kZXN0cm95KG1tKTsKPiA+ICAgCWNoZWNrX21tKG1tKTsKPiA+ICAgCXB1dF91c2VyX25zKG1t
LT51c2VyX25zKTsKPiA+ICsJbW1fcGFzaWRfZHJvcChtbSk7Cj4gPiAgIAlmcmVlX21tKG1tKTsK
PiA+ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTChfX21tZHJvcCk7Cj4gPiBAQCAtMTE5MCw3
ICsxMTkxLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fbW1wdXQoc3RydWN0IG1tX3N0cnVjdCAq
bW0pCj4gPiAgIAl9Cj4gPiAgIAlpZiAobW0tPmJpbmZtdCkKPiA+ICAgCQltb2R1bGVfcHV0KG1t
LT5iaW5mbXQtPm1vZHVsZSk7Cj4gPiAtCW1tX3Bhc2lkX2Ryb3AobW0pOwo+ID4gICAJbW1kcm9w
KG1tKTsKPiA+ICAgfQo+IAoKSXMgdGhpcyBwYXRjaCBhIGdvb2QgZml4PyBXaWxsIHlvdSBoZWxw
IHB1c2ggdGhlIGZpeCBpbnRvIHVwc3RyZWFtPwoKVGhhbmsgeW91IHZlcnkgbXVjaCEKCi1GZW5n
aHVhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
