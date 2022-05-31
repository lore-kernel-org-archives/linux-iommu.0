Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FF8C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 12:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93A3640348;
	Tue, 31 May 2022 12:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tB0SIgBzZA-2; Tue, 31 May 2022 12:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40840402A0;
	Tue, 31 May 2022 12:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17F5AC0039;
	Tue, 31 May 2022 12:16:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB20C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D4D7405F6
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0zDbrzt6GSk for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:15:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B42C40181
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653999359; x=1685535359;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hNAiQ7gwO4WzGADus3ttqXuH+fpzFCczEESmD6y6uic=;
 b=ERV5t2msuyG6jDDmy1t0MkONKb2OiC96N3gZ3fGgK1MQVQhqT+oqvM4T
 RNJhxcL6E5xmkkHwELDTa9+4xWe3zDb/06AxSDjb1WDON69DfUK1V5fQa
 7nRDyoq/SK1Ug8HN7szj+u2gl+hQq+AjikDaQELDSIxWzgbltr7bYuqE6
 Q4+scTAT1cYAyKFnDILWTiR8+XrH8Mwj2UOO4MjOo9Gbix4tVo1eeb8fG
 n03b/2iLQW3KuPAi6S98JPxt+SLx1VmYzSZ6G+pmphhEAZEzDxhxqX719
 H4DL8jHELPepv8NQ6JBjZNDn4hmziC+gsF/VowD1dlX3shZB4zh/zMWgx g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="300584358"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="300584358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 05:15:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="706548125"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.74])
 ([10.249.170.74])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 05:15:54 -0700
Message-ID: <2532cb21-5fc9-57b9-82f6-69a7577ffe4a@linux.intel.com>
Date: Tue, 31 May 2022 20:15:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 09/19] iommu/amd: Access/Dirty bit support in IOPTEs
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-10-joao.m.martins@oracle.com>
 <efd6a8ac-413c-f39e-e566-bb317ed77ac4@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <efd6a8ac-413c-f39e-e566-bb317ed77ac4@amd.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>
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

SGkgU3VyYXZlZSAsCgpPbiAyMDIyLzUvMzEgMTk6MzQsIFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCB3
cm90ZToKPiBPbiA0LzI5LzIyIDQ6MDkgQU0sIEpvYW8gTWFydGlucyB3cm90ZToKPj4gLi4uLi4K
Pj4gK3N0YXRpYyBpbnQgYW1kX2lvbW11X3NldF9kaXJ0eV90cmFja2luZyhzdHJ1Y3QgaW9tbXVf
ZG9tYWluICpkb21haW4sCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBib29sIGVuYWJsZSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgcHJvdGVjdGlvbl9kb21haW4g
KnBkb21haW4gPSB0b19wZG9tYWluKGRvbWFpbik7Cj4+ICvCoMKgwqAgc3RydWN0IGlvbW11X2Rl
dl9kYXRhICpkZXZfZGF0YTsKPj4gK8KgwqDCoCBib29sIGRvbV9mbHVzaCA9IGZhbHNlOwo+PiAr
Cj4+ICvCoMKgwqAgaWYgKCFhbWRfaW9tbXVfaGFkX3N1cHBvcnQpCj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+ICsKPj4gK8KgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5
KGRldl9kYXRhLCAmcGRvbWFpbi0+ZGV2X2xpc3QsIGxpc3QpIHsKPiAKPiBTaW5jZSB3ZSBpdGVy
YXRlIHRocm91Z2ggZGV2aWNlIGxpc3QgZm9yIHRoZSBkb21haW4sIHdlIHdvdWxkIG5lZWQgdG8K
PiBjYWxsIHNwaW5fbG9ja19pcnFzYXZlKCZwZG9tYWluLT5sb2NrLCBmbGFncykgaGVyZS4KCk5v
dCByZWxhdGVkLCBqdXN0IG91dCBvZiBjdXJpb3NpdHkuIERvZXMgaXQgcmVhbGx5IG5lZWQgdG8g
ZGlzYWJsZSB0aGUKaW50ZXJydXB0IHdoaWxlIGhvbGRpbmcgdGhpcyBsb2NrPyBBbnkgY2FzZSB0
aGlzIGxpc3Qgd291bGQgYmUgdHJhdmVyc2VkCmluIGFueSBpbnRlcnJ1cHQgY29udGV4dD8gUGVy
aGFwcyBJIG1pc3NlZCBhbnl0aGluZz8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
