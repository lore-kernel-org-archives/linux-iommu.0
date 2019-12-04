Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74046C432C0
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 00:18:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F6C2054F
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 00:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 085D9203D5;
	Wed,  4 Dec 2019 00:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDO-c9M-addD; Wed,  4 Dec 2019 00:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A39B203D1;
	Wed,  4 Dec 2019 00:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10875C18DC;
	Wed,  4 Dec 2019 00:18:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 779ABC1798
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 62A328760D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dl5UgzAQGl4 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 00:18:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9144D875D4
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:18:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 16:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; d="scan'208";a="223025607"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 16:18:30 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
Date: Wed, 4 Dec 2019 08:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203095636.epmuinnrpykecfda@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

SGksCgpPbiAxMi8zLzE5IDU6NTYgUE0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4gT24gVHVl
IERlYyAwMyAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpLAo+Pgo+PiBPbiAxMi8zLzE5IDEyOjEz
IEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4gT24gTW9uIERlYyAwMiAxOSwgSmVycnkg
U25pdHNlbGFhciB3cm90ZToKPj4+PiBPbiBNb24gRGVjIDAyIDE5LCBMdSBCYW9sdSB3cm90ZToK
Pj4+Pj4gSGksCj4+Pj4+Cj4+Pj4+IE9uIDEyLzIvMTkgMjozNCBQTSwgSmVycnkgU25pdHNlbGFh
ciB3cm90ZToKPj4+Pj4+IFdlIGFyZSBzZWVpbmcgRE1BUiBQVEUgcmVhZCBhY2Nlc3Mgbm90IHNl
dCBlcnJvcnMgd2hlbiBib290aW5nIGEKPj4+Pj4+IGtlcm5lbCB3aXRoIGRlZmF1bHQgcGFzc3Ro
cm91Z2gsIGJvdGggd2l0aCBhIHRlc3Qga2VybmVsIGFuZCB3aXRoCj4+Pj4+PiBhIDUuNC4wIGtl
cm5lbC4gUHJldmlvdXNseSB3ZSB3b3VsZCBzZWUgYSBudW1iZXIgb2YgaWRlbnRpdHkgbWFwcGlu
Z3MKPj4+Pj4+IGJlaW5nIHNldCByZWxhdGVkIHRvIHRoZSBybXJycywgYW5kIG5vdyB0aGV5IGFy
ZW4ndCBzZWVuIGFuZCB3ZSBnZXQKPj4+Pj4+IHRoZSBkbWFyIHB0ZSBlcnJvcnMgYXMgZGV2aWNl
cyB0b3VjaCB0aG9zZSByZWdpb25zLiBGcm9tIHdoYXQgSSAKPj4+Pj4+IGNhbiB0ZWxsCj4+Pj4+
PiBjdXJyZW50bHkgZGY0ZjNjNjAzYWViICgiaW9tbXUvdnQtZDogUmVtb3ZlIHN0YXRpYyBpZGVu
dGl0eSBtYXAgCj4+Pj4+PiBjb2RlIikKPj4+Pj4+IHJlbW92ZWQgdGhlIGJpdCBvZiBjb2RlIGlu
IGluaXRfZG1hcnMgdGhhdCB1c2VkIHRvIHNldCB1cCB0aG9zZQo+Pj4+Pj4gbWFwcGluZ3M6Cj4+
Pj4+Pgo+Pj4+Pj4gLcKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgICogRm9y
IGVhY2ggcm1ycgo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgICrCoMKgIGZvciBlYWNoIGRldiBhdHRh
Y2hlZCB0byBybXJyCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgKsKgwqAgZG8KPj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoCAqwqDCoMKgwqAgbG9jYXRlIGRyaGQgZm9yIGRldiwgYWxsb2MgZG9tYWluIGZv
ciBkZXYKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgYWxsb2NhdGUgZnJlZSBkb21h
aW4KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgYWxsb2NhdGUgcGFnZSB0YWJsZSBl
bnRyaWVzIGZvciBybXJyCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgIGlmIGNvbnRl
eHQgbm90IGFsbG9jYXRlZCBmb3IgYnVzCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKg
wqDCoMKgwqDCoMKgIGFsbG9jYXRlIGFuZCBpbml0IGNvbnRleHQKPj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0IHByZXNlbnQgaW4gcm9vdCB0YWJsZSBmb3Ig
dGhpcyBidXMKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgaW5pdCBjb250ZXh0IHdp
dGggZG9tYWluLCB0cmFuc2xhdGlvbiBldGMKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKg
IGVuZGZvcgo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgICogZW5kZm9yCj4+Pj4+PiAtwqDCoMKgwqDC
oMKgwqAgKi8KPj4+Pj4+IC3CoMKgwqDCoMKgwqAgcHJfaW5mbygiU2V0dGluZyBSTVJSOlxuIik7
Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgIGZvcl9lYWNoX3JtcnJfdW5pdHMocm1ycikgewo+Pj4+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogc29tZSBCSU9TIGxpc3RzIG5vbi1leGlz
dCBkZXZpY2VzIGluIERNQVIgCj4+Pj4+PiB0YWJsZS4gKi8KPj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZvcl9lYWNoX2FjdGl2ZV9kZXZfc2NvcGUocm1yci0+ZGV2aWNlcywg
Cj4+Pj4+PiBybXJyLT5kZXZpY2VzX2NudCwKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpLCBkZXYpIHsKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXQgPSBpb21tdV9wcmVwYXJlX3JtcnJfZGV2KHJtcnIsIGRldik7Cj4+Pj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHJfZXJyKCJNYXBwaW5nIHJlc2VydmVkIHJlZ2lvbiAKPj4+Pj4+IGZhaWxlZFxu
Iik7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+PiAtwqDCoMKg
wqDCoMKgIH0KPj4+Pj4+Cj4+Pj4+PiBzaV9kb21haW5faW5pdCBub3cgaGFzIGNvZGUgdGhhdCBz
ZXRzIGlkZW50aXR5IG1hcHMgZm9yIGRldmljZXMgaW4gCj4+Pj4+PiBybXJycywgYnV0Cj4+Pj4+
PiBvbmx5IGZvciBjZXJ0YWluIGRldmljZXMuCj4+Pj4+Cj4+Pj4+IE9uIHdoaWNoIGRldmljZSwg
YXJlIHlvdSBzZWVpbmcgdGhpcyBlcnJvcj8gSXMgaXQgYSBybXJyIGxvY2tlZCAKPj4+Pj4gZGV2
aWNlPwo+Pj4+Pgo+Pj4+PiBCZXN0IHJlZ2FyZHMsCj4+Pj4+IGJhb2x1Cj4+Pj4+Cj4+Pj4KPj4+
PiBBbG1vc3QgYWxsIG9mIHRoZSBtZXNzYWdlcyBhcmUgZm9yIHRoZSBpbG8sIGJ1dCB0aGVyZSBh
bHNvIGlzIGEgCj4+Pj4gbWVzc2FnZSBmb3IKPj4+PiB0aGUgc21hcnQgYXJyYXkgcmFpZCBidXMg
Y29udHJvbGxlci4KPj4+Pgo+Pj4KPj4+IEFsc28gc2VlaW5nIGl0IHdpdGggYSBkbDM4MCBnZW45
IHN5c3RlbSwgd2hlcmUgdGhlIHJhaWQgYnVzIGNvbnRyb2xsZXIKPj4+IGlzIGdldHRpbmcgdGhl
IGVycm9yLgo+Pgo+PiBEb2VzIGl0IGhlbHAgaWYgeW91IHJlbW92ZQo+Pgo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGV2aWNlX2lzX3JtcnJfbG9j
a2VkKGRldikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4KPj4gaW4gc2lfZG9tYWluX2luaXQoKT8KPj4K
PiAKPiBVbmZvcnR1bmF0ZWx5IGl0IHN0aWxsIHNwaXRzIG91dCBhIGJ1bmNoIG9mIGVycm9yIG1l
c3NhZ2VzLgoKQ2FuIHlvdSBwbGVhc2Ugc2hvdyBtZSB0aGUgd2hvbGUgZG1lc2c/CgpCZXN0IHJl
Z2FyZHMsCi1iYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
