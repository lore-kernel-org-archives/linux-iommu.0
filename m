Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5025C43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 06:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36BDF83EAD;
	Tue, 21 Jun 2022 06:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36BDF83EAD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKVUMuWg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0e85xVvP-Zi; Tue, 21 Jun 2022 06:15:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2C2D82F9E;
	Tue, 21 Jun 2022 06:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2C2D82F9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B57DAC0032;
	Tue, 21 Jun 2022 06:15:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0813FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 06:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3FA683372
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 06:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3FA683372
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZ0VvmNRNLko for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 06:15:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB5A582F9E
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB5A582F9E
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 06:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655792116; x=1687328116;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zNh6pUo3+c2mfFlvlWk9GP/Xel6H0s4DqcuTRAGy/N8=;
 b=CKVUMuWgcS16WVPks3QGkInGLQi+Fk0W++cbewAGgrTPYSz2lrKiuYkC
 txwp8SLDr4se9c4jmKlzwMbHgL+qDPg+k5Z16/N1L7kWlDuV8AMQyQfcx
 V07C3/wSYsbx1dmw1C9orCjoLrP/cnBHrjoMuvsppmDa1uPwDMQCcXrJM
 pBCqJmQJ9C1Sq+riewyxY5rX/1iCVIb/lF8wjBglcFV2zJvGmI0lf5SIR
 0vvpQd08Q4KZPox/1VOffFZjgzePkZQTlx2UXnBtciM4bBkGPXsQzi1KB
 h+dUplCZiEytEnFWfSaWqmLVbDg+6cULLji3g3Ix3Q8nbZamo0XCSjQmD Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="278807539"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="278807539"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 23:15:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="833426034"
Received: from zequnyu-mobl1.ccr.corp.intel.com (HELO [10.255.31.162])
 ([10.255.31.162])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 23:15:13 -0700
Message-ID: <88295461-7cba-7c30-6b9e-63ee77e90295@linux.intel.com>
Date: Tue, 21 Jun 2022 14:15:11 +0800
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
ZXR1cm4gemVybyBmb3IgdGhpcyBiZW5pZ24gYWxpYXMgY2FzZS4KCkZhaXIgZW5vdWdoLiBMZXQg
bWUgaW1wcm92ZSBpdC4KCi0tCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
