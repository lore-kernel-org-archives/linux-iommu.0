Return-Path: <SRS0=ocWU=2F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC3C43603
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 05:39:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D2622B48
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 05:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D2622B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC7C420365;
	Sun, 15 Dec 2019 05:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ts2gJqNfXBaK; Sun, 15 Dec 2019 05:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 33FAE20347;
	Sun, 15 Dec 2019 05:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F8D2C18DD;
	Sun, 15 Dec 2019 05:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE917C0881
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA1C420365
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gp+tac8XQaKA for <iommu@lists.linux-foundation.org>;
 Sun, 15 Dec 2019 05:39:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id D4D1220347
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:39:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Dec 2019 21:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,316,1571727600"; d="scan'208";a="226735317"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 14 Dec 2019 21:39:09 -0800
Subject: Re: [PATCH] iommu/vt-d: Allocate reserved region for ISA with correct
 permission
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-kernel@vger.kernel.org
References: <20191213053642.5696-1-jsnitsel@redhat.com>
 <5ccaaec0-b070-b820-cebd-6b7ad179109c@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7f109c98-00d5-d66c-05c7-70eb670bd1a2@linux.intel.com>
Date: Sun, 15 Dec 2019 13:38:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <5ccaaec0-b070-b820-cebd-6b7ad179109c@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 stable@vger.kernel.org
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

SGkgSmVycnksCgpPbiAxMi8xNC8xOSA5OjQyIEFNLCBMdSBCYW9sdSB3cm90ZToKPiBIaSBKZXJy
eSwKPiAKPiBPbiAxMi8xMy8xOSAxOjM2IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+PiBD
dXJyZW50bHkgdGhlIHJlc2VydmVkIHJlZ2lvbiBmb3IgSVNBIGlzIGFsbG9jYXRlZCB3aXRoIG5v
Cj4+IHBlcm1pc3Npb25zLiBJZiBhIGRtYSBkb21haW4gaXMgYmVpbmcgdXNlZCwgbWFwcGluZyB0
aGlzIHJlZ2lvbiB3aWxsCj4+IGZhaWwuIFNldCB0aGUgcGVybWlzc2lvbnMgdG8gRE1BX1BURV9S
RUFEfERNQV9QVEVfV1JJVEUuCj4+Cj4+IENjOiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5k
ZT4KPj4gQ2M6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IENjOiBpb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyAjIHY1LjMrCj4+IEZpeGVzOiBkODUwYzJlZTVmZTIgKCJpb21tdS92dC1kOiBFeHBvc2UgSVNB
IGRpcmVjdCBtYXBwaW5nIHJlZ2lvbiB2aWEgCj4+IGlvbW11X2dldF9yZXN2X3JlZ2lvbnMiKQo+
PiBTaWduZWQtb2ZmLWJ5OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+
PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIHwgMiArLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9t
bXUuYwo+PiBpbmRleCAwYzhkODFmNTZhMzAuLjk5ODUyOWNlYmNmMiAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwt
aW9tbXUuYwo+PiBAQCAtNTczNiw3ICs1NzM2LDcgQEAgc3RhdGljIHZvaWQgaW50ZWxfaW9tbXVf
Z2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgCj4+IGRldmljZSAqZGV2aWNlLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldmljZSk7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoKHBkZXYtPmNsYXNzID4+IDgpID09IFBDSV9DTEFTU19CUklE
R0VfSVNBKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IGlvbW11X2FsbG9jX3Jl
c3ZfcmVnaW9uKDAsIDFVTCA8PCAyNCwgMCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVn
ID0gaW9tbXVfYWxsb2NfcmVzdl9yZWdpb24oMCwgMVVMIDw8IDI0LCBwcm90LAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJ
T01NVV9SRVNWX0RJUkVDVCk7Cj4gCj4gCj4gVGhpcyBhbHNvIGFwcGxpZXMgdG8gdGhlIElPQVBJ
QyByYW5nZS4gQ2FuIHlvdSBwbGVhc2UgY2hhbmdlIHRoZW0KPiB0b2dldGhlcj8KClBsZWFzZSBp
Z25vcmUgdGhpcyBjb21tZW50LiBUaGVzZSB0d28gcmFuZ2VzIGFyZSBvZiBkaWZmZXJlbnQgdHlw
ZS4gWW91cgpmaXggaXMgZW5vdWdoLiBTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4KCkJlc3QgcmVn
YXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
