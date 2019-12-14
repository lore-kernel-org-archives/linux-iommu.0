Return-Path: <SRS0=0Wzb=2E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3998FC43603
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 01:53:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219C1214AF
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 01:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219C1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C210C873B0;
	Sat, 14 Dec 2019 01:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNVstfPFfCXN; Sat, 14 Dec 2019 01:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4497186FE6;
	Sat, 14 Dec 2019 01:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 253B7C1D7C;
	Sat, 14 Dec 2019 01:53:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0FEC0881
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E887E8854F
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id heYAqtUnH2ma for <iommu@lists.linux-foundation.org>;
 Sat, 14 Dec 2019 01:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A3A6888549
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:53:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 17:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; d="scan'208";a="226462850"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 13 Dec 2019 17:53:38 -0800
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To: Barret Rhoden <brho@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Yian Chen <yian.chen@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
 <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <02d69d9a-9c45-d9e7-4c1a-cb5e50590c47@linux.intel.com>
Date: Sat, 14 Dec 2019 09:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
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

Ck9uIDEyLzEzLzE5IDEwOjMxIFBNLCBCYXJyZXQgUmhvZGVuIHdyb3RlOgo+IE9uIDEyLzExLzE5
IDk6NDMgUE0sIEx1IEJhb2x1IHdyb3RlOgo+PiBUaGUgVlQtZCBzcGVjIGRlZmluZXMgdGhlIEJJ
T1MgY29uc2lkZXJhdGlvbnMgYWJvdXQgUk1SUiBpbiBzZWN0aW9uIDguNDoKPj4KPj4gIgo+PiBC
SU9TIG11c3QgcmVwb3J0IHRoZSBSTVJSIHJlcG9ydGVkIG1lbW9yeSBhZGRyZXNzZXMgYXMgcmVz
ZXJ2ZWQgKG9yIGFzCj4+IEVGSSBydW50aW1lKSBpbiB0aGUgc3lzdGVtIG1lbW9yeSBtYXAgcmV0
dXJuZWQgdGhyb3VnaCBtZXRob2RzIHN1Y2ggYXMKPj4gSU5UMTUsIEVGSSBHZXRNZW1vcnlNYXAg
ZXRjLgo+PiAiCj4+Cj4+IFNvIHdlIHNob3VsZCB0cmVhdCBpdCBhcyBmaXJtd2FyZSBidWcgaWYg
dGhlIFJNUlIgcmFuZ2UgaXMgbm90IG1hcHBlZCBhcwo+PiBSRVNFUlZFRCBpbiB0aGUgc3lzdGVt
IG1lbW9yeSBtYXAgdGFibGUuCj4+Cj4+IEFzIGZvciBob3cgc2hvdWxkIHRoZSBkcml2ZXIgaGFu
ZGxlIHRoaXMgY2FzZSwgaWdub3JpbmcgYnVnZ3kgUk1SUiB3aXRoCj4+IGEgd2FybmluZyBtZXNz
YWdlIG1pZ2h0IGJlIGEgcG9zc2libGUgY2hvaWNlLgo+IAo+IEFncmVlZCwgZmlybXdhcmUgc2hv
dWxkIG5vdCBiZSBkb2luZyB0aGlzLsKgIE15IGZpcnN0IHBhdGNoIGp1c3Qgc2tpcHMgCj4gdGhv
c2UgZW50cmllcywgaW5zdGVhZCBvZiBhYm9ydGluZyBETUFSIHByb2Nlc3NpbmcsIGFuZCBrZWVw
cyB0aGUgd2FybmluZy4KPgoKSGkgWWlhbiwKCkRvZXMgdGhpcyB3b3JrIGZvciB5b3U/CgpCZXN0
IHJlZ2FyZHMsCmJhb2x1CgoKPiBTbyBsb25nIGFzIHRoZSBtYWNoaW5lIHN0aWxsIGJvb3RzIGlu
IGEgc2FmZSBtYW5uZXIsIEknbSByZWFzb25hYmx5IGhhcHB5Lgo+IAo+IFRoYW5rcywKPiAKPiBC
YXJyZXQKPiAKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
