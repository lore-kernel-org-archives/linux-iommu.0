Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0742C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 02:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93FEE84182;
	Wed, 25 May 2022 02:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lA9ESUIMRIY; Wed, 25 May 2022 02:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E7A684177;
	Wed, 25 May 2022 02:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D9E1C0032;
	Wed, 25 May 2022 02:13:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35835C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AC6B612AE
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Jigx2LcMSSa for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:13:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76334612AA
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653444809; x=1684980809;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=y00jKpGRgIg6OivHiwn8VODmVJdokGS+y/8+3XdeIVU=;
 b=JvbXReZv9lDhSX0blKotfdum3WC0gmI/5T0fYTMiqY8vNQVKVUOS1avB
 sTHI8y/EjmNLyCVNO/WNH9NS26V/YLeM1451BlH0/IZVlHKn71p7eGeVL
 jME+69vco3qqa6cEqIzd4gBtH2uPCvTG4ZcqlligG3/6l7kDvv5H4jzHP
 ku7zarCl+Qfqf88huW5J4xNKtCU+t67rAfKNnLJS4E+nhDlZBRSy21JiB
 k2OF50yEagV8Rht3lb1yiIdtLef8ZT7mtWX00mVsbDM/DX81h0AJX2L/m
 xxZGeHj3my6IJBiwgVXG2GFvXefLBpx4SPiWAqYZIIMvAhu+G7sLIditr A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271270227"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="271270227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:13:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601604562"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:13:23 -0700
Message-ID: <3751d422-924f-81e6-de8e-3e33de38a50f@linux.intel.com>
Date: Wed, 25 May 2022 10:13:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

T24gMjAyMi81LzI1IDEwOjAzLCBCYW9sdSBMdSB3cm90ZToKPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2ludGVsL2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jCj4+PiBp
bmRleCA0ZGU5NjA4MzRhMWIuLjFjM2NmMjY3OTM0ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvZG1hci5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYwo+
Pj4gQEAgLTExMjYsNiArMTEyNiwxMCBAQCBzdGF0aWMgaW50IGFsbG9jX2lvbW11KHN0cnVjdCBk
bWFyX2RyaGRfdW5pdAo+Pj4gKmRyaGQpCj4+Pgo+Pj4gwqDCoMKgwqDCoCByYXdfc3Bpbl9sb2Nr
X2luaXQoJmlvbW11LT5yZWdpc3Rlcl9sb2NrKTsKPj4+Cj4+PiArwqDCoMKgIC8qIFN1cHBvcnRz
IGZ1bGwgMjAtYml0IFBBU0lEIGluIHNjYWxhYmxlIG1vZGUuICovCj4+PiArwqDCoMKgIGlmIChl
Y2FwX3Bhc2lkKGlvbW11LT5lY2FwKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdS0+aW9tbXUu
cGFzaWRzID0gMVVMIDw8IDIwOwo+Pj4gKwo+Pgo+PiBzdXBwb3J0ZWQgcGFzaWQgYml0cyBpcyBy
ZXBvcnRlZCBieSBlY2FwX3BzcygpLiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZAo+PiBhc3N1bWUg
MjBiaXRzIGhlcmUuCj4gCj4gWWVzLiBJIG92ZXJsb29rZWQgdGhpcy4gVGhhbmtzIGZvciByZW1p
bmRpbmcuCj4gCj4gQW5vdGhlciB0aGluZyBJIG5lZWQgdG8gaW1wcm92ZSBpcyB0aGF0IHNjYWxh
YmxlIG1vZGUgY291bGQgYmUgZGlzYWJsZWQuCj4gVGhpcyBmaWVsZCBzaG91bGQgYmUgMCBpbiB0
aGF0IGNhc2UuCgpJIHdpbGwgY2hhbmdlIGFib3ZlIHRvOgoKKyAgICAgICAgLyoKKyAgICAgICAg
ICogQSB2YWx1ZSBvZiBOIGluIFBTUyBmaWVsZCBvZiBlQ2FwIHJlZ2lzdGVyIGluZGljYXRlcyBo
YXJkd2FyZQorICAgICAgICAgKiBzdXBwb3J0cyBQQVNJRCBmaWVsZCBvZiBOKzEgYml0cy4KKyAg
ICAgICAgICovCisgICAgICAgIGlmIChwYXNpZF9zdXBwb3J0ZWQoaW9tbXUpKQorICAgICAgICAg
ICAgICAgIGlvbW11LT5pb21tdS5tYXhfcGFzaWRzID0gMlVMIDw8IGVjYXBfcHNzKGlvbW11LT5l
Y2FwKTsKCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
