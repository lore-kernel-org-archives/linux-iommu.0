Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A31C32771
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 00:36:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078832073D
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 00:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078832073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB7388760D;
	Tue,  7 Jan 2020 00:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6dkWKyR9pbK; Tue,  7 Jan 2020 00:36:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA2778543B;
	Tue,  7 Jan 2020 00:36:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1C79C1D83;
	Tue,  7 Jan 2020 00:36:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34BC0C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 00:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31204868C9
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 00:36:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gp5h7Ld-Zu4U for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 00:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A9A7868C7
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 00:36:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jan 2020 16:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; d="scan'208";a="245757764"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 16:36:23 -0800
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
To: Jerry Snitselaar <jsnitsel@redhat.com>,
 Roland Dreier <roland@purestorage.com>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
 <CAL1RGDWU=s6nVArvkci1cXyZVw-fvdtcOjuY+9E+rgBi65q=Aw@mail.gmail.com>
 <567f1506-4a13-535b-ce41-aac079941510@linux.intel.com>
 <CAL1RGDVF1icaeEWMe0r0VA8AaxtHGJZ8NHCpvJfT8+1duOUYAQ@mail.gmail.com>
 <20200106170551.ykphn6couhxozrid@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <799d7ab1-c496-e3f8-719e-e52fbabb8d1c@linux.intel.com>
Date: Tue, 7 Jan 2020 08:35:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106170551.ykphn6couhxozrid@cantor>
Content-Language: en-US
Cc: Jim Yan <jimyan@baidu.com>, iommu@lists.linux-foundation.org
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

SGkgSmVycnksCgpPbiAxLzcvMjAgMTowNSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBP
biBXZWQgSmFuIDAxIDIwLCBSb2xhbmQgRHJlaWVyIHZpYSBpb21tdSB3cm90ZToKPj4+IFdlIHNh
dyBtb3JlIGRldmljZXMgd2l0aCB0aGUgc2FtZSBtaXNtYXRjaCBxdWlyay4gU28gbWFpbnRhaW5p
bmcgdGhlbSBpbgo+Pj4gYSBxdWlyayB0YWJsZSB3aWxsIG1ha2UgaXQgbW9yZSByZWFkYWJsZSBh
bmQgbWFpbnRhaW5hYmxlLgo+Pgo+PiBJIGd1ZXNzIEkgZGlzYWdyZWUgYWJvdXQgdGhlIG1haW50
YWluYWJsZSBwYXJ0LCBnaXZlbiB0aGF0IHRoaXMgcGF0Y2gKPj4gYWxyZWFkeSByZWdyZXNzZXMg
QnJvYWR3ZWxsIE5UQi4KPj4KPj4gSSdtIG5vdCBldmVuIHN1cmUgd2hhdCB0aGUgRE1BUiB0YWJs
ZSBzYXlzIGFib3V0IE5UQiBvbiBteSBTa3lsYWtlCj4+IHN5c3RlbXMsIGV4YWN0bHkgYmVjYXVz
ZSB0aGUgZXhpc3RpbmcgY29kZSBtZWFucyBJIGRpZCBub3QgaGF2ZSBhbnkKPj4gcHJvYmxlbXMu
wqAgQnV0IHdlIG1pZ2h0IG5lZWQgdG8gYWRkIGRldmljZSAyMDFDaCB0b28uCj4+Cj4+IE1heWJl
IHdlIGRvbid0IG5lZWQgdGhlIG1pc21hdGNoIGNoZWNrIGF0IGFsbD/CoCBZb3VyIHBhdGNoIHNl
dHMgdGhlCj4+IHF1aXJrIGlmIGFueSBwb3NzaWJseSBtaXNtYXRjaGluZyBkZXZpY2UgaXMgcHJl
c2VudCBpbiB0aGUgc3lzdGVtLCBzbwo+PiB3ZSdsbCBpZ25vcmUgYW55IHNjb3BlIG1pc21hdGNo
IG9uIGEgc3lzdGVtIHdpdGgsIHNheSwgdGhlIDgwODY6MjAyMAo+PiBOVk1lIGhvc3QgaW4gaXQu
wqAgU28gY291bGQgd2UganVzdCBkcm9wIHRoZSBjaGVjayBjb21wbGV0ZWx5IGFuZCBub3QKPj4g
aGF2ZSBhIHF1aXJrIHRvIGRpc2FibGUgdGhlIGNoZWNrPwo+Pgo+PiAtIFIuCj4gCj4gSWYgdGhl
IGNoZWNrIGlzIHJlbW92ZWQgd2hhdCBoYXBwZW5zIGZvciBjYXNlcyB3aGVyZSB0aGVyZSBpcyBh
biBhY3R1YWwKPiBwcm9ibGVtIGluIHRoZSBkbWFyIHRhYmxlPyBJIGp1c3Qgd29ya2VkIGFuIGlz
c3VlIHdpdGggc29tZSBJbnRlbAo+IHBlb3BsZSB3aGVyZSBhIHB1cmxleSBzeXN0ZW0gaGFkIGFu
IHJtcnIgZW50cnkgcG9pbnRpbmcgdG8gYSBicmlkZ2UgYXMKPiB0aGUgZW5kcG9pbnQgZGV2aWNl
IGluc3RlYWQgb2YgdGhlIHJhaWQgbW9kdWxlIHNpdHRpbmcgYmVoaW5kIGl0LgoKVGhlIGxhdGVz
dCBzb2x1dGlvbiB3YXMgaGVyZS4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMS81LzEwMywg
ZG9lcwp0aGlzIHdvcmsgZm9yIHlvdT8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
