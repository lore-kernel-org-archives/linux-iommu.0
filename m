Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D906C433F5
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 00:57:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32DF61A8C
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 00:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C32DF61A8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7939C40266;
	Fri, 19 Nov 2021 00:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUD9yHPi5bua; Fri, 19 Nov 2021 00:57:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0530A40183;
	Fri, 19 Nov 2021 00:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE01DC002E;
	Fri, 19 Nov 2021 00:57:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBD2C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 00:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF2D7409A0
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 00:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3qp0SL2cjdpu for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 00:57:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B79B04099E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 00:57:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="320543721"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; d="scan'208";a="320543721"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 16:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; d="scan'208";a="495643561"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 18 Nov 2021 16:57:13 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix unmap_pages support
To: Jerry Snitselaar <jsnitsel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <163659074748.1617923.12716161410774184024.stgit@omen>
 <511aa70f-0646-bd90-b14e-ba1cfaa517d0@linux.intel.com>
 <a68f646759351becc665896b72a308c734295892.camel@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <824525d8-a367-a7ec-9706-4ec99be7161f@linux.intel.com>
Date: Fri, 19 Nov 2021 08:52:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a68f646759351becc665896b72a308c734295892.camel@redhat.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

SGkgSmVycnksCgpPbiAxMS8xOS8yMSAzOjQ4IEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+
IE9uIEZyaSwgMjAyMS0xMS0xMiBhdCAxMDo1OSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhp
IEFsZXgsCj4+Cj4+IE9uIDExLzExLzIxIDg6MzIgQU0sIEFsZXggV2lsbGlhbXNvbiB3cm90ZToK
Pj4+IFdoZW4gc3VwcG9ydGluZyBvbmx5IHRoZSAubWFwIGFuZCAudW5tYXAgY2FsbGJhY2tzIG9m
IGlvbW11X29wcywKPj4+IHRoZSBJT01NVSBkcml2ZXIgY2FuIG1ha2UgYXNzdW1wdGlvbnMgYWJv
dXQgdGhlIHNpemUgYW5kIGFsaWdubWVudAo+Pj4gdXNlZCBmb3IgbWFwcGluZ3MgYmFzZWQgb24g
dGhlIGRyaXZlciBwcm92aWRlZCBwZ3NpemVfYml0bWFwLsKgIFZULWQKPj4+IHByZXZpb3VzbHkg
dXNlZCBlc3NlbnRpYWxseSBQQUdFX01BU0sgZm9yIHRoaXMgYml0bWFwIGFzIGFueSBwb3dlcgo+
Pj4gb2YgdHdvIG1hcHBpbmcgd2FzIGFjY2VwdGFibHkgZmlsbGVkIGJ5IG5hdGl2ZSBwYWdlIHNp
emVzLgo+Pj4KPj4+IEhvd2V2ZXIsIHdpdGggdGhlIC5tYXBfcGFnZXMgYW5kIC51bm1hcF9wYWdl
cyBpbnRlcmZhY2Ugd2UncmUgbm93Cj4+PiBnZXR0aW5nIHBhZ2Utc2l6ZSBhbmQgY291bnQgYXJn
dW1lbnRzLsKgIElmIHdlIHNpbXBseSBjb21iaW5lIHRoZXNlCj4+PiBhcyAocGFnZS1zaXplICog
Y291bnQpIGFuZCBtYWtlIHVzZSBvZiB0aGUgcHJldmlvdXMgbWFwL3VubWFwCj4+PiBmdW5jdGlv
bnMgaW50ZXJuYWxseSwgYW55IHNpemUgYW5kIGFsaWdubWVudCBhc3N1bXB0aW9ucyBhcmUgdmVy
eQo+Pj4gZGlmZmVyZW50Lgo+Pj4KPj4+IEFzIGFuIGV4YW1wbGUsIGEgZ2l2ZW4gdmZpbyBkZXZp
Y2UgYXNzaWdubWVudCBWTSB3aWxsIG9mdGVuIGNyZWF0ZQo+Pj4gYSA0TUIgbWFwcGluZyBhdCBJ
T1ZBIHBmbiBbMHgzZmUwMCAtIDB4NDAxZmZdLsKgIE9uIGEgc3lzdGVtIHRoYXQKPj4+IGRvZXMg
bm90IHN1cHBvcnQgSU9NTVUgc3VwZXIgcGFnZXMsIHRoZSB1bm1hcF9wYWdlcyBpbnRlcmZhY2Ug
d2lsbAo+Pj4gYXNrIHRvIHVubWFwIDEwMjQgNEtCIHBhZ2VzIGF0IHRoZSBiYXNlIElPVkEuCj4+
PiBkbWFfcHRlX2NsZWFyX2xldmVsKCkKPj4+IHdpbGwgcmVjdXJzZSBkb3duIHRvIGxldmVsIDIg
b2YgdGhlIHBhZ2UgdGFibGUgd2hlcmUgdGhlIGZpcnN0IGhhbGYKPj4+IG9mIHRoZSBwZm4gcmFu
Z2UgZXhhY3RseSBtYXRjaGVzIHRoZSBlbnRpcmUgcHRlIGxldmVsLsKgIFdlIGNsZWFyCj4+PiB0
aGUKPj4+IHB0ZSwgaW5jcmVtZW50IHRoZSBwZm4gYnkgdGhlIGxldmVsIHNpemUsIGJ1dCAob29w
cykgdGhlIG5leHQgcHRlCj4+PiBpcwo+Pj4gb24gYSBuZXcgcGFnZSwgc28gd2UgZXhpdCB0aGUg
bG9vcCBhbiBwb3AgYmFjayB1cCBhIGxldmVsLsKgIFdoZW4gd2UKPj4+IHRoZW4gdXBkYXRlIHRo
ZSBwZm4gYmFzZWQgb24gdGhhdCBoaWdoZXIgbGV2ZWwsIHdlIHNlZW0gdG8gYXNzdW1lCj4+PiB0
aGF0IHRoZSBwcmV2aW91cyBwZm4gdmFsdWUgd2FzIGF0IHRoZSBzdGFydCBvZiB0aGUgbGV2ZWwu
wqAgSW4gdGhpcwo+Pj4gY2FzZSB0aGUgbGV2ZWwgc2l6ZSBpcyAyNTZLIHBmbnMsIHdoaWNoIHdl
IGFkZCB0byB0aGUgYmFzZSBwZm4gYW5kCj4+PiBnZXQgYSByZXN1bHRzIG9mIDB4N2ZlMDAsIHdo
aWNoIGlzIGNsZWFybHkgZ3JlYXRlciB0aGFuIDB4NDAxZmYsCj4+PiBzbyB3ZSdyZSBkb25lLsKg
IE1lYW53aGlsZSB3ZSBuZXZlciBjbGVhcmVkIHRoZSBwdGVzIGZvciB0aGUKPj4+IHJlbWFpbmRl
cgo+Pj4gb2YgdGhlIHJhbmdlLsKgIFdoZW4gdGhlIFZNIHJlbWFwcyB0aGlzIHJhbmdlLCB3ZSdy
ZSBvdmVyd3JpdGluZwo+Pj4gdmFsaWQKPj4+IHB0ZXMgYW5kIHRoZSBWVC1kIGRyaXZlciBjb21w
bGFpbnMgbG91ZGx5LCBhcyByZXBvcnRlZCBieSB0aGUgdXNlcgo+Pj4gcmVwb3J0IGxpbmtlZCBi
ZWxvdy4KPj4+Cj4+PiBUaGUgZml4IGZvciB0aGlzIHNlZW1zIHJlbGF0aXZlbHkgc2ltcGxlLCBp
ZiBlYWNoIGl0ZXJhdGlvbiBvZiB0aGUKPj4+IGxvb3AgaW4gZG1hX3B0ZV9jbGVhcl9sZXZlbCgp
IGlzIGFzc3VtZWQgdG8gY2xlYXIgdG8gdGhlIGVuZCBvZiB0aGUKPj4+IGxldmVsIHB0ZSBwYWdl
LCB0aGVuIG91ciBuZXh0IHBmbiBzaG91bGQgYmUgY2FsY3VsYXRlZCBmcm9tCj4+PiBsZXZlbF9w
Zm4KPj4+IHJhdGhlciB0aGFuIG91ciB3b3JraW5nIHBmbi4KPj4+Cj4+PiBGaXhlczogM2YzNGYx
MjU5Nzc2ICgiaW9tbXUvdnQtZDogSW1wbGVtZW50IG1hcC91bm1hcF9wYWdlcygpCj4+PiBpb21t
dV9vcHMgY2FsbGJhY2siKQo+Pj4gUmVwb3J0ZWQtYnk6IEFqYXkgR2FyZyA8YWpheWdhcmduc2l0
QGdtYWlsLmNvbT4KPj4+IExpbms6Cj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MTEwMDIxMjQwMTIuMTgxODYtMS1hamF5Z2FyZ25zaXRAZ21haWwuY29tLwo+Pj4gU2lnbmVkLW9m
Zi1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4KPj4KPj4g
VGhhbmsgeW91IGZvciBmaXhpbmcgdGhpcyEgSSB3aWxsIHF1ZXVlIGl0IGZvciB2NS4xNi4KPj4K
Pj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQo+Pgo+IAo+IEhpIEJhb2x1LAo+IAo+IERvIHlvdSBo
YXZlIGFuIGVzdGltYXRlIG9mIHdoZW4gdGhpcyB3aWxsIGJlIHN1Ym1pdHRlZD8KCkkgd2lsbCBz
dWJtaXQgYWxsIGZpeCBwYXRjaGVzIGluIG15IHF1ZXVlIHRvIEpvZXJnIGVhcmx5IHRoZSBuZXh0
IHdlZWsuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
