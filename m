Return-Path: <SRS0=ltgl=33=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE09C2D0B1
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 07:19:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E4820838
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 07:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E4820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B999D86AE3;
	Fri,  7 Feb 2020 07:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NZIFxr6uxKO; Fri,  7 Feb 2020 07:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8ED7C81EFA;
	Fri,  7 Feb 2020 07:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C8CC1796;
	Fri,  7 Feb 2020 07:19:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4238C013E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 07:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AA85881EFA
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 07:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOBE4b-5GfXd for <iommu@lists.linux-foundation.org>;
 Fri,  7 Feb 2020 07:19:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5B16483FA2
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 07:19:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 23:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,412,1574150400"; d="scan'208";a="250325327"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.62])
 ([10.254.212.62])
 by orsmga002.jf.intel.com with ESMTP; 06 Feb 2020 23:19:44 -0800
Subject: Re: Seeing some another issue with mixed domains in the same
 iommu_group
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org
References: <20200206175432.4r5vaurm6codfa4a@cantor>
 <20200206184707.h3lfh2qaxaooe2vi@cantor>
 <20200206213643.b75uilwh3m76rprx@cantor>
 <20200206231657.aflur5zq2jvexrdn@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <41fcb72a-ef3e-9be3-7a63-8800b6eb0a0f@linux.intel.com>
Date: Fri, 7 Feb 2020 15:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206231657.aflur5zq2jvexrdn@cantor>
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

SGkgSmVycnksCgpPbiAyMDIwLzIvNyA3OjE2LCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IAo+
IEhpIEJhb2x1LAo+IAo+IFdvdWxkIHNvbWV0aGluZyBhbG9uZyB0aGVzZSBsaW5lcyBtYWtlcyBz
ZW5zZT8KPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4gaW5kZXggOWRjMzc2NzJiZjg5Li40MGNjOGY1YTNl
YmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4gQEAgLTM2MTQsNiArMzYxNCwyMCBAQCBzdGF0aWMg
Ym9vbCBpb21tdV9uZWVkX21hcHBpbmcoc3RydWN0IGRldmljZSAqZGV2KQo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hcl9yZW1vdmVf
b25lX2Rldl9pbmZvKGRldik7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfcHJpdmF0
ZV9kb21haW5fZm9yX2RldihkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZXYtPmFyY2hkYXRhLmlvbW11ID09IE5VTEwpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFp
bjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9ncm91cCAq
Z3JvdXA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hcl9kb21h
aW4gKmRtYXJfZG9tYWluLCAqdG1wOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9kZXYoZGV2KTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbiA9IGlvbW11X2dyb3VwX2RlZmF1bHRfZG9tYWluKGdy
b3VwKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYXJfZG9tYWluID0gdG9f
ZG1hcl9kb21haW4oZG9tYWluKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRt
cCA9IHNldF9kb21haW5fZm9yX2RldihkZXYsIGRtYXJfZG9tYWluKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4gIMKgwqDCoMKgwqDCoMKgwqAgfQo+IAo+ICDCoMKgwqDCoMKgwqDCoMKg
IGRldl9pbmZvKGRldiwgIjMyYml0IERNQSB1c2VzIG5vbi1pZGVudGl0eSBtYXBwaW5nXG4iKTsK
ClRoYW5rcyBmb3IgcmVwb3J0aW5nLgoKQWN0dWFsbHksIEkgcHJlZmVyIHRvIHJlbW92aW5nIHRo
aXMgZG9tYWluIHN3aXRjaCBhcyBsb25nIGFzIHVzZXJzIGFyZQphYmxlIHRvIG1ha2UgYSAzMi1i
aXQgZGV2aWNlIHVzZSBETUEgZG9tYWluIHdoaWxlIHN5c3RlbSBkZWZhdWx0IGlzCmlkZW50aXR5
IG9yIGl0IGJyZWFrcyBhbnl0aGluZy4gMzItYml0IGRldmljZXMgKG9yIG5vcm1hbGx5IGRldmlj
ZXMKd2l0aCBsaW1pdGVkIGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBvdmVyIHRoZSB3aG9sZSBzeXN0
ZW0gbWVtb3J5KSB1c2luZwpETUEgZG9tYWluIGhlbHBzIGJ5IHJlbW92aW5nIHRoZSBzd2lvdGxi
IHBlcmZvcm1hbmNlIG92ZXJoZWFkLCB3aGljaCBpcwp0aGUgb3JpZ2luYWwgbW90aXZhdGlvbiBv
ZiB0aGlzIGNvZGUuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
