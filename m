Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DAC432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 02:00:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45CD20684
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 02:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45CD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B988686490;
	Tue,  3 Dec 2019 02:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1FZW8evefs8; Tue,  3 Dec 2019 02:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D90686493;
	Tue,  3 Dec 2019 02:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28076C1798;
	Tue,  3 Dec 2019 02:00:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52FC3C087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4E3AB2202E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AT-kFj7c77B3 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 02:00:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 5446820455
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:00:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Dec 2019 18:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,271,1571727600"; d="scan'208";a="222650067"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 02 Dec 2019 18:00:09 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
Date: Tue, 3 Dec 2019 09:59:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202161332.ctc3y5cvdgqwnz7l@cantor>
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

SGksCgpPbiAxMi8zLzE5IDEyOjEzIEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIE1v
biBEZWMgMDIgMTksIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+IE9uIE1vbiBEZWMgMDIgMTks
IEx1IEJhb2x1IHdyb3RlOgo+Pj4gSGksCj4+Pgo+Pj4gT24gMTIvMi8xOSAyOjM0IFBNLCBKZXJy
eSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4+IFdlIGFyZSBzZWVpbmcgRE1BUiBQVEUgcmVhZCBhY2Nl
c3Mgbm90IHNldCBlcnJvcnMgd2hlbiBib290aW5nIGEKPj4+PiBrZXJuZWwgd2l0aCBkZWZhdWx0
IHBhc3N0aHJvdWdoLCBib3RoIHdpdGggYSB0ZXN0IGtlcm5lbCBhbmQgd2l0aAo+Pj4+IGEgNS40
LjAga2VybmVsLiBQcmV2aW91c2x5IHdlIHdvdWxkIHNlZSBhIG51bWJlciBvZiBpZGVudGl0eSBt
YXBwaW5ncwo+Pj4+IGJlaW5nIHNldCByZWxhdGVkIHRvIHRoZSBybXJycywgYW5kIG5vdyB0aGV5
IGFyZW4ndCBzZWVuIGFuZCB3ZSBnZXQKPj4+PiB0aGUgZG1hciBwdGUgZXJyb3JzIGFzIGRldmlj
ZXMgdG91Y2ggdGhvc2UgcmVnaW9ucy4gRnJvbSB3aGF0IEkgY2FuIAo+Pj4+IHRlbGwKPj4+PiBj
dXJyZW50bHkgZGY0ZjNjNjAzYWViICgiaW9tbXUvdnQtZDogUmVtb3ZlIHN0YXRpYyBpZGVudGl0
eSBtYXAgY29kZSIpCj4+Pj4gcmVtb3ZlZCB0aGUgYml0IG9mIGNvZGUgaW4gaW5pdF9kbWFycyB0
aGF0IHVzZWQgdG8gc2V0IHVwIHRob3NlCj4+Pj4gbWFwcGluZ3M6Cj4+Pj4KPj4+PiAtwqDCoMKg
wqDCoMKgIC8qCj4+Pj4gLcKgwqDCoMKgwqDCoMKgICogRm9yIGVhY2ggcm1ycgo+Pj4+IC3CoMKg
wqDCoMKgwqDCoCAqwqDCoCBmb3IgZWFjaCBkZXYgYXR0YWNoZWQgdG8gcm1ycgo+Pj4+IC3CoMKg
wqDCoMKgwqDCoCAqwqDCoCBkbwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgbG9jYXRl
IGRyaGQgZm9yIGRldiwgYWxsb2MgZG9tYWluIGZvciBkZXYKPj4+PiAtwqDCoMKgwqDCoMKgwqAg
KsKgwqDCoMKgIGFsbG9jYXRlIGZyZWUgZG9tYWluCj4+Pj4gLcKgwqDCoMKgwqDCoMKgICrCoMKg
wqDCoCBhbGxvY2F0ZSBwYWdlIHRhYmxlIGVudHJpZXMgZm9yIHJtcnIKPj4+PiAtwqDCoMKgwqDC
oMKgwqAgKsKgwqDCoMKgIGlmIGNvbnRleHQgbm90IGFsbG9jYXRlZCBmb3IgYnVzCj4+Pj4gLcKg
wqDCoMKgwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY2F0ZSBhbmQgaW5pdCBjb250
ZXh0Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXQgcHJlc2Vu
dCBpbiByb290IHRhYmxlIGZvciB0aGlzIGJ1cwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCAqwqDCoMKg
wqAgaW5pdCBjb250ZXh0IHdpdGggZG9tYWluLCB0cmFuc2xhdGlvbiBldGMKPj4+PiAtwqDCoMKg
wqDCoMKgwqAgKsKgwqDCoCBlbmRmb3IKPj4+PiAtwqDCoMKgwqDCoMKgwqAgKiBlbmRmb3IKPj4+
PiAtwqDCoMKgwqDCoMKgwqAgKi8KPj4+PiAtwqDCoMKgwqDCoMKgIHByX2luZm8oIlNldHRpbmcg
Uk1SUjpcbiIpOwo+Pj4+IC3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfcm1ycl91bml0cyhybXJyKSB7
Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogc29tZSBCSU9TIGxpc3RzIG5v
bi1leGlzdCBkZXZpY2VzIGluIERNQVIgdGFibGUuICovCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZm9yX2VhY2hfYWN0aXZlX2Rldl9zY29wZShybXJyLT5kZXZpY2VzLCAKPj4+
PiBybXJyLT5kZXZpY2VzX2NudCwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSwgZGV2
KSB7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IGlvbW11X3ByZXBhcmVfcm1ycl9kZXYocm1yciwgZGV2KTsKPj4+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Vy
cigiTWFwcGluZyByZXNlcnZlZCByZWdpb24gCj4+Pj4gZmFpbGVkXG4iKTsKPj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4gLcKgwqDCoMKgwqDCoCB9Cj4+Pj4KPj4+PiBz
aV9kb21haW5faW5pdCBub3cgaGFzIGNvZGUgdGhhdCBzZXRzIGlkZW50aXR5IG1hcHMgZm9yIGRl
dmljZXMgaW4gCj4+Pj4gcm1ycnMsIGJ1dAo+Pj4+IG9ubHkgZm9yIGNlcnRhaW4gZGV2aWNlcy4K
Pj4+Cj4+PiBPbiB3aGljaCBkZXZpY2UsIGFyZSB5b3Ugc2VlaW5nIHRoaXMgZXJyb3I/IElzIGl0
IGEgcm1yciBsb2NrZWQgZGV2aWNlPwo+Pj4KPj4+IEJlc3QgcmVnYXJkcywKPj4+IGJhb2x1Cj4+
Pgo+Pgo+PiBBbG1vc3QgYWxsIG9mIHRoZSBtZXNzYWdlcyBhcmUgZm9yIHRoZSBpbG8sIGJ1dCB0
aGVyZSBhbHNvIGlzIGEgCj4+IG1lc3NhZ2UgZm9yCj4+IHRoZSBzbWFydCBhcnJheSByYWlkIGJ1
cyBjb250cm9sbGVyLgo+Pgo+IAo+IEFsc28gc2VlaW5nIGl0IHdpdGggYSBkbDM4MCBnZW45IHN5
c3RlbSwgd2hlcmUgdGhlIHJhaWQgYnVzIGNvbnRyb2xsZXIKPiBpcyBnZXR0aW5nIHRoZSBlcnJv
ci4KCkRvZXMgaXQgaGVscCBpZiB5b3UgcmVtb3ZlCgogICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGRldmljZV9pc19ybXJyX2xvY2tlZChkZXYpKQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsKCmluIHNpX2RvbWFpbl9pbml0KCk/CgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
