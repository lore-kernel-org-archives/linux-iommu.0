Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F3DC433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33AA960D5E;
	Tue, 21 Jun 2022 09:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33AA960D5E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vl3Q23eR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3p7bfUsPlyCM; Tue, 21 Jun 2022 09:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E41B060AE6;
	Tue, 21 Jun 2022 09:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E41B060AE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB1F1C0039;
	Tue, 21 Jun 2022 09:03:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5EBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 09:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7271B60BC0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 09:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7271B60BC0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-spqnzgfpI0 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:03:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81ACA60AE6
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81ACA60AE6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655802223; x=1687338223;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4JZweCQSf+b6fCtkASZHm4F6TWH/UJu0XxFQAnCoS+g=;
 b=Vl3Q23eRLHGE1UQH+jSooMnzB5k89ZXygm13HrXoMuVvkexHiIUWYNzh
 uqt9Zjlm3BNqVtnFx80M4c3/At3o3IXobVlOai4pPSj0Vv1XJqBVqZn1n
 tQXT9WzBxcwNfCBvEmToib7ygTy0zx+JA/WovVYVtXTwQggF/zFNI/C0M
 N2Gn1Tzqe31EJdNq2inT8if9kAguALItl4U0l0YFB8pocqam2W8jYRN3C
 YUR774iCzYbXXdYmrO0CoPsItm0ziQORsYGu7bGDgnx7CeWYNWDcPToI2
 o5hwNhIIqHtZ/6jhFYaS4Yy2t1K3FbRkIYWQ4ao0wQHTE23/N066vQrNp g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341754844"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="341754844"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 02:03:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="833485569"
Received: from zequnyu-mobl1.ccr.corp.intel.com (HELO [10.255.31.162])
 ([10.255.31.162])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 02:03:40 -0700
Message-ID: <ff4d8dab-e409-1e5d-74c5-ddbb65c2ba03@linux.intel.com>
Date: Tue, 21 Jun 2022 17:03:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
 <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <80457871-a760-69ba-70be-5e95344182ea@linux.intel.com>
 <BN9PR11MB5276A8B4E2466BE080CA9E9B8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A8B4E2466BE080CA9E9B8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

T24gMjAyMi82LzIxIDEzOjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogQmFvbHUgTHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4gU2VudDogVHVlc2RheSwgSnVuZSAyMSwgMjAy
MiAxMjoyOCBQTQo+Pgo+PiBPbiAyMDIyLzYvMjEgMTE6NDYsIFRpYW4sIEtldmluIHdyb3RlOgo+
Pj4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4gU2VudDog
VHVlc2RheSwgSnVuZSAyMSwgMjAyMiAxMTozOSBBTQo+Pj4+Cj4+Pj4gT24gMjAyMi82LzIxIDEw
OjU0LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBs
aW51eC5pbnRlbC5jb20+Cj4+Pj4+PiBTZW50OiBNb25kYXksIEp1bmUgMjAsIDIwMjIgNDoxNyBQ
TQo+Pj4+Pj4gQEAgLTI1NjQsNyArMjU2NCw3IEBAIHN0YXRpYyBpbnQgZG9tYWluX2FkZF9kZXZf
aW5mbyhzdHJ1Y3QKPj4+Pj4+IGRtYXJfZG9tYWluICpkb21haW4sIHN0cnVjdCBkZXZpY2UgKmRl
dikKPj4+Pj4+ICAgICAJCQlyZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9t
bXUsCj4+Pj4+PiBkb21haW4sCj4+Pj4+PiAgICAgCQkJCQlkZXYsIFBBU0lEX1JJRDJQQVNJRCk7
Cj4+Pj4+PiAgICAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpb21tdS0+bG9jaywgZmxhZ3Mp
Owo+Pj4+Pj4gLQkJaWYgKHJldCkgewo+Pj4+Pj4gKwkJaWYgKHJldCAmJiByZXQgIT0gLUVCVVNZ
KSB7Cj4+Pj4+PiAgICAgCQkJZGV2X2VycihkZXYsICJTZXR1cCBSSUQyUEFTSUQgZmFpbGVkXG4i
KTsKPj4+Pj4+ICAgICAJCQlkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8oZGV2KTsKPj4+Pj4+ICAg
ICAJCQlyZXR1cm4gcmV0Owo+Pj4+Pj4gLS0KPj4+Pj4+IDIuMjUuMQo+Pj4+Pgo+Pj4+PiBJdCdz
IGNsZWFuZXIgdG8gYXZvaWQgdGhpcyBlcnJvciBhdCB0aGUgZmlyc3QgcGxhY2UsIGkuZS4gb25s
eSBkbyB0aGUKPj4+Pj4gc2V0dXAgd2hlbiB0aGUgZmlyc3QgZGV2aWNlIGlzIGF0dGFjaGVkIHRv
IHRoZSBwYXNpZCB0YWJsZS4KPj4+Pgo+Pj4+IFRoZSBsb2dpYyB0aGF0IGlkZW50aWZpZXMgdGhl
IGZpcnN0IGRldmljZSBtaWdodCBpbnRyb2R1Y2UgYWRkaXRpb25hbAo+Pj4+IHVubmVjZXNzYXJ5
IGNvbXBsZXhpdHkuIERldmljZXMgdGhhdCBzaGFyZSBhIHBhc2lkIHRhYmxlIGFyZSByYXJlLiBJ
Cj4+Pj4gZXZlbiBwcmVmZXIgdG8gZ2l2ZSB1cCBzaGFyaW5nIHRhYmxlcyBzbyB0aGF0IHRoZSBj
b2RlIGNhbiBiZQo+Pj4+IHNpbXBsZXIuOi0pCj4+Pj4KPj4+Cj4+PiBJdCdzIG5vdCB0aGF0IGNv
bXBsZXggaWYgeW91IHNpbXBseSBtb3ZlIGRldmljZV9hdHRhY2hfcGFzaWRfdGFibGUoKQo+Pj4g
b3V0IG9mIGludGVsX3Bhc2lkX2FsbG9jX3RhYmxlKCkuIFRoZW4gZG8gdGhlIHNldHVwIGlmCj4+
PiBsaXN0X2VtcHR5KCZwYXNpZF90YWJsZS0+ZGV2KSBhbmQgdGhlbiBhdHRhY2ggZGV2aWNlIHRv
IHRoZQo+Pj4gcGFzaWQgdGFibGUgaW4gZG9tYWluX2FkZF9kZXZfaW5mbygpLgo+Pgo+PiBUaGUg
cGFzaWQgdGFibGUgaXMgcGFydCBvZiB0aGUgZGV2aWNlLCBoZW5jZSBhIGJldHRlciBwbGFjZSB0
bwo+PiBhbGxvY2F0ZS9mcmVlIHRoZSBwYXNpZCB0YWJsZSBpcyBpbiB0aGUgZGV2aWNlIHByb2Jl
L3JlbGVhc2UgcGF0aHMuCj4+IFRoaW5ncyB3aWxsIGJlY29tZSBtb3JlIGNvbXBsaWNhdGVkIGlm
IHdlIGNoYW5nZSByZWxhdGlvbnNoaXAgYmV0d2Vlbgo+PiBkZXZpY2UgYW5kIGl0J3MgcGFzaWQg
dGFibGUgd2hlbiBhdHRhY2hpbmcvZGV0YWNoaW5nIGEgZG9tYWluLiBUaGF0J3MKPj4gdGhlIHJl
YXNvbiB3aHkgSSB0aG91Z2h0IGl0IHdhcyBhZGRpdGlvbmFsIGNvbXBsZXhpdHkuCj4+Cj4gCj4g
SWYgeW91IGRvIHdhbnQgdG8gZm9sbG93IGN1cnJlbnQgcm91dGUgaXTigJlzIHN0aWxsIGNsZWFu
ZXIgdG8gY2hlY2sKPiB3aGV0aGVyIHRoZSBwYXNpZCBlbnRyeSBoYXMgcG9pbnRlZCB0byB0aGUg
ZG9tYWluIGluIHRoZSBpbmRpdmlkdWFsCj4gc2V0dXAgZnVuY3Rpb24gaW5zdGVhZCBvZiBibGlu
ZGx5IHJldHVybmluZyAtRUJVU1kgYW5kIHRoZW4gaWdub3JpbmcKPiBpdCBldmVuIGlmIGEgcmVh
bCBidXN5IGNvbmRpdGlvbiBvY2N1cnMuIFRoZSBzZXR1cCBmdW5jdGlvbnMgY2FuCj4ganVzdCBy
ZXR1cm4gemVybyBmb3IgdGhpcyBiZW5pZ24gYWxpYXMgY2FzZS4KCktldmluLCBob3cgZG8geW91
IGxpa2UgdGhpcyBvbmU/CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5j
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jCmluZGV4IGNiNGMxZDBjZjI1Yy4uZWNmZmQw
MTI5YjJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMKKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9wYXNpZC5jCkBAIC01NzUsNiArNTc1LDE2IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHBhc2lkX2VuYWJsZV93cGUoc3RydWN0IApwYXNpZF9lbnRyeSAqcHRlKQogIAlyZXR1
cm4gMDsKICB9OwoKKy8qCisgKiBSZXR1cm4gdHJ1ZSBpZiBAcGFzaWQgaXMgUklEMlBBU0lEIGFu
ZCB0aGUgZG9tYWluIEBkaWQgaGFzIGFscmVhZHkKKyAqIGJlZW4gc2V0dXAgdG8gdGhlIEBwdGUu
IE90aGVyd2lzZSwgcmV0dXJuIGZhbHNlLgorICovCitzdGF0aWMgaW5saW5lIGJvb2wKK3JpZDJw
YXNpZF9kb21haW5fdmFsaWQoc3RydWN0IHBhc2lkX2VudHJ5ICpwdGUsIHUzMiBwYXNpZCwgdTE2
IGRpZCkKK3sKKwlyZXR1cm4gcGFzaWQgPT0gUEFTSURfUklEMlBBU0lEICYmIHBhc2lkX2dldF9k
b21haW5faWQocHRlKSA9PSBkaWQ7Cit9CisKICAvKgogICAqIFNldCB1cCB0aGUgc2NhbGFibGUg
bW9kZSBwYXNpZCB0YWJsZSBlbnRyeSBmb3IgZmlyc3Qgb25seQogICAqIHRyYW5zbGF0aW9uIHR5
cGUuCkBAIC01OTUsOSArNjA1LDggQEAgaW50IGludGVsX3Bhc2lkX3NldHVwX2ZpcnN0X2xldmVs
KHN0cnVjdCBpbnRlbF9pb21tdSAKKmlvbW11LAogIAlpZiAoV0FSTl9PTighcHRlKSkKICAJCXJl
dHVybiAtRUlOVkFMOwoKLQkvKiBDYWxsZXIgbXVzdCBlbnN1cmUgUEFTSUQgZW50cnkgaXMgbm90
IGluIHVzZS4gKi8KICAJaWYgKHBhc2lkX3B0ZV9pc19wcmVzZW50KHB0ZSkpCi0JCXJldHVybiAt
RUJVU1k7CisJCXJldHVybiByaWQycGFzaWRfZG9tYWluX3ZhbGlkKHB0ZSwgcGFzaWQsIGRpZCkg
PyAwOiAtRUJVU1k7CgogIAlwYXNpZF9jbGVhcl9lbnRyeShwdGUpOwoKQEAgLTY5OCw5ICs3MDcs
OCBAQCBpbnQgaW50ZWxfcGFzaWRfc2V0dXBfc2Vjb25kX2xldmVsKHN0cnVjdCAKaW50ZWxfaW9t
bXUgKmlvbW11LAogIAkJcmV0dXJuIC1FTk9ERVY7CiAgCX0KCi0JLyogQ2FsbGVyIG11c3QgZW5z
dXJlIFBBU0lEIGVudHJ5IGlzIG5vdCBpbiB1c2UuICovCiAgCWlmIChwYXNpZF9wdGVfaXNfcHJl
c2VudChwdGUpKQotCQlyZXR1cm4gLUVCVVNZOworCQlyZXR1cm4gcmlkMnBhc2lkX2RvbWFpbl92
YWxpZChwdGUsIHBhc2lkLCBkaWQpID8gMDogLUVCVVNZOwoKICAJcGFzaWRfY2xlYXJfZW50cnko
cHRlKTsKICAJcGFzaWRfc2V0X2RvbWFpbl9pZChwdGUsIGRpZCk7CkBAIC03MzgsOSArNzQ2LDgg
QEAgaW50IGludGVsX3Bhc2lkX3NldHVwX3Bhc3NfdGhyb3VnaChzdHJ1Y3QgCmludGVsX2lvbW11
ICppb21tdSwKICAJCXJldHVybiAtRU5PREVWOwogIAl9CgotCS8qIENhbGxlciBtdXN0IGVuc3Vy
ZSBQQVNJRCBlbnRyeSBpcyBub3QgaW4gdXNlLiAqLwogIAlpZiAocGFzaWRfcHRlX2lzX3ByZXNl
bnQocHRlKSkKLQkJcmV0dXJuIC1FQlVTWTsKKwkJcmV0dXJuIHJpZDJwYXNpZF9kb21haW5fdmFs
aWQocHRlLCBwYXNpZCwgZGlkKSA/IDA6IC1FQlVTWTsKCiAgCXBhc2lkX2NsZWFyX2VudHJ5KHB0
ZSk7CiAgCXBhc2lkX3NldF9kb21haW5faWQocHRlLCBkaWQpOwoKLS0KQmVzdCByZWdhcmRzLApi
YW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
