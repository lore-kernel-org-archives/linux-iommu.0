Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D9C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 13:05:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0F4206CB
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 13:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0F4206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 861B185D92;
	Mon, 23 Dec 2019 13:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4wvUjQlS7Bb; Mon, 23 Dec 2019 13:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3924285D6C;
	Mon, 23 Dec 2019 13:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A74DC1D80;
	Mon, 23 Dec 2019 13:05:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D746C0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 98DD020495
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynx-Fw1Z+BDu for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 13:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id B5A0B2043C
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:05:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 05:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; d="scan'208";a="223018527"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.45])
 ([10.254.215.45])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 05:05:23 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOiBEb24ndCByZWpl?=
 =?UTF-8?Q?ct_nvme_host_due_to_scope_mismatch?=
To: "Jim,Yan" <jimyan@baidu.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
 <20191220092327.do34gtk3lcafzr6q@cantor>
 <606767b54ad4410abbdd9d053552074a@baidu.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bbff34ed-1c47-3eed-0bc9-30cfdd3ee90d@linux.intel.com>
Date: Mon, 23 Dec 2019 21:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <606767b54ad4410abbdd9d053552074a@baidu.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

SGksCgpPbiAyMDE5LzEyLzIzIDE1OjU5LCBKaW0sWWFuIHdyb3RlOgo+PiAtLS0tLemCruS7tuWO
n+S7ti0tLS0tCj4+IOWPkeS7tuS6ujogSmVycnkgU25pdHNlbGFhciBbbWFpbHRvOmpzbml0c2Vs
QHJlZGhhdC5jb21dCj4+IOWPkemAgeaXtumXtDogMjAxOeW5tDEy5pyIMjDml6UgMTc6MjMKPj4g
5pS25Lu25Lq6OiBKaW0sWWFuIDxqaW15YW5AYmFpZHUuY29tPgo+PiDmioTpgIE6IGpvcm9AOGJ5
dGVzLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7Cj4+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPj4g5Li76aKYOiBSZTogW1BBVENIXSBpb21tdS92dC1kOiBEb24n
dCByZWplY3QgbnZtZSBob3N0IGR1ZSB0byBzY29wZSBtaXNtYXRjaAo+Pgo+PiBPbiBGcmkgRGVj
IDIwIDE5LCBqaW15YW4gd3JvdGU6Cj4+PiBPbiBhIHN5c3RlbSB3aXRoIGFuIEludGVsIFBDSWUg
cG9ydCBjb25maWd1cmVkIGFzIGEgbnZtZSBob3N0IGRldmljZSwKPj4+IGlvbW11IGluaXRpYWxp
emF0aW9uIGZhaWxzIHdpdGgKPj4+Cj4+PiAgICAgRE1BUjogRGV2aWNlIHNjb3BlIHR5cGUgZG9l
cyBub3QgbWF0Y2ggZm9yIDAwMDA6ODA6MDAuMAo+Pj4KPj4+IFRoaXMgaXMgYmVjYXVzZSB0aGUg
RE1BUiB0YWJsZSByZXBvcnRzIHRoaXMgZGV2aWNlIGFzIGhhdmluZyBzY29wZSAyCj4+PiAoQUNQ
SV9ETUFSX1NDT1BFX1RZUEVfQlJJREdFKToKPj4+Cj4+Cj4+IElzbid0IHRoYXQgYSBwcm9ibGVt
IHRvIGJlIGZpeGVkIGluIHRoZSBETUFSIHRhYmxlIHRoZW4/Cj4+Cj4+PiBidXQgdGhlIGRldmlj
ZSBoYXMgYSB0eXBlIDAgUENJIGhlYWRlcjoKPj4+IDgwOjAwLjAgQ2xhc3MgMDYwMDogRGV2aWNl
IDgwODY6MjAyMCAocmV2IDA2KQo+Pj4gMDA6IDg2IDgwIDIwIDIwIDQ3IDA1IDEwIDAwIDA2IDAw
IDAwIDA2IDEwIDAwIDAwIDAwCj4+PiAxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAKPj4+IDIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCA4NiA4MCAwMCAwMAo+Pj4gMzA6IDAwIDAwIDAwIDAwIDkwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAxIDAwIDAwCj4+Pgo+Pj4gVlQtZCB3b3JrcyBwZXJmZWN0bHkgb24gdGhpcyBzeXN0
ZW0sIHNvIHRoZXJlJ3Mgbm8gcmVhc29uIHRvIGJhaWwgb3V0Cj4+PiBvbiBpbml0aWFsaXphdGlv
biBkdWUgdG8gdGhpcyBhcHBhcmVudCBzY29wZSBtaXNtYXRjaC4gQWRkIHRoZSBjbGFzcwo+Pj4g
MHg2MDAgKCJQQ0lfQ0xBU1NfQlJJREdFX0hPU1QiKSBhcyBhIGhldXJpc3RpYyBmb3IgYWxsb3dp
bmcgRE1BUgo+Pj4gaW5pdGlhbGl6YXRpb24gZm9yIG5vbi1icmlkZ2UgUENJIGRldmljZXMgbGlz
dGVkIHdpdGggc2NvcGUgYnJpZGdlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IGppbXlhbiA8amlt
eWFuQGJhaWR1LmNvbT4KPj4+IC0tLQo+Pj4gZHJpdmVycy9pb21tdS9kbWFyLmMgfCAxICsKPj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvZG1hci5jIGluZGV4Cj4+PiBlZWNkNmE0
MjE2NjcuLjlmYWYyZjBlMDIzNyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hci5j
Cj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2RtYXIuYwo+Pj4gQEAgLTI0NCw2ICsyNDQsNyBAQCBp
bnQgZG1hcl9pbnNlcnRfZGV2X3Njb3BlKHN0cnVjdAo+PiBkbWFyX3BjaV9ub3RpZnlfaW5mbyAq
aW5mbywKPj4+IAkJICAgICBpbmZvLT5kZXYtPmhkcl90eXBlICE9IFBDSV9IRUFERVJfVFlQRV9O
T1JNQUwpIHx8Cj4+PiAJCSAgICAoc2NvcGUtPmVudHJ5X3R5cGUgPT0gQUNQSV9ETUFSX1NDT1BF
X1RZUEVfQlJJREdFICYmCj4+PiAJCSAgICAgKGluZm8tPmRldi0+aGRyX3R5cGUgPT0gUENJX0hF
QURFUl9UWVBFX05PUk1BTCAmJgo+Pj4gKwkJCSAgaW5mby0+ZGV2LT5jbGFzcyA+PiA4ICE9IFBD
SV9DTEFTU19CUklER0VfSE9TVCAmJgo+Pj4gCQkgICAgICBpbmZvLT5kZXYtPmNsYXNzID4+IDgg
IT0gUENJX0NMQVNTX0JSSURHRV9PVEhFUikpKSB7Cj4+PiAJCQlwcl93YXJuKCJEZXZpY2Ugc2Nv
cGUgdHlwZSBkb2VzIG5vdCBtYXRjaCBmb3IgJXNcbiIsCj4+PiAJCQkJcGNpX25hbWUoaW5mby0+
ZGV2KSk7Cj4+PiAtLQo+Pj4gMi4xMS4wCj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4+IGlvbW11IG1haWxpbmcgbGlzdAo+Pj4gaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4+Pgo+IEFjdHVhbGx5IHRoaXMgcGF0Y2gg
aXMgc2ltaWxhciB0byB0aGUgY29tbWl0OiBmZmIyZDFlYjg4YzMoImlvbW11L3Z0LWQ6IERvbid0
IHJlamVjdCBOVEIgZGV2aWNlcyBkdWUgdG8gc2NvcGUgbWlzbWF0Y2giKS4gQmVzaWRlcywgbW9k
aWZ5aW5nIERNQVIgdGFibGUgbmVlZCBPRU0gdXBkYXRlIEJJT1MuIEl0IGlzIGhhcmQgdG8gaW1w
bGVtZW50Lgo+CgpGb3IgYm90aCBjYXNlcywgYSBxdWlyayBmbGFnIHNlZW1zIHRvIGJlIG1vcmUg
cmVhc29uYWJsZSwgc28gdGhhdAp1bnJlbGF0ZWQgZGV2aWNlcyB3aWxsIG5vdCBiZSBpbXBhY3Rl
ZC4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
