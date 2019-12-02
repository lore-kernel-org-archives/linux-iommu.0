Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6FC432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 06:42:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E802F20715
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 06:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD08185FDB;
	Mon,  2 Dec 2019 06:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wtyq1x1DJ2lm; Mon,  2 Dec 2019 06:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FC3585FFD;
	Mon,  2 Dec 2019 06:42:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7A1C1DDC;
	Mon,  2 Dec 2019 06:42:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75855C087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 06:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5A2FF87D11
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 06:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruPzG+9dsHa6 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 06:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C8EAA87D05
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 06:42:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 22:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="222318051"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 01 Dec 2019 22:42:01 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <20191202063422.3lyfoerkejig4num@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
Date: Mon, 2 Dec 2019 14:41:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202063422.3lyfoerkejig4num@cantor>
Content-Language: en-US
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

SGksCgpPbiAxMi8yLzE5IDI6MzQgUE0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4gV2UgYXJl
IHNlZWluZyBETUFSIFBURSByZWFkIGFjY2VzcyBub3Qgc2V0IGVycm9ycyB3aGVuIGJvb3Rpbmcg
YQo+IGtlcm5lbCB3aXRoIGRlZmF1bHQgcGFzc3Rocm91Z2gsIGJvdGggd2l0aCBhIHRlc3Qga2Vy
bmVsIGFuZCB3aXRoCj4gYSA1LjQuMCBrZXJuZWwuIFByZXZpb3VzbHkgd2Ugd291bGQgc2VlIGEg
bnVtYmVyIG9mIGlkZW50aXR5IG1hcHBpbmdzCj4gYmVpbmcgc2V0IHJlbGF0ZWQgdG8gdGhlIHJt
cnJzLCBhbmQgbm93IHRoZXkgYXJlbid0IHNlZW4gYW5kIHdlIGdldAo+IHRoZSBkbWFyIHB0ZSBl
cnJvcnMgYXMgZGV2aWNlcyB0b3VjaCB0aG9zZSByZWdpb25zLiBGcm9tIHdoYXQgSSBjYW4gdGVs
bAo+IGN1cnJlbnRseSBkZjRmM2M2MDNhZWIgKCJpb21tdS92dC1kOiBSZW1vdmUgc3RhdGljIGlk
ZW50aXR5IG1hcCBjb2RlIikKPiByZW1vdmVkIHRoZSBiaXQgb2YgY29kZSBpbiBpbml0X2RtYXJz
IHRoYXQgdXNlZCB0byBzZXQgdXAgdGhvc2UKPiBtYXBwaW5nczoKPiAKPiAtwqDCoMKgwqDCoMKg
IC8qCj4gLcKgwqDCoMKgwqDCoMKgICogRm9yIGVhY2ggcm1ycgo+IC3CoMKgwqDCoMKgwqDCoCAq
wqDCoCBmb3IgZWFjaCBkZXYgYXR0YWNoZWQgdG8gcm1ycgo+IC3CoMKgwqDCoMKgwqDCoCAqwqDC
oCBkbwo+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgbG9jYXRlIGRyaGQgZm9yIGRldiwgYWxs
b2MgZG9tYWluIGZvciBkZXYKPiAtwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgIGFsbG9jYXRlIGZy
ZWUgZG9tYWluCj4gLcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoCBhbGxvY2F0ZSBwYWdlIHRhYmxl
IGVudHJpZXMgZm9yIHJtcnIKPiAtwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgIGlmIGNvbnRleHQg
bm90IGFsbG9jYXRlZCBmb3IgYnVzCj4gLcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhbGxvY2F0ZSBhbmQgaW5pdCBjb250ZXh0Cj4gLcKgwqDCoMKgwqDCoMKgICrCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzZXQgcHJlc2VudCBpbiByb290IHRhYmxlIGZvciB0aGlzIGJ1cwo+IC3C
oMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgaW5pdCBjb250ZXh0IHdpdGggZG9tYWluLCB0cmFuc2xh
dGlvbiBldGMKPiAtwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBlbmRmb3IKPiAtwqDCoMKgwqDCoMKg
wqAgKiBlbmRmb3IKPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgIHByX2luZm8o
IlNldHRpbmcgUk1SUjpcbiIpOwo+IC3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfcm1ycl91bml0cyhy
bXJyKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogc29tZSBCSU9TIGxpc3Rz
IG5vbi1leGlzdCBkZXZpY2VzIGluIERNQVIgdGFibGUuICovCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZm9yX2VhY2hfYWN0aXZlX2Rldl9zY29wZShybXJyLT5kZXZpY2VzLCBybXJy
LT5kZXZpY2VzX2NudCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSwgZGV2KSB7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGlvbW11X3By
ZXBhcmVfcm1ycl9kZXYocm1yciwgZGV2KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiTWFwcGluZyByZXNlcnZl
ZCByZWdpb24gZmFpbGVkXG4iKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
LcKgwqDCoMKgwqDCoCB9Cj4gCj4gc2lfZG9tYWluX2luaXQgbm93IGhhcyBjb2RlIHRoYXQgc2V0
cyBpZGVudGl0eSBtYXBzIGZvciBkZXZpY2VzIGluIAo+IHJtcnJzLCBidXQKPiBvbmx5IGZvciBj
ZXJ0YWluIGRldmljZXMuCgpPbiB3aGljaCBkZXZpY2UsIGFyZSB5b3Ugc2VlaW5nIHRoaXMgZXJy
b3I/IElzIGl0IGEgcm1yciBsb2NrZWQgZGV2aWNlPwoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiAK
PiBXaXRoIGlvbW11PW5vcHQsIHRoZSBzeXN0ZW0gYm9vdHMgdXAgd2l0aG91dCBpc3N1ZS4KPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
