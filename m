Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF916C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 04:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AC2B40C59;
	Wed, 22 Jun 2022 04:39:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AC2B40C59
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cC+D2yO4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHiloUTciyUT; Wed, 22 Jun 2022 04:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C37B3400DD;
	Wed, 22 Jun 2022 04:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C37B3400DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85DF6C0039;
	Wed, 22 Jun 2022 04:39:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB0CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 240E161226
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 240E161226
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cC+D2yO4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4-7xd-RpPWs for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 04:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DB5D61052
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DB5D61052
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655872778; x=1687408778;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AMhZegtFWYVx//Lb0JAJ2PWASXQIxUvUTb3GUIaBbv8=;
 b=cC+D2yO49b41AToNl7cg1a9DabVtd4/Duvv8LbUAW9F2PmiURuTnEDe4
 CURD9/6c/3rSLhcga3S/YXzfYXdbDYlU2e4HdRtxAZmJOosEA1xGl8KZt
 f34DYTQD4xWelayvDO5Tmh0CdBvTBvdqUmm4rhoJgi99bH2Sqf3x4+K6w
 32x268QSrtqV3l2w0jiybU5OU+NJhzDqdOGiZPmQK6B4xL/opF40qIGEF
 tOSAKq0Lplc+a0L7r0ZIfoRAXAC102siXDmgzhIC/x+vS3KivWVqR7oaF
 GoTgTTEaClDtq5Rhbe7jHPfEPctOaZDmfL0HZlVKarxGQgle0cTg8KPId Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="280357876"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="280357876"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 21:39:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833905619"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 21:39:35 -0700
Message-ID: <95845c03-d191-7228-c83f-92f5589a70db@linux.intel.com>
Date: Wed, 22 Jun 2022 12:39:34 +0800
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
 <ff4d8dab-e409-1e5d-74c5-ddbb65c2ba03@linux.intel.com>
 <BN9PR11MB52763B34313DD178B44BA2578CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4316fa3e-3183-beb0-9c4a-d6045c6b5340@linux.intel.com>
 <BN9PR11MB52764776AA25E73721396DC88CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764776AA25E73721396DC88CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

T24gMjAyMi82LzIyIDExOjMxLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogQmFvbHUgTHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDIyLCAy
MDIyIDExOjI4IEFNCj4+Cj4+IE9uIDIwMjIvNi8yMiAxMTowNiwgVGlhbiwgS2V2aW4gd3JvdGU6
Cj4+Pj4gRnJvbTogQmFvbHUgTHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pj4+IFNlbnQ6
IFR1ZXNkYXksIEp1bmUgMjEsIDIwMjIgNTowNCBQTQo+Pj4+Cj4+Pj4gT24gMjAyMi82LzIxIDEz
OjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KPj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjEsIDIwMjIgMTI6Mjgg
UE0KPj4+Pj4+Cj4+Pj4+PiBPbiAyMDIyLzYvMjEgMTE6NDYsIFRpYW4sIEtldmluIHdyb3RlOgo+
Pj4+Pj4+PiBGcm9tOiBCYW9sdSBMdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4+Pj4+
IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjEsIDIwMjIgMTE6MzkgQU0KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
T24gMjAyMi82LzIxIDEwOjU0LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4+Pj4+PiBGcm9tOiBM
dSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4+Pj4+Pj4gU2VudDogTW9uZGF5
LCBKdW5lIDIwLCAyMDIyIDQ6MTcgUE0KPj4+Pj4+Pj4+PiBAQCAtMjU2NCw3ICsyNTY0LDcgQEAg
c3RhdGljIGludCBkb21haW5fYWRkX2Rldl9pbmZvKHN0cnVjdAo+Pj4+Pj4+Pj4+IGRtYXJfZG9t
YWluICpkb21haW4sIHN0cnVjdCBkZXZpY2UgKmRldikKPj4+Pj4+Pj4+PiAgICAgICAJCQlyZXQg
PSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUsCj4+Pj4+Pj4+Pj4gZG9tYWlu
LAo+Pj4+Pj4+Pj4+ICAgICAgIAkJCQkJZGV2LCBQQVNJRF9SSUQyUEFTSUQpOwo+Pj4+Pj4+Pj4+
ICAgICAgIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaW9tbXUtPmxvY2ssIGZsYWdzKTsKPj4+
Pj4+Pj4+PiAtCQlpZiAocmV0KSB7Cj4+Pj4+Pj4+Pj4gKwkJaWYgKHJldCAmJiByZXQgIT0gLUVC
VVNZKSB7Cj4+Pj4+Pj4+Pj4gICAgICAgCQkJZGV2X2VycihkZXYsICJTZXR1cCBSSUQyUEFTSUQg
ZmFpbGVkXG4iKTsKPj4+Pj4+Pj4+PiAgICAgICAJCQlkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8o
ZGV2KTsKPj4+Pj4+Pj4+PiAgICAgICAJCQlyZXR1cm4gcmV0Owo+Pj4+Pj4+Pj4+IC0tCj4+Pj4+
Pj4+Pj4gMi4yNS4xCj4+Pj4+Pj4+PiBJdCdzIGNsZWFuZXIgdG8gYXZvaWQgdGhpcyBlcnJvciBh
dCB0aGUgZmlyc3QgcGxhY2UsIGkuZS4gb25seSBkbyB0aGUKPj4+Pj4+Pj4+IHNldHVwIHdoZW4g
dGhlIGZpcnN0IGRldmljZSBpcyBhdHRhY2hlZCB0byB0aGUgcGFzaWQgdGFibGUuCj4+Pj4+Pj4+
IFRoZSBsb2dpYyB0aGF0IGlkZW50aWZpZXMgdGhlIGZpcnN0IGRldmljZSBtaWdodCBpbnRyb2R1
Y2UgYWRkaXRpb25hbAo+Pj4+Pj4+PiB1bm5lY2Vzc2FyeSBjb21wbGV4aXR5LiBEZXZpY2VzIHRo
YXQgc2hhcmUgYSBwYXNpZCB0YWJsZSBhcmUgcmFyZS4gSQo+Pj4+Pj4+PiBldmVuIHByZWZlciB0
byBnaXZlIHVwIHNoYXJpbmcgdGFibGVzIHNvIHRoYXQgdGhlIGNvZGUgY2FuIGJlCj4+Pj4+Pj4+
IHNpbXBsZXIuOi0pCj4+Pj4+Pj4+Cj4+Pj4+Pj4gSXQncyBub3QgdGhhdCBjb21wbGV4IGlmIHlv
dSBzaW1wbHkgbW92ZSBkZXZpY2VfYXR0YWNoX3Bhc2lkX3RhYmxlKCkKPj4+Pj4+PiBvdXQgb2Yg
aW50ZWxfcGFzaWRfYWxsb2NfdGFibGUoKS4gVGhlbiBkbyB0aGUgc2V0dXAgaWYKPj4+Pj4+PiBs
aXN0X2VtcHR5KCZwYXNpZF90YWJsZS0+ZGV2KSBhbmQgdGhlbiBhdHRhY2ggZGV2aWNlIHRvIHRo
ZQo+Pj4+Pj4+IHBhc2lkIHRhYmxlIGluIGRvbWFpbl9hZGRfZGV2X2luZm8oKS4KPj4+Pj4+IFRo
ZSBwYXNpZCB0YWJsZSBpcyBwYXJ0IG9mIHRoZSBkZXZpY2UsIGhlbmNlIGEgYmV0dGVyIHBsYWNl
IHRvCj4+Pj4+PiBhbGxvY2F0ZS9mcmVlIHRoZSBwYXNpZCB0YWJsZSBpcyBpbiB0aGUgZGV2aWNl
IHByb2JlL3JlbGVhc2UgcGF0aHMuCj4+Pj4+PiBUaGluZ3Mgd2lsbCBiZWNvbWUgbW9yZSBjb21w
bGljYXRlZCBpZiB3ZSBjaGFuZ2UgcmVsYXRpb25zaGlwCj4+IGJldHdlZW4KPj4+Pj4+IGRldmlj
ZSBhbmQgaXQncyBwYXNpZCB0YWJsZSB3aGVuIGF0dGFjaGluZy9kZXRhY2hpbmcgYSBkb21haW4u
IFRoYXQncwo+Pj4+Pj4gdGhlIHJlYXNvbiB3aHkgSSB0aG91Z2h0IGl0IHdhcyBhZGRpdGlvbmFs
IGNvbXBsZXhpdHkuCj4+Pj4+Pgo+Pj4+PiBJZiB5b3UgZG8gd2FudCB0byBmb2xsb3cgY3VycmVu
dCByb3V0ZSBpdOKAmXMgc3RpbGwgY2xlYW5lciB0byBjaGVjawo+Pj4+PiB3aGV0aGVyIHRoZSBw
YXNpZCBlbnRyeSBoYXMgcG9pbnRlZCB0byB0aGUgZG9tYWluIGluIHRoZSBpbmRpdmlkdWFsCj4+
Pj4+IHNldHVwIGZ1bmN0aW9uIGluc3RlYWQgb2YgYmxpbmRseSByZXR1cm5pbmcgLUVCVVNZIGFu
ZCB0aGVuIGlnbm9yaW5nCj4+Pj4+IGl0IGV2ZW4gaWYgYSByZWFsIGJ1c3kgY29uZGl0aW9uIG9j
Y3Vycy4gVGhlIHNldHVwIGZ1bmN0aW9ucyBjYW4KPj4+Pj4ganVzdCByZXR1cm4gemVybyBmb3Ig
dGhpcyBiZW5pZ24gYWxpYXMgY2FzZS4KPj4+PiBLZXZpbiwgaG93IGRvIHlvdSBsaWtlIHRoaXMg
b25lPwo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYwo+Pj4+IGluZGV4IGNiNGMxZDBjZjI1Yy4uZWNm
ZmQwMTI5YjJiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYwo+
Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYwo+Pj4+IEBAIC01NzUsNiArNTc1
LDE2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBhc2lkX2VuYWJsZV93cGUoc3RydWN0Cj4+Pj4gcGFz
aWRfZW50cnkgKnB0ZSkKPj4+PiAgICAgCXJldHVybiAwOwo+Pj4+ICAgICB9Owo+Pj4+Cj4+Pj4g
Ky8qCj4+Pj4gKyAqIFJldHVybiB0cnVlIGlmIEBwYXNpZCBpcyBSSUQyUEFTSUQgYW5kIHRoZSBk
b21haW4gQGRpZCBoYXMgYWxyZWFkeQo+Pj4+ICsgKiBiZWVuIHNldHVwIHRvIHRoZSBAcHRlLiBP
dGhlcndpc2UsIHJldHVybiBmYWxzZS4KPj4+PiArICovCj4+Pj4gK3N0YXRpYyBpbmxpbmUgYm9v
bAo+Pj4+ICtyaWQycGFzaWRfZG9tYWluX3ZhbGlkKHN0cnVjdCBwYXNpZF9lbnRyeSAqcHRlLCB1
MzIgcGFzaWQsIHUxNiBkaWQpCj4+Pj4gK3sKPj4+PiArCXJldHVybiBwYXNpZCA9PSBQQVNJRF9S
SUQyUEFTSUQgJiYgcGFzaWRfZ2V0X2RvbWFpbl9pZChwdGUpID09Cj4+Pj4gZGlkOwo+Pj4+ICt9
Cj4+PiBiZXR0ZXIgdGhpcyBpcyBub3QgcmVzdHJpY3RlZCB0byBSSUQyUEFTSUQgb25seSwgZS5n
Lgo+PiBwYXNpZF9wdGVfbWF0Y2hfZG9tYWluKCkKPj4+IGFuZCB0aGVuIHJlYWQgcGFzaWQgZnJv
bSB0aGUgcHRlIHRvIGNvbXBhcmUgd2l0aCB0aGUgcGFzaWQgYXJndW1lbnQuCj4+Pgo+Pgo+PiBU
aGUgcGFzaWQgdmFsdWUgaXMgbm90IGVuY29kZWQgaW4gdGhlIHBhc2lkIHRhYmxlIGVudHJ5LiBU
aGlzIHZhbGlkaXR5Cj4+IGNoZWNrIGlzIG9ubHkgZm9yIFJJRDJQQVNJRCBhcyBhbGlhcyBkZXZp
Y2VzIHNoYXJlIHRoZSBzaW5nbGUgUklEMlBBU0lECj4+IGVudHJ5LiBGb3Igb3RoZXIgY2FzZXMs
IHdlIHNob3VsZCBhbHdheXMgcmV0dXJuIC1FQlVTWSBhcyB3aGF0IHRoZSBjb2RlCj4+IGlzIGRv
aW5nIG5vdy4KPj4KPiAKPiBZb3UgYXJlIHJpZ2h0LgoKVmVyeSBhcHByZWNpYXRlZCBmb3IgeW91
ciBpbnB1dC4gSSB3aWxsIHVwZGF0ZSBpdCB3aXRoIGEgdjIuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
