Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84712C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 03:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05E4661225;
	Wed, 22 Jun 2022 03:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05E4661225
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7CxFtaZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6CfxJXxj2qVP; Wed, 22 Jun 2022 03:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF69360BFB;
	Wed, 22 Jun 2022 03:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF69360BFB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B49DC0039;
	Wed, 22 Jun 2022 03:27:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E034C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2768783F31
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:27:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2768783F31
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S7CxFtaZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UPkgGGw83j2t for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 03:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6267283F0A
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6267283F0A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655868458; x=1687404458;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=j07rY6WMS0CfEZ9gsbNiNKbfiAjIhPmGB19qMdJh6jw=;
 b=S7CxFtaZA9OwZMWakQgotyC7YPm6lq4LLiWJHpyN0zV9OKHrWb+Oqy9F
 hvbtOyESuSugyB09tF90X4yb/jJTpcqCHHpc9RyyUHoUofvQJ3IVWYHB3
 zxU5SyrmF9TwtLpHjb0vwgZt/1LZ4gRJOEuodRXE/9ozuOa9uph3U0QcU
 dBfH8cupaIMY4YKxoqb2DuOdu/Zy1Hpp7v2k/ez+WGqACTC35qlo1Bakz
 Nlm6B2cD3h8z87VYttcd7GIvsVcbuDnxFoLk2c9ijz5VMocA4vnINgenm
 RfUe9So1zUWFL74IT0gtUanqJahVvtOl57AxBdDtZGc96qub5aIFDUKFw A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269019929"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="269019929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 20:27:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833882261"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 20:27:35 -0700
Message-ID: <4316fa3e-3183-beb0-9c4a-d6045c6b5340@linux.intel.com>
Date: Wed, 22 Jun 2022 11:27:33 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763B34313DD178B44BA2578CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

T24gMjAyMi82LzIyIDExOjA2LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogQmFvbHUgTHU8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+PiBTZW50OiBUdWVzZGF5LCBKdW5lIDIxLCAyMDIy
IDU6MDQgUE0KPj4KPj4gT24gMjAyMi82LzIxIDEzOjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+
PiBGcm9tOiBCYW9sdSBMdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4gU2VudDogVHVl
c2RheSwgSnVuZSAyMSwgMjAyMiAxMjoyOCBQTQo+Pj4+Cj4+Pj4gT24gMjAyMi82LzIxIDExOjQ2
LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KPj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjEsIDIwMjIgMTE6MzkgQU0K
Pj4+Pj4+Cj4+Pj4+PiBPbiAyMDIyLzYvMjEgMTA6NTQsIFRpYW4sIEtldmluIHdyb3RlOgo+Pj4+
Pj4+PiBGcm9tOiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4+Pj4+IFNl
bnQ6IE1vbmRheSwgSnVuZSAyMCwgMjAyMiA0OjE3IFBNCj4+Pj4+Pj4+IEBAIC0yNTY0LDcgKzI1
NjQsNyBAQCBzdGF0aWMgaW50IGRvbWFpbl9hZGRfZGV2X2luZm8oc3RydWN0Cj4+Pj4+Pj4+IGRt
YXJfZG9tYWluICpkb21haW4sIHN0cnVjdCBkZXZpY2UgKmRldikKPj4+Pj4+Pj4gICAgICAJCQly
ZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUsCj4+Pj4+Pj4+IGRvbWFp
biwKPj4+Pj4+Pj4gICAgICAJCQkJCWRldiwgUEFTSURfUklEMlBBU0lEKTsKPj4+Pj4+Pj4gICAg
ICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlvbW11LT5sb2NrLCBmbGFncyk7Cj4+Pj4+Pj4+
IC0JCWlmIChyZXQpIHsKPj4+Pj4+Pj4gKwkJaWYgKHJldCAmJiByZXQgIT0gLUVCVVNZKSB7Cj4+
Pj4+Pj4+ICAgICAgCQkJZGV2X2VycihkZXYsICJTZXR1cCBSSUQyUEFTSUQgZmFpbGVkXG4iKTsK
Pj4+Pj4+Pj4gICAgICAJCQlkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8oZGV2KTsKPj4+Pj4+Pj4g
ICAgICAJCQlyZXR1cm4gcmV0Owo+Pj4+Pj4+PiAtLQo+Pj4+Pj4+PiAyLjI1LjEKPj4+Pj4+PiBJ
dCdzIGNsZWFuZXIgdG8gYXZvaWQgdGhpcyBlcnJvciBhdCB0aGUgZmlyc3QgcGxhY2UsIGkuZS4g
b25seSBkbyB0aGUKPj4+Pj4+PiBzZXR1cCB3aGVuIHRoZSBmaXJzdCBkZXZpY2UgaXMgYXR0YWNo
ZWQgdG8gdGhlIHBhc2lkIHRhYmxlLgo+Pj4+Pj4gVGhlIGxvZ2ljIHRoYXQgaWRlbnRpZmllcyB0
aGUgZmlyc3QgZGV2aWNlIG1pZ2h0IGludHJvZHVjZSBhZGRpdGlvbmFsCj4+Pj4+PiB1bm5lY2Vz
c2FyeSBjb21wbGV4aXR5LiBEZXZpY2VzIHRoYXQgc2hhcmUgYSBwYXNpZCB0YWJsZSBhcmUgcmFy
ZS4gSQo+Pj4+Pj4gZXZlbiBwcmVmZXIgdG8gZ2l2ZSB1cCBzaGFyaW5nIHRhYmxlcyBzbyB0aGF0
IHRoZSBjb2RlIGNhbiBiZQo+Pj4+Pj4gc2ltcGxlci46LSkKPj4+Pj4+Cj4+Pj4+IEl0J3Mgbm90
IHRoYXQgY29tcGxleCBpZiB5b3Ugc2ltcGx5IG1vdmUgZGV2aWNlX2F0dGFjaF9wYXNpZF90YWJs
ZSgpCj4+Pj4+IG91dCBvZiBpbnRlbF9wYXNpZF9hbGxvY190YWJsZSgpLiBUaGVuIGRvIHRoZSBz
ZXR1cCBpZgo+Pj4+PiBsaXN0X2VtcHR5KCZwYXNpZF90YWJsZS0+ZGV2KSBhbmQgdGhlbiBhdHRh
Y2ggZGV2aWNlIHRvIHRoZQo+Pj4+PiBwYXNpZCB0YWJsZSBpbiBkb21haW5fYWRkX2Rldl9pbmZv
KCkuCj4+Pj4gVGhlIHBhc2lkIHRhYmxlIGlzIHBhcnQgb2YgdGhlIGRldmljZSwgaGVuY2UgYSBi
ZXR0ZXIgcGxhY2UgdG8KPj4+PiBhbGxvY2F0ZS9mcmVlIHRoZSBwYXNpZCB0YWJsZSBpcyBpbiB0
aGUgZGV2aWNlIHByb2JlL3JlbGVhc2UgcGF0aHMuCj4+Pj4gVGhpbmdzIHdpbGwgYmVjb21lIG1v
cmUgY29tcGxpY2F0ZWQgaWYgd2UgY2hhbmdlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuCj4+Pj4gZGV2
aWNlIGFuZCBpdCdzIHBhc2lkIHRhYmxlIHdoZW4gYXR0YWNoaW5nL2RldGFjaGluZyBhIGRvbWFp
bi4gVGhhdCdzCj4+Pj4gdGhlIHJlYXNvbiB3aHkgSSB0aG91Z2h0IGl0IHdhcyBhZGRpdGlvbmFs
IGNvbXBsZXhpdHkuCj4+Pj4KPj4+IElmIHlvdSBkbyB3YW50IHRvIGZvbGxvdyBjdXJyZW50IHJv
dXRlIGl04oCZcyBzdGlsbCBjbGVhbmVyIHRvIGNoZWNrCj4+PiB3aGV0aGVyIHRoZSBwYXNpZCBl
bnRyeSBoYXMgcG9pbnRlZCB0byB0aGUgZG9tYWluIGluIHRoZSBpbmRpdmlkdWFsCj4+PiBzZXR1
cCBmdW5jdGlvbiBpbnN0ZWFkIG9mIGJsaW5kbHkgcmV0dXJuaW5nIC1FQlVTWSBhbmQgdGhlbiBp
Z25vcmluZwo+Pj4gaXQgZXZlbiBpZiBhIHJlYWwgYnVzeSBjb25kaXRpb24gb2NjdXJzLiBUaGUg
c2V0dXAgZnVuY3Rpb25zIGNhbgo+Pj4ganVzdCByZXR1cm4gemVybyBmb3IgdGhpcyBiZW5pZ24g
YWxpYXMgY2FzZS4KPj4gS2V2aW4sIGhvdyBkbyB5b3UgbGlrZSB0aGlzIG9uZT8KPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyBiL2RyaXZlcnMvaW9tbXUvaW50
ZWwvcGFzaWQuYwo+PiBpbmRleCBjYjRjMWQwY2YyNWMuLmVjZmZkMDEyOWIyYiAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvcGFzaWQuYwo+PiBAQCAtNTc1LDYgKzU3NSwxNiBAQCBzdGF0aWMgaW5saW5lIGludCBw
YXNpZF9lbmFibGVfd3BlKHN0cnVjdAo+PiBwYXNpZF9lbnRyeSAqcHRlKQo+PiAgICAJcmV0dXJu
IDA7Cj4+ICAgIH07Cj4+Cj4+ICsvKgo+PiArICogUmV0dXJuIHRydWUgaWYgQHBhc2lkIGlzIFJJ
RDJQQVNJRCBhbmQgdGhlIGRvbWFpbiBAZGlkIGhhcyBhbHJlYWR5Cj4+ICsgKiBiZWVuIHNldHVw
IHRvIHRoZSBAcHRlLiBPdGhlcndpc2UsIHJldHVybiBmYWxzZS4KPj4gKyAqLwo+PiArc3RhdGlj
IGlubGluZSBib29sCj4+ICtyaWQycGFzaWRfZG9tYWluX3ZhbGlkKHN0cnVjdCBwYXNpZF9lbnRy
eSAqcHRlLCB1MzIgcGFzaWQsIHUxNiBkaWQpCj4+ICt7Cj4+ICsJcmV0dXJuIHBhc2lkID09IFBB
U0lEX1JJRDJQQVNJRCAmJiBwYXNpZF9nZXRfZG9tYWluX2lkKHB0ZSkgPT0KPj4gZGlkOwo+PiAr
fQo+IGJldHRlciB0aGlzIGlzIG5vdCByZXN0cmljdGVkIHRvIFJJRDJQQVNJRCBvbmx5LCBlLmcu
IHBhc2lkX3B0ZV9tYXRjaF9kb21haW4oKQo+IGFuZCB0aGVuIHJlYWQgcGFzaWQgZnJvbSB0aGUg
cHRlIHRvIGNvbXBhcmUgd2l0aCB0aGUgcGFzaWQgYXJndW1lbnQuCj4gCgpUaGUgcGFzaWQgdmFs
dWUgaXMgbm90IGVuY29kZWQgaW4gdGhlIHBhc2lkIHRhYmxlIGVudHJ5LiBUaGlzIHZhbGlkaXR5
CmNoZWNrIGlzIG9ubHkgZm9yIFJJRDJQQVNJRCBhcyBhbGlhcyBkZXZpY2VzIHNoYXJlIHRoZSBz
aW5nbGUgUklEMlBBU0lECmVudHJ5LiBGb3Igb3RoZXIgY2FzZXMsIHdlIHNob3VsZCBhbHdheXMg
cmV0dXJuIC1FQlVTWSBhcyB3aGF0IHRoZSBjb2RlCmlzIGRvaW5nIG5vdy4KCkJlc3QgcmVnYXJk
cywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
