Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3425C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 07:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5490F81D88;
	Mon, 16 May 2022 07:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dl3WKJZgrbam; Mon, 16 May 2022 07:28:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38E5081D3A;
	Mon, 16 May 2022 07:28:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22748C0039;
	Mon, 16 May 2022 07:28:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 908CEC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70AC360A89
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h_oh4hoV2kBZ for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 07:28:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6B2860A70
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652686111; x=1684222111;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=q3m2ohYSgy6ZmyxlbpF3+joY8hSjHHJlesu9z1mgl+c=;
 b=na65zqYBtN+8RExGbe792Ud4zow66N3OvDaTHrJx//CzEILBFI7MzuLN
 fxkrC5kGaga3Z8qjqsoHN6xDAW8LMnQlMbiQ6gBOFs8vTVZoZXYWTjhAR
 uhdFnz7tlJSA8PpncfkPZUjxhFka7GbapGcqtG5Dr+kRIUNbEEWym//ul
 tc2U42e+oFBh9VDLe7X99AZUJAAjE+yLyw6CPtyqe/xIDofxhs0aJvqOx
 GxmGPXq395Jubnk/W/MqAFqxg1zWjcYj6k1q+RGf41Nk3oz7NM0qzfcHJ
 RVr93h1hNk3Vpvl45lY7rVRDOu1uZVy3W8ALjwjHlF2ySIT5oduEp+L0+ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="268334059"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="268334059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 00:28:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="568201191"
Received: from jrozansk-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.130.253])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 00:28:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kevin Tian <kevin.tian@intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Ning Sun <ning.sun@intel.com>
Subject: Re: [PATCH 4/7] drm/i915: Remove unnecessary include
In-Reply-To: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Date: Mon, 16 May 2022 10:28:19 +0300
Message-ID: <877d6mhr70.fsf@intel.com>
MIME-Version: 1.0
Cc: Steve Wahl <steve.wahl@hpe.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU2F0LCAxNCBNYXkgMjAyMiwgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4g
d3JvdGU6Cj4gaW50ZWwtaW9tbXUuaCBpcyBub3QgbmVlZGVkIGluIGRybS9pOTE1IGFueW1vcmUu
IFJlbW92ZSBpdHMgaW5jbHVkZS4KClRoYW5rcyBmb3IgdGhlIGNsZWFudXBzLiBEbyB5b3Ugd2Fu
dCB0byBrZWVwIHRoZSBwYXRjaGVzIHRvZ2V0aGVyIG9yCndhbnQgdXMgdG8gcGljayB0aGlzIHVw
IHZpYSBkcm0taW50ZWw/CgpJZiB5b3Ugd2FudCB0byBrZWVwIHRoZSBwYXRjaGVzIHRvZ2V0aGVy
LAoKQWNrZWQtYnk6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+Cgpmb3IgbWVy
Z2luZyB2aWEgd2hpY2hldmVyIHRyZWUgc3VpdHMgeW91IGJlc3QuIEp1c3QgbGV0IHVzIGtub3cu
CgpCUiwKSmFuaS4KCgo+Cj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcnYuaCAgICAg
ICAgICAgICAgICB8IDEgLQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rp
c3BsYXkuYyAgIHwgMSAtCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9leGVj
YnVmZmVyLmMgfCAxIC0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2LmggYi9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9pOTE1X2Rydi5oCj4gaW5kZXggZmExNGRhODQzNjJlLi5mMmE2OTgyYzNiZWYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcnYuaAo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2LmgKPiBAQCAtMzYsNyArMzYsNiBAQAo+ICAKPiAgI2lu
Y2x1ZGUgPGxpbnV4L2kyYy5oPgo+ICAjaW5jbHVkZSA8bGludXgvaTJjLWFsZ28tYml0Lmg+Cj4g
LSNpbmNsdWRlIDxsaW51eC9pbnRlbC1pb21tdS5oPgo+ICAjaW5jbHVkZSA8bGludXgvcG1fcW9z
Lmg+Cj4gIAo+ICAjaW5jbHVkZSA8ZHJtL2RybV9jb25uZWN0b3IuaD4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXkuYwo+IGluZGV4IDdkZmViNDU4YWE2NS4u
Njg2ZGRiZWViYWRjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfZGlzcGxheS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9kaXNwbGF5LmMKPiBAQCAtMjcsNyArMjcsNiBAQAo+ICAjaW5jbHVkZSA8YWNwaS92aWRlby5o
Pgo+ICAjaW5jbHVkZSA8bGludXgvaTJjLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgo+
IC0jaW5jbHVkZSA8bGludXgvaW50ZWwtaW9tbXUuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5l
bC5oPgo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9kbWEt
cmVzdi5oPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1f
ZXhlY2J1ZmZlci5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2V4ZWNidWZm
ZXIuYwo+IGluZGV4IGQ0MmY0MzcxNDljOS4uYzk4MjM1MjhlYTk0IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9leGVjYnVmZmVyLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZXhlY2J1ZmZlci5jCj4gQEAgLTQsNyArNCw2
IEBACj4gICAqIENvcHlyaWdodCDCqSAyMDA4LDIwMTAgSW50ZWwgQ29ycG9yYXRpb24KPiAgICov
Cj4gIAo+IC0jaW5jbHVkZSA8bGludXgvaW50ZWwtaW9tbXUuaD4KPiAgI2luY2x1ZGUgPGxpbnV4
L2RtYS1yZXN2Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9zeW5jX2ZpbGUuaD4KPiAgI2luY2x1ZGUg
PGxpbnV4L3VhY2Nlc3MuaD4KCi0tIApKYW5pIE5pa3VsYSwgSW50ZWwgT3BlbiBTb3VyY2UgR3Jh
cGhpY3MgQ2VudGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
