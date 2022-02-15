Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE95C433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 02:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B89D60D51;
	Tue, 15 Feb 2022 02:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hKKeuapRRxi; Tue, 15 Feb 2022 02:02:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D4E860A98;
	Tue, 15 Feb 2022 02:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA3BEC001A;
	Tue, 15 Feb 2022 02:02:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2639DC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0BB960AD0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sbu4upsSL-ld for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 02:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 402F960A98
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644890568; x=1676426568;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PQx1bi+RZ7llbsZzitox0+KHCY/gJAuQuxLD+34SPaA=;
 b=A+5gpWf6AFIaQxEQUvOn2xWVR08N/tl9CqOv7MasjjOuIADKe1KarweR
 cpHWBeY5RNIy+5reQem8yqgOB//2Q4U2GLxjr0ASBtB0s6N97Ux3pxsoT
 r2FotITXY3j7D/EloAdeyPlDOfvd/ho77B2z28YYXwnmaW+A/Kct3IPfU
 yO4cjbnBrXUvFhGt9nDREGSiSWTjkfveG/t9JYS1GRcDSoqvTBYybvKU0
 ZiI+dxqzQZ4+X5WA3sUeu0QaEqOI4zXb+mV6VU7Q+qpjyj1yZ8NXZ4cMY
 6BLN0G9JokRusqZJBmBjQH18sZCEBN/1vmiF4Ff9zhUtD9/PYZNo979bf w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250435771"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="250435771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 18:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680793619"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:02:43 -0800
Message-ID: <0bf678af-1905-de87-322b-43703992030b@linux.intel.com>
Date: Tue, 15 Feb 2022 10:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-8-baolu.lu@linux.intel.com>
 <YgpP7AhY5hd/DX/C@8bytes.org>
 <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

T24gMi8xNS8yMiA5OjQ2IEFNLCBMdSBCYW9sdSB3cm90ZToKPiBPbiAyLzE0LzIyIDg6NDkgUE0s
IEpvZXJnIFJvZWRlbCB3cm90ZToKPj4gT24gTW9uLCBGZWIgMTQsIDIwMjIgYXQgMDk6NTU6MzVB
TSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+PiArc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3Qg
aW9tbXVfb3BzICpkZXZfaW9tbXVfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+ICt7Cj4+PiAr
wqDCoMKgIC8qCj4+PiArwqDCoMKgwqAgKiBBc3N1bWUgdGhhdCB2YWxpZCBvcHMgbXVzdCBiZSBp
bnN0YWxsZWQgaWYgaW9tbXVfcHJvYmVfZGV2aWNlKCkKPj4+ICvCoMKgwqDCoCAqIGhhcyBzdWNj
ZWVkZWQuIFRoZSBkZXZpY2Ugb3BzIGFyZSBlc3NlbnRpYWxseSBmb3IgaW50ZXJuYWwgdXNlCj4+
PiArwqDCoMKgwqAgKiB3aXRoaW4gdGhlIElPTU1VIHN1YnN5c3RlbSBpdHNlbGYsIHNvIHdlIHNo
b3VsZCBiZSBhYmxlIHRvIHRydXN0Cj4+PiArwqDCoMKgwqAgKiBvdXJzZWx2ZXMgbm90IHRvIG1p
c3VzZSB0aGUgaGVscGVyLgo+Pj4gK8KgwqDCoMKgICovCj4+PiArwqDCoMKgIFdBUk5fT04oIWRl
diB8fCAhZGV2LT5pb21tdSB8fCAhZGV2LT5pb21tdS0+aW9tbXVfZGV2IHx8Cj4+PiArwqDCoMKg
wqDCoMKgwqAgIWRldi0+aW9tbXUtPmlvbW11X2Rldi0+b3BzKTsKPj4KPj4gVGhlcmUgaXMgbm8g
bmVlZCBmb3IgdGhpcyBXQVJOX09OLCB0aGUgY29kZSB3aWxsIG9vcHMgYW55d2F5IHdoZW4gb25l
IG9mCj4+IHRoZSBwb2ludGVycyBjaGVja2VkIGhlcmUgaXMgTlVMTC4KPj4KPiAKPiBXZSByZWFs
bHkgZG9uJ3QgbmVlZCB0byBXQVJOX09OIGludGVybWVkaWF0ZSBudWxsIHBvaW50ZXJzLiBCdXQg
SSB3b3VsZAo+IGFyZ3VlIHRoYXQgd2UgY291bGQgYWRkIGEgV0FSTigpIG9uIG51bGwgZGV2LT5p
b21tdS0+aW9tbXVfZGV2LT5vcHMsIHNvCj4gdGhhdCBjYWxsZXJzIGhhdmUgbm8gbmVlZCB0byBj
aGVjayB0aGUgcmV0dXJuZWQgb3BzLgoKT2gsIHNvcnJ5ISBXZSBkb24ndCBuZWVkIHRvIGNoZWNr
IG51bGwgb3BzIGVpdGhlci4gVGhhdCB3aWxsIGFsc28gcmVzdWx0CmluIGEgbnVsbCBwb2ludGVy
IHJlZmVyZW5jZSBvb3BzIGluIHRoZSBjYWxsZXIuCgpTbywgeWVzLiBObyBuZWVkIGZvciB0aGlz
IFdBUk5fT04oKS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
